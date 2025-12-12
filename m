Return-Path: <linux-pm+bounces-39453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4047CB829C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 08:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24238300BA1E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3FC30F540;
	Fri, 12 Dec 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="At+kkYta"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AD305047;
	Fri, 12 Dec 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525905; cv=fail; b=Qtk25wt31FoSzcvQycMxMBh1HI4B5JGGrJS9nzlV0k0kPcb1mFJqv4MMAvAf6O9j5xRZlgpgMyKgmLMb7rsTimtOPs4AxiukgSWYUqayXOfXMv6hTZJ4GnXqbj0KUz4XMAbWG3hEr6bLaPqeJ1OJkt7qojXp2UmGCzJ7RXjVdDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525905; c=relaxed/simple;
	bh=Iyj7SrzXzWbl8o5i0IxUwyPydP6+MAJZpEVb8mpLty0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fSvPSLF6axsVPekHCOfNrWf9pFFXYRaHGcKBDVajdYwVx9DTH+QKQ4BGqg6r6XonaQpNysxz29To6UeDOBj/5F07ePvvOvkV+/TZWTUXFInCt56UKkci/pZPhuIPwPWcVJL5Uw6NSsQmestuVUfGJLiBGoBDBOnEDD/KQJ+YIdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=At+kkYta; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x76lCce+5VCS04wjaAkXfmSUIRnsiuht4FDE3NZTpj/nYYexGJzVymOWRZvEMXe3dGVqWWqp2ZBBSql6o0uHDiTrvliniZzXH6q4pzWK3c8eunc8rAJJEvePuXy2vJun6c9x+HDz43vFUti1js8tff8m3bzDDYx5VGvflzLP0LakH+tswsUgEGacpUNunbaot875zgAEUNHCT6590RBTTEUw/Ca3Cw37Czv0hv7DyqPZSRNmnkwBFxXVQCybKxOIb2liJ6Z5WXErReoNh4pN54XQGvmztipHnO595ilw7l1keJeOkj3Z4i+nR6/oeoHeYCwoiqfykWpJN1b0jZ7SNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vez6RZTVK8baSv3PdTFRWDPPijPgsI+5n6KNGRza4W4=;
 b=o3xtIodIT/pz5cdM8eIv+OV3GEVGaGRVyIUSU4H1F6AUD7+12RNwJb8I/WPC8KbXMlBIT1zsVpBsPIo/7MYKuvz6jiTAJZSENdekX//mZpsdkQX/W45EH6LOifN9EU3IQ97IP6IMsEk9lfXBEruR3AQGx1CheeGelFafTWN755tEbOj++Xl3pvMpgJg9M1J+nvU7t7n30ZZwXnlNj/ra7ClsRRY/yToyXaqJ8rB69fN6TW155B7dURQbVx2Z3xlgXtw8cwJPSj+oGwZMQEScJhE6mh9KaAqObIYiRgqQ59X6fh2GpVTvscWOXCTD7nfBILvJsUHgYZ2+r3fG4dVryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vez6RZTVK8baSv3PdTFRWDPPijPgsI+5n6KNGRza4W4=;
 b=At+kkYtaOtHXWpzCHTPAfvs794KvKfdMmvujlrWAAz0lrwgSWuJP3tvWSDczfI6zHerLodqybm9kvdxONDhYWToV0i4aWAyEGnml+tGLYAjV4XtRhGhPdx5nGW3qRyrU45f+YOcnS1pVFzQBS5MP2a0iAqJplYvUtKQjEwTHh2dm+fJ8rEdEUqSzX/SfSsyegnIz9xbCa9Ezcjf3ZlvldKi9y39CkUfQcFbC7CR7vSsLBC5OkDNx7gT74EGJqDzZMyLMqAK6sC7cQARBS/Amkt+P2uqnSSQ55nK2QW4b/OdbYdzSlaW9eXPkuMf4Nb9wWkwFHP/dUdPPsBf5j4/8mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10608.eurprd04.prod.outlook.com (2603:10a6:150:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 07:51:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Fri, 12 Dec 2025
 07:51:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Dec 2025 15:51:14 +0800
Subject: [PATCH 1/3] thermal/drivers/imx91: Check status before reading
 data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251212-imx91-thermal-v1-1-c208545b44cb@nxp.com>
References: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
In-Reply-To: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10608:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c88770-f2de-4550-0fa1-08de3953495c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEdEZExFTW50SW5MM2lyWWhmdENROGNyc3VzSTlYWGVHand4aFpBQnRTTG1M?=
 =?utf-8?B?aVFsdFRONmEwSFJlc0xqNkI5cFhZWnhrek1rdUkxS245UnE3Z3JqTVN1bFBv?=
 =?utf-8?B?dTlDZktjcWErSDdhd0ptYzl1Skt0aldSaVRGK0JBNjNWeGNUUmdjcDVoRkhR?=
 =?utf-8?B?VWNubEk0enllbytIbEMwMDlKeGpiVmpoK0I3NkpRVHZ1K3NoTjB2blVpU0pa?=
 =?utf-8?B?d3hPTDlaQzM3Y1pDZG1tOHJXa2NSRWZZaXR3TG9JdkgrSGZBVDMzancrWENG?=
 =?utf-8?B?YWp6Wmhvb0FGbzBGY2V5RTBjZVdEN2l5ZDB4WXo3TXJXdkUycWwrdlB4cXZq?=
 =?utf-8?B?L3FUeFNNMjM2dUR5TFp3cVFic293R2ptRTRKTXdrQXF4TVVmM0N4L2xMbFoz?=
 =?utf-8?B?cGREWFR4U2oweEJnTitVaWpBamJnbG5IRWVaUllTVUFnNkFmbndxbGdVOGRw?=
 =?utf-8?B?WURSVnlUVHRnMDVSalExUmErZ2Fjd1ZUTDduWFJJRmMzNnFKNUQxYjZrcWJP?=
 =?utf-8?B?MW5CTWozU1VLT0ljek16N1dtemVBc3RLd0NEcTB2aHZTK2VES1oyRUI1STB0?=
 =?utf-8?B?ejZ0clk5dFlhWDNpS3k3SVBRY2hKTDdIeXVxN2tTK2F2dndvOTEyYk9zQWZt?=
 =?utf-8?B?Ly9wbEpCdWJPdDZGVXdyWEtmSm5yWUNyTWd3dnExWXFTUmVMYlVuZGFOWEhr?=
 =?utf-8?B?MmtTb0NRbDFlT0Z0RlBoN2FIUmY1N3A0ZndKOWxGd21FbU1Cb1R6VkZxeUJX?=
 =?utf-8?B?dmx0dktNRWtIamMxWHJYRFYwUlNGUnBzWEhHRzg0NDF6djQ1ZFBUUEVscnhN?=
 =?utf-8?B?ZjNZMGg1WGREaWpWOEVRSGdmcER2SFRHcWd0VHNyTXhmSFB3ZFI1STg3Wk9O?=
 =?utf-8?B?NVJBYVA1UGNqU0wzc1VQbFZTYmFGWFl4dkY5WmMvV0NrRktPb2NQOGh1c29j?=
 =?utf-8?B?bFlFREVQcUNCc3lkbEF1T1NPazBUNVNya1djbHBkQ0xaNXN6MUZrMmdPd3Zv?=
 =?utf-8?B?UDdqL0t5STNXYnZyVGZCN3ZxTGZ1KzZPSUo1ZHRMTWE4VGtJbm5pRGtOR2lW?=
 =?utf-8?B?TGtML2xHWDY2TjZBam9QbzNNUDRBMXBjUEpneTBhdGFHT1pZR3E5bjBzZU02?=
 =?utf-8?B?SHVhOHZYUEZNTHlqZUNyOVgxMXI5QjM4UmZHTEI0cEh6S1A1OTlKRFpkdFNY?=
 =?utf-8?B?N1NTU1VoVEdJbC9zM0FBL25HZVhKNkMvRC80N05OVVZjTnp4M1lyUjRFS1NS?=
 =?utf-8?B?dzdGazFpUzI2MjBnVXZBbDhCemt4WlNHTHBlcGdLSHFNaVpubkJvOVBPMUtt?=
 =?utf-8?B?R3QvRXFMSkhkT3BrZ2U0YWFPVkFCWjlTUjFXSllXalc3N2d5dy9KQkdiQWlY?=
 =?utf-8?B?a2gwNUllZ3FLTk0zU0l6Z3QxZjhUN3d2RExsT2pOK1FVU0RzT1F3R2RBdzl2?=
 =?utf-8?B?Vy93ZWJCdzViNmF6UWdzRzBJQjFNRmxuYThTREpyUzNqVERwTHQzZy9WQVI2?=
 =?utf-8?B?WlU3eGQrUVF5a0xlWHpkd0p0Y0twbHlIYittR3hpL2hyWk5GeDZHczdnblg5?=
 =?utf-8?B?emUySVBZWU9jOTRBQXFhVEFFTGd1Q2RjUysvUTBSUFNHc1k5bVdxem9ud1Bm?=
 =?utf-8?B?cHQxMmtlbFpOMDU4TGVwZ0pkMWYyM0xtRUpCV2xkZm5GSnhVeU5FbzhhNXdt?=
 =?utf-8?B?MFZIM2I2RjI3M2JveWtJQkRHREFtVXkwZG95WkNBNGxxUWkxZlhMKzY4YkVp?=
 =?utf-8?B?ZmNtN1MvWHU2dDVXZ3ZGMjdoT0xZUmRYbjVoTzZhZjU5bGRHRUJtendOWGwx?=
 =?utf-8?B?QXljR2hLb0IrZFQ4SEpueldmZURzM1ArTytEMkhIUW1XN1RrV2tlZHhqOFd4?=
 =?utf-8?B?YS9aOGV6MDNKQzVGMXY3SHhpOEZkbTZHRjEyaDhEaXBiSm04eEpIYWF0ZTE5?=
 =?utf-8?B?OWZMQmkrVGlVb3NsQ3lOdC9nQWc5M2pWbVZzYXdzNUxwZC9rRnFieWp2NnNk?=
 =?utf-8?B?OHJoSFl4T2lLaDJPWERwcFpEU0Qxc2JVcWhiQk8zbEdrSjg4R0plL0dWNSt2?=
 =?utf-8?Q?Js0RLq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUtnMGRVK3ZYdDRtelo1aDRZMlhmTm45VUNWQ2NRbGY4NktHRVR0SzQ3MkhI?=
 =?utf-8?B?U2tEVnpNVTY5SDl4L09Td0xDYzFDU2ptUksvVGxJUldDTlp6VDUrY0paOXlX?=
 =?utf-8?B?d2NYTEh6ZUxmclh1YUtlWmlUK0trOFdlSC9sZXg2VUhsK045NG53Q2ZiNCtL?=
 =?utf-8?B?RVB4b3I2NkMrcnl6M0FyOStkanBQaC93bFB5Q3hHQUZpREJ4dlVLSi9ua1p2?=
 =?utf-8?B?WkUxbkgzS3d4T0cwN0wweTloYUwvYzlXcmViSFBuWDNYSjFqd05KVnFHa1Ra?=
 =?utf-8?B?eEpSazloc3JVRGNRQzR3M1VUVzZrYlNnRTUrTUdKaHZTSmpsTDdmdVpPYndT?=
 =?utf-8?B?UzRhK1pLYXkvWHhPMW5CRHB2OFRsZGY1VVo5L2RTTWFTeUlrd2kzb2x1ZGZ0?=
 =?utf-8?B?YVY4WGhIdHBtc3VJMUxhYmovd0pKamVNdnUvS1piRk1aOHByL0VqSTNsTEFM?=
 =?utf-8?B?YU0xTXlSZ0JpUHIraFMzY0E0NWZoTlY3a2VlQ1VQa0NpSDJNQ1lob1grMEtq?=
 =?utf-8?B?UWw1SThIMjE2c0cvZVlwN2NMRzQvOS81SEt0b1A3ZERjb01WUnhxbXBSZ3dN?=
 =?utf-8?B?cmtXYXNHcnZuanVqcGk1U0VsbU1HSHBaYjcyM1RVVnlKbVRZbnRPL09kSGc4?=
 =?utf-8?B?b0FBRlpkMmJtS0ZNQUhTNi9VRjEyUWJ0KzhTUlNVbDdxZXZoNUlTOUY1Mk00?=
 =?utf-8?B?QmpwZjh3alNzcmxsazd6MXR0TEZpaXMvTXJrMkxROEVsZlVxRHBKOGpLRWlu?=
 =?utf-8?B?TlcwMVl6QWxpcmNEVktYdVR2TnV6ZmZycFczaVpydUNUcE13U1MzRzdxWm5D?=
 =?utf-8?B?L1hIaGtidVRFSlEvTU1OSkVWd2ltUHgzeUlELzFEYUpCWkV0VWROWUJnWHVt?=
 =?utf-8?B?NGdrVWkyWHlVYTNTSjBsbHYvUURFeHNDMGlSV3dIdDUwc0pjTG91dTNvbjNY?=
 =?utf-8?B?R1NyQnQyWjFJOWc1cEI5MjJrZEZqRGZ5VFVCRWdCMi8zZzc5TkJjcXhoOHJC?=
 =?utf-8?B?S1dNNU1tdHdGTTNGbnpCenQzR2FZd3Vxem53b1plNW5hM0lNeit0djlUUVdH?=
 =?utf-8?B?Mk9wVGNzdzNSSGU2OHl0SFF1Zi96VWlhUWFYbzRuM2NtN2ZDcDY2dDduS3hC?=
 =?utf-8?B?djZyTXNuemhqUDBtL1NhMEFNNTViWWFBZ2xUcnFjRVd1dWJhQXVHU2RDUUNz?=
 =?utf-8?B?aWtqRWtHQmFLRGxEajFZV2ZYeXFwMkF4d21rZ2EyeHhsWHZtN3N2QnYvWlFX?=
 =?utf-8?B?Z3g1TmdvTWFsOVUxa0Y4cGk0Njl2SVMreVFPV2g1ZThKQVZlTmphTkVCekVG?=
 =?utf-8?B?MTIxSER5YWYya3ZodklaVWhRZ29VVWF1UU5kWW1sdStSM0RkaFJMVGJqV25O?=
 =?utf-8?B?SDZQczB1UkRWNjdpaWR2RnNPZE42S0JIdWE1K1dtbnJkdlJNK29BaUg4YTEz?=
 =?utf-8?B?MEJ5ajQvZGNxelp1WGtQMkFYd013bS9UaWlhbDlPd2FwNlVtL1VQZllTV1FH?=
 =?utf-8?B?NXNJR21nRXlyeG0yZTN6UTF4L09QNFdVY1NsaWpQMTY1YU9oVmppRTFrc3Qy?=
 =?utf-8?B?RE1kKzZQbFdzRVExbXVnT3V2a1gySnM1SVdpS3VPa1JUOGpyVEdla3FYaWNy?=
 =?utf-8?B?Z24xRllMWDdZSkxza1c0ZnBOa1RjM3B5Y3hDbEdPWkpmOU1Lckhjc1BLK3l1?=
 =?utf-8?B?K3NvUFJDRkswaytHRkRJTlNVclpxYmxtNzFJR0VXL25neW5qbzlsSXRDelY1?=
 =?utf-8?B?bEFCa3ZXVnNDcFAzTGpBZnNpK0h1UUxVZWozSmdwTUFySGM1Z1E4TnRJdHdq?=
 =?utf-8?B?VVgrN2M3SlZEaTZVOFRuR2NkWnJVMUtyT2lOUXI3dmdRWFEwdXU0RU5RZkpi?=
 =?utf-8?B?dklwa2lMV2RvK29MbUhGR3p6ZlRrYnFHVjk0eWxUTDUwcldJTVYyWHlVQmpm?=
 =?utf-8?B?RjBkbTVBRWZQQlV0V2NsbC9BdVA3UTVjcjFCTExVQ1ZwY2o3ZFZ5U2VjeGQv?=
 =?utf-8?B?YVZrdTgwSHM5ZjNxMkhlZGJRRk5xOStjZ3NHaDFIMG41ejl1VUtFUzhtWm9B?=
 =?utf-8?B?Q0pJQUkyditkVmUybnlqS3BFWEF5Y2xFUkRxaEpvSi9HNG9ETG1sNkxTTUtC?=
 =?utf-8?Q?1inHhcRrgDckjSinLmbn6099E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c88770-f2de-4550-0fa1-08de3953495c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:51:41.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NCU+LIzHXvetc2qOMxOGTWwx3NOHmgm1/kTzSWwJ9/svMxIDq0BkvpQCnsEYXlwHvjtOh8OHRkLiwy1/1JDLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10608

From: Peng Fan <peng.fan@nxp.com>

Per periodic mode from reference mannual:
Write 1b to CTRL1[START]. Wait until STATm[DRDYn] becomes 1.
Read DATAn[DATA_VAL]. It clears the corresponding STATm[DRDYn].
DATAn[DATA_VAL] and STATm[DRDYn_IF] keep refreshing at a periodic interval
of time, corresponding to PERIOD_CTRL[MEAS_FREQ].

Need to check STAT[DRDY] before reading the DATA register.

And check the returned temperature to make sure it fits into the supported
range (-40°C to +125°C).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/imx91_thermal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 9b20be03d6dec18553967548d0ca31d1c1fb387c..77e8e6a921c6af308b830c36721293c007256ca6 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -108,10 +108,20 @@ static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
 	s16 data;
+	int ret;
+	u32 val;
+
+	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
+					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000,
+					 40000);
+	if (ret)
+		return -EAGAIN;
 
 	/* DATA0 is 16bit signed number */
 	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
 	*temp = imx91_tmu_to_mcelsius(data);
+	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
+		return -EAGAIN;
 
 	return 0;
 }

-- 
2.37.1


