Return-Path: <linux-pm+bounces-18870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A17D9EA175
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 22:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20B7166285
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E619E830;
	Mon,  9 Dec 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eeH6EBtg"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2E19DF75;
	Mon,  9 Dec 2024 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781215; cv=fail; b=G+jtz8Gd8njdGiHGkuqrfT6l4B9Ad4IdIm1Ip9GLWYvO77vYPGo0UPdEsINVxazF7TKIqZK9/F3mTaqK/LxiHXPRd6JYRHmsgJo/bFQv6dmZ33drOdBoRj7wF3r/25HL4Q1c8jXQ2iBclnG+dPv+mbBf3rCQmUa8BnpFbkcYI9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781215; c=relaxed/simple;
	bh=sFExiCv3YKtMjHKSnTrqvKkjdtXeDGb8mombA55K5OI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N0egRURz4xjD0yk9uajyCOjvKgc5uLk1JhuLlSoO2rqvEu4CbTCA8nZSHO6OAIxcA/zyH+e3Jl5qZAhsfm/ImSNXeq6QYIuV5S/r5KGLFCHrTCci3GWveEE1I067Jp2V2HdhOFC3KvozK3ckp49mfXW5fWII9/Fqdzr2EaRhhck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eeH6EBtg; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNVJBQHFpR8N/k2RFpJiUVHaiPc72vxQog+t1WY3EKZ0+3ENSfmQ2jq0JUPTDELjtj0qQTnDdXJII+RIekJ8MfcrxHeicbVw8fPFOlLfF6aOWU3/31QKxfmV+dOFEwzZZckdSYwDztZlN+94Xhyt2RsbuxmT/0u21edQHmz1cN7nhUjrrQz2VGnpyqSp6tPT8o428XQASMp2QyPVfSYshZC8NbAXeU3nNa+itEu6fGEcWxSR2juKjOJiTniR7xEsOhDpJ8eTM2M+9dvE505BPfRrMvH8MwCv/5G/Kzpg7Hr+Z/7Gy8Hx7nWlRudDrYY276wrDqw8/jysrlaiIl8C0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgtMCLqyqGK1BODw+TI3oOGUb6f940l4cn1sIEKmyyU=;
 b=m1eCSYlR0CwUVNcRoXId63gZjunGufWy8eJX4H84+SCNVvMmz0OB4C7QakpPC0MjOqpXgSp4/B61flve9VnBLqzWoOFcjQx6QWS7jny/RoOBNtUGbQbtwCJSXkFIL1uSFmoE6ZAT5G4lqmd229GRynaiOljnc+R2WE802Lnb34T+gGSNuV6BK2d9nnIDMPe+bPjMZSkzSs19Fh09/dum+fM94CyFaoaUJ2hZyAtylPQneR2H6JSvHMTsdPphUNT1GMQyzagB1u+l9Q8Ntc84Dy68XguhaU52mJ/z7mk+h1W0THlDttIO2iTGq0fgbwkrWHokiVEuHgs8xfOJih9TRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgtMCLqyqGK1BODw+TI3oOGUb6f940l4cn1sIEKmyyU=;
 b=eeH6EBtgWzEafmvWonaYp8LeUG023nxwUedi/fkgUB97sHHflIwBOtZAeYBSnHeGvJpFRucuP/EzH7t5HsWpsOYWCD6bA1aI9OWLaYhviLjNpYN2U0WPcz6Z1tLJoIo7uTGExsXkNCVj2q3c2kxU98mhxo59GOyTQK0bD3VsJ9q5tdR5CiqQS8gpU+6ZK6xBgfMxmGwyDwVc0LBcSnx3FySOPcPsPIHppNAJ9uMGGeJtorF5qubSjfqxwm+IqJYBFEk3oLcG7IwDTPbTa/hDEWtwDfkYn4dcWpkufDrVZZAUjuTmayt1Xbv/p5Sx3Ox3roO066P5T2qTWAKFPNp9/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:53:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 21:53:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 16:53:05 -0500
