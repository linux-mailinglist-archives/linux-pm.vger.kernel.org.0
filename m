Return-Path: <linux-pm+bounces-35130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D526B8EBD9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4657A4501
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E762ECEAC;
	Mon, 22 Sep 2025 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bVE6ilNx"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C031A285;
	Mon, 22 Sep 2025 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507275; cv=fail; b=SUol0BY3u+lNk6KM+Bz0UbPzQiJBKG3KpFfBMnIo6fy8fJ2LFIbS5NU2WSdIBUub/p4AdATIh+wjOXDF5j6qpgQFdqSHlvS2lWKftI6DQWcaU8VHYyO4FsgyJdabN0GG2vU+BMHSakE+JQOUWYrCH8tAqr+DzQqaCozvULR6bmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507275; c=relaxed/simple;
	bh=troiSUuQNja1hOiwaW2ffbaS3zvw1gN5mx3k27TRal4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ueRSd96eiQ++Li83mmM6GdypU/VdNkqJipssjYN2wO86NKeeTlxvv6/h4E971AQE9wXfUxpnilbtEq0IyXDVaCqmtprRGomYxFiznfwqLeH3npQS7Rvi9+I/Tb8j9yaxUXlpRP84QJICYngiibaNwvy+yCnMgvx8rhMmfKbKQJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bVE6ilNx; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsGGPVQCncbUkwbeOcXKeNk079rKRHVi3/KFAVRbz3HI2/4PFUOEV9s8zJmwwBoIWp6UnkciZXHI82pC2NicVZrju4HdzGyDja+Q+B9A+iYIu4z+fI/u1Q7aNUbr49vEUsjwNdxqaMsL7spzuNTD76UhGmN52U78A/fEuZHMZHuHVxEw8cRRwHVaFVPNjdZ6qan904jCeQFaczPw1xKXC5gqBTPWYvLSpywi1VoTFUt9BDuJKeFsLTRmMc2j9cu/ya50IGryVn5/WEwZYlyRmYMco1WsW2JB6L2d2+jM5lY2hO8Pdp+6CRUULc86G/maKrctxdDE8b6++oOKkmMtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5kcM3cOoAV3eVwuvauVL1WX5EMq7U5I5iPiedPYVpc=;
 b=SJZk0hfoBym1ovv2C76LNk5zmEx7pYbfHbmaybfF80capAO7OYZIGuQocTcIwNC1UMlyhG4hfidIbt3ExzKdsuJL4iQGjfsizFosUrIfKvB0Q3sej4olB2XKKuQtqelMWRWSqMvbbXQeUxcnl/n5+S0U0YAuaUUZGpN/90PkD5Ik0TblzwbcQLZH3EFbvqKO00qZEGEOg1EA/9+DDCYzp6r94EzHx924epo2kQ8FyYmS35N+yVe0cJVK52+y+clI4E1aF/K6ySeUBbwnkvHfnve+9+2yLNNHUI847pEIpswQuFzfunEBR6nMq+Dwuoi6mWmNHkBhwj5nOtU/TQKJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5kcM3cOoAV3eVwuvauVL1WX5EMq7U5I5iPiedPYVpc=;
 b=bVE6ilNxZPUKnayo2oGNakU51N5wiagcBe2jvzZilfIYljgl03bs32on+E4Cy+MjxiX7EF9P/Ia1QIvczX+Ckh4alBcdTKJowWm4c+rM9N4wSZKLY61P6C/PD9fKo3y9b0s5gSg33v631olA7iG1kXTDjRApM5okRaGidggiI/EKv5p2FWhdN9NssMd1leiyaS96Osx2vnmfQ2vehDPA0ZFOvLfhaJKAkoVxMTXeoJAfiMlAX3v4/KZzWykO4HKMbSHiIq/ZkOwiIbRsSpD3cBkf626UMckV9Jeljgy13reS+782tXjEtFwA2eexAwBVBcXDqFF0PEoEnfA4izfkDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:14:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:14:30 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] pmdomain: core: Introduce device_set_out_band_wakeup
 and use it in usb
