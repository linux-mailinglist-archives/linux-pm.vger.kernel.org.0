Return-Path: <linux-pm+bounces-37560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55219C3D48E
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 130394E4E6D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE59350A2B;
	Thu,  6 Nov 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D4NcDL4h"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6330C343;
	Thu,  6 Nov 2025 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458813; cv=fail; b=aXkVploxn1PbyRfA6scKZWWqDSyh7jHq0lCu6BJGp+uvcR7fn6OeNMt0g52Bb++Qj6UoUpBH00D+Rvm7G+C06Coqsz0T3TYxcydQ6GhAQfePdfWC4oCruhR1ZT3sYsXxrqTk/O1FOonmSJECrjsrG4RvAjgjsGU3mYEKwDxE7GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458813; c=relaxed/simple;
	bh=bnrz9iGvVJqW5ASgeh8IFWLBGaUMHxYGa4k/WLiTKs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pi52rbDiBuakzL4JI8S+2jULNFwnTGGDex5x3x1nUxF8YiSbTNdbiEbMw2+ewPHr7X15DcKzxbaTDRXARRwNyNP2Vv+bkxX/zYC8bYBxpRMuREbsZhoL5poDDfaql38MbATOG+NK1vrr5z104hseydGKhBNwgTPZheKPHJNAw8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D4NcDL4h; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy+pj0pcCDWyAjdeIRu/RDEsd+Xn//vvBxj7Z/EeXAslcVNSN2/iTLC2aGCn3Udm+igcIdgnS7hzUJUaSXjV6LS6+qGlMH3RG/sKBWV7PKSi9Wv+mmn8kwdQqIfdlfxz/jT4n+Gf6hm7dDr+Hm/i63XT3F/HnGn5LoRli7HqlasxhLE+PG+dMioB42uWHQGm7sWlPy3Nu2zJgX5W3AA8Dt2MiNJhWaoFMaQwhz3+KiWLQgB1DeQmo/FrugZFqrNytk5CrhhZoUuu2Yb61kv+fd4DRsk0+C0Je+4dC9iS9lM1HPZN/4qtTyqw6d5jwFn5sW+MYcEuZgK4reYSUR0arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN2mabEZ89SC2dDCu1ufR8aIG5qATE1Ds1hKiXQhtao=;
 b=Pen/YBkHav1NTzjDYJVxO+1/CF45/FJHFcmlHzuxr35pGB/Zqs+fQxrJ/9Y1gEnlxsWJVRrH/w2MA7e70eMLJBxJiwTP8TpicRS8IhjqWmDxaHdVbXvExGR7Un0SesRDlYsrjKqpG8czakf8jRrTG0E9CHAD+hCQXb7g2y/TpKQF6k/wMs31Da4woBN2LsOvN1h8A3JaUKSYfs9gHF/u9kmsgXJzBePGGyFoISrAU+YSLd1JHodUs2fzDH9Eo3jEy77X8fnWxLE0+oGE3O+JQGTSxid4dcVJDKvJRxp6XjgmHw1037MRdjFA+9GqTVL5XiLpLY1pci8i5KRTirM5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN2mabEZ89SC2dDCu1ufR8aIG5qATE1Ds1hKiXQhtao=;
 b=D4NcDL4hcpZhi1OIsSqwTqxDHSyGr5AyUr7ZNy5PTj3vSJWMNurbRzQgvOCxR39w1QCJnIFuC1i3KkK4gmBSvJtIGSeye9ZBWL089y2HiwCw/DtW4AzdX00xSRdUTfbXepKw407zdNNwJ36L7YLA+EuwQ2D+Cr/9wuRXlZu3uHMV6kGjTV2/BhUkT3VVqLRTRCaz99qLq/xmjRPsbbcpv8h8UJ/XMyta2vfp6tthi1/O9jYLjx08pzme/XkzGgrmkJCJbOVQdhb3j8EBC8jaJgrLEnGg+w3vxOL5jhxwuEgGBDToVyzUFgsPW1fkTGikPuduwTFA/VqG7TqG78+R+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8151.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 19:53:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 19:53:28 +0000
