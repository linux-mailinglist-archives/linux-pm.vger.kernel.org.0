Return-Path: <linux-pm+bounces-32519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B53B29DFD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB023B0043
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D730DED5;
	Mon, 18 Aug 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hUp0Cpk0"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA72D0C67;
	Mon, 18 Aug 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509623; cv=fail; b=UVODr6KgxM9JFAgrrgaDJpuOsK5mZZBlKhbK0rCuFlKizKT/N1nUwVsaOVHK2K8nCQbwTG2qLY23r6344VEig+7PPEGPK2R3/LIzRuvrOeMb/wcRJ5x1A1lycwi3l2YQc3PSfM6S43ViVQhXXiQo0oYFN97sh1gDV27xxJq0Da4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509623; c=relaxed/simple;
	bh=kZ8TG+wjdpP1zOI2nGGmMYZGt0b+cKZtxO5mjPFG85I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CMw6maZ4ttrR4G9ygI4m3VZTpfRDqZKEK9nP+iTFng6Wbv3LcbndbkCH32yoW5zO9WQ6NhGLhumd3+wP/BioFjCNpnZeBUN9VDqG6mr5HUJ2jBwglhCkuqN8U/wEqiZBWNRJvvWfd0Ht+R+ZtH0dVchAGlbZ0T+AK6f1fCjLupo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hUp0Cpk0; arc=fail smtp.client-ip=52.101.83.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDf7U7jhYKPwISoaaXEgAyiZ4vgva+HUnPEwtl1zxLo5Fpm6IBZHlOy2wvJrpfD4x8j8oxCjzuwbO3QpnzvEoeDieHGpy23xhWodrxnG7Q6oehe/D419d3ea4awSN68APIvFoa1rFzR37L3hUfIkJclD8EKRNIujHCuJeXOx40eoElWLTx+afQXeO1VmttGZIauqbHCzik7ArIH45U8oNlai3USCvmFm3py6wGDcvfJUmVg36ksq3zCa0JJnWGr2a1R7ZZMKYDjVWBiUbYhSGPCn6xyqByFYAc2nwvq2QgKxrMbaL5pgAccT9qjp74joZkit7ESj4LZsZBXyUR7jeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mHxUPyEvPiMCYnQCkCjxJA3TOrx6AJmpookKgFzIUI=;
 b=kYkAkPt1lDOkKbW6a/TPnd718hRz/K4SCUOjPwbt/Vkmx6IPb717nbUsTiJRPu3pZ/odaMbr32ADNCm8mIh70Ew8O9KS2POEG69bLqykc5F3ADQSw/fNkzVAOgCUKDsPLZH+8wmjB/zYYxOAfrCQ1nKCFaAzhqrcL5V9vsh9/o6DLDXhESty3JD2zg9hGoFD7KkZDafAs4eBK6PpdVQ/cYANd1uWHkEY5tLduTU5/9ibL6fp0qDWJetlSZZcWMYWkXgkofR/5vVrRV9YIEYbZBE+w5wWXLXsc7R2eHKgWpMcMrnuvP1K7KPzvGsP9TqEzIfyH8tCV/kyngpOmdzszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mHxUPyEvPiMCYnQCkCjxJA3TOrx6AJmpookKgFzIUI=;
 b=hUp0Cpk0lnNzGT8pw3pL4pKf/bcWSvtFnkN8ZXBe9fmUKrUFGJKGP7Qvs5Ek2qegmEi4hJS/c4tJPO6/GcWZdZw9VKsrncj3v0UHlNQ1lQxE/rKUOUqhXlpfYuD516rLwPl/xp1eCWji6luzf5tV5VVVeDKAxQBY59q6vJYTc4VluOTdDH43vTPpCnV9g3JJrwfXNs5fTqDv1aRmLmquChyjXKYMPOcSqW3ko/ulBln3xbXCdL40sk4zAoBofjBXFKgeckPMF1h4mWuI5dRmC3VJKMLJUa5Lukj2scFV3EO5/nKMgKKeHbXQz9DBv98HlMCFIqT75dPrNjGsl7Nrig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.9; Mon, 18 Aug
 2025 09:33:37 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 09:33:37 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Mon, 18 Aug 2025 17:33:12 +0800
