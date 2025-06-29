Return-Path: <linux-pm+bounces-29809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D83AED1C3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 01:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578ED1646F9
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00791E51F1;
	Sun, 29 Jun 2025 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DoNF4AL3"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010046.outbound.protection.outlook.com [52.101.229.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA181B0F05;
	Sun, 29 Jun 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751239072; cv=fail; b=Bz9TXconnqGBwg7iHupXMOyO6hSZjML4fsaVhzmOMRaQNnGheYPqL0UhvDQ9Nb+djYX+Nb5UPA3Ix6baDX+fuZsxmBhQiXNP7NeAbA0WjXFzoIU3fKZJtxYHp5rFEALn8qFQVcr7jQfEUY21DQHf3eUipZC9DiNprV71LuIvpdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751239072; c=relaxed/simple;
	bh=pkUDZcRMpFmi6xwK4XJBU196bLsP5iWBbWN1ko8C9X8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UXbfkyvPWL1TgpYjEbrD2siYIXjCi6El7H05hGGH4P4zq+R9Za46F4JbXpBblmR7rrO1/qxNv3v8NbNUjj9U3eBnfJ/4tZwc08q/7UP0926kTdtWjs7GWThtpdughUhSxpq+gp0gUk/MTGsYcixP53piLh+3lz+r5J/w/accXeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DoNF4AL3; arc=fail smtp.client-ip=52.101.229.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u32pVEMcQdz5cF+HIFA1U/DDr9FF1omnq2EbhNfaGe6/Jj159joIdxjAe6IbvRWAZInWy3b9Yi+jar9FEoNk0of5D2R2KvUXxBzPWbg2A1vSobpP3RtIzlZSyVN9MiiGU70sDlUnwvXwHzDNFCiqTdMqEZNsLH4o8acR6WM8EXrytp8ScYDYASxTjZrfYm1a+PeAnqGKZ14Z62FumuF5xSiZN0ERIynRAO0AZb1fFvf8QFcejH6pIoZl2djAJIEHW8UJhGNfA+cS38xLTNyQmg3NyedLvpVMnqzUW6HqzpMuasZOCuLpLS6SBJJ3OfK8lhVPWXhpWRi2S24ndRnejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkUDZcRMpFmi6xwK4XJBU196bLsP5iWBbWN1ko8C9X8=;
 b=Fg0KYSfVfy8m0Ta/IRRl0FxURIvdLO11MVWiNvfRJqWBAsZWqP1xNrVYut5ek+sPyA1VJyC0CD463H+Apb4FEDVjAprW8k0rogu7/SdX4I25gSrADj+F++7VRy2qjzUhyX3aL13Les6Ufm4rku5rc5pKvYEH0BKZtJu3jhfM6Gft/LInaSgGwiJgrRyATj0yhgSxcxnzalEdwI1Qlt2/Fl2OJg0bgAitvS1g0ur1YpU0ZyqCNwbLcFvaS2XkImDfnrQBL5XlfGd9/B29OR4DTnC0tqvNPOfTGOwu+gPQzyYiXgKLpFjJmJKkKJQ3grDQ4BTP9/AU7CQr6PxhWZcioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkUDZcRMpFmi6xwK4XJBU196bLsP5iWBbWN1ko8C9X8=;
 b=DoNF4AL3RYi5w/HFy1dSymYdHuq2rZuiS6yyhW6XGb/iutofAwQF63s1hxhcIiAHANKgIWOXWhlWJVbnx9S5rLMMn2ZNSiWSoF1RxLcn2AGYQaw+ZZWP2TBxuzX6uKkS0raWKdIxv9QuEqqAAuqfwVHTqbw408LIfcbBrxNZWLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB5661.jpnprd01.prod.outlook.com
 (2603:1096:400:b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Sun, 29 Jun
 2025 23:17:47 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Sun, 29 Jun 2025
 23:17:47 +0000
Message-ID: <87a55qgmsl.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain: renesas: use menu for Renesas
In-Reply-To: <CAMuHMdUMd9OThTQz0NYF=_vX77nJcHNiLY5e7WHjoE89J+uhFw@mail.gmail.com>
References: <875xghhk2y.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUMd9OThTQz0NYF=_vX77nJcHNiLY5e7WHjoE89J+uhFw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 29 Jun 2025 23:17:47 +0000
X-ClientProxiedBy: TYCPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:4::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 657a8256-4a16-41bd-ecdf-08ddb76328e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tl+ISdMtLQIPeTE53+1MZtH+W0yf7N9FkemLKRm6Wa3gHhsE0rKwdjR2KqC+?=
 =?us-ascii?Q?1m5goafPXdsARaUIpiXdEmpcLY1mrI8egUz6+HFCnW4f2kq3Iz7T+TljNcBR?=
 =?us-ascii?Q?wY4Izo7GaR7lrhnJZKTN1PHBvcuwEaEOtf3XcnbG2lEhUDoqIjN05bbcv28u?=
 =?us-ascii?Q?iBpK3iiLZNZhCni7zx22K3puAhMtmVpHdQ9D2yXeBc3g9EreKBaoaluZoCfR?=
 =?us-ascii?Q?/XCuXaMp6GqUGJOc1GuZQCuKcyLvug5b5zRiJJ05/jnZnzChWzBQIiNNXUF2?=
 =?us-ascii?Q?tP7rOokXXrGnkHBrZIUVCxHXLwuMwcc2sgPHiQ7j3sn52CnHzgw4eHBi5tNo?=
 =?us-ascii?Q?lwK/qafSzE9lYpRpH6/olfCqxaio4ERqo3ey5QVhVOhlqgsOXUw/qPje6tjh?=
 =?us-ascii?Q?spXBXRX80Zka0uv6ju6yi8Nhaym4n1ZTh2zN4S3Mcc6kVgKBbNj0nZTQxRuU?=
 =?us-ascii?Q?3NLsK745VYO7ErPsGPuNX01zEXpyeXHIXjikzUeBvznaFyLDgCOlaSQGZsf3?=
 =?us-ascii?Q?IQ5SERwciRXgdZMQWbkPgwAGLbz/B9SPPA70r33upz7vj4xAlem7dre7Vw5e?=
 =?us-ascii?Q?A8a0LApWbcC5pIxaCCvY5LmhsFwMDKQpqbcVyi4+oV1JUUaKN9EMEVVM2j7C?=
 =?us-ascii?Q?9E2CrnkjF3sZIbg0dramsfKKYRjqgRyQi1soAjJOEDvQE9MuKK93wRsdIcc5?=
 =?us-ascii?Q?F1LV0SSgeA1IKRXV/xgGmanFzUkv8AEcfldlco/GeBJWpU+nxhaeSRg9E6GT?=
 =?us-ascii?Q?ZcyTCYRlR7kYupJveBqMEshTvtnLwLeDHsKPLbK9o9U8e4u61ZRRJT/IwlOI?=
 =?us-ascii?Q?+9VLCO/aCUJ1biM641ntYOb27A/EA1v3KtcyeEPTlguA2ve0NqcukyyP4q8J?=
 =?us-ascii?Q?MT00gMvIZOmU+yF4j1itGHMpyIL4QGnDSq6/saKMcG7J87CRjVFNnrmLcW3w?=
 =?us-ascii?Q?ZFuXkQm7JcL4FboXqH550MvDzLxoHGIED+BPuaGpRxg2usntr87hrgr+V8Vv?=
 =?us-ascii?Q?LDSLqigt9hDe5vxkFgfwLqGhi+QmvRFG5ZiBtzyrU53cB64OSybtiwYqILSG?=
 =?us-ascii?Q?fl7ItuKx4iQLnUt8jcOZdjD52Vg0mRH5qEEgvjjB4+0x6NiMCTM6nGnT350G?=
 =?us-ascii?Q?n2xp+tBdavRwa4S1FkHdapgFUWwDOx8OM6LzmNNYVsNbBv3mhBvk7PyXP/lQ?=
 =?us-ascii?Q?JobpwROa3/v7CoQytUmyv8n4g+wkupUOTCHjqECNyEYHs1drvlqH0gQKRPnC?=
 =?us-ascii?Q?g1J8ZlIseNNUxVIrY4koVOOpHjWNyHtrncfElyM6Nz7YbOUQW7ZRH9uh/C41?=
 =?us-ascii?Q?Z2Cc+OqliCj0/Ox7yOzMAJBd1a0TI3QO0e+uSoylvFxnIGZ6O7/44d+L7mIN?=
 =?us-ascii?Q?+l6/ejhc1lWSF+ElA9NRqw2etjt8Gx4ZSPjntO/a82BPzmyS9R2/vTfctK5J?=
 =?us-ascii?Q?rseAmqykW1fUnEFdNjf4jmCCuyo0pPgIu6CVT0oIb10KvA7mEKWPEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+BYqS/fsD4FXzonh1tbzq/1kcrJEcttFuSZGdpMWQ+l9zVf5cCb7vwRRJX9?=
 =?us-ascii?Q?b4LtdXxrAMKc72liWgaFZXrVkFfVvadrH9BlxBSC2Q5tqpd0NGv8gbh4RbhK?=
 =?us-ascii?Q?CDe4A3QV34vhl1848W2sig8j3kJBq4sdcXgS0aAiUSCt2+GSl+8OktE9xkGH?=
 =?us-ascii?Q?Ks91h11FtqIGLzGAu0D9vuC3gHIbebo1ZR/d/BfMcONLI67/psQKn4WYjmXV?=
 =?us-ascii?Q?a+H0iUq/9M8v44CWyljNI01w4W5WLCIIXdpn4+lA/M0c8Ga+Ka4dJbWBhom1?=
 =?us-ascii?Q?RNrrhPb9lLdamOvLmzge+GRnszbyJos+3vBbDSLnTH84wdjDweiB+jTjsO2p?=
 =?us-ascii?Q?l3UrRb9mpUAF0LmFeZvwPwcSY3Lv6hAlDQaNR47OkUjMMSuBeVlhmh6a5B9+?=
 =?us-ascii?Q?y8Yftc9yQ1uEX8NDmtJW1+g6UsUA6++gH/xQ+gcSJtTHSIvV1T1+kYbKbZ38?=
 =?us-ascii?Q?/JJHv4cjcdhNaso4boRWea/AhZ4l8CD2y5cGS+QcFDkEY8jGjtf4K7s2Ouan?=
 =?us-ascii?Q?BRzcbfGzg3HOxI9SNAmLntIdz+eGKBOZbs1BOcYeyo0CeuCvh0UToDk/pG9o?=
 =?us-ascii?Q?9XBXGNrsLVAtsm+LvcT/xRYhljFdSdS5+SgzTDoYgMrqF/S58ThKGEOWSGJc?=
 =?us-ascii?Q?p68C4yc6DJcv9O2N7Uxb+YDcCBQgjHYMYwu6jGSkqI14aax4KOcq1ZBXhauZ?=
 =?us-ascii?Q?8Rg4YYnMZJTtJXxVF9jNVq3tq1dZ+h1Rdelj4I2rHL6nboKyW6ELI8cHGw0o?=
 =?us-ascii?Q?TYtvf3CDhil/OiR6mn5izJLqPqAAXBife922Vf4rDwogDLlJNAWwEshEA1p/?=
 =?us-ascii?Q?ZazyAOYZ2p4eStU1sMBIHgRl5ipzzeQjLRUobHEH836goKkZDqlakAwJqgEb?=
 =?us-ascii?Q?D+jpth/jpWZCEcSmlX7dMoyeaAT/K75KHvZiq8x05oLE2ExZ8Z4ARAYXU3rr?=
 =?us-ascii?Q?d+f2PrWd1v/vcAUgsyqC+/qQKa9K6UkeDv0e4gayfDqkjyDvddIGjmDqrdnN?=
 =?us-ascii?Q?tYdaiWbHDccxNeDJ57y7pZUb7hxRJa6DAWQbeZHKvU4AgZDJ/mCyM+gbWf7m?=
 =?us-ascii?Q?omMGFXPnbzI6Hv7FisRVhgMEdVnEwnSaUp4a4a+YToZqzeWGfRRn4zloR9l3?=
 =?us-ascii?Q?Qgpbu2JhKKSAmIHll3EUAZbHeGGeaiNK/Th4lxAo3BTwz3G6qhpNsdN5kT9X?=
 =?us-ascii?Q?6VJvbcNMaiYqsxXQpY+75/bGReiHlFKKSH1QKbHNa44cVAz/9jDORX2NhK+F?=
 =?us-ascii?Q?EDLwnQhTxNkn3AA48PI3+VOPcirxcohegl0lT5K/WjbYsUtHoAE9d00w5Xqn?=
 =?us-ascii?Q?a2lUy6fovdPOtO3sqHGfaaacll+vvndtSSkg9bsRjotdZMq0Is1ka+q30r7E?=
 =?us-ascii?Q?xNiSc12rk9qd7/oUAhmxPnlm4WDwAKjeM3ewIGQWFx6DzHwf5+IIVJeA276A?=
 =?us-ascii?Q?vc1qEefWNyhtPyoHAZ8TwokkRkvoFOqSHWz7pae7dlq+dlzVyXBBTMXNWlZ4?=
 =?us-ascii?Q?rIbQ/ZZ0TjJPeZ+Ovf2Pj1JFhxkLdGmntwCPq5Pec3py+3EuJUQEKFOTZ4rV?=
 =?us-ascii?Q?AO05UnW/jQO0GbD1tmyxpglj/AZ75I5nXRz0PAQRuOntC3RD12ZSpol+mN4x?=
 =?us-ascii?Q?5OJUYSoLRUn0VLbUQ7qcgfQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a8256-4a16-41bd-ecdf-08ddb76328e4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 23:17:47.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MM5WNNcEHMLpT8wo0w/7WDi2qCIoBYrGgt+h4uupcsjpfN/dud/WWpeJyBpHJI4d0fTGanfQSZSMdwMg6bQd1IKrqs5BKVCoW2QL7IEZy06JCp+EO8TCFJtTqDL6h860
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5661


Hi Geert

> Thanks for your patch series!
> Unfortunately something must have gone wrong, as I only received
> the first patch? The second patch is also missing on lore.

Oops ? Thank you for reporting it.
Will post soon.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