Date: Mon, 22 Sep 2025 10:14:08 +0800
Message-Id: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCw0GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0NL3YJc3TITXUMLc0tTM4uUVFMDAyWg2oKi1LTMCrA50bG1tQCcAe3
 7VwAAAA==
X-Change-ID: 20250919-pm-v4-1879568de500
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507262; l=3738;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=troiSUuQNja1hOiwaW2ffbaS3zvw1gN5mx3k27TRal4=;
 b=YzFF8B8J5Ks/Y2Z+R69meXu1GPdNb2hafPdHYjVFQWa0yoOBPPDji444Q9/dPQSe1ADquJnZo
 Td/1VqJEfqJDqPd6BwRE/aGjuDU2Ij/nbJ2afuPdWgFQF+1rEt8ObNM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d2473f-3db5-4714-b38a-08ddf97dc344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|921020|7053199007|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWlrSmJpWXhFRGR2OC96dFFYWG12VWlmd2d2b0dEeDFXWlJnVDE0TE1kSmNm?=
 =?utf-8?B?c1FtWFJxdmFzaDk3bW9EeldkVm01NmE3REt1Q1pJTmZRYW80N3RIWENUWUM2?=
 =?utf-8?B?a1RHRWNMZzVPVTYzUFhpTU8yZC8rQXFJejhpamw0VU5EQXR0dTk0NjdkRXhG?=
 =?utf-8?B?b01sTGZNYnNqTTBMVVhtNEpCbEw1cG56SjhGZS95UzBvaTdaNTVER3ZJZmdt?=
 =?utf-8?B?d0R0cUxoY1BMVkhzUUVqeVVxWFlrNU53QlZZcXZZQStVdjlqRDR0RlNBa0pG?=
 =?utf-8?B?TEtKQzZzNzhGRUx2SmwyYnhYdmpLOFVOSkZiQ3hraWQ5d0VnbFVmWFNESExh?=
 =?utf-8?B?UlZESGZPMGEycnFZcDZ1c1p5Y0hYQ2VsdWZKMGpDR0pGalI4UjRzYTBDZHMy?=
 =?utf-8?B?K1FhT1VYVnRyUXhwK3FpbnRMNnhXUGxESmZjNUl2NzdXYzNoa2dDRnhJZU9Y?=
 =?utf-8?B?QWRsYkhlcStoOEVyUzdFVU5KTWN3dkR1Z3lnNExDZGhLamU2UTJzOGFQU1lI?=
 =?utf-8?B?SEFtUUk4ajh5WUNuQ1I0TEhmVklxVExqZi9KV01LZjQ3NVJERmtVMWNwb1hN?=
 =?utf-8?B?RkkvcWhnOE10WFVwNFFXN2V4UVd6NjBQVXplci9Qdmt5cVpSZzYrbVQ0RTZx?=
 =?utf-8?B?djIwcEVQOGE4WWdQRmhoNVhZSll2M1dtSGtGTWcwcG0xNWpFQk5tZDFXN283?=
 =?utf-8?B?Yk1sVjQ3ZUhadW92UkdVN2NBRU9XQ1BFd3hXcnNNTzlmREl6RUJ2WkkyM0pF?=
 =?utf-8?B?STFxVnVIL1dzUStaUERnWHlnY2hZRVNPK29DWVF0QjgrREFRY0dBSC9BbjlV?=
 =?utf-8?B?N2pVNjRoTkJVVkJBeDNEcVozMmIrWm1rUmxPck15SVRCbGZkMXZhT1BZTklu?=
 =?utf-8?B?cjhYQk5LNzBLQm5xMTdscVJoVythZzNYVWlpeUZxZ3NBTmlTK291UjRpN2Vz?=
 =?utf-8?B?OWlZZSsvWDlrRGtWK0hzWjdhN1lNMDY2UDRLaHZQTWRDblloa2V0VTgvNTY2?=
 =?utf-8?B?ZllNU2FYRVFEMjRtRE54alpqeW5PY2RDeE95SmlqeEw3dGNHM3BRVmcwUFVV?=
 =?utf-8?B?WFA5MUppZEVyT2Z6TW9rMnp2c2pGcFF2Q0phQ2N3dGVTR2JoMXRHdzRUb2Qx?=
 =?utf-8?B?K0l0OGdCekhMMDFENWxndFlxK0FqM0xBWTZ5ZGx5Ujc1K09QbnhCVElydWh2?=
 =?utf-8?B?RE5kSmo4WnNWNm1TRWF4UTZEWHlESWR0bVloR0gzQWpUV2dnYzBQTDMxRkMr?=
 =?utf-8?B?Nmk1Qnh0Mm1YMjBQMWgwZGF0QTlXamRwZWRYM3Z6SGwxK1hCN1VqZElNQXpw?=
 =?utf-8?B?WVpZWGZTQmRzYlUzeEwvVGQvTi9MSnkyZGNBc1lXc0hTczYwenJ1S1FNWVV5?=
 =?utf-8?B?Sm5JUUJ0czV5ZVFYOGVDSzJ3aVpMc1FFWGJBdnVlQlhmUzNsUmdvQTNEaith?=
 =?utf-8?B?dVpobDlnVk5HTlJaQk4vQTdWWHlJcDVoclIzb0JoSENnSjNGelN6blhDREpS?=
 =?utf-8?B?Y3lvaWFaTVozbmRQWG1xaW1JeEZiN1lTVnFUcFRnNmUrSXdPMDNERXpqWlRa?=
 =?utf-8?B?dUVKZXM2YmNNS0ZpclBNRGZQYXVxZCtOVGh3aytYTmJrOVVSa2RQaENJN0Jw?=
 =?utf-8?B?TkxLVkN3RFhXYkxrZ2JRck8yMk0wRld4TEtSWHUzWXcrQ1dUMjRJQ3FnRDRx?=
 =?utf-8?B?RHpwUWhEN3Y0b0haaHd1U283SjhuTXlPVkZJaWJnZGV6cnhZZ3J0WVRvSkpa?=
 =?utf-8?B?eVd1dmpYQWRYYVkxU044MkFFMlM1TFdGWnRKYnUwK2lNaXNhNFZLMVRhaFky?=
 =?utf-8?B?SUNBME4zMGJQdGZyVHdpZUppTSt1b2wvdWM2bVB4TnhlcWgvNFo1ZnlWOEVo?=
 =?utf-8?B?S1VWT2VQZzhZeTBYRVpkbXpyd3ozWmVuRXc4K2oxSkJmbUtGanVYcmhIZ3p5?=
 =?utf-8?Q?0Y3jgaV0BrxTyAhg/X383MYKmmFnUT1k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(921020)(7053199007)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG95VENCc2tkYlV2c1J2WEk5azRXVURNSWtXZ21FejZzVHB5TFFpWlNIVEdL?=
 =?utf-8?B?NzY5aTN4aTJ3T2NDZUZZUDNxM3NTT085V1RySU9KVHdUUmVPZ0Q5d3BjNlZj?=
 =?utf-8?B?NTFFTDkwMmhsQjRsNE95aCtJVm9xSmt4b05JU3p2S0RRbGc1RUxOVkloaGxt?=
 =?utf-8?B?WmZPS3pvRm1kQ0NIY0xGb2hMNjhvQXhvUDFpUHpYYVZRczcvdnRjVnR4ZUZC?=
 =?utf-8?B?ME5OaE1DQys1UkpOTFVZMkZZbitwVlNxOHUyUE5JMG9DT2hmUTlERE41REpP?=
 =?utf-8?B?V1htbUdIT2lHL050eVQvdWIwekhEelE4QW90YUt0dW0wdVR6a21iNkFyZlh4?=
 =?utf-8?B?UEZXbUcydS9yZ0ZiZURMR0ZqRkQ0aHJDM3pOZjNLcWphbUxvS3haMHRUWkZq?=
 =?utf-8?B?Q3l6WVJKeEt4eTNzcHFnSWFzc2hHZmQzbkdxVFRISTc2NHFlN0RMMmZiSjA5?=
 =?utf-8?B?bzBaSExhWk1GOUZnanpxUlhWZmVKTmRKTmR6QWkzRXJGT0ovYUg1ZWlIUmRo?=
 =?utf-8?B?a09DeUZ4RmhMYSs0bE5UTXhlR1NTT2FyTm1HQ2p6bjNydDNxaGNWOXA1bUV6?=
 =?utf-8?B?bFdqU2NoVEtLejBDT29GelRGM2ttTk9ReU82bXptaitQdTk4QmVpTnIwSEQw?=
 =?utf-8?B?aldNUlFpaTRUVVNHeVBGZ05vL2paT1FqWVcwTE9rSGZEQndnYzRZWWMwQmhh?=
 =?utf-8?B?SC8rcVhWZW5WdkFLekh0eDVRNzVOZnpVK0RhR2N3ZGRJR055aStqN1k0cXRi?=
 =?utf-8?B?YWxpZUc4Z1pab25kWElOalcxLzNvemdKVnBOZExuMlRPSW10WWhPcHZ3M0lz?=
 =?utf-8?B?VCs4WVF5ZVg2U1JVTHBsd2l3VklNajlvckZvMDB3N2xLcGlOY21XY2JxYk0r?=
 =?utf-8?B?cFF2R0lpbFdJVFJFUSs0NER0N2o0ejlsUlZXcjljaklBYmIzYzM1TnU2MXVR?=
 =?utf-8?B?K0Rxd1BqcXV2MU55UWtxck1udVpkMHEycXFYZlY0RFRGZlRSek01clUvK09y?=
 =?utf-8?B?MTVyVVRMYm8vTEsrRm9JUkxOOXFDaEhsalhhNW9pZHpQclhHaHBQTFJmMnZ0?=
 =?utf-8?B?eEZFRnNFNGI4Q0I0bHBxS2dvMC9rbnhJNkhYeGRhWGxsc25GWTE5UGp4LzBX?=
 =?utf-8?B?MWxiS0NoZUVQNGdZZ0p6NmF4aFo1dXNHYWRUREd4ckJTWUxJYmZIczEwSkRL?=
 =?utf-8?B?bkNyY1NNeEFLVExxYTRZamp0alBoUVJFVW1KeE0vcnRWR1kwOWNZb3NHY2hR?=
 =?utf-8?B?MlAwcU1kRm1kMGpTS1R3Y21xZEpENW9Jd2k3UFZsN1MxUEI2MFI0Y2J1STlP?=
 =?utf-8?B?Vm1pMUVJR1hQSndqUU1JeGJVeUhQMXh4SndnVnNYOHFVOG90R1hjbWluajhp?=
 =?utf-8?B?U1ZTTG5QWEthc21hMXFNU1RpM2Z0d1hrNThVSk5MaGx4TjNnSS9YS2tkMWN0?=
 =?utf-8?B?bkxiQVBZYk9ZZGEwbnQveUFSSDE2dkdWbVJBd0dKM3pwYWpsdFlXRmZYYm4y?=
 =?utf-8?B?WXdvN2JaR2lDOVZGclJZZ2RNRFZxeXBoZHlRTTMxYTFBbmtKV0VEd2ttS0M2?=
 =?utf-8?B?KzlUQTNhMWtWUFZsRkR3VCtsNnpsbDB5clNJdkJoK2V1OWVBSkdKK2dSa2Yr?=
 =?utf-8?B?bnBZSHlKU0xxbnBVakxpekRnUnIyc0RCSXg3Y0E5ekZJbW1nd1RzcXVNekJp?=
 =?utf-8?B?WXZlNUpodFNYTjZVVVlZM2VhZ1Vwc1lpUXo4RUFld0dXVVord29teXc3MnBH?=
 =?utf-8?B?cGdrc3RIZGhqUVIxaXIxMEpDZU42WWF0bFlZMG4rYmZQR2VqaGV4U2tKdjVm?=
 =?utf-8?B?dTAxQUw3SFA4aitJQVd2WEtIOWlEUjJ2eXA3VDM5Z1VCN1ZJdjRwNTZGaEdG?=
 =?utf-8?B?cnN2Wkk5UUtla3BMLzVwWWhqK2UwSGdFaDdKT0FJZGhaS2lwbWRKWWYzelAv?=
 =?utf-8?B?TzRRbjc4UHpNSTNuV0t6S2V5ZHlEWmpMREV6bktKWGo0WGJQU29yK1hyNE9M?=
 =?utf-8?B?WUJNKytsOEFJYWlGSGVkZTh2Lzc0WVN1Uk90QXVLREt2bVNmSThxZlBpVVg5?=
 =?utf-8?B?V1hxNnpidUUxSTdvTUNyUGlnM2xWejhKUEZTME4wUllaVUpHb2d0TWpTLzFL?=
 =?utf-8?Q?Q4NxdX6blYpv0xchKXpA4TTF3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d2473f-3db5-4714-b38a-08ddf97dc344
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:14:30.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bQ0hF794LSeG5k/xHSY4DnvbeFkpSRsg9gOGluuixm5mbs6+xB+i7rRnYyjlqYYq5xniX8oxdFY+bsSLEJetQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

