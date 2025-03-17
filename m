Return-Path: <linux-pm+bounces-24221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A88A65DE6
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 20:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5AA3A92EE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC71E833E;
	Mon, 17 Mar 2025 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sOoy7dsM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE015573A;
	Mon, 17 Mar 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239765; cv=fail; b=EsiXZKtX3Oq4fxUYk4oZ/TSv/r6wMgIsHaTSp1B/YPWNKRNwJ2/qBDMNX6n1JkL6WD608zO8zSxCB1lJupotGDb5N45u6ZFHcpV33x5PdoCg54wZDTphkPZv9bMRMkMT+MpLTuMc5GCq1oECGKChrT88XAgGOWayKqthN/bMFak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239765; c=relaxed/simple;
	bh=kM03v8St/dPWJRS6rTc0vZEPuc2Y1sI/TY/Xaww12gQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RQaTwbD2CCGxdlD+8VdvmOvqfsaYXk0zJsKtrbbkGJbdTRqLRwRwzdiW0OSlFWWs9O2krjZkle1c5Sa7d6y0JBMva9e3TCN3DetTzgbCP12NYzgR121p/YLqPKtH7v3m2jLLGP/b7cLNHSzLI2k9d9rI32Ckm/NSo0CHe6D0ugE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sOoy7dsM; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjJj45pl+t1xQlXwFMgNlMINIpxFkvM+MpwBPEzCVK2RBHBuaedI5tTPrafz4fYDCcjxMrAulhQ4+FXUFIuN3LjOfF7rfx4HJA1Rt3ERLv2ZTteNE2wR2Xd5EmfDwLr1xc8H+dJmXij1YlsCGuOt90apNxHECNeu3qnnqJ7Hh0Uh2hPZWXOjPdf6Snlbbr+8fsx689wfyT6mHMUAPoKd96ynaqIeZSxHXlSBrBCdRrf33tGR9G2oDgZyo8ke/H1SgDXuircRy8QZIBa9S2nZp+WJKz+gl0JJXoxzn4hDJE7wTKHo2AQXf7Ft3gyiFfDsip9AcgDxc6rqUXqc/3+OpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM03v8St/dPWJRS6rTc0vZEPuc2Y1sI/TY/Xaww12gQ=;
 b=yvi2KzGoOuhcuKGriPCUB8N2+ImYdUpB6X5i9dxK4+94QDVsVm5yolV4vTo9QHyShPS6m7xDZSzjkZ9bcfZRx5PCcW8ttqwwV2YzzlVZIzMtoLOjhqT5zOrzhWcS8eFuXCvqzQAQEGThYxnbH6RSu727WIKqlZA9mr+2N8GuqqDP3tjIfWD4TV/GBD6/2/Ci/9le1eLzzFCeKqNaS4CNZp1EPQDYWlpnoXcc54sJlRAfOLwA6/BMXoeKmmRQzTtGSqNuenUQiw3pMJzaFl4G5ao+4gHcvTsUlN8NLQKpm5cXXYXcrji8/F6gUHVILf/aSsbmw7EjrghlCtjIhNhq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM03v8St/dPWJRS6rTc0vZEPuc2Y1sI/TY/Xaww12gQ=;
 b=sOoy7dsMYlkZYdIEnsxaXSMAkuMjxOCfBtbUKTB6B/9nGGhX92+ARhdZp4GZ9ColhB/a+aV+hfEB3fklP1z2Ejq+nVJIa3yVJmewMrfHZD383Mjs/5UyD0QRWqdxyoyY9cgamb5TpB2n63Tnqr2P/XMPX2IABWl21gUVYi+ljpQA2y+HhziXmrFBir9fVkf4jZZF+oMyAx7+neUyuZIvOpJnmpsIMutAFZ5FB2S3YEFOpA0qZOYTIslbGeP6x9IPJgMBxysmpWdKd4z8sqzYmjKV0ZkgNkUWkb9dkUQgPse7a5iy1kJ09ECCLuCrGHhsATEhO7tDOLebA7r4hoUK0A==
