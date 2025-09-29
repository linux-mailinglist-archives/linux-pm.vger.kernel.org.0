Return-Path: <linux-pm+bounces-35529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077FFBA7CD5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 04:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B359C3B1E5F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 02:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CE1E885A;
	Mon, 29 Sep 2025 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CMxH4KEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5A2C859;
	Mon, 29 Sep 2025 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759112940; cv=fail; b=HVTCo6O/62zHmso8FAztCK6r3h6iBLRJ6GjSGFevT01npycoyFVodwVj1rIiQsfvTaPzbtqg5K1jCf1/GNrJLSvM5LrOTnf6RZtHk++nY4QAh4OQy6ZxD3vjp07IAJggmmqGkIlB+EV5iwZKImVj/PWWyn9mL7l6MEoNA2tg69A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759112940; c=relaxed/simple;
	bh=EYBe2Ogt0dTUkY2j3pcyIHv6nZkKPtNu65ByUHU2Kqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qys+tXPbcse7T6lpHEZTFBPW282a21sjTjm0KaP2ikoUnnUB3hyzy79q1r+/L6XPLcUSZV8ScPPBgf6mKKIrI/KXDrKZUU2o9Ee1wD7LSYpL4RnPKogyDrZS/oHzL8GbKro9rVYqnd1LErS+H1X0pd1BrlxRvQKQaY8rx8fiQ8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CMxH4KEU; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hImux4v3jDjdFheZSjVp6eGvQf9UFf+OIBucF0Yq9SHsuWz35rnT6xSnwN3/XoVaSlm2Q0VSR4TPKGWhsl0dTyttwK/KfHy2GinWtrY9yclq8VTzmR1ohcXibyyjR7ibrd3XeL3fImg9UiGjcx7Xw9/0K0v1cIYT0KrD+SEM5fXf2vVLxu/Om21cjC6biVlqzEvDVz1uSS2pzTQhepXxht7e0LuXAO/gZoBsaFR7YtTn2wEBrm9mJAKdPA/AeAElMxObUow68sG2pB00eE+QfaOulD29K8LCe1ga9NVuJiNp5BqOLIrsWYp+NjSyR+T/JhkNnMMHu9YvyDpykmN8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HaP2cpl+/9d+FCMjSJnbTXS6xlVGHejKsnqdDroPDM=;
 b=F1DaUD07vdu/P1Njx7MJPhRZTuKJizkZunbGc1QIMx2VAF5kVaG3hLdidzYrrzgfXQKSylRFN5I6idkudh/NFvlCSi20rGbikKtZ7A/qiMcRJYGfMuLZPVKCOs8po2pfhchOP24/noIyNoGtLNeDA64hZrEsf128SG2E/w/trudaUIUrTM0dczVlZ7VffXDTOnOC4BLx+uE8qir7vhHPcLe0Q/scr6o/DwyIh6qVfEjVbWdU0BgPFCtHlR1sdMT6iORieE/B2DI+bNs3L7fycNi7qqNQhpfrIfSwEsvYfbHyunh1mWTUIuKgn+Yl3x9EfBSmFZK61EGNO2KFJExLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HaP2cpl+/9d+FCMjSJnbTXS6xlVGHejKsnqdDroPDM=;
 b=CMxH4KEUIKiIQ+4hLoVky2VpclOZR3XpaqaZ/yG4o/+ges75a9beIMQsLSBO0OVoAM+7U07y8p0zOzCp1Hyq+/t10CNn7ygkxa4WN001eaGL2hKqcULPHhWjmx2y+vQ4Ts4smWSIgPpeDnYvNbDSsWEg0xL9p/leMJryLzC085C0E5Ei1RRhEglJSayeJyItc0GUORA5I3TEwGUGouYkgyfJ7EG0gItjsEjE5IdAwcO0yIKqzG7MEMHucmxghA38NDyvaGK8iDuFoQ5+6lL5WJjvf1jBXfERiOGkxI1HohNW3yj/11zYcGkV3KfLzD9F2nlNTyw1RcTDrR9Rqhz88g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10753.eurprd04.prod.outlook.com (2603:10a6:150:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 02:28:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 02:28:55 +0000
Date: Mon, 29 Sep 2025 11:40:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v4 0/5] pmdomain: core: Introduce
 device_set_out_band_wakeup and use it in usb
Message-ID: <20250929034048.GD29690@nxa18884-linux.ap.freescale.net>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
 <CAPDyKFqQgS9j4uGkTL_taPTL96su1tqpyoek1cpZgTiaaBMpCA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqQgS9j4uGkTL_taPTL96su1tqpyoek1cpZgTiaaBMpCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10753:EE_
