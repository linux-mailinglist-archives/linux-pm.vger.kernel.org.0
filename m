Return-Path: <linux-pm+bounces-32767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7279B2EE24
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B352D5C7BB7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F03276038;
	Thu, 21 Aug 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eH7HPLpx"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658526CE3A;
	Thu, 21 Aug 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757454; cv=fail; b=IZKZgzfcd0hlCwaS/W824dx9rrYEqgywjgoWls3SLpI+G0CXpJwb2fCAeN4RtlylU30fAjl725xGq/AqzHTZFHxg4Ly4RW/fsmz0Eo66k70R8zqymfZHf95gC/hh9Nui3VDfh84QCxr9U+NhXqYGWOB0wbWmBGeyulMtKj4P99c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757454; c=relaxed/simple;
	bh=FenBWv8dlPooSMo9LRres60aoFXSTmBRebAT11SIiCE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RyCwsLc5wtZVxOS5PGpaS/yqhc26v4Yg4Qm2/tG1jNekVybFHK7evTMPX+KJAitXkuIYCb+M+kv7hwGwjwZ7jsroAJ2yMPJ3W2ZBhah0L0CgzOSuO+P4akNn1szDq/ryCjSzTwhxq19F5F9ml4Ry/pvxG1wcEfxAO9gsl9CGFQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eH7HPLpx; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnEsa2nwnPKWR1rV5TvAbEcUpIiEByfrUTceOC8HBfaOqly6sTdr0uz8XimC1hEEt6Deut9AXNmbVcDhWiAeb0EzGrvvQwkZqvV0/sf3SYWoXowOWRn91e9fNXoZ1ZDxDZT/FmcHKt5S1JDAZS17KBaNOGkNvaxEUcV8v7YH6x3PH2pIKUWGaXiP4Yopr6ofo1N/wv46ezImAr/7k4lNVXia/AU1xfL28UgVw2exYNVpzFZmOR/mGQUUoPp8vGihMTj8uVRvNxsSrsmXR+aybTTWL2hODtA69lGi6GSLITdEhbrkSzRUkMbIA2Un/PqxIoBNoUI1xLA9GV1iQ0Bszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKLz8ok8GoNMpZn1q5hse7jOGBxrlCWcxcNFBBKld+Y=;
 b=vtpNely855DJ8NTcrNKqRrwf1XtO2fsBPKoniIh60y+VQ4+VMpTe2kvqktpFktwFn1BBzWu4no4xZb6y2y21e3y2l7JVf86zmpbWSvcCH3RmyJWwxnL/hJFNcNyasrBX3cReJukoVm4MNusDKk5MQCVmmobDbzYBAMPRHgowjCcfbtljAfgy6KfRXlkJyTInFNwHDUTFAnN0y/DAqtcoTXpjubckEZghek7eT2KbBNrVb00u0r7g5/B1w2qIkRmdvvKVLyS7ubXiK8AdaTaQn4W+9V/m1f3+9mvZGgOtesXGeHDPNCFh3lWLDx/VoqRrnt7WzGWJdKCigTWrkQ6OZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKLz8ok8GoNMpZn1q5hse7jOGBxrlCWcxcNFBBKld+Y=;
 b=eH7HPLpxlpuhYa7v9k7Mq710ixfw7QSLilSO66vrtis3jT1KWDonjB12r98Ld9gumqbsItpfNKxTHP1rV0EaMT5KptvDEBarB/V6GFHTP8PJEy1KeDjl+UevfWpGIPPdw/DqXLeLIM5mNnzR6L9xjtEBG+86S98SvAsfEMdblH5Krkyvmp/UuhXjsTsSIkbD050eGwmVsrNC/2jlZKQ25RMVyEwDYHiJNyi5aBbI1sD+E/EMyBvstH1ZP6G6sxFB6fpspp3StLD/3Y5jbKiHGt4XJmRFpF9ayjCVc8C5tf38qDVINALSPp0xn/UoqawdUIPxuMtb66tR+nOt2ZMRcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:24:09 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:24:09 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 21 Aug 2025 14:23:49 +0800
Subject: [PATCH v4 1/4] dt-bindings: thermal: qoriq: Add compatible string
 for imx93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx93_tmu-v4-1-6cf5688bf016@nxp.com>
