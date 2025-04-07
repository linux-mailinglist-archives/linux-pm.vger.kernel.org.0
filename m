Return-Path: <linux-pm+bounces-24900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B43FA7EE8A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 22:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4071896535
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E222331E;
	Mon,  7 Apr 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DieP5xRl"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8F21CA08;
	Mon,  7 Apr 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056369; cv=fail; b=jaMzey2ex5Xkkzs8MqmVO4YM/N7kOz6v7bKS0+pNG+JOezdmbcaNdIpANhNWU5SydoKoK1XSTphtSAfHwFhdSy0bfygo+dgaOU5FjtbxF4PbltYRpZKTOn8neDwJn8mBbrDTxB2ePLU0A8OCPmFG6LVbjJOPcDeUFTb/uvSJgho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056369; c=relaxed/simple;
	bh=BEucYzbZxWUGU9S4l0VB5a9jcxliPYBfbRtXLrc1nUs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qw/x1oAOlIfYvSm4dCgRdnkuALA4vQCplOzATrpCLBItm20H/lxmavL+zwkOBWdaT9CbWs+qBNE6+PtaOCugiPb6lWA/B7joHWY1Jx6CG6/Jd7n6OMIObxXT3DP5BzkTKGpxNDtWibo6Q2H0y1HOw7ynbUxECwkLCtdf/ciO820=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DieP5xRl; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHR0MHxlCvj9G0HVh9vyIv4QgSp6Nq4j0nPAnBmZS/as7wcUYFF0qSFv3NfiTeVmuBfJWcy0NcPK2jGc2n0puSh3l18k2pHcs+J0GknBAVckFnh1+W0rhIkZJBjjgswukZ5DQ25jkba7xaLXEUQwYVfzbuTakZYjZqPnSEQx7Gr8apLQFYTFG1Z+U+PXkhkqk4sXwJXStjADG57H3hawRInDylxpLbMxDszRsU1ZpryPbU0zWhDqATX+mg4xyDOwtzYFOToABsuMFeAZBmLYTUkM+vEvCZT8SEd3SBwKG4CdFzL+MJXf+1LLTgiKejdpQoVeIHs0fhlvsVtsaP4ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sQy6RP37N5DItN0jZmXVqQOx+o2I5IWnuXAaMnsVFk=;
 b=D8K3czkwbVBk9KtImgg7Z25+bd+GCQwt7CpCl6LX3oh/Ue3ib7nGsukER0nsq8RypImRYAvNfP2r0fasbtwxayUvo+naUxNz88PqJKgGotCfit6oI6yVJ2MbJk96eUV+EwZX90hYKcz7IW9aMBo/9HPMRqVyVme0asB/r5iU5QY5je3EeMAVQkLPyR+IdaC2OukmD1g0qGl2omTtpHqdzavIyn36j9jHBj6MyOG6coIqbbd722aAyCBRbyCUm0X+16eSJNdbju//EFUlOEvwykktMibAXF64XGa5M+kqaz0/cgsQ3AZ47rgF1fCL5J58MVwHc8RVAJcUXz8lpSedUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sQy6RP37N5DItN0jZmXVqQOx+o2I5IWnuXAaMnsVFk=;
 b=DieP5xRl31K6E207q/NDw64CpGxkUxcPMKaVftkIqfohYp3xgNpx2YbmZTZsZNLvflZyXCIyt2mtvSsdMun70QGynCW/s+DY6GftaeZy21CBxZlAPbD+jdMfvILvxLNPQahJ6LKuTCT1olFNhcLMQyohgsyn16dc7FcIhXUwGCcHAsVW3dwORaZzSYalHD4pc/fsKN6NT06xYCkSl6gh1QvJoZynX8TPgvx0q6eOD/FI4zMg5aNOHJPAG6u/1xNTreMC8Yp/FL+YehU/+RHHAhQAyp/HarKNJWLZUFyIZ6zq5mGpdxf1Zv6HP/VXtrf1PAV8h7Vs1Ptgw9AhzFmsvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 20:06:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 20:06:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 16:05:40 -0400
Subject: [PATCH RESEND v6 2/2] thermal: imx91: Add support for i.MX91
 thermal monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-imx91tmu-v6-2-e48c2aa3ae44@nxp.com>
