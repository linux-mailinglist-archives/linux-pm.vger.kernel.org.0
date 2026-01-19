Return-Path: <linux-pm+bounces-41072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1CD3A229
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 09:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0769E306E67F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F23502AA;
	Mon, 19 Jan 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g76zNIN7"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FA350280;
	Mon, 19 Jan 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812845; cv=fail; b=unY1A8/Iyqip4HZkOE7UIl1ZSA1Vo48yt2nIeLPFLuhyCzfkZB9TBffP2i6pjJ6Fj9nJOF9VtHezd+QA8DTZwtCubj4nd1QsZjhO/rahEuVAb+l6KXTXgKQc0aFJBZYjW8MQtWgaynF9Gjulfr1uyAVWrYGYfdTODesYUo8UBA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812845; c=relaxed/simple;
	bh=QGMIHHTLYjGiYKvjsNQqGzJoWrvA+xhcDCM+1zfLL1Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jh+YYC3COoEZmPoKqgi18DERfv02A2H1LD9Sj/XDVJjaqLJQNirSXVIX1pHiW40pwz59vpMIyZYCf4QBxwYiZLHk8Bbm/Z6LxtLeGRKRLt1Ea2+ven1nrzzRd0fU2Xhi4hjTtC1GrYRJf/NYIiej8a2HNWnMx4XkLOkEsIn5dQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g76zNIN7; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIqJJtDMho1gR61AZO1vFnUXA0O3qCu9yTv7NA9oaS33pKwziHctjPkJ6jEVw4mtjl/Mu6tbMGm2nvz93AOMiipbpQjs2xR2C6rf55BQBs2BoOuvTaW5d5JqeHkjn2idwAfOF3aeHGZIiUiOqmSo4+2t0neEA+wi/sW0pcWqRiKraAIKspHXb1159L52+2nlIUXQTYU/dE8Lv987iM//qnenJtCHMqfaoD0AtJgu8t1mHs81fklQAgDIrp1SzlYZL8uBa+R6lZ5ZGQP0hcu008Qu+gnaHjLd0ZYC1zOD8dlaOjL1MSsrunrpkDyPz+1VFsf6FfqiXhtzs5oIrfnT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0O6uygT0jLr6ztO0stf2rPwcZSYcRFQ54ehkrVesxU=;
 b=e1pOt12RLN2fNSrkpzuKUbVkphAcZmRb21Kn6fgHCVAaBYrA6if28PyPoYpMzm4PJfUQCS5OMlt1nRnvcmiPC8OTdmE2bRAV8n0vm8addYj3zsNWjjGCIpwk+bcmJjNnHjXXYLtaWEyrV02Yoo/JuTU6QFXQ1o/WTxyJTs6LExLWx2CzY9tu8We5YZ1ti7EeYAknsS2h/tI1k2ndIxFRpOFfQkuHBGofIGvDL+LjK+jIf5Yrww4YANe3TNF+xnXbx/9jaxuha4zOefkiAiD6TWO9GQmu1R8dtd0M1k3trDxpR6P3JcPaYINxUKOuFSwr0xp1e3US8nLTKxXBWD66Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0O6uygT0jLr6ztO0stf2rPwcZSYcRFQ54ehkrVesxU=;
 b=g76zNIN78lnZLDW+L2AYTaba1+Hz2FRNRJNvKlLgCkEFSyXb4YZWttpkwa5HePmJAUFu4s/wrT0YzPKD3G7yweu5PIYaF4F0t1yEJkJjxehh3/9S8ej8G1Lv1la1LPXxdkmtEAWdpHKVLALgWadRVPaU0ab2voccbOtHgvV4cXMOWXo9xkDsFiw/Zr9QZ4ryGA+ao+H+UqVcCZaK6uP3sDwXFHQxA/r85oAgYD1NpzC/8ilMoLSTrvLRJm3IiGOxgujuEe2T4jYwP+VC/ma3LHAn7sD3gt1fj9XzwsyVxZlL0THaWd5BwamMpjZRsPJRAIpaEM2X2a1VJeIgHKJONg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by DU4PR04MB10743.eurprd04.prod.outlook.com (2603:10a6:10:588::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:53:57 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d%7]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 08:53:57 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Mon, 19 Jan 2026 16:53:41 +0800