References: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
In-Reply-To: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755757438; l=1192;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=FenBWv8dlPooSMo9LRres60aoFXSTmBRebAT11SIiCE=;
 b=nnPmq8YHTs12ALOcHNnkHX6UseeySq/mkuoEin2FreddQmcbromDGtfLDgrWl6e9lCXxrRFd+
 XPZvBNo1nDtB1bU104Fy3EXtlJyM2mTdv3u9XHYXOwCvww3N7kvzXee
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 398c0e86-c17d-4423-deb7-08dde07b5645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUlzbSszOXNXQ1hUZzFDY0wvRmJXd2ZXdldkaTJ0T1RRbDFPU1pZNXZwYjFH?=
 =?utf-8?B?WlY1b3BlNHgvZzlWOW5hY3NHdFQvNlFRMGppQzAxcGFuaEZuaXpMOTUvS0ZE?=
 =?utf-8?B?dlBmZ0llUDdOYmRLL241bkVxVXlGL0R2SkpKNlR0K1Q5OWZFTEUzMVZiS1lV?=
 =?utf-8?B?bnpGR20rZFRPWFFNMy96OWdvQ0tCZVVmOWNIc01ja3JBSTlYa1grc1Qrcmh4?=
 =?utf-8?B?bGE1KzJCdmxsY2VoWHNYVnM3S0J1K3NYenhvZEVWM01NUDgwa3YwVXgwQlJF?=
 =?utf-8?B?ZFlrVndwTEtpeURpSFJ4a0JpZE5kYlV3MGplUDZxTUUrQ2x4RnpTZE1Tazc1?=
 =?utf-8?B?aVllU2RwWHprOTZSanJOWnBUM1BNcnFCYWRUc0cwMk5ic0Q5Y1BZN2d3WCt4?=
 =?utf-8?B?SU9vVFdudGsrSXhwUzUrMjVxcU9aTVk0WnZ4SVRMbUZrRU9aeW1TMDNXeVlD?=
 =?utf-8?B?WWZqcjgwTGw2UUR2TThKc2pqSUFON0o1NWJZUkV6NERxTzVjUlErYWZ4MmVP?=
 =?utf-8?B?RmdxTFREYk5qRGxhWWxrN2lLbDRib0FkZ25ORzMxZXNPemFjbHcxWGkxbTlL?=
 =?utf-8?B?cXRhb1J6YUtSZjY1SXRtRG9sVjc3MlJHbWlJT1dyVW9TZnk2N0tRMWljQkFC?=
 =?utf-8?B?UzQ2V3lkVzJNVTFSajF1cHNNZnVLVFlTNjB1RkpQWGZJWGdmYlBWa3luQVF4?=
 =?utf-8?B?b3V2eSt3bW9rRUwrK0gxeUo4S1Z6ZmM5U3ZwbzlzSFl1NVdQMzEyV1NLMG9C?=
 =?utf-8?B?TWlHYjNLcUVZL0xQZGlqWUc2emV6K0c1Z1ZxMVNjc2JuM2V3OUMwQk1JN2VC?=
 =?utf-8?B?RjJ6RkdEaHpOUWErVFo5bGVtMzdLTW02OEpGb0ZXRUhkeGUrdndNNVpFL2lJ?=
 =?utf-8?B?UHdtaEZjNmZpbVY1dXZJQUFqWFlGc0lIWEtMR01WalF4MndIcUcxZmdaNTRD?=
 =?utf-8?B?MlBXVy9XQWEzL2x1VEg3T1NJUEliNnhDOWhobzVDTkdUdFpneUlwZ1VRVEUw?=
 =?utf-8?B?R1lvSmY4dVdSL2ZkSjRsSUhJVnAzdTRYZlREZzBHMWp6Z21NWnZaSWVQVUwr?=
 =?utf-8?B?K2dDM2tJV3BIejJDck9OZ25iRWJDY0JIV0x4K0laeXBUUUtKMENhaG5DN1Mv?=
 =?utf-8?B?Y0gzVVlwWGVVVzgyZ0gwTnVvbVNXMThkSkNOMkpuajNtVFRPUkpvOHdFRDRt?=
 =?utf-8?B?VE02OTl1bHdOd0FHNE9rWEJvOGtqc0ZoS0tqUGVmSnQ1bkN2SStkODRITm1q?=
 =?utf-8?B?Q2lsSWorNFJHTVc1VXZETVMxYVN4S1kxdTg2UDBSWDFTbEM5K3lJUGFTd1BK?=
 =?utf-8?B?cXBlTC9FWHRZTjY2N3JIVzl5SGRiaHIzS2ZiWFR4ZUVUWXI2STdLQzlIWHp4?=
 =?utf-8?B?Sm5mMi9zODBsYUZsMjF0OXBBdG5QY1UxZFNmb1Z4SDRMY1kwNmErdlFTY2dv?=
 =?utf-8?B?SVJTdFlXT0Rud2JIck1TNHV6eXBlTy9mSFVQL3AxVFFaRmx2ZWtRZng5bWcw?=
 =?utf-8?B?VnlsUkltV0RyaU03K0FaZExHUlZlWlBNSXBHekZjV0d2Y0VxVzRTSXQ2VDBK?=
 =?utf-8?B?aWU3RmhrRXgrSzY2ak9qak5ZcWZIK3FQaGUva1ZUTGpCd1JHdERxUVh3V3VR?=
 =?utf-8?B?WkJEL3JxYTM3eHdQenQyOEUzcTI1ejJSbSs1OWZITE1lZnl6Qk01UDRMeVRh?=
 =?utf-8?B?WjVxUk4rTnFzVDh6Z3VaSXk4VkF5cWlMSktRNFRPVDhOSlR2YWRqOGkycm5y?=
 =?utf-8?B?UjdDUFJTR3N0Um80aXp2bCsyYTVTbnJuSm1Gd2c2djFnODcydFdVWGs4eHpm?=
 =?utf-8?B?VkZCN0RJQjdpa1ZhTnpQb3dTL3VZVjYwcHFRVTJRQXRwcVcwSjlGVHpCWllL?=
 =?utf-8?B?d21xSFdMdmtUUU9RMmF4NFJKUmVMTE4rVVA0MG45SW15YnVuNklsbTljM0tN?=
 =?utf-8?B?cXVoQkZvQjdrdEh4Qm9adVNkanNGY0MvR3p6c0pjZVBCS0lJL0lHTTNVMElM?=
 =?utf-8?Q?a2m9+T4OBBYjxDC2wVDallLZ+LgrrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2k2WWJqcnFhblY1NjNSSDB6MjNGVU8xTGlyd0Q4WUZzOFA5U2NxNHg2MC9O?=
 =?utf-8?B?Q3Y5WDRGRlhXc2NVWmJFYitMMUlhWHVnbFdOT0tBb3lJSmQwRFM0VjUvbEg2?=
 =?utf-8?B?Ry94bnZCUHZmbHZEUmxtTndPWGR4RkwvU3VJdmNLTENyU0dEbzVLWEFaT1Az?=
 =?utf-8?B?K1U2V0oraWlvWXlBS3hzeUNSanVxWkRjZzRWdU51RjMyK0ltL3BVSFNLblFU?=
 =?utf-8?B?YTREdVlrc2NMTGlPVjlCN1JiOEMwTTVWUDJWeFVtT2J4cE9pcDBSeVBiVXhu?=
 =?utf-8?B?T2ZUaUJYWXBod0wwYU1nR0F3dGR1cGo3QnBxSDkvVzRLRk5QQ1ZZUWNTZ1Uw?=
 =?utf-8?B?eXdnT2REVVcycGNlSGdFL3l6QXU1djZFRklHZkRoSlRYSUNSRkcydE1BS24y?=
 =?utf-8?B?TGhFZCtmakUxMng2N0NjM3hic0oxQklVS0tVQXV6eGNFQmlyTWJZMXNTR1FE?=
 =?utf-8?B?T3VwQ2wwVk9DYUFTU3JGSCtMR3FHYWc4SWsrQzZYcFlUUjg3T1N5OTFXWXBB?=
 =?utf-8?B?eGxSS0Qzbm5BbnNLVk1QdjUyZGpRdkxDUmZidnRRZnN0L2FmOTIzNTJla0F2?=
 =?utf-8?B?UndEQlVreC9SVkx4bS9ySFZrYzBqeHF3RWJna1JLZ2dialJzYzZxNDN1TmJB?=
 =?utf-8?B?QkRIdytSSzhEbnV4TXBpSEUxckpVajQySy80ZnlnczhlcWI4L3o4clVsV2NQ?=
 =?utf-8?B?bTc4LzFjL29QcVJ0RWVYbVI5dVl3UVA5KzhuYmh0T0JGZ0lMLzBmMWE3Y1F5?=
 =?utf-8?B?NG16VHA1ZHM3UStvcUI2cEhoeVhXUXJnOFREUmp3bWJSQ1VmNlhGV09kRjlm?=
 =?utf-8?B?Vk42WlhMb3RZaHV2VHBvdHhWSUZ3NUFIcUloaE1vT3hiSHJsWjN1TnJlUnpB?=
 =?utf-8?B?eUQ3a0lOdy9NNkE0NTUzNFE3MndjNVpJYWtoMURtVWlDWDd1aklhVFJycGVQ?=
 =?utf-8?B?dUtGN0l6bTBIMlpSSzFwYUZtSTdCWHgxaFZaTlhSbTlqRUlUZStlQzUrY0No?=
 =?utf-8?B?NzZMcmx3NE9LcnZYUjBlUFBicGo2N2I5VnpkUWVjTGMraEdsbGtRODBONXBI?=
 =?utf-8?B?TklKeng0Nlo2MkVBRVYxVGVhaVZGeUwzc3E1SmRod3RoVEdNaG1SOUxjUEVu?=
 =?utf-8?B?R3VsbGtoR3luMzRleDNOSDdLTHd0SVhQT0NpY0ozc24rdU9WUndRVkVxV1h5?=
 =?utf-8?B?SGdBRUNmRUMxcExHQjhMenUxM2JBRHg1cSsrTElKRGpvd1pVTzR6UXRabkFw?=
 =?utf-8?B?WEZOQ3hOSkRIdVlVM0llcmYwNFRPc0hPZXNlQnBuQnRhcERtUFZ5STNXM3Ey?=
 =?utf-8?B?Z1l0S0FMWVB3NzNaYTVSUkcrOFp1UDhmZVRlVWI1WHRWNjBpbjhvd3BVbHFV?=
 =?utf-8?B?R09HSmlxWmhnWWoxOGU1aXZKYjd1OHhRTm9nakhqb0NRMjF2V1pUMGE5Tkpv?=
 =?utf-8?B?VDJ0QzdDOEp6Rk1qKzlMK3hac1RYcFNXZE4xd3hBVWFOZEdXeUt2RkRmWEhk?=
 =?utf-8?B?cHVmRzQwVXVueEswUFJBenlzTTZOZzRSTTUrcmZ0WHRKOFg2dmlrTmNMV0lx?=
 =?utf-8?B?MFhLQkNmbEtlU01aYXJNNVVhMy83ck9GTVplOWdoSnp1MW02TStKRmJia3VZ?=
 =?utf-8?B?a1REOUZhbzR4QjAwZDRZb0dTVWtLSUlMR1kralBEdmlTZFIrYU5BWmUxQ3Fm?=
 =?utf-8?B?NlZNMnMxMmY1MzFWSDdKWFpMM2ZFSFh2WUwzL1BxcGdpQ1d3a0VQcVBHUExx?=
 =?utf-8?B?S0VPREJRQTEwWUpoQnNkRCs4YVNXMzBpNHVkZXllQi9XeWZUc0hBVGVUajM5?=
 =?utf-8?B?Uk9aSW04YXB6VU5wUTJSaE11ZWVSeGxVb1dsMU54MlNkbFBSSHdPZ3EydWJa?=
 =?utf-8?B?SjlzUUlQUWVSNHZwUWlZc3hLc0FhOEFrM09IaVdLUU85NERyQ3BROENkS092?=
 =?utf-8?B?dVpaMFhWQ1J5aThxc1MvUWlHTjVwTE0rRjlhQWk5TlNwV2FqSFBXbW5ETSty?=
 =?utf-8?B?Z1dZSzlYTjRYQzluMXFOeFBMTlJSREVDd2U0QWpONjB2OGp0Z3NCV0pjQ1lW?=
 =?utf-8?B?VGw1Q0d6eGcrVEVzN0VUZGswcEc5ajBLZDl0cnNxdEwrTkl4VmozSVpwWnZj?=
 =?utf-8?Q?PQmFyWJDKuQIlBHRteVhVcWR/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c0e86-c17d-4423-deb7-08dde07b5645
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:24:09.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pByFkzNg7pfZp3sqz2Ml2gf9uDGKu1+iVfEA48sPicrCpwvoS+tH6EZAIpQlS4jIBRYWB4XbwtzeTxDJzHkiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

Add i.MX93 compatible string 'fsl,imx93-tmu' because Thermal monitor
unit(TMU) on i.MX93 has differences with QorIQ platform and not fully
compatible with existing Platform, such as fsl,qoriq-tmu.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v4 changes:
  - no

 - v3 changes:
  - refine the commit log
  - drop the compatible fallback support

 - v2 changes:
  - keep the enum
  - refine the commit log to use i.MX93 and QorIQ name
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index aa756dae512a2c6e3f0b6bb1ab4a65c01e373ea7..f3b136f5e1cba1fff7e90678d7e3d7ec3ddd25c1 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -25,6 +25,7 @@ properties:
     enum:
       - fsl,qoriq-tmu
       - fsl,imx8mq-tmu
+      - fsl,imx93-tmu
 
   reg:
     maxItems: 1

-- 
2.34.1


