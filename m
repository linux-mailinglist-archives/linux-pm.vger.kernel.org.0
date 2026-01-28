Return-Path: <linux-pm+bounces-41616-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIVAAz0nemlk3QEAu9opvQ
	(envelope-from <linux-pm+bounces-41616-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1AA391A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAA5E300A314
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203D336A004;
	Wed, 28 Jan 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TDZ1jHXa"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F16261B6D;
	Wed, 28 Jan 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613114; cv=fail; b=ui4rtBn0zzNz+vCv1Fu3W2VP9cfIoyWbII0Jk3CKo19u4Q6Ik/DXnhPN1DjPw5tTe6qj3Tl0poLqkHZKYbEIeSWB8yRYy9mCVMGoNLO0SFhP72fyO4ZmBtcHmLT5zjiJjBNOquHf0Z7kO2rS0hLP/3B9TJ4kyM9C/RISRMQYZCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613114; c=relaxed/simple;
	bh=3Az1Um+s/RutZCfZdtRTT8YoI5na2kEgMd+sF9YZzyE=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=VuqBxVFPdrKBoGypBZcjmoep3ibjR93IGpURmiia+QzyhJUOUjakyksTMgOz8Bbtfd3/7JDcwm51QRWL01GhC50AfWKlxUqVX4wq0hPeSnhLf5aoE+dakqiALb50JA4YZYIKfvFK3cOK2F0x3mUvPc+GFQs+lIgIuW4kjhPpbI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TDZ1jHXa; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ipie6DFDJwDubsyfoOJPR6m1zSR5Hq094blqKDvV0J2PWdjNtLa3OKA9tpMDrysNPAFMIOTRf1e7DkyIfrAOZzar8DTXEOyzmJM8r1YCYf+QD63LuznObwf6UFu+a+uVOmRGkJdIvwt3NNEPrgkN0fLHe72UTVqy1eLHF6tWB1HaNbvIzyBRzUwD2uwTYfq//kiqTYDw6iakYyLN2B4OApwhlQ6fLbmTd09o114uOhiqxgVDkEq81tgl97aFJh/0QFTYKRt7YAm4J8MpsaiiyvG72wX2/pmZ6eaDsZ+jvlEDtLN/Cz7k5Xs+8q4Tf8+c8q3DFzIcvPgA1J8ox+QbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALFCnKNIjU92vIOqARFDumsZNiNub2RwVFsfXGZgRqA=;
 b=XqhCWAoWMXXb6+ufHgjTAyu6hKrJjG8pWNp+5KDAF9yPbiXTBBP9yZLHDbD4f8vukkhjUp9bEoi70+rly1CTAiGln3J7xTnXzs/Xm7p4sciyVXbZhrN+lmcMOyPK7fM6kh209oUBjAWt5mJVuRsaNle6vBjKySXVCimMQHBkvhCUSULszR+IVLijCtSQa9URBfJPYsqLigEWqWU3an7Hyh73UfkTK9TSdE75q+Tk5zDbGIAMOkgz5Te8VP9CUvsZzaJFDOHl4GX8AjYGSWxXSEh16hBeVeZpPENi3BVb3Z6WCqfR/sYmZcc8/XnkB1/uafnyzbdX5GXyt1SDh7Sp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALFCnKNIjU92vIOqARFDumsZNiNub2RwVFsfXGZgRqA=;
 b=TDZ1jHXaYUOqYJWjg6lOurXl0xgQqAbiJOl53GGycy9uaZZrBbxyJWyJ1leeKZTsBJKsBbb1yUro5mHsDn+pbTFK+2PsbT4F8dS3sF6VBiaBcKesQuSAl8w4ybr/ZMtQYRBgxYyNkGx4iwLTQcjdmn6Rd4DyzH3maHxKA3FoX9DQNdatedf4qNetSJipp/CHpyRo5zraTUnwZMvgKbtyF+ZGFr31OIDFwnHN0/bqRqGCVVOR/+cddqp/jmM4wibTR+qfwlRTq+8ze7TVRqeqHs2psqS6Mojc7HUzbkEXSc/Wfoyii6S4SLPN35uAut5bwPzJXH11VmN39v8fMHOchw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 15:11:49 +0000
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd]) by AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 15:11:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Jan 2026 23:11:25 +0800
Subject: [PATCH] pmdomain: imx: Fix i.MX8MP VPU_H1 power up sequence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com>
X-B4-Tracking: v=1; b=H4sIABwnemkC/x3MPQqAMAxA4atIZgOx1Bq8ijj4EzVDtbQggvTuF
 sdveO+FJFElQV+9EOXWpNdZ0NQVLMd07oK6FoMh46gxjOof9gHvhYlIMHi0pmNxq+W5tVC6EGX
 T538OY84fMGksAWMAAAA=
