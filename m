Return-Path: <linux-pm+bounces-25708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F7A9374C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20BC8E3DD4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315ED276025;
	Fri, 18 Apr 2025 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pM2voUJq"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8D27510B;
	Fri, 18 Apr 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979929; cv=fail; b=PkrCu+VviVH219QgIgUa+s5YJ4mQGQthC6IdXQQh41Zs6pNC9C4wXJewY3YEmxxZnQWEldu8Bv2X855IkVrfEwpvwoiBXIsh00P2Ono5BmhysZVgL+Vkyei5t2NW5/N9PcGb02ZmXO2ZoP+OL2ApBIfj6d2j9s/4mJQvUYpT1K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979929; c=relaxed/simple;
	bh=haTTeE0Nhos0Dg8RPD1CHVoVMSkFD0lSdoZz9ftvIXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=giH50LOjoODsGd95UYjxhe5mCZv/neMYrtcEIYnao62aRy4pZDQj+5QihDMAMs43hAG15tgk2OBKCUI6BeCirkxgwxSDxUuiUNmcVj1U+nyg0lsSrtASwxhxZl226qUnsvW6tVLAyyXCvIQbUK3Q7BAhSnFMy/pculIQiGr8xeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pM2voUJq; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNt2EkTlC4Bi0yNO3RjvHj2FN3GaGauk7BC8mRpX2jzUAm6Mp03xp3j8tX/l2XNEZVRAQ30+nveZ3kPeOQMTW43RsjL7QgGeh1VPiL9JP8EKr3plZt5xZUZMpnqGMo6ci2dNV++bB6SRVxHT7d9EFhXtfNDhbaPAcpj8AQOtayWd0t9nWox2q0AJm/IwUOuvVXoiNR6v4hxQnDPzGtteyMzPX1WWdQj72chZ0cGy55BinuOEO8ZwPYAMppSnwQZX+01d1XVKlR2eJFo1QeEzy+rMKcwi+5qjoZqO1t2L0UlRNc8hdPA0TXtKaM75TsJ+vfr3ZmJ2k0zbh6duHpfxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haTTeE0Nhos0Dg8RPD1CHVoVMSkFD0lSdoZz9ftvIXY=;
 b=IayFyDYQFM1MZU7suOWQ2hd4M5L8OSetGTdNAZfJZ3wosWL4ypB+MzFBmm4BqQeMi4IIg26hCKpcOIFzB0pUyBSTFhukPiicxj4IWSr8bZviVjXOcMkjeykdkvSNG8CShceO7kKp2p/yl7djgNKTjKbjgMWnZTwFRCpClmNJx/KX9zuMDeDMnjypxQevqEwEYiv+sJVXwvsPETyqruaihbh5llpsXEBsMEIgwPQE+UPmpWkSnBaCXclm1vSJdmsbXcWlIqHZBIsrp9qgJ2hATWW2Ck1XlVKfNGo3aa+ndJrdPecCc3TYPAXzf2K0tdR8rOMrbbudXVPf8ObUpnihIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haTTeE0Nhos0Dg8RPD1CHVoVMSkFD0lSdoZz9ftvIXY=;
 b=pM2voUJqwFFcXuBHX+rw4YoWI6cm0gPRtoECMZsY8P7BOW8Tf4EZrlEkt+jmgJzobRW7epUcBjDZ6ZT6sn+7JsMq7bLUqbPC2uZIlEsogTFQuvYTj8ZLXAaK3qRePLZFLy1P+waVikZHEeIPZKHVxXTr/G+NfjOoI79l5TlYP8I4cP0Fsr5wB+zJcf7Xahjyk9BEjCW4EyUhPPJ9e1OCVCCiLog2wxPadFrOdlWCr6UBTH2LB3mlxmpfpS1nbyPBo9ypc1IFvG97+v9LksOEXva7Z4k8GbQd1VqWSto5XPSWRom6AqIYK/DyloY+zYQ1dTrN6zzatbeRl23FW/QHRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 12:38:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 12:38:42 +0000
Date: Fri, 18 Apr 2025 21:47:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org, rafael@kernel.org, pavel@kernel.org,
	len.brown@intel.com, vincent.guittot@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Message-ID: <20250418134721.GA31933@nxa18884-linux>
