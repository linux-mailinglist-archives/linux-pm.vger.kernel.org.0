Return-Path: <linux-pm+bounces-41229-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC5wHA3VcGkOaAAAu9opvQ
	(envelope-from <linux-pm+bounces-41229-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 14:30:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D534E578BC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AE2F60E63C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A2AD24;
	Wed, 21 Jan 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kXtZuIhM";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tyEp7m91"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD3217F33;
	Wed, 21 Jan 2026 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000721; cv=fail; b=lTTraU7ElzAKg8QN82jZIduMfAKRNtIPT3opA5c5M/x/hn8NH27PsFrOnfJv2V3SqqPhaDItSIsuo+o2WUUM/+hP9IRLvNIfOguyU7aVd/C30MnwgNNOiVyKkyVW5fEbpl7hFYRq/ETeS9ivKAnBAf3+uBMxiqBM7NKEXPAom8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000721; c=relaxed/simple;
	bh=5aQWWgahCh/7Az58YOf280GjFvfy+S3mUUkCMoJthw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfdDl0vUJYX5PAzkWyJCVfEnvoJYxh0KjDIgnkz1WHA86IASvFLKvWJtP6oYVcMNsA69bONm8lc1R1XpKbP/B5mexKNovCXgdKuRB0H2aVWbVvE0yg5swFD6OzXuRSn24q4dVYXgfLwhF2O7CH291TMBQ/4xo/cOR3XE+yHEXj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kXtZuIhM; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tyEp7m91; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L0mqEu3498261;
	Wed, 21 Jan 2026 07:05:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=FBZthT/26r+T9lVeD8
	2ecM1Zaq35cRzDjJdMRxVfMZ8=; b=kXtZuIhMQitrBuZnh0V8Y4RtG1nL+Y/4T6
	rMjptcnyTjR/v4ZJUGfuVa8HzhC/RXINJPeSDTif2+c5Ff+aG5FG+K14o7oz5sQK
	PHumeowgUGk0ENm2vkKS+xL5WQQFVZ2CUC95niVkY7XoB/8KsX7PVGoa9AqCJL2Y
	PqtDgB0iPc8dibzC9lgXf6KMAadhmmHJHmPKxiE7qyzNqOiI0AfUIwqj3NTr4eUe
	tSNfwaj+TPP7PT7gBVQsRksOid53CFieX9bRD1WR5YuAsX3jC4lxiWDTBMwf7pID
	Icgf6gDmagKD7AGIOk7FY1Uq4NFjnr7uDJFXv6J5ZI2y2dfsu9kA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020120.outbound.protection.outlook.com [52.101.46.120])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4br7qjvsr6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 07:05:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx0cV720Fy40KGNF22UQ0K2HNwdsX+VwsNH2w2XIhaJ02zN6y3hs7zi7gptXLGJ8mHzuixkZ/LCP5aLSyBD3BSYVs8A779ns0+syAPDMzHum6N7dE6pzO1Q0NIV+mNL2mG7lV1h191HdNfWwpmqotitEwUfZlD1IjlRX+UnDqeKEmiOvMhIxCdlWmVERjq1LhsbtF7wN9IVhvMMuyMFrhLqpwxeq8hG7juw7HVvXaHsFxBwN7AMi1AWy5pNrK8q5rHz42lQBgabxNUqbUKb3HyXZpsnNEyw40DTfOMiShKTNxPd7yLv1LiPIy/m6KCbc3dx/5FURKdGBaXhnRi1MmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBZthT/26r+T9lVeD82ecM1Zaq35cRzDjJdMRxVfMZ8=;
 b=ULrgciaLDnOoLDXv+deUYzNy9ZuSGw/7cjnOHt42u2FmxWGPCOWfJIalaFpgmvbRpPU0jMDISYV038/D1aCmLGW3xAdNby0VtfFuD0OMG9N8tqdP+6lLNPD3vmHIEHy5SWx/0c68jLmEZFVXvCsomOZxUmNPgr4iewQOcl3dM89CqtxPThh3sO37FyKK5xzUsUpO7EBc+sNq4Bbl/MNEpDcjIBVtYvDQap4uQHYcXovSN7NI+HIX6TNBIbiX61NYKHKLXQ4plRIxSfifdCT3Ilr0tESD45yY46swlfPkVnkO/vvvRQSJ4xW0OeYerkKGwXLN8btJzeZrQmwMdbllww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBZthT/26r+T9lVeD82ecM1Zaq35cRzDjJdMRxVfMZ8=;
 b=tyEp7m91T6JL0CZGYoq2bvunwL3xWoKfM3baDvdmTAPV2BS+hv4+R272jbEQoNdA/P8h/WaQ9Jgha6tmnRCcqTojztUxAGl3pTi3/pxK46ws2XLyWRkRPaEjFwIDLzpYADHI2BVgLtMWqrKhVCMBfUOEuwW0RjvDczuV2/b3eNg=