X-Change-ID: 20260128-imx8mp-vc8000e-pm-4278e6d48b54
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Jacky Bai <ping.bai@nxp.com>, Frank Li <frank.li@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AS8PR04MB8450.eurprd04.prod.outlook.com
 (2603:10a6:20b:346::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8450:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 661d7c0f-a954-4806-b961-08de5e7f8e90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjkzcFg3c3FxNjFjYXdYNDFCN25sd1Q5ZHJseDVlMndpaHo4Qjcwa0thL3dJ?=
 =?utf-8?B?MGd4dmNqanByWDBpYUJOb0dnN2xpUUVWS2NMc2Q0V2lqcER0SElWbEVkVVc3?=
 =?utf-8?B?TlNoNGR3OUE1ZDZvYVBQNGZQbE1rTGVzWStTTFVqNFZ4T1lDL1QyUStBOWlB?=
 =?utf-8?B?NW5yLzNsVmNpVmRueDFxVWMwUXkxL2NCNlMvR1o2SWdVTnptT1FZRmJYZGhT?=
 =?utf-8?B?ZXdHcXdSR3VyN0JDNFRYSlpib3hOZjF1Z3lWaGgyc0J0NTJ0aE9PZ0JoNlps?=
 =?utf-8?B?TE1xbGVqbnFydzIzb1NoTGlWQTdNMzdMR21Ed29EUENhbVVuSVFwemtyMTBK?=
 =?utf-8?B?Rjl3TG8ycFRpaEVVRFY4bkxUSnRoM1BVdzVaV3NxSmdyMjYybVVTTHNvVE9s?=
 =?utf-8?B?bGhZS0hwNHd6aU9QKy8rVGZENnpLV0tSRzF3UThJWTRMNm5QRTVZQkgyRmFT?=
 =?utf-8?B?VHcyV3FzQlNhT2IwcmFQQXlnb0dwUTQ5ajRsVy9tL0grRWUraC9RNENTOVkx?=
 =?utf-8?B?aXh1UlF0dndGK2RFTnNpbjdxNVVzRFp4QzBUQWNLTjJGSlNmb0xyci9wMGI4?=
 =?utf-8?B?TmRzR1JlamtvYUJLNjF4MnF2bEdmdU5hMzh6enl6b3BUbnpqczVpdmduampN?=
 =?utf-8?B?Vko4ZmM0Ym1kOVl0Y0tWVTRXQXMzWjFBdG5sc0hPc0ZmaXNXaEF1SWw4OWow?=
 =?utf-8?B?am5sekNmc3VSdDR1bEtLZlVXaFRYakFseW84Vko0c3M5anhoK3NMNUo1STZP?=
 =?utf-8?B?eERLUjVTdEwycjIrSXdLTHlTdTRMVmdrbDRxVGMzWXdVbW9jTjdlcVRLZk9F?=
 =?utf-8?B?OGV0Sm5Xa2NZZkxvbmVBeFNDM0dKMU5yOHk0cXc5RkpqaFZiSE80dG1UUkV1?=
 =?utf-8?B?UUQxS2pCSVE5RTZRMmdCSTArYXdHQ0tva1RNempJZ0l3b2hpSXYvREt4RVdR?=
 =?utf-8?B?eXVkUlM0bWJQM0ROWHlHRlNCMTIvM0JscW13NDN1SWcwNXViRFJzUHRVREZI?=
 =?utf-8?B?d3dDZHdXTTZvQjNWQ05uTHhzVWR1ZGJoemR1M2VaaTdlV3p0Z1VQVGVSRVg0?=
 =?utf-8?B?MWdtdm4xOW0ySXM0ZDVLUjl4SUFLVWRUeG9WL1M2TWt2V0xra2R4aUVEQnRq?=
 =?utf-8?B?RjZyeTZ0cVRXdjJmUkg2ay9FaURJcEVmRytmOUFRU0tjRkpsY1UxeUxaWHl1?=
 =?utf-8?B?a3NQR05TaFVqeTNLWmdYbENhTWN1cDJnY1BwdzArZmJpazRUN0xoQ3VWR1Ra?=
 =?utf-8?B?bERkVXJWTmNKMkU2N0VrU3k3UjJMd1h0UExwbXF0VjdFMjcrRktERExENGJx?=
 =?utf-8?B?eEZKUUtzSE9HTnRKa2E5SnYzcWM3MVBsV1FMbW0wSDZGYU1yd3pNS0Y4cnpW?=
 =?utf-8?B?K3JkeXFaR2tnSFV1OUp6QTZxUGFwdHBRaDhwTDZreHNJTmp0cVJNc0hQSUZR?=
 =?utf-8?B?SzBtTUUyUU9rMXFWaVE3REZJV0kreDFJRTFhTmQvU2d4WXVRNmM1cWU4UGoz?=
 =?utf-8?B?TVBNOTNFODFCcHZEQ2JBRElyb2tLeFFEMGFSejZHVEprd2ZaUEc2VEZCVWRx?=
 =?utf-8?B?WStQaVNxUjF0bXhuTXJiWHFuYnpxTG5WNnBQS0FWZVBrVEM4Q3hXNnZ1QjFX?=
 =?utf-8?B?T1VmaG0wakdVSE45ZCtRMm55UUtkZm53YW91M1RsczlQNmpZckRSSFVXOWJz?=
 =?utf-8?B?VmZGNTlmYmdLSFp1WlpScDA3bnNDbVVTNmJ2OFh5WUpCVUV6am43ejBmc090?=
 =?utf-8?B?SmxHTkNvdldVRXh1d1p1US9DS1ErS0Y1bDdJd29WV1pndWlMZDNlWE1yQmgz?=
 =?utf-8?B?ZXc3cjZTRUZ6T2lRby9kanlQdkNNVkpTaFdIbG04QTJXa3o2UVIxYWYyWGVF?=
 =?utf-8?B?SENtTjdNbllBTnZVQ2M3M29SVFFxVDNkZjJIUWtpRDJHRTh0V2xwa3YydWlC?=
 =?utf-8?B?anlITS9kQjJDakNNSDZHSFFWZllIdFpCMFpsUUc3TFBSejBXNkhpL2ZpWGVO?=
 =?utf-8?B?akhjUkM1eVRURE5tM2Y5b0VWMU5ORDRSSHVOU2o3WEFjVUordmQ0U2ZhWWNs?=
 =?utf-8?B?eFBJNjlQYWpYRlRWMlNycjVKTlAxeEhvSHgybVd5ejhqMHorYWNXaFZaK0do?=
 =?utf-8?B?cEZ2OWFTTDIzZnUzZXNzdlpxZjVtVlp5aDJURUZ4SWY0dlhpY2M0aHpHUFFv?=
 =?utf-8?Q?kM2pFXbqUCNZMeJ7tta/2IA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8450.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RC85Wm1uWHYxWU96bTBIbWV0eER4b3E3OVFTMFV1WXFZZTJsN0o3SENrME1p?=
 =?utf-8?B?VGQ4RVVJOVBSdU0za1N5clJBSER1WjByekkvTHRHdFF2QjVabEppbHFMRmFw?=
 =?utf-8?B?NUh1b2hVN1RENlFFUzFMZE9yNTBuQ2ZqUFVNR3c0S09Yc0FFVzRpQWpyWndr?=
 =?utf-8?B?TzN4VE1taVZoRklndUkwTHUrZ2J4Nm03Z1NubGx2bVFDK2d6MlZSUTc4VE9S?=
 =?utf-8?B?eGJzTy9VQnlJME0waXpBY3B0TVJqZExMUTVQN2JKckVjTmVXTTFJckhQbFRr?=
 =?utf-8?B?QUJINTNxMGttZUdEbEZHditUV2JtY0dsUW9XSWVwUFZQUVpIbndwVERHdndH?=
 =?utf-8?B?WFg2VFBJZ21GSkR1MnF2NDVqQWw3OEc2ZlNhV1BubHA4eVp4c2ErTHNPaGxy?=
 =?utf-8?B?T0VrSGxSeHcwTEwveWp5MlQ2aEFlYTlDN2xVSTBmMXd5dzZGTDAvWXdVZFpS?=
 =?utf-8?B?Wk5ub2UrR3pYTXVuTXQwaGVTSDl3U0JMZVFIaEdBQSszdTB1ZGFQckF5L1ND?=
 =?utf-8?B?cCtWbVdEMTZ3cWVURGE0TkJzS0lleGNCMGsvWlR6ZG4zN2lXdDM3S0tSdjZu?=
 =?utf-8?B?S1J0L1h5UjVYYjg2VmcxSXI3VnB0MXp0ZUt4TjBseGFYanE0MzFQVjd5Szln?=
 =?utf-8?B?dE4yU0NKVUwwelJSMXcvdXRmdG43aVJpOFRWWXlSbVBoV1lmbWExTTRwbmsx?=
 =?utf-8?B?QVdVaXRmU1FrVUw5T2wxOVdMcE5yd3FkRFJEMVJHeGEyUlQ0V0pHN21kR0Nv?=
 =?utf-8?B?S2pBMzJBdGR3YndkZ2xONnNCb1R5dEdNNmZFdkZOUW1iMmxZU3VMQTBMYnhs?=
 =?utf-8?B?U3BQWSs3Y2JTY21GLzBhRWsvVmtvME9CVlpQdkRuUDJMeGo5ekpnWU9BaGQ2?=
 =?utf-8?B?eW5kSjQweFlvby9aNGZzNkJCSXVEMWNVUjZkaWR3ZDRHOHZ1Z1J3c0dzbElw?=
 =?utf-8?B?anRHM0tlWXNUbHlINVZkVlJKWUZQKy9rbjBuN2lyYXdpRnpsU3o4a2NnUTNN?=
 =?utf-8?B?eTdDYUZGa3ZGdU9pdHVhM3MrejFYSGtiS2VadmFweFhXUy9OektaT1NQVHAr?=
 =?utf-8?B?MVNCcVRMRHM3VFA3Sk1GZ1hObEJlTk1WNVpLWjBpOUM5OHVnZThkSDRyL2Ji?=
 =?utf-8?B?aEhoUTNNbzZobko4SmYzbUlYL0s0dnZNeThOMzBOaE4yUis3SE1DVWJyZlFj?=
 =?utf-8?B?Qjc4TlI5YW1KMS9makI4UmNhQUVWMXYvdEpVT0RORWRvNW15cWFMZjJYSXNG?=
 =?utf-8?B?aGhkaCtzSzM5NzhrSXZFRlFIN3FZbFkvck81RVc5Qzd6UTdHRGpKREJHS0RZ?=
 =?utf-8?B?SmsxbmZSUnhiMm5jeC9CeERkaGlmc3VTaFNsaS8yaUpOY0xXY3pRTDNaVXVy?=
 =?utf-8?B?bHBQQlpvaDBzQXBUcFluYUNiVEVtejk2TGpvc1VOaVRNVjhLTVBkblNUUDl5?=
 =?utf-8?B?STdCZi9xNTNTZytDdXljSy9UbUxUWFgxYldXVFgrbmM5MEJsRWJGRjdqbVJL?=
 =?utf-8?B?NzRxVTVMYVJoZXExN3RzZklaUjJZc2tHSjNldEdHYlAzZUN4eWUwVHpvOWdL?=
 =?utf-8?B?eGtJWVVML2s0SjFGbE9MWU1yemZQbW9qcmgwUnpEV1RkaTEzU3QrZlRTQnQx?=
 =?utf-8?B?NE5xMm1MekNrdEo3RjVoSkFrOG9HV1E5ZDhUMjFQeTdxMytuM0JiRllncUcy?=
 =?utf-8?B?MzViU3dIWkJkSHpDdHhMcGVUdHEwSkh0cXNmekFqNkJDV1BXMmhQMm1LZGRl?=
 =?utf-8?B?UDlOOVl4Tko4enl4RE9RZjYzN3lzTGVJaEpnYWw4S2pZYW8xbmw1VVVLQjJy?=
 =?utf-8?B?MTdnZjlqdkE5ZEZ6RVNxM0V0SEdhb0lZVGFacHNydmVmdDNkaHFtZ1B2Z1lU?=
 =?utf-8?B?NERYdTd1SkNTMmxhLzh0TUFpNEFNQmNmbmFhTWJ0OWVMRlpkN2NwU1VFclZ2?=
 =?utf-8?B?OXpYV29zdnJrUVIrNUpTU21EVzhxa3NOVWFTNzh3WVAwK2ZHL2dIQWJaL0pT?=
 =?utf-8?B?eHdqeUhtNUk3ODM4S0d4YVpzZklQTTVZRE45QURjSnhnc29LTXMycXgvQjZE?=
 =?utf-8?B?dG9qZFZ3SGpBdGVvK0lmc2YvYjR6Q0Q4Sm1hZXc3WGF2ZytSK0NSZzNQUWdE?=
 =?utf-8?B?bElFZzlGRDMwSkV5QnZFeG91c2JMejJ5YXJESm5BVkFzaTFMNlBqRHV6V2Jz?=
 =?utf-8?B?UXpldmRZeE0zTDFyTHE2U1dPdzUra0FHekFqelJwQ01uYjkvVFhHbklBRS9Z?=
 =?utf-8?B?cG01YnpiNTBTdFZTb3UyT24zUzlrbDgycC83eVgyMEY0N1g5SXhQUEtSWEZX?=
 =?utf-8?B?WGZ3Y2EwYXNMY0s2N01QME82Tnk0eVVCeTltY2d4RzJEcWY5Slkzdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661d7c0f-a954-4806-b961-08de5e7f8e90
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8450.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:11:48.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkpGSFAcg6bQv9r3e6XbJ0hZToE84MO/WhcYzLnmrChzgal+/qnj8X7oek+WgJ89GDS5DQEFSZIazNEOFAWhcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41616-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83C1AA391A
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

Per errata:
ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
power up/down cycling.
Description: VC8000E reset de-assertion edge and AXI clock may have a
timing issue.
Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
de-asserted by HW)

