Return-Path: <linux-pm+bounces-13419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52529969DC6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D5A1C212D9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15791DAC47;
	Tue,  3 Sep 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ryWwZyiu"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011071.outbound.protection.outlook.com [52.101.125.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62081DA0EE;
	Tue,  3 Sep 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367085; cv=fail; b=pasobUHmhg8HWV7sm77HABsd58aZ+tOz4TaBBDd20O3gh1+F4ifiIpxm2E52Lc0AiEnyF96AfVs0YPzyEurDesKdae0Ilp/4bGcU2Ok/jE9Qo7ru8F5J0QsopmWfgraaGQJK2lSzpeW9TWZkjN2zh1/Lar9K5etXDGWNVUu36ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367085; c=relaxed/simple;
	bh=KPzAwWHMwaNHJgLjeAV3HoFB7O4Df+WlnqDZUdd6mUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smZnfYaKLG7f2eIcwNzBuNmaK5hmWzBGWXr4EsUg9alhG3GftThcjFAoFuLeuP9ECPUNdJvOkxgsXK0QBoPENARcxiCVI7BRTA4OKzrvoEigElJMBPk+RG25rkN9rqVUqOT6GF8UpqI6vs45GbdAg3EY8rLp6vTtXH9r+TM7lY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ryWwZyiu; arc=fail smtp.client-ip=52.101.125.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNWkzRNsPf6km3jHgheEl0rzIBdsYFhJeysPd6P+2RxW2ILntjKNTxszQDmfG1SutCsM9HtwbxfdM+bx6zMScdgKZOtT9wytvU1Fe3+Wad4Y0LOUVMT8vvf7tqOtWafOgToPlhFm/7YeuJaFUJv2dbWH/kseIQdxGRsKJolBdaz77zvFRQJaROaL/4xoqGmW+uPSgog/WVRLutuXjpP4n6F+b8RbxhfLhLYhQjvF+K79cGzlWwlgqKpfN2dzwlpI7QHs8CLbNTRz9cFuqG2TUiJje9I3l9UIy/nrHOiZCH7IZNXKo6mEVHEzbzJabRZs4Og+8E95peaegwdKUOWbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPzAwWHMwaNHJgLjeAV3HoFB7O4Df+WlnqDZUdd6mUQ=;
 b=Xd/xks3NfyCEgmN4Uj0P4ixKFNGs9X7L5ExVlaUnh2/p8g5grqM2qpu+mKYXXa9ULeBNUPKJkINHPuxkPVWxKqUYzw94fUvtFfulZjgC8HMyNxLQeq00P1LQq3GpN/wHpUQlaUaDObEN6lrqLqHdqjkRk1gR3T3yS/bWUjD+9l4v8HnqVbutJRr/JXpdFM3Z595KTVzAMLqB+XXvXOhVZ9RZUHEm8Q2nDnbfzk5TtKs7HrNj8p9qn0t/JAVZIIBEoh6e/q3sfwRWRYN8gzY4rbv1R/BRYV0zdyHaTycd1IdD41gtE9f4RbAiCcrvxnXprz7yJcu4RCxH4EFpm0RkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPzAwWHMwaNHJgLjeAV3HoFB7O4Df+WlnqDZUdd6mUQ=;
 b=ryWwZyiu2UM+XjuKT+qme3mitY7MGMiJfjxNNRUHTDGLVKB3zAazmnmb0oD+i0yks6x4LkVYnnOinoY8+4GZznKrTwNIsz3jlLB59N4+U+NpK+yqPR9jdqMEhjBfMs55PVjzyo4Sv76xfNjyR7DvfllPNk5eXKyIU0j+Sdtsk8s=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12842.jpnprd01.prod.outlook.com (2603:1096:405:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 12:37:58 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 12:37:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Topic: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Index:
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcwgAFU0LCAADjlgIAAAKQQgAAJGICAAAE9UIAADyWwgAAHkoCAAADSkA==
Date: Tue, 3 Sep 2024 12:37:58 +0000
Message-ID:
 <TY3PR01MB1134689573A785E91A9041E1886932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
 <TY3PR01MB113464D53083F4C8A5DBBA36586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <590a4fb2-24b2-432b-92db-534c5a52ed0b@tuxon.dev>
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
 <TYCPR01MB11332EF1A8D064C491D8F261286932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <f7c57e76-b890-491f-880d-62d060b7b31e@tuxon.dev>
 <TYCPR01MB11332BE2EDB318950B9C7B54C86932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <TY3PR01MB113469FC8A9F49D9B1FA432FD86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <0b73544b-0253-43b9-b631-6578b48eaca8@tuxon.dev>
In-Reply-To: <0b73544b-0253-43b9-b631-6578b48eaca8@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12842:EE_
x-ms-office365-filtering-correlation-id: 20cf7c8f-2a0e-4d6d-733e-08dccc153dda
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmphRVFUaGJrT2pmS0NCVjRjWUVueFZhTUFOWFlpczg3UkdUY3l6RGRBbjgz?=
 =?utf-8?B?d1Y2L2tyVkd5TzRhYkRiSlByOTVNa3ZhY1ZGcmwrZDlaMURlbmUrc2xLTk1x?=
 =?utf-8?B?Mndad2I0ckRrRi9kdkQvZ1E4ejgwcFdOaWZKaVZEY25KcGZNR2JsM2g3TXkz?=
 =?utf-8?B?RmNLQk9YK1YwSHdab1FlUHdmVDhSZ3Z1UUEyaS9Ib3RRWkdLd2FwNjZvaS9k?=
 =?utf-8?B?enRUM3c0dXEyekN1NzJSV09yWGhMRjM5KzlXSUtrc2NrK243aHlTMS9LeThU?=
 =?utf-8?B?VHNvYktZOG95c1VkVE9sUVBBWEtlam9keFVsY00vSVU4THovZnVma1o2SkhQ?=
 =?utf-8?B?U1FvYzk2akxkMDl5c3VSdlk5WkdDUVhTaFR0WU51SFBpd3RzOWlMVVFRZjBP?=
 =?utf-8?B?dnd6WGkwR1RwZFlIa2UyYnNXNnp0MUxMbldNaGlKaGRmZnN0YnF0Nkh2NWZB?=
 =?utf-8?B?emJHVm1UVHlFaUV5K0lGQmRwck1SMkU3SmlhTTBLKzAwaDZzZ1V6NWlTcVFL?=
 =?utf-8?B?cHZwdVBKYmo3TU9KL2gvU2VOdzFHT0lXcXFaWUw1S0U5Um9DdkZ3bXlGeE1y?=
 =?utf-8?B?NXd0YjNzRHN6YWFlUDA4d1pFT2I0cHJySHVWTzJrRzVWZ2pZc0YybnNBRHZt?=
 =?utf-8?B?c0R1Wk5DVUJxRXdZd2lyMmFHVkk3Z2RKWlk4L1RVclFHRXk1YWIvUDhLQlJD?=
 =?utf-8?B?MVI2SmxFWjdkMExack50aFJCVlV2VWhsNWJJWUp5UTFpTTdvV0dQUHNTd3o0?=
 =?utf-8?B?MEJya2tBSE1RcEQwTmRudndVQldBSFZzR3hFMkJMVUw1OUV0UUk2bG9CdFZH?=
 =?utf-8?B?bE1kNjhGb3d1dDd0U01SUDkyU1pJTzZzd2k0ZzRNN2tOb3VldXlhUTVVMGNO?=
 =?utf-8?B?bk9KZnNFYThxcVl0dDlzSGdScFVyYXBpV3g5aWFFN3lTZE8zeHdjaHhXWmdO?=
 =?utf-8?B?ZGl2aTU2TXJXRVVnMXdhRU5uUFNPRVRyeEQrcGNrNm4xV29YbGh2WUF6ajVH?=
 =?utf-8?B?S3JJWEVWOXVjdlpiVTE0RDlNNlpvNS85MnZIeUpiV2d0WWJEVTd4MEhObVNt?=
 =?utf-8?B?SlhWZ0VNMTA2K3ZSSDI2OXFLeVVaSytVSDJyR1BKUVpTSk9kNmdaV1lkVlFm?=
 =?utf-8?B?c2ZUY3dwanZzYVRWTjN3VHRLYTBSdkk0RU9UWUZNbTA3VjNYWG15VUZ5emRX?=
 =?utf-8?B?VWhUS3BRQ0NJOFBDcWJ1a1lCR01CbTdXNnU3alNEZlBydm5hYXo4eFRJb2VM?=
 =?utf-8?B?VmFlZWVET2JjSXBpVGRYRWJLVnZYY1ZUU0txMXNLTS9TZ21zNDB3dWFZTkpH?=
 =?utf-8?B?bUJTSGs0U01IcFBKbWRjOWRkUzBIdDd0cnJXdGFQcmEyUXpTUFFjbDBPWHBx?=
 =?utf-8?B?eFhMbmhZOENjbTRwMEdxNUMveGM1WlVXZTBHeTdaOW5NNndGd2UrNkhxdG0r?=
 =?utf-8?B?TUVUbWpBZzBBdVB5YW1tUUNzRE9yMDI3bi9WRTNkUzAyRnVRbDZKZ1VPMU14?=
 =?utf-8?B?MkNmZWFQdk1Pa0R3YU9CUlRnTFE0cGFRTHNyeXJ6SnZMdlFWR3VMVDAzeXFm?=
 =?utf-8?B?SVovQ0pMZnFHT1ExdW5qdGZnL24xNy9pYTRmQUJlSmd1UUVVbkwzU0xqejJV?=
 =?utf-8?B?LzBBZytyckFaaGxITG91OXB5NUlSNFl1elBvU2FsVTNxa2U2UmpPUXpGT2Qz?=
 =?utf-8?B?dlpybTJJa29sZ0UzL3hmU2UyUTNrb3p5NWxBenRYMkk1eThnQU1aUjdsM2NB?=
 =?utf-8?B?YS91WWM4UGNRZDd5UEh0MmtGWnZVTTR3ZDFTY0REWGJmSEZyVm9pS0Q4Y0Zl?=
 =?utf-8?B?TGsrUWhQYzZYazRnQWV6c0NTVkNzb3o1WXNUVmUvUU03TkszdmZpcThLOHVr?=
 =?utf-8?B?Y28reWZzcE9RcVVVcURndXFjUzBsNlgva1o2RjcwSTFLelE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHkzOUdmSWorVmtCRDl1MXBGRzBiQnpFYUdLb2JBQkRPNFZTeitVNXdrVWls?=
 =?utf-8?B?ZzN2b1dUcStBbFE3MExJUjJOMjZBVzU1M1ArcllaWjJiTGFOMjNOQ1BpT2w5?=
 =?utf-8?B?UHFaL1pDb2luODFSMk9NZS9BMnI3RElLM09KckpDOVB1T0Z4eWxzNVJGdG1m?=
 =?utf-8?B?dnhSY2ZSUEZBeHFtZjlSczFRTFBwTER4d3FucmV5elNsUDBRNkhzV2xVb2Z5?=
 =?utf-8?B?RlVxdW8rUWtSTWZUMGJZVkxwVmNKMThVLzNzajRiSEVFSUpMZEdWN2JCVm5x?=
 =?utf-8?B?dHlLUytkYmZ4OG14L3RFN3FuWVQwR210L2MwbkdIMGZrZkxGeEQrWWhEVlh5?=
 =?utf-8?B?TmtvdnpCZEIwUFNlRWxIQlV0dG13OE1yNlN6SVczY0lYRXc0WXUwWnUzNmp3?=
 =?utf-8?B?eTdiWlZsL09uM2tQenlIekM3bjZmYkl0QjJ3MDdKOTdwNS9pY0VRNVpFL2Rs?=
 =?utf-8?B?V2Z2WFhzYXF5OUdNT0N3YmNrMy90TXROMVNnOFhSby9IWllKTmFxUDF3YlUx?=
 =?utf-8?B?TUs3am8zNUJMb2dNNEZWOHEyMXhZNjhxeVVGRjBxWER5ekZpcWF5RitnNi9Z?=
 =?utf-8?B?dFlsRTY3YWhmeVVZcnFWM1hhM3pUa2VsVTVmZUVVM0JBb1FxeHZ2eFB1andQ?=
 =?utf-8?B?UUhXRlNBU3lSSjUxcTd2R3J6Q3dlM3FoN3V0MElqa0J3WVhOdmlMbjg1aG0z?=
 =?utf-8?B?bXFRZmNwb0M4YzFRMmQ2ZFdyamtCVWNhaHhnZXh2Z3UrWEE2L2t0L3hOa1cz?=
 =?utf-8?B?T3A1ZDRvRDQrTmpqTnY2eWNveGhkWDZtd0x4NUc2YlZzTHMrUVNHVE8rQUh0?=
 =?utf-8?B?RkVOZXljazRZZnpzNG5qcDlaaW14QUhWYUxDQ3dacGJYTEQ5cE80ZjcxZUND?=
 =?utf-8?B?dzBjR1RWeWZQMmQ0Z29DZkZ2ZVVSQzh4VWQwVitBc0cyVitXdTVxVGZOdFJS?=
 =?utf-8?B?TXh1VXhFZnlRbnFwSWM5eXlpNGF1dTQ1dWxTZkpRcGdyNWc3OUVabUF5VjVn?=
 =?utf-8?B?Zm1TMUNBbExpM05EbXk5V1lzMC9NamNQV2tyc2V2SXpEQWd4UW9LTUxsVGxU?=
 =?utf-8?B?MEdvVmc2dUZaYjJYM1VPck1iUXhRc28zNS95aDI3U1BCaXFwak5jdjdvUlRX?=
 =?utf-8?B?SzBBZWZzS0gyTlhzYk1iL2hjZWY4TUFpa1ZzeTNGV1ZKWTA1QmRmdUluV2NQ?=
 =?utf-8?B?SXRpbXgzdTA5azk3MiszVlBPTWQ1Qmh4K0c4azBUT3hIL2x2cGh3K0pBT1d4?=
 =?utf-8?B?elhvRDFudFJYSzdLb21PZ3ZtQkZVbjZIOXVPM3NGRHUzVzE2Z1kwN3ZDNzRD?=
 =?utf-8?B?bFg4VDg5RlFHVjQwcnlnVmN6Z3cwVEpYV0tqeUt0MENBZnU1bEg0YW9ydUEx?=
 =?utf-8?B?MGlXQThzeUR5WFF6ZnNMMThYWXBrTjRXTmdWYU9LVjJsbTJOS2kzTUhuRkFn?=
 =?utf-8?B?emx2eUQxUmpCajVaRUE4LzNxS3VWdmt0eFduaTNhSGFMbVFxMk92K3QrMytK?=
 =?utf-8?B?dHMyVHE5TWZyQVFpenNNQ1RDY2EvTnFTSDZuWm82RHFscFRFVkJkbWowNENQ?=
 =?utf-8?B?L0psVVVGRXdSSmRhTHFVTU1hQUZSU0Y3MVlTUFdGZGppVnFhZi84NlQ5dkJL?=
 =?utf-8?B?OUt1Wk5TSkJKV2ZSeGxxWjU3Yi9zQnZQQnlWTjdKd3Z0WU9NMjNMQ3Raanhr?=
 =?utf-8?B?NWxoK2lhZ3N4TldvdU9xa2F1QmE4Q1V1c3FNNmlibkMvMThUWUlZN0YzZlFh?=
 =?utf-8?B?WURSbWNUenZGN00ySUlrd0xIdXd3WEVEcFh1Y1poc3FWbW9CbG1PcC9YYVRY?=
 =?utf-8?B?MHE3bEFYS0NMQTRsU1Ftd254UDZ0YTh3QUlIZ2I5Sk4rWnI1WXpYQ3BGUWxW?=
 =?utf-8?B?L0JodllCdmMyRnJZVXNoOEhZdXphZTh0c0I0YXhnQjFqWnJwV0JZSC8wRjNa?=
 =?utf-8?B?TEYwSGhzeHlJYkhtVW81L2lhcWV2aVpqaGFnSmd0OGJPY3FEWnYyVWtGNXBo?=
 =?utf-8?B?NmtPSU5wbUJNNVpLbThTNmFsL0QrYUQrbmx6YUNJUzhtYWZjVDYzT1oxRUgx?=
 =?utf-8?B?a3Fna1R2Um9YcjQ5cjdaYjdpaktLSE9pWC96Q3pFU3N2Zmt3S1BrUGRIaEx0?=
 =?utf-8?B?eHBNOSs4cmM2QTZEU2FjeW1jdzNGV2MzcUxvZ0MzRGpnYW5Ba2xHZ0ZQeko0?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cf7c8f-2a0e-4d6d-733e-08dccc153dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 12:37:58.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkpQdjiSYarQeyaRr9GkQ2t1FvQpeyH+NgDWbr50xCpIZ+LZR8EaH7M6fjnaq0r0jjE6TagbdX+fgUy3Os1N3h+DmmQasPoNrxisYW7LRIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12842

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2xhdWRpdSBiZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDMs
IDIwMjQgMToyNiBQTQ0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiB2a291bEBrZXJu
ZWwub3JnOyBraXNob25Aa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5l
bC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBtYWdudXMuZGFtbUBnbWFpbC5jb207IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVs
Lm9yZzsgWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29t
PjsNCj4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcmVuZXNhcy1z
b2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YS51akBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xNl0gQWRkIGlu
aXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzIFJaL0czUyBTb0MNCj4gDQo+IA0KPiAN
Cj4gT24gMDMuMDkuMjAyNCAxNTowMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAzLCAyMDI0
IDEyOjA3IFBNDQo+ID4+IFRvOiBDbGF1ZGl1LkJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24u
ZGV2PjsgVWxmIEhhbnNzb24NCj4gPj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ID4+IENj
OiB2a291bEBrZXJuZWwub3JnOyBraXNob25Aa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0K
PiA+PiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHAuemFiZWxAcGVu
Z3V0cm9uaXguZGU7DQo+ID4+IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBtYWdudXMuZGFtbUBn
bWFpbC5jb207DQo+ID4+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBtdHVycXVldHRlQGJh
eWxpYnJlLmNvbTsNCj4gPj4gc2JveWRAa2VybmVsLm9yZzsgWW9zaGloaXJvIFNoaW1vZGENCj4g
Pj4gPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPjsNCj4gPj4gbGludXgtcGh5QGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0gcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwu
b3JnOw0KPiA+PiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGxpbnV4LSBjbGtAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IENsYXVkaXUgQmV6bmVhDQo+ID4+IDxjbGF1ZGl1LmJlem5l
YS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4gU3ViamVjdDogUkU6IFtQQVRDSCAwMC8xNl0gQWRk
IGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzDQo+ID4+IFJaL0czUyBTb0MNCj4g
Pj4NCj4gPj4gSGkgQ2xhdWRpdSwNCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+PiBGcm9tOiBjbGF1ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2
Pg0KPiA+Pj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDMsIDIwMjQgMTI6MDAgUE0NCj4gPj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0
aGUgUmVuZXNhcw0KPiA+Pj4gUlovRzNTIFNvQw0KPiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4g
T24gMDMuMDkuMjAyNCAxMzozMSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+Pj4+PiBEdXJpbmcgYm9v
dCBjbHIgVVNCIFBXUiBSRUFEWSBzaWduYWwgaW4gVEYtQS4NCj4gPj4+Pj4+IFNUUiBjYXNlLCBz
dXNwZW5kIHNldCBVU0IgUFdSIFJFQURZIHNpZ25hbCBpbiBURi1BLg0KPiA+Pj4+Pj4gU1RSIGNh
c2UsIHJlc3VtZSBjbHIgVVNCIFBXUiBSRUFEWSBzaWduYWwgaW4gVEYtQS4NCj4gPj4+Pj4gQXMg
SSBzYWlkIHByZXZpb3VzbHksIGl0IGNhbiBiZSBkb25lIGluIGRpZmZlcmVudCB3YXlzLiBNeSBw
b2ludA0KPiA+Pj4+PiB3YXMgdG8gbGV0IExpbnV4IHNldCB3aGF0IGl0IG5lZWRzIGZvciBhbGwg
aXQncyBkZXZpY2VzIHRvIHdvcmsuIEkNCj4gPj4+Pj4gdGhpbmsgdGhlIHdheSB0byBnbyBmb3J3
YXJkIGlzIGENCj4gPj4+IG1haW50YWluZXIgZGVjaXNpb24uDQo+ID4+Pj4NCj4gPj4+PiBJIGFn
cmVlLCB0aGVyZSBjYW4gYmUgbiBudW1iZXIgb2Ygc29sdXRpb24gZm9yIGEgcHJvYmxlbS4NCj4g
Pj4+Pg0KPiA+Pj4+IFNpbmNlIHlvdSBtb2RlbGxlZCBzeXN0ZW0gc3RhdGUgc2lnbmFsIChVU0Ig
UFdSUkRZKSBhcyByZXNldA0KPiA+Pj4+IGNvbnRyb2wgc2lnbmFsLCBpdCBpcyByZXNldC9EVCBt
YWludGFpbmVyJ3MgZGVjaXNpb24gdG8gc2F5IHRoZQ0KPiA+Pj4+IGZpbmFsIHdvcmQgd2hldGhl
ciB0aGlzIHNpZ25hbCBmaXRzIGluIHJlc2V0DQo+ID4+PiBzeXN0ZW0gZnJhbWV3b3JrIG9yIG5v
dD8NCj4gPj4+DQo+ID4+PiBJIHdhcyB0aGlua2luZzoNCj4gPj4+IDEvIEdlZXJ0IHdvdWxkIGJl
IHRoZSBiZXN0IHRvIHNheSBpZiBoZSBjb25zaWRlcnMgaXQgT0sgdG8gaGFuZGxlIHRoaXMNCj4g
Pj4+ICAgIGluIExpbnV4DQo+ID4+DQo+ID4+IEkgYWdyZWUgR2VlcnQgaXMgdGhlIHJpZ2h0IHBl
cnNvbiBmb3IgdGFraW5nIFNZU1RFTSBkZWNpc2lvbnMsIHNpbmNlDQo+ID4+IHRoZSBzaWduYWwg
aXMgdXNlZCBvbmx5IGR1cmluZyBzdGF0ZSB0cmFuc2l0aW9ucyAoVGFibGUgNDEuNi40IEFXTyB0
bw0KPiA+PiBBTExfT04gYW5kIDQxLjYuMyBBTExfT04gdG8gQVdPKQ0KPiA+DQo+ID4gT25lIG1v
cmUgaW5mbywgYXMgcGVyIFsxXSwgdGhpcyBVU0IgUFdSUkRZIHNpZ25hbCBzZXR0aW5nIHRvIGJl
IGJlZm9yZSBMaW51eCBrZXJuZWwgYm9vdHMuDQo+IA0KPiBUaGUgImNvbnRyb2xsZWQgYnkiIGNv
bHVtbiBtZW50aW9ucyBDQS01NSBvbiBQV1JSRFkgc2lnbmFsIGNvbnRyb2wgbGluZSBhbmQgaXQg
aXMgYi93IHN0ZXBzICJERFIgZXhpdHMNCj4gZnJvbSByZXRlbnRpb24gbW9kZSIgYW5kICAiY2xv
Y2sgc3RhcnQgc2V0dGluZ3MgZm9yIHN5c3RlbSBidXMgYW5kIHBlcmlwaGVyYWwgbW9kdWxlcyIu
IEFGQUlDVCwgYWZ0ZXINCj4gRERSIGV4aXN0cyByZXRlbnRpb24gbW9kZSBMaW51eCBpcyByZWFk
eSB0byBydW4uDQoNCkREUiByZXRlbnRpb24gZXhpdCBoYXBwZW5zIGluIFRGLUEgYW5kIGl0IGp1
bXBzIGludG8gcmVzZXQgY29kZSB3aGVyZSBpdCBleGVjdXRlcyBCTDIgaW4gVEZfQS4gQmwyIGNo
ZWNrcyBmb3Igd2FybSBvciBjb2xkIHJlc2V0Lg0KSWYgaXQgaXMgd2FybSByZXNldCwgaXQgc2V0
cyByZXF1aXJlZCBtaW5pbWFsIGNsb2Nrcy9yZXNldHMgYW5kIHBhc3MgdGhlIGNvbnRyb2wgdG8g
bGludXggYnkgY2FsbGluZyB0aGUNClNNQyBjYWxsYmFjayBoYW5kbGVyLiBXaGljaCBpbiB0dXJu
IGNhbGxzIHJlc3VtZShzdGVwIDExLS0+MTQpIHBhdGguDQoNClN0ZXAgOCwgQ29ydGV4LUE1NSBF
eGl0IGZyb20gRERSIHJldGVudGlvbiBtb2RlICh3aGVuIHVzaW5nKSBTZXR0aW5nIGZvciBleGl0
aW5nIGZvcm0gRERSIHJldGVudGlvbiBtb2RlDQpTdGVwIDksIENvcnRleC1BNTUgVVNCIFBIWSBQ
V1JSRFkgc2lnbmFsIGNvbnRyb2wgKGlmIHVzZSBVU0IpIFNZU19VU0JfUFdSUkRZDQpTdGVwIDEw
LCBDb3J0ZXgtQTU1IFBDSWUgUlNUX1JTTV9CIHNpZ25hbCBjb250cm9sIChpZiB1c2UgUENJZSkg
U1lTX1BDSUVfUlNUX1JTTV9CDQpTdGVwIDExLCBDb3J0ZXgtQTU1IENsb2NrIHN0YXJ0IHNldHRp
bmcgZm9yIHN5c3RlbSBidXMgYW5kIGRlc2lyZWQgcGVyaXBoZXJhbCBtb2R1bGVzIGluIFBEX0lT
T1ZDQyBDUEdfQ0xLT05fKioqZXAgDQooKioqOiBHSUM2MDAsIE1IVSwgU0RISSwgVVNCLCBFVEgs
IEREUiwgUENJLEFYSV9DT01fQlVTLCBQRVJJX0NPTSwgQVhJX1RaQ0REUiwNCk9URkRFX0REUikN
ClN0ZXAgMTIsIENvcnRleC1BNTUgUmVsZWFzZSByZXNldCBzZXR0aW5nIGZvciBzeXN0ZW0gYnVz
IGFuZCBkZXNpcmVkIHBlcmlwaGVyYWwgbW9kdWxlcyBpbiBQRF9JU09WQ0MgQ1BHX1JTVF8qKioN
CigqKio6IEdJQzYwMCwgTUhVLCBTREhJLCBVU0IsIEVUSCwgRERSLCBQQ0ksIEFYSV9DT01fQlVT
LCBQRVJJX0NPTSwgQVhJX1RaQ0REUixPVEZERV9ERFIpDQpTdGVwIDEzLCBDb3J0ZXgtQTU1IFJl
bGVhc2UgTVNUT1AgYml0IGZvciBzeXN0ZW0gYnVzIGFuZCBkZXNpcmVkIHBlcmlwaGVyYWwgbW9k
dWxlcyBpbiBQRF9JU09WQ0MgQ1BHX0JVU18qKipfTVNUT1ANCigqKio6IEFDUFUsIFBFUklfQ09N
LCBQRVJJX0REUiwgVFpDRERSKSwNCkNQR19NSFVfTVNUT1AuDQpTdGVwMTQpIENvcnRleC1BNTUg
Q2xvY2sgc3RhcnQgc2V0dGluZyBhbmQgcmVzZXQgcmVsZWFzZSBzZXR0aW5nIGZvciBDb3J0ZXgt
TTMzX0ZQVSAoaWYgdXNlIENvcnRleC1NMzNfRlBVKQ0KQ1BHX0NMS09OX0NNMzMsIENQR19SU1Rf
Q00zMw0KDQpDaGVlcnMsDQpCaWp1DQo=

