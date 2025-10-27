Return-Path: <linux-pm+bounces-36890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C5C0D067
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0DAD4E02C4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B82F6907;
	Mon, 27 Oct 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="FeEFgxUq"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010064.outbound.protection.outlook.com [52.101.229.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E3366;
	Mon, 27 Oct 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562452; cv=fail; b=Ka2TKf0sgNNnuAhWPF273euvZ/ixbI097bmvFyrCMSyjaAv14/udNgWiSfdefZPTOksBI9umgmILrslXg8+gi6XAdkPlouCqC4CaenmgvMsWgH8TgCCD8cXaf0ub8VG03Mw+0S9FFepzgaSMJYqxgI3x0SlqLLxsRclDoYqF1Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562452; c=relaxed/simple;
	bh=vsnAHUtTABppND2lE75m3gFJTzrCgrLIjr9y4gUt6h0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o8lxDsmFLWnYeBEF9GR0HWpet63k+jZl0nkXFu9IBUONoCGCg6ygtbOmkXHuv0Z85sGP9GjnevW2wrA32qFmnWtr6Ut4faJjXANf0IZ/BcJLkk84dvrsfzhG5aFDpVrutC59w/qIOY6qZYsSwYp+EkuHEr4GfwAsLeZR78R6rLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=FeEFgxUq; arc=fail smtp.client-ip=52.101.229.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1W8AG7QoLyMbIuAq7U10sRHdRRLEz1/cQakE0qgEgJ6riwYS3kPGK97W+jsf2Ix+5xfs83bdqD3VaSQFLSbBc8VREQkHBO4N/c4KNTVBeF7b8Y1sDkShpPfv7I5wml/vFLqWXrQ9gM2WeUny3lEbFp0bCKd3uADtL27gaWmQqfhlD0kDPzgx6Moqo9eQf0+5tUyV5d9G1IfPf+sXKZNeFCYW1AsLZO+Ank40g3hmrhb84xRmCK8n3VrnXeOOKEc/kUCKeyDBXgvvbMZl61ByR5Aen5zN+0FY2evRCwCBvM0qjsbnookc22YnxkqeFBn6Ai6i31OfMjM/Rulv+bhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsnAHUtTABppND2lE75m3gFJTzrCgrLIjr9y4gUt6h0=;
 b=liYA5C6pz5wI1BRBZjxRGlpwAEoqM7chCPgM+g5R+JW18P4YhbX7713MyXrBL6ctDGsAkO0K6FW21wE/zMVWBHGbrF+gOaqCOn+E+M8tiWc2PiXP51PEx+Fq0Zz6/ola7AoaKu1w1zqI84u7hYVRmLu3+Xr6J96PwQ+nNviSgKnJUszPAa4j0qzrDQzta4s6RC6fu/VwWKy5lsdJv/v6ksj2ydziUwbxdRYb92ev7bouyXylCZm1TX0IuM3L4hEkSZ16xZD+caP7rI824OvoD2yp2tepRMoINgw5gASu8wMwwFlZ5VetydWYaLPtExpojABQaN8UFl+e86pZ6wx/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsnAHUtTABppND2lE75m3gFJTzrCgrLIjr9y4gUt6h0=;
 b=FeEFgxUq8ydt1VAW4Gdokevk9mgDtupNWvUXD7YGpbgFemXzz9XgcdQIAEu1MyobZBuDX56zeQv5yPu4iZfiARk5P5O/KXVC1nOJCLvCUlvaDagmycTNIefQcggcPy4g1AC28sjtby+Is+wKgdghe6cvMV3/gV+Lmd9d6bIZGKY=
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 (2603:1096:400:2f6::13) by TYCPR01MB9290.jpnprd01.prod.outlook.com
 (2603:1096:400:196::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 27 Oct
 2025 10:54:06 +0000
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686]) by TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686%5]) with mapi id 15.20.9275.011; Mon, 27 Oct 2025
 10:54:06 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 01/10] clk: renesas: r9a09g077: add TSU module clock
