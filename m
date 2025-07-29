Return-Path: <linux-pm+bounces-31544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF7B148BD
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 08:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194E0546648
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 06:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403027057D;
	Tue, 29 Jul 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QjKA89bt"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FA2701BB;
	Tue, 29 Jul 2025 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771933; cv=fail; b=l7cdglhAiUAleUL0Kwxe2MbcXY8LzIPBst7E0qYLNYvYLNUhVoXKToJ9qSVczcOExPrkA4aJoWQzwogau6JWtsil99it0z/c4TmlBv7DPSWVWzjCQ+dB4koswKsk8OrmW8xiBl5Psv99FPgTp7Te2DNzlZqylQW0vmaIrGkiKzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771933; c=relaxed/simple;
	bh=1YE4H9K0AdkCxIe3aaUCBXDMOiioo18p1K7i8ve8gg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+6Df2eTSBWrwEQQr5UnGh4nc5qHEkSt+23tvHRq3afFSkd5H/1wPLP++hA0r0d+vsD4lH5kGo7/UxcDS/verDdzsagxfRud8Chao3MtV9Ro49unRuO2I7tIIwMP+a0BJU3X0mbIUAnqwszjR83sLJBVPhoquuUEPl1oRZdolOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QjKA89bt; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl7w6uHCIiQ4MjriCOqIEmmg9pfCfyk5WdKVsN4qzC3YkXJAa49QCivOyPq6ecLUKb+ZCiNiuYNZ9J3g1GsNQUWR8vh5XiRYgR3Woj9GTatJG+5/GLc/NwMjNfCK1xg7f5s4ZhjTrCIeqAvc4ojSw1RuE9ffNqN4Nz8mufu4xlHGhr1LMvmMdn3IzGKuWklZ1JhiBkUfFWuYaC7763v8Ib9Obq7+9ryfSIThEM6eddSHSWsvV5erahYLaYw+kSod+GEznKyNb0so4+6wfcrgCK0rDPUcWMNcU/insQXqH8ti82PmHy85tPpHt0BNn3c5niU/E52Dx3ueVI3y8JE2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YE4H9K0AdkCxIe3aaUCBXDMOiioo18p1K7i8ve8gg8=;
 b=Ld3z7ba5tPSG9TNbfbhyRyIQIKApXrYqygf+msApzxWWlau3qhO1hXxjGFXTqutbydvjo3oWkvPWlwSxXln9JO+J6Ru3Cq7+HfhKi4FJKCjQiZWPdEfcT02j+fCM7NDnXgt7PqJYOJcpxM4wPEZg9Esg76+yf4wesrVRNVehV7D/mvxz3VPc2SZ/8AGbAXToBo3ePfc3cDH7JEVKGoFkQZHYhpq/RyFphtcw+NLIcC02dqGKPcsdywEXDu9wqI1En3b2/8ymnCFJX71qY3mVnZKGeiqOUIHiEYW1E5YE6wuKJ5eip0fpGcVBR/5gXVWUTeWtGYLFfeqXZJxhdeDZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YE4H9K0AdkCxIe3aaUCBXDMOiioo18p1K7i8ve8gg8=;
 b=QjKA89btKGnKF4vkZVSCI3vDCopnr8qA1exlzJrQAbWMS0CQtHh1Ou5YnGg15wzNaFekPHv+Eru7biunXNk34TiuGqq4zwbH9N80qApdIFfGeWfDSOpmUvUfc9dE2/ajTp/6pLhvm3KN6GkaBZ4i9YrumA0kxTqAb/CLLz4tJ9dGG4qB+C7qWONt4SVIZh0tuFHgU0sl4tFLgs8uUKlvO29U7oW4HRjNRl0EbpRZAP0LXW44ttMYzxPnVPx6AhOr1PN8k1NJ1tHgMNQlCBvDHhwm+e2+ul/HDn2Rd6LXZmjcxpWcb7FinenYiVYqKh9HpCbCFVvjI1IGnzGsrWSjfg==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DUZPR04MB9822.eurprd04.prod.outlook.com (2603:10a6:10:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 06:52:07 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 06:52:07 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH 1/4] dt-bindings: thermal: qoriq: Update compatible string
 for imx93