References: <20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com>
In-Reply-To: <20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744056350; l=15172;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZmDXRbH6wNI0VwbN7e+E+vQyFtq4jtjbaOSLMJUl0ws=;
 b=2NJHfdmQ5OejDSQshoKXU7gcILHrrvdr9gRVlQSwWUeZujz1WT8FhGDSyzdH4gCgaoJnitYXw
 ZxhtcXGaMwIBk8G8B0pJpWLVK9XyJGmcFO6ZY67ZJZqaz7KmUGqxtN9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:5::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b84f96b-cd2b-473f-6e48-08dd760fa002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0xtMGhLb0JFWG1kejdnWHRyZmpzK0QxSUdyb2VuK1RleWJ1QVNzdHE0MjlG?=
 =?utf-8?B?M3gvbVJYSFBib0xoKzZxMnBLNWp1d2tqenVJcy9xT094OTdQeUpQVXp3Q2Mv?=
 =?utf-8?B?WUJMKzdZYjV2K0xvekVTcS9NM2dPU3NpclZYR1V5RVhjOUFrVTVYdlFjMUhC?=
 =?utf-8?B?TGJnYTFvb2xuaU81OUNYS1o0MUtQZklPblRkWEZybHc5d2VDVUJaMi92MEJh?=
 =?utf-8?B?WndnNURCMTVFOWUrS2phdUxkdzYxN1QvQTVXN0VIVmZsNlZnL09KemxLdDNu?=
 =?utf-8?B?UmtBZXZtVFNSWnkvVzBCTGd6bXYvczVxSjRzK2NjREZWTVJZM0djQWIzZzR0?=
 =?utf-8?B?YmNGZ1VXTmFpUkZYWUp1cWs4UkR4c0daekJJajZzN2l6eGd3ZUFkRkw5ZUhB?=
 =?utf-8?B?ZGVKbE5pOElTSjczSnNsajBWUloyR3hNTDlhQS91QjFKTVVIakdURjI5V2du?=
 =?utf-8?B?TVlzb3RCR21DSWxFVkZOSUsxdmM5d1hlMVA4bVF3dHptUkxQMXdWcklXMmgv?=
 =?utf-8?B?dkFpQjN4RGcyRE5BdUUvMExCUnZGcmNOenRtSHUzMksvZ1lyalFTalhscHpR?=
 =?utf-8?B?SFBHNHdjckl2WjRPSmQ2R3RNVG5HNW1XWm0zTDFmYnNwamh3MXREZnMreTNi?=
 =?utf-8?B?b25sT1luOUY1dEhLVDJReExPckJPUkRZUjEwUDNSekhMWWFBMWxRR1BGQU1n?=
 =?utf-8?B?ZUs2eHFPbHJBSlVMOE9taWs3YnFUL1dOWld0eHZYclB4cU80Q0hUekJWTFRm?=
 =?utf-8?B?ZTBOcDVIODh3R0RvaEpmWmh3MnFjcnFDU00reWUrTUZ1Ykc1RGFhM0cxY2pm?=
 =?utf-8?B?NjZhcWd3eFhrRmhHM204VXVBV2NpbzhjVjNwem91RGdJVVQwNXYvNFowOFE4?=
 =?utf-8?B?NWc1eFJvMjNsczVDNFNYZlBBdmtwUWk1THFkZENyOExOalhUc2hocm40WWw1?=
 =?utf-8?B?VHZQS0xwU2JqcE1WK3I3anNBeHBlckE2dk0va0h4WCtnS0VGcW1DaGJjamdt?=
 =?utf-8?B?ZGM0bitZUHMwNFpDaWd0UURVM29PekJiVFB3Q3dzczhKb2p6N2xWNnZSTVVX?=
 =?utf-8?B?dklzaXdCeFFuZDNIWno4a3grTytxYWNOSDNieUJ4NDdyT1J5SnNSSTZmbDJy?=
 =?utf-8?B?U0hOKzBNbDB2cEdjMnBXYUVINS9mdHZXZkVza3dzVVZ2M3czbjF6VXJac2Rp?=
 =?utf-8?B?dStTb1RDL2MxVkQvdVdlYVBNTGRoUTJ5bXpMVnRzQmdUTGt1a0dYdk1xTEVL?=
 =?utf-8?B?TEdhNGZQTFJ6RFgzWnM0c1JLSXNQUWwxQTFLem1jYTk0akRiV0pjMk5lTHFs?=
 =?utf-8?B?LytLSUZ0allVVXNVcVBuWFNoQm5GT2JabW5mUlV0cDRIWGNZMzBVTDIzOXZU?=
 =?utf-8?B?VkpvaVFRVmd3SnBtQ0xyZWliOTBtL0xNT2FKbVFzcFp4bFgxQWdCUVM1WlBN?=
 =?utf-8?B?N1l2YS9uS3pPWWh3OXFPWDI2dDNINzJjcHdTVDRYTWhtTXJESWR4NUVnb0VL?=
 =?utf-8?B?eExjSnBmZW9vcHhCb2Y2aFVkUFR0MGdVMXF0SjlPUFJyOFRMMXVLN0EwMXJY?=
 =?utf-8?B?NVZnay9UeTYxTEhJd3V4dVpCL2k3ZjRHaVRsWkpZK2F2V3I4WlZDQzFyVTJX?=
 =?utf-8?B?ZVI1SkxXallYVWJyU2xLTVY4eUdNdGVoVjc3TjU1c3R2SGRXTSttcytWYkph?=
 =?utf-8?B?ejVnWFB0bzkxc01MbVRTeFBIcU4wWjEwQm5YZ0VzbUJXYzliNTRBTzJIc2h1?=
 =?utf-8?B?MkZDbzg0dmJyNk8zemFCL0h0MWRaSUcyMDFvZkVrMGRESWxLZVFXcStkTGk5?=
 =?utf-8?B?TEZoamhZUlZJMitpT1NFYTJDOENSWGxzNWxVTHhyaEo0YllDVWd6em9zREhU?=
 =?utf-8?B?MDc1SG9IYllHMHI3WGdnNzJUWVNaN29iMGpTNEpwZmsvWkFrWktpeHUvWktn?=
 =?utf-8?B?VERiY2ViclhENy81U2xYUjg2TGZDd01SdUdHM2FqY3orcUY3UlVtemM1c1l5?=
 =?utf-8?B?TFlHQnhWSitaYktNR2hKRmxITis3dWo0RUo4NHVEWVduQ3Fjd3lSYS9aMkd4?=
 =?utf-8?Q?hZvq3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmpPUldPcXMwU1NvMWt6aHJoR2tIOW1HVitaRFU5Uk0yQ3hVUDlyYXh4UzRa?=
 =?utf-8?B?Q1Bid3dqZEtVNi9RTlJyYlUvN2U5ZUJhQnl2UGx2T0Q2a2tLZHpycDBTdzVs?=
 =?utf-8?B?UHVpUHF1dlErN0N0RkhSb1dtQmo0RUZIMk1XckdtbENXcjBjRXVTd1JZMWRM?=
 =?utf-8?B?QVhUWURBMkVseWl5cTV1b3YrRU10VnV3NURWREJKVWsvMXlUTGNFUW1ucUI1?=
 =?utf-8?B?M1d4V3o3NDBjRndMMmZHTGJMR1ZuYlFDNG1zaURrQzYrSS83bnNKb0ZReHZi?=
 =?utf-8?B?TGZLVEJ1enQwSE43N2RtSGpOSjkwL2pFSjhLTmJ1Rjg4Q2FDQ2UyTXowbjRR?=
 =?utf-8?B?Y0tKSlJnM01TZHVTZER5OXBBY2NzRUpzWWwxQWJENy92c1hQRU1BQzFaRHZ5?=
 =?utf-8?B?eTlhQWlhc25FeVF0bjFNM0w0dHZtNFd1QU4wRThFUEVtcmxHN21nU2xsSlBC?=
 =?utf-8?B?U3o4NFA4ZGdXZGQ2TTFhUmloK2RxSVcwT3ZSbmZwcGxlMHdVUzNqZlhtVCt1?=
 =?utf-8?B?eW9UbFlIVVZzNGZXY24wK3BIODFsYVVOR25MbmFIRENoSlN0UDZuSkxRdzNi?=
 =?utf-8?B?bTluSTFOUTR3K1lBUUpHeFNyUVEwTW5vLzRIS0ZUQm9Oa0VOYzhLQ2tPbHZk?=
 =?utf-8?B?ZjBUY2h1NGdwb1poUzZKNlQ5N2xuZ0g3S1JDK1d6VVJzTG1SZFQzdEh1Zk5q?=
 =?utf-8?B?WXUxVXJZaDhKQ2szRjVvRlFHNEg3YU9SN01nWWtRUWprVGh6enFZUFEraUF3?=
 =?utf-8?B?YkdNTHJSNnpMR0FsZlJhN25VbHJOeVFvQW9sZjhPRzJrVlFHMzE0VXF0M2pP?=
 =?utf-8?B?SzltNElkbllIMUxGanYxSHVTd0FyZFpEVlNaMDExSWgrQnlpUk1La2lqRHFp?=
 =?utf-8?B?a0kvVnoySm1xUDZ1elBPTFdtRXArMitLNlFtMElwcm1VbnRpK2V1LzJWUDh6?=
 =?utf-8?B?QnhsdU1zc0tGN052UzkvbklCS3NqSzU0aTc5RGlYRnlxUEpLS2Jidit1RytS?=
 =?utf-8?B?NGJXdFNqaXVxSEtDSGxvUmdQSW1Ca0wxSVoycEYyWjJqOU42aW5iODJKV3Rq?=
 =?utf-8?B?K0ZweU8zVEtUQ2J5MUdObW1jZzFzTXJhMkpoc1FxSmFuOFZsRUVlSEhiYTJv?=
 =?utf-8?B?Yy9vQUZiNXZGVHV4cDhsRU5WRE9RakpCZG01bWZTYVUvQWJhVXU5RjI4NE1x?=
 =?utf-8?B?M3EyMHpHUWRZWllXb0cveEhtV2hzbk1LU2N3M3BieUpQS0dzVVlsK2s0TjlV?=
 =?utf-8?B?RWUxZm1RNktJMlBIbHJKN1ovSHRRMHVUODBUVFJzSG5RYjlCOXBrSHNqcWE4?=
 =?utf-8?B?V2w0T0hQYXR3Q3lPa3daMWJSWGlnUUNoOUF4Zk9WNlB6OTJzZ3lGRWREcnlY?=
 =?utf-8?B?UzBSYVVicjRCcGZCdW5haGlMbWJwZjRhNE5VeXF4MkZSMTFKUDlHY0ZUaHdH?=
 =?utf-8?B?QVJuazBrajJ6M2ZXenMyMkRGZm5UenNGNnJxYS9QQTExd0txa3ZnV3JCMUVM?=
 =?utf-8?B?WmpDdGd6ZFdXTE5jM2w5UDJmYWl5b3JBcHh4WktvdnVtWnh2UkNVcVBWNEhm?=
 =?utf-8?B?RHNoNGJRalpKanRReTZhdTNYR0N1Zm1sY255dEZ4SFM1T3l1Qk96eVVUWWNY?=
 =?utf-8?B?L054WjNTU0d5ODdHZndZTmJ2WGJLN1pqKzkyYkczdFZ6aEgzLzFVZnJWT3Vj?=
 =?utf-8?B?a294a2Z4cEVDemxVK2NWc040UVo3Y285Y0VYRWtJaHVnZlVFODgzZ0YveVRl?=
 =?utf-8?B?aC9vNjdIcFl4cVl6VzBJVm5EbGo1azBLSGpRSHRTQmNNYlEzZ081NmtLZkpI?=
 =?utf-8?B?QUNRTlE3YkNFdytGOWdRVE4yWGYvdUdUYzBTNnZqZ3hxR1grcUsyTmZ0TTFF?=
 =?utf-8?B?NERNV1YrZ2ZYWUM0N1ZUWjlXdWQ3UVBlWDFzUDhNZVREQ01xODEvaTZsNlpo?=
 =?utf-8?B?bkNGODJQTzFXd2FYUlFuT3FCdU0zZG4vODFwSFpkOENXdVk3MnFGSnQxdms2?=
 =?utf-8?B?eWl4VFNob293Y1g4ZEhidTk0WUtRc1dob05JZGNMYWI2TlVDQW0zd1JGaEpI?=
 =?utf-8?B?NTMwZmJNbXU4N2xQV1htSUswQmkyUmVVZXpRYlZQN25jVzRaY1pjZW5JTUtL?=
 =?utf-8?Q?w+WY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b84f96b-cd2b-473f-6e48-08dd760fa002
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 20:06:04.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ls6GhX/8G35VHDmbrzUc+6yV4AyaABmestkklIgRKhdNWY38pSp26ngqZVsqzJmTmGdvhUuspIFm3g6lxvmp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