Subject: [PATCH v3 2/4] thermal: qoriq: add i.MX93 tmu support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx93_tmu-v3-2-35f79a86c072@nxp.com>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
In-Reply-To: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509601; l=3136;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=kZ8TG+wjdpP1zOI2nGGmMYZGt0b+cKZtxO5mjPFG85I=;
 b=Edpo9pbQa2eoplrgn9Xx39S9Dn0oWBUeZIFZRjMjltS2EGNx3wQgy+D6iMcdAk9/FUFVoCjtq
 //LLJqsoDriDC3NHDOmqPnTtJMn1VnaoD1Ph5eEkZH9HjU8r7xxs9ok
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7a6149-1172-4c06-95f3-08ddde3a4f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzVwbzk3aUlsQUxYRnFibmpLUHlhL1Y1NklvbWptallTSWs5R0tCKzBSd2ww?=
 =?utf-8?B?bHVmeU5KbkV2WU05VGxoZ2lIUnMxNHZKdHhNQngvcThsbWVFNmg0YjVPSFNR?=
 =?utf-8?B?QnRYeGx2bVRtSndJbUVyUnlkZGt2Rm45Vks2Ukc5czRZeEFpUWZ3Qy8yQ0dq?=
 =?utf-8?B?M2J1Z1dvV1Mydkh4ZWpWM2t5ajFiSGorR0I4Qmw1V1g1SFcxU012WGVqN2VZ?=
 =?utf-8?B?MXVFL1duWHJzYzRWLzhnUWZmbUg5NGZRTjZGWWxEMC8xb1BILy9wMURKUUJr?=
 =?utf-8?B?dnlBQ01lMGNLWEtmMlhCTkJNVklEYWcwUkV1UjJWbW1HMEVkNU0rUVpsVmhB?=
 =?utf-8?B?cXRFV3NvN2k1eGk3dUtSdEZuZHRFcFdhZmF4N1psVngzOEI4L0dzbHlUblV5?=
 =?utf-8?B?RzdvSFEvWDdPdGlwYXN2SnlxQ3ZwbFlQWG5LK011TzhkU2xqZ09TYVdCbGVn?=
 =?utf-8?B?cmQ1a21RRjBPMmFlbzZUOVYxWjZ6NUlBRGhxM3dzUHdwaVg2Rlg5L2dPanhZ?=
 =?utf-8?B?QUhjR0ZBWFM4UzJ5QTZrSWVPUm04WnRZSWluMXhUZjNzaVlnVGRnMlRobzVG?=
 =?utf-8?B?STV6em9MOEpzYlVwM21ibWNUVXVGZzVqOTdjMnlsai9VWjEyNGtTK2g4MzVZ?=
 =?utf-8?B?aWRHdTQxaUFMUCtIMzdpeTgrL3VPa2RscGR5K1JKM3ZjMTRwTmFGaHFta2hv?=
 =?utf-8?B?V2NBbEphdzZkUnA5b21IalNSMXErOWJ3ZTFLcGEzSmRLZmtZUDJFVnVzUVJX?=
 =?utf-8?B?TWpXQnFRRnlwVCsxOVQzeGFqeHR1cGhSVnh6aElaN2RWVkxQWXI4clZYOWVB?=
 =?utf-8?B?a1NKZFpOT1VVQ1psM3lTR2tCOWVpR2pEOHhhM2pGOXFheFdwTlpSTW1XQTdI?=
 =?utf-8?B?ZjNhbFNUSm1OeDFYVUdFMENNRVZmV0w3blNJdTVSZnRLcU1RTCtSaUR5WHFx?=
 =?utf-8?B?NEZhSGYxdGlJanM2TkJXT2R3eHAxRXA3UnpZUHY3bUZsVktmckwvazVFcnZG?=
 =?utf-8?B?U2ZSWVlzYUVtZ2t6QmpJMWZQditvYlNuQ20wRlB1THdnS2w5UFRaTytzZDI0?=
 =?utf-8?B?Yjh4MFBUNkNLbCtWTmVmSXp4aGtKcDB6ZmVLcWRWUzUyaEZLaTYwSGFwWXRH?=
 =?utf-8?B?TXNtbzMwb2lPbk1VcGVhaGpRMXpqeENUQzRPWUtteXZ3SXlWdTdVaGZycVF0?=
 =?utf-8?B?SzJ5YnpjcndWVGpBOFFVMkVYVEJYTlhBVHlUZUhscWJpbnRWWlg3eGlCYW1B?=
 =?utf-8?B?akVYQkk3UVhTaERVTE9ZYnNpOVNSVzJOejdUY2JuSkJib2h0M2JCQVdVekRq?=
 =?utf-8?B?MUlVeEFHQ2dCV2Mrbjl2WFNxdU5tY1ZwQU1QSTJuVmdDZFgrM0RySzBIcEhX?=
 =?utf-8?B?eFlXZ2V0aFErWTBBS1NKeFB6OFA2RWNSczZHZzFyTHFEMlBmQzBNeU9Vbitq?=
 =?utf-8?B?UHg2ZnFtazdneWEyTE1CZk4wa004Y3hTNEl3QjY4OHI3Njhqc1BGMGZqY2pY?=
 =?utf-8?B?ZjNROGV4YUN0ZWxQSzFZSllzczQ4L2p0QmswVDVBandGZ2ZoTnVvdDNLT045?=
 =?utf-8?B?cWhaNUFHak9kUlA5UFR1a1ZGenJmblFtVndRT21jOHdDU0RqY0RkV21KUkJa?=
 =?utf-8?B?YVJoMmRyL0NTRE5BUDBFZEVwQ3FHanJyTlhLQmFNTXg5eFh4bjc1Mk1MU1VJ?=
 =?utf-8?B?TlQ1K21NT1pvcjJCdSs1akpmSjl6akI5dWZnNzJMM1BKblA0ZnhnNFVXcHJx?=
 =?utf-8?B?elI3b1Z0aVRSdlVSU1g3NE85TnhEZ1RyQjBIMHd1Nzd0VEdHL1huWit6NzZo?=
 =?utf-8?B?SzhGbUlOMG93TjY2MFYvNG95cTFzUzEzdFpFb2IwbEl3ekx1OW5hejZKS09p?=
 =?utf-8?B?amxVVFNsOHJXd29LSCt4K0VrOFh3MTRiSTRaMnRidTQvaUlmQzZyMnFDYit5?=
 =?utf-8?B?N0l0bXlrNHN2V1h0Q1BWRnN0REdrUEtHZU83MFhYa2RLZWM3cWVKR2d1WFlT?=
 =?utf-8?Q?dKrIQKzbar7XbWE3obEX8FjjBNzfls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRUNHowTTFWTEV6S1VENGVUakVDd01BaDE4RDh4UUtCOHdrNFhOQ1FqVlIy?=
 =?utf-8?B?M2VuVGV3LzAvb3R0UEk0azlqQ0U4cGFTVjJtQVRYM0hPUVFlRitkVjVhbmgr?=
 =?utf-8?B?dzVXYW1jZTJQN3FEajZ6TzhMZ3JvZ1U0S0dLUmYwTkxNSmFHdXp3cVhjWGI2?=
 =?utf-8?B?aVBZMGEwaFhlS21Ya1Z4SW96aWRuQ2xFNE1XS0xDdDQwNmpzMG9Fc2N0TjZM?=
 =?utf-8?B?QnVYSmpLQ1lMbi94aFc4N0hNSzJJdHFuRngwK05Qdng0TCtIaGwyUTU3VDMv?=
 =?utf-8?B?Q2NGVVBTTGhUMG84MU9rOTVaN2piSjF1eFV0T1ZMMmFPajVaU2I1eEs1aktO?=
 =?utf-8?B?L0NKeWdiK1pxY3RLaHNnWDl5Vi9kOTVYNkx3OVF3U0dWVzNCbGwvQlBJcnRv?=
 =?utf-8?B?L0thd1pwZCtjenc5a1FyTWF1Vk1tRUxxUDc5NTgzYm4rUjd6c2gzOTd3d0Z0?=
 =?utf-8?B?RDJFQzYvZXpXYU1zTnNxb0ZpVjRVWi9TRzU3b3N1anhQQ2RyYzhwRmdRbjR3?=
 =?utf-8?B?NjJvZktMSGpTdmRiYVptQjFveldPWkFtZmptOTdvV0xEZGpldzNQSnVHZnlk?=
 =?utf-8?B?dW11N01GUzhoVW9GR1hkQUVjeHNqZWVSOHp3UE43NjhFY1RGNEFYL0tZUzJE?=
 =?utf-8?B?Q3Q4L1NIYjBzU01YbzBBNjFFNFl3WE5IcGhwcnlCZ3J0Yk5oMEpGU1R0dW91?=
 =?utf-8?B?UjZzb3RiSTExR0lsOWxUd2pGcno5WmkwVWc3WC9zVnlHb01CZjJqMUgxWFdQ?=
 =?utf-8?B?KzJUd05vUFZVbTB5UGJjWUZmK3MrR285ZU1VSkFEektRVnQxcGFKRHlLa2V5?=
 =?utf-8?B?VTFaaEdwdSs2RXFjNjhKUXA0eDVsTDNGRjN2NjFPVUVKM0R6WUNQVVRWMmJV?=
 =?utf-8?B?dXlYL01HMzE3NjFSVy8rNzRuNXk3UG8vemNLRXE2cGxtMUxyQ1BSVkhUUWtL?=
 =?utf-8?B?L0V4VFo3ekZ4WTVmMWJFMEVuMGp2ODQ2bkNsZUhPaXk4VE8rWEt6eWdyOW1G?=
 =?utf-8?B?cS9obUpoSmRJaXBJbXBKd3J0cmViUVBldzZ0Sy95NEVaYlNzYytWZ2NMUDZL?=
 =?utf-8?B?bFBCYWVSSHNoZE1xNWhhRENXL2NBNWhtSHRwektyTFR5Y2tJc0U2ZUtGK2xt?=
 =?utf-8?B?TVZGYzN1UW13V3oxMlp1UW5wSHpHYlV4YzlvNXpUeWUwbVZmYkQycGhURDlQ?=
 =?utf-8?B?V0l6UldVcDdCOEpSeTloQWxTSkF3b1RTeFE3RzFWejdmSVFQQUs1c01maTEw?=
 =?utf-8?B?T3VGZnhSSDBTU0JPS2ZmRlc5bkU3ci9CK1ZSeWt6aVg5TFVhcU5oOVBFRFQw?=
 =?utf-8?B?aDc3dzIrSTN4NFdXYThLUko0U0tzakNLZXZTMEk4ZTFiNEdWUUJVT0xLLzdJ?=
 =?utf-8?B?cXVzc0V0cG9HRXQwNktJTW12bTgrK3BmSEF3S0thTWVlNUd6dU42WXR4TzVo?=
 =?utf-8?B?ZUNIbG5tYVkvL2YwbkVNRlQ4bTk2U3J4c3pZQXlTVTNTaHIvbEZIRVlMMzc0?=
 =?utf-8?B?WFZGWFMrZzBaSkdaVFd6alJ6MEtIbE92T3NPTkRHb1F2dkR3a0czbEkvdm9D?=
 =?utf-8?B?eTdhRllFVm1ZZXBKMjZZOGkyd2FlT29qc1lqalBPNGs5bmVwZkcwYmNyR0Zm?=
 =?utf-8?B?SmJCRGg5bWVIS0svUFZQNW5vVFZqeUtlUXBhakhoTlZTYzAvQjVkcGxFMEZP?=
 =?utf-8?B?bjBVZTdISnh4bmNjL1JnVmNzS1N0Tm5vcGRhcGpXYnR0ZDRrNHZ6REY1bTZw?=
 =?utf-8?B?eWFpV3VSZHB1M3NXUkV6NUNabTVtVlAwUkpLeXNmYmNBKzZtcldXZ1hTWmsx?=
 =?utf-8?B?eFhySDduTHVqTVJTc21qTkhSdkVWMzFYWUtrb3NMNzY1RmE2S3ozMFM5elhr?=
 =?utf-8?B?OHNEZ2NLWXBxU3VwSk5YV2pud0JlbW9hbGRPN0t0bUJON3Zqd3c0MnYrMWZH?=
 =?utf-8?B?QXBjMFZjbzV0SzZndzhZWkM3eVorTHdCM0pWclV6MmxuNnFDNFhMNTg1M0xp?=
 =?utf-8?B?bWVxNkdiVFVVLzRrVmMzOGtySC9qZVJCNWJYTitzdTdtNVc1VWpMbG82ajdT?=
 =?utf-8?B?RFE4Mmd3WXM3ZUw3bXJtRk1Sa0lZSFRHMjJGVGNSRlY1dVQweFE3OFlxMWdi?=
 =?utf-8?Q?pyrUN3uC1Kw0DGR5dugn5eicl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7a6149-1172-4c06-95f3-08ddde3a4f53
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:33:37.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQAMgxullDAjrvisa60cEt9SIWdgvQvOVSSPl5G2fnvdGG2zvZz/njLtvL2+xjmGytp6p6wmjWd2FpCorIDGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
from the ID register is the same the one used on some of the QorIQ
platform, but the config has some slight differance. Add i.MX93 compatible
string and corresponding code for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v3 changes:
  - use the drv data struct for match data and refine the code
  - update the copyright

 - v2 changes:
  - use the compatible match data to identify the i.MX93 TMU variant
