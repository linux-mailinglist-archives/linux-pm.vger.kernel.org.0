Return-Path: <linux-pm+bounces-33599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0657FB3F2C2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB05417D9C9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1862E284B;
	Tue,  2 Sep 2025 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="chsz6k+x"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B22E0B60;
	Tue,  2 Sep 2025 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784026; cv=fail; b=Ep3EjllDWJcoU9JQBYOyO3exa9RS0qgN/fEShfUcuKLIaC5MYKFXYjJWIXknjWhX+1Vlkl2khxcKNco5guQD9ARYjj3yywPs5JnY2x/UQI9ImmN82XK/UGPFs9fI8ptK72s1HYXThYONSzeQrpZw3yv4g35ygFHKPyl8JmF8Q7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784026; c=relaxed/simple;
	bh=z669bSOPvj3ICy7xTdxnoREISZopcetfT97jw5UXzko=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RvKwjfpjZb856rUFxNFVcsH06Q3SjBlkhOPRtDRn4kpnSZXmQQIeFNfBr11XGwkmyjMGWT5Exh609TFFaWmwblmDlxrlC9c/0RUav4/maZibPJYqjTOCihfDmHP5KwaP2IdWuN9rVuQgt4O6KxyDJ9Y2b11Ghgl4j2HyAeaqWv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=chsz6k+x; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGPIYIQ6a6qqLiA7+zTzWVy/CI5OKycg9S/5JeRvMM5jFp/Dk+sh6vUymn8NdN2lXfhBI+SHVb6q5N89zS4mTzpnQh02G20xixC+QfCRMIHdPhGIx4JZQGblFCY3qCSORQNVYcuIJPdHqMzRzgaivga1h/2eK/fEV9/tJDP/JDyQFeSkuq6expC0ovu11BUG7K321EDA3EzfVzXbQ8Zfh9H4BA7eLkT2OflBeW/DEtdXPxJdq2InyAqJnw2dwfXCBq6YaHr1EnSXQgimnyPpHScxc6hd4eCOm3ZJMq8Sr8C/QRBP0Kzv80LogR/t2gJLdHga1+AoX23GMC78Uz3nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA7Y8ZN7KCVDtYqE8W54rGY+NSm/g7zu8bSECei5b6U=;
 b=O6GUUvSF7ilsx8A+tx1D5D7Yxhdbc7aF01Wqk8HbBiaykXfNexM2fV1Mspoo6HuBcXIj9FnVVszYC79bBVgg6CpZ8n/N3A8PsOL1wZeNLjHEf0n9a0cwbT7nqIxlJwbGqoexSB35yUyVHX5444UbvOTfq78ChOjcAaLEcraVq10vKrKXv6f2bPUz+d9pa6T/cvnjyfZdMDW9bgBjfykjySm7f5C5D26rKKHRlHXl/0c0Oec1Kz20QLAF5x8Zjx+UrVZ/Xteb7u0ifi1IIsFv9sqe1mlLG68FcI0G1t9Zy4Dy3Wz6y862EaZJ22Le8WOl2DfbSncLkMGl6HsY64cI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA7Y8ZN7KCVDtYqE8W54rGY+NSm/g7zu8bSECei5b6U=;
 b=chsz6k+xwgdJmWQwj0NGmhb1O0r3pUcjKRZBWxLWdyvicjEWC+C3DCwzDRLUYrUCoG826t9n99R2BB96XvA2KmipAZpsaehxoFzdfnE9XroMH/7i3s5gpU5x0GSCxhHOXj4SyA8irkSaLHcacG4fgf9HSyaLUtg409pm4BvcO2g/OMNV9P+mozA8Khf+1Sue7G5HgjqZwLd7muM1ICr/kZYKeE0x08KYyAKNc+PZLr5nnLvsZHXces7c6CvGDAD3mmkgxyen6jQSjiaqJst8Xv5FpQX3+LR43rsB+y7tnZjmP62tcGYBmJSBmWJU61Mff3go0fkCUefdVh46Lj1Ehw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:33:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 03:33:41 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 02 Sep 2025 11:33:03 +0800
