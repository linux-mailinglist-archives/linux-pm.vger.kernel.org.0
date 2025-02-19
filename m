Return-Path: <linux-pm+bounces-22516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E2A3CCD0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A83A717F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9925C6F8;
	Wed, 19 Feb 2025 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jF3V5LZl"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51925B69E;
	Wed, 19 Feb 2025 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005787; cv=fail; b=jNNnxER1uSOeStmss5P995x4O9xoEhjaMV/vnWpMe+iDKY3frOTBSWkgpM4MX/+YAaulejxahxdXf0fe8/WkSRbat6ILQdCAW1oyI60Y3zL4V7Vnx0Ip3INLxON2ITx0mQLUGGMNoq29KlzMkqNpQfhu93NZWQMickUreXFGtmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005787; c=relaxed/simple;
	bh=BEucYzbZxWUGU9S4l0VB5a9jcxliPYBfbRtXLrc1nUs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RAoaxVbR32F97327jnSsfvg8AjtE5unNDlPoUX8sWSj0OYBO6Olx0YEL6gBgy52bVhGfZ0XSYz5Zjh98wZgWJ8SVF48verS+OqjRKEiKDyUejeKL5cpi8r9FPWwX0T/jHZmXPQWoJi9KLuaqDmE60JXCUnL5ArkKgtlKUDkbf4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jF3V5LZl; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY1w21Rv6uSGh+Bsb1piF3b9evXQNxqKZgAs/pQ69eNg7+dMnzGn8DQ7z+LBWuJyj87NeJF6EMRq/ae4EEZErIc77Serr5zKdaFpwOaJO6RFJHVOyddoBa7IBg3+mubNVUCD2dhfjbl8JTNkl2NmenOGIshcMOO5COwARAhhpofHGrj2jh89JUE4CsmGSEKqFzW4k9cn5/NTJEEWA5U7QDVaNfsFI8rL3V02Bt1EK+zTjIFqEQteAklfMRA6VFUYngrjgn9CCnsvIh4lLT2km91ApSNiiOwfY6nKiVQV7vQXDfGqXI3kBqS0OU9NmugySG7IBBW0OvNQ/LhSR4Goqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sQy6RP37N5DItN0jZmXVqQOx+o2I5IWnuXAaMnsVFk=;
 b=VkpbTe6WNyzafEQll7ztWZk7K4GWsZoZlJozdj/Z78c1EIo7/tj97RNYLG77LQsIuTFAyEGz8Na2bWOYCcLnPtVO/R53dSF/heazz1hgpDfqSW+VRLHVbZRrO2c06ztNBJfh+vVm/7uKxBXFXenqOmZJHG5vKmzjavrBJ+30JpTr4cztsVyQHWsRDnPkkwuXXMxm9ZJfoM9h2EmDmjWnV9mIWepwCRlo0cVcLSdZqrNkK0Z3ylrVf/VIpWgpgdfGl9hzibPAoCUc7s2lqmzMBt61ynv5fvPdduyEXvQszIz+3lUIPdh303IayJUYo8Sg9nXJYbWOJsAubWpUb8z1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sQy6RP37N5DItN0jZmXVqQOx+o2I5IWnuXAaMnsVFk=;
 b=jF3V5LZlU+mNzqdXOHhrydeRZoI1C1lAXmXId1xbA3ABj7iR6V1yMo1+Rm4JCgAZdGHXmhaBxP4vX7VS4pDF5J0P+S2dJACC3+CSBAQxQ8kh/kl6FByJqnSWt6pxu28eINfublQa05/gE8KKyYSLLdRsnto9sQvcKT0k5uaMGcqHClkKj/7vQDkbVHjPGVWPiTsm6kFSlSaIVt8z4ykcs7bD8BmbBJuC6OlA5d77NdrmlzpUTqsC+KmpUyhna8S9qiWDuGVtTPoD9PRcIAg23zN/1EK7qT/WUyvjsHx9PloksdlQmjYztJPnjvmdA+jwkTKoRmiDrzVXYgXJ4U/aWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 22:56:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 22:56:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 19 Feb 2025 17:55:53 -0500