---
 drivers/thermal/qoriq_thermal.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..b2e634547271dcf512c714907baa162921d2d527 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2025 NXP
 
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -24,6 +25,7 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TEUMR0_V21		0x55000c00
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
@@ -66,6 +68,8 @@
 						   */
 #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
 
+#define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
+
 /*
  * Thermal zone data
  */
@@ -73,12 +77,17 @@ struct qoriq_sensor {
 	int				id;
 };
 
+struct tmu_drvdata {
+	u32 teumr0;
+};
+
 struct qoriq_tmu_data {
 	int ver;
 	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
+	const struct tmu_drvdata *drvdata;
 };
 
 static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
@@ -234,7 +243,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
-		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
+		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
 	}
 
 	/* Disable monitoring */
@@ -319,6 +328,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->ver = (ver >> 8) & 0xff;
 
+	data->drvdata = of_device_get_match_data(&pdev->dev);
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
@@ -376,9 +387,14 @@ static int qoriq_tmu_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 				qoriq_tmu_suspend, qoriq_tmu_resume);
 
+static const struct tmu_drvdata imx93_data = {
+	.teumr0 = TEUMR0_V21,
+};
+
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
 	{ .compatible = "fsl,imx8mq-tmu", },
+	{ .compatible = "fsl,imx93-tmu", .data = &imx93_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);

-- 
2.34.1