To i.MX95, USB2 and USB3 are in HSIOMIX domain, but there is always on logic
to make USB2 and USB3 has wakeup capability when HSIOMIX power domain
is in off state. So when in system-suspend state, USB2/USB3 could wakeup
the system even the USB2/USB3 HSIOMIX power domain is turned off. This
means USB2/USB3 has out-of-band wakeup capability to wakeup system from
suspended state.

Without this patchset, if USB2/USB3 are configured with wakeup enabled,
the HSIOMIX power domain will not be turned off. This leads to more
power consumed in system suspend state.

This patchset introduces device_set_out_band_wakeup and
device_out_band_wakeup two APIs to set out-of-band and query the flag.
In genpd_finish_suspend, there is a check, if out-of-band is set,
it will continue to turn off the power domain. In genpd resume flow,
there is a similar check to turn on the power domain.

Patch 1,2 introduces device_set_out_band_wakeup and
device_out_band_wakeup
Patch 3 and 4 are drivers changes to use device_out_band_wakeup

More old discussions:
https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

This is pick up of [1]
This V2 patchset
- includes usb driver changes to give people a full picture on how it is used.
- Rebased next-20250729 to resolve conflicts

[1]https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

To: Rafael J. Wysocki <rafael@kernel.org>
To: Pavel Machek <pavel@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Peter Chen <peter.chen@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>