Subject: [PATCH 1/2] Fix the imx8mm gpu hang due to adb400 reset wrongly
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-imx8mm_gpu_power_domain-v1-1-34d81c766916@nxp.com>
References: <20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com>
In-Reply-To: <20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768812829; l=6168;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=QGMIHHTLYjGiYKvjsNQqGzJoWrvA+xhcDCM+1zfLL1Q=;
 b=SAcHfFlNCr+XM07i+erI4a7qNv/glIxbckN+0TxdKTKQNmBHcDRr6UCro5B3FzU9uqmMPl3FY
 3H4wd0bNh29CPEOoVKfdttEgU/YHkokCOQHW6Stkk9Oadx2DRPH9tiY
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|DU4PR04MB10743:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dc02d7-f654-4651-ba90-08de573847fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkFYbERVbUxXUEMxcXU0dURPVEhxZk5nR3I2d0ZHRWJBRHFETVJlTVcxRFIw?=
 =?utf-8?B?OEVkaDRlREVpbGNoVklPYVpxcmlReTFQajlzL2lDaEhtTkQ0K1Z2dDhJbmxJ?=
 =?utf-8?B?bGNFNXpucTRFSzZCaWt1Nm03WTVTT2NpbmdSU205am0wZHlWMFN4QnRyTkRW?=
 =?utf-8?B?UU4zSUsrUDB6MVRSTmFiK3pzdnFrOFplOUQxWE1uM2VCa1FMOFZFaEdDaWwx?=
 =?utf-8?B?MkxpNmpHYUduS2E3cHhVYmRJeEVFUFhDWWNYQU9PMUtRSGxvWXF4QUlmQk1r?=
 =?utf-8?B?aXluRTBsZW9QSmZFcXhwVzNPM1dUbUlJejE2N0NBckthMFNVa1JGeEVLN0ZK?=
 =?utf-8?B?eWs0Y2Q4TFpBWjJHOWtmSlVhdG9BWXJic0s3VTgwQlM2VDBqcUpDYUI5elZ0?=
 =?utf-8?B?T1U5TGF0bStWK0dwcGdxN0RudUNkc1pTMVBlMXJBekxCWDBXN283UFA1R21D?=
 =?utf-8?B?UkRVRkI1eCtzdlE4dC9oVHhUT3A0LzBQSFkydkpLd2ZBRGtyU2Q1b1ZUc0FZ?=
 =?utf-8?B?blhleGlrZDhuaWJDN25DcDBZS3JrWWNtaDY4ajNmbnZqbmVCS0E3SUpYVDNY?=
 =?utf-8?B?RE5Oc29zZmxxNFd6ZTh0ZnVYWGtrdThGSHZuSjB6Qlg1Y0RUZ1ZBZEtPUnl3?=
 =?utf-8?B?dmFsOFMwS0NWS0lvaDJwVXJrK25UQXM4eXhXVlNaTHQxTE5RaSt0c3BTc0Rr?=
 =?utf-8?B?emdvSjVVSU5iTHVkODJuLzMra1IrRDJhd2lGbWVDK0NTUnMwb0YxM291VkJI?=
 =?utf-8?B?WVRqR0I3YlMvaXFGVy9xZ25PYzFBNXVkOFFpWnV1QkJ3Wk5kblhvWnBleXAw?=
 =?utf-8?B?Q2N6aTlJNjUyWlJROWZ1bGpSNUlnTUIzMFFaNUprNXNyeFB2TlBSaTJxeFIx?=
 =?utf-8?B?WGxQQjZIbERQcnZDS0VTSDVFaGRVSEI4eDJvSDJGUHQ1eGowQzNoTDNZVkhJ?=
 =?utf-8?B?R2p3NHZ2cTBwT0g4alRTWGk1bXpvckdvbXZhRnJ3NEJqRVRNbUJOY2RSdkFq?=
 =?utf-8?B?R25YVW4yc3ZjNzBxRko3c1Q4dVh5cGY1YXVTeEYrbHNwY3JvUmhoT3dvK1B6?=
 =?utf-8?B?TlQ1Q1Q5dGkxNU1vL1phRy9wUXRYd2k3WW5vVHNLM0JvZktXTlNyV1R1bVI4?=
 =?utf-8?B?cldldUk0emJQZGhPUzVOYk9DYWl5RUZKK2VFak9SaVlNOWdCYis1WngxOEpq?=
 =?utf-8?B?bnRiVTIzbjNwZGQvME1GZmM2MUlycWMyWXNBVzNod1FiemVwYkJyY2h4bW1y?=
 =?utf-8?B?dHB5WVRYbENxOThITkdiQkRzVHdzZWxISThHWktZWmVrYUdVZ1V6VVRVVm9Q?=
 =?utf-8?B?bGVWUmNjVWNZbyt0R21hSHBQY2tmaG9CNUw2STZ6YndZMUp0UEozMmNBcDVk?=
 =?utf-8?B?UDRMOHdCOE5yVGVrc2RhVUdRYTF2SjBWMzFkUkRxNzJXdHBjbFBxVDJyV1VC?=
 =?utf-8?B?RXp3RFRtNUIxME1lakpPckZYVlhra3FrK3VkbjdEdElod1RSZ3VTbmtMMFl2?=
 =?utf-8?B?SmtJREk0NU1JcVhhcStPUDdvMldFTWc4T1o2NVQrTE1IcUg5NzNyNHNDQWtL?=
 =?utf-8?B?NEpQUThCcFNPTk9sbEZhdG9qeFlVOVUwR3V4QzhwQ2RYMXlmL28xaG1KYTRw?=
 =?utf-8?B?a1Vqbm9JN3E0bGFwQ2szbjRoQXRMY1lnLzFXbnZlN0puOWNYUHI1Z21ITWdN?=
 =?utf-8?B?SDltcTNTUDJaNEVHRjVEVTlVWjBoZDhtMFNwdVFjZEhVTDdvZG1ZTmRqaE00?=
 =?utf-8?B?K0R3aTkzR0t4dGRhaU15TElGaXJqcWtGei9SK3hzNUs2MlNOdkZIUXBzWFdR?=
 =?utf-8?B?N2hJcVRjcmUwT1JOZUN0WlZxbWUwNmpSY3prYUVkdkM2cHl4c2ZhenBJZGpu?=
 =?utf-8?B?WXFvS3ZmTDFvcndYN3B5N0dzWVVzMSswQzdmcW1iM0JOamhJTHNidm1qL21V?=
 =?utf-8?B?cVdHVzlOVTh2Zjg5cnZaV2N0bTFKd0tIUDB2bkhYRURTNGpIMkZCOU1RbVd6?=
 =?utf-8?B?TU16aFgwTGkwRFpmR0swWjZtTzdSVDE2Zjh5OWxnczF4NWpIdVZpUkxmb1l6?=
 =?utf-8?B?RkNiaXlYL0lLRlRGRWp1M3NrUnphTUl4NCt1bVRvVEZoV3J5aGNDYW1VNmM5?=
 =?utf-8?B?WnREL3lteVZhMTdVU3BzcGQyWnJvanV1VXJPYlJlVmpkZTZQTjRlUDcxMUpN?=
 =?utf-8?Q?vWnNIcSPdKCst/L9R4WuluI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1NxVTN4ZTVXS2wrUVdYQ3VVaU1CdHVNK0MwU0hTaWZrMDdGZUpYbFhZR3d2?=
 =?utf-8?B?RzJ2UWE3N2FyQ3JwOWhhMFg1enJOL1prc2p3UXF4QksvOFJZQXRUUnc5RHVW?=
 =?utf-8?B?MUI2eFJBNVJISjNrVVFBbUovdjYwOURvaDNXckZ4YUw3YzdYU0hzK0VCL084?=
 =?utf-8?B?Z1IvSzdIWUNiRlpQelhGVldtbFd6Ujc2eDFCZVBENlR3SWhyU3VqTWE2RFFJ?=
 =?utf-8?B?RFplcHNMT0pkVVF2ekd1eXlJdHExTGZobTlNWU5yVk9FSFhFVXI5R0l5Zis3?=
 =?utf-8?B?c1IyTmEwZlZhT1QxeFV6WWFZUzRQVGYwUlZSdkZFTzZGY3JpY2l6SUxhalBk?=
 =?utf-8?B?bmt0WlJMY05oWU5tQVNnRkFTaklvRkl3clQwcDRnYnU2cGh6ejNWTnhHK1BQ?=
 =?utf-8?B?K1gwNFNVcjFkakFQcWtkVFFCeDdZS1U3TGgwUElReXlsWjVRMXdvQUtlY2sw?=
 =?utf-8?B?UmRFRU9wOTJMdW5WL2F0eW5melR3WVBjVU9vV1VtK2dGVSs4QVJ5aDhiOFVt?=
 =?utf-8?B?TXBiczMzeVJSRHVGa3d4WVphODBpT1UrNk1QRWJmSGpKb0FvZk9MWTM4bHgz?=
 =?utf-8?B?ZWtxc2t6dzg5dlh6UFQ4Um1paWp6NDN4MzZUdGdUc09wRmVTcWVZdzhlY0lV?=
 =?utf-8?B?UTV0aFhycDVHL2lPcTVucDhjNUs4STRDRnVxWC90ci96a0IxUUtMUTh1NkZU?=
 =?utf-8?B?YXh5VzJ1dEZlaUtlSzcvdUt3YUcvVGUwS0hxTm0xV2NUWGtqSzJRVjREekFw?=
 =?utf-8?B?TXE3MlZVOFhRaWpBMGNtQ0ZBZmFzL0gwSFlBSG1zeHVpSERlbWNCWE12Wlhr?=
 =?utf-8?B?d0dlVjJ5YTdCYWpIaHo4cGVCRTdlc2N0NmJYSzFHcms0L1kveEYrb01DQ0RX?=
 =?utf-8?B?Z01WaFZQZVpvbUhIc2tTZEVKdDI0NURwU01KYkdSeTdmWmlJaU1nb1o3Qjc4?=
 =?utf-8?B?M2FiWlVTZzgwam1Ib3R3YzFldzZBcWZlNkhmQWNJRDBlYjY2VzRJZ29zeG0v?=
 =?utf-8?B?REw2UFRjd2pLcGtaVWRScnR5M25SR3VOS0NUbE1pV2pZTEs0Umt4TjFxS0x4?=
 =?utf-8?B?YTNEVkIrMjRleVFydWZsRXZNVXZFcjR6aWtxZjFxRzVwKzlXYXE0bzd0MERs?=
 =?utf-8?B?YlNwOUQ1TlMyMzExemV1RUFibW5YdlMvTnhiYm4wT1c5M3Fib1JzU1RIUVdm?=
 =?utf-8?B?TWZpV3htOGtJMk1mbWZVMTlDZHJXYjRWeE90a0JiczdQTGpNTWEyUHdxRjQx?=
 =?utf-8?B?Y3hvaU0yZ1g1N0hNOXh5ZWwraEtRQm83MGpFQ2Z0Y1dPOUZpV0srY1lEZzBa?=
 =?utf-8?B?ak4yQkFKUjZZbEt4QWtjZEVFWVBWZzc2bkluZTRFRUJFYm44OWJoVFJpWDJJ?=
 =?utf-8?B?T05iMmZ6QmZxenk2d3JtNm9JNTZFSFVQdlc0c1RjaElOcGVoZTBES0lTdUZ2?=
 =?utf-8?B?eXhPUlBVYkxVdi8xTFlKcm5Mbzl4ZEp5dFVLdTJ4WjU0ZWVNd2t4emR1Zjdv?=
 =?utf-8?B?cXpQUmVCK2F4SnF4RDR5TGxzMnpvUFdoTXNCalB1dEc2OENlV3R4M3R5NEF0?=
 =?utf-8?B?c0FTTWovcmFIREt0T1FDMzZKYU1kSkxITlRFbDNXZHpkY0dRRzFWci9rWUJj?=
 =?utf-8?B?WldqZG1yOW50MDYxNGN2dWQrMnhCVkV0Z2tGaHY0Z3lGTUlPZU5UanFYR1hw?=
 =?utf-8?B?Rk1SdnVBbEhFTXdrcXUydlh0anFURHhYWVhsUWRqTS81TkVneVRlaU9tS203?=
 =?utf-8?B?V3FuKzBXbHdBSnlHbUZLMndYTVBmWFYzREJqSTVIU1dkdUFMdGhQK2F2S3VN?=
 =?utf-8?B?NmJoRXJKeTJyTFdDbjVxMnc0N1RWT2p5UXA1M2FJd1gxOTRKZHlod21oS3BM?=
 =?utf-8?B?Y0Y3UU55bENJeVc1TnFNaWZMa1ZnSUtadXZWelNoQW0wS3YwQnpnYkpmdWQ5?=
 =?utf-8?B?SFBCb2JtQlNhWXV5M1FTOXBBUkFjVmFnRHhtUkNnZDJuZml4amcyLysxYjF3?=
 =?utf-8?B?N3p2TndoRWFLNmQrZzF5VU9jQzRINEdKR1gwTGxVN3o2OFcrVmFGQXV4R25Y?=
 =?utf-8?B?VVdNUlJIZVBXajR0RDRIRzF1cVBjREsrTVlUVXl0VVBMbWJtKy9CZG5SU1U0?=
 =?utf-8?B?M3VubjBUQVA2SWFUcEZIVHJQTTlpNXpwd0JWY0ZBUXFvc2NzRkJkM3FnSG9o?=
 =?utf-8?B?NUNKdnVMN1ViU2lZaDVLUGptNm5oMnhhQUltSlhISDV0TFF4UEoxdGNVNHZI?=
 =?utf-8?B?cjRrMktVb09wQzBQdXBwam0zS0lNZS9GZ0NXUitSZ2JSTnE2bk1KRmxrTWxr?=
 =?utf-8?B?UWxvaXVtQlU5bEpRWkxSaHBLZHQ4YjJibnJBZnppVE9RdEt4OThtQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dc02d7-f654-4651-ba90-08de573847fd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:53:57.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqLqSzE7U5mJmac0w5+2puw2qimD+oNv1Uyi1OSvbjuPI4mT+6Ir6DBIh1AmOvRQxSZZQxvCyv93PnkcNqe/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10743

