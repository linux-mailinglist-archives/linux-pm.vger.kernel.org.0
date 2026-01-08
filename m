Return-Path: <linux-pm+bounces-40485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053BD045F4
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90000304479D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DEE279DCD;
	Thu,  8 Jan 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BKSVTTkw"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278212882DE;
	Thu,  8 Jan 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889459; cv=fail; b=tE1PLjaLx+8DqhtRO+IpPWJTV+MsRXmg023kw7ATCgVknQe5nn8N3NxuI8K4kdf4AjkHOBQynSCajMHeUaEfW7dGJm3yTfquhaCcRj8IrxG2QAZGrH5ytzBfoWzCZbzZmdANkf8397Ia4rEmcM9wrRUGtOrko+R6p+OaOPZKqIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889459; c=relaxed/simple;
	bh=qmX1Rdu/punmLw19C6shwkaZDBF6QUG8zVGaERnxkdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rQtONC+o34dkwnu4ka4KTSo2GBeCChRlxz4K8q4XjLULdNuCJ2sG1/5FL04thQzC7/pOKQMXCCGvbbOkLI8EoFceNkIBK9j7D60RmD8R4L1206PXQoSW2RCkDdgHSaqd6AyrjayZWOrbQOSJdIABTdhK0VeNkD94e3rhkKI4Hag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BKSVTTkw; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrkAO00nXCRJZynncGpVToS8EsyXUTcQoP8AtmRsQrgl79A1y0+WfG1Dl6XZH3ZLNc+1O7Fgs7y3OLsAo3/HP+oSsqAjzNDu0pfdCk3nTV9wVwKwz5H4PQZNKKOQMWYNZFMZaKNSw5ftr8NfaULCp3dere98Ye8ZvekhawfVmmoyThsOVmSgNhNHLFlIEKjrlNSV1dqEqfmYNxv+IbpW0BKznf/uurMkqbh1fHFIHl6v+PhNUUanusZou6W0/0RWHB9j41ghy8OaJofsXGVPmImVodT8FfiSMx1IkThSBxy5mOU3InqhkSS9XVY0AAhBnQ19QFwhHhsR3sEkICtuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IWS9RUStmCTBLr23Yy7Jz6HGgf6Yd26xa2qUmw/c30=;
 b=serZQq26U2tuxEuX3MgB2X/Bsc2rwIVGPg97VTLftLhqG99vgv0h0xB0Xgf/IxG+fHdyjDOj0mNDAsfp6gatjERD3X3Zx0zs+5UTppLTg+IyrJuv0AucSo34QKxXLDCiKAhFdbmGF8ACy5yany81JG1/4IAdk38nlETIYYjoYi7cAIn2POTQJDNrInWM08pTAud6WuSp/1M8C9cnl/avszAJWgAwyU/zT/7tt74o/UPTUDDSfV1Liv9NzxEQYkmdr7xc8wZsO2J3L0sGjtO+9XY9grQliSJ0AoG7ZJHMfGkJ0NXUxR8wkLQg+lKVL9Hv/jFROZz7eXpx3RpCXHtbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IWS9RUStmCTBLr23Yy7Jz6HGgf6Yd26xa2qUmw/c30=;
 b=BKSVTTkwr0f2O8D30jPgkONb9doPRFoSusjbLu+KT2afkPBv53iycj3EVfPS6eePxF7LVtNiwmbalx1FONrlPvlUItKjdQG17pR7IBzTfJmFiBNsBBLykV6QqTMAFvQY8YLZVU10Q+CbB4Y9F9pd9vfNXeWC9pRCx9bzPYqbdWfIFMttK1AcVcEbk/7d9BjuxXprWABHCpw9GnA1UPSo1B5axrXUWr+ZTeM3uN0uyCUqDQ1fRd54gtHlI+1gm4GAM2YvKqwCiynC9o6FETXDEJW76YE6KiClc4GQGQXfmrUGMW65BbPwPo4La9Bxyf6tGIEK7tFmnvRVgXhHf3Tx5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB11632.eurprd04.prod.outlook.com (2603:10a6:150:2c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 16:24:12 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 16:24:12 +0000
Date: Thu, 8 Jan 2026 11:24:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ye.li@nxp.com, joy.zou@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 2/3] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <aV/aJXSU7jSw/6hu@lizhi-Precision-Tower-5810>
References: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
 <20251020-imx91tmu-v7-2-48d7d9f25055@nxp.com>
 <86748f89-8bed-4435-98c4-991e649e5b87@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86748f89-8bed-4435-98c4-991e649e5b87@linaro.org>
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB11632:EE_
X-MS-Office365-Filtering-Correlation-Id: ef986f83-a65e-4c5f-153d-08de4ed25bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djNBSVVVb2JzaVFBTmFmNmFOUTd4T0RFSU5QeDlGUlpkQU5pVUk1bjRkdmhM?=
 =?utf-8?B?L0RpS1M2cHF0NDFPWEJFbk41Y0ZnRnVCS0c2cTA0aS9KcGd2Si9OWW0vSVN5?=
 =?utf-8?B?NTE2RStmT2JqSEVqR0FmWUNreVJGVTIrUmRyaUNQbGNHOUhaTm91QmxkREU4?=
 =?utf-8?B?T0NRNWJMdnlRU1hBV3FhMTM5WXdZQWxWc2RpWTRSK1pTd3p5ejdmWisxNXVB?=
 =?utf-8?B?WFc5M0pRakZzeHhhNkR4Rng5RmJwVXZjMHVkVm8zelR5SUVIZDhrZ0hiQnYv?=
 =?utf-8?B?UGV6MitmM1QzMStEdzB1aDhDRTFPVUVDOHEyeEhzR0RsejJGaE4xN28wN2pD?=
 =?utf-8?B?VURQKzg2OThxNm9mUjIzVit0dlJFcnJIQU1ROVZ1UGJVWmlHNGZjdVdzRXJZ?=
 =?utf-8?B?dHlxWXpIT2IzYXdkVTJjS1M5aGNsczducTI1a3MyNWxrRjRaOEZnNytNY3Fv?=
 =?utf-8?B?QUNXUVdwQmxPMndNSVo0cnJReUFqRm91Z0NFTnJrWkY3Y1FYbkdzMllzUVhk?=
 =?utf-8?B?eHk4bGc0V3dXWEg3Ny9jQzFaOEI1NnBFMXhxODhZRE9EcWRuZGkxN3kxNU5J?=
 =?utf-8?B?Z1U5aGlnY1VGNWxUTXppMGhMZm55QkdDRnNZQUFQR0ZsTGw0K2lsUEN1dWdH?=
 =?utf-8?B?cmJ1azFweVdmZWhlanZvRGxZUEVYNmZDQUtNNU9URE52K1pkR3hRc3pFbkRL?=
 =?utf-8?B?Zkk4dk45RytRV2xuZUZILzVpaUlmem9yUktxWlNjTGdid1oxdUwrOUFzdkk0?=
 =?utf-8?B?TlNzVDI3MUphWVp6N0JzMUhCL1QvZTNVdmpKTGlWTmJnaUhiayt6V2lGYnp6?=
 =?utf-8?B?dE16ZVFTV2ZhcFE3cTR1T2dmbm83eGRuTnovUWlIS3VSaWdNREtzVG5HOGUz?=
 =?utf-8?B?QVl5TVFTWDJ4L0R6UzNVNDNZWU1BOGE4cFMzaHhTb0tjcldma202S3J0elZu?=
 =?utf-8?B?TUJ6M0ZRbzhWNEo5NlpUQ2VpMDNNQ0pRSXBQTFFhcEpTalVlWkdzdjVtTllF?=
 =?utf-8?B?WUR5aEpkNDgrZXpZL1pITmowNFB6ODJQYkJuamR0K3dzSDIxam10U2NTa0tv?=
 =?utf-8?B?U2dKL1RKL0RWZk9KWkN0akpNd21lK0lYdTNJWnRWRDJwYzNtMkt4cEU4RkJX?=
 =?utf-8?B?Tm1Ud1lGSHgvcmtPR0VHN1N1UXZYc3BPMWp0YWpkUVRhcjU4K29IeENZOEJu?=
 =?utf-8?B?U3BTdDQrbUdJeDFFZ0RlaiswUlp6czg1b1YwdUxuV0krZkVCVGxORWdWSFFV?=
 =?utf-8?B?UmdXY2ZDN2JXaEdhM1VnRlIyblNrdGx2YlVzUm5aZnozR09taUx3N0FnTjVh?=
 =?utf-8?B?WEJKLytmZUhieThsUlpMSDBsM1NBRXdzVG1pamdycXJ1Q2FnS0JNWjE1UVpz?=
 =?utf-8?B?OUZIcXRLMGJHc0t2L2RWdi9SWk9mMCtwWWIwSTd5SUNkUVZ2REhwNjZOVVhz?=
 =?utf-8?B?dDFveUlZaDcyZUd5N3NSaG1wVnNvYVYxT215TGdlWUQ4QmgrSmhVbDVkb3Zm?=
 =?utf-8?B?dytDQVRwU1NOQk9VeFNndi9TdEU3QWZ4eEJlNUhMZlcxRlVRSURJRkk4OEtB?=
 =?utf-8?B?Q2NWZlpOeG1rUG5JNjZCVnRjQTdncnpNbTZXeElvcSszYjBoZnpHZ1ZYU3Zs?=
 =?utf-8?B?Q09BcHNwdHI5Nk1heVN6azVpR3l0eDJweTVvSFBwYjNRZjVEWDI3MzBUZ2pT?=
 =?utf-8?B?K3ZKMmN0MFR1NnB3OElHN3FzQ09SM0xXSVRjRnJiK0g1U0ZQMnFmZUljajVp?=
 =?utf-8?B?YWovY2JVdkU2RnRSSGJlM1oyNnk5WGplWDAxNW5PQzVUQ21rWU5iTmFtWFpZ?=
 =?utf-8?B?ZjJaN1pMOURNckRkY0tkcEh2YitKb28zWGh2eTVZZlk3aVRBRHV5aDdmMFJk?=
 =?utf-8?B?Y3UzK3J6N1RKWlZIeThkWkNQWGQ4eEk3NlhYZDF5dUo3VXZ6OUpCbXhIS0NN?=
 =?utf-8?B?Rmo3WktMR2VXNyttM05FQXlJM3BBYVNWOHZNM1I2MWsrSHhiUzRsRGdDL0lj?=
 =?utf-8?B?NGR4TnRKTnJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlJBcklmOHdVeHhTWjVRUFR0RVl0Wjh4QzFkMVZISG5EQXhQTlZOa1ZtN3hn?=
 =?utf-8?B?RVZ4QWdsTWtiN2pyN0l5c2dtQXpzU2RLRkFMTWx2eGhFSUNZQkd2S2tubUJp?=
 =?utf-8?B?OGl2RVFJdHlCQ2ttVm5rdjViQTVqVW84NnBmdkFzOGgvMGxCRGRIQlFXMm5S?=
 =?utf-8?B?cnNKV1BsRDh0WDhvUjJIYTIyWDdrTVdRVDEycnhyN1c4L282MzJKN1BkZGVN?=
 =?utf-8?B?VWM4cDNSQ3o0MGtndXNIOVYzQkhhL3g2VFJZS3lEMEVoZCtkWFdnZXJ3NlVX?=
 =?utf-8?B?bUpKOFcxTUI3RzA4U3ZwWElnUENhMzN6L1hjYnhOYjl4TzlKb2ptKzdlajZS?=
 =?utf-8?B?NlhjcnpJWVR3T3NvYkFFZEZadkgxNEJTQ2ZQTFh1Qk8wMmh4QjA2TGdIc3Ba?=
 =?utf-8?B?a0I4SmdpQjlqOHV0bkpmcWs3NWxneHFFcVRVWmVxNStlTGREOGdiMVhRRVRI?=
 =?utf-8?B?ZGcvc1RZV0dGTDdFeFo3K0FvLzBINTF6MVBWaFoxUDMrUnFNR3U5Mmt0Tm1w?=
 =?utf-8?B?UzZ5WTdZZ1ZqVlZkeXVNenpHNWNJekxXcVpkc1dySThYSlI3MitDTkQ1Vi9s?=
 =?utf-8?B?ZTIwaCtDV1lGRkE5dTFPVXdPMlFkWDBaWmt1RXpzVnhqT2F5bCtnTmpDSi9u?=
 =?utf-8?B?UjludFRSZkVrRlV3NDlxdFczUitYTk9RZUc5ejRkYlI1UlpRYUlrL2p4cDB0?=
 =?utf-8?B?WHpIaVg3dEsxSytCb1dMeVhDci85RERoRSt6SWJjOTB5R1pFdlM5QTl0Sity?=
 =?utf-8?B?OUJDQm5DdUp2ZzlhUHRPVklUbmhCSmpiUTIvbEp4QlVFV09FNFBlZGxWcSto?=
 =?utf-8?B?bXdwYVo4WlNldXpIZVRiLzY5Y0poQTJIL0dsQ2dFK3pSS2l2K2lDcjlLR0JL?=
 =?utf-8?B?d21BMCtaNWUydEhrUWMxUE9XbGVUN3RsdGdCT1pXeWt1ZFFnMDFtYm5pWUJW?=
 =?utf-8?B?ZHVjQVg2TUdXbjQ5QUdCMmN1ZCttRzJXMjk1SXIrbzBmRnNiOXJXbTlrcllu?=
 =?utf-8?B?NHZRSkV2UGg3ZC8yTkVHV25HT3JWb0Y1cWtPc3lYUmxrSHpYVzZuMU90RUsw?=
 =?utf-8?B?UllZUTVaQVE2LzljSnlIbnp4Q0NHVFZFS0FUdU13RHhvcUV4dHdsZG8wSmVS?=
 =?utf-8?B?VU1pdFhEN0JscnJ4UG9YMVM1TUk2dW96YVJQWFVyOXgydmM1RXJVQ0FZNXRr?=
 =?utf-8?B?K1c0VnlRY3VLUTZWeERhVCsrbnhxekZFT29WNWZLenhONGZsSy96bXJTRUdz?=
 =?utf-8?B?eWtQdHJvNTVGeDF3c09MbklrMGZjMlZPeXR4YzlycVErLzdueUMwOThlejFz?=
 =?utf-8?B?cHBaQldKSm9EeDNwSU5vZW96RnJoVHJqMUcrS0EvTForUkpHMHNpMy9uMkhn?=
 =?utf-8?B?TzAybjhFdnZoTjdRTS9ERW1oWGFSTjZKY2xKUFdhM3h2ZjNNT3ZKaHZtMTJD?=
 =?utf-8?B?SHlVTnk5UFpHT3h3UWdDRHQ5YXFQTmJUV1UwcVFOZ3lMcjBhVGRqeERncmFT?=
 =?utf-8?B?eHl5VWk0SjVacmZlcFl3b0VQMk9vbW9iNHBzTmNuVm5zMG1VaWJ4UzBOQmlx?=
 =?utf-8?B?Yi9TR0dTeVcwcHRxZjg5S1lMMDZzS3A2WDhsdlB0d1JtMTFEdi81WlhCNlNT?=
 =?utf-8?B?alBXRVh2ZHZ3TmtKdG1uVDB5NzRFQUxVNFJFYUN1Q1EzQ2xrSk1rVWUvVkNI?=
 =?utf-8?B?WWdUYmVueHVhdUtsRXJvQS9GcTVoUVhPUGZZdjZWY1pXeFFpdGlhdG9BZXlU?=
 =?utf-8?B?NFpyVXR4Q09sT0tzT1ZOcWZKRWR3SDAzSk1FWitTbk9YWmtvRmZlRFM1dTQy?=
 =?utf-8?B?RTdzem5SYmNQdW4zalFhdXlHVlZFaEw0Q3AyZEVsSkE2TnV4ZkxIYWdZWEZ0?=
 =?utf-8?B?NjVkaFdLTExZeTNMWVBuMUV0VFlKdnpqM09DaFRvS3FueDFvcWZ0VlhnanVV?=
 =?utf-8?B?L25OOWxqc04vR2tlNUNLZk1BTk5EVG0xYjQ5elR5dkdPOUZEYVlYbHMyRnBJ?=
 =?utf-8?B?Skg1cjEvVTBiS21pSHFmMVFFRk5DWFV4Y0RnWk4wQURPTnZ6UFdFSnhZZHEv?=
 =?utf-8?B?TnFhV3lMVlRWTFJGTzNraHR2MVpVbkJWakJsSEdYRlFZaXNHZEIwSUN3ekRD?=
 =?utf-8?B?S2RBV2E2TXNSNTh5ZXZhV0ZDMlR1RENoSXJZckZvN0UzWnhLSHlLd1FLaSs1?=
 =?utf-8?B?dm0vR251QWdDZ1hFeTRIWkljcUl0YVU5cDArSjQva2RVekNzRk1hQzd5bXdC?=
 =?utf-8?B?MTZlYXpVdUVMc0E4WExPM01qNEpMNGxZQ2x1ZzMxa2lURVBFUXhtREF4eFM4?=
 =?utf-8?Q?egm7t17p6Em/6CBuK9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef986f83-a65e-4c5f-153d-08de4ed25bcc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:24:12.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr9znfbwS2tWxAgEYy2gfGMkGdqM86/stV5rD3Gec+6g4L/ltswlHW2dU4HG1Nf05QHhmkuIddrVFHRzaqK9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11632