Received: from BYAPR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:e0::22)
 by MW4PR19MB6983.namprd19.prod.outlook.com (2603:10b6:303:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 13:05:10 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::89) by BYAPR05CA0081.outlook.office365.com
 (2603:10b6:a03:e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 13:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 13:05:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 91FA8406540;
	Wed, 21 Jan 2026 13:05:07 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7C1EC820249;
	Wed, 21 Jan 2026 13:05:07 +0000 (UTC)
Date: Wed, 21 Jan 2026 13:05:06 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
        lgirdwood@gmail.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class driver
Message-ID: <aXDPAjgEgHvrezVz@opensource.cirrus.com>
References: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
 <43cb31d5-1423-4354-8eb1-68afbac622da@linux.dev>
 <aW+/J7id+7GhD9T9@opensource.cirrus.com>
 <74596131-4d06-449e-8ba9-30b35e0e2064@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74596131-4d06-449e-8ba9-30b35e0e2064@linux.dev>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|MW4PR19MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b1860b-6694-417e-b63a-08de58edb49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEHKLINhDZoddUEzsLUNjPm6IFipx0yFKNKS4jv9DEpme5fJXDXHnShkzSHE?=
 =?us-ascii?Q?S/xnQDzqoe0wJ9corJHZ6eJFg2cAqy8pZL/26wRGGkiVlFmpAw/CSa7Z48df?=
 =?us-ascii?Q?5AX5/rvi2z6vHi/Y3NkriDTdThQ9Um6htbkHxKu6crLKcgQ/Cchj2zaxPl4R?=
 =?us-ascii?Q?I6u4hYNeTmQd+GJgZZ+6wpeCyfUH/Zumch9PkqjnI695aD/70v9B56eiFm8V?=
 =?us-ascii?Q?8iLeJcJWbDNO3DtaBXbbesfsaivwch8KJKct5/heA4tlk64VxRpetItjfchy?=
 =?us-ascii?Q?p/dGvqEOEFxC7KEIzI/bgknV7eO3LxJWjDmQ7EAw9/6MebZoNe4DOoUFG5Rc?=
 =?us-ascii?Q?lXG++K061omIUWnMMMPHuJ0zSojJL7GyfS+4+ABeWJylBfbD/ydu7WAsyM5B?=
 =?us-ascii?Q?sb9WmAwOLWqFD7DmpyQ/AXf8o1ZBJ9ydPQQ/3ChnAax+f6nlafmdQ47aWnbR?=
 =?us-ascii?Q?EHOYodzu6FkxChvFCrm0uI0El5bvk1VS+3+ouajvl4SKqiyrGYcLMFNb6tbm?=
 =?us-ascii?Q?wYW7PTWPVkBMEAHQvzuRzZpNi+fkN9c6FBY4F1Nh1OW44d4SSM8OVrZW7QTk?=
 =?us-ascii?Q?x3r2GENaSMebA8gTwJfChi0Ddd/D9ugaejaGLWEUIMK01CXA6ft0JSEybNiZ?=
 =?us-ascii?Q?5+uyipI0tQ+ZV+aWr68onCGQZiZiaK6RFivrsO6Ysez2wHgs1CdM8q+1AoTz?=
 =?us-ascii?Q?hJCNBIVlDAqrXl1Zy0HZCZ0Db120IuapABP8CXdJbmnJ50tk0Cc4x2MvXFh5?=
 =?us-ascii?Q?MtAtHEaEwd4CijgYpZmRepw+IUWZaC5aBbxS6YKOTThmtfsd/XXm8os3xZuJ?=
 =?us-ascii?Q?l71FvpxCkobTepnVKxrZm+G1oiaIGUUgh5PegGeqfcFGJ3Mic296dO4ynlQf?=
 =?us-ascii?Q?3tc6aNeZ1gbxpL5su5ctc5WLE91WApRXNhFbbjM+SdVF9E8ygBjs3uManvK8?=
 =?us-ascii?Q?ddmvIkLpFV1+w2piLFTK359BulZFjPJm61xJe7CjiQWjcVOr0/eGqjBsSxcm?=
 =?us-ascii?Q?9BiMo0Myyo+hGfPRiGtCglz69VJZCY1JFa5mYp62wTCsgPHaNTeLZesFZCKs?=
 =?us-ascii?Q?cvNycAcbhMe8HgjrKAoMqLrWlLR00RKG3ExB19dXJHHgoYKel37R7ZIDUTI1?=
 =?us-ascii?Q?mGQW7aQtBrGW+/v0u9zsdsMJWb23lj0iSSjgBViiemctnsfkDvWcl3M7WyLF?=
 =?us-ascii?Q?VW43UW1zwMOojqhWZxOqoQZW+7cJ5V/DsmkCjHkkojNb1oWpxMaFFfE3JI8+?=
 =?us-ascii?Q?eEO5/R+jo3HyXUKAKYGkh+6E1wAXm34Y1Z8FOHMvYl0+G8QB0jkSPoEF+Zui?=
 =?us-ascii?Q?M7B7lL3cNGmN4wFE4W8L6hYGhV53u3Y57EASj+TK0+c2nZoKzMWLtD/WOvNc?=
 =?us-ascii?Q?u0Aetsoxow2wYdZFFVi7CFyDEieX+RTZVhkVi4HHo6AUoJbkUEOpwC8hw9WZ?=
 =?us-ascii?Q?h+Yx7MLTXv9m085VsNwwjfHI3aoV43hwZ3UuFTT6aJz2HHT8c8TyDlt2eBWv?=
 =?us-ascii?Q?ItvY3/qUVA9Engu1MA7aQYmmc+UlDgLqLKGfqc7Tppn9L64Vrw8SfEA0V5cr?=
 =?us-ascii?Q?RUGibdbk8uz7aLpLXMInPDWpj81Iu6IUQ85PGUuoGyvF1GqBDivy64j3JFnn?=
 =?us-ascii?Q?p6u8BnuluzyPeTDP5PbowC9cCq4BBDouG+tRDI212AV0Ify6F0yDD/yOen5U?=
 =?us-ascii?Q?4/e/Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014)(54012099003);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 13:05:09.0222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b1860b-6694-417e-b63a-08de58edb49d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6983
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExMCBTYWx0ZWRfX8Wufw29rEAGi
 ipmVyaJxarKBUELdkUcY+SBJiLxealQ1Vm3XsOEZIOmmPjlDsRq7LTq36fzTXKYz2q0Tb8ChSrG
 2TMQTTOXClCSfYmNC5lw1btD0IQ7geH9365u0GsywAulivxITGlRcoURsbYKFkJesaMNTPO6J0w
 FyouMyQN/onESI6kLWqHfWIriTuSwtXtGD0xN1dsMXsDgi30yRTg3c5NB+j6eiDJWnjn6dyCDkB
 WmbfgxkRUjTaM9JXGkMndebesMD/fzKWzHFr8LOWRnV0pE1wURQ+AQ6BN9rGdrJ/vJamO0Z8Vg5
 6PNsT5LiysGB+b1umx9nc+YmWP3O6beIyH0xCzbd3kurpVy9z4di/zAhVayl0DNdpQCWaLVbOpp
 o7Bq1jG2iYfyXhXSt1kTiKpsNYdfKHTCkY4aNWRGQhn1lNvFV84qR8y5Z+U4hdtmDr5n/ys5vH0
 JChKvcj8Y97Uk3DzjtA==
