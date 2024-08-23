Return-Path: <linux-pm+bounces-12808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F186295C8B5
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3311F2359B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277431494D6;
	Fri, 23 Aug 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="h1uv7uJo"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011013.outbound.protection.outlook.com [52.101.125.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF33611E;
	Fri, 23 Aug 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403667; cv=fail; b=i6I5yHo75bi0bXJeRCyonHddx7LRsClr8VoyzSLcjpzt6iLWTER46grZSRjFJqX2EA5UxMv4oaSZociYZaYTdKnOGJNrrDkX26JT/1BwmHpis85DRMWCxN7DcI/5meXDDE632OMIYfGqD9P5gvcKjpKoJ+aOeUFeuC/qbp8qtFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403667; c=relaxed/simple;
	bh=ihcUZ6ygve1J3SiMQjg0q+nKqY9fXdDauAqp3k6nhLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwtW/ZvOO/5Q46xp7PMpi4CbOQNeM3b4qk7NEUQYWaVnXN85NsiREmHqkqelRjXnE52pBP9vFH8R8gZb2/+MJg6xElW+hNbSKbvf5M5tRo8BMM6W+9syKDqMhdT4isHa+buDKciiB1u9dK1Ch6WDOe3KxMGtMLktBLdaX+XXqE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=h1uv7uJo; arc=fail smtp.client-ip=52.101.125.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br2eVDUTnDq38XQfogRlr715bwROX0phG2ir2S4zZ8uSkLyrHyVG7NgVUAV+RXKCsIM7HyLYpRyKgrSpbMPdC6gC9MDqLT196zhToDxL7gvX/gsriWE2rvEvBIC3IGcBZUaQWaxyzKIUWZykI+UsqwlFeJVdVgbtjOkeVIqfCKMAYgLU3YhtXFvyJXiM+D+ZxNHe40jM7z0vtV3nRztewHRJ0sga2FxcjlEhwy9GDoN7lUrDAiZKSjAGHvNJdIVq2Mzu+0aHCC+ATMQo1Y7rN+qc22DaC+CzaWr5oOWMtBP8a7XEOKjMc0VrQvjKpFvCARDTXcKSji0POSMAx2AXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihcUZ6ygve1J3SiMQjg0q+nKqY9fXdDauAqp3k6nhLQ=;
 b=fc1kquRHGuE6bjRD4Hm5gzg/LhLvqlCxLlhWDPxWzkttBnxrHIU2cTvVia12v6dLhfWKdoyqsWClC+v9uIUu2x4NoET/gqmTvSzW3nPhSAXNeK20n82YKlg/PAhijv16ZbuPN0XfieNxBb8j50xxyf2zgVVcP9BfE72orwriYUwjLsAAUWNasLqIzpV/QPv4ILernhXNLFs3nBoXaaEFqweGmVElOR4H+cC/QIdTjyniUEeHe9HcDm2djD2W3uCYowN1wHZGV8TPpDC0etGilrKDF2m1fJxQfTplUHpOk4UdXeaGAvveZv30GuvUySMrKAbQBpfSnU/2ejWYSxjNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihcUZ6ygve1J3SiMQjg0q+nKqY9fXdDauAqp3k6nhLQ=;
 b=h1uv7uJo1yBO/NWdBTGO6u3KaOpFc1U1qEpfReLlh8S2L7UYTy4v6rFPTM6HWaF+rzMj26Sv86uDJriJJF2+zvJjQefzrVJMU7iXB3d3AxwrL82kkaHgmV8IOWrsw/kC4L5Sf10Os4+ZVWwDfRJ89/NtcF7YVD38ZM7sU3Fw6Jc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYAPR01MB5820.jpnprd01.prod.outlook.com (2603:1096:404:8053::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 09:01:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 09:01:01 +0000
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
Subject: RE: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Thread-Topic: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Thread-Index: AQHa9Kf4PPM3ttIrIU+GFs1JG0RdeLI0cirAgAAZfgCAAABPEA==
Date: Fri, 23 Aug 2024 09:01:00 +0000
Message-ID:
 <TY3PR01MB11346FBA77256F2156D374ECF86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113468A6CA4ADBCA577670AD486882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <8faa6b6d-a013-4a71-a8b7-af02ac92d94b@tuxon.dev>
In-Reply-To: <8faa6b6d-a013-4a71-a8b7-af02ac92d94b@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYAPR01MB5820:EE_
x-ms-office365-filtering-correlation-id: dace2aee-6271-4026-3523-08dcc3521c51
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZE82SDFKZ04wZVZaS3Z5WWIyVnp4SDVMN3plRW5BOXJNQ0k5ZU43WlExc3N0?=
 =?utf-8?B?NlpFSEF3SXRidmJYWGUzY1lzcXFjNjlqWWNxMUJ4bHg2NEorQWFETTB1Q0R5?=
 =?utf-8?B?Ni94SWF1YjJFdVo2VjFpOGtzclF2QWtpNHlhakVnUzlIVitoMG4zRG5kSlRj?=
 =?utf-8?B?Q0d5UTl2UFZxOUtnYk5ZbUhwdE00citnRFVRNWkvRWYveGZwbmg2eDhoMlNt?=
 =?utf-8?B?SVpMRTRITktiSElhZmxza0daTmdva0JVUmkxRllTbjRDM3RsTGdyRG9USksy?=
 =?utf-8?B?cFdIUlN2bHVGVkJFN2FzL2VUa3RkVC9haDlkQXRyYlZmdEJvTjl1a2o5WC9j?=
 =?utf-8?B?MlhtMmZRSHFnbWZYM0xGNS9UeDJONi9FZkM4VUdrM0ppOHlhS3RWWG4wcHhI?=
 =?utf-8?B?aE5zTThWK0E4MjlYNFdsdFByR3dhcURScWs0RHNLdXFacnhsNVhLMjBxNmVL?=
 =?utf-8?B?T3JvYVozMmdqNS9xMWsvRmVBdHE5QUxsYWN0aHdWNnEvajMxNnFVZ2l6QW40?=
 =?utf-8?B?NXNscCt0TGlkTFZ4dFN6UXRrU2dxNmNXdnFkQWRMRlh5LzZSa3ZiL2o4Sytl?=
 =?utf-8?B?K0NmVDF2V2Y3cllaR3NtTXU2Tm9HQ2wxb1Vkc0laUkRuRnNBbThoOTc2b2xC?=
 =?utf-8?B?RjNmV3Ava0E3ZXJvQkV5M3k2Y0tpdnRVcDVUb216bmMwZzdyaEFpNkppUFVj?=
 =?utf-8?B?VnJUcmo3OEh5MlZQeDB5b25hRE9oZFN0WVIvb2FwRlRNVWVIZTF1OUZhT25M?=
 =?utf-8?B?NXhMV2krK284eUtPYkxMUE8rM25GS3BEbml2VDFPRHRWYmZla09YaU5nckll?=
 =?utf-8?B?aWdSMG14RHRlMkc0aElCS1d2d1NUNURNKzVsUjBwZkNRdGpsbzdtRUttRDNQ?=
 =?utf-8?B?bG5SWTlPRkNtdjNKVGxDQUNqY2JFZmNOYXhBYXFlRVUzS3lhMUxteXI4SURX?=
 =?utf-8?B?R1RZaUFaM2lFUjc5eUlIcUMwR3kyZWN3MDRLNk1TWktTaGlpc2NPMktZejNo?=
 =?utf-8?B?UGVORnNabG8yK0ZKL0JTaVBRc0JXV0RGSTlFYWdybjRPb2hDVGNXRUVQdXA5?=
 =?utf-8?B?S3pGbzU2aXpreUV0YlFUbXBFcVErNFJBVUtEQ2dueWxhL0IwSFB0STgwK2N4?=
 =?utf-8?B?bCtHbFRqS0NJcnRhZ1ZoOFRwV01USXM1Y0o1MXZHS2lqaWorVU5ocFNIaVFQ?=
 =?utf-8?B?VjRkNWY4SVVXT1ROVXJOVFNLMGFIQlA2Y2g2aGdPaE1KekhLZXN3T05QSm1O?=
 =?utf-8?B?MU5yL0IwSEhYSEZaRnBNbG04aGthVFlOTTljWWQ0b3ZKSnE3Q2c5cHZRUU1K?=
 =?utf-8?B?YktZZTBuRzFWNEw1TVZwbHZLSTY2aVRqcGNUUXdNOE1NNVJGOGhpVklVL0Rz?=
 =?utf-8?B?M2hJSDNHYTVNZllBak0yN0s2RmNrUlNMekgvZUVVYzViT0UzZUpVN2tobnBp?=
 =?utf-8?B?bU9TckY2SzRuc3ZGOGUxSEhLUmdtWlhKQTN6Ym1yWGErZ3MxVjltTEZDVXIr?=
 =?utf-8?B?ZlNkMGFEb29PdlRaN0l3eFp6RXFkVGJLZytJWERvSmJMMFBVeWxKWnROaVlY?=
 =?utf-8?B?Y3JIeURoNVg1UUc1MjA5ZmpZTUdiRy9PMk5YRTNrMFJoZ0hkTjFPZnJaam9i?=
 =?utf-8?B?SXVscGJkU0dGUmMvZFdkQzFKY3ZsSzlVcVFCY1YxY2RNUlkrWklPcTFPa3RG?=
 =?utf-8?B?ZzREZXM2eXFTMXlaSWZEbDlzMllZMVl6eDNiYUJNa20rYVdoVGVQM3M2ZG9F?=
 =?utf-8?B?TGR4bjVYcDU5MCtjUVdsMWZkN29hS00xak5HelF2YXQ5UmhCbTJnZzZ6U28v?=
 =?utf-8?B?WE9GbmIya1lIa1FJcGVPeG9JUWl5Nmw3RWh3ZWFDeUhvY1Y2WFozYitWV2pL?=
 =?utf-8?B?S1VEZ2g1STIvdUxBS2pKazNubmJlUTU2OFVPNld3S28yb3EvWUYvZW03QUJI?=
 =?utf-8?Q?77570HusCVA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXZNbitWdXk3YmF1WGVJaGVWbGxqWG8rM1U0NWdsRC82c3MrbnB2V1JGTEVo?=
 =?utf-8?B?R3N1WkVtWnAvSHJsNXVNbmpnVWd4MEJ1VEJ4cmwzSmZVSFdFSTk4dE9PQ2kx?=
 =?utf-8?B?QlF0dGVDY2NTazdTeWFsc01mZDF0Z2VCaFhhZ1Z1Zm1IMVc2amNjL0kvaEI3?=
 =?utf-8?B?Nk93aXZxdGdVdldhQ0V2dk5NN3VQa3dqT1FLbDY0NFdTcVdsYWp6NWtBRmFq?=
 =?utf-8?B?TDg0SGgyN2oyV3BBRkJsbzZDV1lGbCtQR0lnKzh4SnVDK1A2d3JLd2lPSldI?=
 =?utf-8?B?Z1hQUWdvYmtwbnRzY2dyVzhLZEpxYURUUjRpKy9wTFZmU3B3a1JkZSsycmp4?=
 =?utf-8?B?ZlVwUzRKWitVTnBodnFTMEJMWHZmUUZGZmMzY2thd3FDcStlaFJ4STZZaS9U?=
 =?utf-8?B?WHNnNFZUaE56QTZFNWtLSThNRm1URmw3UlAvWUdyODgxaUVYY01yQWxRcm5x?=
 =?utf-8?B?TnVRZHpsK1NFdkxucHJ2Q2xBWEQ1VDNYekdGdzhZUHRQeTkyUEcwd0tzNnNL?=
 =?utf-8?B?M3loUStKcFV5UHF0YmprWHNHTC8vQm9aRVovSlZBUEhtcWZGb056SjB5VG5o?=
 =?utf-8?B?VTQ3bGJIQU5hemVrTGhVSVlnOFZDYnR0cENUME1YRUxsbVMyOU5HeTlaREhG?=
 =?utf-8?B?RHJWbnhkSFZYaHJRSGRBcktXZXRid1RuSEtVcnU3WjhHbGZGQmNuZzNGcWly?=
 =?utf-8?B?UFNpNjJTVFNGMVZCT1U5TytTR1g2NHRZTHk0Z2dTRC9iSVVlcHJVZ1lyYWds?=
 =?utf-8?B?RlZBQ05YT3I2dDEyQlYwbnVJZDUrZVJScjEyTDk4WHJsZEdna005bXpXYmtV?=
 =?utf-8?B?WmIvYm4yc3RuTHhEV0IzZnVTMUV1UU5KWnFuM0FkcGpOcUVwTXduQTdSaTV4?=
 =?utf-8?B?Rk8zTEpSMEJ2aVRKZkVZQllkTkVGaldwTUlLWE9XNHRKRllsSi95S3hBSzU5?=
 =?utf-8?B?OFY1UU9iTWtIc0dVTnJmbUZEd1VOeTFIN2VOZG5ON1VQdnByNXF4Vmhkb0VK?=
 =?utf-8?B?blZpSHkvS1NMMjlKZkYwdy8yT2V1S3pCSjIyNTlZZnZrQUZTdnUrVXJnU1pv?=
 =?utf-8?B?QW9ValVZL0licmk2dCtFa1dXcHZIRmMzV3gwWHlWRTAyOExOSVR4cWVyQy8z?=
 =?utf-8?B?U0p4RWxwQVR3Z0ZKUGV1M1h6Yjc0dy9VTS9wY04zMTNveUYyb0dOK3JNa1g1?=
 =?utf-8?B?RVJxN3VBaVMyWGZNZi9DbXQ4NnB0UkpxU00wVDVJczlZUHNObDhPY0sxNmtO?=
 =?utf-8?B?UUd6QS8rcXNYWno3cmFZM0dBei8yc2d1UXVZVDg4MzU2VTZjNldnTmRxR0Ny?=
 =?utf-8?B?bXJ5NSs5WTBWR2FSbmp1RWJZR3k4WHliY3ByS0V5YWdRdTNHNWdMYVA3RTB1?=
 =?utf-8?B?M2FNTUE2L2xYQUEwcGxBSXkyeWZqbFFOdHdZQkJxbWRWSlV0Y24zMmxxSU9r?=
 =?utf-8?B?WUhOWGJtaW5WMjBvR05xUk91YlRCVXQ5Q1V3Q013dHd4TXgyNUhoWGcvSjlC?=
 =?utf-8?B?THh2dDBOWloxOWdBMnF2bWFlN0FxVnhZaE9YZC92N1oydDlSQzh0MVNRd1Jl?=
 =?utf-8?B?cmxxUmM0Wk1BVUo0STMxb1dNUXp6dmtFcU5remVaM3R4Z2lJeTJ4d2llMTFl?=
 =?utf-8?B?eDZFTlBibUowaGNBdmF0TWNXdmt3eE04M0FTQWZIeUMzTVhETmZnOG1DbTJQ?=
 =?utf-8?B?Q09yUDZCT0JFdWxUbVBHMlZjTjRJcHRyL292S0hvcU9NbGpUK0k0QnBxTDVr?=
 =?utf-8?B?RjZ1Nk1GaHlldjdzNFY0SWliQTFzWnRwSkhCdVlYUHFJWEJiQ2luQnhIbUVw?=
 =?utf-8?B?QXhsOXVzMldFMVR0TXltNFlFT0NkVVI4ZHZqMlFkWVQrS1Y5ZzVhMWpZc2tU?=
 =?utf-8?B?cUVPUmZFckhjc2ZtSW9FZHhhc2lMWnc1ZEtGeU9ML2hmZ2N1TndXZUZ5OHJ3?=
 =?utf-8?B?OFM1ZTRINTROYkxaY0tIaVdTZ3FRQmJxS1NvRDFtQ2tCMUl4MGRzSWNWY3Nv?=
 =?utf-8?B?eTlXTjUyL2VtQjQ4dXVEUSttSkM0eVRvYTVObm1yY2tmNHNFSlJMellHL21s?=
 =?utf-8?B?a0NoblRGSHVvZEhmNGRIVDYzV1VvL0Zad2UzTERXbjZORkVNemVxTEhwdWRx?=
 =?utf-8?B?bFREUVFNTFQ0WFVVMEg0eWdNU2FVL1lCRk1Qam9CQ1plQTExTml1RjlDOXNa?=
 =?utf-8?B?VFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dace2aee-6271-4026-3523-08dcc3521c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 09:01:00.9234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQTXKuyXCk67j7D9coI6VLIGARGovslaKMIQUMCvKJqhSK1MFV3atqO0To/6obQDD3LbxAdSka/ZM9zeKMTnqEJXOWUPLihrWUowvaO529A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5820

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBGcmlkYXksIEF1
Z3VzdCAyMywgMjAyNCA5OjU4IEFNDQotDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZzsgQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJl
bmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEwLzE2XSBwaHk6IHJlbmVzYXM6IHJj
YXItZ2VuMy11c2IyOiBBZGQgc3VwcG9ydCB0byBpbml0aWFsaXplIHRoZSBidXMNCj4gDQo+IEhp
LCBCaWp1LA0KPiANCj4gT24gMjMuMDguMjAyNCAxMDozNSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4g
SGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFRodXJz
ZGF5LCBBdWd1c3QgMjIsIDIwMjQgNDoyOCBQTQ0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMTAvMTZd
IHBoeTogcmVuZXNhczogcmNhci1nZW4zLXVzYjI6IEFkZCBzdXBwb3J0IHRvDQo+ID4+IGluaXRp
YWxpemUgdGhlIGJ1cw0KPiA+Pg0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+IFRoZSBSZW5lc2FzIFJaL0czUyBu
ZWVkIHRvIGluaXRpYWxpemUgdGhlIFVTQiBCVVMgYmVmb3JlIHRyYW5zZmVycmluZyBkYXRhIGR1
ZSB0byBoYXJkd2FyZQ0KPiBsaW1pdGF0aW9uLg0KPiA+PiBBcyB0aGUgcmVnaXN0ZXIgdGhhdCBu
ZWVkIHRvIGJlIHRvdWNoZWQgZm9yIHRoaXMgaXMgaW4gdGhlIGFkZHJlc3MNCj4gPj4gc3BhY2Ug
b2YgdGhlIFVTQiBQSFksIGFuZCB0aGUgVUJTIFBIWSBuZWVkIHRvIGJlIGluaXRpYWxpemVkIGJl
Zm9yZQ0KPiA+PiBhbnkgb3RoZXIgVVNCIGRyaXZlcnMgaGFuZGxpbmcgZGF0YSB0cmFuc2Zlciwg
YWRkIHN1cHBvcnQgdG8gaW5pdGlhbGl6ZSB0aGUgVVNCIEJVUy4NCj4gPj4NCj4gPj4gQXMgdGhl
IFVTQiBQSFkgaXMgcHJvYmVkIGJlZm9yZSBhbnkgb3RoZXIgVVNCIGRyaXZlcnMgdGhhdCBlbmFi
bGVzDQo+ID4+IGNsb2NrcyBhbmQgZGUtYXNzZXJ0IHRoZSByZXNldCBzaWduYWxzIGFuZCB0aGUg
QlVTIGluaXRpYWxpemF0aW9uIGlzDQo+ID4+IGRvbmUgaW4gdGhlIHByb2JlIHBoYXNlLCB3ZSBu
ZWVkIHRvIGFkZCBjb2RlIHRvIGRlLWFzc2VydCByZXNldCBzaWduYWwgYW5kIHJ1bnRpbWUgcmVz
dW1lIHRoZQ0KPiBkZXZpY2UgKHdoaWNoIGVuYWJsZXMgaXRzIGNsb2NrcykgYmVmb3JlIGFjY2Vz
c2luZyB0aGUgcmVnaXN0ZXJzLg0KPiA+Pg0KPiA+PiBBcyB0aGUgcmVzZXQgc2lnbmFscyBhcmUg
bm90IHJlcXVpcmVkIGJ5IHRoZSBVU0IgUEhZIGRyaXZlciBmb3IgdGhlDQo+ID4+IG90aGVyIFVT
QiBQSFkgaGFyZHdhcmUgdmFyaWFudHMsIHRoZSByZXNldCBzaWduYWxzIGFuZCBydW50aW1lIFBN
IHdhcyBoYW5kbGVkIG9ubHkgaW4gdGhlIGZ1bmN0aW9uDQo+IHRoYXQgaW5pdGlhbGl6ZSB0aGUg
VVNCIEJVUy4NCj4gPj4NCj4gPj4gVGhlIFBIWSBpbml0aWFsaXphdGlvbiB3YXMgZG9uZSByaWdo
dCBhZnRlciBydW50aW1lIFBNIGVuYWJsZSB0byBoYXZlDQo+ID4+IGFsbCBpbiBwbGFjZSB3aGVu
IHRoZSBQSFlzIGFyZSByZWdpc3RlcmVkLg0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gdXNlciBmb3Ig
dGhpcyBwYXRjaC4gVGhlIGZpcnN0IHVzZXIgaXMgUlovRzNTIGFuZCB5b3UNCj4gPiBzaG91bGQg
bWVyZ2UgdGhpcyBwYXRjaCB3aXRoIG5leHQgb25lLg0KPiANCj4gSSB0aGluayB0aGlzIGlzIGEg
bWF0dGVyIG9mIHRhc3RlLi4uIFRoaXMgaXMgaG93IEkgdXN1YWxseSBmb3JtYXQgdGhlIHBhdGNo
ZXMgKGZvciBzY2VuYXJpb3MgbGlrZQ0KPiB0aGlzKSBhbmQgZ290IG5vIHJlcXVlc3QgZm9yIHNx
dWFzaGluZy4NCg0KVGhhdCBpcyBzdHJhbmdlIGZvciB0cml2aWFsIHBhdGNoZXMgbGlrZSB0aGlz
Lg0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KDQo+ID4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+PiAt
LS0NCj4gPj4gIGRyaXZlcnMvcGh5L3JlbmVzYXMvcGh5LXJjYXItZ2VuMy11c2IyLmMgfCA1MA0K
PiA+PiArKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVzYjIuYw0KPiA+PiBiL2RyaXZlcnMvcGh5
L3JlbmVzYXMvcGh5LXJjYXItZ2VuMy11c2IyLmMNCj4gPj4gaW5kZXggNzU5NGY2NGViNzM3Li5j
ZjQyOTljZWE1NzkgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvcGh5L3JlbmVzYXMvcGh5LXJj
YXItZ2VuMy11c2IyLmMNCj4gPj4gKysrIGIvZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1n
ZW4zLXVzYjIuYw0KPiA+PiBAQCAtMTksMTIgKzE5LDE0IEBADQo+ID4+ICAjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5o
Pg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KPiA+PiArI2lu
Y2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+DQo+
ID4+ICAjaW5jbHVkZSA8bGludXgvdXNiL29mLmg+DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvd29y
a3F1ZXVlLmg+DQo+ID4+DQo+ID4+ICAvKioqKioqKiBVU0IyLjAgSG9zdCByZWdpc3RlcnMgKG9y
aWdpbmFsIG9mZnNldCBpcyArMHgyMDApICoqKioqKiovDQo+ID4+ICAjZGVmaW5lIFVTQjJfSU5U
X0VOQUJMRQkJMHgwMDANCj4gPj4gKyNkZWZpbmUgVVNCMl9BSEJfQlVTX0NUUgkweDAwOA0KPiA+
PiAgI2RlZmluZSBVU0IyX1VTQkNUUgkJMHgwMGMNCj4gPj4gICNkZWZpbmUgVVNCMl9TUERfUlNN
X1RJTVNFVAkweDEwYw0KPiA+PiAgI2RlZmluZSBVU0IyX09DX1RJTVNFVAkJMHgxMTANCj4gPj4g
QEAgLTQwLDYgKzQyLDEwIEBADQo+ID4+ICAjZGVmaW5lIFVTQjJfSU5UX0VOQUJMRV9VU0JIX0lO
VEJfRU4JQklUKDIpCS8qIEZvciBFSENJICovDQo+ID4+ICAjZGVmaW5lIFVTQjJfSU5UX0VOQUJM
RV9VU0JIX0lOVEFfRU4JQklUKDEpCS8qIEZvciBPSENJICovDQo+ID4+DQo+ID4+ICsvKiBBSEJf
QlVTX0NUUiAqLw0KPiA+PiArI2RlZmluZSBVU0IyX0FIQl9CVVNfQ1RSX01CTF9NQVNLCUdFTk1B
U0soMSwgMCkNCj4gPj4gKyNkZWZpbmUgVVNCMl9BSEJfQlVTX0NUUl9NQkxfSU5DUjQJMg0KPiA+
PiArDQo+ID4+ICAvKiBVU0JDVFIgKi8NCj4gPj4gICNkZWZpbmUgVVNCMl9VU0JDVFJfRElSUEQJ
QklUKDIpDQo+ID4+ICAjZGVmaW5lIFVTQjJfVVNCQ1RSX1BMTF9SU1QJQklUKDEpDQo+ID4+IEBA
IC0xMTEsNiArMTE3LDcgQEAgc3RydWN0IHJjYXJfZ2VuM19jaGFuIHsNCj4gPj4gIAlzdHJ1Y3Qg
ZXh0Y29uX2RldiAqZXh0Y29uOw0KPiA+PiAgCXN0cnVjdCByY2FyX2dlbjNfcGh5IHJwaHlzW05V
TV9PRl9QSFlTXTsNCj4gPj4gIAlzdHJ1Y3QgcmVndWxhdG9yICp2YnVzOw0KPiA+PiArCXN0cnVj
dCByZXNldF9jb250cm9sICpyc3RjOw0KPiA+PiAgCXN0cnVjdCB3b3JrX3N0cnVjdCB3b3JrOw0K
PiA+PiAgCXN0cnVjdCBtdXRleCBsb2NrOwkvKiBwcm90ZWN0cyBycGh5c1suLi5dLnBvd2VyZWQg
Ki8NCj4gPj4gIAllbnVtIHVzYl9kcl9tb2RlIGRyX21vZGU7DQo+ID4+IEBAIC0xMjUsNiArMTMy
LDcgQEAgc3RydWN0IHJjYXJfZ2VuM19jaGFuIHsgIHN0cnVjdCByY2FyX2dlbjNfcGh5X2Rydl9k
YXRhIHsNCj4gPj4gIAljb25zdCBzdHJ1Y3QgcGh5X29wcyAqcGh5X3VzYjJfb3BzOw0KPiA+PiAg
CWJvb2wgbm9fYWRwX2N0cmw7DQo+ID4+ICsJYm9vbCBpbml0X2J1czsNCj4gPj4gIH07DQo+ID4+
DQo+ID4+ICAvKg0KPiA+PiBAQCAtNjUwLDYgKzY1OCwzNSBAQCBzdGF0aWMgZW51bSB1c2JfZHJf
bW9kZSByY2FyX2dlbjNfZ2V0X2RyX21vZGUoc3RydWN0IGRldmljZV9ub2RlICpucCkNCj4gPj4g
IAlyZXR1cm4gY2FuZGlkYXRlOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiArc3RhdGljIGludCByY2Fy
X2dlbjNfcGh5X3VzYjJfaW5pdF9idXMoc3RydWN0IHJjYXJfZ2VuM19jaGFuDQo+ID4+ICsqY2hh
bm5lbCkgew0KPiA+PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGNoYW5uZWwtPmRldjsNCj4gPj4g
KwlpbnQgcmV0Ow0KPiA+PiArCXUzMiB2YWw7DQo+ID4+ICsNCj4gPj4gKwljaGFubmVsLT5yc3Rj
ID0gZGV2bV9yZXNldF9jb250cm9sX2FycmF5X2dldF9zaGFyZWQoZGV2KTsNCj4gPj4gKwlpZiAo
SVNfRVJSKGNoYW5uZWwtPnJzdGMpKQ0KPiA+PiArCQlyZXR1cm4gUFRSX0VSUihjaGFubmVsLT5y
c3RjKTsNCj4gPj4gKw0KPiA+PiArCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZGV2
KTsNCj4gPj4gKwlpZiAocmV0KQ0KPiA+PiArCQlyZXR1cm4gcmV0Ow0KPiA+PiArDQo+ID4+ICsJ
cmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChjaGFubmVsLT5yc3RjKTsNCj4gPj4gKwlpZiAo
cmV0KQ0KPiA+PiArCQlnb3RvIHJwbV9wdXQ7DQo+ID4+ICsNCj4gPj4gKwl2YWwgPSByZWFkbChj
aGFubmVsLT5iYXNlICsgVVNCMl9BSEJfQlVTX0NUUik7DQo+ID4+ICsJdmFsICY9IH5VU0IyX0FI
Ql9CVVNfQ1RSX01CTF9NQVNLOw0KPiA+PiArCXZhbCB8PSBVU0IyX0FIQl9CVVNfQ1RSX01CTF9J
TkNSNDsNCj4gPj4gKwl3cml0ZWwodmFsLCBjaGFubmVsLT5iYXNlICsgVVNCMl9BSEJfQlVTX0NU
Uik7DQo+ID4+ICsNCj4gPj4gK3JwbV9wdXQ6DQo+ID4+ICsJcG1fcnVudGltZV9wdXQoZGV2KTsN
Cj4gPj4gKw0KPiA+PiArCXJldHVybiByZXQ7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gIHN0YXRp
YyBpbnQgcmNhcl9nZW4zX3BoeV91c2IyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpICB7DQo+ID4+ICAJY29uc3Qgc3RydWN0IHJjYXJfZ2VuM19waHlfZHJ2X2RhdGEgKnBoeV9k
YXRhOyBAQCAtNzAzLDYgKzc0MCwxNSBAQA0KPiA+PiBzdGF0aWMgaW50IHJjYXJfZ2VuM19waHlf
dXNiMl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiAgCQlnb3RvIGVy
cm9yOw0KPiA+PiAgCX0NCj4gPj4NCj4gPj4gKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBj
aGFubmVsKTsNCj4gPj4gKwljaGFubmVsLT5kZXYgPSBkZXY7DQo+ID4+ICsNCj4gPj4gKwlpZiAo
cGh5X2RhdGEtPmluaXRfYnVzKSB7DQo+ID4+ICsJCXJldCA9IHJjYXJfZ2VuM19waHlfdXNiMl9p
bml0X2J1cyhjaGFubmVsKTsNCj4gPj4gKwkJaWYgKHJldCkNCj4gPj4gKwkJCWdvdG8gZXJyb3I7
DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICAJY2hhbm5lbC0+c29jX25vX2FkcF9jdHJsID0gcGh5
X2RhdGEtPm5vX2FkcF9jdHJsOw0KPiA+PiAgCWlmIChwaHlfZGF0YS0+bm9fYWRwX2N0cmwpDQo+
ID4+ICAJCWNoYW5uZWwtPm9iaW50X2VuYWJsZV9iaXRzID0gVVNCMl9PQklOVF9JRENIR19FTjsg
QEAgLTczMyw5ICs3NzksNg0KPiA+PiBAQCBzdGF0aWMgaW50IHJjYXJfZ2VuM19waHlfdXNiMl9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiAgCQljaGFubmVsLT52YnVz
ID0gTlVMTDsNCj4gPj4gIAl9DQo+ID4+DQo+ID4+IC0JcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgY2hhbm5lbCk7DQo+ID4+IC0JY2hhbm5lbC0+ZGV2ID0gZGV2Ow0KPiA+PiAtDQo+ID4+ICAJ
cHJvdmlkZXIgPSBkZXZtX29mX3BoeV9wcm92aWRlcl9yZWdpc3RlcihkZXYsIHJjYXJfZ2VuM19w
aHlfdXNiMl94bGF0ZSk7DQo+ID4+ICAJaWYgKElTX0VSUihwcm92aWRlcikpIHsNCj4gPj4gIAkJ
ZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgUEhZIHByb3ZpZGVyXG4iKTsgQEAgLTc2
Miw2DQo+ID4+ICs4MDUsNyBAQCBzdGF0aWMgdm9pZCByY2FyX2dlbjNfcGh5X3VzYjJfcmVtb3Zl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+ICAJaWYgKGNoYW5uZWwtPmlzX290
Z19jaGFubmVsKQ0KPiA+PiAgCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRldiwgJmRldl9h
dHRyX3JvbGUpOw0KPiA+Pg0KPiA+PiArCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGNoYW5uZWwtPnJz
dGMpOw0KPiA+PiAgCXBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gPj4gIH07DQo+
ID4+DQo+ID4+IC0tDQo+ID4+IDIuMzkuMg0KPiA+DQo=