On Wed, Jan 07, 2026 at 04:22:20PM +0100, Daniel Lezcano wrote:
> On 10/20/25 21:00, Frank Li wrote:
> > From: Pengfei Li <pengfei.li_1@nxp.com>
> >
> > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > single sensor for the CPU. The register layout differs from other chips,
> > necessitating the creation of a dedicated file for this.
> >
> > This sensor provides a resolution of 1/64°C (6-bit fraction). For actual
> > accuracy, refer to the datasheet, as it varies depending on the chip grade.
> > Provide an interrupt for end of measurement and threshold violation and
> > Contain temperature threshold comparators, in normal and secure address
> > space, with direction and threshold programmability.
> >
> > Datasheet Link: https://www.nxp.com/docs/en/data-sheet/IMX91CEC.pdf
> >
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change in v7
> > - remove enable field because framework already check mode before call
> > get_temp();
> > - only call runtime_pm_get(put) in set_mode function
> > - remove enable irq at get_temp.
> > - Enable GE compare irq at set_trip() call back
> > - Config GE irq at set_mode() when start measure to avoid issue unnecessary
> > irq when clear Compare mask (generate one LE irq).
> >
> > Change from v5 to v6
> > - remove Macro's review tag
> > - remove mutex lock
> > - use set_trips callback
> >
> > Change from v4 to v5
> > - add irq support
> > - use period mode
> > - Marco, if need drop review tag, let me know
> >
> > Change from v3 to v4
> > - Add Macro's review tag
> > - Use devm_add_action()
> > - Move pm_runtim_put before thermal_of_zone_register()
> >
> > change from v2 to v3
> > - add IMX91_TMU_ prefix for register define
> > - remove unused register define
> > - fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
> > - use dev variable in probe function
> > - use pm_runtime_set_active() in probe
> > - move START to imx91_tmu_get_temp()
> > - use DEFINE_RUNTIME_DEV_PM_OPS()
> > - keep set reset value because there are not sw "reset" bit in controller,
> > uboot may change and enable tmu.
> >
> > change from v1 to v2
> > - use low case for hexvalue
> > - combine struct imx91_tmu and tmu_sensor
> > - simplify imx91_tmu_start() and imx91_tmu_enable()
> > - use s16 for imx91_tmu_get_temp(), which may negative value
> > - use reverse christmas tree style
> > - use run time pm
> > - use oneshot to sample temp
> > - register thermal zone after hardware init
> > ---
> >   drivers/thermal/Kconfig         |  10 ++
> >   drivers/thermal/Makefile        |   1 +
> >   drivers/thermal/imx91_thermal.c | 384 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 395 insertions(+)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index a09c188b9ad11377afe232d89c60504eb7000417..b10080d618604ddd90295bff973e337ae0509059 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
> >   	  cpufreq is used as the cooling device to throttle CPUs when the passive
> >   	  trip is crossed.
> > +config IMX91_THERMAL
> > +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	depends on OF
> > +	help
> > +	  Include one sensor and six comparators. Each of them compares the
> > +	  temperature value (from the sensor) against the programmable
> > +	  threshold values. The direction of the comparison is configurable
> > +	  (greater / lesser than).
> > +
> >   config K3_THERMAL
> >   	tristate "Texas Instruments K3 thermal support"
> >   	depends on ARCH_K3 || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index d7718978db245faffba98ff95a07c7bcbc776fd2..bb21e7ea7fc6b70aa84e5fed7cfdc7096e3fb1f7 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> >   obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> >   obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
> >   obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
> > +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
> >   obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
> >   obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
> >   obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> > diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9b20be03d6dec18553967548d0ca31d1c1fb387c
> > --- /dev/null
> > +++ b/drivers/thermal/imx91_thermal.c
> > @@ -0,0 +1,384 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2025 NXP.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/thermal.h>
> > +#include <linux/units.h>
> > +
> > +#define REG_SET					0x4
> > +#define REG_CLR					0x8
> > +#define REG_TOG					0xc
> > +
> > +#define IMX91_TMU_CTRL0				0x0
> > +#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
> > +#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
> > +#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
> > +
> > +#define IMX91_TMU_THR_MODE_LE			0
> > +#define IMX91_TMU_THR_MODE_GE			1
> > +
> > +#define IMX91_TMU_STAT0				0x10
> > +#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
> > +#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
> > +#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
> > +
> > +#define IMX91_TMU_DATA0				0x20
> > +
> > +#define IMX91_TMU_CTRL1				0x200
> > +#define IMX91_TMU_CTRL1_EN			BIT(31)
> > +#define IMX91_TMU_CTRL1_START			BIT(30)
> > +#define IMX91_TMU_CTRL1_STOP			BIT(29)
> > +#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
> > +#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
> > +
> > +#define IMX91_TMU_THR_CTRL01			0x30
> > +#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
> > +
> > +#define IMX91_TMU_REF_DIV			0x280
> > +#define IMX91_TMU_DIV_EN			BIT(31)
> > +#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
> > +#define IMX91_TMU_DIV_MAX			255
> > +
> > +#define IMX91_TMU_PUD_ST_CTRL			0x2b0
> > +#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
> > +
> > +#define IMX91_TMU_TRIM1				0x2e0
> > +#define IMX91_TMU_TRIM2				0x2f0
> > +
> > +#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
> > +#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
> > +
> > +#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
> > +#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
> > +
> > +#define IMX91_TMU_PERIOD_CTRL			0x270
> > +#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
> > +
> > +#define IMX91_TMP_FRAC				64
> > +
> > +struct imx91_tmu {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	struct thermal_zone_device *tzd;
> > +};
> > +
> > +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> > +{
> > +	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
> > +
> > +	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1 + REG_SET);
>
> Why do you need the 'relaxed' version of the readl / writel ?