X-Proofpoint-GUID: ktlwTwO6REN0FtMP2RF2Szjjf_YUFU9J
X-Authority-Analysis: v=2.4 cv=GrRPO01C c=1 sm=1 tr=0 ts=6970cf09 cx=c_pps
 a=8oFNIrebv7KdPcC3sjE6Hg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jBUp83FWQ4oBY8_TjYYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ktlwTwO6REN0FtMP2RF2Szjjf_YUFU9J
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[cirrus.com,reject];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,vger.kernel.org,opensource.cirrus.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41229-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cirrus.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,opensource.cirrus.com:mid,cirrus4.onmicrosoft.com:dkim];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D534E578BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 01:41:31PM +0100, Pierre-Louis Bossart wrote:
> >> Going back to this SDCA driver, if the PM core does NOT
> >> change the pm_runtime state, then should the class driver
> >> perform a full pm_runtime resume and then do the expected
> >> system suspend sequence?
> > 
> > Yeah we do perform a resume in the system suspend although to be
> > honest its mostly just to force the pm_runtime_force_resume() in
> > the system resume handler to always do a runtime resume.
> 
> I think we are talking about different actions...
> 
> a) pm_runtime resume BEFORE system suspend. That would be
> necessary to deal with e.g. clock stop modes that are valid in
> pm_runtime suspend but not system suspend. It's not clear to me
> for example if all SDCA chips will support direct transitions
> from PS3 to PS4, or be ok with power rails cut while in PS3.

I mean I think this is currently handled at the soundwire level,
since the soundwire bus runtime resumes all children for system
suspend.

> You lost me with this sentence:
> 
> "
> For SoundWire itself the soundwire host resumes all children
> before a suspend, which dodges the direct complete.
> "
> 
> If the direct-complete optimization is not used, then do you
> actually see a different behavior with this NO_DIRECT_COMPLETE
> flag set?

The flag is applied to the auxiliary device children of the
soundwire device. The direct complete doesn't affect the
soundwire device, but it it does affect the function devices
children.

Thanks,
Charles

