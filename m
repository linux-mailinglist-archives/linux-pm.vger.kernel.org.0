Return-Path: <linux-pm+bounces-2700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD383B592
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 00:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75609286906
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5DF136655;
	Wed, 24 Jan 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="YWAScaOs"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727B7A714;
	Wed, 24 Jan 2024 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138804; cv=fail; b=KgV3TZj7pl2hq+JlVteanfKhp/KARydukqxn6+5Dh4/jZB7JTfDC+jsVTYjXe6bREvVaTajRIgxuA6kZO18S8fEBroTh+ssX7foYT017d0lNrKwoj0ybV09e+qkhAZ9vs5a0sZC++oHCWMlB8HNiRBbCC4vF1R96SW7BRdZof8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138804; c=relaxed/simple;
	bh=RGkLBKBSVgaJGirb9l7USebBJ7LUUGmVeTj2fd5N0PQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=sKZJoCRgo3nhUKHVKIUK12M+9ZYtSwiY8GX8IqTQkda3ra+F1qXMKdRXdfj5ykip62PsUlzElBNKp3x90ELT/5vR8oPFZNsb0F1D9uKtbBoat+pHN+tRamDQVWql43Dyd+jS8bPaqz2rP1YNh88B95kV4aHEFQsveYlS/a9bQ3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=YWAScaOs; arc=fail smtp.client-ip=40.107.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMnEXvHkg6q3/BsS5y8AZjRQk5hz6oCY2gi3RwnSKF7rcNOBoSA+4er3sipNlPsyLP5yf/lTUoT0/HVSnuXCQZrcxCFn9QMFNyjN/hxP6ADcFAQ8bBQU3+x9vJ8jqssyMq7b7d/cvH4d5r0B8imPkCZ73UfNuJpNjrtLM4p7+RSdZ8hZTpz4spDshQQtxzKbmv7jCP30jpJqXXSbbPn431UXhlzthVEpevF6WTP6vgfj1/G1VI5MNzrmKBv6MB31NlAFaLJpIdPM3VG9G8OiZnxQYEfwwldxgP9jBsIVa3+1vNriNF6m0gjB85WNHiCemfQHpYpvF4QrhiTIfeQowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNnGKzwwDwoO3XvRjbUjWHYy77X9VE+eikClYfTOubk=;
 b=W+mWvoXMR9eH+q/8pkjvIjP3qkIypvVmw6wBP2+dbS02aXNtcz3sJvzbdk8p+n1I5mFD7hvW1CG2pVyBjSKU4vnlRbL7cpkl0SkrQFcKiFdYldAB8NE8gDwWmydTgD2Mh66WXiV3CZxIKWU6z+a56r4Xobl/oHUFOv8uGJECPV6T935ATw3vRbBu75Dj/+FfRiL4YCXJb1ikT9USnTd35zya96vXRFlbo4yEpcIHerEwJWKEpeg0mXvmdEzNI2al9qi5yopT0pzND3zuwclVM4luA50FOHPgchW99zH+8/L5zG6ektzKOnGF95EcPsaZRKSE6a1+LSQ3iLA5S2Wsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNnGKzwwDwoO3XvRjbUjWHYy77X9VE+eikClYfTOubk=;
 b=YWAScaOszu2VmbUMW+12VlKskgcn6OWlUD0RXLUDY/8bSSTor+ko+v0jbikpSRcyvDGBEnZoNdkCvj8Gw2e9iGC6F9FTe2u+FTGgmGSxxvgQSXPs9+VJ7/LKPBXoRYq4/bjBxORNRn1+vcJardNBmlZvNqcINTRsJ3dhhj7ux40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB6072.jpnprd01.prod.outlook.com
 (2603:1096:604:d8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.14; Wed, 24 Jan
 2024 23:26:37 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::ce8:8f5e:99a0:aba4]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::ce8:8f5e:99a0:aba4%2]) with mapi id 15.20.7249.013; Wed, 24 Jan 2024
 23:26:35 +0000