Changes in v4:
- Split device_set_out_band_wakeup API and pmdomain changes into patch 1
  and 2 and clear the flag in device_prepare (from Ulf)
- Add R-b in patch 2
- Move the call of device_set_out_band_wakeup to system suspend
  callback in patch 3 and 4. (from Ulf)
- For patch 3,4, I still keep the Tags, since compared with V3, it is quite
  small changes.
- Link to v3: https://lore.kernel.org/r/20250902-pm-v3-0-ffadbb454cdc@nxp.com

Changes in v3:
- Add a new patch from Xu Yang to detach power domain for ci hdrc
- Add A-b for patch 4
- Link to v2: https://lore.kernel.org/r/20250801-pm-v2-0-97c8fb2a433c@nxp.com

---
Peng Fan (4):
      PM: wakeup: Add out-of-band system wakeup support for devices
      PM: domains: Allow power-off for out-of-band wakeup-capable devices
      usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
      usb: dwc3: imx8mp: Set out of band wakeup for i.MX95

Xu Yang (1):
      usb: chipidea: core: detach power domain for ci_hdrc platform device

 drivers/base/power/main.c          |  1 +
 drivers/pmdomain/core.c            |  6 ++++--
 drivers/usb/chipidea/ci_hdrc_imx.c | 11 ++++++++++-
 drivers/usb/chipidea/core.c        |  3 +++
 drivers/usb/dwc3/dwc3-imx8mp.c     |  9 +++++++--
 include/linux/pm.h                 |  1 +
 include/linux/pm_wakeup.h          | 17 +++++++++++++++++
 include/linux/usb/chipidea.h       |  1 +
 8 files changed, 44 insertions(+), 5 deletions(-)
---
base-commit: 8f7f8b1b3f4c613dd886f53f768f82816b41eaa3
change-id: 20250919-pm-v4-1879568de500

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


