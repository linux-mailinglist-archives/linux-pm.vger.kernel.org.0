Return-Path: <linux-pm+bounces-12803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78E95C7E1
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0391C20C9B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55D1428E4;
	Fri, 23 Aug 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wnB6EM4W"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010048.outbound.protection.outlook.com [52.101.229.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367113B2A9;
	Fri, 23 Aug 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401079; cv=fail; b=BSDbvTgWAYmNwcxfC8BGNHX0mJRUCzUNeD7W4NZxP16rMeZYml14oK3dEej9jsY+cWSsUL9pHFP+ZiFOiQU9cVO3O1+aN0gHq0RB9KZ2pFOsWxDDPwUGtzvZe3cqtFxaCSATJgGtWP9ZrrHCXjNxdkMyufrD9snJPnsE79GYBvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401079; c=relaxed/simple;
	bh=ejoL3u7/ok0ZMFopSzQK/2INqPb+8d6879nrgzVKUAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJmWpebvY+gAlE8c5OPqnV/LbioOYGaL7vSzwQPB9PlCAPC6MlVFdiY/KJX7IViyFVnGmDCRzNZ6gI8S4lvbnMZqmFl5Ct7aInNxKPM8/1dkRAvHZ1aAfIs9sElKwMMKT1a4qXu6bDSOALOGozmIHmyooQ2w9eGWilmmG9tsPbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wnB6EM4W; arc=fail smtp.client-ip=52.101.229.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/B3s2Nb9DpUJOsMJ9yyGyS2K+QjXGRaEbCJDVOzQ1p7AeFeWAYwFlRZyZ/H5wa3pd3H48cHclKZtW5MtMHcrLRqVcJnJ7zVx4tFhhsj/EBGmIWfN+qOEEFRXXv3iF20lRQ+mRRMc1tYMqvbdzlbx9cOSjsE9gzl/Mkf9lfoELJdw2fWtVI1F5lWziFG8hJGObjDFndb3ZNCXfkp1MUzFVfs6Au/W3u9piZouPs1Ln6Y+PYUJSELNSrJEoahHY+y0sdL1NHkj4soCYQpsp7nwEb9LakXRAtTWwEpl6hAD+ndBiY0FUlgxS9hktrzhPngHOy1lBHMuTcc8mI/xbxIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejoL3u7/ok0ZMFopSzQK/2INqPb+8d6879nrgzVKUAM=;
 b=aNaM1sieGfdi9hrdWNjFcz3y7Npz+iTuQ6gQWnBDsgyhbvlld5RpnfBwj8Dolue//rX9WPYwUmo//wlojuZ6aRBzJqtWyaExIDUKCporIn4s3oLmV6JzjtazUBcQ192cmxgYrQQ96ukJHWRLag9phhsYhR4BLEW2UkqrhisqG0Ubt6RFGc8/rML20ukIOYfs5gyoNpcybHR2oFQaSBdm2+GknvJ3ONh8i8pVILtyeH6I5sOEbeTL+v/xs8CGcW4FrvAZshQvyiqOzAKzDGoW1W+gV6ppZ+JVe2P+V/KU0Q1eLd7MwoRNvT+Snw+7bk6aNmXmgJ1t7PrVjL7uABsu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejoL3u7/ok0ZMFopSzQK/2INqPb+8d6879nrgzVKUAM=;
 b=wnB6EM4WEdDXiZJ6Xo81RHviF9y3AAwxvSOxqep8khd96bxboIuRrgb8UcH3WMM59pwl4BLrS6nW0r4aHPOnCCnG4utr2EAFB6WH8Y71yKNgwSlrkA3E27IY8UnVNRi3yTa1E/d/trTvI4XnAO16wX5yF5wRuRliA0c1w455LHg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11871.jpnprd01.prod.outlook.com (2603:1096:604:23d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 08:17:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 08:17:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 07/16] reset: rzg2l-usbphy-ctrl: Get reset control array
Thread-Topic: [PATCH 07/16] reset: rzg2l-usbphy-ctrl: Get reset control array
Thread-Index: AQHa9KfzjUIr6NsDo02njnbQaEM3ZLI0cJ3QgAAMbACAAAJOoA==
Date: Fri, 23 Aug 2024 08:17:51 +0000
Message-ID:
 <TY3PR01MB113467345E2DD50E165FFCC0086882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346900BCCEB55580C2F912086882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5f14dc3a-edff-45f3-a162-3f6fd567777f@tuxon.dev>