Date: Thu, 6 Nov 2025 14:53:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/13] of: Add wrappers to match root node with OF device
 ID tables
Message-ID: <aQz8rW9GE66xPYrL@lizhi-Precision-Tower-5810>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-1-d780ea1780c2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-1-d780ea1780c2@linaro.org>
X-ClientProxiedBy: PH7P221CA0054.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 53af9b15-dbe3-45b6-d10b-08de1d6e2758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BClG8opJ5ptWKwlgyYgKkaku2Hw4f9veCJQn0K07t/ktqxEbrcBupWhUDBJ5?=
 =?us-ascii?Q?f1XY5dsTN6ciWRcPPpUBCE8/dQFHTGw6+tQ0jD3K+hQ001g6EEJRoOsYp4zJ?=
 =?us-ascii?Q?ctHMFi/aCQI/Rc6JW5nKWnGtvmnpJq/Pfz9drie6uyYFOCeY5nvqQwHvfRRW?=
 =?us-ascii?Q?y8XhzkUxNwXi3+L3c/clsawCnf9ykdyP5xvbFMPKB8ERsC3pY42HTY+pwvIl?=
 =?us-ascii?Q?VfQztafu72jgabYJhKGZyXzG6xETKgbGPRX+CCNofJiNhVEt/9QDXAIvf4Zt?=
 =?us-ascii?Q?p8YngQJqpIwi6jnMxnJGwtsZYGSdckufdfDviQY2pZLt6haIfrbnWyymQvPv?=
 =?us-ascii?Q?gGrFjWI5K5P4Ew8NZ5YDhC/6s3Dy3mjYsP7O2PzaU5psAuDPLiKx42kFX6/W?=
 =?us-ascii?Q?9Tj6fa4mgkkDQ910Nfnmw/pbeYxoY5ZCL1ZmfimkDIAa2dFPZWMkGd91q8eB?=
 =?us-ascii?Q?irwFe+tJaeJjuwpM0egZlHLfRiF+9FhXF16Neah1rgQYAV9oCjzz4lQFs05x?=
 =?us-ascii?Q?HVW7fowA0EUgdjZ+gOGk3PePcE5s3ERudsLg34VlvpHIU8ougDeiSS+MgXVT?=
 =?us-ascii?Q?gKySjYlYrJPTGMlhc+cpFE2VEAuZUOMn0FB85vfF41HRy1VdVpS4U8I+r6yX?=
 =?us-ascii?Q?cOLacxDmivyyWjF0uXt71DhWNAQyqKl1HhscqMT6eB8i7jPGGoOzJNGfqqYx?=
 =?us-ascii?Q?e93TxySz3F3mqOGtN/sXNtg7ffN+0w50yEZ0bFR+LUeRdq8t2JGD11+cxjuq?=
 =?us-ascii?Q?CU7FOMRIgpwnVN2zSzdBOiBWrwoPDLEkz4a8Vf9h7+zDEMjCNtjjiz/RWMwL?=
 =?us-ascii?Q?fRcaYI+IRe1kzsmbpljd7tbUq1loM9kCNaemHJ/lQIy+zzKI0V66rEaKcpVI?=
 =?us-ascii?Q?zZdpn55Kn5RRcbCssiKrzQMdL8Wt/hOLg+if6dsh6siKUs6HgFzB1+KK3O0r?=
 =?us-ascii?Q?fnjD7G7P+rEQfWypPHS0JRPX0D8Y3BspqDhVIqe+0/gpPzGGuulRtpuTLOPA?=
 =?us-ascii?Q?MZQRO3M1rx68vTZO2FLtfIbRzrjRjUD1h2W6gGw8yDRTOFra9DZccq9w3B5H?=
 =?us-ascii?Q?sTortyrfukPq6Z2Z6gHcJB1Y3tkSt1de7VGMbXhT1AdiOjmivwD5LC5yUjQk?=
 =?us-ascii?Q?FD44zQnwitIdpFpP1EqU4zrcM7wjBQrRTTiFPOq7i8zjSa7UKfHtga3BQZ2M?=
 =?us-ascii?Q?eMlxwlnVlt84PUE+m1JpxZ05sflQ2dF4zLt/jbusWsx5Tha8v+ka7/Qd9Ckm?=
 =?us-ascii?Q?b1ealFvpnG73ihGZWKZZkO0HjhgeYpsqxCMimG1dUt17FlvWr0P7VfDgO2pC?=
 =?us-ascii?Q?hEmn3e59joHH1Gb7oFUbYtqK/DeB0g7EGEHwd6KkM1Tl17/92guSrJLoEEhu?=
 =?us-ascii?Q?6bnBrUeg++Rlwwpc3SttFy+7Le6KfjAEvFKvtEll9+afJ6oxMvW9C7Ui++R6?=
 =?us-ascii?Q?Guo3+x+ROMU3tPle4z5bq79YOHufW8/ATbY8+vsA8Vu5xCp2cR/MGDUYG8pX?=
 =?us-ascii?Q?LbX5h3VL0Jpbvg8s/y6ngVHNMkDX7YISCBJw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PG7OPYwdaNr7Yi1R0UyWZ5SHX7xcQRPjL75TTH+HnkbdIKE9TPtKH3BHsGOd?=
 =?us-ascii?Q?FVGVJhKTtgDZfmOiSw08iSv9JQZttz/w4IojD9nnKt3C/h99xFTmaiNkezW7?=
 =?us-ascii?Q?IGFxpzUHXSTI9ug5tIrkf/lLFZfsXvXCoXGxN3gZTuwwiM7hM8lLYWofbj/X?=
 =?us-ascii?Q?HOeEFCRAi8K77/7Zhv4dRzeVjH9cXKe+g+MHWmzFW+Q2QRPkIhMWpzx9KMyt?=
 =?us-ascii?Q?ZDzfXn3tlRrNvUPfCIuWSDvrAZgzrFHddb3n+1ZZFi15LYK7ASkAS9owyoFS?=
 =?us-ascii?Q?KPRfFQcYF1DHz8IKyMDNhd2m16FqTwmcTjAHc34n+FBhH4hRWAKHCcyeE8Ar?=
 =?us-ascii?Q?a25pYQdRrQIYnoEUmoWD9f2xH5E3Hk+IBrX/JsNt1HAIzAKP9UzHoHtAkKq3?=
 =?us-ascii?Q?Z5WyMZtoiGBmR9rdbgdBK6/9gasEgMzWl8XM2U6/Vs1aq14unobM0hfA0sJN?=
 =?us-ascii?Q?AwcFrDPFV0W8/dlkdFNUpg2mSAzTgg0ZtYCusdAPral6x+H1ULrOPBld1Loa?=
 =?us-ascii?Q?IvVPKfZKzO5WuyZMkHHl+X8FGS6YN6fypPXXgOM7NOr6Pg2tcFhQeqL4WU5e?=
 =?us-ascii?Q?86KNPaZEtNsuYbr2FuelT+yyg+Dg9+ulZiPvlvPo9YHxe5q9GPAh0JVyH+NZ?=
 =?us-ascii?Q?9vwJYLbmJlVsvIWaFabKYd6Nbc7hsd+aAfJIzLc1MW32/487I3eMD8eHwlZv?=
 =?us-ascii?Q?hkWid9D8NHLtKScIiXd4GFLCTkQe/O0QWfrw5KVdBxAXNtfPMug1D8QgmGNH?=
 =?us-ascii?Q?r5w0P321gtP7LcJ6Vzpq3Kn4L+r9DrKHF5P1oGy/xomEMxkLZ6HwL4cnuyaQ?=
 =?us-ascii?Q?Fhg3+pi/ooOmTCTtxyuQ/D1PgcS7oGW48Smd9j4uy0x5riHbPJsZQWbOmcNk?=
 =?us-ascii?Q?cktst2CEK/RWcby3C/hQ6uzfnFPxgq7q9/2yh4Pe3sqBKT6ZNDWyqAfTyoGc?=
 =?us-ascii?Q?qwlBsQU8l2yHPp+I6uryKVElFtUx1yeUSdtncNMMQCMdmd+0gZlyWbKk/kVT?=
 =?us-ascii?Q?3HLdopQs40lT3ixD67bcB5Uqj1C7NsirZRHRfsjL1DPtaOoy8nX2uKFhoaqz?=
 =?us-ascii?Q?mGgzXaObE318IcrlJD3BQCCXMNwqzBSmpP3XX3wB+wzzA9QgNGubcJmeBqij?=
 =?us-ascii?Q?JEs3Dvbgtn63CB5tVAPjAHrfhU/tP1DdVWnZTQx0Yco9QQSSoEE+NQiY3aHM?=
 =?us-ascii?Q?s3WWwb4WxbrgEs3b9iW7EwaBDEf7DJMUdeolmPwut7iYjjRFSx5TY6c7NRW0?=
 =?us-ascii?Q?pVa0izowRo9vpuA3jexqfxer3lPj/ShJTjqeCac83lKtCLC8Naj5Z6uw1nW8?=
 =?us-ascii?Q?0E/mv/WlOaswHDA50dWvijAW1+TpTkTPSIs7cvZFo8VP4RnrIXcgc9q5XfL8?=
 =?us-ascii?Q?RLH1OVrZziQOkppru9SLWuPURbfpSwnBmrou0XVX0lWJGo4QZoC+55vx5rrd?=
 =?us-ascii?Q?xxV6QumptMbEy4/upx7fmRZSxO2CRZilN9Of1JMOcVVac9RjltIjDnZ2q/33?=
 =?us-ascii?Q?rC4+ggsV05mLp/IYaaDMLHCyeOohNwWzD9psiqwLzmmoOVEtmHAHIr3UhC5l?=
 =?us-ascii?Q?98DS75L6azydU/L3C+k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53af9b15-dbe3-45b6-d10b-08de1d6e2758
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:53:28.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SjHJYdAPNmK6tAxfY10FZT7TcHN4E+UTFVmW4/rhcOPq+lsWO7jj5+zab+0aWxPd5VD6+RgJeLfROvGQly5ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8151