Add a bool variable is_errata_err050531 in
'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
is needed. If is_errata_err050531 is true, first clear the clk before
powering up gpc, then enable the clk after powering up gpc.

While at here, using imx8mm_vpu_power_notifier() is wrong, as it ungates
the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
imx8mp_vpu_power_notifier() for i.MX8MP.

Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 37 +++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 74bf4936991d7c36346797d8b646dad40085fc2d..5b26b7c2c43172817d5e407a7d85eb6c5400d5a8 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -54,6 +54,7 @@ struct imx8m_blk_ctrl_domain_data {
 	 * register.
 	 */
 	u32 mipi_phy_rst_mask;
+	bool is_errata_err050531;
 };
 
 #define DOMAIN_MAX_CLKS 4
@@ -108,7 +109,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		dev_err(bc->dev, "failed to enable clocks\n");
 		goto bus_put;
 	}
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
+	if (data->is_errata_err050531)
+		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+	else
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
 
 	/* power up upstream GPC domain */
 	ret = pm_runtime_get_sync(domain->power_dev);
@@ -117,6 +122,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	if (data->is_errata_err050531)
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
 	/* wait for reset to propagate */
 	udelay(5);
 
@@ -514,9 +522,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
 	},
 };
 
+static int imx8mp_vpu_power_notifier(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action == GENPD_NOTIFY_ON) {
+		/*
+		 * On power up we have no software backchannel to the GPC to
+		 * wait for the ADB handshake to happen, so we just delay for a
+		 * bit. On power down the GPC driver waits for the handshake.
+		 */
+
+		udelay(5);
+
+		/* set "fuse" bits to enable the VPUs */
+		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
+	}
+
+	return NOTIFY_OK;
+}
+
 static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
 	.max_reg = 0x18,
-	.power_notifier_fn = imx8mm_vpu_power_notifier,
+	.power_notifier_fn = imx8mp_vpu_power_notifier,
 	.domains = imx8mp_vpu_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
 };

---
base-commit: 4f938c7d3b25d87b356af4106c2682caf8c835a2
change-id: 20260128-imx8mp-vc8000e-pm-4278e6d48b54

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