Subject: [PATCH 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-imx91tmu-v1-2-7859c5387f31@nxp.com>
References: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
In-Reply-To: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733781197; l=9745;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nNhwjFBwQVTIDJisSK0WnxFeaeyXNS38R647unJN1/c=;
 b=oKDonfw2+8yyM63EMa1d/vz7hxajUM7XNdK7zgSes1nQEgHo8FtpgzPMgQ3vBPGoQV7wZbdbf
 bUBNxv9PS+QBO3Cq7FOIGonyDXvWMiyXspI2LGhmvX2ciFQuE6Gr8uP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df96c2b-6f5b-4b01-86c7-08dd189bebb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzN2bXVua01mY2Q3UmxIcFplbThrd2hReFQ0V05aMktQU21WTTB4NUl6MkNx?=
 =?utf-8?B?Zlg2UE52Tk9kN1JhVlluQVh3dDdZWTBXNVZiaU5SYWlZVHJ1TWFnZ1JrbDVP?=
 =?utf-8?B?RURIbS9pUVJPODdqMUpGeXFnRnRzRm5mdmFtbXQydVlBdTNqSmx0Z0Y3ZDNC?=
 =?utf-8?B?VSt1M0tIdVN4RWxiRDZqa3lWS3JEM1gyM0FhZkJidFU2czcrdVBMTFRlZmdS?=
 =?utf-8?B?Vk9WdGdDbVFsRlNQM1NVZWpOWlVhb2xaVjdEdSs2bmJyZ0x3enltekJkak11?=
 =?utf-8?B?ZXRuclErVTJTQ0xQRFVHUWtIb2c4VHBWeXJ5emRoZi9ick4zbVFtQ0xBQ3VL?=
 =?utf-8?B?bmkveVNHLzVoYTFLSWxxNE9JNG91TGF6NXk4QUI4VlNSbTM1d0Z4U2tSL3Nx?=
 =?utf-8?B?MmNKL00vNHFkTVNaMm5IVjFnT0FsOXIyVnh6N1hSd2cvWEJrY3RUd2hNdkF1?=
 =?utf-8?B?SFF5TFk3ZjFqMWRRVHBhYlpDZFFDNTVWSmRkeXJYNU4wdDBUL3lFVk4wWjZS?=
 =?utf-8?B?YVYvZjlHdkZueGFDTFJDV1FsbjQyNXVFOUpiQTF4alNwYTdEZHRTNG05MTJa?=
 =?utf-8?B?WWFtRTJsY05lK2NteXpOWDJ3elBNS2RzWk5LRzZnRGZZVFJBK0JhbU80WTN6?=
 =?utf-8?B?YithbHpQMkUzaFE4TmdrZHdpR2FQZjYyeXRJRG5DTVorWVRVNHZ1VUtQbHQy?=
 =?utf-8?B?SUJhYnhaRzZmTGZNSnNaN2ZsRGJYR0VCdlArRUloQld4QmtOVG9jakdmb1Bm?=
 =?utf-8?B?K0JxSytzVkxuUFdVSUJVUlpiSVNpSEVmd3I4QXEweksydTN0QUdlVWwrV0s0?=
 =?utf-8?B?THRJa0MyUmxrQjRyWFh6ZDRlSzZTaC9sT2dUd0hRZ3Y2TjMwdFkxS2tvdmd4?=
 =?utf-8?B?TTI2bms2ck5VV3VZR0J5U0cwQUVGeHpmNFkvaTNvLzNUdlZ2d00xbWFFbGdr?=
 =?utf-8?B?MUd5NFFlYnV2UkR0WndVY1g1QkhpbGd3VmlxVGJ5YXI5ZzJ0MW9vanFUR3ZR?=
 =?utf-8?B?QmEyNU01T1A0am9NWHZUVXEzWjEyM2tBckhOM245MDVOMXFXYys4eUxHYzln?=
 =?utf-8?B?OUlaaEk4T2hCQXVzWWhLMGRFN2E1WU04QndrVUFOQnEvM0VxbW5ISnlZRGhQ?=
 =?utf-8?B?bjdIMWtJZWpDSFFKaGRaQWRsa3l0UWF2Ly9kdFVVRGdqTytMeERzbnFtRDla?=
 =?utf-8?B?RWtDSlhUU05UZXhIb2NDSHh1Uk5XUUlzejQ2Q1NUNG5yc1crYlZBb3pQcVRt?=
 =?utf-8?B?Q3kzQWhsREpQRUYxRkdsWWozd0lsYUhqR1NsWGhJYytaQjU4OUk0cys4V1U4?=
 =?utf-8?B?MW51VkRzd2pqZkpGdlozSjZ5MnhpWFg2QmVjeUJSSWpDSTlSUkR3b25LRXAv?=
 =?utf-8?B?TTJvZDBDUkhRWVZML0lZeUYwdE9yRXpaVEU2VTlsNnR3YUNiZXVFaU5oV01L?=
 =?utf-8?B?cDdwNE5TemZEYVpnZFhVTE5HWlRIV0piQTVTNUcxbFU3clBKQVp0SHZJRXpL?=
 =?utf-8?B?UUlnaU1hZklBM0NERXE2NThCbEFhaEwrSzJ5ejRyQjNSWkF1UnhpUVIrNG45?=
 =?utf-8?B?ai9oU0tQZ2VGU2tQU3Y5RkNJVjNQaVpyQVBrTTdpT1B3elg2SEZZbi85ZzZ3?=
 =?utf-8?B?MGg1RnVBWEtsQmxtbnNLa2V1OG1sOHZrRXFET3U0WjJOS2R1NC9rYzNDR215?=
 =?utf-8?B?VFdjTUQza2lVdjI0czd5Y2V6Vm1EVWF2Tm1NdFNjL1VXVitxbElGSDZpVzZ2?=
 =?utf-8?B?cVRmRHYxMkczbDVvVDZGeGVmdFNIOUN1SnNmZ0x2TWExVWRIWTgyUDZKdVVl?=
 =?utf-8?B?bXdOVGI4WVF2T3pra0hJL0xsdU1QYVVzZlFFQXNsb1FsT1RvcXFpcy9FVWFa?=
 =?utf-8?B?THlnMFJmMDRpUXh2Y2ZBMGpPSlhkTlVhYjZrNGhlNkNjTTJwOHV1RDM1aDRF?=
 =?utf-8?Q?i7f/2jxpAPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHp1cHhzU3hGdkx3N0NyRkwrZjRQYnFUeXhTOENvWGgxKzFZbE90aFFITzM5?=
 =?utf-8?B?ZkNIdEljaWt0ZTZONG9XVi9BeVJnMzNLdWdNWlJiU2l0bEtocE44OVhUWTRK?=
 =?utf-8?B?d09aK3BuenBQVG9LK2NScUd3QjgvVEd3S01oZGZqNFBTMG83SGtvaFMvejFL?=
 =?utf-8?B?R2t0WkowTDBkZERrZDhiSUR2RjQ4WWpvWEt3Q043V1M5MkkwbFkwYnpudExQ?=
 =?utf-8?B?TFRSOXpESzFCQTd6WXNaR0FlWTF3MkJrYTNyTVI3SlpySG9KUlN2bDlrZVh0?=
 =?utf-8?B?aU5ENFMyNGEwM3B0WDFqZXA3RTR6R1RRVTBObWlYVUwwNEtIWW9jUzZnMzhX?=
 =?utf-8?B?ZGI2ZlRTc0xnNHo0STlkYnEzZWczTTFrRzBNTmtDRjVoSVNNbmZGbDltR3hl?=
 =?utf-8?B?NU41REhCNkJJQmdXYk9MSkJZTENmUmhjOGJPMXJtamgyWXdpUHRRc1pOWWlq?=
 =?utf-8?B?b1NBR05Mc3RjUDZaT2FtVUhTZUp4aUZIYWNhVnZKakhqVWpKUzJNRFRTdEpm?=
 =?utf-8?B?a0JDMGR3TnpmcWNZZXpFWlhWcDV1N240MnNxb0JlSE5qNi9kSVJxcy9UbndT?=
 =?utf-8?B?c1c2OTQvd2tnSEoyK1dONDcreFpySVZ3S2ZwdlMrKzMvN2djVHQ3djJONTQ5?=
 =?utf-8?B?Q3d2c2pRWW91eGcvcnJKTmM3aHdvR003TTczRWRnMVRLcU9kZzl0VEhNVFVh?=
 =?utf-8?B?dmJZTktucWw2b29FZFd5YTUvZ3pJc1NGazVROVA5VGZaQ2p1VGRiMGN1bmZS?=
 =?utf-8?B?dGR2VzdBd2x3M3Rya0NOZGdhL245ZVBUdkwwZldJcW9tTWhZN0ZiV3ZxZUdt?=
 =?utf-8?B?VnlHODk3TTBUOWtram53c1F6YjlxWmQrMDhYaEhNeXRsQ3l6cUJFZEY0OGIy?=
 =?utf-8?B?U2lwbjBQamNqQVlOZTl5MWF6czNzclhzb0wxQ0lsNFdqL29UMlBROW5OTlRw?=
 =?utf-8?B?Ukp3NTEvWFhqMTIrS3JRQlI4MjZsYjFqR016SFJDYVVVckZvR09EdnI5SWpW?=
 =?utf-8?B?WkNQZ280cEtSeVFBYW85a0kraGswbll2cWtaVXJiRHBvcDlrbHd0cWI5VUkw?=
 =?utf-8?B?ZHhDTExISXJqS2Mwb0dSWk9pRTlhNDZoS2ZrVWlrMm03OUE1dnpIUEZjbm1G?=
 =?utf-8?B?enAwcWs4R1JIWWMzVWlEcUd4czF3TWx3WDhQZVR2bVFFWTRXTTJlRWwzMnJY?=
 =?utf-8?B?Wm11clpZTVdrbjllRngrV2xjRzlSY1N2SVJqV0RuOFVwV2EvRGg2NVBCUjMy?=
 =?utf-8?B?Ui9jRTNOMmw5dnl0S21DNXNsMzFJczhnNmM2TDZkSWN0UnFlM0poT294WTZ0?=
 =?utf-8?B?cEJNYWNSdlI0bDZ4WVA4clJNaGYyYVV2QkxuOGhNcXB5RzRHeWxPdW1VY21N?=
 =?utf-8?B?SklxemExeldncDIrcGFYMm9sMzAxYTE0Qnc4Vlh2Tk1yOFBsRFJrVi9BQ2tG?=
 =?utf-8?B?NHJHV202NDBXdzFpRUZxMDZsNGx5b3F0WGJQSGtCZllzYkdld3J5QmZBQStO?=
 =?utf-8?B?V1h2OW1zU2FweG5RSjJDQWs3OXBCUy83L0VMd3RVTndkdldJTW1LalpFYmFJ?=
 =?utf-8?B?VklRVGE5ZlpIajFUdlRZVk0rcW50eHVLSmVyM0JHL1F1bzNNeUpMWHlRL3hC?=
 =?utf-8?B?OGNvYzYrN1dqVFhXd05ZMGtoNEFuYmZVN1UvaEFHVUEwOEhlOTdGWVd2Tk5T?=
 =?utf-8?B?K0QxYjR6S25GSHRUeUM5T0pqUTc1WlVTQ1pqUWF3RVZxQkh0enVVeXh4N216?=
 =?utf-8?B?M0I4UjNLdCt5OHZSM1hPZXg2c25vbkxQc09RZU4xdmZOangrQXJ2aTlHVkt2?=
 =?utf-8?B?ZGdMR1Ard3JDMWprZjVSbnlKanlRajkxMlZWd29VRk84aXQxUDZ4TmwrYjFP?=
 =?utf-8?B?cVdYWUt4OGNJQ0ZtaVE3c0pCb0c2K0NXdXRaVmdaV1F6WC9FTjhjeTBneFh6?=
 =?utf-8?B?L3lxeXhUKzNZRmZOdk5nYThTOWY1ZDlmSjR5blpYeHUrcTJrUkZqZzNZRG5U?=
 =?utf-8?B?SmFGOExiTFlTRnRFa3l2a3pNTTdBWG5LVDhRKy9HVkR5VUhuZ0p3djhNTDd6?=
 =?utf-8?B?TlRTQ0lycUZtUUdZQnlFQlk3RnQ1ZHJaMXR5dXRhOUJSeGs2aVFnUUVXZWRL?=
 =?utf-8?Q?VSoc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df96c2b-6f5b-4b01-86c7-08dd189bebb0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:53:31.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRFnw2C5Vy9xp75nQVlQ4B8PAnqI720i5vepGNA2E4lbgZTHy4aBFQPTBWJJfEY8iFV5U9fmsAoINxZ9Le95YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818

From: Pengfei Li <pengfei.li_1@nxp.com>

Introduce support for the i.MX91 thermal monitoring unit, which features a
single sensor for the CPU. The register layout differs from other chips,
necessitating the creation of a dedicated file for this.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/thermal/Kconfig         |  10 ++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/imx91_thermal.c | 281 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e71..da403ed86aeb1 100644
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
+	  Support for Temperature sensor found on NXP i.MX91 SoC.
+	  It supports one critical trip point and one passive trip point. The
+	  cpufreq is used as the cooling device to throttle CPUs when the passive
+	  trip is crossed.
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
index 0000000000000..19c4dafe9c7a9
--- /dev/null
+++ b/drivers/thermal/imx91_thermal.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define CTRL0			0x0
+
+#define STAT0			0x10
+#define STAT0_DRDY0_IF_MASK	BIT(16)
+
+#define DATA0			0x20
+#define DATA_INT_MASK		GENMASK(14, 7)
+#define DATA_FRAC_MASK		GENMASK(6, 0)
+
+#define THR_CTRL01		0x30
+#define THR_CTRL23		0x40
+
+#define CTRL1			0x200
+#define CTRL1_SET		0x204
+#define CTRL1_CLR		0x208
+#define CTRL1_EN		BIT(31)
+#define CTRL1_START		BIT(30)
+#define CTRL1_STOP		BIT(29)
+#define CTRL1_RES_MASK		GENMASK(19, 18)
+#define CTRL1_MEAS_MODE_MASK	GENMASK(25, 24)
+
+#define PERIOD_CTRL		0x270
+#define MEAS_FREQ_MASK		GENMASK(23, 0)
+
+#define REF_DIV			0x280
+#define DIV_EN			BIT(31)
+#define DIV_MASK		GENMASK(23, 16)
+
+#define PUD_ST_CTRL		0x2B0
+#define PUDL_MASK		GENMASK(23, 16)
+
+#define TRIM1			0x2E0
+#define TRIM2			0x2F0
+
+#define TMU_TEMP_LOW_LIMIT	-40000
+#define TMU_TEMP_HIGH_LIMIT	125000
+
+#define DEFAULT_TRIM1_CONFIG 0xB561BC2DU
+#define DEFAULT_TRIM2_CONFIG 0x65D4U
+
+struct tmu_sensor {
+	struct imx91_tmu *priv;
+	struct thermal_zone_device *tzd;
+};
+
+struct imx91_tmu {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *dev;
+	struct tmu_sensor sensors;
+};
+
+static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
+{
+	if (start)
+		writel_relaxed(CTRL1_START, tmu->base + CTRL1_SET);
+	else
+		writel_relaxed(CTRL1_STOP, tmu->base + CTRL1_SET);
+}
+
+static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
+{
+	if (enable)
+		writel_relaxed(CTRL1_EN, tmu->base + CTRL1_SET);
+	else
+		writel_relaxed(CTRL1_EN, tmu->base + CTRL1_CLR);
+}
+
+static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	struct imx91_tmu *tmu = sensor->priv;
+	int val;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout(tmu->base + STAT0, val,
+					 val & STAT0_DRDY0_IF_MASK, 1000,
+					 40000);
+	if (ret)
+		return -EAGAIN;
+
+	val = readl_relaxed(tmu->base + DATA0) & 0xffffU;
+	*temp = val * 1000L / 64L;
+	if (*temp < TMU_TEMP_LOW_LIMIT || *temp > TMU_TEMP_HIGH_LIMIT)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tmu_tz_ops = {
+	.get_temp = imx91_tmu_get_temp,
+};
+
+static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
+{
+	struct device *dev = tmu->dev;
+	int ret;
+	u32 trim1, trim2;
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
+	writel_relaxed(trim1, tmu->base + TRIM1);
+	writel_relaxed(trim2, tmu->base + TRIM2);
+
+	return 0;
+}
+
+static int imx91_tmu_probe(struct platform_device *pdev)
+{
+	struct imx91_tmu *tmu;
+	unsigned long rate;
+	u32 div;
+	int ret;
+	int i = 0;
+
+	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx91_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->dev = &pdev->dev;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return PTR_ERR(tmu->base);
+
+	tmu->clk = devm_clk_get_prepared(&pdev->dev, NULL);
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
+
+	tmu->sensors.priv = tmu;
+	tmu->sensors.tzd = devm_thermal_of_zone_register(&pdev->dev, i, &tmu->sensors, &tmu_tz_ops);
+	if (IS_ERR(tmu->sensors.tzd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->sensors.tzd),
+				     "failed to register thermal zone sensor\n");
+
+	platform_set_drvdata(pdev, tmu);
+
+	/* disable the monitor during initialization */
+	imx91_tmu_enable(tmu, false);
+	imx91_tmu_start(tmu, false);
+
+	ret = imx91_init_from_nvmem_cells(tmu);
+	if (ret) {
+		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
+		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
+	}
+
+	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
+	rate = clk_get_rate(tmu->clk);
+	div = (rate / 4000000) - 1;
+
+	/* Set divider value and enable divider */
+	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
+
+	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
+	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
+
+	/*
+	 * Set resolution mode
+	 * 00b - Conversion time = 0.59325 ms
+	 * 01b - Conversion time = 1.10525 ms
+	 * 10b - Conversion time = 2.12925 ms
+	 * 11b - Conversion time = 4.17725 ms
+	 */
+	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
+
+	/*
+	 * Set measure mode
+	 * 00b - Single oneshot measurement
+	 * 01b - Continuous measurement
+	 * 10b - Periodic oneshot measurement
+	 */
+	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x3), tmu->base + CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x1), tmu->base + CTRL1_SET);
+
+	/*
+	 * Set Periodic Measurement Frequency to 25Hz:
+	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]. ->
+	 * PERIOD_CTRL(MEAS_FREQ) = (1000 / 25) / (1000 / 4000000);
+	 * Where tMEAS_FREQ = Measurement period and tCONV_CLK = 1/fCONV_CLK.
+	 * This field should have value greater than count corresponds
+	 * to time greater than summation of conversion time, power up
+	 * delay, and six times of conversion clock time.
+	 * tMEAS_FREQ > (tCONV + tPUD + 6 * tCONV_CLK).
+	 * tCONV is conversion time determined by CTRL1[RESOLUTION].
+	 */
+	writel_relaxed(FIELD_PREP(MEAS_FREQ_MASK, 0x27100), tmu->base + PERIOD_CTRL);
+
+	/* enable the monitor */
+	imx91_tmu_enable(tmu, true);
+	imx91_tmu_start(tmu, true);
+
+	return 0;
+}
+
+static void imx91_tmu_remove(struct platform_device *pdev)
+{
+	struct imx91_tmu *tmu = platform_get_drvdata(pdev);
+
+	/* disable tmu */
+	imx91_tmu_start(tmu, false);
+	imx91_tmu_enable(tmu, false);
+}
+
+static int __maybe_unused imx91_tmu_suspend(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+
+	/* disable tmu */
+	imx91_tmu_start(tmu, false);
+	imx91_tmu_enable(tmu, false);
+
+	clk_disable_unprepare(tmu->clk);
+
+	return 0;
+}
+
+static int __maybe_unused imx91_tmu_resume(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret)
+		return ret;
+
+	imx91_tmu_enable(tmu, true);
+	imx91_tmu_start(tmu, true);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imx91_tmu_pm_ops,
+			 imx91_tmu_suspend, imx91_tmu_resume);
+
+static const struct of_device_id imx91_tmu_table[] = {
+	{ .compatible = "fsl,imx91-tmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx91_tmu_table);
+
+static struct platform_driver imx91_tmu = {
+	.driver = {
+		.name	= "i.MX91_thermal",
+		.pm	= pm_ptr(&imx91_tmu_pm_ops),
+		.of_match_table = imx91_tmu_table,
+	},
+	.probe = imx91_tmu_probe,
+	.remove = imx91_tmu_remove,
+};
+module_platform_driver(imx91_tmu);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