Due to the HW limitation on i.MX8MM, the gpumix, gpu2d and
gpu3d share the same reset domain, that means when gpu2d/3d
go through the power off/on cycle, the gpu2d/3d reset will
also reset the gpumix domain, The GPUMIX ADB400 port also be
reset. But the ADB400 must be put into power down before reset
it.

currently, gpumix, gpu2d/3d power domain use the pm runtime_pm
to handle these power domain dependency, but in some corner case,
the gpumix power off will be skipped, then the ADB400 port will
be in active while gpu2d/3d doing the reset. The GPUMIX the ADB400
port will be reset wrongly, so lead to unpredictable bus behavior.

To simplify these domain on/off order & dependency, refine the
code to directly handle GPUMIX domain on/off along with the
gpu2d/3d power on/off flow.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/pmdomain/imx/gpcv2.c | 100 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 16 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index b7cea89140ee8923f32486eab953c0e1a36bf06d..3a13aa7f1888863048106c2432eec80c7364c462 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -53,8 +53,7 @@
 #define IMX8MM_VPUG1_A53_DOMAIN			BIT(13)
 #define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
 #define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
-#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
-#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(11))
+#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(9) | BIT(11))
 #define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
 #define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
 #define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
@@ -292,6 +291,13 @@ struct imx_pgc_domain {
 		u32 hskack;
 	} bits;
 
