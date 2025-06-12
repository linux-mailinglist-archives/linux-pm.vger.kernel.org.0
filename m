Return-Path: <linux-pm+bounces-28522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0CAD65BB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 04:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A76D17D601
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 02:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1516E80BEC;
	Thu, 12 Jun 2025 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nhxomPW1"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012054.outbound.protection.outlook.com [52.101.71.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00941E487;
	Thu, 12 Jun 2025 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749695633; cv=fail; b=ZyYtVpeqry1w4NRBSq1UoQ3C178hmQEf2UUxkfTCyUGpciqkoYHiVg/gnRgiueyfrpFqcJTA+TVnlt5/uKrTDh65zR8jjfqQMqYKtKjSz0B160tkca+pzhu6hvTwGgYzLR0x6ge8kyA50eAxfZbbKRXa2EHOdpwm5auvgP5+/KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749695633; c=relaxed/simple;
	bh=kF6ieQ2kJIj0bIR2SaJ+ErRFQpA7X9ODQVOnzOetSq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r6TjAD7a+yEpBa046xp6gCvJe33okrnmbAlZdoY4RCtuNezZ89BvJbKJGoTSr5bACQ/6/th1vFv+1yVX+g6R1egQROcLNJwoiImFuP0V/VcSmp+fuK70Vxe2/N7bPZrh0OOwYaakO9dDRwke6CdGiXtS7YYEskMB2pwVywOKQYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nhxomPW1; arc=fail smtp.client-ip=52.101.71.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwah5lHZd3uHwmPH31RBZ3d5bYsJrWlTELjYoKKbe3M+yho3PqW9EPS5QSsJRsVDZXTYQjw01QCgMLKoaXJeufJNVb6KKlfns8p+YD8CL+ORecXEt4oAsbVaZCUgmCRm4ba7colR8ys7AhkuVYh5GOA7+yeaI51eYdZTkEhUzfSiPKW7nCuEypai/flfGM36/ncQFdFss4tkv0ugawr/RxkrXMd2nUH7zz4XMW4fjsFSG453Ca/UdLqie99bqXVb8SYCRsLtHjMpWh/SQkEYqHk/F6oShmaVbWcSe5YKM2+SJzV0hlCh9fgSx9OSFg27XQ9/Oh8bqqwNsY/LQIb+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRU7ooNIVf0rQwd4utOxJq4l+EGGiKU4yv35DgR8Y8g=;
 b=bVsYTmsExvn7FdszANdq6k2kdA71xBR4LGwA0rIaGzm3NOqbmP8hXft8JAMg6gIxqZQJhNBHqqWAhC/mTjkXGuG5V2joilBtQ64QK/JOHVmUtWr07JVVyjZMXgRoLtbq5eORCZ7UOD5+KFJNebsaRa38nIFtQwe0m0E4+pk08uVtoSdNbM+Wx/XCCjpUjuhLSiGRhhmhEMFc0AG0MlB/xKQ9KFHecHcaX5xrrQTSMbC9hGQ/TQk2/e2JpWPAM5W0oCnhW2QJLDTWHlNfoueRBh+kepJaQKVPJU3Eo1MQxYa3K2KETRP2ycjlBeKpEuZKgVwonCHa1m2hdwLDxpdpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRU7ooNIVf0rQwd4utOxJq4l+EGGiKU4yv35DgR8Y8g=;
 b=nhxomPW1L71bYLkFb/hGOgKivtG2Qpm0mZP3bIkPODMtkEKSjRFy9zSjDfpeHcsP81cwoMXn/o+WZXQcHGrWUyLOeVj+Fi3C+aSme1+LjFBWCAEtxxh6AwUmhgXWIu8BGg9o5t61wFZonru8216o5dw/NKThihEXirREfPCW7YpP/JO9fNp/hJfzcKcT6aQA/ztO1AtRdBhTxOwD2djDX4h72XOqwopXpsQGMg36Q4PZkNKwE+x4COYh4Gr5tRFgVTmR+zOCXk/D0iwgBpQyHbhnskn/QohRb5iaglcdlEAlC0LedV9EDaa7tcwFOmonaBMhFpNTAYHFk5epLCVcGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10732.eurprd04.prod.outlook.com (2603:10a6:150:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Thu, 12 Jun
 2025 02:33:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 02:33:45 +0000
Date: Thu, 12 Jun 2025 11:43:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] firmware: arm_scmi: perf/cpufreq: Enable
 notification only if supported by platform
Message-ID: <20250612034351.GA7552@nxa18884-linux>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
 <20250611-cherubic-solemn-toucanet-aac5af@sudeepholla>
 <aEmFnJVG8lXTDNmO@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmFnJVG8lXTDNmO@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10732:EE_
