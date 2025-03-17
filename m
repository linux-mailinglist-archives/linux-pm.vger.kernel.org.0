Return-Path: <linux-pm+bounces-24195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475BA65686
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C8B189BCB1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7691891A8;
	Mon, 17 Mar 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VE2pTnw9"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011042.outbound.protection.outlook.com [52.101.125.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA5185B67;
	Mon, 17 Mar 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226593; cv=fail; b=nZqluZr7bm2WDB1X8j+3pCcp53Jh7VBiId3bltYt413eqMOqxtbBUKNHapID/RbxGdd+RLOgXixc/aVBD1HioE9MCthU3F6x3/OUtksb7vyzLzaMI78rlfmvuFX00TPAluAnt+ekCKK4swNdeLwsDDDi+2gqymb4j5XHQxb8Cek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226593; c=relaxed/simple;
	bh=fYxd9Od9WhIpN8lp1uj7nCmZwIhPtuDLRHEkVXsfZrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zk4MHZyZme7pZNUT4Kd4+cSUHFQJaWlaHharVITReAG/n/xBLS1uarA6p/LOfZj5Mx9zCKO0BIOWsMo469DI2sK5PSt+i745QG2rW9tOKS9nc6g2K9ZhR20YU8d1Xphp6u/qQuna2oyiL4324hjiBSueBhgBxP716VzlKrFgQDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VE2pTnw9; arc=fail smtp.client-ip=52.101.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj8R7/jKr8YPUyDAS870KB443rbE6Z+ARK5Mhoo67BRn9vuKePH4ilwiKe+GFJUmMikKseBsoh6LCbIudra7Wv84+vSFwO9LkFKmyEn+nwbvg+npN5w8Wd49ks0KAmzYKCgoMjPnAVtYni2v8G2+/n4lnefRCckqoE51lGPPQkrSdf5GxPcT2sqIr+EpJzdu9prlUTyUj3gqpqbK/FzViVOvrlX54i8jVc39b3AVAk9r/xrhVxtq/ldb6vofcFkCn/koNRhe4GakHbclZAgeGfrtQeemJS0D8zF+V06i7eUUkuJpPlVgck14GFO97dlRLJdSjkvXtd6YM34Fd6KWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYxd9Od9WhIpN8lp1uj7nCmZwIhPtuDLRHEkVXsfZrM=;
 b=ySQYkjQ/sboOd385SswMx6IfRDrb9rnhNvA3Zk+BE1IxHcXzMx3Bzrs6KPBDE1HuAMVfKJLpvS2mCHPyle1UDYKarh4eXtxqJNdYICRRhSksdioC/QFsW/ZKECF554OPf+R4R6l3Zs1DpK9nopzsaQMrsjPTmYMGHefBQ8U4TJCFjZLb4l4FdLPk48mELQpXD+tatHIC9HqIDJ4+zKRGpSkrYIFJ1EP67rDrUue0vjMtZR87CrDdq0pvqA/et04W0ofkxsv2fUOPbz8ybJeGWR4AafZP52MwiuD9gAc5KDAgU/9viOpEtVKzNWK6FYCsZWjPqnr+DReOIerGBwm65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYxd9Od9WhIpN8lp1uj7nCmZwIhPtuDLRHEkVXsfZrM=;
 b=VE2pTnw9rfZfxmhoMREvGRUv9BsAryvOf/tSbeiimxgjoAUDPfEolX+eWo44ejVR6p4bbXAKoyo/XKZIgYmmtkrzr7IZ3RtM6myMetKDxKqPxTCd9Zk+ry1UHpCdLGVkOqUSVJm3PWxqO0bsvoIqFrcGBBtx9dN3jfv6KwQPwSg=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TYCPR01MB7196.jpnprd01.prod.outlook.com (2603:1096:400:f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 15:49:47 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:49:45 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Subject: RE: [PATCH v3 1/6] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Topic: [PATCH v3 1/6] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Index: AQHblYIGivVFYFKgUECiS3DWld6hrrN3cxkAgAAH3SA=
Date: Mon, 17 Mar 2025 15:49:45 +0000
Message-ID:
 <OSBPR01MB27759945E762C46A04CE449DFFDF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-2-john.madieu.xa@bp.renesas.com>
 <CAMuHMdXWGLUzJFKdDR3hLf0iOoKzb15fNQmvzZZQq-a8e6cxfQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXWGLUzJFKdDR3hLf0iOoKzb15fNQmvzZZQq-a8e6cxfQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TYCPR01MB7196:EE_
x-ms-office365-filtering-correlation-id: 88a34aea-c9db-4869-c50b-08dd656b5742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVR4SUJwbUp2SmsxaXkwMGdIWnVka2JvTHd0U0pvc3hSQjVJUVBQN3NldDRO?=
 =?utf-8?B?OS93WUhvRGlldmxhejE1dmMwdkV5QXcwbVV5LzYwRFcwV0l5VDhPOUEvZy9W?=
 =?utf-8?B?VlpyK0wxZzZTTEltKzhrOGgvbTByUjN3c1lZRW1SOXhJcmx0RnBWbVA0Y2Yz?=
 =?utf-8?B?TXIvS2VvZGVJVk16RlRaY1plRmZnem01dGJCSkJ0c2lWVm5neGdDS0p1eTFQ?=
 =?utf-8?B?QXg2UFBkUjRPTVRNWWd5K2JoMEsxVXRFZGZXcDBnaEN4M3JjaC84MHRjN2Rk?=
 =?utf-8?B?MWgwVk1aeC9XdVRIRzRNanJ1dW1obGN5Mzh3Mk5RbFJUcXd4VXVjT3hhYXlI?=
 =?utf-8?B?Y25Vd1dnS3d4OXJib0dSTTNrbU43YWJzOEYvWFJuWnViVkViM2NSK1BoYkg4?=
 =?utf-8?B?Szd2VFhMb2NrczVubEM4Nk5ON3MzRFhsUFlJVkR2TDlTcVpLdWQ1ODhOUkVK?=
 =?utf-8?B?aHRmUFZqNTRKYzBDeVdZYitKWENkOFh6dzNiM1ZDNW03RFRIMnZrYTY2UEh3?=
 =?utf-8?B?ZkpVcmJ2WGFPVER5YmRETjJPK2VVVml0VWRWVVB1Q2dOQktDdzRCRW1ESkZE?=
 =?utf-8?B?eUJNTm1HUkJEUjVUU3F2ZWN2Mm9sK0J3TlM3ZDViMkJMcFVHaFJ6eFg3VzhQ?=
 =?utf-8?B?cEFGbG5OalRXZ3lzMytDc3M3Tm82aEJTNjBkK2RKb2JTVjd6VURIZHZlZ2do?=
 =?utf-8?B?eXhUMG1sUlR5aEk2WGdybHdBRkhFL3Ava0VqY1plYWJDQ0lsNmlSVy9vblZk?=
 =?utf-8?B?Y25IajlNTUJvRnBUV0VKelpMQlVHdm1BLyttd2d2dWplczA3RSthV2JlOWxB?=
 =?utf-8?B?TG5pZVdraGdhV0YrTzRuNHpMYWI5VjJDQ3VnYkpDSHdtSXRlWGl6anFLNmpW?=
 =?utf-8?B?VmQ5K2svajRFRDByV1NtcTQ1VmQ0TVZ4a1p3L0dobkNJRUo0cGcvQ2FaMFpY?=
 =?utf-8?B?QTd0VThMRjBIbTdzWHFOVzJNQWpkN2RlRDc4b2ZRanV3OEFoeE9PaTlDUW5k?=
 =?utf-8?B?NHJtUloyeEdidHlVWkRwRUl2YjdUOVdCdjdZTVVrd3RhVTFrWDM5RHdkc0I5?=
 =?utf-8?B?cStVS2hNM3pqZ2JrV0wrWHEzSWNpY0c2ZkRweUJNbmc0RmJERXUwaGxkTldI?=
 =?utf-8?B?UEptNUsxL09UWnROTk9uSE43RGpHZmhZdTM3dHBwek0wMnMzbE15ZGdkM3Z2?=
 =?utf-8?B?Wks0azJVZHVxaXRTYmFGUXdDWE4zbHVpNGpRUjJVQW9WR2RkWGFKQ3BFTkd4?=
 =?utf-8?B?cTVVZk5NM2lwZTkxZGV2b0lvaTMzR05zdXNDTjJKUFh6NVdtdW8zK1V2RFls?=
 =?utf-8?B?ekZwV0hNdGFDR1ovaitscVltdDRvZlpTS3lzVFdlbC81cFAwaUI3Y2kxUzFL?=
 =?utf-8?B?TGNJZHpDTEhuTHJEK0xhZ0RYcWI5MEZGMXFqNURKRWpsUE1NN05PSVhCZUFm?=
 =?utf-8?B?MS9qQkFJUklNcXhWM0poSXl4S1MrckFyWlV4U2pyUi9qWDhKNElyb1BIUnlu?=
 =?utf-8?B?M2dmR1N6UjZMN0NNV0FEbFljSTRGS1JQbDlNSGNIaW80aUd1OGUwZzVwK0NF?=
 =?utf-8?B?QWJUejVWQkRQU0dwcWo3cmE0NXd6aTZNemZRT09tUStyMkxjbXhYRmpHS0VS?=
 =?utf-8?B?MkVkNy9jbzV2U3VLRnRnZ0c4akdlSFRmNmtxNnVnVG1kSjA3ZDJyeHFWU1Z6?=
 =?utf-8?B?a0Fyb2RTaHBoWVE0QjBhM252WjF2RlJoK0R5QUFxbUpOSmxMQkczWnloa0U3?=
 =?utf-8?B?MWZudHVjMWxWeFJ0WDFuWElDNTFvMXNuRTdDOVVhVk96OVg4UFNaZEsyWDBj?=
 =?utf-8?B?aVI5K0RMRjlnZURaVXVrT0RobUlla2QrYVp0TDZVL200TXdaVHBGb3NJQytX?=
 =?utf-8?B?KzZiUmdnUWpsQWphNjJrZ25RcHhhM0FaTmdobisyRFp2bmpmSGJjanpYU3Uy?=
 =?utf-8?Q?zZgmZfV0DTd409T6L4OYykl2Xpo3RVJk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmNnSG9UTmlGdE5FNHNsUHd3NFNKQWpsa2RBTTA4ZGUzT3dNUDlJSFBMUG1p?=
 =?utf-8?B?RGJQWiszNWtndU5sR3M4Q21uY0tqeURQMVRldGdKaDA3eE5WYUljdGlLT2RP?=
 =?utf-8?B?Ym5JL0lyOVdNVEpPUDdDb3FoUGwyQk4yMW5lbkhxOUtUQ2lRNWJQSEZoY205?=
 =?utf-8?B?VGxxN0pGTXlzaG1ZajBPek5FVFM4cFJCRUh6aE9pZlVROHN4dGp1S2Yrcmp4?=
 =?utf-8?B?UEY0eVp3aDRyOUhtWk1nNXlwMEZnVmJxbE9ycjBxVmp5SThLUnluRUlML29H?=
 =?utf-8?B?NUx2aEphbXVwUTlhcmJoVFp4ajZsSmtMNmUyWU8zT1ZEcTVQS2JQR01wSk9T?=
 =?utf-8?B?UUZsOXczRCtkMEpNN1VVaUMxY3ZTRTY3eUREMkZDQUlvOFFlalpxVGg1cW1J?=
 =?utf-8?B?TzlJYWRZNDhyZUhGZ09FUDVaNUN1b1Z4UmlYMXRVR053MDBwbmhVRGJ5Ylc3?=
 =?utf-8?B?aXMzbUNlVnQwdDR5UUkzNlJXaTY3NERqY0FXb2UrYUhpU0hIN0FQT1NYbmcy?=
 =?utf-8?B?TTZRYysydzN1UDFFZThpV2wrSHV3V0lsTzBxTEdOT1lLNDJlcENpbmVmYUs5?=
 =?utf-8?B?ZDByV3dWSXVNcER4OTcvL3ZLMVFBWUZTMXIvOU1xYk5mU1pHdUNpcFhsUUor?=
 =?utf-8?B?NFc2R3ZlK2d6RVh5T0RBYkZ5WEF2dG8vaGx4MEt2K1Y1bWxQMlNCVUd6N2JO?=
 =?utf-8?B?cHBmb0dtNkFTa01jS3ZsNWlWWGw3MnQzUnJhZnBCYnN4QmU0U01JcXBzRC9o?=
 =?utf-8?B?dzk2a2RjL1dSSFpNUU5SeldkSnRFSkVhZlNIbzZxSGlsaDlFc0NYYVBpWTNB?=
 =?utf-8?B?a0hZTVN6Z01GWm5hRW0vdUdhaFBmOUlwcWtqVzlmMzUxUkEyd1VvQWJlSk1V?=
 =?utf-8?B?OE1ncFpPWHZvSngzMU1wYVNTRC9Jc1F6WS9VWGtVK3FPMW1RMHdHajByVWFy?=
 =?utf-8?B?T3RFTjFuRVU4T3NJY3BqVDlXVFdRS0ZXVlFHc2REMWNGN3pENVBNUXFrUGZD?=
 =?utf-8?B?UCtITjNUYm9qN09XM0R0K2s2ZmhMTFVnSjJqYkpCREltOURPOFlyVldaY0lU?=
 =?utf-8?B?Yy9SQTNpbElYWGNJdStBbU16c0duQWQ3ZTIwd29OQ0hUdVVnUTN3WHRBSUpn?=
 =?utf-8?B?Z2lPRS9qQzJOY2xJQ0d0WWtHSHoxcCtORkxRdmFyc0cvbEtMNHJOUURCVEVM?=
 =?utf-8?B?STFYSFVKMlpvQkRZa0VpU3ZJOG5JR1BtaE56YUxBcnI0Y3F0NWZlN2t5WTg1?=
 =?utf-8?B?eFNJSjB6bVUzMUFEazhIT2FCVy9qcjFzckpFMVc2NXZPYlFKcW5IZ3kxTEZP?=
 =?utf-8?B?aUp2MzhtK2Nja1g0TStHZGNKQ2t6Y2VDbjYwclI3QS94eGRObkJVU2NkWDkv?=
 =?utf-8?B?dUJ4em5XZFc2cDJNeDZ4VFlHU1pMdVpqQ0Zxckg0UmdxM09aSTROYmRoUDhn?=
 =?utf-8?B?Q1pwcVJYRGQva2I0YkYrREZEUlNHYWY0LzJycnFiNmZTR2JjVit3QnRZVFVV?=
 =?utf-8?B?bkRtd0Z1L0RDS0JuU2lHamlxaWl4UHBMOURJeWlwb3g5RUU5RHpabVR0L0F3?=
 =?utf-8?B?RVU3NXJVTVRWY1FITm1pSm83VXZjeFdpQkh3M3J0WWVxSmdKTURJTGs2SXov?=
 =?utf-8?B?K1RFbGUzQzNRVjhIQzlDVDlqeXhobkE3WmhYQmlNeUluSm04S0s5R3c5SGkw?=
 =?utf-8?B?ZGlkZnJFWkVDSFNXTzY3VzNjQVdUeDhWdGR3UlVGRU1BMkltRXFVRUR5cjdn?=
 =?utf-8?B?YnVpTVFaWXlIT2Izb0QzMmlQaU1RL0pNenp1WnlkYzJKVjQ1TmdVY0lWb1Y0?=
 =?utf-8?B?S3hHQTkyL0hVRlNNOE1MdTk4NlVxWDJnbytMdkZjckFKWmgzQTZWNEpWY00w?=
 =?utf-8?B?ZGduOWh3TkpPOWpYZGNLQ09SUXhzbWNrMmxlNEFLVkZJYlhMZi9IdS9WMHFF?=
 =?utf-8?B?ZUwxOFJQUjkrbHdDb0dJNnFKUHJKekFESGVWWFRkSWpWcHFkMWRBN1Y3TFI1?=
 =?utf-8?B?MEREb3YybGRLYS9jdDF5WjJneTZ6emMvUkdPWnlBWFoySTVUVWd2YVVQcmFU?=
 =?utf-8?B?S05QenhmMGV0WVYwa3VvM2FWQ2dBYnl4VHdDSUZmekVab2syaHFKRGt6cE81?=
 =?utf-8?B?anpwWnROSVYzbjFYbzRCY2ZQSmI3WXpqQ2RVTWFpVkdnU29tam1sdkkvWUZr?=
 =?utf-8?B?MkE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a34aea-c9db-4869-c50b-08dd656b5742
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 15:49:45.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoZqMhR3j7rQovKclBIlXc2n3gjBdtvARSsWHGMEkUFHgB2vGakX9KpQ9zxQJmGHd+vOQJs7vTsMEKKzpUa1i5op1AIkkKLFKqQeho3jQ/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7196

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNywgMjAyNSA0OjEzIFBNDQo+IFRvOiBKb2hu
IE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMS82XSBzb2M6IHJlbmVzYXM6IHJ6LXN5c2M6IGFkZCBzeXNjb24vcmVnbWFwDQo+
IHN1cHBvcnQNCj4gDQo+IE9uIFNhdCwgMTUgTWFyIDIwMjUgYXQgMDk6MTIsIEpvaG4gTWFkaWV1
IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gVGhlIFJaL0cz
RSBzeXN0ZW0gY29udHJvbGxlciBoYXMgdmFyaW91cyByZWdpc3RlcnMgdGhhdCBjb250cm9sIG9y
DQo+ID4gcmVwb3J0IHNvbWUgcHJvcGVydGllcyBzcGVjaWZpYyB0byBpbmRpdmlkdWFsIElQcy4g
VGhlIHJlZ21hcCBpcw0KPiA+IHJlZ2lzdGVyZWQgYXMgYSBzeXNjb24gZGV2aWNlIHRvIGFsbG93
IHRoZXNlIElQIGRyaXZlcnMgdG8gYWNjZXNzIHRoZQ0KPiA+IHJlZ2lzdGVycyB0aHJvdWdoIHRo
ZSByZWdtYXAgQVBJLg0KPiA+DQo+ID4gQXMgb3RoZXIgUlogU29DcyBtaWdodCBoYXZlIGN1c3Rv
bSByZWFkL3dyaXRlIGNhbGxiYWNrcyBvcg0KPiA+IG1heC1vZmZzZXRzLCBsZXQncyByZWdpc3Rl
ciBhIGN1c3RvbSByZWdtYXAgY29uZmlndXJhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gDQo+ID4gLS0t
IGEvZHJpdmVycy9zb2MvcmVuZXNhcy9yei1zeXNjLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9y
ZW5lc2FzL3J6LXN5c2MuYw0KPiA+IEBAIC02LDggKzYsMTAgQEANCj4gPiAgICovDQo+ID4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29u
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxh
dGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L3N5c19zb2MuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAicnotc3lzYy5oIg0K
PiA+IEBAIC04MSw2ICs4MywxNCBAQCBzdGF0aWMgaW50IHJ6X3N5c2Nfc29jX2luaXQoc3RydWN0
IHJ6X3N5c2MgKnN5c2MsDQo+IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdA0KPiA+ICAg
ICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IHJlZ21hcF9j
b25maWcgcnpfc3lzY19yZWdtYXAgPSB7DQo+IA0KPiBXQVJOSU5HOiBzdHJ1Y3QgcmVnbWFwX2Nv
bmZpZyBzaG91bGQgbm9ybWFsbHkgYmUgY29uc3QNCg0KSSdsbCBxdWV1ZSB0aGUgZml4IGZvciBu
ZXh0IHZlcnNpb24uDQoNCj4gDQo+IEFib3J0aW5nIHJldmlldywgbmV3IHZlcnNpb24gaGFzIGJl
ZW4gcG9zdGVkLi4uDQoNClNvcnJ5IGZvciB0aGF0LiBTaW5jZSB0aGlzIGZpbGUgKGFuZCBvdGhl
ciAuYyBmaWxlcykgcmVjZWl2ZWQgbm8NCnJldmlldyBmcm9tIHYxLCBJIHdhcyB0aGlua2luZyB0
aGV5IGFsbCBkZXBlbmQgb24gdGhlIFlBTUwgZmlsZQ0KYWNjZXB0YXRpb24sIHRoYXQncyB3aHkg
SSBpbW1lZGlhdGVseSBzZW50IHY0IHNlcmllcy4NCg0KSSdsbCB3YWl0IGZvciBmZWVkYmFjayBu
b3Qgb25seSBiYXNlZCBvbiBZQU1MIGZpbGUgb24gdjQgYmVmb3JlDQpwb3N0aW5nIGFueXRoaW5n
IG5ldy4NCg0KDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUn
cyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0K
PiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkg
Y2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxp
c3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg0KUmVn
YXJkcywNCkpvaG4NCg==

