Return-Path: <linux-pm+bounces-13410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAEB969B23
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A70B20D54
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BE01A0BF4;
	Tue,  3 Sep 2024 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SI2TxdjN"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011057.outbound.protection.outlook.com [52.101.125.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A21B12C1;
	Tue,  3 Sep 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361634; cv=fail; b=BqWge3/VWku2iQ/zswiv3vcHoQh7QH8hoYrI/jg23S652qV2OBzJ6SbVqWyTojPxMGTGsoJ4arkFC31g+GbDXcRukcBAT7ylMTYrTVhczVAM2zurFxnv2jNumWUfLetiOjMOEEkyfQbRwoIUVtEI8GXADQX1tRPJavId5ujHvVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361634; c=relaxed/simple;
	bh=g6rufKgm5s0eEcSdaHJGh06UiapUdBkSvCM+W84qVP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5oz77ImxA1C8CDJDsC5zNGoE4H/b3CtWLzT0Qzx+stz82yomrEF8A5WC0xs9gJ1J1l6iO2eqy26tHSrWcJlD1Lnb35QOBRir3A9RVZJukyK8tkHyycoyKpR4EHyWzSgjR/vVS5/XJeWf7HO1OFxQUC5BE/PbOJ2kifkKsUUUJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SI2TxdjN; arc=fail smtp.client-ip=52.101.125.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ted2mS9wFVk6Np4E+rMLwINF1OhmEvKKqiTAJJPC9IjLSdU37a7+SElXSuh1cVGAld3h8zlW9uMp1hqw/i6xlYWwD98LGpIJZOXcMd2UkQPhoiBhRX+eSHod2MEPU4uGmlT5gUaaTBaPx/ZSUyFDBL9i/pw0agiQapzDFIOUyHwiIyB4+9p53kWwB4mhbWq+so/GOpkLmfJQohAfNidIiUrUFKSr0PFWXzyoGC5suv78ICTLNK4CDfcGU1AOJ8OkbZ/A6MNFAZNPaOEyjM6oxRPE35/2WoJ30R03JeXcy8FItiagEYx9iQqlUYXvkte7yzWbKzht/9//fa7JC2URig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6rufKgm5s0eEcSdaHJGh06UiapUdBkSvCM+W84qVP4=;
 b=SqLoHke/o59UeSEEiDc+V8mWZEe5GRblo6hdVsR8Snao+xHXYFR4oxEMaEUsABkXDSRHz1tzqv4DyDAGcc974rzkIpLzzbD0sDAdz3d4LCsnq/7Uj9YvkLJcgCg+ps8ZBfVYNQQQaP6BKbMmJDtsw3Rte6TYyT+NmPpp4j5q6eu8qLEoFygHpNZgOT2EDFVH0rhz+OfPvCfbW0MwZb49eoGkrRodfBva/Bq20drGjWnwjUKNiy5r+1xehva6u2rRWzgfxM79mTS8uIwV1V5bu8tMPaeqv6QqHNMsrjKcNDkqC8lv13OUGC59qld/x2FwqOq5E0VTCExrIKh0dCWeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6rufKgm5s0eEcSdaHJGh06UiapUdBkSvCM+W84qVP4=;
 b=SI2TxdjNo601tCcsE0cfarc7Yk/vmmpF6tAWEG9dKC26OXgNYgWxK8bPZq1kCzOOGbsTAw/8DNFlbv5i7pDaIM7vGRD5YLWbApbpmEmYdgWyWbClKD9K3zIDzzGxlkhNIFZHBihU+o1XTmPxaWgoqAic/cNR2RhyEU0bDs0QlmI=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYRPR01MB12190.jpnprd01.prod.outlook.com (2603:1096:405:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 11:07:06 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 11:07:06 +0000
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
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcwgAFU0LCAADjlgIAAAKQQgAAJGICAAAE9UA==
Date: Tue, 3 Sep 2024 11:07:06 +0000
Message-ID:
 <TYCPR01MB11332BE2EDB318950B9C7B54C86932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <f7c57e76-b890-491f-880d-62d060b7b31e@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYRPR01MB12190:EE_
x-ms-office365-filtering-correlation-id: dcf453ec-c716-4a81-1e29-08dccc088c37
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U291TURseEJydlFRb0MxVU85dmtBc0J2Zm5KbC96aVg4SXJuTWM2VjQ0cERL?=
 =?utf-8?B?VmVoSUx5VnN1cmlGL2tYaDBQMXFZYjAzeUdyN2RnMzJ3a0p6SDRlY0pOT2JT?=
 =?utf-8?B?dUVPcUNOZVQ1T0Y5clBBQzNGUUhPVWs2YUZYR3AzV2g1ZEtwQnBzRG5wQVJj?=
 =?utf-8?B?OFAyWVIxYzFFazBxVlE1TTFaWHE3Mks2V0N6QThxM3lCNytpSytxY0F0NFlN?=
 =?utf-8?B?NmozQ2UrM3hlQVBZVzBVYWJ0NUNSRnYwaEdJM2FFSEJ6M3RINXRObGlPRHVG?=
 =?utf-8?B?cG5oQXh2QzdVNC8yWmY1NzBINmJpOVZ3c1p4K1JNNHRUNnM5dk1FQkRGZENJ?=
 =?utf-8?B?TlVTbktFdzZiNG0xZW92dzczQWtMY2ZoVEFVUlhFd2dSVkZUSFR4R0lvNzM2?=
 =?utf-8?B?bm0rc1QxTWphK3V2MmR5OWMrQnJ2WHU0QkdLNHA3VVVENHFHNU5nUE9uYWZ6?=
 =?utf-8?B?WEcrWjdaQWwzbnV1U2dpV0pIRnN3OFF4M2dJWXlYakVISlI4d084MGlQcjk0?=
 =?utf-8?B?NVNucTRlYUw2NUQ0UFVsUkZKU1hZS24rZU1FWWZQYUdhQTVXWXpKZzl0Qk1m?=
 =?utf-8?B?RDQxUWQxN3FyeGJ3SzcyWlYxazZtOWNBQ1E2V3dFRjdMbzA0OW93cEI4Y3Rr?=
 =?utf-8?B?alE1eG5VVDhybjJNckZaMmRTWUhxb3FEZ1J3ZkpLMEljV2hGbk1iQmEreVJR?=
 =?utf-8?B?YmY4dmVtMkdsYmhGQ1oxa1o5RHAvWGRKajgva0I0aURXeW1SS2NaaDNFeHdZ?=
 =?utf-8?B?aUhVYmNaZmtkYXlRY21reDJKOVNsUUovdlRxNU5pS0pwYjlvRE9oZkhPVFpB?=
 =?utf-8?B?YjR0ZDNGQ0h5QWZmTWtvZ0JrSkU4OHFTdXNnakRRV2F4YnQ5MTBzRSszMGFy?=
 =?utf-8?B?SExXQlpjU05qbTBzbElyaTVwK0ZSRFpnenRIUWl3MlY1LzdkZ1ZEY1B6d0dl?=
 =?utf-8?B?enZTRWVYTDZWZDFDOGVUZjJBaUJQcTJVNVQycG1VeUFBdG1paXRtdlc0U2Ux?=
 =?utf-8?B?UWdMalNlVElkTWxiblh0VWlhVWoycTlmdmlKdm05VTBycmxLd1RaNFdiNjJp?=
 =?utf-8?B?dUJEcDlxTlpranh3dzZYYnNBdHVhU2llejdYOTFrQWNGNjd0VTJEb21wVXBC?=
 =?utf-8?B?TDZRRXVhaHRta0JHODR0WncyNWxDWmx3N0R0a3ZLZ3o3amtuWkVXMm1vNmlC?=
 =?utf-8?B?dmFqajMwY3J0VUpYZ2VMK09paEhSZk5yZmtJcXhyWGVDZGVKOE4rMG1Wblhn?=
 =?utf-8?B?TjFCcEJKTmZvclVRbzE2anI2RUVhRXV1dkNDUU5TVmRsNGlDbTlxQnMzaFF3?=
 =?utf-8?B?dEFZWWFtZENMd2N4YkdYZHl3SHc3d2NQMlJ5VVBPVFZKSjNjRkhqVDIyV0RP?=
 =?utf-8?B?cDhDcmlSbmdUcWQyd1RySC9KdjVpVkJoQ1ZlcGk1Y3VMRWI5Z1Ara2xSbXBt?=
 =?utf-8?B?YXZ3YXNrNDUvcVl4bmdCSjJIWVU3ZGFTTlhDYklYM2hVL041aVVTZXNIWFJm?=
 =?utf-8?B?VTRrdXhpK2xTdUpoMi9oUE5xUXNzRmFFYUc5cW9HQXdMMTh6T3doZ1VZdG81?=
 =?utf-8?B?Y1Y0amU5OFVYdzhHZEFuTFZOODdRQ1NpVGhvdTIzZ3FnaXZyaFI3YUE3VExC?=
 =?utf-8?B?ajhFSDJPWGFmQ3BPVGdzMmhUenFtdlFEdlczckN0aGdKajVXOWU2ZU9Ea1Iy?=
 =?utf-8?B?WFFPbjY4U0tNNFpoaHg1Q2lDa0RQMkZ5R3NzRkNiVDNYNGU5dWczbjNPQS9h?=
 =?utf-8?B?UlUyQ1ZqUFRGSytFdzNsV0dKQmgyaXlKaFZvUUpnUzZSZ3dCQlJtSk1Idys4?=
 =?utf-8?B?ZG8rK0lKWUIzUjJSQ3BrZnNRWERrckJDV2hEdHBOa0s2T25pZ0hWM3VSeFkz?=
 =?utf-8?B?TlRFWjlrK3dLVVZCRG1FNEp0OHQ4enB5b3lKQzZ6RHEwNUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODhtd0l5c3hCZVhBdjB2b2l0amEzeGc2cFRVUnNXOXJLUUc3TTNUcSswUGZq?=
 =?utf-8?B?VzBZM2JhMjd6Q2swMG1kM2I2dUc4bGlKWktucXdzZFZLMXVRYVAxK0R4V3ds?=
 =?utf-8?B?UFI4TFRLWmF3OHVSdzc4Z3l4YU9GYyszZjgrV0NRblVZUGNTQXlpeFloVU1L?=
 =?utf-8?B?UzFaeVBMNC9Sd2lEd1FoQXdmK1dqMWJKckpuSFVObWNQNjEzdW52STNoeHBn?=
 =?utf-8?B?QkFmNmJ2Rys0dHplQmlXekw0Z1h4SHBuWHZMSnRnWUhvaUowUkpuV0Jvdy90?=
 =?utf-8?B?cHZITXlWNFNJYUE3MjNLVS92ZUdzL3FEaEZaMUorV2tUTWlUQ2pGOFFKRWd4?=
 =?utf-8?B?NlFFMmVvdzQxMjFvRFhtdENUWGU0WGhvVUliSFJUQ1pxM3d1cFpRTHd3VnhF?=
 =?utf-8?B?WHVnbkpQNXgvV3AwZnhQdlc3bmorLzJRL3I5Z2VQQjduMHNGN0dNdzArWElj?=
 =?utf-8?B?QUhkWWMyQ21pQWZvT0haU2xWc2xHM01lT0ptUlM2NGMzZEs2ZmdNZXBQOVZD?=
 =?utf-8?B?V3lQazI4cWtvSkVoUHUzRU1YN2tBS3JQU3NaZytkR3o1WDNPNG1Xczd1K2Ev?=
 =?utf-8?B?bHBTOEROQThQM3BFRkNpSXVsREVybUY3NkwwTmU3NWZFUmM4Qk9helkvT2Va?=
 =?utf-8?B?MkU3RkhpdzNGUEZJRHJBVVlGNjFZbkpLZGp2Q3dJUVF3V043Rk82eU9sdnBv?=
 =?utf-8?B?MHRTMmtSM1Z3ZVJiNHdLZ3U3S1lxQUM1RW8zOHRyeXRIYk9uNlJsS2t1Y3Rk?=
 =?utf-8?B?R25vWFRHRnZudURoNkJ2UkZ5YUtQc3lvbWdnQ1g5WUhvSVMrNEViNHUxRlFE?=
 =?utf-8?B?eXVBcGxydUFYZTZTbFNSbnRqdHMvVmNETVZUTmlZNU45clU0dUYzUlJDdUpk?=
 =?utf-8?B?aWNXRjBjWXRJU0hCU2lmRms3SnI1SC91TU9xU2s3RkpXVTVmRkdJaDM3L3h5?=
 =?utf-8?B?ZXN2TVFxNFJJVXB3VElXejJiNDVCTTNaQnRUWGxzT1FhSktqUVdvM0NVeURD?=
 =?utf-8?B?NHlURnFCRUlDdklxRFdMOGwzVmhpMkRFWjJ0Nk1rVzR5MnIvUE1Wa2ZXWE1u?=
 =?utf-8?B?K1hBdEh5RUJKU21PekZMbHJHSURHL3BabUFoUWNhVnJYaEg1Sm0wRmkrUzA4?=
 =?utf-8?B?TDdFTUNxUGZEbVdPdjB5T0VhZTVzUjlwVU05L0tvWk9GMTRWVEJYVGtuL2xw?=
 =?utf-8?B?eDFhNGhaZmQ4b3FXdGk2K1RPQzFEU0UwY29WbW44RFJKYm5SUnBWK0RqeTJF?=
 =?utf-8?B?SzE0ZWkrb3hXdkpjRDU3L0tlaXBML1V6djBRR1lsTXlaSUkwb3J4NHRMTkVm?=
 =?utf-8?B?QThOUTJpK1ZLWjBqMi9xTWtMM2J1Q2lHUnVnUWkvSzR3ZzloTTU1dG1YN2ph?=
 =?utf-8?B?QVo3a1Zucmsvb2RJRVJES1JmblQ3MjE4a3BrMklXNk9KVzdGL29uNHBXZ0lQ?=
 =?utf-8?B?THZIRWphakQzRDkzZTdTOWVlU2ZIVGJ5c21iWXEvZndzV2huMjhqSzlONTh3?=
 =?utf-8?B?TUFjN2pJWGx0VUs3RmJHaVFkZXYyT3dsOFBSd01zaWR1bFVRdkFEaHhKUkZk?=
 =?utf-8?B?Zi9vNkxsQzB6Z0JHRk4yRWxUWjI3RTJhMEU1SnI0RkhXSGt1RE9lN1VJT0F2?=
 =?utf-8?B?ZTd1YUJpUnJnaGdWaFBOaFJtQ2srcTgxZlV4d21wQ3R0YVZaNDVJU2NDRW1o?=
 =?utf-8?B?SWR0NHhlS3BxaThwUmtDR0lqZVBSZXp5YTh6OXZiUVhJR2cwVm5LYUJjZTdX?=
 =?utf-8?B?YlhTOVhwS3Y4Y0FxVTlvT3A4MTJNSG5IK05Pczdpbk95eE03QWlmdWZYTGY5?=
 =?utf-8?B?enp0TFU2K3NGRGtBdlpqcll0QWZ2Wko2ZUFKUVdueXI3ZW0zeGVPY0VIZ0l1?=
 =?utf-8?B?Q2hOcWxtdzdpWmExYmZ3M1dZMGxOaFBaYnJVWmtTUlE1cGRjZkFEdFYrQWRE?=
 =?utf-8?B?UG1CaGx5L3FaMU9vVGNVZllVWFBVSmxmRFV1eGo1dHY0SFRhZk1vV0Fhc29w?=
 =?utf-8?B?ZnpRMks1M1N1QmRJcG1mQlV6R2c0ak9VL2NCdFBwNCsyeGQvVkhsM1RDZjUw?=
 =?utf-8?B?TGpxa2ljS3E1ejkwWGtrVmNlN3BabmlrQlI0Z2NMbFhCUVF2YjIyOENURzRO?=
 =?utf-8?B?VzhscXd3dE0yVVlJcXV2R002U2FLam94UE13WlIvMHF2WHBhYk5DdFIxNk1S?=
 =?utf-8?B?SUE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf453ec-c716-4a81-1e29-08dccc088c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 11:07:06.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5Ts4DWihvtXuKizawA+ekFxIp7Y5Zvo4xGdu6BghhsBdHML2UIhFicL4wnSE0O2CHwrf1x1E/IQJcLncX0wDmN0rUA0uQvHTl7SJbD79LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12190

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgMywgMjAyNCAxMjowMCBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE2XSBB
ZGQgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlovRzNTIFNvQw0KPiANCj4g
DQo+IA0KPiBPbiAwMy4wOS4yMDI0IDEzOjMxLCBCaWp1IERhcyB3cm90ZToNCj4gPj4+IER1cmlu
ZyBib290IGNsciBVU0IgUFdSIFJFQURZIHNpZ25hbCBpbiBURi1BLg0KPiA+Pj4gU1RSIGNhc2Us
IHN1c3BlbmQgc2V0IFVTQiBQV1IgUkVBRFkgc2lnbmFsIGluIFRGLUEuDQo+ID4+PiBTVFIgY2Fz
ZSwgcmVzdW1lIGNsciBVU0IgUFdSIFJFQURZIHNpZ25hbCBpbiBURi1BLg0KPiA+PiBBcyBJIHNh
aWQgcHJldmlvdXNseSwgaXQgY2FuIGJlIGRvbmUgaW4gZGlmZmVyZW50IHdheXMuIE15IHBvaW50
IHdhcw0KPiA+PiB0byBsZXQgTGludXggc2V0IHdoYXQgaXQgbmVlZHMgZm9yIGFsbCBpdCdzIGRl
dmljZXMgdG8gd29yay4gSSB0aGluayB0aGUgd2F5IHRvIGdvIGZvcndhcmQgaXMgYQ0KPiBtYWlu
dGFpbmVyIGRlY2lzaW9uLg0KPiA+DQo+ID4gSSBhZ3JlZSwgdGhlcmUgY2FuIGJlIG4gbnVtYmVy
IG9mIHNvbHV0aW9uIGZvciBhIHByb2JsZW0uDQo+ID4NCj4gPiBTaW5jZSB5b3UgbW9kZWxsZWQg
c3lzdGVtIHN0YXRlIHNpZ25hbCAoVVNCIFBXUlJEWSkgYXMgcmVzZXQgY29udHJvbA0KPiA+IHNp
Z25hbCwgaXQgaXMgcmVzZXQvRFQgbWFpbnRhaW5lcidzIGRlY2lzaW9uIHRvIHNheSB0aGUgZmlu
YWwgd29yZCB3aGV0aGVyIHRoaXMgc2lnbmFsIGZpdHMgaW4gcmVzZXQNCj4gc3lzdGVtIGZyYW1l
d29yayBvciBub3Q/DQo+IA0KPiBJIHdhcyB0aGlua2luZzoNCj4gMS8gR2VlcnQgd291bGQgYmUg
dGhlIGJlc3QgdG8gc2F5IGlmIGhlIGNvbnNpZGVycyBpdCBPSyB0byBoYW5kbGUgdGhpcw0KPiAg
ICBpbiBMaW51eA0KDQpJIGFncmVlIEdlZXJ0IGlzIHRoZSByaWdodCBwZXJzb24gZm9yIHRha2lu
ZyBTWVNURU0gZGVjaXNpb25zLA0Kc2luY2UgdGhlIHNpZ25hbCBpcyB1c2VkIG9ubHkgZHVyaW5n
IHN0YXRlIHRyYW5zaXRpb25zDQooVGFibGUgNDEuNi40IEFXTyB0byBBTExfT04gYW5kIDQxLjYu
MyBBTExfT04gdG8gQVdPKQ0KDQoNCj4gMi8gaWYgT0ssIHRoZW4gd2Ugc2hvdWxkIGdldCBhcHBy
b3ZhbCBmcm9tIFVsZiBhbmQgUGhpbGlwcCBvbiB0aGUgcG93ZXINCj4gICAgZG9tYWluIG9yIHJl
c2V0IGFwcHJvYWNoZXMNCg0KT2suDQoNCkNoZWVycywNCkJpanUNCg==