On Thu, Nov 06, 2025 at 08:07:08PM +0100, Krzysztof Kozlowski wrote:
> Several drivers duplicate same code for getting reference to the root
> node, matching it against 'struct of_device_id' table and getting out
> the match data from the table entry.
>
> There is a of_machine_compatible_match() wrapper but it takes array of
> strings, which is not suitable for many drivers since they want the
> driver data associated with each compatible.
>
> Add two wrappers, similar to existing of_device_get_match_data():
> 1. of_machine_device_match() doing only matching against 'struct
>    of_device_id' and returning bool.
> 2. of_machine_get_match_data() doing the matching and returning
>    associated driver data for found compatible.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> All further patches depend on this.
> ---

...
>
> +/**
> + * of_machine_device_match - Test root of device tree against a of_device_id array
> + * @matches:	NULL terminated array of of_device_id match structures to search in
> + *
> + * Returns true if the root node has any of the given compatible values in its
> + * compatible property.
> + */
> +bool of_machine_device_match(const struct of_device_id *matches)

Will it be more useful if pass down path

of_machine_device_match(const char* path, const struct of_device_id *matches)

caller just pass "\", or NULL point as root

> +{
> +	struct device_node *root;
> +	const struct of_device_id *match = NULL;
> +
> +	root = of_find_node_by_path("/");

Use clean up will simplify code

	struct device_node *root = __free(device_node) = of_find_node_by_path("/");

Frank
> +	if (root) {
> +		match = of_match_node(matches, root);
> +		of_node_put(root);
> +	}
> +
> +	return match != NULL;
> +}
> +EXPORT_SYMBOL(of_machine_device_match);
> +
...
>
> --
> 2.48.1
>