Subject: [PATCH v6 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-imx91tmu-v6-2-7af2281bcada@nxp.com>
References: <20250219-imx91tmu-v6-0-7af2281bcada@nxp.com>
In-Reply-To: <20250219-imx91tmu-v6-0-7af2281bcada@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740005766; l=15172;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZmDXRbH6wNI0VwbN7e+E+vQyFtq4jtjbaOSLMJUl0ws=;
 b=6DgK9+PaxHTEeLvY1evX+oX/iZ7VLFhPwTP7cD5saJMDDYqNLeOx0XKqblz8N8D9ILgwvGUfT
 Ni3h+l7d9TXA1jyYYrOJZdtU4Rxx+GhEDu4Jslr0hP5ZflQtxqNb0KV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfe2e5c-f6e6-44ef-9fb0-08dd5138a15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHBkRGg2YWxYYjN6VjZpaGdjNXd1ajZZcDVJNDVRYzE4UmFibHR0cHJsTncz?=
 =?utf-8?B?SzYzZW93U2ErM1ZpNVd4c1VQRnhhdC9hT3Y2ZXlBbnpmem9VRXVjYzhOd1Jl?=
 =?utf-8?B?amNFUkVnTlVWM2RjOEwrbmRSOUxVd0VHKzdrR21LWmVtUlpGZkJzS3Rpc2xH?=
 =?utf-8?B?aFp3QUw4bXFPcHUrRmhYdDZPTTFSMk0yclN5Mi9CL3k4VEdhQ2wxNExQUFFD?=
 =?utf-8?B?NlhjaG0xTjRmWUU2N3p4SVlXYXdjWUpML0VVY2ovWEJScW5EM1Y5dk4rNkN3?=
 =?utf-8?B?STVPRXcyR2ppN3NJWDdHUm1Gckwwck8rTlpBOGx0OGJ5VUQ0OHNjYko1Nms0?=
 =?utf-8?B?TGtuaHQwMWNqUVVqdnprOXY4OFovMlBhS0hqL0FuOXlZNk9saWppaVpxR0dZ?=
 =?utf-8?B?U3RzRFJObG91TTFmZllBZSt0U0hXTUhWam5seVNzanBpTjNlL1Z1cHNiOW0y?=
 =?utf-8?B?Mnc4aXkzREd6blFiRnBkRXdNS3c0VGxxbGdjektmQUpLOEZMbTR3eUt2Mmwr?=
 =?utf-8?B?NDR6SjFic29IRkhDMUJzNkpBOWY4Qm4vNE1jay9mMmUwdythaThhSFlNVDNX?=
 =?utf-8?B?dS9hUEFtQWFuT3NMUUVlRGtxRCtHYWU2TG5ld1g1OTFDYXJUSC9JRURMak5w?=
 =?utf-8?B?NUdTMEtSR3dIa09lT0I3YVFaSklBT2JZZ1hiYzRGNUU0U3BTUEhqUzQ2eEpB?=
 =?utf-8?B?TDM0MUl1TDBpV1NoMjI3MmNHQjd6MkRzaXZXSStkTHcyU2owYTNJakR3bG9W?=
 =?utf-8?B?K1Q1YnRlbno5bXZsY3NYb2hvTUJ5K0FXV3I3SzhkWUVEZ1E2UUdNZERBZzNJ?=
 =?utf-8?B?Q2VsaFh2ZHE4b1VwSFdGR2toaWQzZ045YXBMRGF4K1B2aUVPc2lXS01NMmY5?=
 =?utf-8?B?OCtweWwwWThxUG5GbFVNVnRFNUlwK1dYY0F0aDRtclFDSTFHNW5xWmZxMDUy?=
 =?utf-8?B?OWxabG1FODJvVXpjNStOZ1NUNjk1RTlDY0RDekdKdE9xdGZIQ29qVGdLd0Q4?=
 =?utf-8?B?c2QvUzUzZ1BHaDZic1JUdFRYaCtlWVYydkpnVmlrRG1DeDVwbXNBNjkzbkZw?=
 =?utf-8?B?aEwzRThiQmw0dVlPTmE3RUF6TU01NGhCQUVmNThDRTg3UzZ0a2xtVmpNQldE?=
 =?utf-8?B?alBIemJmQ0JRSDJsRTJKRjY3elFZRG9kOUR4eDBna29LS3FaZzRXNWJEMG1Q?=
 =?utf-8?B?cUVRUVBmeEFkZGtoL1VNSFRaRGR3aFZGZ09LRCs3cGk0Uy9GZlBtUmRvOWx2?=
 =?utf-8?B?bGNVYWc2UEc1OS9OVGhVS2JqYWlFeERtVkdRNzhWcjdnaEZUUDEvdWQ1R0Vi?=
 =?utf-8?B?K2phSUJac2cvNVo1Ylo2Mkw3UWFrR2dRVXdBUjY0VkdrRURtaXJuTTZ0U3B6?=
 =?utf-8?B?MDh0Ykh0dTVnakdPSTg3VU5TZjN5SVl4SEFhNmcvU1dudENnZVY2amhaOElR?=
 =?utf-8?B?dmZ2dzV4RW5yV3FDVXN3REFiRGdSVmRKMnM1U2dOeVNmZGhlL05oRnF0S011?=
 =?utf-8?B?R08zaVBDYVhCQ3hqdXJ2NGx6alFpZUQrM3BoQ0RCS1UyRGtaYldMOElIUnpa?=
 =?utf-8?B?SUMrWkxVYk52K1dqY3JrTjNyYXhGVDM5bXdmVEc2RjFVdGdVMnNjS1Q1UU5q?=
 =?utf-8?B?VlA0U0xGN1JZbjRtb3hqd25BTE5tOWV5a0NoZU9COW1nVy83ZjlNMHNlZ2xK?=
 =?utf-8?B?eW5Bc2pTUmlXK3V5NjdmZURVRHhyTkNFbGVENjdEWURPRVFqejU5eUNRQUw2?=
 =?utf-8?B?OUNwS0duTmNPSmc5elFqMDA1b1lkQkI0RHAzRW05L3pGTExpNE1DL1QzZDBm?=
 =?utf-8?B?d1B0U2VDVUxnSjU1YnZDcnQzK2hpWGZtNVlOQ1lMUVdQUkRyYkpCZUlkVnlw?=
 =?utf-8?B?MHdud1BwQktVVW95aWFJdThualhOd242OWk2UkZTWW80NGxGdkQzbWxEVFNl?=
 =?utf-8?B?Yml5MGFsR3BYT0NmWEoyZ3RIZkZxRXVJSjhlclhJajM1Vkp2bUNyOWRRWmZ6?=
 =?utf-8?B?eDhXdUVvdGN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0ZLbVhyNGFsbXRJNlV5S09qWU5MSThjVy9FVXdpZWtTQU1STms4eTIwU1pR?=
 =?utf-8?B?NzJrVU1qWENHbGlGdnA4azZQVUN3S0xYQlV6SHpKSkVJR2dEOGc5VzgxR3lj?=
 =?utf-8?B?L3ZmdHJEeEg2MURnWFFFRFo5Q2xpMmZFbGFtcTRZcFF4Y0FYci9PS3NYRjYy?=
 =?utf-8?B?ZDVRQmhBL09TQ0JIcXlvcWw4RE1oc0lGTWYrbUQxTzJJc2pmRDhWeDIxNnZJ?=
 =?utf-8?B?ZGFwZ2EyZE5uRHdEc0lOTVYzZDNobVV3T1dvV01IUHdQMUVmdmZBMDhYWGda?=
 =?utf-8?B?cHZFdHBnRG9DUjk0eEFoTGtCM2xhMmp5djg2Ym5hZTFFalBPclRXOENZR2dq?=
 =?utf-8?B?TmtVblUrMnN3T0FwTUpKNmVvS0V5VFFMcmU5RHFmbEs1L0FONFR2MWEyU0V2?=
 =?utf-8?B?MXFZN0tlYWlaZlZhdGdpUTgwaERjUldleGdFakd6M3F2WVZDN3lHVzlGNDEy?=
 =?utf-8?B?Zkw3aW96OUNiaGE4am9QenNJekxlOFZzTmlrS3RBWG81L2xUY2RmbUxvblk4?=
 =?utf-8?B?SHZkSVo0TGFCZC9GcXhlS3JmL2ZsSEExZGdET3dqc2RvLzR3dGppdHQvY1RJ?=
 =?utf-8?B?c1NJS0ZuMmpLQ3prKzBDN1VNK09Oa202V0lTcFdkekJseFczWVpXV3lJQzJH?=
 =?utf-8?B?YTR0NGpxallSd085RXFHdHlHQmxnSnRTWC9NNjk2M0xkQXdNeHczVkVqRWRN?=
 =?utf-8?B?bXgvZDJSUjhDdmJSR2pIU0w0Y3FYVEllTzZaTDZwcEJSM1lzS3N6K3p6b2ps?=
 =?utf-8?B?TnlZallWZmdKdk9XN25mRUNWYmJHdXhnRkRkODdNWWowZ1craXpjcFlubmRX?=
 =?utf-8?B?cFNibjlRMCtRSjNKazlUTWJBNEVMa3BLWTRoS0hzdlU2d2tGUUw2bFZNVFl4?=
 =?utf-8?B?NzRlalVaSnJUYVE1alUvaHM2NnFBT1VYa0w2dHloZDVOMEZvaU8weGtuazBT?=
 =?utf-8?B?MmtoQXFOR0w3Zm8vMzdyajg0Rll2TGo5TkZvdXJQbWMwM0hDZEFrelZnK29E?=
 =?utf-8?B?WWhEYnNiSGRxdEFySUs3U2JnMWJMdjBOcUdXNmlFTTZONDhiRzdxNHdFQUNw?=
 =?utf-8?B?OU16YXVOSTZ2L1ZwK1VaMUxlbVBQV2Ezc1VFU0FmczBrVTNObkRDbnJmYWcx?=
 =?utf-8?B?NVNuWWFDZ1JhbVZvelQvZkRPV29PTzlWdHNWeFdQMGFXbmNSM1c5ZkZwUGFw?=
 =?utf-8?B?RC9ab21OdkZwQ1owZHRXVE1xZURGMDNHYTFEb0hhQ2xQYWZQTy9iM1RsRjh2?=
 =?utf-8?B?N2p2SDBNWGRRbUlqQkx6OHhsUG1oOTJPTmJscFJDWTBOTm1GM0h4b0F5T3VP?=
 =?utf-8?B?ZSs5M1ZLK1Q0UWdyUy9Sa3NPWXBoU2Q2SnVhbCsyTzhJa3IyNWo5dFRDYmJP?=
 =?utf-8?B?NjZGRElDMzM2RzNEaC96TDJMYjI5S25NQWFOU0pkdmZQTG91b3l2b2sybWhF?=
 =?utf-8?B?aFA2Mk9zN0s5RGdnZ2JuYVFLeHlaSVI1aHJEOEN5QmdwRGl3d1NtSEZJQkhG?=
 =?utf-8?B?dnk2R05IeWpiRkdKbTFJZ29ucURiUWErUE5LVSszUHZaNlJ0TW1ocUdhV1pZ?=
 =?utf-8?B?ZmdOeHFEQ0JXWjg2MTMzaHhoTERSY3NrS3BuMVcwYWZoSFB4MktKcjlIWGNz?=
 =?utf-8?B?TFUxZXg3V3pjcFRTTXhsV3lGR3pTZGgrbmJDQVA2NHpYNUQxUUI5Z0toL3hR?=
 =?utf-8?B?S3RTcDhhOHZYb0RMVmJNZUJZMGhWNElpdGNvQUVsbDh3R0pqUFpiMzAvSDNW?=
 =?utf-8?B?VzFRaUY1Q1FiSXRwMk4xYUN1VllQaDVONFl3d3QxcXE0NXJ3SXZSZDh0YXJz?=
 =?utf-8?B?OC94aUVBYzV2KzJvcjE5VWtnU3ZRcEl0N0pMUzFta2xNVzlsOWJldVBvc3Vs?=
 =?utf-8?B?ZDhoQXh3V1cxVkRJSWlHVEFkQ3JycGtwTzFxbW8yeG1qNkhLbHpxVUZXa1hM?=
 =?utf-8?B?bGY5Z1R5am5WVVhLclp2cmg0TzQ2S3hURC9JbjJlL21PMEN5ckFsTXBkakdF?=
 =?utf-8?B?cDJwOXFLWWYvOVN4cmVxVDdIaFM3OS9HNFl5TzFYbGZlL0tEbnFzWUhXZUZW?=
 =?utf-8?B?YzVIZFhIeWROMzFZMk4wSXp2ZnlWTG1nL0VxSkFpRmhiSnZYckZKcWhvNFZn?=
 =?utf-8?Q?rLDDYMYnhxT+yLPjuN+vh3taE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfe2e5c-f6e6-44ef-9fb0-08dd5138a15d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:56:22.6279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbTsHkM/IYeXxWvC1H+9lq5QwuILq4/tQyZu7aW0t+ciITg83cJwqqiPWsn0Oi1plt8QWKEwqskqu2eIVmUKhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9251

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


