Return-Path: <linux-pm+bounces-25361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C31A87BBC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2AC7A85C9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF76258CE6;
	Mon, 14 Apr 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rj16lEwt"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAB1A8401;
	Mon, 14 Apr 2025 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622382; cv=fail; b=W6NSLS+6taSdv0+1KbgH4S/V5/2wJfw2eGExjpSydmsXXcDIrBBPRI4jKGsyeYwCWDKDYkP+HXXppFvL9cDMdH9I4iT9i40QYdMNg6U4GrqZzOZ3DreyaT4pq7EorcVWeQ42iWZ/uzWOa98Q3Oe7fu4Awfl3CcJ5ks2dRQFretk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622382; c=relaxed/simple;
	bh=pz5hJLISxbIxGyOp3GC5a7LMYv67KXmK/h1jx7jRLcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lYKcVVCUly1mA0GUC7FJEn0FlZ9AIlc4o9q3Dq4TVGF7LS1tFICFe/HSN4LAdDPOklkldkLTSNjyqI7Y300GlZA3oWWlIgOnRfc3cbtwW1wNIkh94/6HXz2vD72py7XDpWnVC7chpj3fCZ4Ecv5yaUVDzYllv4+pPsQr15HrX+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rj16lEwt; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwsX0froMaGATWQxouZJd/AIo0J1+w5MWNu5XtA2PCqYm5eJX8lb9F0R685Om1iEhvjnrx77pY4YvsMN1Ni4/wHwvVMjBbtZSE7wVHvt3lxSEun2KoxWxZzP0chkXhxsw4ehXFDU7g2QAWy1/9HaQmu3Utsqe2kruCCZqJRZzFUCi+Mf6Y5pWwYwabjrAe+eZjdqCjwxlF1fYs1tpxS/zNe4WVPfMPI8fQslNMImwo+3n2DH73d3a9h4Bl0a7nckQ0g5m6N+IkLTjl8SQ04+lH+xPtgIU94TzTw2F7PRa/xr+dahbdEJXy3cyQqImbYqzGEt3J9KgpC01NhrNkLTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQtmspkb1aROd1Ubk666XgmYAjTNK3z/oh+kFf0qBqs=;
 b=Pz1QCVCA8enJiOk37k/2LLYhYNhgAeCRns12Xk9wLHdbD+nQOicRyd4xJy4n5xLQCdplphULJ53GlLkd8cGF2/N91jSsifZ+Gt8ZrA/rOn+KhTyeIffRBqn2ePnvSbynYcyhSoYjcPTXvQliVEihmSmh20yuc1LXL7ixpxt3zL6Ay18sF+gJbF8oeGO8svDINj4HdYU9iK+PkNbYrtTlTjf8mjxWBKQMXYF4xOxVXpPayFuH9I+L+fr8Y+7aIwowavEiGN639xW1/Fprm9LRtAckMAHFd057LBscxPCl0j+2qBNptH3nDyJ8aqFmZOKPZVKpa+fjmjkjoybFJy93VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQtmspkb1aROd1Ubk666XgmYAjTNK3z/oh+kFf0qBqs=;
 b=rj16lEwtw3yiptHySmsXJWusdsnXTYWYdrQGrEBHE/d3JGe9BySPGJM4erdshu/RE99r5dj84g1XGmMIy8/rFHrWxbqcdKXGmfW+X4vIe8m+u9ng+1vc7IgB//p+lPxA+V8bAHGLQKOEZGUMTKz+y3U3TSs1kPVpeuYs5iHlTDhJaic4vSjPrl+VYjrwhHtIPE3oxCt31pJaLn+AF/hIQUAEA6YA1hLEL5zDMtMCi9Dbde//Q9ej5XWiKrh0dmqs6lxg5HJrty/b3OYuP8Qz5HpRRqsWFWdrfSUT9nAh9IPOnZ/ATrR3mye0kAHDblUaioumnnooWbxNHSp5Xs5AgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 09:19:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 09:19:37 +0000
Date: Mon, 14 Apr 2025 18:28:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mike Tipton <quic_mdtipton@quicinc.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Skip SCMI devices that aren't used by the
 CPUs