Received: from CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 19:29:20 +0000
Received: from CY8PR11MB7034.namprd11.prod.outlook.com
 ([fe80::b284:ae0b:19ad:6b8a]) by CY8PR11MB7034.namprd11.prod.outlook.com
 ([fe80::b284:ae0b:19ad:6b8a%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 19:29:20 +0000
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
	<linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v3 00/21] Enable Power Modes Support for SAMA7D65 SoC
Thread-Topic: [PATCH v3 00/21] Enable Power Modes Support for SAMA7D65 SoC
Thread-Index: AQHbiS+psTe+QQ7+CkKv+s0dnIZXqrNxW1yAgAZ4BoA=
Date: Mon, 17 Mar 2025 19:29:19 +0000
Message-ID: <1600105d-a527-4f2d-a41e-33d6fd227334@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <20250313164211.GD3645863@google.com>
In-Reply-To: <20250313164211.GD3645863@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7034:EE_|IA1PR11MB6073:EE_
x-ms-office365-filtering-correlation-id: 93bb3935-467b-4a1c-b72d-08dd658a03c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dU9CVFc5bDZmTUIxeU9QKzZ4MlZHajNEaFlZWGxscGM4eFhjRmJNUmxBK09k?=
 =?utf-8?B?QUxvcUNOSkZ4NEl0ZTFaQWhSLzk0MGpDcHhrb2xQcWxpekNCRVFMcCs2emdt?=
 =?utf-8?B?MVNxOXVxc3ZlOGNUbHpxVDlxU0VNK2NWWGl5RUt0R0FHS3pVV2RXdUlack12?=
 =?utf-8?B?UUY3VHdrZTJoSDY3L0d2VVVJYzc5QlUrb0JrS3VqSFkzMGltTjJHMWNhbkU4?=
 =?utf-8?B?OVBOVGdLSWdnWXRSc2VVNVRDRGNZNmNGWElKNWpYRVlPcWRNMUVjdk9KcjMz?=
 =?utf-8?B?MW9OUTJDTU5uTys5UVAxcXdiYkNrcXdnQjh2eW44S0NobU1KTWNJcmlZdVNo?=
 =?utf-8?B?NVBNSitPczlMZ0dtU0cvQUROanJ2Q2dEQ0tnWmJLcW9IVEc1OEkzT29FTlo1?=
 =?utf-8?B?d25LNTh2VlNrTVJzS0Focmg5RTgrRDd6c0FKa1B4dUVldnY4YnRXTUsxQkE4?=
 =?utf-8?B?MUUyeUl0TC9KQ2hURkxLSlUrZDYrM2kydm91TlhYLzRoY3cyOEVlN2RQT0p3?=
 =?utf-8?B?QVNZdlNOQmFGYTl2b1dkZlludU9aZi9JOWphWEJrVHpzckQrRnhXN3FmemJP?=
 =?utf-8?B?QWVjV0Nwa3FsT0pJRTg2enFNanpNSUdQdDQyRmpSVVE2T05tb0hzQm1XLzlC?=
 =?utf-8?B?MkR5bXhsOElvWGFQbzhCRVI5aXBGcFpPWUdWNTNwUlNtcitUZUZpQk1ic1pB?=
 =?utf-8?B?cXZUUzQ3L3Y3SWpGaEtpNERJSDNwRWpGenpLeDBJTkNXTjBlSklnRTA4R2k5?=
 =?utf-8?B?clJ4NjNQVHNzSnpBbTBQOWorNWM2cE9ORW9sdGRPTWd4UW16d3ZYSkZhbjRP?=
 =?utf-8?B?aEVaaFY5Q3REbjZkbVEzazFHV21QRVlhcEZ4bzVBSHBUUTF1MThGNEhpOHR0?=
 =?utf-8?B?cnBjVUxaQ1dCMVVEMTRCUnNXOXh6R1A4bVA0Q0xzcmZ3NEtESHozMTY2Z3Uw?=
 =?utf-8?B?VEozUnVWVTFGYTNMLy80b1dwWWFOWXZqdGVFSkJQc0w2WUtGUHJ3MDhuOGR0?=
 =?utf-8?B?dG5JMjZkRUZtOVg4bUtwZE13dUIvYWtTTVdTWndjbGtnUDVuRlV0K1ZWTWJE?=
 =?utf-8?B?dCtvc1lJQXB5ZmNQR25DNjRMVndPdHhoQWxaVXN3QlkxNzk4dFJvQ0FJK3Fp?=
 =?utf-8?B?a204ckc4STVUZXhwcHNiZW1jQzFNNGtQZmRQazNhTGt0ajI2V2xTTVFIczB5?=
 =?utf-8?B?cDR2QWFNZGNUY0ZHUWZRRmRLVStRU2xvWlM4TkR6bTVsRGNRWkRnNTNNZ0lp?=
 =?utf-8?B?SHhJcDIwbitFcG1SQzAvb2UvWnBFRkw1QUtIM1o5MWtOK29uMDVuMXZ3VlYz?=
 =?utf-8?B?UFlOUVNqWmhhR1N6OWM0dmNpbTlQWjExTW4zT1ZMM1ZkL0tHeVdxY0g1MU51?=
 =?utf-8?B?OXE5NUFUTVRHYkpxK2JJREtpWEpwSlhDSUsrSThLZ1ZTTzJ6TFRrLzkxZ3ZB?=
 =?utf-8?B?ak8yWGhoOEJXNkFSMHd5K2JHdS9ybjRsREV4WkVpMkZIUDNjaUl4b2pxNElN?=
 =?utf-8?B?OFY2NHFPMUpDVUxIbndBbWJJRTQ3b0ZuWnFnNThEaTJWTVJmQ1MvQWduNXph?=
 =?utf-8?B?Ky9Vb002UGd5aWdaZmZNeDJvYmg5cDNhbkVVREpPRS9iTmc0L3lIZVpkM1BN?=
 =?utf-8?B?cjVob1dtZmt0VG5HUDBHNHNUMkxEMUEzU3VseVN5dzM1NWpxM1VVMmVTbURJ?=
 =?utf-8?B?YlB5UFlMamsxK3BlS3ZXYlY3TFNsLzBhQ1VzRWFrQnc0STNaTlBrbU10aDR5?=
 =?utf-8?B?TFdUaFRueTZvbytnc2YyNVVVQyttMWxzNmpkK0hLcnNIN21zOTdqL0NockN0?=
 =?utf-8?B?MGl1VjR1NFptNXk1QThVOElRTmROOVplOGVROVdIQlgzbUpOalZLaW1EWFRI?=
 =?utf-8?B?ZXREa3B3MUNxVEF1M0NVaTYvTTRCRHdZZUFJK1MxWTZySElZT2dsU1Y4VlZ1?=
 =?utf-8?Q?Th8TmeBK47xoBDb37Lmc1d7iDxIrLLJx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7034.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmszaDhZdU84UTdGeEdMRW5pSU92UXdYanE3MHMvTitlYm1xY2Z0NVdGSFhJ?=
 =?utf-8?B?ZTl1Z2ltbXl5SncvSEtMekRyYklsSDlWK2JWSmVyQjkwa3hXNWFrWWxUSDk1?=
 =?utf-8?B?Q2hMYW1KQmxXb0M0MWpaaGxYYjFxNk9kaHZXQ0RXV0lIV2ZDdVNBWnhHVnZG?=
 =?utf-8?B?WS85eVVtdWJMRk90RXNaenBteE9YamQ3STBqdEk4NFdVcnorQ3A2dFZVK0lr?=
 =?utf-8?B?aVE5eVl5OFJBemJrZGZ4ZTZTYi9kMmFOVHZqcERZS1Q2T0I3WXRhaGhFRDVw?=
 =?utf-8?B?aG5haFlTcVA2TVR1ejVibzRFU25PTThSb0FYUHdWSTlEQTc5VFhYU3d4VXFT?=
 =?utf-8?B?N21vRnFmMFdOS2ludGxEa2tKZEZkVjcrSVl4K2ozWE9tc0NaYm1MdzQ0YUxw?=
 =?utf-8?B?NkRUVkpuQkczbktJeUtPYUY3eVRiUzltZU1QY3QvTTU3S1Fmdy9QWDQ0YUR4?=
 =?utf-8?B?QnlCQStseGY2SE9oand0Y3hKN0FCNU5yRUlvbkNvZllqZXRuTFMveHZDRUVx?=
 =?utf-8?B?ZzU5aDY5MzUzVFpRbDhsMENFRmdtSHNKWGdISFozQVIwOGF4UEo4K2owQ3Nu?=
 =?utf-8?B?bDNacW9SQ0tya3B0WndSdVk3OVhNZjJiK0pHdm9STnAxRGRnbHhqRzNjdVU0?=
 =?utf-8?B?TEhSMDNBUm96N1RKRHIrQnNuZEtoenRCZmVvcXl2UTQ0U0RWVW5XK1NQYXpm?=
 =?utf-8?B?SGFqRVc4VUZsbnNONDIxL3o5VGMxWmJ2QmtlcVZUR0ZSc2FNRjZqRGJ3bVdJ?=
 =?utf-8?B?RHBPRHhyMGxvbU9qUjR6WUp3dlYxampSUENmd3U0VmprUTVDMkRxMEFSSGdi?=
 =?utf-8?B?ZVFKQURlSlF0VVV0UDg0OStocFpHeHAwa25YZ0cvbzcrOWFoNUZ6WlpsQzFV?=
 =?utf-8?B?QUVQVmc1OTRLOUJCMGwyYkNvczUxaFJOSkdtbWdhVDRsTlo2dEJhdnhhTWd0?=
 =?utf-8?B?S0xDV052OXQvWnJoMk9SM25UUkZxMDB3NGtoelM4a1VQYkp6bVhMWFRpQXI2?=
 =?utf-8?B?cjBqZ096RnVpS013UFdYdEZZd2ZSeVdSd0xUT2lPZXVEdGJNWDNSTE4rK2NZ?=
 =?utf-8?B?bkRpTk1zWHVRMHNoQ1haU1djaEhvN3ZLcTc0dS9iL0RBTkRNQU9jRTN3Tnp6?=
 =?utf-8?B?TGo3N21TdWtYVEJjRHJsbi9WTFJFV1kzQVZuVTdIM3FvWFlPNjlBMVE0YkZH?=
 =?utf-8?B?Q2JPNHg2a2x6OUZvN25pc1d5R2lmMTJ6ZFlYNlJNQjZaNGVjQVV1UjRJM093?=
 =?utf-8?B?VUpDSk5lTnBOUzZRNTRjU0lrd05BbTZqeHlmOHR2NnNOdU80MUJjQ3FKSXdr?=
 =?utf-8?B?ZXJkWVFTNnAvZnphRitCZXM4MC9QdzFEQUY2NVBHQ2dLVFR2SjBnSTA0amc1?=
 =?utf-8?B?YXlWSUxDN3UwaVFwUCt1MDhBV1d5bnhtd3NERjFZL2wyMDdzazNuMWx3SmJX?=
 =?utf-8?B?L0xjWjdTUEJ2MDNNSU1ERlBBaEN6NnBPU3FnWENTZkFaTWNNWk1Tc1FQTG5o?=
 =?utf-8?B?ZFRLeUl5WldrZy9wU3cvQ0tPK1huWkc3dUJhaFB5SjBYU2ZPWHovZlY0aU1a?=
 =?utf-8?B?U0dPV3RPWmN0Q0hIbnRJV1JSZHhaanRlclR1TDJpaEpyYWJyekFCb04vM3cv?=
 =?utf-8?B?MmQ5a2tZUjdsclRRWEJMbkozVnFrdkJ1NUxJaks2TjQ4K3NKUzJoUG1QNThC?=
 =?utf-8?B?ay91UTBSd293MmpBc3NxNExmQnhkRmNaelVZUnE3YjB5ZkdlaEhvQTA4cXNy?=
 =?utf-8?B?d0NZamJkZkF4MEg0azhhSk95RXMwb0N0TkUyOW1NaldyWGhqN1E4WkNQOE5n?=
 =?utf-8?B?Zno0d2k1VUxIK3d1KzFxVUEvYXVLTlN1dVd5VDBOTWJCeTMyYnl4Q0NKOVN5?=
 =?utf-8?B?eWJVMlhSakVXNWJPRzA4WVIyblFZVWFOR2ZhVlB0c3I5eGw5bVJleGZNQTN4?=
 =?utf-8?B?UFZWZmkwaVdMWVFFYnNXeVNsMS9BNHUvd2UwRnpKd2lGTVRrT0RKWHV1NThn?=
 =?utf-8?B?L2M5dS9WdVhjOEt1a1pJK3FId045L0owaWJXUmFZRk1wVktNRnRGYTRBTHEz?=
 =?utf-8?B?d2VaZ3ZhTVFqS01WbFM2Q3ErdGJPem82WUpraURBdVI3V2ZaTTgyOFgvNG1I?=
 =?utf-8?Q?ePAxRCkMDk19SK2MwvD4nfW2w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52C31F584EB9614C9D37BEFE682FDD28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7034.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bb3935-467b-4a1c-b72d-08dd658a03c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 19:29:19.9531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqF1qIjAXZDn4yhLwxrK+S7m0UnLCvo3iNlRB7C+Lm72MxR2pE5b9Inq3mSi/S/qxmeguvlH87ZXrHhkbxHLffwdyr/d44V1x6/hnMEkjGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073

T24gMy8xMy8yNSAwOTo0MiwgTGVlIEpvbmVzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgMjcgRmViIDIwMjUsIFJ5YW4uV2FubmVyQG1p
Y3JvY2hpcC5jb20gd3JvdGU6DQo+IA0KPj4gRnJvbTogUnlhbiBXYW5uZXIgPFJ5YW4uV2FubmVy
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhpcyBwYXRjaCBzZXQgYWRkcyBzdXBwb3J0IGZvciBs
b3cgcG93ZXIgbW9kZXMgZm9yIHRoZSBTQU1BN0Q2NSBTb0MgYW5kDQo+PiB0aGUgcmVxdWlyZWQg
Y29tcG9uZW50cyBhbmQgY2hhbmdlcyBmb3IgbG93IHBvd2VyIG1vZGVzLg0KPj4NCj4+IFRoZSBz
ZXJpZXMgaW5jbHVkZXMgY2hhbmdlcyBpbiB0aGUgYXNtIGNvZGUgdG8gYWNjb3VudCBmb3IgdGhl
IGFkZHRpb25hbA0KPj4gY2xvY2tzIHRoYXQgYXJlIGluIHRoaXMgU29DLg0KPj4NCj4+IFRoZSBE
ZXZpY2UgdHJlZSBhZGRpdGlvbnMgYXJlIHRvIGVuYWJsZSBhbGwgdGhlIGNvbXBvbmVudHMgbmVl
ZGVkIHRvDQo+PiBrZWVwIHRoZSBTb0MgaW4gbG93IHBvd2VyIG1vZGUuDQo+Pg0KPj4gVGhlcmUg
YXJlIHNvbWUgRFRCIGNoZWNrIHdhcm5pbmdzIGJ1dCB0aGF0IGlzIGR1ZSB0byB0aGUgZHQtYmlu
ZGluZyBub3QNCj4+IGluIHRoZSBjb3JyZWN0IC55YW1sIGZpbGUgZm9ybWF0Lg0KPj4NCj4+IENo
YW5nZXMgdjEgLT4gdjI6DQo+PiAtIEFkZCBtaXNzaW5nIGNvbXBhdGlibGUgZm9yIGRkcjNwaHks
IGl0IGlzIG5vdyBpbiBib3RoIHN5c2NvbiBzZXRzLg0KPj4gLSBGaXggYWxwaGFiZXRpY2FsIG9y
ZGVyaW5nIGZvciBzYW1hN2Q2NS4NCj4+IC0gUmVtb3ZlIHRoZSBpbmNvcnJlY3QgcmVvcmdhbml6
aW5nIHBhdGNoLg0KPj4gLSBSZW1vdmUgc2FtYTdnNS1ydHQgYXMgYSBjb21wYXRpYmxlIGZvciBz
YW1hN2Q2NS1ydHQgYW5kIGFkZA0KPj4gICBzYW1hN2Q2NS1ydHQgYXMgYSBjb21wYXRpYmxlIHdh
a2UgdXAgc291cmNlIGluIHRoZSBwbSBkcml2ZXIuDQo+Pg0KPj4gQ2hhbmdlcyBmcm9tIHYyIC0+
IHYzOg0KPj4gLSBDb3JyZWN0IG1pc3Rha2UgaW4gdjIgc2ZyYnUgZHQtYmluZGluZyBwYXRjaC4N
Cj4+IC0gQ29ycmVjdCBpbmNvcnJlY3QgZHQtYmluZGluZyBhZGRpdGlvbiBhbmQgZm9ybWF0dGlu
ZyBmb3IgcnRjIGFuZCBydHQgYmluZGluZ3MuDQo+PiAtIEFkZCBtaXNzaW5nIFNvQiB0YWcuDQo+
PiAtIENsZWFuZWQgdXAgY29tbWl0IG1lc3NhZ2UgZm9yIEJhY2t1cCBtb2RlIHRvIGRlc2NyaWJl
IFNIRFdDIGlzIHN0YXR1cw0KPj4gICByZWdpc3RlciBpcyBjbGVhcmVkIGZvciB0aGlzIFNvQy4N
Cj4+IC0gQ2xlYW5lZCB1cCB2YXJpYWJsZSBuYW1pbmcgYW5kIHVzYWdlIGZvciBtY2tzLiBDaGFu
Z2VkIHRoZSBtY2tzIG51bWJlcg0KPj4gICB0byB0aGUgY29ycmVjdCBudW1iZXIgb2YgY2xvY2tz
IG5lZWRlZCB0byBiZSBzYXZlZCBhbmQgY29ycmVjdGVkIHRoZQ0KPj4gICBBU00gY29kZSBhY2Nv
cmRpbmdseS4NCj4+IC0gUmVtb3ZlZCB0aGUgU0hEV0MgZnJvbSBVTFAwIHdha2UtdXAgc291cmNl
IGFzIGl0IGlzIG5vdCBjb25maWd1cmVkIGFzDQo+PiAgIGEgdmFsaWQgd2FrZS11cCBzb3VyY2Ug
Zm9yIFVMUDAuDQo+PiAtIFNlcGFyYXRlZCBhbGwgdGhlIERUU0kgYW5kIERUUyBjaGFuZ2VzIGlu
dG8gaW5kaXZpZHVhbCBwYXRjaGVzLg0KPj4NCj4+DQo+PiBMaSBCaW4gKDEpOg0KPj4gICBBUk06
IGF0OTE6IHBtOiBmaXggYXQ5MV9zdXNwZW5kX2ZpbmlzaCBmb3IgWlEgY2FsaWJyYXRpb24NCj4+
DQo+PiBSeWFuIFdhbm5lciAoMjApOg0KPj4gICBkdC1iaW5kaW5nczogbWZkOiBzeXNjb246IGFk
ZCBtaWNyb2NoaXAsc2FtYTdkNjUtZGRyM3BoeQ0KPj4gICBkdC1iaW5kaW5nczogbWZkOiBzeXNj
b246IGFkZCBtaWNyb2NoaXAsc2FtYTdkNjUtc2ZyYnUNCj4gDQo+IFBpbmcgbWUgd2hlbiB0aGVz
ZSBhcmUgcmVhZHkgdG8gdGFrZS4NCg0KSSB3b3VsZCBzYXkgdGhleSBhcmUgcmVhZHkgdG8gdGFr
ZSBzaW5jZSB0aGV5IGhhdmUgYmVlbiBhY2tlZCBhbmQgdGhlDQpTSERXQywgUlRDLCBTRlJCVSwg
YW5kIFJlc2V0IGNvbnRyb2xsZXIgaGF2ZSBhbGwgYmVlbiBhcHBsaWVkIHRvIHRoZQ0KRFRTSSBm
aWxlLg0KDQo+IA0KPj4gICBkdC1iaW5kaW5nczogc3JhbTogQWRkIG1pY3JvY2hpcCxzYW1hN2Q2
NS1zcmFtDQo+PiAgIGR0LWJpbmRpbmdzOiBwb3dlcjogcmVzZXQ6IGF0bWVsLHNhbWE1ZDItc2hk
d2M6IEFkZA0KPj4gICAgIG1pY3JvY2hpcCxzYW1hN2Q2NS1zaGR3Yw0KPj4gICBkdC1iaW5kaW5n
czogcmVzZXQ6IGF0bWVsLGF0OTFzYW05MjYwLXJlc2V0OiBhZGQNCj4+ICAgICBtaWNyb2NoaXAs
c2FtYTdkNjUtcnN0Yw0KPj4gICBkdC1iaW5kaW5nczogcnRjOiBhdDkxcm05MjAwOiBhZGQgbWlj
cm9jaGlwLHNhbWE3ZDY1LXJ0Yw0KPj4gICBkdC1iaW5kaW5nczogYXQ5MXJtOTI2MC1ydHQ6IGFk
ZCBtaWNyb2NoaXAsc2FtYTdkNjUtcnR0DQo+PiAgIEFSTTogYXQ5MTogQWRkIFBNIHN1cHBvcnQg
dG8gc2FtYTdkNjUNCj4+ICAgQVJNOiBhdDkxOiBwbTogYWRkIERUIGNvbXBhdGlibGUgc3VwcG9y
dCBmb3Igc2FtYTdkNjUNCj4+ICAgQVJNOiBhdDkxOiBQTTogQWRkIEJhY2t1cCBtb2RlIGZvciBT
QU1BN0Q2NQ0KPj4gICBBUk06IGF0OTE6IHBtOiBFbmFibGUgVUxQMC9VTFAxIGZvciBTQU1BN0Q2
NQ0KPj4gICBwb3dlcjogcmVzZXQ6IGF0OTEtc2FtYTVkMl9zaGR3YzogQWRkIHNhbWE3ZDY1IFBN
Qw0KPj4gICBBUk06IGR0czogbWljcm9jaGlwOiBzYW1hN2Q2NTogQWRkIFNSQU0gYW5kIERSQU0g
Y29tcG9uZW50cyBzdXBwb3J0DQo+PiAgIEFSTTogZHRzOiBtaWNyb2NoaXA6IHNhbWE3ZDY1OiBB
ZGQgUmVzZXQgQ29udHJvbGxlciB0byBzYW1hN2Q2NSBTb0MNCj4+ICAgQVJNOiBkdHM6IG1pY3Jv
Y2hpcDogc2FtYTdkNjU6IEFkZCBTaHV0ZG93biBjb250cm9sbGVyIHN1cHBvcnQNCj4+ICAgQVJN
OiBkdHM6IG1pY3JvY2hpcDogc2FtYTdkNjU6IEFkZCBSVFQgYW5kIEdQQlIgU3VwcG9ydCBmb3Ig
c2FtYTdkNjUNCj4+ICAgICBTb0MNCj4+ICAgQVJNOiBkdHM6IG1pY3JvY2hpcDogc2FtYTdkNjU6
IEFkZCBSVEMgc3VwcG9ydCBmb3Igc2FtYTdkNjUNCj4+ICAgQVJNOiBkdHM6IG1pY3JvY2hpcDog
c2FtYTdkNjU6IEFkZCBTRlJCVSBzdXBwb3J0IHRvIHNhbWE3ZDY1DQo+PiAgIEFSTTogZHRzOiBt
aWNyb2NoaXA6IHNhbWE3ZDY1OiBFbmFibGUgc2h1dGRvd24gY29udHJvbGxlcg0KPj4gICBBUk06
IGR0czogbWljcm9jaGlwOiBzYW1hN2Q2NTogQWRkIFJUVCB0aW1lciB0byBjdXJpb3NpdHkgYm9h
cmQNCj4+DQo+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3N5c2Nvbi55YW1sICAgICAg
IHwgICA0ICsNCj4+ICAuLi4vcG93ZXIvcmVzZXQvYXRtZWwsc2FtYTVkMi1zaGR3Yy55YW1sICAg
ICAgfCAgIDUgKw0KPj4gIC4uLi9yZXNldC9hdG1lbCxhdDkxc2FtOTI2MC1yZXNldC55YW1sICAg
ICAgICB8ICAgMyArDQo+PiAgLi4uL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxcm05MjAwLXJ0Yy55
YW1sICAgIHwgICA0ICstDQo+PiAgLi4uL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxc2FtOTI2MC1y
dHQueWFtbCAgIHwgICAxICsNCj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcmFtL3NyYW0u
eWFtbCAgICAgICAgfCAgIDEgKw0KPj4gIC4uLi9kdHMvbWljcm9jaGlwL2F0OTEtc2FtYTdkNjVf
Y3VyaW9zaXR5LmR0cyB8ICAxMyArKysNCj4+ICBhcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAv
c2FtYTdkNjUuZHRzaSAgICAgfCAgNzcgKysrKysrKysrKysrKw0KPj4gIGFyY2gvYXJtL21hY2gt
YXQ5MS9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgYXJjaC9hcm0vbWFj
aC1hdDkxL3BtLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ3ICsrKysrLS0tDQo+PiAgYXJj
aC9hcm0vbWFjaC1hdDkxL3BtLmggICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICBh
cmNoL2FybS9tYWNoLWF0OTEvcG1fZGF0YS1vZmZzZXRzLmMgICAgICAgICAgfCAgIDIgKw0KPj4g
IGFyY2gvYXJtL21hY2gtYXQ5MS9wbV9zdXNwZW5kLlMgICAgICAgICAgICAgICB8IDEwMSArKysr
KysrKysrKysrKysrLS0NCj4+ICBkcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtc2FtYTVkMl9zaGR3
Yy5jICAgICAgfCAgIDEgKw0KPj4gIDE0IGZpbGVzIGNoYW5nZWQsIDIzOCBpbnNlcnRpb25zKCsp
LCAyMyBkZWxldGlvbnMoLSkNCj4+DQo+PiAtLQ0KPj4gMi40My4wDQo+Pg0KPiANCj4gLS0NCj4g
TGVlIEpvbmVzIFvmnY7nkLzmlq9dDQpSeWFuIFdhbm5lcg0K