Subject: [PATCH v3 4/4] usb: dwc3: imx8mp: Set out of band wakeup for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pm-v3-4-ffadbb454cdc@nxp.com>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756783991; l=1053;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=z669bSOPvj3ICy7xTdxnoREISZopcetfT97jw5UXzko=;
 b=ZQEjIntlNAiD+6h1mq1yOQR3crp5RIC5CmQk5axsvb1U8Hhv6uKTF58UP7c4LvYcz/tJpaDZx
 9P0UfKbhdGWABnfVlsy42wPvr5NAimaIWNg3Eg4itkfP8t052INsfkb
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: e21b16f7-d404-4ff6-7936-08dde9d182d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHNYVUN3eDk0eHlVQmxselFaalZZbFNpV0dkQ1dTQVRQQnVYZmxLZUVXNkha?=
 =?utf-8?B?UHp1dG5xM0s1RThVbGQyL04yOXg4N2Z0UHE2alV1RjNJVEI2ZWxjeDhYQlln?=
 =?utf-8?B?UkRsT0laZ2VuN0ZheFAxbHB0RENoek9vRktiSGhhUkdCSUt2OTJJVWE3SnhI?=
 =?utf-8?B?TGdkRHdYdmpadkZqbFZOaGZNTjNMSGNHZkhYVGM4N2JTdExUWVZuUVk1RTlU?=
 =?utf-8?B?Wko2dEtES0pJRDhvbCtkb1QvMnk0ZjFZMTdtL01FeVloRWU0czhFRytmQ2V3?=
 =?utf-8?B?K3BiS3JGMmZXV0JNK1Y0ZlltOXlSN3lya1JmRGhvZjgvemV0QTRpcGhGNFBa?=
 =?utf-8?B?a0c0OXdyMzdndXArN0hVMEVQZlhCU2pLeVJkV1J3ZmV6Vk12RnRSRlp6SUJK?=
 =?utf-8?B?eGowQ0p2WUxrTU1kaTI3Wm5tbDAwelpmdTgrK012K3doSHJUeDdSMDlVc015?=
 =?utf-8?B?aDluVVRpZkpGUzk5bmhRNFpWZllnSDhUaVh1MEdzdXE1dzFPZDJOZnR6Y2ZO?=
 =?utf-8?B?NDNVN0o2azh3dVBGWEg2eGRrTVQ4SnJCL2RScjNyMUxReEZab2RoQk9pMHJO?=
 =?utf-8?B?M1hYZ2t4VWNrMTltcGlYRGFuTUU0Y0xYQkpaRFI4UWd5NTlZLy9NNFN5eHBu?=
 =?utf-8?B?KzVCNVQzQ3l1NC9ZZlR4VEFxZ290UFN2TVJhUnI3NFo4K2d5bFZKTXFTaE1S?=
 =?utf-8?B?SUdOOTR4aVl0R0pnWVU1aWF5aytQOENrdnZaTGFaejB0NklETHUwVll1QTV2?=
 =?utf-8?B?QUNjWTltMExEdENFTzJmZGdQZ1pIdDJUT0w5dVZVTFRjRkcwZWliVTI1NGxM?=
 =?utf-8?B?Uy9MNXhIbk1LTGV0ejVUL0Z6bnc5NWQzVnFHNmRtZWxOZ3JvdVpiUW01RDJu?=
 =?utf-8?B?L0xTZUQzaEdhR2pUSzlIdVhOUGV6WlVTWkd4bUxrMVU5dzNJVnA3TjR2R2pX?=
 =?utf-8?B?SkIweDZoZG5NRW5Ed21RMTFLREtHZjEwUGJkWGJ2dVhiTFRCajBzSjBhNmhM?=
 =?utf-8?B?M3VHUjN3dFVkdTQrRi9sVWlhODR6V1hjalhJS1MwbGxtMm1KTldRNDFjNFcv?=
 =?utf-8?B?blJDdm5VRDZxY1FwZVdnd0MrbDJONHFqQkdCS05YZFl0NmJRR2VjSG1YUmZ2?=
 =?utf-8?B?b0NSbTFwaGh1dEc3aFd4K0RtMHhDUkh5bFg4SmlmQVR0bmU0ZjVveXU5bDFE?=
 =?utf-8?B?QUxKODNtaUdoUDVRZStDZ0tkRlowSFJld0lVZmZ0STAvNHVrcUsyYzdzU2hD?=
 =?utf-8?B?TmhRTTY4VGlMbUx1bWpPb2cvUjdzOHBzUVQxR2ZkM015UXVwTjBWc2lBR3Fi?=
 =?utf-8?B?ak03WUhmVFZDZjRjcGZtV3B4VTkyVm5TdXArc3k1TFVnZ0hEUi9NSkFWU2x1?=
 =?utf-8?B?dGQyMkJkV3pRTlhkZGFvcUFXZG9aQjBwUE9kWVJBWFdGSVM3a0dpaDRFeHk1?=
 =?utf-8?B?Y3MvNldiSGlQdDI5NkhlM0tqU2hjaXVoVCtZMDNrNTZQZVpkRzgyS3huVTJw?=
 =?utf-8?B?TzJIMmUxajYzeUVYL2oweWh1R0diQmpVMzMvV3RPcEtQT0gyTnNnaC9BQnl6?=
 =?utf-8?B?T1hCam5HRGU2b1NlRUIvTEl5cERqakJQNGNkWE5ubmtnNnRqVXQ2VndPTDhF?=
 =?utf-8?B?d2F5Y1ZkWmtQMUthcU4vek82ei80R3FkN0FyMVFMUmlqTlNwcFlEZ2Q2K0k4?=
 =?utf-8?B?WW1CdDBiNTNjRUhTSURZNzVFWWZiSDJhOE9KU2N0b3lqN1dLTnU4Q3RvVXVL?=
 =?utf-8?B?Zi9mZ2pmNmZoYW5ackRUNFZRUUs3RHNWUmVrcUlBWEo3SUoveTMwTHlVS2lW?=
 =?utf-8?B?ZnhjL2cxdkdxbWg2eE55dVkydTdhTVNtd0c4QzZEa1doUWs2QVArUTNjRGdM?=
 =?utf-8?B?OTNxcldBN1NvMHNyaW1lUkdmSWhmd3gzYWltV1pSQ1JHMzE0NGsyeVozS28w?=
 =?utf-8?B?VFJsQ0RuWlczdzZUWFRBT3NTd2krT0ljTGlxZVl6TXZsOVNyV2Q5MlhwLzg1?=
 =?utf-8?Q?C3hlK1EPg/vvCljcWLUosM5xAXvZi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODN6V1p6MW9IU1NxYzZQWFhORXhEZW1hekZGc0ExSXF4Qy8yVitiNWFFZ29a?=
 =?utf-8?B?YXgwYjBISGcwTGphUlYrM2VnWDEyaFVtZFVhelNKYzhwSUV2bHhVYjRnT2Fn?=
 =?utf-8?B?RGlMS3N6YnI5WmZzSkZuVEJLS1ZiRTdkMzhTUXdQc2hHR2U4SDV6eC9wMXZz?=
 =?utf-8?B?VGsvQStsTjNUV3Jkby9VYVlFTTdxQk1SV2d1ZnNYcUlrSlcxSVNkL2tPSHh3?=
 =?utf-8?B?bjRLNUcySzhLTEdmRkdvblU3bUVVUWh4Wm00dmMraUJYOEQwek1SdHpianRB?=
 =?utf-8?B?U2hXWDRLVTFsTlduZDdpbW15VmVwNXFuaUlhSzloakhyTW5oM3NPNEdYRTZW?=
 =?utf-8?B?TGVMdkRjWFFzaFB4dWdLbUhtRFdVM3gxRlFDei92Z2JINUdzTktYL0pQN2hP?=
 =?utf-8?B?am5DbzRxR1c2Ykk1K2FDa3UyWWYyZUFkZEltTWpMcWNoMlBabzJKMVhpMW9l?=
 =?utf-8?B?empMRlJTM1IrZGhHSGlncnBONnREYkxIeUI4YURqeHlET0R4TCt1bGR0dzBx?=
 =?utf-8?B?OGg2eWFKYzdRMnZrUUtuTFV2WkEyek1yaldicFpMM3Y4RlZLNVFTZ3psdG1y?=
 =?utf-8?B?YWk4eE0zTDIxRmRpSlhjRnc4NUZTWHdTb2ZjSGtVaU9IMWNXOGRzUVBQQVRo?=
 =?utf-8?B?NlRkZlRIRVdVMTFGalI0bnhSUXlQdzBiSEt6TnRPUnVIdi83TUxGb0N6UzBv?=
 =?utf-8?B?ZjE3N2xNQWczUFFjUFJBdnlFaHhERFNsRG9XbzZIZklLb2ZkaU5DOFRBM0x4?=
 =?utf-8?B?T3IvM3plWm1GaXRuS21UMTg3SjFCTUhmZW9Ha1NDTlp4V3pySlRpMXVuWnVx?=
 =?utf-8?B?cTV2TDgxZkdLb2FXZVBBVmorMzNQRTNOQlA5VG1RN21icXlzNXdSS0R1aFRh?=
 =?utf-8?B?K2l2MEY0dUppZGkvU1VmWVVzVFZtV0VQRmttc2s2L0xRWVFTMnJMQ1BRMWU4?=
 =?utf-8?B?WE9oMVJJaEYzTHRETnR2SVVaaTExTzV2TGxCVlVNVUY4OTVzREQzcHFQVmxO?=
 =?utf-8?B?ci9oVk9sQmtGQWI1SGVpMmRaNUg2akJFZ2d6ejBueE1CK2VqRXU5aUtxOXFy?=
 =?utf-8?B?RWpqb3FJVWxFOHUwcThUblZ6cE9sc0krbllBaHVEMi8vbnRQUFZNZ3NaSDF4?=
 =?utf-8?B?VE45dHdyNlgrTFRvTSs4VlVka0ZoUkdpOGJndGVtZW9tUXJnSkdwT2Y5OVgw?=
 =?utf-8?B?MzY2c2Z2VG9uKzZLTm9TVWExZFNQaVpabnZQRTVReTlZbVV3U1B4bDlmc1Z3?=
 =?utf-8?B?Y0M1VFFUbGE1TjdvUlZJU3dQT1ZmS0ljLzNjNEJNL2xBSXBTaUlXUlVxK05v?=
 =?utf-8?B?TUZ5bmVNL3NuSmNrOS95Nm93WFh3VExpeEVzejhrNnNib0RRWXlNYUxlLzls?=
 =?utf-8?B?UDY1NWZvaFVSUG5qMzhkV084akZ1ZHFhaXlDdnFKeTVKMU00eWVkdmJtbWsz?=
 =?utf-8?B?dm1PV1dyc1pPUzNiOGc0K01SbnlENEZmcFNBbGw5bTVmNGEydzRiVE8wenRW?=
 =?utf-8?B?MnVUaEJLQmxQZFMrSTNmck5VUnpkVHh2MThuM3QrUzdIVk11elZPcjNIVHdl?=
 =?utf-8?B?bWhjVUhsbm5RZ0pkLzNRSGZHK0RDY04wSlZOK3JtNnZiM1M1SEpLWlFtbFl6?=
 =?utf-8?B?dUJOVDQzOVhBYWZKVEVpaElubHZ5Q0tHQ0xlalpOVXBtaDZNK255M050NXZX?=
 =?utf-8?B?Y3FrVkVhcXpIUnRNRTVvMml1bi9LdGgyOVlKcTlYcnpOcDY5UzA3cHppZDdE?=
 =?utf-8?B?eTVyUlRRdHJua2ZyaUovbjVwa2xQT2ZMQTJPR1QxbXp5MDdCV0kwcEUzejIz?=
 =?utf-8?B?YmJlM2RTV2crS2JtNGxVTGNYL3d5MTBnQmZYTU5sQ3psU0xybmNLc3hSUi9i?=
 =?utf-8?B?ZjZEdVJKMUVhdjh4bkJlTjVjdDVxRFVGZWV3c1Zja0taMkp1MGxYZTdIZEt0?=
 =?utf-8?B?SXppWmZvWUxuT1I1amlRS2xnZndHVHZSOUdXM0ZvSGRqYnU2VkpPcEtvUHN5?=
 =?utf-8?B?S3FxajdrUUU4QzRTVXhPK2dTY0VnbGc1Szg1NmtqNFovdHhLVUFUS1VyZDFj?=
 =?utf-8?B?S3F2V3Uvb2ZsNHd1OHJxYXdPVlloRy9mdENGdkZIVTJ0NnFTRENwUnBKOTMr?=
 =?utf-8?Q?S/5Sm0muYnL/EbSbUIutdZE7D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21b16f7-d404-4ff6-7936-08dde9d182d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:33:41.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8eNaVuZaR6iat3rCcK0u1Vh2CzOOKEQKnHB2u5fmWxcxKIRy+3ASpFscM+3mTPkEl0YjDhULT38lJfSo9HsUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583

i.MX95 DWC3 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure DWC3 could
wakeup system even if HSIOMIX power domain is in off state.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index bce6af82f54c24423c1e1fcc46913c8456b6f035..fde158d1f6e3d89d261ed3689a17d703878c7e37 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -248,6 +248,10 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	}
 
 	device_set_wakeup_capable(dev, true);
+
+	if (device_is_compatible(dev, "fsl,imx95-dwc3"))
+		device_set_out_band_wakeup(dev, true);
+
 	pm_runtime_put(dev);
 
 	return 0;

-- 
2.37.1