In-Reply-To: <5f14dc3a-edff-45f3-a162-3f6fd567777f@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11871:EE_
x-ms-office365-filtering-correlation-id: 96b35982-460d-4537-6fc4-08dcc34c14ed
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUUzRStHQ1BReUVVQlVNV0ZkYzVoRGdRVG90a2dYMVd3bUg3VjBmNnI4Si9O?=
 =?utf-8?B?bG5DNzQ2ZmE1c1BzelpGeCtIaDJpeTlWQ1ZRMFQ5QkMyWEdvMVhpamhWallo?=
 =?utf-8?B?cGt2aURIbFQ0T20wQ05EYU9iZUI4MEhCeFZzZ1BBa0VhQ2w4ZmpFaHdiSVZO?=
 =?utf-8?B?RGU4QkxtSFpwYWNKaXRzSU5keFpkRGFPM00wcUI4MWhTeC9HRTJBUTgzd2Vw?=
 =?utf-8?B?dmQ5Q3FIellGWXJZdEg2dHBxbDRxUjArUE1QdnhKUW9xcGZ2UEtuV0JKQnBq?=
 =?utf-8?B?azFNaEtIdHZYYlNlc0xQUTdjQll3VTFnM21WUzdnalNwM3JuMlRvTEdWNDdm?=
 =?utf-8?B?Z2hiL2RmNVRwWnB3Z3RBL0ZVVzNpcklJMEpuQnNZaWZET2RCYTNUSWFDd2ZN?=
 =?utf-8?B?YW9lSmZ2emRCdVRDeWswZnFmdHJ1dHhDRHV0cW1VN1VUZ3RFTjVhc0I0NWx2?=
 =?utf-8?B?b1N6NEtLSEZEUHRocldWTkd2WWNjZ2hzRkxuZ3JpSCswR2h6QWE0WWVhdVV3?=
 =?utf-8?B?cUVRMkZ3bnEwS2h1VitIVkxCcmVoTWk1UlY3WW41R01oVU5NcTVPK254M08r?=
 =?utf-8?B?a3NsRGZpVXRqM2F3aitYZ2M5Y1ZyTGFNV2o4bjhzUFU1YnY0UllldGRRbDF2?=
 =?utf-8?B?MnYvRnU1cmhkZjRCN3FubzJvSVAvWFV1cUZ6WW5Oazc3N2txbFpxd20xamQx?=
 =?utf-8?B?cVBPb2hFdFZPT2VRT3Q2OW1ZWHdjVmg4RHNKU3NZUTV5YkZwcVhEYllVT0h0?=
 =?utf-8?B?VU55ZDE3cit4NWxkaFlTaUphLzJSTkt4VVNHVWxLQ3dTWks1ZFBMV3h2WWFs?=
 =?utf-8?B?YmFaaW1aRW4rd3I3UWgwMjMvdTBVNHJtQkhWd3NFOU85dndjbG9CN0cyN1hk?=
 =?utf-8?B?Kzc4ZTd6SDg3SWM0NmJTR2hxWk9sdFZWQUtwREJucDF2QTZjQ1gzRHd5Vy9S?=
 =?utf-8?B?MTZmQytuUzdSVnFiVUtMQVV5cllwMXNQNWpYaStCbGNoNm03dnliS1UwT3lJ?=
 =?utf-8?B?VHR6Q09Bbm1DS1dWVlp6Z0J6a1hpcGtJZ3pzbE1pTG5Jb1pOS0dOQzRtMWlE?=
 =?utf-8?B?YXBjdHN6UnI2VnIvaTU0dkpGYUltbmd6d3BOU2RhU2RnUGNqbndzSC9iaHNX?=
 =?utf-8?B?QVRHWDZ5TmxFOXNEeS8vZmlFc0JGMTF2ZG9TMVpwcHNoVTVLL1dMQkVDbzVl?=
 =?utf-8?B?Q0lBZmcrSXBmK1FsL1BrZnBTaXNSbUROWEgvNmxlenhBS1I4VFFkSXZnckZq?=
 =?utf-8?B?dll5dUlJd1lNWnFwTmlFcEpsQ1dYMzRMTWJZdlk2SHpXMGJiditlMkhhUU5m?=
 =?utf-8?B?ZVlGMXJKTXpzNUdCZ3paWFJTYmJ2NVAzRlFXNCtONDFMQzhXbVJCdUo0RmdW?=
 =?utf-8?B?c29GVUdDdzNiTzk3QnJBNHU3dkYybDIvMFhPampXY0M0UDBVbkp3NmtwZlhB?=
 =?utf-8?B?ZFBJcUt0cmJoNFNSdVpDUExDZVNwTFNnM0grTWVrM0Y3UjhSY1RwSVBsUGpW?=
 =?utf-8?B?TTJZeUtKUmNVVjNFdmtrcHRjTWhxUFZjL3dOWmNyZHBSdHkyVnpmOEpHY3Vm?=
 =?utf-8?B?OXpuZVA0UFNETDgraXBDLzhQMnNMUldobnNCOEJ6ZHRHVzFCUXRqV3FGN2Ux?=
 =?utf-8?B?Y2FEL1lDNDZUL21NdmJZUEsvYnFwY2wzUjdZQWV4cllONjFlY3ZZQ0szK05B?=
 =?utf-8?B?YnNuYUd0OWFxTmRBRkV1V0tYMTJDMGo2MjA3YjF3aG4xWlYxSnVFcDgwb1M0?=
 =?utf-8?B?WDdyYnVFMitScG9XdDlzbkkycDl1ejBIenozWEliYzhpcDhKWTloN0JOVUtF?=
 =?utf-8?B?NllpMmx4SE9aQ3kxZU9yZzd4VG9LaEJVcFdveXU0QjNXRmRlVjFRc0hzOERp?=
 =?utf-8?B?YkpoOFkyRVBRVTc5VndWNmVvSGRpaytoUC9aWEIvM1JwQzN1blVKWVJYNkF3?=
 =?utf-8?Q?dOjaYpFoVsw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFdYREFWTTBBbnNjeTJ2dnpEbHRMOE1WSnlIaDVEOEdFZkViRzJUZGh5bkJq?=
 =?utf-8?B?V05XY3VMMUJKUk1CVVlLZjVXdm93VWk5eXVURFlHcDhTSWQycEk2a3VyVlN4?=
 =?utf-8?B?TlBSWkd6WjZONHI3NnE1bFV3L1AzY241SUNNUHJmWWVoL2tmZzduWkVWUXlL?=
 =?utf-8?B?dTB1S2Q4bWc3OTVPME5hcE0zeS9aZFBkZkg1Y0tHZVBNS1Nad3ZCWTA4Tlls?=
 =?utf-8?B?R1JMK29Jc1A1dGs1N3NFWUhKeWRTbHNCQ2hKSVBxWHBYUmhIdFRvRDU0bXIw?=
 =?utf-8?B?NDBpUTlDUXJpaldScGxubDZ6c3dkN1NqakR1RzNoZ2hZUW9sMmtWNEpPZzBm?=
 =?utf-8?B?dndpek13OUhzUTN4SkVlWmRmSTVId2FYNkR4TmhOalVLL3pBVEtUaGdORTF2?=
 =?utf-8?B?UTVnbEIzbG1qSXdVVk9zOTNYRUJMb2orSmVlUHM0RE90YkpTWU1VbFpPSUF0?=
 =?utf-8?B?R0FndUxBVmFLY3JNOVU1TVVZelFZRHFiMnhWd0JvRWw3YjBCM3l2cVAxRXRZ?=
 =?utf-8?B?K29hNE5aOWdnOWJ3TWRkT2FmemtPOTV0Y09IRU5ORVlzS2VBV2lVcEQ0SEwv?=
 =?utf-8?B?cFMxcWs5aUhYV2JmV09IaVhEcnVxdzdKOGxzajhIMTFISlhrbGNUcVdjQ0Na?=
 =?utf-8?B?TXdYRXg0Q2cyMnFOWmRTaW9kMVJ4M1lIMDlTTmNXcHc0aDdmWW1PVEJGQVZB?=
 =?utf-8?B?d0hscGhrRUN0OUJ2eHY1RktrUHI1MFdMS2dJYnNTcjVvWnBCdndaWHFTd3l5?=
 =?utf-8?B?eTNwNlFBZS9CSlllcDdqelpsUlhJQy9TR3dJZXRxUnBLTWZ0c295WlEyZmxS?=
 =?utf-8?B?ci8zUGI4alVEMndwR3c3ektJQWY2UGJvVEE3K1JBNkt2Z1M2V1hBbkR6MG1j?=
 =?utf-8?B?eTRydDhJTCtLZmJqWFBWNEx4OFprKzBOQmxWeDExYWYxK0xhM2d6U2lqNitP?=
 =?utf-8?B?QUxnOEJ2V1Z6MWNkbGNuSmZvc044MUdUNVQ0RE1YVDhsSGsxQkc5V1lZUEx2?=
 =?utf-8?B?MkNwV3dEbVMwaFhtN3VTbDJFam1QWDBMSzVrS0FmVVBtK1c0dHR5NFp6Q213?=
 =?utf-8?B?RmIzakQ3cG8rYXJsNWhacVBSYlBhaERDQk92eGdScFZsck5nemIreGhZMG9w?=
 =?utf-8?B?ZGFoMmd4OE1qNEhPNkhaRTdsYXQ1Y1poaWx1eUxPcGFZM2Z2QjJRb0dCM05x?=
 =?utf-8?B?QTdjUGU5N2dxRDhrTENkVFphcmdLei95WkhmWWhNakgrWlZOalhidFl2V2tF?=
 =?utf-8?B?MGswUmlVUUxGN2hjMFE4NEhGNlVRUEFVbmFaTy9ZQk1obUQySWgxd1VReStk?=
 =?utf-8?B?TS9HdlE4Q1NUQ3pRUlBSRS96T2djZmtNbEI4V2pIWE1YTDBBb2FCaHNFRW1L?=
 =?utf-8?B?bEViaWFFU3RGVUFYaHI4d01lVXFEM0FFSXlrbjVSdjJWU3hCYjAxdXQxWHp0?=
 =?utf-8?B?N280ZDBYM3RRazdKaWhBa3ZUSVhrS1hUSXJydkdSYzZGY3JMYWZSRkdVbzhZ?=
 =?utf-8?B?VktxYWRNTllTMWltVEcycXllSnM2N28zM3EzR1pCTVltbkRsK2w0S1JUd1Jk?=
 =?utf-8?B?RlFaOVl3L0FCZHFxNXBabHc0N1BzUXJvWnM0Ynk2MjdFelM2bGdidEgxd25j?=
 =?utf-8?B?SjNydjdtU2tOVTI0ajZiVGhlMnAwOW5PM21WNGgyS0xTQ3dvQXErZ1NCZlR6?=
 =?utf-8?B?Uk5FdkEyaXZ4cFZEWnI1NVB3QkNJMWVXTjdoRm1RaW8zRkV1S2RicnFPNVFV?=
 =?utf-8?B?enY2M2sxRWo5Qm12c1FjcHFvOVFDU0ZaYTdTNUY5ckNISEVsL1VYYlM1OGlt?=
 =?utf-8?B?RjRYZWVpdGQweHVTV29XaVBHMGw3U0JybXZlQnhJUmp3V2JIb3B0dmErSzRU?=
 =?utf-8?B?RXVoN2htMUVSVDJOckgzRXVOU3NleWoxdEdBWkdqYUJWRmcyNk1VL1Jtd3ZK?=
 =?utf-8?B?RGEyMjVONFFzMVI1dlFIb21hYW1NS01RWnhtTGtKeSs0ZEN3SlFUSnN4UDFk?=
 =?utf-8?B?U0p4U0hzZ0oyTmNnN3JkYk11OVMzVzBTNXozK0dwSXpzekRCM0pGQVR2eXRu?=
 =?utf-8?B?NExmb25XVG1SQzRwSGUwLzJJVmZ1NlN0UmdrZlEvNUlocXBGY3pXRHpLcUlv?=
 =?utf-8?B?bzdhUFZqWlRNRWdVRlprTmFmVktnT2ZiTWVjVmt0ekZNb1dHRDJSTDZ4NDhJ?=
 =?utf-8?B?TkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b35982-460d-4537-6fc4-08dcc34c14ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 08:17:51.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKRI1eOvkKafGKbb0hhD10Z182hbo/GVydUdPHffeLFcA2SqTqKN/TMhIroAmH8qqXlQQVF5eAY0XkiRYbCU84MQCAGypi9EiUrz54sJ3yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11871

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBGcmlkYXksIEF1
Z3VzdCAyMywgMjAyNCA5OjA1IEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDcvMTZdIHJlc2V0
OiByemcybC11c2JwaHktY3RybDogR2V0IHJlc2V0IGNvbnRyb2wgYXJyYXkNCj4gDQo+IEhpLCBC
aWp1LA0KPiANCj4gT24gMjMuMDguMjAyNCAxMDoyNSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkg
Q2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMjIsIDIwMjQgNDoyOCBQTQ0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMDcvMTZdIHJl
c2V0OiByemcybC11c2JwaHktY3RybDogR2V0IHJlc2V0IGNvbnRyb2wNCj4gPj4gYXJyYXkNCj4g
Pj4NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVz
YXMuY29tPg0KPiA+Pg0KPiA+PiBCZWZvcmUgYWNjZXNzaW5nIHRoZSBVU0IgYXJlYSBvZiB0aGUg
UlovRzNTIFNvQyB0aGUgUFdSUkRZIGJpdCBvZiB0aGUNCj4gPj4gU1lTX1VTQl9QV1JSRFkgcmVn
aXN0ZXIgbmVlZCB0byBiZSBjbGVhcmVkLiBXaGVuIFVTQiBhcmVhIGlzIG5vdCB1c2VkIHRoZSBQ
V1JSRFkgYml0IG9mIHRoZQ0KPiBTWVNfVVNCX1BXUlJEWSByZWdpc3RlciBuZWVkIHRvIGJlIHNl
dC4NCj4gPj4gVGhpcyByZWdpc3RlciBpcyBpbiB0aGUgU1lTQyBjb250cm9sbGVyIGFkZHJlc3Mg
c3BhY2UgYW5kIHRoZQ0KPiA+PiBhc3NlcnQvZGUtYXNzZXJ0IG9mIHRoZSBzaWduYWwgaGFuZGxl
ZCBieSBTWVNDX1VTQl9QV1JSRFkgd2FzIGltcGxlbWVudGVkIGFzIGEgcmVzZXQgc2lnbmFsLg0K
PiA+Pg0KPiA+PiBUaGUgVVNCIG1vZHVsZXMgYXZhaWxhYmxlIG9uIHRoZSBSWi9HM1MgU29DIHRo
YXQgbmVlZCB0aGlzIGJpdCBzZXQgYXJlOg0KPiA+PiAtIFVTQiBjaDAgKHN1cHBvcnRpbmcgaG9z
dCBhbmQgcGVyaXBoZXJhbCBtb2RlKQ0KPiA+PiAtIFVTQiBjaDIgKHN1cHBvcnRpbmcgaG9zdCBt
b2RlKQ0KPiA+PiAtIFVTQlBIWSBjb250cm9sDQo+ID4+DQo+ID4+IEFzIHRoZSBVU0JQSFkgY29u
dHJvbCBpcyB0aGUgcm9vdCBkZXZpY2UgZm9yIGFsbCB0aGUgb3RoZXIgVVNCDQo+ID4+IGNoYW5u
ZWxzIChVU0IgY2gwLCBVU0IgY2gxKSBhZGQgc3VwcG9ydCB0byBzZXQgdGhlIFBXUlJEWSBmb3Ig
dGhlIFVTQg0KPiA+PiBhcmVhIHdoZW4gaW5pdGlhbGl6aW5nIHRoZSBVU0JQSFkgY29udHJvbC4g
QXMgdGhpcyBpcyBkb25lIHRob3VnaCByZXNldCBzaWduYWxzIGdldCB0aGUgcmVzZXQgYXJyYXkN
Cj4gaW4gdGhlIFVTQlBIWSBjb250cm9sIGRyaXZlci4NCj4gPj4NCj4gPg0KPiA+IENvbW1lbnQg
YXBwbGljYWJsZSwgaWYgdGhlIFVTQiBQV1JSRFkgc2lnbmFsIGlzIG1vZGVsbGVkIGFzIHJlc2V0
IHNpZ25hbC4NCj4gPg0KPiA+IFRoZXJlIGlzIG5vIHVzZXIgZm9yIHRoaXMgcGF0Y2guIFRoZSBm
aXJzdCB1c2VyIGlzIFJaL0czUyBhbmQgaXMgdGhlcmUgaXMgbm8gc3VwcG9ydCB5ZXQuDQo+ID4g
SSB0aGluayB5b3Ugc2hvdWxkIG1lcmdlIHRoaXMgcGF0Y2ggd2l0aCBuZXh0IG9uZSBzbyB0aGF0
IHRoZXJlIGlzIGENCj4gPiB1c2VyKFJaL0czUykgZm9yIHRoaXMgcGF0Y2guDQo+IA0KPiBJIGhh
dmUgbm90aGluZyBhZ2FpbnN0IHRvIHNxdWFzaCBpdC4gSSB3YXMgc2VlaW5nIGl0IGRpZmZlcmVu
dGx5Og0KPiAtIHRoaXMgcGF0Y2ggcHJlcGFyZXMgdGhlIGdyb3VuZCBmb3IgdGhlIGFkZGl0aW9u
IG9mIFJaL0czUw0KPiAtIHRoZSBuZXh0IHBhdGNoIGp1c3QgZW5hYmxlcyB0aGUgc3VwcG9ydCBm
b3IgUlovRzNTDQo+IA0KPiBJdCBsb29rcyB0byBtZSBtb3JlIG1vZHVsYXIgbGlrZSB0aGlzLCBw
YXRjaGVzIGFyZSBzaW1wbGVyLCBlYXNpZXIgZm9yIHJldmlldyBhbmQgZWFjaCBpc3N1ZSBpcw0K
PiBkZXNjcmliZWQgZGlmZmVyZW50bHkgaW4gcGF0Y2ggZGVzY3JpcHRpb24uDQo+IA0KPiBJIGNh
biBkbyBpdCBlaXRoZXIgd2F5cy4NCg0KSWYgaXQgaXMgY29tcGxpY2F0ZWQgcmVzdHJ1Y3R1cmlu
ZyBmb3Igc3VwcG9ydGluZyBuZXcgU29DIHRoZW4gaXQgbWFrZSBzZW5zZSB0byBzcGxpdCBpbnRv
DQphIG51bWJlciBvZiBwYXRjaGVzLg0KDQpUaGlzIGlzIHN0cmFpZ2h0IGZvcndhcmQuIFlvdSBu
ZWVkIGEgZGV2aWNlIHF1aXJrIHRvIHN1cHBvcnQgUlovRzNTLg0KU28gdGhpcyBraW5kIG9mIGNo
YW5nZXMgY2FuIGdvIGluIGEgc2luZ2xlIHBhdGNoLCBhcyBvbiBzZWNvbmQgcGF0Y2gNCnlvdSBh
cmUganVzdCBmaWxsaW5nIGRldmljZSBlbnRyeS4NCg0KUHJldmlvdXNseSBJIGdvdCBmZWVkYmFj
ayBmcm9tIG1haW5saW5lIHRvIGFkZCBhIHBhdGNoLCBpZiB0aGVyZSBpcyBhIHVzZXIuDQoNCkNo
ZWVycywNCkJpanUNCg0KDQo+ID4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3Jl
c2V0L3Jlc2V0LXJ6ZzJsLXVzYnBoeS1jdHJsLmMgfCAyICstDQo+ID4+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcmVzZXQvcmVzZXQtcnpnMmwtdXNicGh5LWN0cmwuYw0KPiA+PiBiL2RyaXZlcnMv
cmVzZXQvcmVzZXQtcnpnMmwtdXNicGh5LWN0cmwuYw0KPiA+PiBpbmRleCAxY2QxNTdmNGYwM2Iu
LjhiNjRjMTJmM2JlYyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC1yemcy
bC11c2JwaHktY3RybC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtcnpnMmwtdXNi
cGh5LWN0cmwuYw0KPiA+PiBAQCAtMTMyLDcgKzEzMiw3IEBAIHN0YXRpYyBpbnQgcnpnMmxfdXNi
cGh5X2N0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPj4gIAlpZiAo
SVNfRVJSKHJlZ21hcCkpDQo+ID4+ICAJCXJldHVybiBQVFJfRVJSKHJlZ21hcCk7DQo+ID4+DQo+
ID4+IC0JcHJpdi0+cnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKCZwZGV2
LT5kZXYsIE5VTEwpOw0KPiA+PiArCXByaXYtPnJzdGMgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfYXJy
YXlfZ2V0X2V4Y2x1c2l2ZSgmcGRldi0+ZGV2KTsNCj4gPj4gIAlpZiAoSVNfRVJSKHByaXYtPnJz
dGMpKQ0KPiA+PiAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIocHJpdi0+cnN0
YyksDQo+ID4+ICAJCQkJICAgICAiZmFpbGVkIHRvIGdldCByZXNldFxuIik7DQo+ID4+IC0tDQo+
ID4+IDIuMzkuMg0KPiA+DQo=