Message-ID: <20250414102813.GB19563@nxa18884-linux>
References: <20250411212941.1275572-1-quic_mdtipton@quicinc.com>
 <20250414083832.GA19563@nxa18884-linux>
 <20250414-splendid-clam-of-democracy-dacf96@sudeepholla>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-splendid-clam-of-democracy-dacf96@sudeepholla>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 934be631-e7c9-4ec6-99e4-08dd7b357a18
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3WTy5am47lyMQ2frmVfrfdSnVzSr80PuMrxOUyNXiWZCSbCTJR38/E1+3+cB?=
 =?us-ascii?Q?asXr/cXIUTRxcUCaF8OCsGU1UWeKyUEFbAxAQ9rAZZv2VNB0BSXMu16IwEf8?=
 =?us-ascii?Q?IcKJ27qvpuxWxNLMhge4QasWLpewGS42yKWXXwVbQO1F6kZKD2TFDEUzjq5B?=
 =?us-ascii?Q?O9uyab1keA3n3g/+AyNwRsBiNyAMEbuMCk/4IA1MYmi5MfNVvk9DjPCTAQ5E?=
 =?us-ascii?Q?g5Fm7g2oSNPXeMYZZAJjm8tXSpI1LDcJZzQJ4XObFf0zXHHRHSawjoXB4Rd+?=
 =?us-ascii?Q?8DYH9X9psLQZw5l5KfB6tYtr0icLm0WYj7oAeQ6xrbTBpH2NWzAXdj245Hvt?=
 =?us-ascii?Q?MgaI6k3eQTd7NYOwvajZMS/x0fzWKoYjrymNUCnF+FE32hrUbwXfmffxTfIf?=
 =?us-ascii?Q?LhDRu6roIUBTFdZzQpxsZv36HPMFcEEh+qxiw7ruW0Ca1TocASs5MvEXdCJp?=
 =?us-ascii?Q?5vaHXQ+3xILKsCQtZ2b3MbNK/Djq6BRaPhu5lyWNBJc9LOw79e7rFhNQk7dL?=
 =?us-ascii?Q?GDYvYZSBbDpwmeJR2Rz0fJ/s7cq5mwei1BtJ9bijiUVIj+HvHYIc+ld/za+T?=
 =?us-ascii?Q?5frkcxSkgcuS3z1Z9yatY2A8opCOVrO3iTJxUj4xYmAYZYuaoec9dK9fBE+3?=
 =?us-ascii?Q?KTSI8fOsWK4+UJ7Q6VKvccCKCRsN//fp/bWeklluF1duEtHeRKTkMbwp+S0U?=
 =?us-ascii?Q?g8sqIBjDp1t1VDFpz80n/4ihYzH6A0ApGwiyuw/sgde0nS6J44HBw1oNXp8Z?=
 =?us-ascii?Q?hZVd3hUL3ksWMk0RA3FQK1n5yrBdM33nDNoONgSjWpVxlkUpXlywtbPKyFqo?=
 =?us-ascii?Q?dLnotf8DFBKUqTiNF/q42IXCP96RyNfCOYPEeTkeeTfanWpOK4YMKCOAvnP3?=
 =?us-ascii?Q?6KOoJ0VmcnP7Lj10g4bySSGgnbdT3DsR+LtEGykgsbSKIs+k33ecJVx0IgnS?=
 =?us-ascii?Q?BiZhTlTpiFgsgPJVMJN2dIDdgMfaz24wo7Wa/s9d+wlXt3KCGEexHKzkFwgc?=
 =?us-ascii?Q?TQYqNkP15fKXfEVKQMK8wuSVy+ue4yO30mLNBOG5bjlNZcYoH8HmKmSTWcAH?=
 =?us-ascii?Q?YRNzd2Xn8u4UGrmJAWOYwfikIqbEo5qajV9RHzCTqa4OHCeumbAu7t2IrZhx?=
 =?us-ascii?Q?qENQJTSNM1TIq7ZQMqejUIl1+Bns9Mf4ysqie3xQ4A0hhRFfUcWsKQC/xUgb?=
 =?us-ascii?Q?Tg71E+ZORXdFg2AGocsEcoo0yYCIKZQEQISQ9HFZbhZsfLVuAZZG99aeA7yu?=
 =?us-ascii?Q?x4492tPb00aGwX0sQk3RMbTLO/f4SORIMt6fszQUpjiFMDcPgEZj9XrmfA5F?=
 =?us-ascii?Q?csoQXMR7zJRi+b3yDMBqnVWTSI8qXTxFQ7UnhXnCYIn9j3NogF7EXGDq3p1m?=
 =?us-ascii?Q?RWz7b8U3lQCxRH7iPfHS8PjyewyBm6/KEMeWX6KSdPmH2IypvMbHAvBC+75i?=
 =?us-ascii?Q?ZtbourcBayz34m4y71KisGE+/GOpaHw4qqT2MxdUE8izIi93WxE4JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQMV68WnUuobs0zmFSkylyPyim4wdl0DfnaKrrt6KGjpLjTxleFPf203xTdm?=
 =?us-ascii?Q?tnUvv3TjWdhS15SrWqG71i9JTEnr/F48IFN2sHc/cCj3rx/aBRisoE7AhKIU?=
 =?us-ascii?Q?lFEbTQSowAFPbDsKlnMsw4alRw8BspCrWgOyVzE/2t0ikoVDCESu6KQcqwPj?=
 =?us-ascii?Q?usb0IwgOlPr/6rusvMGlOtWG2yc/yCTAYlM4l7msIqfzjcx6pKFcNxzL/9ze?=
 =?us-ascii?Q?rkll+lkrGU36dlTUcU1l4tN/Xt5jhJp0sz2ATPSjBdI4xyFnIycKv9j1Dft/?=
 =?us-ascii?Q?ghzUw+aIHAy0TgN9kjuvwj9sARAratQ6IwQrQdDoDT0vAS/L7orHV4Ep1Z/d?=
 =?us-ascii?Q?quVjxJVknDNR/a12Mecwy39NXSm2e9Qrld9Jc9YrtIHSdG+cpeZkxyRbU8j+?=
 =?us-ascii?Q?LYFxvpam+CiMo1ebBj8CFMXCauwbbAlKu8PSpSrGnCiVQo5Kuby1Eq+ElXDr?=
 =?us-ascii?Q?dItxQaIpbiVq7/DZzbwhEBR01x/lzzwh3UGeKyyxQE9bbqvJ2mMoBKvorXyg?=
 =?us-ascii?Q?9FmfrIalH1n9T99/HGRo21thgmVT6dEhAoZ3py6W9gw6YElK0MC2gU+DT0t3?=
 =?us-ascii?Q?cKB5/ziRDCxr97DBFGAHrX2T5UHaVIDkNtySzmsXGLpLarErLJl9oWhwap2W?=
 =?us-ascii?Q?TToW5uf5vyaj1V2YOBxr3LDhaLkV08oxW8x+9lv04kGiCTVHnb9MsRA4HsHH?=
 =?us-ascii?Q?gW8DMStrMYLoZLC6GJNKH/RIUIIlZE/zUiDVr8sXsrecUxMbKVM2O4psa4KA?=
 =?us-ascii?Q?z2Uqjiiy2bM5QBBGTOA3r6Mi+ctAZ2QtEimYIy3XMRlV0G89Oeut8ZevLxWk?=
 =?us-ascii?Q?Yw980D6xpZvog3k5B8ChwH70tdQU6jXceKjmfjsJhUMwidiKhRLvPZVBvmIy?=
 =?us-ascii?Q?qSQD1HC3tuZl6coOclCQsB2q61jr4sGSSUGI8t9I5axH4AYHUNa5MYh9LvV+?=
 =?us-ascii?Q?e1V7OSP70+31aVtJiTPfrbiaKJWqDwW15M+YgCrX5QrqdCqga6GsDzBrhQ+l?=
 =?us-ascii?Q?r7d4vnMGwKVvn+SwEpBxgDkNybZXZuzRh+zHhhC5DyWak6ybKAtePmJpZwp4?=
 =?us-ascii?Q?1G2Y1Xdf8+tiLH6rbRwAO+Ls9mAHnzZL+EoROr67lVCzGI4yhtoGcR2IzIve?=
 =?us-ascii?Q?CB4r+f3FtrtcY7cCTPGJyQl1G0bgi79KRybErUaJG0T9TUKqNyVsmKKgmj1o?=
 =?us-ascii?Q?WZNHvR9SEK2AiVGh365OwOBQVtSRmyVU5q5ztW9bWqDpL9sApi0T/RTqI9GN?=
 =?us-ascii?Q?GSV0TdDS1s8s0NgnKiruUYmKdM83XpfQoIF41aYFqw7I3/ijr6HwpOaaKvpv?=
 =?us-ascii?Q?oSdBosa+1YMeEU9HlFgBA/wBrBwtDThVQLOWuypuXhw32Sku9GNzpInBOd2O?=
 =?us-ascii?Q?GIkXBueBnQpHXLqkbazUYzbNB2qseuxzR46usDhpoG6+GWU69SEN2jRRMPzY?=
 =?us-ascii?Q?7ykQSgcPBRRiTQYUi2m4mvr88DjX68enL5K0wOiTdxpCVGqRXEHNwt7+wvPy?=
 =?us-ascii?Q?rCIlzMuZ8HWUCw6HQWDMZQC3XMFGdTlPDjqi51Ruo/k/iGP5VqBOgn8SmvWN?=
 =?us-ascii?Q?QH5ZPRICxbyKPwieiyne4K1GOgr0YiGuEE1P1QZk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934be631-e7c9-4ec6-99e4-08dd7b357a18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:19:37.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GP/UrloCVSSHx/nw3lHK0PmFyOB1VN1ip6/dzLQKqcLxAmhEKpRrcxBQ9lsQJnIcw2FDK7lwAUxfvpZgyqjcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786

Hi Sudeep,
On Mon, Apr 14, 2025 at 09:23:24AM +0100, Sudeep Holla wrote:
>Hi Peng,
>
>On Mon, Apr 14, 2025 at 04:38:32PM +0800, Peng Fan wrote:
>> Hi Mike,
>> On Fri, Apr 11, 2025 at 02:29:41PM -0700, Mike Tipton wrote:
>> >Currently, all SCMI devices with performance domains attempt to register
>> >a cpufreq driver,
>> 
>> The scmi cpufreq device is created based on entry
>> { SCMI_PROTOCOL_PERF, "cpufreq" },
>> 
>> So the scmi-cpufreq driver could only probe the upper single device.
>> 
>> How could the driver work with all SCMI devices with performance domains?
>> 
>
>IIUC, this is on a system with multiple SCMI servers/providers some of
>which don't deal with CPU performance domains at all.

Yeah. This sounds valid case.
CPU perf only needs to be managed by one server, the other server
also has performance domains that only for peripherals.

Thanks,
Peng

>
>-- 
>Regards,
>Sudeep