Thread-Topic: [PATCH 01/10] clk: renesas: r9a09g077: add TSU module clock
Thread-Index: AQHcQ/XYFN0xTXFAq0G+MQlq5PRA0rTV1aCAgAACMAA=
Date: Mon, 27 Oct 2025 10:54:06 +0000
Message-ID:
 <TYYPR01MB105128801D5B38F5D016E589485FCA@TYYPR01MB10512.jpnprd01.prod.outlook.com>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdUnom39_Rj+6Jc2g69i+Z4V7UkfXT791buK3h9cpOFpsQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUnom39_Rj+6Jc2g69i+Z4V7UkfXT791buK3h9cpOFpsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10512:EE_|TYCPR01MB9290:EE_
x-ms-office365-filtering-correlation-id: 94e8e671-994d-4f0b-61d0-08de1547266e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTBIRlRldmJHOXNkU3gzcmVIaEJGQXEyeGxKck1jaUcvLzVDajNybGdHOVZs?=
 =?utf-8?B?R3ltQ0dZVEZnQTFaZTJBczZ5NE11bGFaTSthd1E0dWZ6ZVV2cEs2dWlmQzNB?=
 =?utf-8?B?OU12MzlBUUwwd2Izd1pYbU5QdDVhMzV4ZXNLNU1Xenh2MkJHcXE0YXRvaE5q?=
 =?utf-8?B?dk5CNEVEdW81UjB3S3gyYWZSc3VCbVN0U0pwTmhYbU91c0dlY0I2eWljUm02?=
 =?utf-8?B?VUtsdENYR055a1YxNzczVFE5a0pHMEV0RnBTdEpDSW80NzFtU0Mva3NmdEVz?=
 =?utf-8?B?V0ZLYWE4Y2liYVhXUFdPSkQ5NStTYmxVQ3IyYm10KzZXVGJKTCtaY3c0U0FM?=
 =?utf-8?B?WWFjME0vdWdUK29rb3BualBtMGl0R1Qxa3BXMnRwalR1VTVHSUx3bHFMeldz?=
 =?utf-8?B?cFlNN2R4VjI0cHgvaWNrbDI3Sk5WeGloUnFiZGNUNG1EYnh3T1pMdWszMlVY?=
 =?utf-8?B?eFVRZDJrSjBwV0RWLzVPMk84R1FWU3p0K0xVVmkxSXg0cUNVbWpBL0pzMHUr?=
 =?utf-8?B?Mm42ZzdoalJ3SzlGOG9FUStmV3lGbWlTRkYxeTVDbXRzVzlzWWhGNnNDTzFF?=
 =?utf-8?B?NFlVOEYzcnFpSTcrWWVGbkx4bmFlM3NhTGJOMVlSU3I1OHVGc3ZLcUZwVmsr?=
 =?utf-8?B?SmVWdm5Pc1gxS1ptKy9kUUUvc2pDTmJpc25QaTNMZXpiMU5wOERaeGRML0VF?=
 =?utf-8?B?QzBGbm95TlFNemhocm1vSFUwajIrdGVER1ZjaUNiOFZOcmwrRFZiMStKWXJE?=
 =?utf-8?B?WEowK3hEMzViSUtpdVdTbnJWSzlOaGdwN2JDKzNKZnBBOHA1eTVXczdidXhK?=
 =?utf-8?B?d3ZuZXFTdXNzLzZ1ckowMTJuV0xvTjAxZzJLVHlHQ2M3WWhZaXhGZVovZVhD?=
 =?utf-8?B?UGszVVprd3N1Skoza1U2d0tyVmZZazFxQjdvNlVGL3h1aS9HOFVTcjV2ZVFC?=
 =?utf-8?B?SUtVc0dWWHR4TU5NcmpkZzdkNzFBS0w5RUZVRmgxWmFzeHFhTGlWSzFZZ3RN?=
 =?utf-8?B?QSs0dzlUMW9Hd1VubEpSV3QvUE1meEloYk5JQy91Ym93VU5NVkJWMFhSaVUr?=
 =?utf-8?B?TnFseElSOGhHR1lKLy9BUkcxOTlGSTduR1M1My9xY01paHFuYXpBWGROdGNJ?=
 =?utf-8?B?YjBmaFAyRk4rbmxxY24wa05FRkpKenpNRWk4OWd4M0hzOXRSYjkrODJkQUw4?=
 =?utf-8?B?SDhyV3Z6MW42b0Jzd0xldyt4UWg2K2xoWVNVek5xY2hDbGIzalNJL0pldVNr?=
 =?utf-8?B?dEZNVWJwNDdDQTFraVdlTnEzcXBxUlVtcTBaZmtFZW05b1FhTjI3RVlQWDlo?=
 =?utf-8?B?c0c3RTBLelNSQzVad1Z0M29uYzlKWHdBaFc4Tk1XdFRVWlJFR3NrNGsrNkxi?=
 =?utf-8?B?M2cwWUVyRlRvM3UzR2hhczB3bjhacHJXZ1hURnFqdnpBWlI0M2xLby9kbHJF?=
 =?utf-8?B?ZSsvc2UxN2NCZkFiNkYxQ1o4ZmZXV2lYcjFuQzhUcFdVa0MvaTZ4MmZPQWJx?=
 =?utf-8?B?bmJpazkrWTRYeW1Oem9XNjhPZFBuQURxYTdEdmwvZitJZVR2SWdqTjNEcUpN?=
 =?utf-8?B?czNzMUY3c1Aya1h3V2FVVk5LOXI5aU9LbnpGbEZMYk53K2lyNy9PM2NpMkNY?=
 =?utf-8?B?NFJ5NzNpM3B1SW81SEl0T21UaFJTMEVvd01nQklyT2ppbnpFN2tldUIwK2J3?=
 =?utf-8?B?bUkzNFN5R0Y1MXlCZTdWTHJLK2hIRW4xUkhudm96ZmtxR0hrT3NWZEtmb0E4?=
 =?utf-8?B?NUJLZDFPSzZOcGppTW5ZZGFkdXlFYjZtaVJPUlE5T1lKb0lJZis3eThEbnVh?=
 =?utf-8?B?TW5yUXNDdUFORHVJS2trOUJiN1IybFlqWHgxbFRsYUVsNmFPNUJDbnE4a3NF?=
 =?utf-8?B?aDBwdGhKZnRzSmppcFhkVDV4YWN3dW1QcDlleWc3Znc0Q0prVnZ6ZWc4YlN3?=
 =?utf-8?B?cW1EZGhmd3Zmd0NHaXV4aHBLbGt2ZTVqRVg3ZHhmam1jUzExU294VTV0Wndh?=
 =?utf-8?B?TmxuNkZWZlNMeWxsRGgxUVZpenM0dVVnd0RXZHpEalAza1p4U3l5Yk1jMzAr?=
 =?utf-8?Q?+QPQwr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10512.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1M0bXZPclRNdE01RkNvWitCd2NnRmsrZVh1OWZlOHB1TjdUUzVGU0ZUNTky?=
 =?utf-8?B?Vk9kNWdWUlVueWdoTkpvd2ZWQVVRNy9iV2pIYS9XUkpCY09NWWpaOStUL0h6?=
 =?utf-8?B?ZU8wRGtSMVBnS3FoWXRzMXJJeGcwaENNa3JReFI5MFlnMSt0d1h1UnJObVp5?=
 =?utf-8?B?b1ZYL0Y1MkszczNKdzNnTDBIR1QwSVFIdHZPWHdCSDVJZGRDcjZESW9kOVpo?=
 =?utf-8?B?cEREdVZBT2RBNVFSSTRON1ZsekZrUmJGOFprYjkwemhvWFNZS2c0anlHREk2?=
 =?utf-8?B?Z29JWW5IdXhYMGRnTUp3d0g1ZW5MYXVNdnc3eUlFWE04V1VKdFNGS05TcEpa?=
 =?utf-8?B?S1dFVXRZbUtQbEU2SFNzSXRsODBha2tNZGZ4NlZrNEVrTFBjUFVDQkxqNVhM?=
 =?utf-8?B?L05EbkF5azFLRDQ2VlpvdUpSMEZKR0JQZWdFK2tQbGNuVXQrMFFJdFRtbEEx?=
 =?utf-8?B?cml3NGU0cXExekhCMUczNnErdGh3YTB4OFlPaDJiaFZSeEo3b2liaVByb0Fn?=
 =?utf-8?B?R1NtRisvSi84emp2eEJBckJUeFc2QWt5c1hBYmR0NWJ6UW9wZVVtVFhoWG1G?=
 =?utf-8?B?SnlHQWhyRzVidUx3UWV2QjVjMzJoTWFXZDRPOGQ0cnc5MDh5dWdkRi9ORDRm?=
 =?utf-8?B?cEM5eWFpVTluelZtcGVvdmRNdTh4TGtXSVRyK3FRRWtQN1ByVWJpS2JIZEYv?=
 =?utf-8?B?N3FmUDg2YjY3WUtzOUVSV0lsZUlwc1F3T2x6b29Hb3ltVHhIRnAzQWtoYXhP?=
 =?utf-8?B?YkYwUm1KeTJLNVlpSGZiS0FUNXp5U2FTY1RXTmNWRVJYMXBvQU0vSGk4elhw?=
 =?utf-8?B?dXBwUmtBQjZGMXVudWc1ZHpNNENiUDBwUkduSVAydGg3aHJkZ3JBV2YvNzZN?=
 =?utf-8?B?QU45dHk4VmFlMFphWkQzMFZsYklwNGdMc1FZbDR4T3B4LzZhQkpEOWtMc3BN?=
 =?utf-8?B?TDdUcEZ6ekxSYjNYdDU3SWxvbmRMOGhHcVR2ZHg2b3F5T3doNmdkU2lUV0wz?=
 =?utf-8?B?Q2dEWFlMdmlqNm9aYUdhQ0N4MVZOcWtmM3dxWHlNK1ZpUVUweFNob3hadFd5?=
 =?utf-8?B?WEZGdFVPdEpqL1dhdGl1aGFoKzFNRmNpZlQ0SXBrbnZua2kyOVpDUkIza243?=
 =?utf-8?B?WlgzUDMxVEJXZmwwemRkd1EwdURjQkRhd21ZUzY0TWhRU2ZCTTVWWFdYaWRG?=
 =?utf-8?B?Rk1VNkNmb1ZRdkNMVTNuWG1UMldDUUlvRkE3OElSN2thYUhEN0xPa1dkVWdL?=
 =?utf-8?B?dUd1YVREa3htUVFnMkYrYkpFWktaRWR1YUxyK3JEYno1ZFlXbWN2bnZCaDFH?=
 =?utf-8?B?QnB5UTU3bXpJYUxhM2REY1NVTEc2NnN0bVUyK2lRYXB2S09QTVZGRzZXd1VM?=
 =?utf-8?B?YXJ5d1NmbHB1ZUN6YW52VzRvY0Rqb0RPcTJMMXNTaXJCSG82YlpaNUFkdmxh?=
 =?utf-8?B?T1ZXWUVNZ0VIV0R4cTV1QkF4Ukg5UFdoMGZwM1k3Q1J2VVBtR0ZJVjFwVW5E?=
 =?utf-8?B?d1VURFByc3BzbWZpcUtDVFFmVmFwR3R3L3pRVEpmeGlEQ2tIakM4Qy95VnVa?=
 =?utf-8?B?Mk1la3diYUpuZkg1T2p6Rkk4UVdJVkNsT3NhNTU0cnBKSE8zQjBDREZBNHlm?=
 =?utf-8?B?SzlPTGZMdHlUNjJkN2YrOXRtOWRKTFFvdG5YSkh3dXQzS1VPOEtLZ0VlYkRk?=
 =?utf-8?B?M1A5Qm5HUDdybU5ybnRRcU0zY3RwZFZxOFBMV3ZlMyt3K2RtcG9VZW1xcnc3?=
 =?utf-8?B?Q2ZGWDVvdTVvZFp6ZjU4WFRjcFJkS2tpWWczWWhvbGJCUk05UVpPQWMxL0hS?=
 =?utf-8?B?UE9mL3Y3bVJXUEJqNVFiWmNrUHdJZmF1TVUwUFgwbzdwbG9FM0oyUzhLNy9k?=
 =?utf-8?B?REk5N1hYeDJET2RqNlFWZmUxbHZMZUdZV0FvSEs0WEl6d1Q1SDJYRWNqN3R4?=
 =?utf-8?B?eFRiKzBEVDdSUVZhbHRObTJZVVhkYjZsZWJyc1o2SlQ5bWtFS1QvM1JtR3Zk?=
 =?utf-8?B?UmN6cFZqd0FnTmV2aFlCRitSbFpjT3lFUFdFdGFjU3JLNTA5NVNHRW9GU1F5?=
 =?utf-8?B?QTAzVlo3cFN6V0dTWVl3T09INzNaYVM1N0VIcmFEd1FycFZCMCtLWk90SHgw?=
 =?utf-8?B?Vld6bmV3M2dHOW8vNFg3TmIzZUZBS3JlV3RhK1VjdHcxOVptM3BvMlk2UE42?=
 =?utf-8?Q?Q9OadT7HGIUobix2FUr1tik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10512.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e8e671-994d-4f0b-61d0-08de1547266e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 10:54:06.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET6XmcWvAa2qLLj/e+tgiT45n2AsvPlWsAIFLz9uRgcXvwaI6JdgslaAaFGxHN0Mz5SCk7hgBG+obEwbI6FuWWRAXgDUfribfQYVf2imNkuv6NcgKGwyd8cjevH7Wv4m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9290

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI3LCAy
MDI1IDEyOjQ1IFBNDQo+IFRvOiBDb3NtaW4tR2FicmllbCBUYW5pc2xhdiA8Y29zbWluLWdhYnJp
ZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+DQo+IENjOiBKb2huIE1hZGlldSA8am9obi5tYWRp
ZXUueGFAYnAucmVuZXNhcy5jb20+OyBSYWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwu
b3JnPjsgRGFuaWVsIExlemNhbm8NCj4gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+OyBaaGFu
ZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+OyBMdWthc3ogTHViYSA8bHVrYXN6Lmx1YmFAYXJt
LmNvbT47IFJvYg0KPiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5l
bC5vcmc+OyBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgbWFn
bnVzLmRhbW0NCj4gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47IE1pY2hhZWwgVHVycXVldHRlIDxt
dHVycXVldHRlQGJheWxpYnJlLmNvbT47IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz47
DQo+IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1jbGtAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMTBdIGNsazog
cmVuZXNhczogcjlhMDlnMDc3OiBhZGQgVFNVIG1vZHVsZSBjbG9jaw0KPiANCj4gT24gVGh1LCAy
MyBPY3QgMjAyNSBhdCAxMDoyMCwgQ29zbWluIFRhbmlzbGF2DQo+IDxjb3NtaW4tZ2FicmllbC50
YW5pc2xhdi54YUByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhlIFJlbmVzYXMgUlovVDJIIChS
OUEwOUcwNzcpIGFuZCBSWi9OMkggKFI5QTA5RzA4NykgU29DcyBoYXZlIGEgVFNVDQo+ID4gcGVy
aXBoZXJhbCB3aXRoIGNvbnRyb2xsZWQgYnkgYSBtb2R1bGUgY2xvY2suDQo+ID4NCj4gPiBUaGUg
VFNVIG1vZHVsZSBjbG9jayBpcyBlbmFibGVkIGluIHJlZ2lzdGVyIE1TVFBDUkcgKDB4MzBjKSwg
YXQgYml0IDcsDQo+IA0KPiBNU1RQQ1JEDQo+IA0KPiBJIHdpbGwgZml4IHRoYXQgd2hpbGUgYXBw
bHlpbmcuDQo+IA0KDQpUaGFuayB5b3UgZm9yIHNwb3R0aW5nIHRoaXMsIEkgZG91YmxlIGNoZWNr
ZWQgYW5kIGluZGVlZCBpdCdzDQpNU1RQQ1JEIG5vdCBNU1RQQ1JHLg0KDQo+ID4gcmVzdWx0aW5n
IGluIGEgKDB4MzBjIC0gMHgzMDApIC8gNCAqIDEwMCArIDcgPSAzMDcgaW5kZXguDQo+IA0KPiBH
cntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+
IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJl
eW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252
ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4g
QnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3Jh
bW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