X-MS-Office365-Filtering-Correlation-Id: f5edfc34-ef0d-442d-9bb1-08dda9598def
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cD4K+O555B6MSTZFrwLmoMT3QKBuetnCf+BhnOBB+uHf3t5ZYIH3rsUaHnok?=
 =?us-ascii?Q?5LEvlza1lLKo+eMMyPyUyakiwN72ppucccEocn37CgVgurtSVXtxHvMqvSwT?=
 =?us-ascii?Q?GbTqR9k4t2qRzVZ0iFUwjGofMzOFs3xB8R5YnWBO3VKwPElGsMNX6CXcLmc1?=
 =?us-ascii?Q?nKUm1Z/0yq9bIz6TgyE60wu+lZY5g/3U1ZAefmB8b4ESbVRXZcVufqpbLcer?=
 =?us-ascii?Q?LRzNGTi3osYdAgQglhFnbyVqU5ycVWqGoC95n+jrXZuqiSIAW6yivQVy+tFr?=
 =?us-ascii?Q?hz9pWI3EedSaEUx0ED1zCjkalZk+/32Nh4IVq/FbbPa0pueuRBaQMPF7X2Yo?=
 =?us-ascii?Q?3QvmzEQoBiAL/5Sc6V2/IKbDu/rkx84tg2OCEpmvMwSm2qibPxQSu9uw5RhI?=
 =?us-ascii?Q?Hlh2GYDVD1Pf0RigYAsWBAYzaeamkdorM02RhfqhKfSmY374gkHwLNsg29CB?=
 =?us-ascii?Q?NHs3UwdZKYBuxAP/NYIH1Vi4qTHzFqizhxCPw39bZvNi9P6A+ef1UZv5kU0K?=
 =?us-ascii?Q?BYn1spu5DaN7P/iFAZYNMvv3N8Bix3RW4MpQxXlHLnAehJ3u4gA2fiX/TV7j?=
 =?us-ascii?Q?/jOyWOOMkkMf+nH5Y8Sck6Aq8i4w6EYkL1zvqxuCer1VYV6rLL8OAKNCMrDu?=
 =?us-ascii?Q?nMgDPZ3TUrFWeECuYi+KPmIfuljnZBYiY6UxxKN0oEe2Wf6CA1vPgtGR+jH9?=
 =?us-ascii?Q?eJa+whzb/gHHtOdMfFZarojZVXwReVXEQaHMZQx4Eh8Mymh9XoPQCQhA5lyB?=
 =?us-ascii?Q?n+W9h5kZeV5IQsBuXp3eMYsD6rJrjhYN79GCk0f3VPsvJzuP7THRcVkJQ7XM?=
 =?us-ascii?Q?nTl2SBSLYCw50MOw+9kr5V3ng4ZVU46FPPFybiiiMIW5tjMYeN6PaxJcEsJw?=
 =?us-ascii?Q?3Leid6z4ewbKjk71srypEB29RPDXmcyGQK0Sc/KHt6W9s6PcvhF2JMuU3j/E?=
 =?us-ascii?Q?nP3kx4e9j+k2AP1XK0QWHHqq1AMY2+k6i7JsQ0FLXIEKfVC6IrmRgIM0N8Dm?=
 =?us-ascii?Q?l1PvL/qm6zNwlnkNgFvE5SxVpeGEydVBnE2JwTVL3peR0P+IpDw1ESb98CLX?=
 =?us-ascii?Q?ubjDbGfH2JyUhME8urqMJ6R3lUEIdSPwPTeYtNL1IjxUb46Bjc1rHJJQ1LhV?=
 =?us-ascii?Q?94LFWHko4vUIniAN0J//zhMsOrHccCXZcW0VFiTFZfn/qAcek5DWmR7REaUu?=
 =?us-ascii?Q?IMLj2sDYHjoB74W6n9IWam82oSVTCFJnV6Bp3jKCW81TqPcVVdHF55XgdGnQ?=
 =?us-ascii?Q?IrrFgwvjLP8Zjw1N5skeqkrWT7GI6ZfhWI4OavjO25tBwGhtlT99BMXpioQL?=
 =?us-ascii?Q?a8uBy3I9ncnyG1yca22COCxiaOmtmsRgDVYkEmPCtlHlgUpqXh+yDObsyRHQ?=
 =?us-ascii?Q?ToFuVXK3gdlHHzNq4MGBwGoD9IopZ+cQCp9/xWtq9/ADCXtDP4vhkOATAWFq?=
 =?us-ascii?Q?zNUqzbzqP+r4LfPUwRsXG25I8nor61hWj1cy8SxE5mC22i55poDAtN1rh0vR?=
 =?us-ascii?Q?QzlGUFC0B65mk8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ooJmSgTSmxjRa5mYPDrIwoeexrDHIv45S7TJ/FvMh2Sq6+PgKv4ak2OMq1rg?=
 =?us-ascii?Q?v+3oscDjj/JAEx1Mi2rVED9Xivr20h+cvQw7BOrTwqXh/6+V62Fc5J5CW73g?=
 =?us-ascii?Q?Cd2oHj/14jyqLJinBmGO0YRGyA2Y/X9zFnVPXObykA8aws9h8FDeKKuG/T0n?=
 =?us-ascii?Q?/CJ19pcxxUEw65lEMpwmaRcD43L7WoUzBq2OeVoGja/WcbkBC0Ll9ZsrO8zj?=
 =?us-ascii?Q?pkYOGh5FjsQ86Q1oVKDQD28f8eWcVs8T7jEXTlr/k1AkgPYrBbg7FSrHDdUJ?=
 =?us-ascii?Q?wu8yCPL8m9UeYoFT8+WaXhs2ojNCy0FfD54ngO0tEBeqfrpsdBIKA80Q6Vk0?=
 =?us-ascii?Q?dNEfYmxPt/niUIqRb6Rmev7eli7m8lBxeAnn7j4Qqzmep5KB3oKTPFC/jFC3?=
 =?us-ascii?Q?HaQLmahuTw8MKMPfJzQiryIzWozb5qg54Ae16GO4F6lzO4vwnbZqEwTZfbW0?=
 =?us-ascii?Q?qghGAmQwI83mTH5O+lB9HszZJ6SBZAygXH0DNgm0j97aVxK1hNYj8to1yQuF?=
 =?us-ascii?Q?PHALCGC5u/5xCOanvGLr51eZHWPHAu4g+DfhHuCETM/B9gMco+thBZHtHEsh?=
 =?us-ascii?Q?2c846cHljBFvBrZaOvwttuhJdY8s/969XRPsYVaIEXlRsVhoTpfzJmdklU9E?=
 =?us-ascii?Q?Jb059vPDwkexUGJHu+KW91G+Qvmvn/3QTjMntXo7MejF83BcqQqNzVC4IqQE?=
 =?us-ascii?Q?eoF2RMpw+88XiOkPnktF6gr656iskIYr1kw4GeXPvT99dtz5+KiAz3wvc+zJ?=
 =?us-ascii?Q?PQcBvzz68J2HMr99wL5SNHzMM6GcUwluJIKscG+7tYiBfEV9K3jyTQL5hNUM?=
 =?us-ascii?Q?6U0be6KVfuaM7MuBi+ccTFBAJKO6yC4+N5nH+TkWa7hMnBotXF320PUF5Te+?=
 =?us-ascii?Q?RvjJMPZzF/wgsnBh/9AyHlMgB/AIMCW+vOHJk8iR1SJ4JLwGBDRg9XCH8hPD?=
 =?us-ascii?Q?4fTTZvaocm99YrEpKr0uzt6yyS/YmRBJIqRkwTs72VHSA9Z2dYsUntVxbM4L?=
 =?us-ascii?Q?A6GjZO52rxnQYZMF+8qfFgf1YKf03q7/L4gksPXjgaYqC1xnFBhku7UcS91C?=
 =?us-ascii?Q?Pgng3OefQ5xMlz7iqf15tZMMjRAwx4YWDW9Zl1vhj75gAgHhrun1vsWgrmFw?=
 =?us-ascii?Q?W0buAzJSx1OrGLWBnTWMR3MRU6uPjdZela9hOiFuCpdKDD4kwAUfzkFBcMCt?=
 =?us-ascii?Q?sZPHJqkophB6JV7mVhBIc/njb9/+TxRQILoPg+oD3w9knF/YxEgciWFtZOtS?=
 =?us-ascii?Q?go4jcKgq42QvFig4BrNDwcUkv8LJUG9tq0WUccCDdieEUwHZrpFQmSzAqang?=
 =?us-ascii?Q?RdFk2gvKg+huKmuR6ujJqVFoYsi29W3I8RN3AFfM2ovSBzaO6OtEBgnXSKt0?=
 =?us-ascii?Q?C5UtK2vlk7gtK0KCUFbA4iIjpovsuhAGbf/R5FwlAyR5uAkGwWjSz4odSlPU?=
 =?us-ascii?Q?Spz8J/plsFYCc+tyyVVxLoaL++zzdbrzLc2EYdZVmX6xu9E7Lz7BTYWuevAR?=
 =?us-ascii?Q?YwZPQB0d1y2dY1mlb8cFq5hMsBckSZlHnEYK6BxzL6RddBRDtKpbtcfDzmEd?=
 =?us-ascii?Q?k2gpH9wo93Ce6m1HMvjHCD2HQm47ll8gxwJRycSS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5edfc34-ef0d-442d-9bb1-08dda9598def
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 02:33:45.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB0CTJQ9wKzup9EKnZ5Pc4zBqNMfwU7J9yE0C1wTrPOgmfHEPcOURbDPYSM7zIFeQLpW/mtyn4qO6E3pbTs+jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10732

