Return-Path: <linux-pm+bounces-31952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FF2B1B0EB
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48FA16117A
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2D259CBA;
	Tue,  5 Aug 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JkhC5zNi"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010053.outbound.protection.outlook.com [52.101.229.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E09253F11;
	Tue,  5 Aug 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385734; cv=fail; b=NJgCaQorPRHVaG1iCFa/iKN3BNvRqkQLCO+llt6TWcw+ct/BDsQ+pw4T70BxfzXQK7buK8iOAT3AAN1lccV8LXU5GRrl6nABP5uaYwviIrY7fRoNU0+U9GmOUxQWF8WDTRHfB+JzxyqYeY3IPzsMzPXNGYNABtX95uw7Duhm1uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385734; c=relaxed/simple;
	bh=TME1CvMeXbMvWLWZu+XQB/FyDwWumdMjlL4zfPZrRYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EyOq9RSkn3wYTIbAMhHVwHgeY9RQThItAd9g2GggbB5E7nTONcutpYiv8KebmEs1aZjy+3FUZvefKI8JFAmQC4gX2RILg2ZvGuq4jZKMeelw3WR/GnKCY2goOPM3viZGChoQKT37HDF26V7bexdQH6kUP+GkfxdCfi+n4gQ3l6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JkhC5zNi; arc=fail smtp.client-ip=52.101.229.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW+P3P3F2caePkP1HaMezHbEUm1HbTMIaB5GQpgSZUNQwM4sDEt5wNT/BRXLCau7Mbl9RdItB9w1VgXRAt4U4m/FEeGkzoagBmjCzd7tzO41IpzTSwe1Vk03NB4ZwTx26kzfNtf11AjRk9l6tRtRbyKweau9g4OnTKNKODo5PlGr8ddxaDJS/JECbcqVLPjmpfOpvwTykhIDnHWMZQtn1HXvK0a65JwWmb0aYnm+LQuYTSMcUrkkCJYzl3f5erVyLlQ+Jy7NXzw8Fbnpnz0a+Jtlrc9Xd/Ca3B1QXVmZz+b6hFdflk1XNFTKuSkyvzjsxwJ4AKX4MuDwvEVOr4yjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TME1CvMeXbMvWLWZu+XQB/FyDwWumdMjlL4zfPZrRYM=;
 b=YPB7We2k5jjI1JLxXjFLkgMHwtn4h/fzrtFCqmuVEG85W1PBIgaTmmbi0ehBVCfwjXJ7r9JpiBT4GcqTEqJBep6Yh3Iq6DacBGOwkunKBRAV3WGbc1oMEA3ZxPY01p1LpQrGhrOoRqBAhPjiLQ7hdJtjRXrqlSlxhYKMRSeEg7d3rsS0jLkQNoq7ikkcWen2lslMbNDJPdQWcTcEy2oKf/TawbZ3K8e1jEnVKF28WlbisuIFTpJPs29WlQDNth3A6loRS3QnnAKOnsu1K1VzWhs3TIkqXYeh0p9OohfkdydQmcyaXbvbdDvRrGTAuxx4OLutpGdOxadvDySluNnvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TME1CvMeXbMvWLWZu+XQB/FyDwWumdMjlL4zfPZrRYM=;
 b=JkhC5zNiofSzje73ycaxiy3DUSXLv9GlwxduzzQwTCCkcf/XDjXFhojj5iisKZNaE9bEyQVwyxBGdtOnlu8MdhET11VHU8rMDGRP1R7JOqOyLbT/e9BA6Pstq3DYxfItkliFF5AAnjzkbst2AUEkJ8OFo1ub05C0kR68fuITzsk=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by TYCPR01MB8503.jpnprd01.prod.outlook.com (2603:1096:400:15d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:22:07 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:22:07 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, magnus.damm <magnus.damm@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>
Subject: RE: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Topic: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Index: AQHby0ai9SCDgo20z0y3b2QkXuPFT7RSraWAgAGApSCAAAY6AIAABXfA
Date: Tue, 5 Aug 2025 09:22:07 +0000
Message-ID:
 <OSCPR01MB146472833398C4E61B9C5B160FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
 <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
 <OSCPR01MB146471D101C6D66C1B81336A1FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <CAMuHMdV2DsJ5_0sW+f6anrqpr5kjLoe9w++E_xKJjdG7TJmGcQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdV2DsJ5_0sW+f6anrqpr5kjLoe9w++E_xKJjdG7TJmGcQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|TYCPR01MB8503:EE_
x-ms-office365-filtering-correlation-id: 5a9a10f4-f022-4c38-54ba-08ddd4018ca0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDVHckJhTG9IVG56dlo3U2crd05VR3VrMS95NWxRWXVWNDhMaG1Xcjd6WTU0?=
 =?utf-8?B?STAyQitrbnkwT0JYOUlzUjNnNWZTQU4wc1RTWThMSHFpdFZzR3FHVGRHNHNx?=
 =?utf-8?B?blMxVTROY01FTmMvdjQwcUNkNnhTdnpVbE5CN0dTZUE3TmgvVHo4cGFITVlO?=
 =?utf-8?B?ZVZHSDBucFQwc0RCN0s0Ykc1VTdoSk0wR2p6NWlzMUhCNGZ3Zlh2ajg2UlNS?=
 =?utf-8?B?TGUwNFpuaDJhUCtvQ2RTUzhOMitxMWFOTlZwQnFBRG9yZGR0V3dlOTc1aThF?=
 =?utf-8?B?QnFPR2ExRDF4ME5tZ2dXTGxEQUhXRE5mRnpYd1QwUHRDWjdyckduVmdNZ3Av?=
 =?utf-8?B?MGFNemZmb1J5QVc0aUNzUzVSbW5IVlVReHBuVGZweXB4U0pqWkFDZStjQlRQ?=
 =?utf-8?B?QTB1S2ZPQ1NoM0g2c3ZmNjQ0Vk83MWhkYlMvSHcxdEw4NzRyQjNjYW5aWGVH?=
 =?utf-8?B?OWhKeWZVa2QvSThZSDN6WmwxMTNlbmQrQmJOaGxxbklQRktKS21JVFpPbXpJ?=
 =?utf-8?B?akdRcFl3eHhLRHF0UkpLSlV1TkRFSmpkK29XZzFIMUt5RGExNmcwOGtENm5i?=
 =?utf-8?B?KzRlSDdiQWlTbHJQdGpJWmdETUJKV1VqZlpPRGU0ZWRvQ1JJV1laOEh4blBK?=
 =?utf-8?B?M3RYb3hyTkxKc1M0cjlhMFQvS0ZERGRYa2owbWh5ZGR4bW5ST2taOTBpUjFB?=
 =?utf-8?B?QTdxSDBXR2FudTNGTmN1VFdOUUhJMmpjaE9XYXhaSE8zWmZsODg5bVhBdzVH?=
 =?utf-8?B?eFBCUncyVS9KTHRzNXkzSGNhYXpkSWFtTDJnUjNvOGhOUWlHaXRCLzkwN1Rh?=
 =?utf-8?B?MmlqRXpPZ1c2c2FkSklJUWJrMjRSQk1zS203V1E3V1JkdEliaTYvV294blFw?=
 =?utf-8?B?R1ZLbUN6YTNNWE0wbE1rL3BhNGkwUm5QaDAxbmowVGlTd3RSS0RvalVYU05u?=
 =?utf-8?B?QU9tVkhGcy9CdTVQNE4zSlkvVXRYK29JaTR6blR1dUVlczlQU1lqRVlpK2ln?=
 =?utf-8?B?eEsvRHhtTHRhaENEcDhHYzl0ZUlzZm1QZjZBa00xU0YxMmJudHVqenFGaFdD?=
 =?utf-8?B?TmNDTHBGUGZjclduYzZZaHdVUU1XQ2hCR0puR1lST2dRbHFDS3owTlIvR0Fx?=
 =?utf-8?B?d1MrQmRtbk9CaDVzQTEwSWJ1NExQKzBPSkI3WXJoVEo3V05jSGZDb1RweFV1?=
 =?utf-8?B?S1BYbzFSYWViTnQrSlZPdmRyMVpMNncxcDBwa3MvMmg0UVh1UFZ1WXdZWGxl?=
 =?utf-8?B?UnZBUmVTUzVlSFh2Q1ZkZnhNQmR4V1kxcFhzWFlNdU1ock5CcmxHRjlPTFQv?=
 =?utf-8?B?TnhPM3ZIWFB0K0JkTWhsK0pkTFBaZWxqZkh6U2Q3ZVcvdzVSakhNTWtGdzhn?=
 =?utf-8?B?RUtSbGRlcjZ5RGxtU2JBSkJLUFdhQ1dKdnpoYk5ZcUJKUFpQMXNXQStWMU5J?=
 =?utf-8?B?RTJiM1NkcS93d3NmSkk0SUlMTWhIcTRaVDVaVGpDM2M4dHdsclhzTHlscVJk?=
 =?utf-8?B?MXUwMnhWdWdTenlLWnNpUVJtMzRjV2Nid3dlNEhPZndzM2p5dENxQ1c2SjQr?=
 =?utf-8?B?OVNXOHVmV2x1SjdNN3pxT0U1MXdWbXBvQTZMRkRlWVcyVmFSVnptVm1uVDZH?=
 =?utf-8?B?enBXWHlYbytJQ21VR1VJTE5NeWJacnU4TkwzOStHRnNsSS9OWnYrTzNBZDBx?=
 =?utf-8?B?NUlLWm00a0FUbTQ4ZnVpbStieW1yTmU4eGIrTmh2blJrM2FUNzJxQlFjN3JK?=
 =?utf-8?B?M2J4c1d5RzVzOTcvSlU2eFZJUmZhN3pCMklicFMzekc3dW1rZnh3VElka3VN?=
 =?utf-8?B?U21vSGM5YVZWNTUzL25JOFFVYmlQbDk3WVZpSTVWWmM0ZVJlRDlRMWtPSUwx?=
 =?utf-8?B?VStHSjAydlRPU1JJNmJkSjVoQUpIMjBOcUtDMUp1Rzl0WG05TEVySDg1eHlX?=
 =?utf-8?B?bEczK21vemd2YVV1QkFwM0RIbXQ0TjcwcThJTHYwQ0MzOHZxSUlrT09iVFph?=
 =?utf-8?Q?4dkqxk3Y1h1NmwZZKkRU9hrZpGeMTU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekw4aFBFNXpnRVhOUEZ1ZGpNb2xLWlJVZE9ub1pubW9CL3dUOVp6THIvaytO?=
 =?utf-8?B?Q0ZwYmx0Q0hMY0QxQWdLNEc1VVFwYWsyc3JZT1QxdWNXWW8wUDFiZmZPV2gr?=
 =?utf-8?B?c3JWb3BsY2N3R2xDcUJEYi9zWVYrVnVialVRMTEvL1Zwb3VHeS82RVNoYlJ6?=
 =?utf-8?B?MjBucEhYSCs0Nkp4ZjdocTh5TERGWWVLdkQ4WFJtMHA3Z09KSzRMbE50ZXVE?=
 =?utf-8?B?SGlKRU5vSHhSMUlScmJTSmplbXFHbC8zUzZxa0w1Tlk0ajBlSlBqdzgyWUN4?=
 =?utf-8?B?RHQwMUVmZFAwdjZ4aml3ZVBGazN0d1NWYUtpU0w2emdQbVkzVXExdytVSmN4?=
 =?utf-8?B?bE9LcFhPN29UYWlDeDVVWXN1Mm5hY1FOY1lPNVI2VEVEWlZpZ2psUm03b2xS?=
 =?utf-8?B?VTNxT1ZualI0bVBXZGV6ZDhzU1ZCQk5tSFhPeWQ0R2xyTmhUTm5MaHhpbmRU?=
 =?utf-8?B?MHZKaWU2TVk2b3dSYXdndWplaU9hYlBDWlNWZVpFb0pzd3hvSElQb3IzU2ZW?=
 =?utf-8?B?R3dnOTdTeDRoaGo5ako4SUtHVGdIVHBSSEwxQjVCQWo1ckQ3cjlzWGxwdTVW?=
 =?utf-8?B?QWluSkFseXlrYWdzRUFqb1NHaEY4UHR1NzM5RzNuc0FUYjdQM0dOQVFWK2dF?=
 =?utf-8?B?d1M0Mkx0MFpEN29LeG1BZk9NWG5yVU5FQUhnUnpwWWdIRjU1T2xwSy8yY0Vq?=
 =?utf-8?B?cEF6RUIvT1VNRUhuMU9od3pqQ3ZVOHRkQUNTT3lCTzdwT3ExQi8rdHp2d3Z5?=
 =?utf-8?B?c3FvL1FmVDZ0QjZ6YmE3NkdYQmYrSERWYk9NZWtEeG0wam9rOXNjZXpFRDhS?=
 =?utf-8?B?Wmg1YUdGL1I0Qmk2RlVKWnErb2l3SnM3TzFvckRKN2VEOW5veUNZcGtBemNY?=
 =?utf-8?B?WXhTdmRYTTNGMkFJTlhDMXhWRFNjL21LdEFxR1JkRFR6NHR1ajFGd1NLWXRl?=
 =?utf-8?B?VnRRbStGL3dJMXhBSkEyb2dLUmxoa3F5b1N5SFhSVzkvQ3lZYlVTck55SXRI?=
 =?utf-8?B?aU1wMWdoVWtycFR2N1MwZ2wvMHFwSVdvRnYxaEpUT0U5bXhOcnRmdFZhdHNi?=
 =?utf-8?B?bzN0dWp1aE95dzZJcWhsRGhHWjhHN3JOYU15YkIwMi9Tc24wZFgvb1RNUER6?=
 =?utf-8?B?OWR4emFMMnlEZGpBNjErT2hNdG9mVVd2a2hTVnBzZ0pwSWIrdjFwWExZUVFo?=
 =?utf-8?B?bHNYakVaVjJFV1NONnk4ZEJLVlRMMFgzVW1ubXNjSzRwNHY1K08rNU1uVS9z?=
 =?utf-8?B?TmRGRzRsQVN1TEFVYzZ0K1pKWXh6b1hzZm82VXo0WE8rUDV3ekI3QVJ2L1dz?=
 =?utf-8?B?K01OY2RWQUdFU04wVjBuejdmcHdpa2R4ajIrMkhkNUlvZ1ZrNXk1ZUltN0VC?=
 =?utf-8?B?dXRwTWlxYUllUEpUYkprYkphOGZBU1Z0aUJzNFVndExBQkppU3QwTGh2Smty?=
 =?utf-8?B?K0xmRFAyZDUrVGY0K04yUGJNVXNOdVZac1lXWEdLRXl1ZHljQ2dpQ2Nsai9L?=
 =?utf-8?B?Y2dGWDNpQzlWY1lDeUt6NGZvRE5RUnlDWUpoSlUvaGVWNXd6Y1hhVWNCdmla?=
 =?utf-8?B?VXdqdGZleHM3Sjc0Q1ZWWlZtWitVN3IzOGNhbjlFZFo4Z3RXSGYyWjlPaVNs?=
 =?utf-8?B?bkh6L2tRT2dqc3NidDZ3WldtN3Z5aVlOSkozRXQrMzBoeFlNamt0NkdCVnky?=
 =?utf-8?B?U2J0amk5eGVoZGhwOThvNW03WWRsa3g3VWw4ZFRPYWorS21TV0VVVUdPQzZI?=
 =?utf-8?B?TUc1NE5xUzRDMXZUU0x0TlVETEtKSVpGSWhoOGd4RnpJY2ZLd2dUS2g0Mkk5?=
 =?utf-8?B?ZXkvaERTMUplNG9nWVoyYXNYWXZ0czAzV05GSU91emNURjBqRy9JazNaMXdD?=
 =?utf-8?B?OXdiNVVDZmR3YXc0QXFjVm5sNnFFYjhtTnVwMXBhZzlBSjl3aWR5K3BTRGNh?=
 =?utf-8?B?WmhobFMxVzZNdlZqc004bzQwbFc3eFQ4eWFVYzFSWkkyckNTTjEwY0NyTSt0?=
 =?utf-8?B?NmxnU2RWMkdiV2tzRGVIY21vMzArOXp1MnArTTBERFl3TkRaTHlBM0krUDJ3?=
 =?utf-8?B?b1NUcVBMclpwa25EbTNnWHp0OUZkbGJSSWRMTnFaRVNvODJkbU9JeDhuUFd4?=
 =?utf-8?B?YkM2cUdKTlA5NEdHWkdzQUM5anlRVm1USkExWXNUSzQ0Zzd0ekVyOXhFRUZz?=
 =?utf-8?B?ZHc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9a10f4-f022-4c38-54ba-08ddd4018ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 09:22:07.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E53ItWD24meWv8SS1Svo1n2ajvm3jHtGibbcRWfZ2It1krSO0cKgWMXeKZ3/sZ+06mYfk5OXfyGMxy8ho+BXF6mTwQvM70EoDxics+rwVLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8503

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIQ0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA1LCAyMDI1IDEwOjQ3IEFNDQo+IFRvOiBK
b2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjYgMy81XSB0aGVybWFsOiByZW5lc2FzOiByemczZTogQWRkIHRoZXJtYWwgZHJp
dmVyIGZvcg0KPiB0aGUgUmVuZXNhcyBSWi9HM0UgU29DDQo+IA0KPiBIaSBKb2huLA0KPiANCj4g
T24gVHVlLCA1IEF1ZyAyMDI1IGF0IDEwOjI3LCBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFA
YnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVu
IDxnZWVydEBsaW51eC1tNjhrLm9yZz4gT24gVGh1LCAyMiBNYXkgMjAyNQ0KPiA+ID4gYXQgMjA6
MjMsIEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IHdy
b3RlOg0KPiA+ID4gPiBUaGUgUlovRzNFIFNvQyBpbnRlZ3JhdGVzIGEgVGVtcGVyYXR1cmUgU2Vu
c29yIFVuaXQgKFRTVSkgYmxvY2sNCj4gPiA+ID4gZGVzaWduZWQgdG8gbW9uaXRvciB0aGUgY2hp
cCdzIGp1bmN0aW9uIHRlbXBlcmF0dXJlLiBUaGlzIHNlbnNvcg0KPiA+ID4gPiBpcyBjb25uZWN0
ZWQgdG8gY2hhbm5lbCAxIG9mIHRoZSBBUEIgcG9ydCBjbG9jay9yZXNldCBhbmQgcHJvdmlkZXMN
Cj4gPiA+IHRlbXBlcmF0dXJlIG1lYXN1cmVtZW50cy4NCj4gPiA+DQo+ID4gPiBSWi9WMkggYW5k
IFJaL1YyTiBoYXZlIGEgc2Vjb25kIHNldCBvZiB0cmltIHZhbHVlcyBmb3IgdGhlIHNlY29uZA0K
PiA+ID4gVFNVIGluc3RhbmNlLiAgU28gSSBndWVzcyB5b3Ugd2FudCB0byBzcGVjaWZ5IHRoZSBv
ZmZzZXQgaW4gRFQgaW5zdGVhZC4NCj4gPg0KPiA+IFdoYXQgZG8geW91IHRoaW5rIG9mICdyZW5l
c2FzLHRzdS1jaGFubmVsJyBwcm9wZXJ0eSBvciBhbGlrZSBQcm9wZXJ0eQ0KPiA+IHRvIHNwZWNp
ZnkgdGhlIGNoYW5uZWwgYmVpbmcgdXNlZCA/DQo+IA0KPiBXaGlsZSBJIGFncmVlIGluc3RhbmNl
IElEcyBjYW5iZSB1c2VmdWwgKHNvbWV0aW1lcyksIHRoZSBEVCBtYWludGFpbmVycyBkbw0KPiBu
b3QgbGlrZSB0aGVtIHZlcnkgbXVjaCwgY2ZyLiBjb21taXQgNmE1N2NmMjEwNzExYzA2OCAoImRv
Y3M6IGR0Og0KPiB3cml0aW5nLWJpbmRpbmdzOiBEb2N1bWVudCBkaXNjb3VyYWdlZCBpbnN0YW5j
ZSBJRHMiKSwgd2hpY2ggcHJlZmVycw0KPiBjZWxsL3BoYW5kbGUgYXJndW1lbnRzLg0KPiANCj4g
Rm9yIHRoaXMgcGFydGljdWxhciBjYXNlOg0KPiAgIDEuIFRoZSBpbnN0YW5jZSBJRCBmb3IgdGhl
IHNpbmdsZSBUU1Ugb24gUlovRzNFIHdvdWxkIGJlIG9uZSwgbm90IHplcm8NCj4gICAgICAob2gs
IHRoZSBTWVNfTFNJX09UUFRTVTFUUk1WQUxbMDFdIHJlZ2lzdGVyIG5hbWVzIGRvIGNvbnRhaW4g
IlRTVTEiKSwNCj4gICAyLiBJdCB3aWxsIGJyZWFrIHRoZSBtb21lbnQgYSBuZXcgU29DIGlzIHJl
bGVhc2VkIHRoYXQgc3RvcmVzIHRyaW0NCj4gICAgICB2YWx1ZXMgYXQgZGlmZmVyZW50IG9mZnNl
dHMgaW4gdGhlIFNZU0MgYmxvY2suDQo+IA0KPiBIZW5jZSBhIHByb3BlcnR5IGNvbnRhaW5pbmcg
YSBTWVNDIHBoYW5kbGUgYW5kIHJlZ2lzdGVyIG9mZnNldCBzb3VuZHMNCj4gYmV0dGVyIHRvIG1l
Lg0KDQpUaGlzIHNvdW5kcyBnb29kIHRvIG1lLiBJIHNlZSBzb21ldGhpbmcgbGlrZToNCg0KcmVu
ZXNhcyx0c3UtY2hhbm5lbDEgPSA8JnN5c2Mgb2ZmMT47DQpyZW5lc2FzLHRzdS1jaGFubmVsMiA9
IDwmc3lzYyBvZmYyPjsgLyogT3B0aW9uYWwsIGZvciBWMkggKi8NCg0KLyogb3IgKi8NCg0KcmVu
ZXNhcyx0c3UtY2hhbm5lbC1tYXAgPSA8JnN5c2Mgb2ZmMSBvZmYyPjsNCg0KSSB3b3VsZCBnbyBm
b3IgdGhlIGZpcnN0IG9wdGlvbiB0byBtYWtlIGl0IGVhc2llciBmb3IgVjJIDQood2hpbGUgYWRk
aW5nIHN1cHBvcnQgZm9yIGl0IGxhdGVyKSBzbyBpdCBjYW4gY2hvb3NlIHVzaW5nDQplaXRoZXIs
IG9yIGJvdGgsIHJlZ2FyZGxlc3Mgb2YgdGhlIGluZGV4Lg0KDQpXaGF0IGRvIHlvdSB0aGluayA/
DQoNCj4gVGhvdWdodHM/DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KDQpSZWdhcmRzLA0KSm9obg0KDQo+IC0tDQo+IEdl
ZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0g
Z2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25z
IHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4gQnV0IHdo
ZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Ig
c29tZXRoaW5nDQo+IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtLSBMaW51cyBUb3J2YWxkcw0K