Thank you for your review this patch. This already in linux-next tree

commit c411d8bf06992dade7abb88690dc2d467a868cc4
Author: Pengfei Li <pengfei.li_1@nxp.com>
Date:   Mon Oct 20 15:00:41 2025 -0400

    thermal/drivers/imx91: Add support for i.MX91 thermal monitoring unit

I ping this just to reminder guo shanw to pick dts part.

If anything need me to fix, let me know. Sorry for confuse you.

use _relaxed version here is because it slice better performance when
polling temp capture register, needn't dma().

Frank

>
> > +}
> > +
> > +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> > +{
> > +	u32 reg = IMX91_TMU_CTRL1;
> > +
> > +	reg += enable ? REG_SET : REG_CLR;
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
> > +}
>
> Can you explain the register layout ? It is unclear how it starts / stops /
> is enabled ...
>
> For instance doing reg += enable ? REG_SET : REG_CLR is confusing
>
>
> > +static int imx91_tmu_to_mcelsius(int x)
>
> 	(short x)
>
> > +{
> > +	return x * MILLIDEGREE_PER_DEGREE / IMX91_TMP_FRAC;
> > +}
> > +
> > +static int imx91_tmu_from_mcelsius(int x)
> > +{
> > +	return x * IMX91_TMP_FRAC / MILLIDEGREE_PER_DEGREE;
> > +}> +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	s16 data;
> > +
> > +	/* DATA0 is 16bit signed number */
> > +	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
>
> Does the routine works for a negative value ?
>
> > +	*temp = imx91_tmu_to_mcelsius(data);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	int val;
> > +
> > +	if (high >= IMX91_TMU_TEMP_HIGH_LIMIT)
> > +		return -EINVAL;
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> > +
> > +	/* Comparator1 for temperature threshold */
> > +	writel_relaxed(IMX91_TMU_THR_CTRL01_THR1_MASK, tmu->base + IMX91_TMU_THR_CTRL01 + REG_CLR);
> > +	val = FIELD_PREP(IMX91_TMU_THR_CTRL01_THR1_MASK, imx91_tmu_from_mcelsius(high));
> > +
> > +	writel_relaxed(val, tmu->base + IMX91_TMU_THR_CTRL01 + REG_SET);
> > +
> > +	writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> > +
>
> IMO, it is a good practice to wrap those calls into single line functions
> with a self-explanatory name
>
> > +	return 0;
> > +}
> > +
> > +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> > +{
> > +	struct device *dev = tmu->dev;
> > +	u32 trim1, trim2;
> > +	int ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (trim1 == 0 || trim2 == 0)
> > +		return -EINVAL;
> > +
> > +	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
> > +	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx91_tmu_action_remove(void *data)
> > +{
> > +	struct imx91_tmu *tmu = data;
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_enable(tmu, false);
> > +}
> > +
> > +static irqreturn_t imx91_tmu_alarm_irq(int irq, void *data)
> > +{
> > +	struct imx91_tmu *tmu = data;
> > +	u32 val;
> > +
> > +	val = readl_relaxed(tmu->base + IMX91_TMU_STAT0);
> > +
> > +	/* Check if comparison interrupt occurred */
> > +	if (val & IMX91_TMU_STAT0_THR1_IF) {
> > +		/* Clear irq flag and disable interrupt until reconfigured */
> > +		writel(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> > +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> > +
> > +		return IRQ_WAKE_THREAD;
> > +	}
> > +
> > +	return IRQ_NONE;
>
> Why is this routine needed ? Is it a shared interrupt ?
>
> > +}
> > +
> > +static irqreturn_t imx91_tmu_alarm_irq_thread(int irq, void *data)
> > +{
> > +	struct imx91_tmu *tmu = data;
> > +
> > +	thermal_zone_device_update(tmu->tzd, THERMAL_EVENT_UNSPECIFIED);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_device_mode mode)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	int ret;
> > +
> > +	if (mode == THERMAL_DEVICE_ENABLED) {
> > +		ret = pm_runtime_get(tmu->dev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE | IMX91_TMU_CTRL0_THR1_MASK,
> > +			       tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> > +
> > +		writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL0_THR1_MASK, IMX91_TMU_THR_MODE_GE),
> > +			       tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> > +		imx91_tmu_start(tmu, true);
> > +	} else {
> > +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> > +		imx91_tmu_start(tmu, false);
> > +		pm_runtime_put(tmu->dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct thermal_zone_device_ops tmu_tz_ops = {
> > +	.get_temp = imx91_tmu_get_temp,
> > +	.change_mode = imx91_tmu_change_mode,
> > +	.set_trips = imx91_tmu_set_trips,
> > +};
> > +
> > +static int imx91_tmu_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct imx91_tmu *tmu;
> > +	unsigned long rate;
> > +	int irq, ret;
> > +	u32 div;
> > +
> > +	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
> > +	if (!tmu)
> > +		return -ENOMEM;
> > +
> > +	tmu->dev = dev;
> > +
> > +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(tmu->base))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
> > +
> > +	tmu->clk = devm_clk_get_enabled(dev, NULL);
> > +	if (IS_ERR(tmu->clk))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
> > +
> > +	platform_set_drvdata(pdev, tmu);
> > +
> > +	/* disable the monitor during initialization */
> > +	imx91_tmu_enable(tmu, false);
> > +	imx91_tmu_start(tmu, false);
> > +
> > +	ret = imx91_init_from_nvmem_cells(tmu);
> > +	if (ret) {
> > +		dev_warn(dev, "can't get trim value, use default settings\n");
> > +
> > +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
> > +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
> > +	}
> > +
> > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > +	rate = clk_get_rate(tmu->clk);
> > +	div = (rate / (4 * HZ_PER_MHZ)) - 1;
> > +	if (div > IMX91_TMU_DIV_MAX)
> > +		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
> > +
> > +	/* Set divider value and enable divider */
> > +	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
> > +		       tmu->base + IMX91_TMU_REF_DIV);
> > +
> > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
> > +
> > +	/*
> > +	 * Set resolution mode
> > +	 * 00b - Conversion time = 0.59325 ms
> > +	 * 01b - Conversion time = 1.10525 ms
> > +	 * 10b - Conversion time = 2.12925 ms
> > +	 * 11b - Conversion time = 4.17725 ms
> > +	 */
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3),
> > +		       tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1),
> > +		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK,
> > +				  IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC),
> > +		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
> > +
> > +	/*
> > +	 * Set Periodic Measurement Frequency to 25Hz:
> > +	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]
> > +	 */
> > +	writel_relaxed(FIELD_PREP(IMX91_TMU_PERIOD_CTRL_MEAS_MASK, 4 * HZ_PER_MHZ / 25),
> > +		       tmu->base + IMX91_TMU_PERIOD_CTRL);
> > +
> > +	imx91_tmu_enable(tmu, true);
> > +	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
> > +
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_get_noresume(dev);
> > +	ret = devm_pm_runtime_enable(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
> > +	if (IS_ERR(tmu->tzd))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
> > +				     "failed to register thermal zone sensor\n");
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	ret = devm_request_threaded_irq(dev, irq, imx91_tmu_alarm_irq,
> > +					imx91_tmu_alarm_irq_thread,
> > +					IRQF_ONESHOT, "imx91_thermal", tmu);
> > +
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
> > +
> > +	pm_runtime_put(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_runtime_suspend(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_enable(tmu, false);
> > +
> > +	clk_disable_unprepare(tmu->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_runtime_resume(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(tmu->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	imx91_tmu_enable(tmu, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
> > +				 imx91_tmu_runtime_resume, NULL);
> > +
> > +static const struct of_device_id imx91_tmu_table[] = {
> > +	{ .compatible = "fsl,imx91-tmu", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
> > +
> > +static struct platform_driver imx91_tmu = {
> > +	.driver = {
> > +		.name	= "imx91_thermal",
> > +		.pm	= pm_ptr(&imx91_tmu_pm_ops),
> > +		.of_match_table = imx91_tmu_table,
> > +	},
> > +	.probe = imx91_tmu_probe,
> > +};
> > +module_platform_driver(imx91_tmu);
> > +
> > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> > +MODULE_LICENSE("GPL");
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