Thread-Topic: [PATCH 1/4] dt-bindings: thermal: qoriq: Update compatible
 string for imx93
Thread-Index: AQHcADHFAUgxD7CZQkWdSND6lcgLF7RIp04AgAABZlA=
Date: Tue, 29 Jul 2025 06:52:07 +0000
Message-ID:
 <AS8PR04MB8642331056F6F6042B2725168725A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250729024039.1223771-1-ping.bai@nxp.com>
 <a5b67786-69eb-4c87-899b-0db67c7b79f2@kernel.org>
In-Reply-To: <a5b67786-69eb-4c87-899b-0db67c7b79f2@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DUZPR04MB9822:EE_
x-ms-office365-filtering-correlation-id: 82edd025-bb56-4b34-10e2-08ddce6c6f53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?clo1aUNDL3JlcjNpOURZZTlib1FWeWtSNmxYN3FuZHZXVFhYNk01UDRFSk5y?=
 =?utf-8?B?Zlc1em4xd2NpUFJKbEhvZ0NLZ0dzbWJpV0VFMXZSYjBpWVNwbjQ4emhLS3Ro?=
 =?utf-8?B?LzBkNi9FV2dQbGFyNDRpemVORForMmF1cUpla3IxbG9sSzZGMThNWGcxTzBQ?=
 =?utf-8?B?MEpsaFp2Zmc2d3B0SFlvaFE2Mkh4cHlhb1RtaDVrOERtblZiODlnRkJFRHJh?=
 =?utf-8?B?aXp6bmJpMjlyNjZHZ3ljQ1dsTnlFTXlmZXNjWnM2QWZyTUx5aXhUWTVYUzRr?=
 =?utf-8?B?Qzc3T2wwUWxNaUtjc0pYTy9Tck51MlE2NlBrY0dmOURIZ3BDR3YvWVZyQzk5?=
 =?utf-8?B?REx4K25LVXQvaG9tK1FaMThBYXIvampydWVteWV3c3FFVTVuRFhGV3MxeTI0?=
 =?utf-8?B?Z09RN3pObmNyYkpCTFBiSXp6em9YQis1L3lmMTc4emdXTzdDSys4aHA1Q1pk?=
 =?utf-8?B?WmEwbVhZTUdEcytiWThZWTNkeHc5ZnFVMjZYQzQ4MEVEUG9DS29qNlc4bXVO?=
 =?utf-8?B?Ty9MV1hyR1Z1QWRvTXBaaWhOTU5aOGtQVXFsS3lVbEdIL010TzE4VTFzNFJE?=
 =?utf-8?B?ZDhLNmx5NHJKc1k0bVdheHowVEc1eWlFREloalZxaFBrbmdGYnVQbVlaTWJG?=
 =?utf-8?B?VFNCcUdnVGxWNXJhNHJUOGlJUWJGdmNFZGdCT2tzbFRuRGhwU09OSWxZSk5G?=
 =?utf-8?B?WlJwdmJGWFkzRTBsVkw4WUlNYVplS1g1Yy9UMlZaMm9YOE9oKzdrZXpjaUhn?=
 =?utf-8?B?WWtta2s2MmNoMGVEUFI2akxOMHdCc2hIVHA0cEdQRFh0eGhkV0d0TlU2UlJU?=
 =?utf-8?B?R3dQUEh3TXBTd0I5R281YWVlTS9nL2tsRGROck9uQmszeUhqOUo4YlhzQk1J?=
 =?utf-8?B?OENKYytJZUh2NE82Tk1QWkltcHNDVnlXVHcyZmczL0dQSXhSblpTNmJsNmdo?=
 =?utf-8?B?M3F3UVMxYjJPQmVLbmJxSmhCSGs2cTR2US9jTWxVZ0RXZ0lGLzVJcFRTaWJO?=
 =?utf-8?B?ekp1VklPcEZUcDRGM3lpd2s3VFcwRGtnL2JNT0hxbUNpSDZVWW9KUFZSd2lZ?=
 =?utf-8?B?TC9ZTnFwNTQwUXJFai9qRWdUMjNObW02aDkxNGFQTU1QbW1uUFdLTDBob0RN?=
 =?utf-8?B?UlJVek5mVU1Rb1pjbFNhYkJwcGZjSW9hWXc2QTI5cGMxVmN6d1RNMTJydVRO?=
 =?utf-8?B?QThBdkxNMys4bE9YcTZpMW9IU2QyRkFMNzNZTnpZQWlJQ3ZpTU5oYkk2WFhG?=
 =?utf-8?B?KzBzTnFFRGpydjJHNkd1Y1A4T3pXOWtRQUVYWU1KUGtPV2xuK1ZsL0toYVpM?=
 =?utf-8?B?ajRHaE9venQvbkljY3FIU2ZEVUVGRDZYOGU3Z0p1VmdkcG9Rc25YOXRVNmZx?=
 =?utf-8?B?V25kQ1dxVmtpcUg4NkFNRlIvN2tGWUliRDN5WjFaei9OYUREbFM3bXl2VjlS?=
 =?utf-8?B?dGZQU04rNW5RUmdTZFVxdEprdnpIZzdkZHZoR3ByYzFBWkFBT0pWVTFldjBE?=
 =?utf-8?B?Ykgyb2ZYQ2tvZnBWSFA0NDQ1RysyeE9ocFNraFZQMjhpL1JiL3VVdGlWRjR4?=
 =?utf-8?B?N2kyQU9WUitIVkNCSFk5WVdDR0IvakdTMjExN0loUXhNcTFwM3hkWWptZHB5?=
 =?utf-8?B?bTFKOWFBekVrcWxkRWhCNzVUeHp1Y3l4Q29MdUdQR1JVMWI1cVNZbjJPSlAy?=
 =?utf-8?B?byswN0djSHBaaFQzelZjdi9rOW9ORnlqcE5PVG1zTlFZNmpSNnFFdkVyRE5P?=
 =?utf-8?B?dk1DTEo0K3o4L3JtTDl5a0E0L0xqSE5GZmlWZVZ4eGdDbUgxT04yY2FNRFpz?=
 =?utf-8?B?c1BLUzU5dStNVXdFcHA1Yi9NdjczMmNRSWEyK0pHcjM4MDk0aTdaNVpYUW5O?=
 =?utf-8?B?NVYwVWhQQ1c3OHBrNStwaEY3cUxacFZ4SjMwS1h2Z2pwL1BCUW1iYnI2T1VF?=
 =?utf-8?B?M1JIODkyaE1oMTJqeGZYVytjR0VCbDVqNW9wSEhFb3JrQ3FVT1Y5TWdGQTFX?=
 =?utf-8?B?WnFmSGhDYVBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajFTTm8vWmY4VEcrczZDUWdzYUhYN3YrYkQxK015d0o3eEpHQ2lJMDJ4NlMx?=
 =?utf-8?B?UVFaa1lQUXNjdWRqbW9mcEp3OEIrcUpPTXIzb29tL0U4U2YrQ053UTR1K05p?=
 =?utf-8?B?VVBxaE5ramdWWDQ5KzFLcWVwQmFDMzJ0eS9oVktyRzVCYnl1QWc2d2FsdUY4?=
 =?utf-8?B?bG5zVU4yd1diK1cwR2gyQ1BOWjhCSFdscW1ZVGdXZVZYNW0wSk4wWHZDU1Fm?=
 =?utf-8?B?L0d4Q25UQTdSRGpXZjhGQ2Q1MThpU0dKL1k2bHVnczhQNkNhL3hwT2Y2bWhI?=
 =?utf-8?B?Z2dzZG9kKy92RUc4ZTZEU0V5SHNoMkFqaXRhSUc0eGRTUDBxWmNWN0hNQzM2?=
 =?utf-8?B?MTA3S2FObVJuelhWQnFibnN1VUxkZGF4TU5DWUs3VXlsUnBRU2hURGRTTTkw?=
 =?utf-8?B?bmZnRlFxNGV1bDhUTXc5T1pRUGRCYWNOWUd6bXdpdk9JQTEvVkRJNDRtL2hh?=
 =?utf-8?B?cHg4MkNLNEdpZ0IzZkh5WVFPbkhHbUVmeHpWTCsvaGZpbkNZY3FLYmZod3k3?=
 =?utf-8?B?UEI5WlZPc0tENklPVTNJWjBqWGVJdjljZzdSdEo2Wmo5Rk9Zd1h4UXYrcGNV?=
 =?utf-8?B?VWxxNTVINUQwSnU2Sis0dmtkOHJlYk4zZGlHZ093aThMUTlCKytCNHkyZzJt?=
 =?utf-8?B?SVdsNUZlL1ZkRnM0OGlQaEJnTTVQdklOYWZvY2d1cGpUV1huem5FTEtld3JB?=
 =?utf-8?B?cWV2ZDRBOXFkVXRpMjlMZkIwZHlsU3lIMXdSZ1ZnQkhTamtHWkFJMVNJVlVE?=
 =?utf-8?B?SjMvZk5tb0EzQnFmZlBiZHY0RXc1d2tKMGFkL3RUTThhZmRZUGZZaUFOaWUr?=
 =?utf-8?B?YkFHSWZ5NEJXYzI5aTJZbk1IQmkrZkxCeUdaRkxadlZKNnkvRGtGYzB2cHg5?=
 =?utf-8?B?WE5wSXdIQzBjQ2NlS2dEVk45S1JJN2JGS0x4T2pEUW90NWV5b0s2czdrcXpG?=
 =?utf-8?B?QVlXMm1uaHljeCtnQTJmOTNnMTIwcWhmckVVL0E4NG5FTXU4NWRiYk1vaE40?=
 =?utf-8?B?VFkwQVdSWXM1bC9lNHlrc2NsWWt2bitoZWt6bHBjL3RGZC9wUlAycTdkWVVD?=
 =?utf-8?B?aUovVkozb1ZoS1dPbmF0NEVMYkpveS9rR3o2bWJEaS9NVGlyRTNqU3pHVlcw?=
 =?utf-8?B?RXVBdFJOTkhvQWlnaW5HU0RhTkxQOVQwamk2cFNYRlR3U29aOEF0VFJnWE01?=
 =?utf-8?B?L2Q5WkFYZHA1NHRQTGoyaUphSi83bEkxSmRVNFZUcUtiNkp1cDhSTFJlYWRD?=
 =?utf-8?B?MGd5YTNSRjdrUDlLS0VodS84UjNHNEFtWllKR0FDZTl1MmZwNVRDZWlnVnNX?=
 =?utf-8?B?L2xSamRpMjNqQ0J3VGloS2E4VE1FekFtOHp3Uk9Ea1BDcE5wc2hZSjJ1RXVU?=
 =?utf-8?B?bTliQ1d3ZDY4OEJtSURLSTJUemNyS2t6aFUyenpQOE0xOGZNM3d6VGVSbGFl?=
 =?utf-8?B?Zisrd1QwMkh3WllRbVdJN0lFNXRiYUJvNXdEVmNUR0pRNnAwdkhyYW9MR0I5?=
 =?utf-8?B?VXNJTVBTakVMOWJXL3hOa01kZEhWRm5saVpRYlpnVmxHaFdGdW1PTHUrYnAy?=
 =?utf-8?B?RHRYaFI0YUY0a3hkckVRMXRMRFRlR2RtZk05bVE1U3lUZEtLSXI0ZCtwRU9V?=
 =?utf-8?B?N2JZWFRtYzlVQjV3V3FyeXBvWUxFRnpSdXFZVjczZGtJTDgwV1lETjlmMkhT?=
 =?utf-8?B?VnlpdHFka0s3aWl4dmRwZmV0OHhJRWpQajJnMExBcVZZZnBiL2RlQ2xab2pJ?=
 =?utf-8?B?R2htN1cwMDljSC93RGMrUVBSSzZRa001TEE2YWJqWEpjSVhOTjhGNU9pVTB4?=
 =?utf-8?B?MkthdDdjSU54VGNpRzNKMVMvZ0kxL3NZUXZ4RmxUMEx2YVA4dHpWK29GZENo?=
 =?utf-8?B?Y1ZKNElkVGVLS293eUthSlBYY2ZnT29Fb0dqa0dkeURHVWJoN1ljdXRmKytq?=
 =?utf-8?B?SWtjNHl6dlc1MnBKVU1uQ0hJOHVmWkFwUVhGWmJzZDdTRXF5eHl5UGR5dGVS?=
 =?utf-8?B?bW9HbjV0VTFuTlc0cFp2VDdNditENi9KSmUzeDd6c2wyZE91czVGRTBVa1p1?=
 =?utf-8?B?eDk0eCtndFc4alpHaUZwNHJEWGRCbmtRS3A5UVRPSi8wME8ralFMTG13L3hw?=
 =?utf-8?Q?9bN4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82edd025-bb56-4b34-10e2-08ddce6c6f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 06:52:07.5698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xW7m2U+YxTWPJ6a8oloxr6XP+Zq+6iUb289Kj5qC6vB8cx5QP5eoO6+QwGXH04k8ePdVqJkw2TnZ/a2kPR0BUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9822

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IHRoZXJtYWw6IHFvcmlxOiBV
cGRhdGUgY29tcGF0aWJsZSBzdHJpbmcNCj4gZm9yIGlteDkzDQo+IA0KPiBPbiAyOS8wNy8yMDI1
IDA0OjQwLCBKYWNreSBCYWkgd3JvdGU6DQo+ID4gVGhlIFRNVSB1c2VkIG9uIGkuTVg5MyBoYXMg
c29tZSBzbGlnaHQgZGlmZmVyYW5jZXMgYW5kIGJ1Z3MgY29tcGFyZWQgdG8NCj4gDQo+IFR5cG8N
Cj4gDQoNClRoeCwgd2lsbCBmaXggaXQuDQoNCj4gPiB0aGUgb25lIHVzZWQgb24gcW9yaXEgcGxh
dGZvcm0gZXZlbiB0aGUgYmFzaWMgZnVuY3Rpb24gaXMgdGhlIHNhbWUuIEFkZA0KPiANCj4gcW9y
aXE/IFFvcmlxPw0KPiANCg0KUW9ySVEuIFdpbGwgZml4IGl0Lg0KDQo+ID4gaW14OTMgc3BlY2lm
aWMgY29tcGF0aWJsZSBzdHJpbmcgYW5kIGtlZXAgdGhlIGZhbGxiYWNrIGFiaWxpdHkuDQo+IA0K
PiBpbXg5Mz8gSS5NWDkzPyBDYW4geW91IHVzZSBwcm9wZXIgbmFtZXMgZm9yIE9XTiBwcm9kdWN0
cz8NCj4gDQoNCmkuTVg5My4gd2lsbCBmaXggaXQuDQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvdGhlcm1hbC9xb3JpcS10aGVybWFsLnlhbWwgICAgICAgfCA5DQo+ICsrKysr
Ky0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy90aGVybWFsL3FvcmlxLXRoZXJtYWwueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwueWFtbA0KPiA+IGluZGV4IGFhNzU2ZGFl
NTEyYS4uY2M2NWUyMTBlMjZiIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwueWFtbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwueWFtbA0K
PiA+IEBAIC0yMiw5ICsyMiwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICBWYWx1
ZSAgICAgICAgICAgRGV2aWNlDQo+ID4gICAgICAgICAgICAgIC0tLS0tLS0tLS0gICAgICAtLS0t
LQ0KPiA+ICAgICAgICAgICAgICAweDAxOTAwMTAyICAgICAgVDEwNDANCj4gPiAtICAgIGVudW06
DQo+ID4gLSAgICAgIC0gZnNsLHFvcmlxLXRtdQ0KPiA+IC0gICAgICAtIGZzbCxpbXg4bXEtdG11
DQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBjb25zdDogZnNsLHFvcmlxLXRtdQ0KPiA+
ICsgICAgICAtIGNvbnN0OiBmc2wsaW14OG1xLXRtdQ0KPiANCj4gDQo+IFRoYXQncyBzdGlsbCBl
bnVtLiBEb24ndCBjaGFuZ2UgdGhhdC4NCg0KVGh4LCB3aWxsIGZpeCBpdC4NCg0KQlINCkphY2t5
IEJhaQ0KPiANCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IGZz
bCxpbXg5My10bXUNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IGZzbCxxb3JpcS10bXUNCj4gPg0K
PiA+ICAgIHJlZzoNCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+IA0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg==

