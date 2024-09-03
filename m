Return-Path: <linux-pm+bounces-13440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5052296A2C3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A10E2817E9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64418BBB5;
	Tue,  3 Sep 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JSiyiVeN"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6918BB86;
	Tue,  3 Sep 2024 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377451; cv=fail; b=gf+GKC0oGMXeGTjqjswpim6QoSN0xFX8hXFoY4jX+r4i/XXsAqR01ETI92PQUZmxs05N8zhWQivi6KwEz8Pgd/SkFxp5OsauidFCXereFgxi09AkfCFEbPlcah2tdz/t71B7TnFxNucKKLaeEHzoTDqaCUxxa/4xjsEMElNyB0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377451; c=relaxed/simple;
	bh=Grf9LpQORYOl7s8Gg57S/13ebMgtgg8M14BumzJpaok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSnE45x0d6zjalXxbfTxEIsFfqnEvTQyX9CFPvEyLztow8uVBzCxw6AGPbwg3z4RppGgxverKkkTTiCAQhY6Y1MIndgY79PQfctYBF0+nLNNx1BIQO1guRkLZ6CF1hBiTGfcqlnx80kfa835sW0AeWEUrQPIOS/NisoqFLrt8zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JSiyiVeN; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2hKPKSwvTxdb7cqpyG9JCUy07KCrU6HkxV4j1xQbstInulAuytOYALDOZ7qqT4lNVhJs6BPXaJFjI2Ajx/R/fzh7OIPik3E7UQXaqBVzvMh+VpLoKybV2az03z/dXlZ/sMJj14XFGJxDXKZ05iTSJaG2TvzY/duHwnAgLkVPWAdo59slsMMCdlZlWFHl6K/vbhdaIbjO74XRnxQk7JnpqUVtP3kGLxfhMjvIsF5Vq9+8JS70EViQADJVD6R9JPuIvJOVwMQgJIrH3tRZ7oYSFwh6zn/WYcHaPA/Uq6o9QSBpSMxScQ53U3oYJk3lGJ3CzXxlATqnFQHhGoUmzpH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grf9LpQORYOl7s8Gg57S/13ebMgtgg8M14BumzJpaok=;
 b=olhg1XqnE9nCV3rj20AI6d9lin9eMY1o3/kdxOoEvgkATaf2RZW4I/Sf4TVVrXHAwWKk75X2KIBCR9sjx7fxpO7lhTFO9GjgF9Rccw8bOCF/bR6xcbcIBqdxvo+wTBYnpKAwJ2ng880mwnPr6qCf5zDBPr+3L9Z4BH+pFNs9EalMH5BEBblSGKRaJ1h+oh030ZQdRHzCozc2/4E07Np6lTpBGHz1EZfI6OrQjA1/a8g0k7YEI/kTfOZWDkqwuIz3srhoiHlg6yI7Vqzc6DLLkvx4oxwk4PGNyJKGfpQ2RUZrlm1fjroija4yd+32XpLRdOmlJtWr+eLs5ut9isdR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grf9LpQORYOl7s8Gg57S/13ebMgtgg8M14BumzJpaok=;
 b=JSiyiVeNlNU9Max3mp0Coq7LC0mKZfNV5VhK1BjWJnAXIWQqURfb9hWKQoLWchpKFVY1iUd/zEelsUwZOux6uPBAuipnvYgidscaA/ZLFWVfCHtFRtpw+P8vzXDyjUClMapAHC2RCWo41Op9LEUJUv0jKXdmH74LsBAMYxtdqJs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB12356.jpnprd01.prod.outlook.com (2603:1096:604:2e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 15:30:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:30:43 +0000
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
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcwgAFU0LCAADjlgIAAAKQQgAAJGICAAAE9UIAADyWwgAAHkoCAAADSkIAAB+2AgAABx5CAAByhgIAAAMmg
Date: Tue, 3 Sep 2024 15:30:43 +0000
Message-ID:
 <TY3PR01MB11346676D07F8434BBD68E62786932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
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
 <TY3PR01MB1134689573A785E91A9041E1886932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5bcdc677-e61e-4312-a19b-57b4600685d3@tuxon.dev>
 <TY3PR01MB11346FAC6022C81ED8B9B2DC386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7ffb6419-b8f0-4940-99d9-7779eec9bbb7@tuxon.dev>
In-Reply-To: <7ffb6419-b8f0-4940-99d9-7779eec9bbb7@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB12356:EE_
x-ms-office365-filtering-correlation-id: 4aebda6a-a561-435b-6da7-08dccc2d602b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjVKbjVNMXJBQ1BjQVJ5blNUMDd5M3VMWEpudk90VmJrbTBzM2oxL1NDM0Nw?=
 =?utf-8?B?bDJsaUJzaVpRb0ExZXBSMHVrK3RRT2NaUXZoOVFPMmVFMkNlNDJTeDQwZzQw?=
 =?utf-8?B?bFpiWncxWkVNb05xVlNkY25YQ2R5eEhMUWlXZTdwR09lZnd6NXRZaXUyZms5?=
 =?utf-8?B?SFQ5WGV1SzZnYnp1VmloaGpxTXI3R0ZzdXNVWC9uQ2h6U0srSk4xekNCRGRz?=
 =?utf-8?B?Zk5HZGp4VHQ4cjZMMzZKa2R3OHVTOThWb1RJa0VxSFBRZFI4Um1uUGtOYnpW?=
 =?utf-8?B?bHNpZS9kR2dtc0c0QjBkYmZ6MGJsMHhmWmhid2pqVmt2UGcxUTltbzNENmU3?=
 =?utf-8?B?dHJLYk8wd0JLT0l4MDc0d3pPTjVicjZIeFV4V3gxeGZOWjV0c1lZOWRjNFpo?=
 =?utf-8?B?dTJDSGZsdU9Nei83R0dJbllyZWtqVmFLM1RBR0dWRE95UGJrbWtPNm9aMmxN?=
 =?utf-8?B?VVd2VGJIYTBUQ2hGbmtHNVIvZ1Erdllldmw0WGR2ektUa21Wd2hrZnlNa1ZN?=
 =?utf-8?B?MlEzSm1TelRCSjdGUXRBaXJnQWRFV3AxeUw2R2hXVmE1bDAydHBkOFMyVGFt?=
 =?utf-8?B?VHF2emJOeDRvcHRFNXN0YzNLZUw1MysvTWRzRWRBMXNyRDVKeGZDUkp5RGUy?=
 =?utf-8?B?OG14QVVralhMQ1VzSXVzWUE0WWFMc3hFMlkrQkU3NVVTUjdkMlE1ZDJEOUdN?=
 =?utf-8?B?U2txQzBJRHJLUjFJQUtlT1pBTFQxbWRyNG9KVzZLdS9meVVnUUl5bDBlRlJS?=
 =?utf-8?B?aUNzNGFUWnpBMnIzZmtXZVN6bnY1U3oyRDlCZzB1RTBjYTVZRFduWnVPeGFB?=
 =?utf-8?B?UmdlWFZHNVBBQ21UMjFGL0U4Y3IxOENHWkZSTjJidUVoSjkvSTZMelg5T0xN?=
 =?utf-8?B?YzQ3ekVFVlM2SWdtMWxCa3IxSFVCaUs4Ri9ZZ3M1bE5EVHl2WXUzZy9LcVBa?=
 =?utf-8?B?aHpTTUplWEwvOXZKblpTR24vZWtham95aXFDTTlSdW9mM2hWU1ZmTG00SU1n?=
 =?utf-8?B?SkY3WmpZTE1YdjY4QmNMTnZoTU5ibXd4ZVVqK25uVmpLRHZQeFkxYm8zTktZ?=
 =?utf-8?B?UzJBQTliT2t4ZEk3RXpUZm1INS8yTk8zWHJ0MVduYzFwc255K3A0d2FvMHRI?=
 =?utf-8?B?aU8zQTl1VTdKMTJ0aGI2ZjY4d09MNTNyMEpwbTR1UDY4V054MG05VGR3YXht?=
 =?utf-8?B?WlpKWFZqRmtFT3I3UXRmWkJEcERZengyK2RPZEN4Sk1OS1JabmJmQmZoL0Vu?=
 =?utf-8?B?eXp3ZUt4STFnOW4vYTAzOVpCeHo3b0k3bU9TR0E4aXZoTFRBYVRHTy9xR1VY?=
 =?utf-8?B?UytTTE5JTlBqRVpvVytzSC9RMkxRQ0ZsZUFIYlg3Zkora1Uyb2FsS1lyVHdw?=
 =?utf-8?B?WVRBMjIxWmVsblBBT1JnR0E4UnFhSmtpYkdPdkp1anNXWkVqa1lFcjhOY3Vp?=
 =?utf-8?B?SFhGT2F1OXNON2xsTFlNaTUrMXRuUFBLWmdVWTBIODBOK0V0bEFYa0xyWXps?=
 =?utf-8?B?T3JXVGlCWkIrZFAyTlBnanB6b1ZrS1UyemxFVXJ6aVRpRDY2NVp0YjdKdVZV?=
 =?utf-8?B?Z29jUWtoZzNqbDNwSU1KYWFpazdibUgxMWFKQkJ4UFlxYmtnSkNHMTlISnlK?=
 =?utf-8?B?WmpHRk9zM3FNcGFjWkdPVFp1M21nV0RpeURBcjB2dGF2eDBkUVk4QktTc2lM?=
 =?utf-8?B?bXhBTHhUUXNEa2k0RVgzSkFxa1Zzc3BUYUl2Qk9JVmVKUWxRNlZZWWNTd3pq?=
 =?utf-8?B?SGFVOHZRTnR5enJ6TjA4Sk11Y3ZHV0x0a1VlUkRXUSt6ZnFveXZyNXdkelVr?=
 =?utf-8?B?U09WMHRnampoZ2ltcHlFaWoxemZlb2hWQk9WV3RydWJ3SzhuTG13MHlKZ2l0?=
 =?utf-8?B?UFZNditMcGZTaE1UMkVuM2FjY2NvVHZSMFpFN09lb0Mzbmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ME9pY3BMVDVITlBBS2pTNFNNZzZaRmxKMjY3RW0xblhWbEV5YUtXZUU5dCtO?=
 =?utf-8?B?MHlKc2xacDNrTW9TaHNoNjBiem5SaWg0eXVPWXV4VjhrQTJOeDJuQkpCYjE1?=
 =?utf-8?B?UE1YSkQrQ2xaa2d3aDZkRHptaFFhUG9laXZjL1hNZVZqaVlLR1VvSVR5Ym5m?=
 =?utf-8?B?SEpTTnoyVExZbjdhZFl4YlNYRGVFQVdSbkVzRzVQb3dRUVNrUWNHOEQxYklu?=
 =?utf-8?B?V2xKdUcrWXZINlpCQnFyTzZwaVBaQkUyY3BHQ2hoSXMzVTFkazIxWGxBK0xK?=
 =?utf-8?B?c2tDcmNYdVRCNkZMMTBEUjh0czdHbHFsUTBSamFjNklRVitSS3BqZFhyZXFz?=
 =?utf-8?B?M3BQQzF6SWVveXFJQ2NnSUhVaUo4NHhWcUpsSE1zT25wOVh6UjJvb29LVU8v?=
 =?utf-8?B?R0dUdEd2MUh6MUlLcFovaGNrbkF4QnBWLzJ6dFUxMVlCTlRkVGdCTXc1bnBD?=
 =?utf-8?B?bm1ic0pJZEJtNVBFQkFlQ1A4cXljdkhieTlKQmJvalIvWVFydDl1SENIS1gv?=
 =?utf-8?B?cGlKemNZWnJKV2dHdjJPbEN5cno2SXJnNUhOUURSdVNaVHpYZTFuUnRsYmRw?=
 =?utf-8?B?Q2o2c1dqMDdTdStNSHFhNUlBQnBqQkE5bXppUjM1VG9RSHNzbWdxQzlFbW1F?=
 =?utf-8?B?SzBXSmkwWEtQYWg1SHFaS25PU2hYbUF5blJXK1ZHOGZyUDZOL0tob1FoUTA1?=
 =?utf-8?B?Mjlsa01NRFk2S3duRVJFQmhrYU1jbTI4REp3emlKSUFDYkRkaFdMVTRIeDVo?=
 =?utf-8?B?WDlYN290UjVpQWNHODRNbXMrVklaWnM1RFpMSTJJdHk0OENTcHRUNXdTaThP?=
 =?utf-8?B?SWVaVFJXZ0ViRlNKOXpzd0NKNW1qSlAzdEQwR2V5eTgrZXpZRWU5eUovT0tZ?=
 =?utf-8?B?ZlVkVWFpMUp3eEZ6a0pvRktPWGE4eTNBZ0Njak9lNXFxQ0RDNGtUZDdjZWY2?=
 =?utf-8?B?aHZ5MkNRN0l6cFRmQk1xZ3FvTytUa3Y4b0liZTFTcjVCY0R5R213dlhlYzJL?=
 =?utf-8?B?QU54V21Ld1Bic2NhR0dZT0xGaWhMNjhIQW1DZ2o5MkdsWC9wT1M0c0xKSGpC?=
 =?utf-8?B?eUJqN215ZVBObXpvNnhhMHpERjh3RU8rY2Q0OXZaeW9TWjd2NUdlQ3dkeUVO?=
 =?utf-8?B?dWdGWGd6Z3djNDBRZ3lvcDM4SEhBaUFtRm12aU0xVE04YXgxc1M4VFdGZmNp?=
 =?utf-8?B?ZTJuUnpGb2FWVmdsbzFWbTlzTGJGVDRERGJ3d0dha1NlRTF1UE1wUVdWUVFM?=
 =?utf-8?B?MzlJSy8xT3N6SmI0VjNlVmV3RSs3L0ZOMDJ6TUI3L0w4eVY0ZkpaTGZzYmhZ?=
 =?utf-8?B?N25hWVJlWkcyUDlObFk1MjQySHkzMktiMTh0ZjR6S21Ib05UQ1hsbnZFYjll?=
 =?utf-8?B?YzBLOU0yWGsyUGRmQndJamM5ckFlK3VId0grZ05UZ1dmNFVVaHBGU3BGcXNr?=
 =?utf-8?B?cHRzZVovVUh0NGFBS25Fc3dNR1BzLzYvejBwdWZUZUJwWERKNGppWTJUVE8y?=
 =?utf-8?B?UFpqQWdvTURRM1kyVkhLTlBycDZOZmdYNllVQ2k1RmgyZmlsU0ZPUTlpYnZR?=
 =?utf-8?B?L3Y4SzlkeE9rVlp0UjdzbE1ITnlGMHhGeitDck9DY1Rla1NCcUptUjJCVUpv?=
 =?utf-8?B?REJjZTAvR3dQandxbmZFU3hDcUJZVkE4ZWNFTk9aZmE5VFdzcFh3WEZzSjlG?=
 =?utf-8?B?YVRvVzNDUW95NTdGdFF3YjRlYW9VOEVUbUFxZmpSMVBHZHpaNE1Kc1lGWTh0?=
 =?utf-8?B?RFNKRHVxVEl1L3A1eFg2ODRwNXhEOU1PaG1YSmJ2UGJpOXFqT2w5c2FObGpl?=
 =?utf-8?B?VmtFSi80VFJBb0xWWkN4OGdPSEZ6OEkrcHVSNUlpTWhxYTVJOE9jblIzZU50?=
 =?utf-8?B?SFdUY0JBeU42WFRacUVxdWN2NlpJSlJkK3JibmZnRzlZemRsWXdGNkpiMEt0?=
 =?utf-8?B?L21JSTZ0czhUcTd3WmdhMDA1c3N3ZGhQV1ZZRlRxbDJTckw2Q2VUUktXTnRM?=
 =?utf-8?B?MURlZE11M3B6c2tOM3UvOFdjT3dHalZ4YmVSbVFBOTFIbi8xWFN0eFJKY0Jj?=
 =?utf-8?B?STQyNkliOUtyMEhvZjBpQmxXVUg4eFVGckVLNkVSRVZadFFMY1JEM24yR2pv?=
 =?utf-8?B?ejhsM1pUZHpaT3ZPSi9KS0huUnZZTERBN1U2aTlJMFBES1IzOFRoVFZWWFJl?=
 =?utf-8?B?ZUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aebda6a-a561-435b-6da7-08dccc2d602b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 15:30:43.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SgQEZRmhBRjTIDctbdqDQ2Aqk+ydbLyZI1J1ejonnZdsb2KVp/SBRP+X/CgakXzFgV1qPmamjSwjmxOmxaZzh9Hau//mccRfV0OP8BJY3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12356

DQpIaSBDbGF1ZGl1LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNs
YXVkaXUgYmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+IFNlbnQ6IFR1ZXNkYXks
IFNlcHRlbWJlciAzLCAyMDI0IDM6NDYgUE0NCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAv
MTZdIEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DDQo+
IA0KPiANCj4gDQo+IE9uIDAzLjA5LjIwMjQgMTY6MDksIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhp
IENsYXVkaXUsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJv
bTogY2xhdWRpdSBiZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDog
VHVlc2RheSwgU2VwdGVtYmVyIDMsIDIwMjQgMTo1NyBQTQ0KPiA+IC0NCj4gPj4gY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBDbGF1ZGl1IEJlem5lYQ0KPiA+
PiA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMDAvMTZdIEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcw0KPiA+
PiBSWi9HM1MgU29DDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDAzLjA5LjIwMjQgMTU6Mzcs
IEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBjbGF1ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4
b24uZGV2Pg0KPiA+Pj4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAzLCAyMDI0IDE6MjYgUE0N
Cj4gPj4+PiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgVWxmIEhh
bnNzb24NCj4gPj4+PiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gPj4+PiBDYzogdmtvdWxA
a2VybmVsLm9yZzsga2lzaG9uQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gPj4+PiBr
cnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9u
aXguZGU7DQo+ID4+Pj4gZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU7IG1hZ251cy5kYW1tQGdtYWls
LmNvbTsNCj4gPj4+PiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbXR1cnF1ZXR0ZUBiYXls
aWJyZS5jb207DQo+ID4+Pj4gc2JveWRAa2VybmVsLm9yZzsgWW9zaGloaXJvIFNoaW1vZGENCj4g
Pj4+PiA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+Ow0KPiA+Pj4+IGxpbnV4LXBo
eUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0gcmVuZXNhcy1zb2NAdmdlci5r
ZXJuZWwub3JnOw0KPiA+Pj4+IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4+PiBsaW51eC0gY2xrQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBDbGF1ZGl1DQo+ID4+Pj4gQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BB
VENIIDAwLzE2XSBBZGQgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMNCj4gPj4+
PiBSWi9HM1MgU29DDQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gMDMuMDkuMjAy
NCAxNTowMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+Pj4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4+Pj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDMs
IDIwMjQgMTI6MDcgUE0NCj4gPj4+Pj4+IFRvOiBDbGF1ZGl1LkJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAdHV4b24uZGV2PjsgVWxmIEhhbnNzb24NCj4gPj4+Pj4+IDx1bGYuaGFuc3NvbkBsaW5hcm8u
b3JnPg0KPiA+Pj4+Pj4gQ2M6IHZrb3VsQGtlcm5lbC5vcmc7IGtpc2hvbkBrZXJuZWwub3JnOyBy
b2JoQGtlcm5lbC5vcmc7DQo+ID4+Pj4+PiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtl
cm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4+Pj4+PiBnZWVydCtyZW5lc2Fz
QGdsaWRlci5iZTsgbWFnbnVzLmRhbW1AZ21haWwuY29tOw0KPiA+Pj4+Pj4gZ3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiA+Pj4+Pj4gc2JveWRA
a2VybmVsLm9yZzsgWW9zaGloaXJvIFNoaW1vZGENCj4gPj4+Pj4+IDx5b3NoaWhpcm8uc2hpbW9k
YS51aEByZW5lc2FzLmNvbT47DQo+ID4+Pj4+PiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4+PiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0gcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOw0KPiA+Pj4+
Pj4gbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiA+Pj4+Pj4gbGludXgtIGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZzsgQ2xhdWRpdQ0KPiA+Pj4+Pj4gQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4+Pj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDAvMTZd
IEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUNCj4gPj4+Pj4+IFJlbmVzYXMgUlovRzNT
IFNvQw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEhpIENsYXVkaXUsDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+Pj4gRnJvbTogY2xhdWRpdSBiZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgMywgMjAyNCAxMjowMCBQTQ0KPiA+Pj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MDAvMTZdIEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUNCj4gPj4+Pj4+PiBSZW5lc2Fz
IFJaL0czUyBTb0MNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBP
biAwMy4wOS4yMDI0IDEzOjMxLCBCaWp1IERhcyB3cm90ZToNCj4gPj4+Pj4+Pj4+PiBEdXJpbmcg
Ym9vdCBjbHIgVVNCIFBXUiBSRUFEWSBzaWduYWwgaW4gVEYtQS4NCj4gPj4+Pj4+Pj4+PiBTVFIg
Y2FzZSwgc3VzcGVuZCBzZXQgVVNCIFBXUiBSRUFEWSBzaWduYWwgaW4gVEYtQS4NCj4gPj4+Pj4+
Pj4+PiBTVFIgY2FzZSwgcmVzdW1lIGNsciBVU0IgUFdSIFJFQURZIHNpZ25hbCBpbiBURi1BLg0K
PiA+Pj4+Pj4+Pj4gQXMgSSBzYWlkIHByZXZpb3VzbHksIGl0IGNhbiBiZSBkb25lIGluIGRpZmZl
cmVudCB3YXlzLiBNeQ0KPiA+Pj4+Pj4+Pj4gcG9pbnQgd2FzIHRvIGxldCBMaW51eCBzZXQgd2hh
dCBpdCBuZWVkcyBmb3IgYWxsIGl0J3MgZGV2aWNlcyB0byB3b3JrLg0KPiA+Pj4+Pj4+Pj4gSSB0
aGluayB0aGUgd2F5IHRvIGdvIGZvcndhcmQgaXMgYQ0KPiA+Pj4+Pj4+IG1haW50YWluZXIgZGVj
aXNpb24uDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IEkgYWdyZWUsIHRoZXJlIGNhbiBiZSBuIG51
bWJlciBvZiBzb2x1dGlvbiBmb3IgYSBwcm9ibGVtLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBT
aW5jZSB5b3UgbW9kZWxsZWQgc3lzdGVtIHN0YXRlIHNpZ25hbCAoVVNCIFBXUlJEWSkgYXMgcmVz
ZXQNCj4gPj4+Pj4+Pj4gY29udHJvbCBzaWduYWwsIGl0IGlzIHJlc2V0L0RUIG1haW50YWluZXIn
cyBkZWNpc2lvbiB0byBzYXkgdGhlDQo+ID4+Pj4+Pj4+IGZpbmFsIHdvcmQgd2hldGhlciB0aGlz
IHNpZ25hbCBmaXRzIGluIHJlc2V0DQo+ID4+Pj4+Pj4gc3lzdGVtIGZyYW1ld29yayBvciBub3Q/
DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBJIHdhcyB0aGlua2luZzoNCj4gPj4+Pj4+PiAxLyBHZWVy
dCB3b3VsZCBiZSB0aGUgYmVzdCB0byBzYXkgaWYgaGUgY29uc2lkZXJzIGl0IE9LIHRvIGhhbmRs
ZSB0aGlzDQo+ID4+Pj4+Pj4gICAgaW4gTGludXgNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJIGFncmVl
IEdlZXJ0IGlzIHRoZSByaWdodCBwZXJzb24gZm9yIHRha2luZyBTWVNURU0gZGVjaXNpb25zLA0K
PiA+Pj4+Pj4gc2luY2UgdGhlIHNpZ25hbCBpcyB1c2VkIG9ubHkgZHVyaW5nIHN0YXRlIHRyYW5z
aXRpb25zIChUYWJsZQ0KPiA+Pj4+Pj4gNDEuNi40IEFXTyB0byBBTExfT04gYW5kIDQxLjYuMyBB
TExfT04gdG8gQVdPKQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBPbmUgbW9yZSBpbmZvLCBhcyBwZXIgWzFd
LCB0aGlzIFVTQiBQV1JSRFkgc2lnbmFsIHNldHRpbmcgdG8gYmUgYmVmb3JlIExpbnV4IGtlcm5l
bCBib290cy4NCj4gPj4+Pg0KPiA+Pj4+IFRoZSAiY29udHJvbGxlZCBieSIgY29sdW1uIG1lbnRp
b25zIENBLTU1IG9uIFBXUlJEWSBzaWduYWwgY29udHJvbA0KPiA+Pj4+IGxpbmUgYW5kIGl0IGlz
IGIvdyBzdGVwcyAiRERSIGV4aXRzIGZyb20gcmV0ZW50aW9uIG1vZGUiIGFuZA0KPiA+Pj4+ICJj
bG9jayBzdGFydCBzZXR0aW5ncyBmb3Igc3lzdGVtIGJ1cyBhbmQgcGVyaXBoZXJhbCBtb2R1bGVz
Ii4NCj4gPj4+PiBBRkFJQ1QsIGFmdGVyIEREUiBleGlzdHMgcmV0ZW50aW9uIG1vZGUNCj4gPj4g
TGludXggaXMgcmVhZHkgdG8gcnVuLg0KPiA+Pj4NCj4gPj4+IEREUiByZXRlbnRpb24gZXhpdCBo
YXBwZW5zIGluIFRGLUEgYW5kIGl0IGp1bXBzIGludG8gcmVzZXQgY29kZQ0KPiA+Pj4gd2hlcmUg
aXQgZXhlY3V0ZXMgQkwyIGluIFRGX0EuIEJsMg0KPiA+PiBjaGVja3MgZm9yIHdhcm0gb3IgY29s
ZCByZXNldC4NCj4gPj4+IElmIGl0IGlzIHdhcm0gcmVzZXQsIGl0IHNldHMgcmVxdWlyZWQgbWlu
aW1hbCBjbG9ja3MvcmVzZXRzIGFuZCBwYXNzDQo+ID4+PiB0aGUgY29udHJvbCB0byBsaW51eCBi
eSBjYWxsaW5nIHRoZSBTTUMgY2FsbGJhY2sgaGFuZGxlci4gV2hpY2ggaW4NCj4gPj4+IHR1cm4g
Y2FsbHMgcmVzdW1lKHN0ZXAgMTEtLT4xNCkNCj4gPj4gcGF0aC4NCj4gPj4NCj4gPj4gSXMgdGhp
cyBmcm9tIEhXIG1hbnVhbCBvciBzb21lIHNwZWNpZmljIGRvY3VtZW50YXRpb24/IEknbSByZWZl
cnJpbmcgYXQgInJlc3VtZSIgPT0gInN0ZXBzIDExLS0+MTQiDQo+IA0KPiBZb3UgYnJhbmNoZWQg
dGhlIGRpc2N1c3Npb24sIHRoZXJlIHdhcyBhdCBsZWFzdCB0aGlzIHF1ZXN0aW9uIHRoYXQgSSd2
ZSBhc2tlZCB5b3UgYWJvdmUgdGhhdA0KPiBpbnRlcmVzdGVkIG1lLg0KDQppZiB0aGVyZSBpcyBE
RFIgcmV0ZW50aW9uIGV4aXQgaW52b2x2ZWQsDQpTdGVwIDExLT4xNCBpcyBqdXN0IGxpa2UgcmVz
dW1lIHBhdGgsIGZvciBlYWNoIElQIGl0IG5lZWQgY2xvY2sgLCByZXNldCBhbmQgcmVzdG9yZSBy
ZWdpc3RlcnMgZnJvbSBERFIgYmFja3VwLg0KDQo+IA0KPiA+Pg0KPiA+Pj4NCj4gPj4+IFN0ZXAg
OCwgQ29ydGV4LUE1NSBFeGl0IGZyb20gRERSIHJldGVudGlvbiBtb2RlICh3aGVuIHVzaW5nKSBT
ZXR0aW5nDQo+ID4+PiBmb3IgZXhpdGluZyBmb3JtIEREUiByZXRlbnRpb24gbW9kZSBTdGVwIDks
IENvcnRleC1BNTUgVVNCIFBIWQ0KPiA+Pj4gUFdSUkRZIHNpZ25hbCBjb250cm9sIChpZiB1c2Ug
VVNCKSBTWVNfVVNCX1BXUlJEWSBTdGVwIDEwLA0KPiA+Pj4gQ29ydGV4LUE1NSBQQ0llIFJTVF9S
U01fQiBzaWduYWwgY29udHJvbCAoaWYgdXNlIFBDSWUpDQo+ID4+PiBTWVNfUENJRV9SU1RfUlNN
X0INCj4gPj4NCj4gPj4gTm90ZSAqaWYgdXNlKjogaG93IGRvZXMgdGhlIFRGLUEga25vdyBpZiBV
U0IvUENJZSBpcyB1c2VkIGJ5IExpbnV4Pw0KPiA+PiBUaGUgZG9jdW1lbnRhdGlvbiBtZW50aW9u
IHRvIHNldCBpdCAqaWYgdXNlKi4gU2FtZSBub3RlIGlzIG9uIEFMTF9PTg0KPiA+PiB0byBWQkFU
VCB0cmFuc2l0aW9uIGRvY3VtZW50YXRpb24gKG5hbWVseSAiaWYgdXNpbmcgVVNCIiwgImlmIHVz
aW5nDQo+ID4+IFBDSWUiKS4gSWYgVEYtQSB3aWxsIGRvIHRoaXMgaXQgc2hvdWxkIHNldCB0aGlz
IHNpZ25hbHMNCj4gPj4gdW5jb25kaXRpb25hbGx5LiBJdCB3aWxsIG5vdCBiZSBzb21ldGhpbmcg
d3JvbmcgdGhvdWdoLiBXZSBkb24ndCBrbm93IGF0IHRoZSBtb21lbnQgd2hhdCB0aGlzDQo+IGlu
dm9sdmVzIGluIHRlcm1zIG9mIHBvd2VyIGNvbnN1bXB0aW9uLCBpZiBpdCBtZWFucyBzb21ldGhp
bmcuLi4NCj4gPg0KPiA+IFlvdSBtZWFuLCB5b3UgbW9kZWxsZWQgdGhpcyBhcyByZXNldCBzaWdu
YWwganVzdCB0byByZWR1Y2UgcG93ZXINCj4gPiBjb25zdW1wdGlvbiBieSBjYWxsaW5nIHJ1bnRp
bWUgUE0gY2FsbHMgdG8gdHVybiBvbi9vZmYgdGhpcyBzaWduYWw/Pw0KPiANCj4gSW4gdGhpcyBz
ZXJpZXMgaXQgaXMgdGhvdWdoIGEgcmVzZXQgY29udHJvbCBkcml2ZXIuDQo+IA0KPiBUaGUgaW50
ZXJuYWwgQlNQIHByb3Bvc2UgdGhlIGNvbnRyb2wgb2YgdGhpcyBzaWduYWwgdGhvdWdoIFNNQyBj
YWxscyBpbiBlYWNoIGluZGl2aWR1YWwgVVNCIGRyaXZlcjsgSQ0KPiB0aGluayB0aGUgaGFyZHdh
cmUgdGVhbSB3YXMgY2hlY2tlZCBmb3IgdGhpczsgSSBtYXkgYmUgd3JvbmcsIGFzIEkgZG9uJ3Qg
aGF2ZSB0aGlzIGluc2lnaHQuDQo+IA0KPiBBcyB5b3Uga25vdywgdGhlIGluaXRpYWwgY29udHJv
bCBvZiB0aGVzZSBiaXRzIGluIHRoZSBCU1Agd2FzIHRob3VnaCBTTUMgY2FsbHMgYW5kIHlvdSBw
cm9wb3NlIHRvIGhhdmUNCj4gYSBzZXBhcmF0ZSBMaW51eCBkcml2ZXIgdG8gY29udHJvbCB0aGlz
IGFmdGVyIGZpbmRpbmcgdGhhdCB0aGVzZSByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgaW4gbm9y
bWFsDQo+IHdvcmxkLiBBcyBhIHJlc3VsdCwgdGhpcyBzZXJpZXMsIHdpdGggcmVzZXQgYXBwcm9h
Y2gsIHdoaWNoIHlvdSB3ZXJlIGFnYWluc3QsIGJ1dCBJIGZlbHQgdGhpcyB3YXMgdGhlDQo+IGJl
c3Qgd2F5IChJIGtub3cpIHRvIGRlc2NyaWJlIHRoZSBoYXJkd2FyZSBhbmQgdGhlIHJlbGF0aW9u
IGIvdyBoYXJkd2FyZSBibG9ja3MuIFRvIGNvbmNsdWRlLCB5b3UNCj4gaW5pdGlhbGx5IHByb3Bv
c2VkIG1lIGludGVybmFsbHkgdG8gaGF2ZSBpdCBpbiBMaW51eC4NCg0KSSBhZ3JlZSwgSSBwcm9w
b3NlZCB0byBoYXZlIExpbnV4IFNZU0MgZHJpdmVyIGluc3RlYWQgb2YgY2FsbGluZyBTTUMgY2Fs
bHMgZnJvbSBQSFkgY29udHJvbCBkcml2ZXIoUmVzZXQpDQoNCkN1cnJlbnRseSB3ZSBleHBsb3Jl
ZCA0IGFwcHJvYWNoZXMgdG8gYXZvaWQgU01DIGNhbGxzIGZyb20gUEhZIGNvbnRyb2wgZHJpdmVy
Lg0KDQoxKSBtb2RlbGxpbmcgdGhpcyBhcyByZXNldCBzaWduYWwNCjIpIHBvd2VyIGRvbWFpbiBh
cHByb2FjaCANCjMpIHNldCB0aGlzIGluIFNZU0MgZHJpdmVyIGR1cmluZyBlYXJseSBib290Lg0K
NCkgaGFuZGxlIHRoaXMgaW4gVEYtQS4NCg0KPiANCj4gVG8gYW5zd2VyIHlvdXIgcXVlc3Rpb24s
IHRoZSBhbnN3ZXIgaXMgbm8sIEkgZGlkbid0IHRyeSB0byBqdXN0IG1vZGVsIHNvbWV0aGluZyBm
YW5jeSBqdXN0IHRvIGJlDQo+IGZhbmN5LiBJIGRpZCBpdCBiYXNlZCBvbiB3aGF0IGlzIHByb3Bv
c2VkIGluIEJTUCBhcyB0aGlzIG1heSBoYXZlIGJlZW4gY2hlY2tlZCB3aXRoIGhhcmR3YXJlIHRl
YW0gYW5kDQo+IEkgZGlkIHRlc3RzIGFyb3VuZCB0aGlzLiBBbmQgY29uc2lkZXJpbmcgdGhpcyBi
ZXN0IGRlc2NyaWJlcyB0aGUgSFcgYW5kIHRoZSByZWxhdGlvbiBiL3cgaW5kaXZpZHVhbA0KPiBo
YXJkd2FyZSBibG9ja3MgYW5kIGluIHRoaXMgd2F5IExpbnV4IGNhbiBoYXZlIGF0IGl0cyBoYW5k
IGFsbCB0aGUgcmVzb3VyY2VzIGl0IG5lZWRzIHcvbyByZWx5aW5nIG9uDQo+IHRoaXJkIHBhcnRp
ZXMuIEFuZCBmcm9tIHRoZSBIVyBtYW51YWwgZGVzY3JpcHRpb24gbXkgdW5kZXJzdGFuZGluZyB3
YXMgdGhhdCB0aGlzIGlzIHBvc3NpYmxlLiBJIG5ldmVyDQo+IHNhaWQgdGhhdCB0aGlzIHNvbHV0
aW9uIGlzIHRoZSBiZXN0LiBJJ20ganVzdCBhZGRpbmcgaW5mb3JtYXRpb24gaGVyZSBhcyBJIHJl
cXVlc3RlZCBoZWxwIGZyb20NCj4gbWFpbnRhaW5lcnMgdG8gZ3VpZGUgb24gdGhlIHByb3BlciBk
aXJlY3Rpb24uDQo+IA0KPiBZb3Ugd2VyZSBhZGRpbmcgaW5mb3JtYXRpb24gdG8gc3VzdGFpbiB5
b3VyIFRGLUEgaWRlYSwgdG9vLg0KDQpUaGlzIGlzIGp1c3QgYW4gb3B0aW9uIGJhc2VkIG9uIHRo
ZSBoYXJkd2FyZSBtYW51YWwgdGFibGVzIHdoZXJlIFNZU0Mgc2lnbmFsIGlzIHR1cm5lZCBvbiAN
Cmp1c3QgYWZ0ZXIgRERSIHJldGVudGlvbiBleGl0IGFuZCBiZWZvcmUgc3RhcnRpbmcgdGhlIGNs
b2Nrcy9yZXNldHMuDQoNCj4gDQo+ID4NCj4gPiBEb2VzIHdpbGwgaXQgaGF2ZSBhbnkgc3lzdGVt
IHN0YWJpbGl0eSBpc3N1ZSBhcyBoYXJkd2FyZSBtYW51YWwgc2F5cw0KPiA+IHRvIGRvIGl0IGF0
IHZlcnkgZWFybHkgc3RhZ2UgYmVmb3JlIHN0YXJ0aW5nIGFueSBjbG9ja3MvcmVzZXRzPz8gSGF2
ZSB5b3UgY2hlY2tlZCB3aXRoIGhhcmR3YXJlDQo+IHRlYW0/DQo+IA0KPiBBbGwgdGhlIGltcGxl
bWVudGF0aW9uIG9mIHRoaXMgaXMgYmFzZWQgb24gd2hhdCBoYXMgYmVlbiBwcm9wb3NlZCBvbiBC
U1AsIHRoZSBzYW1lIGFwcHJvYWNoIHdhcw0KPiBwcm9wb3NlZCB0aGVyZSwgbWVhbmluZyB0aGUg
Y29udHJvbCBvZiB0aGVzZSBzaWduYWxzIHdhcyBkb25lIG9uIHByb2JlL3JlbW92ZSwgc3VzcGVu
ZC9yZXN1bWUgaW4NCj4gTGludXguDQoNCkJhc2VkIG9uIEhhcmR3YXJlIG1hbnVhbCBzdGF0ZSB0
cmFuc2l0aW9uIHRhYmxlcywgVVNCUFdSUkRZIHNpZ25hbCBpcyBzZXQgYmVmb3JlIHN0YXJ0aW5n
IGNsb2Nrcy9yZXNldCBvZiB0aGUgSVBzLg0KSWYgdGhlcmUgaXMgbm8gc3RhYmlsaXR5IGlzc3Vl
IHdpdGggQlNQIGFwcHJvYWNoLCB0aGVuIHRoZXJlIGlzIG5vIGhhcm0gaW4gd2hhdCB5b3UgaGF2
ZSBpbXBsZW1lbnRlZC4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo=