References: <20250311083239.3336439-1-peng.fan@oss.nxp.com>
 <20250403094629.GA20718@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403094629.GA20718@nxa18884-linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ed54bc-3f4c-4d2d-6138-08dd7e75f3d7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zLzUD9n2kHvzirlRKf3vaK6uaeEs6civdgbxmQjx2PvT0LFRPHIa4nZfpijc?=
 =?us-ascii?Q?fs+3RuUs+KftgVkxZeVClZUVzRyUurzfAL5K5L8Z1busDW94avyO/DBa6WLF?=
 =?us-ascii?Q?3nOgI6qlt6CSncNXgLJcFCvt+kMLuk/Td8XHiAXDSRy8ApV1vjfANOrAOhZX?=
 =?us-ascii?Q?nQdWtWn7K1CwK4wWi02ng73H/BgZtf3F5CuzxYy+/DmKSgp8VP2bQohK70Xt?=
 =?us-ascii?Q?JP3+pMquLpfDXTaHiGcSEvy8WZ5RyA7t2X7J244L/tPhFbqHx8OxENFws6hu?=
 =?us-ascii?Q?SJjyZKdDXvUryr28rIaSyZYU96tZ0tkwV+jkWwpTtITr8bxb1krBIS1j1G+X?=
 =?us-ascii?Q?SU1Bjw+0F45XGll+VTWS8j4U+l93a24TD9tD3EuXIewC7d6Hgzd0R+tuygJU?=
 =?us-ascii?Q?R9wbTPdKhJkroMtRze3v4eBe+StyrLQkuuYn1GSNKsYdXbEHPumSwxOc3zBt?=
 =?us-ascii?Q?vMINoI9Tybm/TJbSNkYtukKqmtNP3AmrW6hDk0wd8//9D4LlQE3+cKtQDKWS?=
 =?us-ascii?Q?MBm4A9mqiPDAxlOfsVOZDch0JnNbUpbFZyiVRxSTEAvxDHOh08RixqTb5/9r?=
 =?us-ascii?Q?9Euh4ajXx2k02qXkJkdpX6ghPdbejwVOYLnv74K11sjq16d8IL5H8nctsYcY?=
 =?us-ascii?Q?J/KxqJxKk6CsPzOpjIH5k0ag8gaNAqIuqWCkU9rPSxRQKKpUVwnA5MWIDnE2?=
 =?us-ascii?Q?yGnMh2Yy7Au9sBRhgPJePke0l6zrZr3AviC6H1N+I3rFM4vfwpuKs5lT9pSJ?=
 =?us-ascii?Q?i7IHRByQ/IVCTchS4VdZjtPCIoWSprsxRXFRQuA5+9qmT4uXKnolEkQZ0xQn?=
 =?us-ascii?Q?2XQOpvxb0Z5mq+VOYXd7Zm9YSg6oByB2khUF8hPWLhnhA383VrZc/JVtvHde?=
 =?us-ascii?Q?Ukxjcvv38h/yoDRPRr/DVspacV3C7SKgHySNnI5Ax/ptq5YROi2r+iX7fvqT?=
 =?us-ascii?Q?ybkNwDogLrxwtoIPDqIyaA5uE88rvHnswqXbi+9BbtDlQ9CmgLdvspg7FLrT?=
 =?us-ascii?Q?QwrUt9arn6oIeO8jRqk0ITuy/Oxk1nIA/mIaGKsYV77gOIw68ToXrN4jkaQL?=
 =?us-ascii?Q?ZZPEVxjVUPAV/QxYcL6CmWL08I3RT31GuDUNaOAFl/xEiFDuwKDEi8ika+GI?=
 =?us-ascii?Q?O2dy0DK1OkKIpvWxIlquX7ICAkTnlSs3Iv4rSsBfXwAbvpXKjprtIgGV8O2K?=
 =?us-ascii?Q?EZIpSsfxD6ICbltRmrohyuz94QhYTOWtr1+/TKaxQlM6NYMbqdUJeSw/muYX?=
 =?us-ascii?Q?pbPYyeiwnkkL8jlkzkFv8eGFVwlO7c72SEBycniwDuUTJnIq1ny3faTh/YNa?=
 =?us-ascii?Q?HD8JurbBil59wu2uc0vbRzcbv3bRwTK3Qh3yUYl1ldstdQRkRxtIuBnEHQhK?=
 =?us-ascii?Q?wBONDRNOwWHDXmYaSa+Xeylkxexu0f0g32t/DQeEYBfmBO0AQmonK0/pYb1L?=
 =?us-ascii?Q?kJGvzFPrvd/a1zsERXQzDAvLh3MpHV0Ze+3s0b/wCBzfe16en5ShIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJbwj7qaGswBuDP++ogdApJp4YI86wHhVlocaWlmLFtrDDG30/w4S7L/sJ5b?=
 =?us-ascii?Q?vXePV2rjfrlS3/024MJYVq1wqwMfFfD1f97WoBOBixjpKUMnB2h0DogMkR7H?=
 =?us-ascii?Q?QhFyDEis2adBT5tNgXhlKpsKYRqRN87S9ZVloXTjVgL3gUk7+Ees0VmLHtzA?=
 =?us-ascii?Q?dSb1RpJXly8YCBwhxLxJiUWNPQ4nvEJU+NLcNiRVJ4NJwEBECuAtLn+0TUkC?=
 =?us-ascii?Q?iMatyb2ArKAVYs4ywwxmMuClsHKAj10neseW29uvzjM0RTMIWkPPcns4Ou6R?=
 =?us-ascii?Q?DB1hO2l0x/1qRkNv2osMfWYFSua/bKojuwSaAzihD8PMu/DpFK3SYKCSJTDY?=
 =?us-ascii?Q?dQcyovGDo3BvnQY3iMwHALdWcBMTilMwpI/T6nHqn4vfjH8/uM53LV34bEGc?=
 =?us-ascii?Q?o54INbyv3uMLBnExuZwanPwMYktnvytJb9PxFWymcR8T4qEhuEMzuZxmMY4n?=
 =?us-ascii?Q?GM7NZH7PFnBt7udnOjOuCq1smIES7HFk0jejIZwCGQgpo188SB3xah1yNlX9?=
 =?us-ascii?Q?yjtuBgImqLmR5gCphh6qpzsTjiiJAo3nVzNtjrlj3a8gFisHwq9+ANG43fd7?=
 =?us-ascii?Q?gHpPcIqGf2JVrkpEJhdbT5+n6LsoTJoCPHwTNRwyuQ/w9bH81Dbvw1YvxduA?=
 =?us-ascii?Q?Tmn4B4WpGNQKlSpxNuYEns0KxWKY/DlPQWhQXaIF4zGi3uZorI4ogkyFpm4o?=
 =?us-ascii?Q?il94sdZ9c9wp9FqWdtZ6M+p3u56vNQddsxZ7OmtUFF3hGZgtKB6kpmrtpzPN?=
 =?us-ascii?Q?5YDYbzHzni8D5LzCMgC93TS7C26iHiA6CCiMqdbu7gvH/TVm7FHVApXaXw7S?=
 =?us-ascii?Q?sGsCq/ILo3ZwO6Gz8EnNeXVGubS+nT6CJVwf0p6ZxzFPHWaOx+aaYNXqutRG?=
 =?us-ascii?Q?MKPUX7zlwu6e0HEZl7/hwQxQllydV6vYjlb990y7/AKLphLTsqZP17xuIguI?=
 =?us-ascii?Q?39L0THHrdVCISnfFRxzPLa9JNTsxOstRSpXZkYUsYktw5CDa+2rqTAKbBlHJ?=
 =?us-ascii?Q?q0kjh4ltznR+QjnMkiJfawGfRKIXj/gJEG2WA8u4/3rcvqvUt2Cj20kvdJUx?=
 =?us-ascii?Q?zpxqtDk51I1QtqdJ9a8PGjTyqQxVkWLTd93Y5IbfXz9NHAQ62VLnVctClxUP?=
 =?us-ascii?Q?62cpvaEgLGJDv5jeywfCSIUqZ6gjvq222vShtYX3GtsSZdsFbr+MCQPF06SY?=
 =?us-ascii?Q?KVhk3n6+i7VV9jIvlZ50pr3+X990WZAbsZxfV9f+y98vlufxn0nBjxKRirB5?=
 =?us-ascii?Q?u04cQOzyXY1t7IFIjTpLmRlFAbZruoVy7CYQYviPGot2PG6Mz6ix3RvhGp3S?=
 =?us-ascii?Q?EtO+T1p0uoaBuyQHcdpww8R5y/ZQCOpkldWXOQv88EpDsBxgtK0xqf193iRY?=
 =?us-ascii?Q?jifRpAbE02Sv+QDkdFEUlfey8OnC6/kI2OZpY7AjPqv2KzFzeEmgj3qzFty9?=
 =?us-ascii?Q?Sqg5BRgQN2fRJkMkvw3o6jpTpovtLNnTilsPtSUJjdBGau5cuE+HFShnx8sO?=
 =?us-ascii?Q?UZlrbLiS9Y3Beb5hefIPCCWV3VKSMW/Lb3WzqaoNX5E8+N8QCyTP3/7wDHwZ?=
 =?us-ascii?Q?Waqi9zSF5GAbqvgycEDSS+ft31EwHXsvpDMKLIFY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ed54bc-3f4c-4d2d-6138-08dd7e75f3d7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 12:38:42.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KV9wiF2+JDqDELQ3etFllpOkjp0lKzziKkco1Btdt81yIyiGMh+fJn0VleCjGfNT5VzD0WsWpWrM9bJagQY80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

Ping..

On Thu, Apr 03, 2025 at 05:46:29PM +0800, Peng Fan wrote:
>Hi Ulf,
>
>On Tue, Mar 11, 2025 at 04:32:39PM +0800, Peng Fan (OSS) wrote:
>>From: Peng Fan <peng.fan@nxp.com>
>>
>>For some cases, a device could still wakeup the system even if its power
>>domain is in off state, because the device's wakeup hardware logic is
>>in an always-on domain.
>>
>>To support this case, introduce device_set/get_out_band_wakeup() to
>>allow device drivers to control the behaviour in genpd for a device
>>that is attached to it.
>
>Do you have any comments on this patch?
>
>Thanks,
>Peng
>

Thanks,
Peng