X-MS-Office365-Filtering-Correlation-Id: f0218efe-a1ba-4f93-bdf6-08ddfefff00a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t+Q7E88RvXEL8cZz9XTXaUSD/kzo6FFZ2SEZ4hSMnBW0XmciNtLZamzI1GYu?=
 =?us-ascii?Q?V4Rl6MGqcB3jBv+PI2Rm2wxoyFXoitcRfEvMfGw8DosNGUrjGTBuVCPp6DQP?=
 =?us-ascii?Q?r54iqQz8jDQjjARhgwp0CtMv3JRA+A+vYH0PHO+DGWIgY+0Mm91uPJ7tDsx5?=
 =?us-ascii?Q?7DPucGn+aCJ9R6JGq1umhTpNQ8VvvdMkfYf8qJ51BqTrkSA6z8pJSHQWUo4h?=
 =?us-ascii?Q?9v24HvpQCe1zuc8X6m+aXD25KplrjO18mX699mKx0BnVu7uj9kWYlloJ3gET?=
 =?us-ascii?Q?s09QdhdQ6AVfQws9dLwQ8PUkoDoButUcEJw3N/Pj/iwbbOJmwExrRp30L76r?=
 =?us-ascii?Q?mCa0JqfGjHbrKBh1wIYA8hi0UCgG7YP8zmWJt/k5ZItfsLVmQCiOVwWgXEOz?=
 =?us-ascii?Q?zpOIqEzCwesyDCSBprtkANzNMPhf7EB4l1u5dtrqQm01gsN60EJZ3UT9FVBg?=
 =?us-ascii?Q?jD3LFFVio8l4jtThEIU1hlr1KLpoo1YvDI8TU4fcBofjn071OtuN70NNvgUW?=
 =?us-ascii?Q?EcqYX7jpL8ws9qSZ0N/PT7nFn3CVcUKKHLE1eBLTqryZujGMuvnIpOldcnZD?=
 =?us-ascii?Q?XEgovwI/yEudjJyXe5FUA/5k+EjNd5DdwZhMhdXorjUroskm+FXkMuQazWSr?=
 =?us-ascii?Q?1PZyXrO1JNwyyD2VTNj9VKWQtVkUN5T3k0Piev7u7vuU5+q/WsP9aJ1YuPTh?=
 =?us-ascii?Q?j+yKM3FzhyuKAJ5b5J4HANWMxIMNnFUZoLUD8NwMXtJPma6Z/tZS8XvCUsY3?=
 =?us-ascii?Q?TQkw1QLBbpL5N+HKvPLCyrtY1DbY8Pl/RhOnpqwU/ZLF6SdvwL+vLc+BBmJO?=
 =?us-ascii?Q?ktxLy5JCuv/exkLfGM+AC7evOTVF++s7R0b6VKqKq4anOKvxJwog0Ewq/6CM?=
 =?us-ascii?Q?66dSakwbSMEDx6935F8LEIgyMMGInhEeB6wJN1Fb7TSOy2DNNUklwjYhAFDq?=
 =?us-ascii?Q?0M6t+nqHgrt8/CP5w/RTTunFj1P2CmiKqdFupLVPFI2VM/gCNMlLeu4h5jGP?=
 =?us-ascii?Q?IVmAUiRDA/wCWLabAb1HhlteLscm1u5graDzio/bJ76IZaVFekSFU+gaROQp?=
 =?us-ascii?Q?u/nAKrv8gzQAuPV6MTGFekmhKrTw/EYrlLefbe97tw4569JD9KaKd7yP6bI6?=
 =?us-ascii?Q?Qg2XvOC2cKo7/k9ENV6XSdUO29ufi2lDZ2C2ORY41knaMnXot0dPF/hm9ols?=
 =?us-ascii?Q?MS/863QcavaZ9Z0tkKWYPM4iK6m+B5mZZ+1aQoU42l+AjVcLurIITg6b3Acq?=
 =?us-ascii?Q?Qh6ysIPxNs6Zd1X0rtOW4P7GssIMrYloi/Hu7gr9PkLW0F0KZ22/t/QobJRI?=
 =?us-ascii?Q?1zB0N34S10gR0v2sV2WmBkzZgnCwrV3LPrlPIo4S1k35p7XhZ2M3NppfOrXE?=
 =?us-ascii?Q?OnXXFdg5mX3np+ETTuUqO4mrmuyc4XgTnjc+uKmNYwCVDXi8z+CEeGeA3VEA?=
 =?us-ascii?Q?3cN+0bG721AKaEIpxfyanVopP8E1+oLY+A71gg0oTordu9+ij3i6aTi6onLk?=
 =?us-ascii?Q?oF1z8lhIPcXkquXmcvFr08MLx/S5jIOY0EG9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RS6xAgoJxu5mvD/R0Sqh3DDrZZv7QjnJzWsLTIbcA2Bw/303oAcEwpi8I3nJ?=
 =?us-ascii?Q?Cbso26+BFBgDQI0LYMKO4VOS8e2EzgehYeaDpmJ1kdJCAuvimjSnUOJfZPyi?=
 =?us-ascii?Q?xi3bPtSfsB/KzffkXJ8YGC5F8NGdI1jCVEnVRd/8Y2ALsc4JDEDcy5YjSm0B?=
 =?us-ascii?Q?Etb7wfyoP1a3eadX7B97N5HL8y/lJv7/rwJID8EfI6zyZPwCtcStUFmCtmRj?=
 =?us-ascii?Q?mDaxIE5rVJgC6KzBvllBmOOR15q99tbR56tUKuyB/VF9zM758oBYtjw5TPNl?=
 =?us-ascii?Q?Y1cNpmBfHkMvLX6/hFzIbPtnqqo2L7SqfmRoAScmJkVpAuu1vAeJEQSmwd76?=
 =?us-ascii?Q?5AWAj15aCLWRyvEyNRutK0T9rA8lTClDaa0TMiGZ29wNNUQTQD/dkwC2PJ8t?=
 =?us-ascii?Q?z9jEyQLqgoCCAjyZ3m5dQtKr9b+JQkA9dySD4ysRCawYVFhZzqSeZkqHrc6F?=
 =?us-ascii?Q?Aq/qboFVkzo9aAAGzTwjl3tI4KzmG2VtBa6wPEe+5JOAdC+Ahfe3p6b3qUjg?=
 =?us-ascii?Q?zyfvXo51GFUmqn89dTvptdXgeDgeCvFKmIKmO8Nddc3C7OGHvEywOX1cBpn6?=
 =?us-ascii?Q?flmOHzv1lBtC3MImcHWVnMQroXiDIpCyUKo1CI958DRfzg8Z/Z8zhFRco5R0?=
 =?us-ascii?Q?uw9H2RTy34IZbftGISPotrMVI4MEAZBorHMPBQkfi8EuFI4fvMzKWlLGCIYq?=
 =?us-ascii?Q?61eCU+Fi0UEISyC1dxk2Rxkbk2lcqR8r01tiRJp78qHzS9sOdvPD1O5uff81?=
 =?us-ascii?Q?SBHnLIGwewQQH02MhuU5ZYfMH8t0eyKYk8abebFwjSxr5SpbLhFDXaLFEJE9?=
 =?us-ascii?Q?9jFUIbPiIayfomi1V7fiRtbsbNpAFLuftuoavY0yvTitRP9eWIas+sevWkAt?=
 =?us-ascii?Q?L1vu6P7w12OpXWy34dqLzUKoh0MKvYpsDXwEsWV5n/kN4jHpsuE/P8v159/z?=
 =?us-ascii?Q?ah5GJdy2+DXAUwwHz3rpMAAq01ZlmI9VYiK7bRsEk/LZrqiuAKW98NhfALB9?=
 =?us-ascii?Q?7Khn915kET0yh31U2YzwWNvYLfAmI0I5N10fdM+w1fIthbWn6NsZRJQz94WY?=
 =?us-ascii?Q?upokLrrp9ugv8Z0LjXjhad5tkfJhrBu+Q8zMn3+F7Mn3suk87H9I+wA7D+KB?=
 =?us-ascii?Q?hmY8ZEsn18WNjdtZkVsX/nOgRMos52S160i6zjnTNrdYTNaYKVM6SW9FXPoa?=
 =?us-ascii?Q?kkjPCUN418X39bm0YkExGo9LRIw6YRniTYpUfYF5ECXsE+ciUxPkz7EvZK98?=
 =?us-ascii?Q?qzPdT7WcSJiw44J12DKPWUYge0GPLMLDv9GUANS/R/kPwyH0T7AcETZZQFJ6?=
 =?us-ascii?Q?qlTLZ7tdCF0qy2Q6xmwK1/waMWyRlVR5Smvo3wgi1PI+vdGoQzhbsIgXJGQn?=
 =?us-ascii?Q?ehEjxex3teoNxiu6HHykQmO159ezHBHCU7h8FcpsJhW/L2KQr6DyClKeDA9m?=
 =?us-ascii?Q?xAm2HZWteVH3GDoOWAWCZCWgrHonhzwF0BMGdUHjbnhJiRDZu63lxuvpiv4N?=
 =?us-ascii?Q?dRe7qjWAbkqDEFN19OXhuTbAFwffx/nkIMt5GWmYqLGpjD4V554NmmjaKhEq?=
 =?us-ascii?Q?acyTDKICdbHSU4fplaxw0CXz7kzI15ThibWwuiTP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0218efe-a1ba-4f93-bdf6-08ddfefff00a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 02:28:55.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3/fjjHZkK6OVrLnIv9uPC8WY93XoXFkcBDpHwsX+P76cFlam0c8RVMX4lxXk8iPtYmuP5favhtKAvx3vGi1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10753

Hi Ulf,

On Tue, Sep 23, 2025 at 12:07:02PM +0200, Ulf Hansson wrote:
>On Mon, 22 Sept 2025 at 04:21, Peng Fan <peng.fan@nxp.com> wrote:
>>
...
>> ---
>> Peng Fan (4):
>>       PM: wakeup: Add out-of-band system wakeup support for devices
>>       PM: domains: Allow power-off for out-of-band wakeup-capable devices
>>       usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
>>       usb: dwc3: imx8mp: Set out of band wakeup for i.MX95
>>
>> Xu Yang (1):
>>       usb: chipidea: core: detach power domain for ci_hdrc platform device
...
>
>Rafael, I intend to pick up this series via my pmdomain tree shortly,
>unless you have some objections, of course.

Sorry for an early ping. I see v6.17 is released. Just want to know whether
you would pick this up for 6.18.

Thanks,
Peng

>
>Kind regards
>Uffe

