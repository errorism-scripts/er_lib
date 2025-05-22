import Notifications from './features/notifications/NotificationWrapper';
import CircleProgressbar from './features/progress/CircleProgressbar';
import Progressbar from './features/progress/Progressbar';
import TextUI from './features/textui/TextUI';
import InputDialog from './features/dialog/InputDialog';
import ContextMenu from './features/menu/context/ContextMenu';
import { useNuiEvent } from './hooks/useNuiEvent';
import { setClipboard } from './utils/setClipboard';
import { fetchNui } from './utils/fetchNui';
import AlertDialog from './features/dialog/AlertDialog';
import ListMenu from './features/menu/list';
import Dev from './features/dev';
import { isEnvBrowser } from './utils/misc';
import SkillCheck from './features/skillcheck';
import RadialMenu from './features/menu/radial';
import { theme } from './theme';
import { MantineProvider } from '@mantine/core';
import { useConfig } from './providers/ConfigProvider';

const App: React.FC = () => {
	const { config } = useConfig();

	useNuiEvent('setClipboard', (data: string) => {
		setClipboard(data);
	});

	function toLibTimeDate(dt = new Date()) {
		const year = dt.getFullYear();
		const month = dt.getMonth() + 1;      // getMonth() is 0–11
		const day = dt.getDate();           // 1–31
		const hour = dt.getHours();          // 0–23
		const min = dt.getMinutes();        // 0–59
		const sec = dt.getSeconds();        // 0–59

		// JS getDay(): 0 = Sunday, …, 6 = Saturday
		const wday = dt.getDay() + 1;         // 1 = Sunday, …, 7 = Saturday

		// Day-of-year: diff from Jan 1st, in ms, / ms per day + 1
		const start = new Date(year, 0, 1);
		const diff = dt.getTime() - start.getTime();      // ← use getTime()
		const yday = Math.floor(diff / 86_400_000) + 1;

		return { wday, yday, year, month, day, hour, min, sec };
	}

	fetchNui('time_on_connect', toLibTimeDate());
	fetchNui('init');

	return (
		<MantineProvider withNormalizeCSS withGlobalStyles theme={{ ...theme, ...config }}>
			<Progressbar />
			<CircleProgressbar />
			<Notifications />
			<TextUI />
			<InputDialog />
			<AlertDialog />
			<ContextMenu />
			<ListMenu />
			<RadialMenu />
			<SkillCheck />
			{isEnvBrowser() && <Dev />}
		</MantineProvider>
	);
};

export default App;