From: Pengfei Li <pengfei.li_1@nxp.com>

Introduce support for the i.MX91 thermal monitoring unit, which features a
single sensor for the CPU. The register layout differs from other chips,
necessitating the creation of a dedicated file for this.

This sensor provides a resolution of 1/64°C (6-bit fraction). For actual
accuracy, refer to the datasheet, as it varies depending on the chip grade.
Provide an interrupt for end of measurement and threshold violation and
Contain temperature threshold comparators, in normal and secure address
space, with direction and threshold programmability.

Datasheet Link: https://www.nxp.com/docs/en/data-sheet/IMX91CEC.pdf

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- remove Macro's review tag
- remove mutex lock
- use set_trips callback

Change from v4 to v5
- add irq support
- use period mode
- Marco, if need drop review tag, let me know

Change from v3 to v4
- Add Macro's review tag
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()

change from v2 to v3
- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
uboot may change and enable tmu.

change from v1 to v2
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
---
 drivers/thermal/Kconfig         |  10 +
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/imx91_thermal.c | 398 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 409 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e71..78a05d1030882 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -296,6 +296,16 @@ config IMX8MM_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the passive
 	  trip is crossed.
 
+config IMX91_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX91 SoC"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on OF
+	help
+	  Include one sensor and six comparators. Each of them compares the
+	  temperature value (from the sensor) against the programmable
+	  threshold values. The direction of the comparison is configurable
+	  (greater / lesser than).
+
 config K3_THERMAL
 	tristate "Texas Instruments K3 thermal support"
 	depends on ARCH_K3 || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9abf43a74f2bb..08da241e6a598 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
+obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
new file mode 100644
index 0000000000000..e8deb0b07dc98
--- /dev/null
+++ b/drivers/thermal/imx91_thermal.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#define REG_SET					0x4
+#define REG_CLR					0x8
+#define REG_TOG					0xc
+
+#define IMX91_TMU_CTRL0				0x0
+#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
+#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
+#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
+
+#define IMX91_TMU_THR_MODE_LE			0
+#define IMX91_TMU_THR_MODE_GE			1
+
+#define IMX91_TMU_STAT0				0x10
+#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
+#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
+#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
+
+#define IMX91_TMU_DATA0				0x20
+
+#define IMX91_TMU_CTRL1				0x200
+#define IMX91_TMU_CTRL1_EN			BIT(31)
+#define IMX91_TMU_CTRL1_START			BIT(30)
+#define IMX91_TMU_CTRL1_STOP			BIT(29)
+#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
+#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
+#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
+#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
+#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
+
+#define IMX91_TMU_THR_CTRL01			0x30
+#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
+
+#define IMX91_TMU_REF_DIV			0x280
+#define IMX91_TMU_DIV_EN			BIT(31)
+#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
+#define IMX91_TMU_DIV_MAX			255
+
+#define IMX91_TMU_PUD_ST_CTRL			0x2b0
+#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
+
+#define IMX91_TMU_TRIM1				0x2e0
+#define IMX91_TMU_TRIM2				0x2f0
+
+#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
+#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
+
+#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
+#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
+
+#define IMX91_TMU_PERIOD_CTRL			0x270
+#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
+
+#define IMX91_TMP_FRAC				64
+
+struct imx91_tmu {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *dev;
+	struct thermal_zone_device *tzd;
+	int high;
+	bool enable;
+};
+
+static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
+{
+	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
+
+	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+}
+
+static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
+{
+	u32 reg = IMX91_TMU_CTRL1;
+
+	reg += enable ? REG_SET : REG_CLR;
+
+	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
+}
+
+static int imx91_tmu_to_mcelsius(int x)
+{
+	return x * MILLIDEGREE_PER_DEGREE / IMX91_TMP_FRAC;
+}
+
+static int imx91_tmu_from_mcelsius(int x)
+{
+	return x * IMX91_TMP_FRAC / MILLIDEGREE_PER_DEGREE;
+}
+
+static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	s16 data;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	/* DATA0 is 16bit signed number */
+	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
+	*temp = imx91_tmu_to_mcelsius(data);
+	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
+		ret = -EAGAIN;
+
+	if (*temp <= tmu->high && tmu->enable) {
+		writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+	}
+
+	pm_runtime_put(tmu->dev);
+
+	return ret;
+}
+
+static int imx91_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	int val;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	if (high >= IMX91_TMU_TEMP_HIGH_LIMIT)
+		return -EINVAL;
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+	/* Comparator1 for temperature threshold */
+	writel_relaxed(IMX91_TMU_THR_CTRL01_THR1_MASK, tmu->base + IMX91_TMU_THR_CTRL01 + REG_CLR);
+	val = FIELD_PREP(IMX91_TMU_THR_CTRL01_THR1_MASK, imx91_tmu_from_mcelsius(high));
+	writel_relaxed(val, tmu->base + IMX91_TMU_THR_CTRL01 + REG_SET);
+
+	writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+
+	tmu->high = high;
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+	pm_runtime_put(tmu->dev);
+
+	return 0;
+}
+
+static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
+{
+	struct device *dev = tmu->dev;
+	u32 trim1, trim2;
+	int ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
+	if (ret)
+		return ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
+	if (ret)
+		return ret;
+
+	if (trim1 == 0 || trim2 == 0)
+		return -EINVAL;
+
+	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
+	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
+
+	return 0;
+}
+
+static void imx91_tmu_action_remove(void *data)
+{
+	struct imx91_tmu *tmu = data;
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+}
+
+static irqreturn_t imx91_tmu_alarm_irq_thread(int irq, void *dev)
+{
+	struct imx91_tmu *tmu = dev;
+	int val;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	thermal_zone_device_update(tmu->tzd, THERMAL_EVENT_UNSPECIFIED);
+
+	val = readl_relaxed(tmu->base + IMX91_TMU_STAT0);
+	/* Have to use CLR register to clean up w1c bits */
+	writel_relaxed(val, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+	pm_runtime_put(tmu->dev);
+
+	return IRQ_HANDLED;
+}
+
+static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_device_mode mode)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	int ret;
+
+	if (mode == THERMAL_DEVICE_ENABLED) {
+		ret = pm_runtime_get(tmu->dev);
+		if (ret < 0)
+			return ret;
+
+		imx91_tmu_start(tmu, true);
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+		tmu->enable = true;
+	} else {
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+		imx91_tmu_start(tmu, false);
+		pm_runtime_put(tmu->dev);
+		tmu->enable = false;
+	}
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tmu_tz_ops = {
+	.get_temp = imx91_tmu_get_temp,
+	.change_mode = imx91_tmu_change_mode,
+	.set_trips = imx91_tmu_set_trips,
+};
+
+static int imx91_tmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx91_tmu *tmu;
+	unsigned long rate;
+	int irq, ret;
+	u32 div;
+
+	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->dev = dev;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
+
+	tmu->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
+
+	platform_set_drvdata(pdev, tmu);
+
+	/* disable the monitor during initialization */
+	imx91_tmu_enable(tmu, false);
+	imx91_tmu_start(tmu, false);
+
+	ret = imx91_init_from_nvmem_cells(tmu);
+	if (ret) {
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
+	}
+
+	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
+	rate = clk_get_rate(tmu->clk);
+	div = (rate / (4 * HZ_PER_MHZ)) - 1;
+	if (div > IMX91_TMU_DIV_MAX)
+		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
+
+	/* Set divider value and enable divider */
+	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
+		       tmu->base + IMX91_TMU_REF_DIV);
+
+	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
+
+	/*
+	 * Set resolution mode
+	 * 00b - Conversion time = 0.59325 ms
+	 * 01b - Conversion time = 1.10525 ms
+	 * 10b - Conversion time = 2.12925 ms
+	 * 11b - Conversion time = 4.17725 ms
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+
+	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK,
+				  IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+
+	/*
+	 * Set Periodic Measurement Frequency to 25Hz:
+	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PERIOD_CTRL_MEAS_MASK, 4 * HZ_PER_MHZ / 25),
+		       tmu->base + IMX91_TMU_PERIOD_CTRL);
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE | IMX91_TMU_CTRL0_THR1_MASK,
+		       tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL0_THR1_MASK, IMX91_TMU_THR_MODE_GE),
+		       tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+
+	pm_runtime_set_active(dev);
+	devm_pm_runtime_enable(dev);
+	pm_runtime_suspend(dev);
+
+	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
+	if (IS_ERR(tmu->tzd))
+		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
+				     "failed to register thermal zone sensor\n");
+
+	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, imx91_tmu_alarm_irq_thread,
+					IRQF_ONESHOT, "imx91_thermal", tmu);
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_suspend(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+
+	clk_disable_unprepare(tmu->clk);
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_resume(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret)
+		return ret;
+
+	imx91_tmu_enable(tmu, true);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
+				 imx91_tmu_runtime_resume, NULL);
+
+static const struct of_device_id imx91_tmu_table[] = {
+	{ .compatible = "fsl,imx91-tmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx91_tmu_table);
+
+static struct platform_driver imx91_tmu = {
+	.driver = {
+		.name	= "imx91_thermal",
+		.pm	= pm_ptr(&imx91_tmu_pm_ops),
+		.of_match_table = imx91_tmu_table,
+	},
+	.probe = imx91_tmu_probe,
+};
+module_platform_driver(imx91_tmu);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


