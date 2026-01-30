Return-Path: <linux-pm+bounces-41792-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBpzEf7ofGlTPQIAu9opvQ
	(envelope-from <linux-pm+bounces-41792-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:23:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89900BD02D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 626493019A98
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036263559F2;
	Fri, 30 Jan 2026 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ouae5Vso"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9A34B19A;
	Fri, 30 Jan 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793091; cv=fail; b=JbwLqq72oQgXf2dSppG0boPyIoNlO3mx6daYIhLEgLXPqDGfd4pOTMwLiV8fulXhzQ71UJXt2htwn1y7ua1NbyJ9m6iYonnGmT3hHLSoP+xnNVT5Zej3uM8WGYzZiBaNRjgBpoxiDWIELQ4NeCsBTjsn7rcSQf7/K9dTnJBhqvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793091; c=relaxed/simple;
	bh=1NTSVcLQkX0rseX2qqjENVHDh32FjyTH+nW+IuI9Wvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m+2dg7L+ZKDbl3vPo4sY4r9PLnyrnvaf9aTKGrfbAwN8366fDVYAYlzpiTZmTalG9OcH5njXYu++FE9PjOg8p8DkwJC+sXsyR3mr8opkAPsnD45hOhTAj8HmHlWtnneJsV+lEHgmr55VssA05Ut9E5AB8pS7AuQHiH/nb2RUMuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ouae5Vso; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7aFE/sQ1qh07l9MINuNnrsCLJ/tRCNwKJnskZ3gC+zLoeSSB3ywZ8uGrnjfP6uFn3SyK+tvbTDyyp7ZgPuBxg2lXqx/yoOkGgvP+9PUA+lS4c8xergd50zi0gW2yJYghe+QihQzOKvLukEO3Ir+u/AkCMsqlkwY4wBX3FqHqbEoVD/RwZNZGsEmnzvxmoohhw8aHXgjSqRIx0SiMScNzllCFqfPCc4HljZVAyaUwcXmMkh1Ibg0UrY/K1tPwGP2CiNejNlfEcdmMCdfhjoLZb/aQI1C52SuDZ8l/5Lehiou5RtchYt/ZFo4dwBDyIjmwmXQS4AklvzJCy/v8u5VVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnYFx/BMlRIwMrNswYPLSQ2Zonu5w7zo0TrtofxsBKs=;
 b=lEze5OczanoEkKARJoEZUbeBomW7OsgzaFT/ZAfvsYHsgFiOYdeGTCUyZoH1yApS2S5BVwqlPScok4q9fGjmR1Zhd0+pzvp5zF/lqC5yHCMv4MfEihb44zzZ+nOfXJR361nErMnYakAdWINMYX/oUkghG5YMZlFHEP3tuQcU4mEjoi6+vVqIBvcH7LEm3x/x/DjQH0OKe7eLZ6okdcjOupSvgmj4e4n5xmvCYC8ycAPfxE80l4cLTlklhmlLGoNyLpeoTICdwcwwuA2AlKrGemTrwPEacRe23VgXf+s19Qz3xTlYJ4gaigQmedNR/LHHaDOxEPqXaxeF2z+N3/0HMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnYFx/BMlRIwMrNswYPLSQ2Zonu5w7zo0TrtofxsBKs=;
 b=Ouae5VsowLilcESqQKP3vT262Xnvz+zSoixtFiwT3DtWNEPfL3q1tnh8eUlwySICeoblZGY2Qtgb8pnPv+CedPFuuD/kbfwN+t7pnlRO3lbBXN7n2kGv4lE1mg4ZJuk2ywiU6T9t64vGR2xKtCM692nNBBjAHHL0kAmh0nvM7d0778VfDMvF5rh0MykdpBVQaVryRlzwMbh4f6RM6G9WXRiF0WKd7g1ihMmLlGBEkvJol0lSuKZB2yZ+erSwUrMKEtcafFUZpLvTHqNS/ZBSSs6d57ZWvuuLqweIbELDPeWIC7zJ4cg2DxkF9YwEjPRgV0hh9kJN2aVxt0smCIHxbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB12124.eurprd04.prod.outlook.com (2603:10a6:20b:744::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:11:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 17:11:26 +0000
Date: Fri, 30 Jan 2026 12:11:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Message-ID: <aXzmN2JiopDi+INX@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
 <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
 <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB12124:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c2dc49-0e54-41e3-c090-08de602299f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitGN2VtcDZIdk5VaDFaRTZRQ1hYT3hPS2YwZVBOdGQvZ2dLT1NJalY2OXRn?=
 =?utf-8?B?RDNHeHFUcFUxL3BwN3BjL1p6QXZkUVJKV2xoQ2kxMThnZDcrejFhdzBCcURz?=
 =?utf-8?B?NExDY1RyYXNZOFliUzRtaFFxSlRqWDNraVUwTFJTTDByOWRnejZTOHJhSVlH?=
 =?utf-8?B?Y3dLNDBpVHd3WnVLYnY0djhyY0c2ZGY5L3lRbU9NSHFsVktsQWxLcXlIOVlp?=
 =?utf-8?B?ajgxamtMUUZxRm1PQmtxY3RNWUJ0aWE0eE1lOGxvR095ZDMrV0VtSUxRR2NM?=
 =?utf-8?B?UkxSQjJFYUozUVppMmVQN0F3VXYzeXJaVTdHS1Yya1l2VUlTVGpHT1RVTUFE?=
 =?utf-8?B?U2FvcWp3bjBjVHVkTzQ3WFZ6cmZBTVFPcVJPd2IzdHhyc2c5TzVyY1pHL0cy?=
 =?utf-8?B?MVkvR3BXQWNBMHIvZGJ0bUxBQ0dFUEpqT1FjdG9jZGNxRHJiT3U4Q0hxcjFJ?=
 =?utf-8?B?c3NsRk0rT3ErNlZYQXRBN3NyYnNyVjNhTWVQZkRaWWpkSmR1d01QQWNVVGx0?=
 =?utf-8?B?OWtPeEcrT010SEROeUo5YSsvLy96NU40VkRyKzNZdzgzSzlNc2dnMSt0Mkt1?=
 =?utf-8?B?a29wYWlXeVBCamowc2lQbnVIbkVSMmNwT0FvTWdhaWN4eHpjMVdQK2hGS3R0?=
 =?utf-8?B?dGZ2dGNrTTFNYXc0MDNPNXVPVEtqS2daY0lKa0Q3SDRxTXd5Q2tqUG5KUU9Y?=
 =?utf-8?B?TDFDSFRQanpTbzdvTWsxamlmS2RlZ1Y2YXNtUkxlMzBsRjhadnc1NnkyQnhC?=
 =?utf-8?B?by9QM1BUTVprMEtiVHRrVUkyM0lORmNCTys3S0RyMHlZUzBYbmFGdWFia2ky?=
 =?utf-8?B?UlV1QkhoVXRUYjJFWndlQmE2VC9Da0NQRHFEYkRhYURFOVlsYVB0Wit1ZkVt?=
 =?utf-8?B?VFFTcVRUMGlab0p0RzlnbDNIWlNKNFBkdnVRUDZJOVhEZmRDZDBwbW9OR3Yx?=
 =?utf-8?B?a01xTENPQ3hpVGxVT0g5QWROaE5jU3FwUHNjS2VuYnRnYVAvQm55eXk3aHIv?=
 =?utf-8?B?VkVnaWhxVW1oNHVTY0FPci9scjg2QW5WeFR3a1JGZEtaVThETklZaUtWTlJR?=
 =?utf-8?B?RUU2Nk9XSzMwQzhJYUJERmFUaTVTU0pWLzBPdGtmcUp2SmhIQ0I1OUxvYmVv?=
 =?utf-8?B?clh0c28wekduVTJwS2l6UThBNUFPcFJSazkvVnVSTWtZQjlvSzhQYklUYmU0?=
 =?utf-8?B?bE8vSDRKd3I0ZWhaL1Y1TUVvQ3RRdVlPL04zcHJBNGt2YkJ2TDlWdlBJUE42?=
 =?utf-8?B?SHMwNlJTaE1hcVRSd1lBUGZVOFJMZWRaeVFiaGgrRlVRSjFQbW4rNWNXZkJx?=
 =?utf-8?B?Q2ZoL3h3UXQxQWsrYjl0SWhrWEY4RUtoek9hYkRsamc0SCszR3dQSHlPRi9X?=
 =?utf-8?B?c08wTkhBQktock1PQWhVNHF1RGc5U2RtQ0tCcVI2YUNmVWJYUVRzWjdJSnVW?=
 =?utf-8?B?cDU2U2M4TnVaZmloSW53cW1aakYzQnNkVnV5ZTF3dHVQQXMzVzEvRHRadnE5?=
 =?utf-8?B?b0ZDMGl4cFcxUE04VXBEY0ZOTVU3UGpvcTdXOVcvN3dSaTRCSHdCOHV4dHYx?=
 =?utf-8?B?LzFDTEtSWVpISGR5cjVlUFNpcW16Mnc5MkhYWFRkc3NGYWdtRjllWmU4d3Bp?=
 =?utf-8?B?UmxIMmlnMEJHdFlvYkVSRm1TOG9jbGYxaFBveVJDQ2FVTk96Y0NNTjF1MGh6?=
 =?utf-8?B?ay9haGozd3pqcHNkUkhFaThQM2ZxVFFYaHh2ZUQxUGhTdEdhMlcrdFFBSzZR?=
 =?utf-8?B?WlpPU2daOE9maDNTZTFoNVVhV1RaalFHczFWVDY4TC9mbE9sQjIrcmdCWVZQ?=
 =?utf-8?B?MlFLT1BpQVczZktsemlkYkZiWVRkdE5XWEJCTmZlaGI2d2xNays1b0Zob3F3?=
 =?utf-8?B?TUNrak12ZHYwRFB4SXIyZ1JqL2w4czhvLytvUzhMRVhvUVc0c2x1dlAzdEVW?=
 =?utf-8?B?YXNackhlc3E2cjIrOHBPU3o1MnphaDh2QVNhOGQ5RUwyVWhxQnR2Mnk3NU5G?=
 =?utf-8?B?WVhESXpZbEpMMFU5Wk1mNHhlZSs1eDFPWWhTR0RpcGhnRzVmUDZ1dkY3M2RL?=
 =?utf-8?B?T29URWxlS3pOd1BHRENUVDdrVk14TFNtVzVmd05JR3A5T28rRXZ6aVBSNk9l?=
 =?utf-8?B?V0lJSktoUUlCVVE3WTRhRHNXQVNjYnZuYjVlVGxoRE9HcE1FRzFtdktyTDJD?=
 =?utf-8?Q?h44HY1gIWgFUFUkrILxNmJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTNSWXdvdk53ZXUrWDdHMEo1RmtpWCtIVStvMC9CT0VLZXRqd1BMTHVoN2R4?=
 =?utf-8?B?MUZNUUF4b2E5dHE4NWFOMm5QT0ZxOWp5Tm5kdUYzS0gwMG02SjhQbnNGTWN6?=
 =?utf-8?B?NWRHOW81YTIxMU0vTnU4NER1V3VBWnNlTDBES0hqSkVFcFhPLzcrcDd5dWhF?=
 =?utf-8?B?SFhsY1RRZGNSWHcwWGp1WmlMV3NoNDlmdW11ZDlpbloyNmdDVEh3RWJKMkl3?=
 =?utf-8?B?U2lnSzQySnBGTXQrKzZvNlI5MXVISlBqcXpzVkxOV1VNMXZQSXlxNU9xYytx?=
 =?utf-8?B?RXBnNTJLWVlPT0pwc01veHFNYVZIa21IWmFHbWNxellRdFM3ZGU4ZG94ZlpP?=
 =?utf-8?B?NG12OStxSmxpUmY0cVk3RHRZNk9UNlJqUUdSSkVIeTY0K0RIM0VYc1BjSzEw?=
 =?utf-8?B?ZkZrRW9qNHM4VHYxUG1uMHcrekVZc3QyOFU5SE9tMFV0OGV6N1JCOEhvY3Av?=
 =?utf-8?B?Nzg3S1kvQUU3d2Z2bHdZN1l4bXVid1l6NWtHNU4vcm9DblpkblJZV0xIait0?=
 =?utf-8?B?R0c4NGlvOE1tWWJMZkVoR1dkd1NSVytzeDM4OWh1M0pRbVhuS2VtOUFNZlJD?=
 =?utf-8?B?NzF3d1RXc2FucnYvSUw4azVxZGxyR1h4U2FzWTViK2Q0NzdYYUpxWkN3V0xC?=
 =?utf-8?B?b0lFNHJ5SEl1dkRDaGFvdmNINUJoMVFjaE1vaWVmRTN1dVJxNkVSditOYjJD?=
 =?utf-8?B?WnpLRGZ5TlRSRVVKNXNObGRJTDFidjNNUlc1cHJLRlFaM3BBc1hqb0I0ck1S?=
 =?utf-8?B?aTR3eEpmSXNzRGtkVHN3QW8vNHRzeXdtNmFQY2IrNHBVK09Kd3NsU1I1aWtw?=
 =?utf-8?B?NlZYemdvNU5FUHhicEZNWTFTMjQzRG1nYnVtSldMSTk4UGtFSk90QVdNalc5?=
 =?utf-8?B?NytHYjAxZldZSWx2MDdLd3h6YmZHMDZ4c1FYL1U0SnBjUlUwVWZqd3JheWMy?=
 =?utf-8?B?cFpHTkNuS3BTUGoxUlpXUm45ZUcrVnp4R05ESDErU0dxL1VWK3p6SnprS1RX?=
 =?utf-8?B?LzZXaWE3cEF2akxOSUU3NEVNa2YvUU5JRkV2a1Mya3c1QmkxTi9zYWpCd0c1?=
 =?utf-8?B?YytRR2I3UWNSN3ZkRDB3emN6a3VTWHdUaW54eUp0R25lTktlZ2pUN1lkc1Rj?=
 =?utf-8?B?Y1BpTnhVUEVmSThnQjVvaitKRTNQWW1FakhGdys0VlU1U3RWallXV2h3T1hR?=
 =?utf-8?B?cjNRT0RWTERpS0Q5czgrOWYrOWVDUHZLUWYvdElESHBKcXgwVHArYjdoc0Rs?=
 =?utf-8?B?NGJ1ZE45UzJEeUNPUEorMGs2VG96eDJ2Y2cxUWx3Tld4eU1tNDdNUkwvbmln?=
 =?utf-8?B?Q0RWRmF1Vzl5R21TNzVFTU5HcXFDK0xWZk54bGNHQ043NWVpN1hvczcvazha?=
 =?utf-8?B?VVl5a2pZWXVpR1ByKzJnNEtEMkFqRkc0WHdSUTErNnB5ZXR3VjBuTFBZaktB?=
 =?utf-8?B?Qjg3Z00zdTBhU3cvSHAzOE1BV1JvL0U4OHhXZTNFbW9xSVRGVHF0ZG9hN3Qy?=
 =?utf-8?B?bDNNbi83ZnBCL2QxdDZaK0sxUFN4ZXhnN0N2aUNIemRpalFHb05RakgyNk1n?=
 =?utf-8?B?b3REMEx2VjRBSUtWdUNWMTFkVnc5WkhxTk1HaWRBcUJBa0FXNi9TclZHRzUy?=
 =?utf-8?B?eVhVN2hSTFA0bHNXUVFVVWc4elVEL3dhYk81T2ZZYTNvanJmRkJDZ0VXbHE3?=
 =?utf-8?B?dFBlb2o2Ylk3R1JvV2pUVVFVMFlZblBtN0xiakFyRzAzdFkwOW1BYWVYeGRR?=
 =?utf-8?B?WWM0KzI1U1IxK091TEZNbVVURC9zRTREZWQrS1lTVEdtUHNGN1VKeWgvQU1w?=
 =?utf-8?B?V3gyTGlZSjVzVnlvZXF2TGowQmJiWVBqdWR0WWlwNHJIZlVaczlhdk8wb1V1?=
 =?utf-8?B?UEJLNzI4QWV5QzNmc2MvYXgvY1RKSXkvbm8ra3llNUxVNHVKUmcxUThJcGhz?=
 =?utf-8?B?dzVPUVYrelRkRDlJeXkxUmR1YktLWk9LMnRtRk9EMnphNnFGU2pxN2FaNnRB?=
 =?utf-8?B?OXlKT2NjUXhubTJFMm1sU3NqeTZTWkhYUzhhSDBBQWxYZWpKS0hIaGtHVFl0?=
 =?utf-8?B?M2pjQUl0MXF5bElPeDNMWUFXRjJYSWdyT0gzMU9KS3JIMWhHRWRELzBHK2ZI?=
 =?utf-8?B?RUtkT2o1c2tFZm9tcGFlSkI1ZjNGZSsvdkRoNGtOWVd4eHp0RjRaYkUrL29Q?=
 =?utf-8?B?U1BqVWI2RXFxYUc0bkJwUDdoc2FGdDEzZ0hnVEEvZitSYWFmTFdKTjRkRTRv?=
 =?utf-8?B?L21pSVErZkxHbkpCTitFQlJxbHE1TGd2S0lxSU1SM3FtcnBTb2ZsWVJyTFZo?=
 =?utf-8?B?Qy91UmhoUG56ako2SHJIMnpsbkFVM1JOZ1lnRHBaMWk4bUd2d0tSUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c2dc49-0e54-41e3-c090-08de602299f1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:11:26.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtM86TaUiKfQsIIvCk1ac+O6GXs3gbCLXG4QwviotLnGP5NLGVscE4USP4onRSQVGEcxRgaKPgeUbFYZcBmL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12124
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41792-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89900BD02D
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:34:37PM +0200, Adrian Hunter wrote:
> On 30/01/2026 17:04, Frank Li wrote:
> > On Fri, Jan 30, 2026 at 09:00:33AM +0200, Adrian Hunter wrote:
> >> On 29/01/2026 23:00, Frank Li wrote:
> >>> On Thu, Jan 29, 2026 at 10:28:14PM +0200, Adrian Hunter wrote:
> >>>> On 29/01/2026 22:00, Frank Li wrote:
> >>>>> On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
> >>>>>> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> >>>>>> where a single parent device hosts multiple I3C controller instances.  In
> >>>>>> such designs, the parent - not the individual child instances - may need to
> >>>>>> coordinate runtime PM so that all controllers enter low-power states
> >>>>>> together, and all runtime suspend callbacks are invoked in a controlled
> >>>>>> and synchronized manner.
> >>>>>>
> >>>>>> For example, if the parent enables IBI-wakeup when transitioning into a
> >>>>>> low-power state,
> >>>>>
> >>>>> Does your hardware support recieve IBI when runtime suspend?
> >>>>
> >>>> When runtime suspended (in D3), the hardware first triggers a Power Management
> >>>> Event (PME) when the SDA line is pulled low to signal the START condition of an IBI.
> >>>> The PCI subsystem will then runtime-resume the device.  When the bus is enabled,
> >>>> the clock is started and the IBI is received.
> >>>
> >>> It align my assumption, why need complex solution.
> >>>
> >>> SDA->PME->IRQ should handle by hardware, so irq handle queue IBI to working
> >>> queue.
> >>>
> >>> IBI work will try do transfer, which will call runtime resume(), then
> >>> transfer data.
> >>>
> >>> What's issue?
> >>
> >> The PME indicates I3C START (SDA line pulled low).  The controller is
> >> in a low power state unable to operate the bus.  At this point it is not
> >> known what I3C device has pulled down the SDA line, or even if it is an
> >> IBI since it is indistinguishable from hot-join at this point.
> >>
> >> The PCI PME IRQ is not the device's IRQ.  It is handled by acpi_irq()
> >> which ultimately informs the PCI subsystem to wake the PCI device.
> >> The PCI subsystem performs pm_request_resume(), refer pci_acpi_wake_dev().
> >>
> >> When the controller is resumed, it enables the I3C bus and the IBI is
> >> finally delivered normally.
> >>
> >> However, none of that is related to this patch.
> >>
> >> This patch is because the PCI device has 2 I3C bus instances and only 1 PME
> >> wakeup.  The PME becomes active when the PCI device is put to a low
> >> power state.
> >
> > One instance 1 suspend, instance 2 running, PME is inactive, what's happen
> > if instance 1 request IBI?
>
> Nothing will happen.  Instance 1 I3C bus is not operational and there can
> be no PME when the PCI device is not in a low power state (D3hot)
>
> >
> > IBI will be missed?
>
> Possibly not if instance 1 is eventually resumed and the I3C device
> requesting the IBI has not yet given up.
>
> >
> >> Both I3C bus instances must be runtime suspended then.
> >> Similarly, upon resume the PME is no longer active, so both I3C bus instances
> >> must make their buses operational - we don't know which may have received
> >> an IBI.
> >
> > Does PME active auto by hardware or need software config?
>
> PCI devices (hardware) advertise their PME capability in terms of
> which states are capable of PMEs.  Currently the Intel LPSS I3C
> device lists only D3hot.
>
> The PCI subsystem (software) automatically enables the PME before
> runtime suspend if the target power state allows it.

Okay, I think I understand your situation, let me check patch again.

Frank
>
> >
> > Frank
> >> And there may be further IBIs which can't be received unless the
> >> associated bus is operational.  The PCI device is no longer in a low power
> >> state, so there will be no PME in that case.
> >>
> >>>
> >>> Frank
> >>>
> >>>>
> >>>>>
> >>>>> Frank
> >>>>>
> >>>>>> every bus instance must remain able to receive IBIs up
> >>>>>> until that point.  This requires deferring the individual controllers’
> >>>>>> runtime suspend callbacks (which disable bus activity) until the parent
> >>>>>> decides it is safe for all instances to suspend together.
> >>>>>>
> >>>>>> To support this usage model:
> >>>>>>
> >>>>>>   * Export the controller's runtime PM suspend/resume callbacks so that
> >>>>>>     the parent can invoke them directly.
> >>>>>>
> >>>>>>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
> >>>>>>     parent device as the controller’s runtime PM device (rpm_dev).  When
> >>>>>>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
> >>>>>>     instance’s system-suspend callbacks from using
> >>>>>>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
> >>>>>>     PM is managed entirely by the parent.
> >>>>>>
> >>>>>>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
> >>>>>>     by parent-managed PM implementations.
> >>>>>>
> >>>>>> The new quirk allows platforms with multi-bus parent-managed PM
> >>>>>> infrastructure to correctly coordinate runtime PM across all I3C HCI
> >>>>>> instances.
> >>>>>>
> >>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>> ---
> >>>>>>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
> >>>>>>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
> >>>>>>  2 files changed, 22 insertions(+), 9 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>>>> index ec4dbe64c35e..cb974b0f9e17 100644
> >>>>>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> >>>>>> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
> >>>>>>  	return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> -static int i3c_hci_runtime_suspend(struct device *dev)
> >>>>>> +int i3c_hci_runtime_suspend(struct device *dev)
> >>>>>>  {
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>>  	int ret;
> >>>>>> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
> >>>>>>
> >>>>>>  	return 0;
> >>>>>>  }
> >>>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
> >>>>>>
> >>>>>> -static int i3c_hci_runtime_resume(struct device *dev)
> >>>>>> +int i3c_hci_runtime_resume(struct device *dev)
> >>>>>>  {
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>>  	int ret;
> >>>>>> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
> >>>>>>
> >>>>>>  	return 0;
> >>>>>>  }
> >>>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
> >>>>>>
> >>>>>>  static int i3c_hci_suspend(struct device *dev)
> >>>>>>  {
> >>>>>> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>>  	int ret;
> >>>>>>
> >>>>>> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >>>>>> -		return 0;
> >>>>>> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
> >>>>>> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> >>>>>> +			return 0;
> >>>>>>
> >>>>>> -	ret = pm_runtime_force_resume(dev);
> >>>>>> -	if (ret)
> >>>>>> -		return ret;
> >>>>>> +		ret = pm_runtime_force_resume(dev);
> >>>>>> +		if (ret)
> >>>>>> +			return ret;
> >>>>>> +	}
> >>>>>>
> >>>>>>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
> >>>>>>  	if (ret)
> >>>>>> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
> >>>>>>  	return i3c_hci_resume_common(dev, true);
> >>>>>>  }
> >>>>>>
> >>>>>> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >>>>>> -
> >>>>>>  static void i3c_hci_rpm_enable(struct device *dev)
> >>>>>>  {
> >>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> >>>>>> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
> >>>>>>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
> >>>>>>  		hci->master.rpm_ibi_allowed = true;
> >>>>>>
> >>>>>> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
> >>>>>> +		hci->master.rpm_dev = pdev->dev.parent;
> >>>>>> +		hci->master.rpm_allowed = true;
> >>>>>> +	}
> >>>>>> +
> >>>>>>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
> >>>>>>  }
> >>>>>>
> >>>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>>>> index 819328a85b84..d0e7ad58ac15 100644
> >>>>>> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> >>>>>> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
> >>>>>>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
> >>>>>>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
> >>>>>>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
> >>>>>> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
> >>>>>>
> >>>>>>  /* global functions */
> >>>>>>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> >>>>>> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
> >>>>>>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
> >>>>>>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
> >>>>>>
> >>>>>> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> >>>>>> +
> >>>>>> +int i3c_hci_runtime_suspend(struct device *dev);
> >>>>>> +int i3c_hci_runtime_resume(struct device *dev);
> >>>>>> +
> >>>>>>  #endif
> >>>>>> --
> >>>>>> 2.51.0
> >>>>>>
> >>>>
> >>
>