+	const struct {
+		u32 pxx;
+		u32 hskreq;
+		u32 hskack;
+		unsigned long pgc;
+	} parent_bits;
+
 	const int voltage;
 	const bool keep_clocks;
 	struct device *dev;
@@ -335,6 +341,30 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		}
 	}
 
+	/* Need to do special handling for parent domain like GPUMIX on i.MX8MM */
+	if (domain->parent_bits.pxx) {
+			/* request the domain to power up */
+		regmap_update_bits(domain->regmap, domain->regs->pup,
+				   domain->parent_bits.pxx, domain->parent_bits.pxx);
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap,
+					       domain->regs->pup, reg_val,
+					       !(reg_val & domain->parent_bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret)
+			dev_err(domain->dev, "failed to command parent PGC\n");
+
+		/* disable power control */
+		for_each_set_bit(pgc, &domain->parent_bits.pgc, 32) {
+			regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(pgc),
+					  GPC_PGC_CTRL_PCR);
+		}
+
+	}
+
 	reset_control_assert(domain->reset);
 
 	/* Enable reset clocks for all devices in the domain */
@@ -376,6 +406,11 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 
 	reset_control_deassert(domain->reset);
 
+	/* request parent ADB400 to power up */
+	if (domain->parent_bits.hskreq)
+		regmap_update_bits(domain->regmap, domain->regs->hsk,
+				   domain->parent_bits.hskreq, domain->parent_bits.hskreq);
+
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, domain->regs->hsk,
@@ -438,6 +473,21 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
+	/* request the Parent domain ADB400 to power down */
+	if (domain->parent_bits.hskreq) {
+		regmap_clear_bits(domain->regmap, domain->regs->hsk,
+				  domain->parent_bits.hskreq);
+
+		ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk,
+					       reg_val,
+					       !(reg_val & domain->parent_bits.hskack),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to power down parent ADB400\n");
+			goto out_clk_disable;
+		}
+	}
+
 	/* request the ADB400 to power down */
 	if (domain->bits.hskreq) {
 		regmap_clear_bits(domain->regmap, domain->regs->hsk,
@@ -477,6 +527,30 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
+	if (domain->parent_bits.pxx) {
+		/* enable power control */
+		for_each_set_bit(pgc, &domain->parent_bits.pgc, 32) {
+			regmap_update_bits(domain->regmap, GPC_PGC_CTRL(pgc),
+					   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+		}
+
+		/* request the domain to power down */
+		regmap_update_bits(domain->regmap, domain->regs->pdn,
+				   domain->parent_bits.pxx, domain->parent_bits.pxx);
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap,
+					       domain->regs->pdn, reg_val,
+					       !(reg_val & domain->parent_bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to command Parent PGC\n");
+			goto out_clk_disable;
+		}
+	}
+
 	/* Disable reset clocks for all devices in the domain */
 	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 
@@ -787,20 +861,6 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		.pgc   = BIT(IMX8MM_PGC_OTG2),
 	},
 
-	[IMX8MM_POWER_DOMAIN_GPUMIX] = {
-		.genpd = {
-			.name = "gpumix",
-		},
-		.bits  = {
-			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
-			.map = IMX8MM_GPUMIX_A53_DOMAIN,
-			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
-			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
-		},
-		.pgc   = BIT(IMX8MM_PGC_GPUMIX),
-		.keep_clocks = true,
-	},
-
 	[IMX8MM_POWER_DOMAIN_GPU] = {
 		.genpd = {
 			.name = "gpu",
@@ -811,6 +871,14 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 			.hskreq = IMX8MM_GPU_HSK_PWRDNREQN,
 			.hskack = IMX8MM_GPU_HSK_PWRDNACKN,
 		},
+
+		.parent_bits = {
+			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
+			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
+			.pgc = BIT(IMX8MM_PGC_GPUMIX),
+		},
+
 		.pgc   = BIT(IMX8MM_PGC_GPU2D) | BIT(IMX8MM_PGC_GPU3D),
 	},
 

-- 
2.34.1