On Wed, Jun 11, 2025 at 02:33:37PM +0100, Cristian Marussi wrote:
>On Wed, Jun 11, 2025 at 01:17:11PM +0100, Sudeep Holla wrote:
>> On Wed, Jun 11, 2025 at 03:52:42PM +0800, Peng Fan (OSS) wrote:
>> > PERFORMANCE_NOTIFY_LIMITS and PERFORMANCE_NOTIFY_LEVEL are optional
>> > commands. If use these commands on platforms that not support the two,
>> > there is error log:
>> >   SCMI Notifications - Failed to ENABLE events for key:13000008 !
>> >   scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8
>> > 
>> 
>
>Hi,
>
>I had a quick look/refresh to this stuff from years ago...
>
>...wont be so short to explain :P
>
>In general when you register a notifier_block for some SCMI events,
>the assumption was that a driver using proto_X_ops could want to register
>NOT only for proto_X events BUT also for other protos...in such a case you
>are NOT guaranteed that such other proto_Y was initialized when your
>driver probes and tries to register the notifier...indeed it could be
>that such proto_Y could be a module that has still to be loaded !
>
>...in this scenario you can end-up quickly in a hell of probe-dependency
>if you write a driver asking for SCMI events that can or cannot be still
>readily available when the driver probes...
>
>....so the decision was to simply place such notifier registration requests
>on hold on a pending list...whenever the needed missing protocol is
>loaded/inialized the notifier registration is completed...if the proto_Y
>never arrives nothing happens...and your driver caller can probe
>successfully anyway...
>
>This means in such a corner-case the notifier registration is sort of
>asynchonous and eventual errors detected later, when the protocol is
>finally initialized and notifiers finalized, cannot be easily reported
>(BUT I think we could improve on this ... thinking about this...)
>
>...BUT....
>
>....this is NOT our case NOR the most common case...the usual scenario,
>like cpufreq, is that a driver using proto_X_ops tries to register for
>that same proto_X events and in such a case we can detect that such
>domain is unsupported and fail while avoiding to send any message indeed....
>
>....so....:P...while I was going through this rabbit-hole....this issues
>started to feel familiar...O_o....
>
>... indeed I realized that the function that you (Peng) now invoke to
>set the per-domain perf_limit_notify flag was introduced just for these
>reasons to check and avoid such situation for all protocols in the core:
>
>
>commit 8733e86a80f5a7abb7b4b6ca3f417b32c3eb68e3
>Author: Cristian Marussi <cristian.marussi@arm.com>
>Date:   Mon Feb 12 12:32:23 2024 +0000
>
>    firmware: arm_scmi: Check for notification support
>    
>    When registering protocol events, use the optional .is_notify_supported
>    callback provided by the protocol to check if that specific notification
>    type is available for that particular resource on the running system,
>    marking it as unsupported otherwise.
>    
>    Then, when a notification enable request is received, return an error if
>    it was previously marked as unsuppported, so avoiding to send a needless
>    notification enable command and check the returned value for failure.
>    
>    Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>    Link: https://lore.kernel.org/r/20240212123233.1230090-2-cristian.marussi@arm.com
>    Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
>
>...so my suspect is that we are ALREADY avoiding to send unneeded
>messages when a domain does NOT support notifications for ALL
>protocols...it is just that we are a bit too noisy...
>
>@Peng do you observe the message being sent instead ? (so maybe the
>above has a bug...) or it is just the message ?

Just the message.

arm-scmi arm-scmi.0.auto: SCMI Notifications - Notification NOT supported - proto_id:19  evt_id:0  src_id:8
SCMI Notifications - Failed to ENABLE events for key:13000008 !
scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8

It just make user has a feeling that there must be something wrong, especially
those not know the internals.

And from the error message, "Failed to ENABLE events for key..", we not
know which protocol, and whether notification supported.

I was thinking to propogate the error value, but __scmi_enable_evt
always use -EINVAL if not success.

>
>> I wonder if it makes sense to quiesce the warnings from the core if the
>> platform doesn't support notifications.

If not quiesce, we might need to make it clear from the error message,
saying whether X events are supported for Y protocols or not, not just
a "Failed to ENABLE events for key.."

Thanks,
Peng

