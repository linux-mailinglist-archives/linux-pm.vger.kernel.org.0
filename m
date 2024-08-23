Return-Path: <linux-pm+bounces-12806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34295C854
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77097B20FCA
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118C6146A67;
	Fri, 23 Aug 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="gFeZBjiz"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010041.outbound.protection.outlook.com [52.101.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C312E644;
	Fri, 23 Aug 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402775; cv=fail; b=Su1Cu3E7BrbLsZKJALK2Op7pO1tIqxRLQAhRb9gLgxqHGpA5cgRcyENOKb3lhxsvUZFYWBsh9cGxrykVcNbmt58ZR9MO9tWS+CEswL8hBNSiUn2fXYjC92MqU/8x2JqA+FDP7fB98V8RCoKKD9wD1WyLE25yo3aoTWIksBegwqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402775; c=relaxed/simple;
	bh=GN7WrPoDiV10/YGB/R0KqWzSNdeL4tc+XnBhxn+y7Ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jw8QI9uvhG6HsA253fbWWJpHzJjpUdeQF2f4A2m0OSULoTfFDIMX1YURBuFFGkpskbsZt7wDQRWZHj366MPNROWYf47jpqLHlEiEAEwDFQf/SMYnl5OCzlugqG8svgtHgQUqjHyCIf7UXYQy9u5/LOC6E78NFBVmkjG3xr3Wq3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=gFeZBjiz; arc=fail smtp.client-ip=52.101.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8magRaqWOiRd0P8jlP512AJfGGRQZ3BcresP58KOw48XaOB1Rf3/ALLaO5Y0VH+UdHl6wE6aO82VaTh9MOHDVGGKCceFDvjJRjDSV5y0sZxRynahQ+5s46kGr5LnUr1J4df7CrgXuCQa1vWEO9BXUz7v+z0Y8f8+2teP01wGQGSLdvaQMLt7xVNOAWtjmNmhNA7JTr/jDheerOTzfQUVbG4DKSbBwg1Yxn8rGzUHJ1ztuSBEVa4szIWrAUQ1+kflfWoRQoDFrpXlk7sM69fhnOGDTTqzwpfW/JA0SEqcwQyhAIkqks9cPp7xnAaH3jCHZGjPVEs2V/c+0dWnC5A/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN7WrPoDiV10/YGB/R0KqWzSNdeL4tc+XnBhxn+y7Ms=;
 b=VdsFAixEuJ0a+FFBlbZH49O2TC7WaLWO7vAzAwgqxpK02gSez+ehh7N5ae0PiLQ9pIUGPIW6BaTYz2bQDtVqqNIK5c2F9i+emILdhXdOU9G5dJ6DMce+sgZjzZlvPDU3UFn7tFPqM/l3xHfb6ldWRritIiJpVsWD4zRiMlBGLwN5+en1rUFkQgKAdYvZYx9g/7w+lh4S1EHMkUY9EKG+pLLz/WqLOzT8xNCMGgBOtrgLHP9KZmkQ62Uujo9BGCbyzkcdmioN0yo2XoiPmT4z9adI6t/ZeJ9/HCDHLZvPz2gwV0MfuGHLlfRZMe7arNM9BLK1f6oGPGg2iPXd+KNS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN7WrPoDiV10/YGB/R0KqWzSNdeL4tc+XnBhxn+y7Ms=;
 b=gFeZBjizBykVHoXLEhNfm2wrc4s3Jslz0lTh5DFr4qC4PJwHmwIC/kN77RY1lpGDN5nCNZb1umXnjGN77My22xgD8nPpu3ijeKYgOHqUMehXqVux/83SAr4OTmfiJJOs7nuPWdcXZM2tnX645K2AE0nbA4HOxD9ni7r2Nfz/A7o=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYAPR01MB5691.jpnprd01.prod.outlook.com (2603:1096:404:805a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 08:46:08 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 08:46:08 +0000
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
Subject: RE: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
Thread-Topic: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
Thread-Index: AQHa9Kf1es/yPNhZeEG/EOaLUabxzrIzfjMQgAEIvYCAAADxoA==
Date: Fri, 23 Aug 2024 08:46:08 +0000
Message-ID:
 <TY3PR01MB1134687634BB1B11B419C58E086882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-9-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346B5C5D9AA883B7736A5C3868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <59f4d28b-5b9b-427a-baca-739fc03a5cc1@tuxon.dev>
In-Reply-To: <59f4d28b-5b9b-427a-baca-739fc03a5cc1@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYAPR01MB5691:EE_
x-ms-office365-filtering-correlation-id: 086913d9-cfa6-4b63-a3f9-08dcc3500824
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?czl4aEtQOU5iT0JubndDa09QNjVhL2I0RXoydzUrNk9uQ3hRZmUwU0k0dU83?=
 =?utf-8?B?VVVFQUdnaDJrZUJEQUhremk2NGlpVDIvYk14MlBIbU96YlRBRG5kbFQvcTFN?=
 =?utf-8?B?eDNGSEJMRXNnclkzelZMSzVRc3IwWVA5eHdVYTFaVXZFRktwYWdqSGNxekhx?=
 =?utf-8?B?R2JmVFVxbTRpdDl4OXN4WlFOSDBDVmVIWUIxYnM1L3UwWERNRWh6LzV1Q2wz?=
 =?utf-8?B?WXE3ZldWSGNvcE0rZmFEQXpway9jM1Z5c2laaHczM1lZTWZvS0ZjdXZITGVv?=
 =?utf-8?B?eGs2TXUyRTBndkhHWFhkUnJZclVFbGFaMXhhNFRNSXVjSzErbEJ2TGRQeVVT?=
 =?utf-8?B?VjdCRjljL3orMWtIZENyZjV4U3FUazZYTkp2L2crb3A3NjlyVWNNT3lWUHFv?=
 =?utf-8?B?N0VUa2s1L0pCTEoyem5IaFhvd1ZxVEN3RFAyaVhUQ1pWOWltZ2d4eno4YzFz?=
 =?utf-8?B?aXhHci91NjBmcVBVbmpPenZ3dWlZNDBpb3dHeVRydFFxMFpVcUxNRml1TnRW?=
 =?utf-8?B?VEVxQlZ3MFhQYW01cjg5dXpzSXEyV0dzT1lwS0t0RVRVcUcxNzJRL1l3Yitz?=
 =?utf-8?B?Q3lNcTR5Yk5KMzJycU1nTUxld2x0ak1SR1UzYnJoYTVuQ201UHpJbzVZU0FB?=
 =?utf-8?B?WkRCWi9kRUNBQjhSdVVvaG4vZHVxY2gyRFE2akpZcnRGbkhLM0FTODVxbmxr?=
 =?utf-8?B?TUpYUm1KaGROYXhON0U0MHFnc3JFMHZPVVNleHV0eUFMQW5NZmJ3MUJwUGVI?=
 =?utf-8?B?UFZLYkZIbGhQZ05HOGMyZTF0NUJ5SFVyTWRyNW1IMWY4TXh4MFpnWGRCTTRO?=
 =?utf-8?B?bnVyRmpxeXVzWVFkRHBCQjI2SllRN2NyT3czd3l2T3NRczArZHJLb3pqcjR5?=
 =?utf-8?B?UGNjVEhITW1RTkM0TGxGSnVrb2NQbS9tQ3pqYXVKV1NtSXBHcTJHZ1ZWRmVt?=
 =?utf-8?B?aUdYSkptVDJEZllRcndHVTk2MzV2WDlRUmNEVW1xdUh4anlqOURxemhMS2lQ?=
 =?utf-8?B?amFwK0VDeXdzUzk5UWo4T2ptczlLT0NXd1U1MzJLY0tKdVBIaWhXRGM5aG4y?=
 =?utf-8?B?LzlnQm0xb0NvdHdrb0s3Tm43THJUbWp6bCtiWmpiWWlzbHRhQndobzdFcVBK?=
 =?utf-8?B?MXpOYmphSDh3OWRoSjZjYkMxUDFldVUzMzJ0cG0yNm5heE5jTm5sZ1ZIYUFz?=
 =?utf-8?B?YUs4M01YaHpkQTF6ajhkWlNLOEhqTXlWRVZCYU1yZXdvWFNwUzRlWmNCeGRR?=
 =?utf-8?B?U1BuQnVzVUN4TEN5cVF6UG1tSG1KVkx6VDVOS1VNVXd4Qi95U1dmWHdhYXR2?=
 =?utf-8?B?TWxiT3NCbWR4WnlYVHMwZHZBbERFbm4vZ29MNjgvQjhnVmxBd0E0MGlwUzdu?=
 =?utf-8?B?Vjd4WTBzWVVaV2JHRTJRVmZQalp2WXhUSkRMTUFxamZMN0x0REQ4OE1NN0Q0?=
 =?utf-8?B?VnBlRUZad1JqdkpWMUJYWUpLRGt3ZjBtK1pWbFVRcC9oeGY0OFZzVkZ6MHRH?=
 =?utf-8?B?elVSZkNLaEtIN1NMRXRkcnZNWmpsaHQ2M2tBZzZyNFVIYTZtV3cwbUdLa3R2?=
 =?utf-8?B?R1BMN2JKQWxlT0hMejVxNHNuTmpEOWtqNDRzQWtnRWNxUjF0NHBvcXdFR2NQ?=
 =?utf-8?B?Zm43MnMxYTJQZk1OT1cySGN3Yzh5TmVwdEpZQkp3MTJBMFh4V29Ua096MVpt?=
 =?utf-8?B?dmxudlFDN3YxaTNmZlB4di9vU0ZoTHN1YmNVL2VMbTk0TmFzNXJOTEpEeFZ1?=
 =?utf-8?B?bkRFNnNOb1UzT05QM1hxYmRkRXR3UE1CZUYweTZWeTlzYU5hQUFUd241RStV?=
 =?utf-8?B?M1k1QVhlbnBHYS9RWWFJMzRqZDdzTmhDczZFVVQxVitvV1puZWFPT2xnVnZs?=
 =?utf-8?B?ZHNMT1NpMjloTDI4VE9QZ3BneTNqNHpnQW0ybkkyaFl0cDlpNTlKMUVxUjZ5?=
 =?utf-8?Q?1IRhLCqB7Gc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnFydFArKzZMaHVTdnhQcTdxS24rMG5vSmJnb1MyTmx2ZU9YSFk3VmFhWTA4?=
 =?utf-8?B?NnhuRFMrSUQ0clpuL3RBU0Npb1oyb3ZLblRIR1NJVmwwRzgyZEg3eDJ6WENa?=
 =?utf-8?B?LzVaUFl3a2FNOG5VOGpEbzJjSWV3QXJvd3ZYeGx2ajgwdENSaW1nSWpyRXd4?=
 =?utf-8?B?REg0eVFUTFdjRVRsTjNLS1dsY1VBV3cyOWxYUlovLzkwZTBJTEtHeWovYnRB?=
 =?utf-8?B?MjJFUkp5UnllMTBWYVg3dzdCdEU2VGNMYXA3WHdoc0tUQnNtYWtHVWQ5QWVI?=
 =?utf-8?B?cVdaVjJCbmhtUjUzbndrelp4Ym9YWkJidFNOcXNvb0lsWGhRYzFJVEFFSUlj?=
 =?utf-8?B?NkJDYWVQRTZITlpQWUVPb3FINGNCcUlFcS9RMFpyQUxvL2l1Q0QyR1FIYWZh?=
 =?utf-8?B?bHI2Q2tSajJHL3VUTWRndDJVWmtRRFBXUHRBSVZFd1hCc045ZHNrcGxnYzlD?=
 =?utf-8?B?TVB3MW84dGtlc2tuOHpHNm04SGI1REk3WnBzRXJxalZuNUVoSXlITHU1Ty9i?=
 =?utf-8?B?WGhsdkFLbHNOSmt3NVpPVW1KQndZZERIUHZqZGtrUWlBQTlOdzUySjdlMUFO?=
 =?utf-8?B?b1ljTkRwWE5ybzRyelBUckpZeVViS0w5SjVRQVJQT1ZOSXN5VFpleWMrcnV2?=
 =?utf-8?B?bDc5TmJtUkUyemkyTEloUHZzQ0c0K2lSR2MxVENVZW42bndBZ2FzRUdLdC9R?=
 =?utf-8?B?YzlHWjVzbW4xeWQzUzd3eEF3S3ZFOGpmdFppcmV1anBmc2FMcXhSOEt4aDN1?=
 =?utf-8?B?Uk4zTnRSc1R1VW5INEJXNHRPZ0VWSWg4UHlPOUVDMzUvUEdaTlA1MnE3YThV?=
 =?utf-8?B?bFJ6MmVmNnhvT2R1UW90WVorMWtVbmlaUHcvdy9nTUt4ZTYyUUpZVnd6R0Ro?=
 =?utf-8?B?SSthbmM5NGdvVy94TkFyOXozYTJsWkJza1RDYXMyUHdwTS9vVmg5VHNnY29i?=
 =?utf-8?B?MVlKa3liVW1vN0o3TFJ0NE9sNVlwaEovVXNYY09XTWk5VXFZL05QZ1BKeENY?=
 =?utf-8?B?TTMrUlhWMFJPUmJHRHhLTWhtc3BVUG56STBnUWZEclBiNVgvL1JkcEFkWWE3?=
 =?utf-8?B?NUwvb1RIeVg3eTV0ZVZnNEpnR0NMbUZmYXlOeEQrUithQ1E4TnMyUlhWYldq?=
 =?utf-8?B?R1lobmgzZUVScENudzgvZUlackdYSEI1d0pBdkhDZ3lsdUFuOGpHOFBLMDRL?=
 =?utf-8?B?ZkhkSS85cG5KYTd6SlZyVmYyQ0tYLzJrTmY0d21NMFNaU1RjTWkva21obnFp?=
 =?utf-8?B?MWdhb0paOFRTSG8yR2NHLzdxZmYxa0pqK1p4aFR0bXRtN214S2YxazRVUUFY?=
 =?utf-8?B?dmx0RGhRVTcycDcvMURoelY1Rm5hSHJxOHVaUWZuQ3dJeGw0NGJUbm1HZmdm?=
 =?utf-8?B?dmUyRGpFajltV0l6djR4Zy9nbWdmUFREcW5kZ3NzZUtkWFhLS1o0ay9WRjZt?=
 =?utf-8?B?cCt4VWdLVEdlRnNNY2VMbzliNkdLdU8xcDV1anEwMUZNMzAyRWtFR252bk5C?=
 =?utf-8?B?RnIwVlNUNDQxSmpOWXQwYWV6d3pwQmtJckhmTEpyWk1aNTNrUVNkSWxFK1gx?=
 =?utf-8?B?cEtQYlJDWHRuL2NKTCt1eWFwcjJXUVM3ZnZTZm5YTG1FMHNjbDVMMDFWODB4?=
 =?utf-8?B?V1V3aXVFa3dNTGpQRll3OVdKY1o3bnJkcjFZL3QzU3F6Y1FnaVhFOGM0S0lh?=
 =?utf-8?B?YXczWEVlSTVWNWVNZGdLMTd5ajJ1VkUrU2hsdVVWeEc1d3hVLytvL1RLcCtv?=
 =?utf-8?B?blNWdTRSaEFocU91UzY0SGdGSVZjWTJlNGhrNE9RMHRaMWN1S292U3ZmcWlN?=
 =?utf-8?B?K3daYVc2UjBCa2kra1JkZWZacVFFK2I3RWZaTlpGUTRObzBxQ1R4OUNtQ3Vx?=
 =?utf-8?B?ck9oeFoxbHdmbDduR3podWY2RWVMZ0x4M1A1OUt3MFc3ZHd0Nk9YcGhlSk53?=
 =?utf-8?B?R0NCQ3IzWmhxRi9WVElMNkVvYkQ4UDVWc0xQTHdPc3owRWhEOWJwV1ZrTm1X?=
 =?utf-8?B?djBHRUg1akIvYkZnVU5WOWFTOHI1S0tQVUJXQXRzVHI4V2hkSnBWeVhhb3lT?=
 =?utf-8?B?Ky9FQ0Q1dEF4UklqcWxHZ2NqZ0dvditOc214eFkvU2pEdXFIV20rZDNVMHc0?=
 =?utf-8?B?N3d2V0tsRVk1ZXBFQVdiSjRIbWR6QlVva3k3T3RPSzFEV2QzelY5TjE4dkNT?=
 =?utf-8?B?S2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 086913d9-cfa6-4b63-a3f9-08dcc3500824
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 08:46:08.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEsZ6/S9EKzo423bjC0B/qb8rwt4e0wkm7K12UDUW9swp3fxNlZYNiuLNz7bNUgX6yn/OeYMCjY4bSiQrCfhI5nCfgefmpHeOmc7lIp8jbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5691

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBGcmlkYXksIEF1
Z3VzdCAyMywgMjAyNCA5OjQxIEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDgvMTZdIHJlc2V0
OiByemcybC11c2JwaHktY3RybDogQWRkIHN1cHBvcnQgZm9yIFJaL0czUw0KPiANCj4gSGksIEJp
anUsDQo+IA0KPiBPbiAyMi4wOC4yMDI0IDE5OjU5LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBD
bGF1ZGl1LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206
IENsYXVkaXUgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDogVGh1cnNkYXks
IEF1Z3VzdCAyMiwgMjAyNCA0OjI4IFBNDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCAwOC8xNl0gcmVz
ZXQ6IHJ6ZzJsLXVzYnBoeS1jdHJsOiBBZGQgc3VwcG9ydCBmb3INCj4gPj4gUlovRzNTDQo+ID4+
DQo+ID4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2Fz
LmNvbT4NCj4gPj4NCj4gPj4gQWRkIHN1cHBvcnQgZm9yIFJaL0czUyBTb0MuIEl0IG5lZWRzIGl0
cyBvd24gY29tcGF0aWJsZSBhcyBpdCB1c2VzIDINCj4gPj4gcmVzZXQgc2lnbmFscyBhbmQgaXQg
Y2Fubm90IHdvcmsgdy9vIGJvdGggb2YgdGhlbS4gVG8gYmUgYWJsZSB0bw0KPiA+PiBmdWxseSB2
YWxpZGF0ZSB0aGlzIG9uIERUIHNjaGVtYSwgdG9vLCB0aGUgUlovRzNTIHVzZXMgaXQncyBvd24g
Y29tcGF0aWJsZSB3L28gYSBmYWxsYmFjayAoYXMgaWYNCj4gdGhlIGZhbGxiYWNrIHdpbGwgYmUg
dXNlZCB0aGUgUlovRzNTIHdpbGwgbm90IHdvcmsgYW55d2F5KS4NCj4gPg0KPiA+IE90aGVyIHRo
YW4gcmVzZXQvIHBvd2VyIGRvbWFpbiBhcHByb2FjaCBmb3IgaGFuZGxpbmcgVVNCUFdSUkRZIHNp
Z25hbA0KPiA+DQo+ID4gQ2FuJ3QgVVNCUFdSUkRZIHNpZ25hbCBoYW5kbGVkIGluIFNZU0MgZHJp
dmVyIGRpcmVjdGx5PyBTaW5jZSBTWVNDDQo+ID4gZHJpdmVyIGluaXQgaGFwcGVucyBhdCB2ZXJ5
IGVhcmx5IGJvb3Qgc3RhZ2UgQ2hlY2sgZm9yIFVTQlBIWSBjb250cm9sIGRldmljZSBhdmFpbGFi
aWxpdHkgYW5kIGhhbmRsZQ0KPiBVU0JQV1JSRFkgc2lnbmFsIHRoZXJlPz8NCj4gDQo+IEluIHRo
ZW9yeSwgaXQgY2FuIGJlIGRvbmUgdGhpcyB3YXksIHRvby4gIFRoZSBkb3duc2lkZSBJIHNlZSBh
dCB0aGUgbW9tZW50IHdpdGggdGhpcyBhcHByb2FjaCB3b3VsZCBiZQ0KPiB0aGF0IHRoZSBVU0Is
IFBDSWUgZHJpdmVycyB3aWxsIG5vdCBiZSBpbiBjaGFyZ2Ugd2l0aCBoYW5kbGluZyB0aGVpciBz
aWduYWxzLCB0aGVyZSB3aWxsIGJlIG5vIGRpcmVjdA0KPiBkZXBlbmRlbmN5IGF2YWlsYWJsZSBi
L3cgU1lTQyBhbmQgVVNCIGRyaXZlcnMuDQoNClNZU0MgZHJpdmVyIHByb2JlL2luaXQgd2lsbCBo
YXBwZW4gYmVmb3JlIFVTQiBkcml2ZXIgYmVjYXVzZSBvZiBlYXJseSBpbml0IGNhbGxzLg0KU28s
IEkgZG9uJ3QgdGhpbmsgdGhlcmUgd2lsbCBiZSBhIHByb2JsZW0uDQoNCkNoZWVycywNCkJpanUN
Cg0KDQoNCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvcmVzZXQv
cmVzZXQtcnpnMmwtdXNicGh5LWN0cmwuYyB8IDEgKw0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0
LXJ6ZzJsLXVzYnBoeS1jdHJsLmMNCj4gPj4gYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXJ6ZzJsLXVz
YnBoeS1jdHJsLmMNCj4gPj4gaW5kZXggOGI2NGMxMmYzYmVjLi4wOGIxOGQ3ZGU3YWQgMTAwNjQ0
DQo+ID4+IC0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtcnpnMmwtdXNicGh5LWN0cmwuYw0KPiA+
PiArKysgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXJ6ZzJsLXVzYnBoeS1jdHJsLmMNCj4gPj4gQEAg
LTkzLDYgKzkzLDcgQEAgc3RhdGljIGludCByemcybF91c2JwaHlfY3RybF9zdGF0dXMoc3RydWN0
DQo+ID4+IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPj4NCj4gPj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHJ6ZzJsX3VzYnBoeV9jdHJsX21hdGNoX3RhYmxlW10g
PSB7DQo+ID4+ICAJeyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHJ6ZzJsLXVzYnBoeS1jdHJsIiB9
LA0KPiA+PiArCXsgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyOWEwOGcwNDUtdXNicGh5LWN0cmwi
IH0sDQo+ID4+ICAJeyAvKiBTZW50aW5lbCAqLyB9DQo+ID4+ICB9Ow0KPiA+PiAgTU9EVUxFX0RF
VklDRV9UQUJMRShvZiwgcnpnMmxfdXNicGh5X2N0cmxfbWF0Y2hfdGFibGUpOw0KPiA+PiAtLQ0K
PiA+PiAyLjM5LjINCj4gPg0K