Message-ID: <87a5ouz525.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pmdomain: renesas: sort each SoC on Kconfig
In-Reply-To: <CAMuHMdXMDXK9uXMkj48J1sbk4LCH+rjPKjfvGvNOrscS0ywpFg@mail.gmail.com>
References: <87sf2no5xo.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXMDXK9uXMkj48J1sbk4LCH+rjPKjfvGvNOrscS0ywpFg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=ISO-2022-JP
Date: Wed, 24 Jan 2024 23:26:34 +0000
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: cf094e9c-0ce7-487f-2f4e-08dc1d33e7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XlWj7kWUCxeZyoN8QasnNcammVpr6TV2UkBQDEGmm5UsWzdgFjMnImVjUbetY45hJAPEJQLykRYyMh8Z4bPwFrSyb6pZbpLzq2RlitS/AEGexjmoPy6SoTXhrHJPNVA9DMh11rkhY/cuq1dUC9e4ED1/sCm5Gfx2zm3OKWw9nUDRqzMKLsL/vEzgWINd4vORpP9NZ3a9iKPoT5S66KS1TePG8sajBFylaFb7xP8eeMSe924cf5NFM0W6zKeezvdaz9JKg/sN1+k8AQO+YTW6yZXeBwsj6RWE4MnWHTburik8xHzDHrhUmvp7baubrt+r9Hb1dtaOpcYG/d8K7/CHkcY3eJ0S7u5kDzd0hZghetFdmIGhE88Ku1AlYibCzqSyK/8rAiukd6KHtI0bGSKx/uQpxsonSShsWKEh66Rm6/3knXl0VZTZj0/F4aAXVi25RZhBFIqNeNEIOrM0sxEWXUZ3HjMSREDieigmlU+4SilPXiJB4yLqjSnQm7R71zNcHwdsuBStJ1GjBfEte6e77v1yE7IsZr7YGz9N98x74OAstMeWSfHhptZrGXtk190lKPApDLuk2Lhr/Mw9o1diMsbt2gel7lA9+dQcK/mtnw0zUXdgVHqE1VRnfroPcD0C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(26005)(36756003)(38350700005)(478600001)(6506007)(2616005)(83380400001)(38100700002)(52116002)(6512007)(6486002)(4744005)(5660300002)(86362001)(6916009)(66476007)(66556008)(66946007)(2906002)(316002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-2022-jp?B?YU9aVTJ2YndiRkJWWFRySnFKWCs3VTNHZEMwNVpWM1dqUjEyODlDZFlG?=
 =?iso-2022-jp?B?NGZoMUJseVIzMjBtMzUwbGt6UExReVA4SExRQlNGVXRUSUUza25DZmhY?=
 =?iso-2022-jp?B?N3F5NGtFWklhK3pwUVZ4RTRmSndXeU1mYUtqTGx2YVBBenFmaGlaZlFT?=
 =?iso-2022-jp?B?OW43RDJKc1AwM1pLYjZkK3pYSmE0WmtxQ2doK0lPREEveDJ0bzBSZWNv?=
 =?iso-2022-jp?B?eU1JVFFDTCtYYTN1RWlhU1NhTFgwamNnc29rZTVNRmFWVjc1bEpsMFlo?=
 =?iso-2022-jp?B?QXE1eng2TlhrVHpBK0YydUZUQUtSU2cxOXlncCtjMDc1YjlSRFYxZnE2?=
 =?iso-2022-jp?B?cXhqSi9uQlZMQnlXMjFRVG5CUGN3N0I4aWtBVkY3ZHZVUXpBWkZLMGFj?=
 =?iso-2022-jp?B?RUlsUDF3N1ZjdFNwaHh5bFpKanhHQm5QM3A0TUdyYzdsaVphQnhBdHp6?=
 =?iso-2022-jp?B?dzNyaXVJeU41OHpCNUpIQXlEc1BZckY1aTk0T3NKMHhSMkJkUlVHUzBQ?=
 =?iso-2022-jp?B?cFp1c2FLeVJCeDBFcjErSVJaYXVKWlExa3BCV2RWT2FSby9oZElGc0lH?=
 =?iso-2022-jp?B?MkdWaVFUdmlvdjRnL1ZaVGR6UmM3UHhRbVVnaVJSS3F1ZzZ6ZG5McGhh?=
 =?iso-2022-jp?B?QWZ5NTFCWFRFbEVkYlRRdXNFUjl0Zm5RWmwvOG5ITTg0eEkrbWM1eW1S?=
 =?iso-2022-jp?B?VVZqYlNwYTBycU11NERxNU51ME5MMTdnK3ByQVB0dXQzUkYzcTRRNnVh?=
 =?iso-2022-jp?B?L1VOTEFJb2JCaHpJeDJDRGtRWjZlNFZoRGJpNkJJSUFOSDNMKzlUNEV2?=
 =?iso-2022-jp?B?azBjK1ZIZERYQXA3RjROcTFnR24wZVdyY28rWU9obWlaS1FUWjIrYzh6?=
 =?iso-2022-jp?B?OWx5OUNKUnAwTjY1by9vcUhib1lMNU1xZ2N1NDRsN0QzUG4vWW9wSURY?=
 =?iso-2022-jp?B?UmQwc0xTNFN2ZStIYmVXSzdRNWVFdTFRSE1IbVM5VFUzZlgwV1dWdC9J?=
 =?iso-2022-jp?B?MUUvNmRTU21IeWtYZEM3aVlCZWFwWU1vSlQ5MWNBbitWcnd6SHdRd0dU?=
 =?iso-2022-jp?B?RTdHb0JRNGFrMWFaL3BUYmFsWXdZWjhRVFd5SjRjcDlucW85Q2c0bENw?=
 =?iso-2022-jp?B?N013UFhOd1lzWWdhbzNkWWZnZUE5SWd0SVVyd0paMWNlSzFCN3UwbnVP?=
 =?iso-2022-jp?B?Unp4aUVGT2xYNGVQamZpUnc5VWQ2TElMSCt1cS8zMlF1bXZULzJGcXdS?=
 =?iso-2022-jp?B?MHpRR3NnTHA0VS9uSWRaaVZSQWMzeWhZcFZRaEtiaVV5YWZmM3VlS0c2?=
 =?iso-2022-jp?B?eGMreDhqQ3l6QWo4UjJPUTlKRlV0RndINjdlS0Z0ZDVXUFBMUjhlL0hi?=
 =?iso-2022-jp?B?OWdiaGd3K2xrMnc2U001WXBES1NqWmdSeHdiSFdhV2c4OEpNT1gyTGc1?=
 =?iso-2022-jp?B?NUdyMjJ5OFR2ck9uUm5POVM1dzZsYVF1ekp6ZjEreFA4TVlkdlFJN2Yv?=
 =?iso-2022-jp?B?ZnNKaUVXVTBnb2laRjRIeHdOdUNzWERoQVpnd08vQkdCd0k5UFcrMmlj?=
 =?iso-2022-jp?B?Mkp2aE5RZWxVVkc1cXY1ckJ4Z0c3MnBQZmVEMC9CdjROWCtwdzlucDha?=
 =?iso-2022-jp?B?RXlBWkZFL3EvaktaazY2VmRQKzczRjdDSHY0SkZPanpxakJTR3lEZGJx?=
 =?iso-2022-jp?B?c3lxNHZybHlhRHNlUEpjWUdhc3JQdjRzQ3l6MkJDMlZmeEJTVHova3RJ?=
 =?iso-2022-jp?B?NU94eFlLSjk2LzdhY01xbnhudVFxS0wvZm14UHBDTUxhR0JzVjJpL3FM?=
 =?iso-2022-jp?B?VUI5ekJsSE5XOUZlYmFDQ05rM3ExQWxlMzJJeElaOFEwV0QwUTA1YWx0?=
 =?iso-2022-jp?B?bTY2L1FEam9lMldXanBXTG5lMUFJMW5uaHZqakVQUGZHdGc3aWdNKzdl?=
 =?iso-2022-jp?B?QjJSRjVTbkc4dnNRcmxwR2JjRjNvaFlza3RtTWxFa0s3TU1qRU9vYWZa?=
 =?iso-2022-jp?B?NzV4VGZmdmVVVnVsRTdML3l1ZC91Nlp4WEJzT0JFUlpwaGpmdDhkcnB6?=
 =?iso-2022-jp?B?a2NzcTNUTXQ2elBvNytoN0FuSW5ybkFvdStVT1oxQ2dEenJBcmJQclNZ?=
 =?iso-2022-jp?B?amI4eGlIVk85OTNNSzBsMGZyeUVDV3pGQUVpTnFDOTRpZzdnakZ1endx?=
 =?iso-2022-jp?B?R0J6NG9NRzdpSlJPYWVWekE4eHQvN1ZtRWh3akZWZnB3QUQwZWh2NEo2?=
 =?iso-2022-jp?B?eml5WWdiL3pZUHphSGtydHNGY2hPbVJWdjhvdGhrN3hrbGRHUkhKUVli?=
 =?iso-2022-jp?B?MkxiN05aWlpxbjFNQlVyYmZFNTcyeDhXVElQUk4xSE1tTERuaHRvNGNu?=
 =?iso-2022-jp?B?S2hkQ3M9?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf094e9c-0ce7-487f-2f4e-08dc1d33e7dd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 23:26:35.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEUWGiEa2XKqtZFwXQGo07ysRZWmE9/aPa2ntPXmDPcPYCZvL99zm4QK3CDGLj4GjRgGRriILIhcHgLvUalefHUE35/NuOEyAQWXIfrX0/xDJHE//zgnmBLu5Ntsiwkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6072


Hi Geert

> > Renesas has many SoCs and it has generation/series/model number,
> > but these are listed randomly in Kconfig. This patch tidyup it.
> 
> They are not listed randomly, but sorted alphabetically by description,
> cfr. your commit 6d5aded8d57fc032 ("soc: renesas: Sort driver
> description title").  Have you changed your mind?

Ah..
${LINUX}/drivers/pmdomain/renesas/Kconfig was copied from
${LINUX}/drivers/soc/renesas/Kconfig.

Indeed it was alphabetically sorted, I didn't notice about it.

> “A wise man changes his mind sometimes, but a fool never." ;-)

"A wise man never forget his work, but a fool easy forget"

Thank you for your help !!

Best regards
---
Renesas Electronics
Ph.D. Kuninori Morimoto

