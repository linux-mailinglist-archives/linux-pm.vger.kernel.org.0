Return-Path: <linux-pm+bounces-41186-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IXCCJfgb2n8RwAAu9opvQ
	(envelope-from <linux-pm+bounces-41186-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:07:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9314D4B05E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 666E99E7BB7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACD42980C;
	Tue, 20 Jan 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="S7NjTnwn";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="yx7doTNk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D72429837;
	Tue, 20 Jan 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931161; cv=fail; b=b3ZN4nG3nKa74Yp4SJDEowbFUJ9kjrwIu1w36h9fNNBLFY7AGWTX1rCuA+rl5CiTsbOYKlvnOcoUBU7h5AAQ1PL3jQTzZmuSLngCzGVVqOgA25jlHO17oaI3ds55WqFd0wTNoGMMJ2Vv6yLBFu/0iEOWTSDejy9tGurZUlhTeIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931161; c=relaxed/simple;
	bh=+xAkb0zBZnpf6Kpynu3vcF4Cf3yYeXQJiNZ2LxCg/vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogLcrC1O6V/UsUGSivG3C3sN6ucNhDuknbr+i8UXR7ak91vTm3Ypb/y/FK/RIJNmytpDHafxz75Rb+1qctuOmGzk8wBGkpJXdWrAfC01X8dliM8bEIIGWmzGZrKIZC9n7/J4K6cRwQldxo0a/casaeZXFYShbPe9ipq71iWTrwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=S7NjTnwn; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=yx7doTNk; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K5R78t1026485;
	Tue, 20 Jan 2026 11:45:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=XJZrJ1CyVuUgZpGnZs
	dge5eCrHWoWAJudQ/JYKDIGu8=; b=S7NjTnwnWQ5OISsaYoeZcAKYjNBPR5j/Z4
	6ufsPAw0uvOt4l43SPIlXhdRChdZ7nOxxJz39zkFENCP0a464TeJN0b62ISVjW+7
	njH0XQD2lU+CrmM8NCq1OWdOLw29i8WtuEokEucqZnwBitzP67GA50IzblPCF7+G
	uOfkAnWf7QwFzDEtivjIQrgnhHgyXI+/ykCqUTDgiEGulI8ZEHFlE5LhAAAizDt/
	6VLmd1FmvXerk7kIRG8ZSN3XlwqKb/sCKwC7CtNEQijQcNJF1Fxa5MzixPjinpCP
	KNEwyDYbloCB64Hf4O5Nr17PNYHtKlr+5Km5QNXJ8DGn+g5ff8Xg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020108.outbound.protection.outlook.com [52.101.61.108])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4br7qjurcu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 11:45:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSqMUWR4KXYwXCvYgh6TCniqkXRbYa4tAbUONefS6Nemvr9RfUxs80qkQo/7e3T8JYAMsDwPJZ/jyyL5lh5DE6gmjcFGFc6ylKR6sZLU6XjHMVITJkeWi/Son9iYUTt0Mx5Of/gteKxmHn8Y09Cy9oqprkezZsfBrb0gRYrX+zIUG4TOK/+BD5q2LFDejyVngg5mcXE+RHjk6Ahvt17XHmehb/cUYk5R3Y0OsLdKHDY2RxqXZ/zyaLw5iSfWYxkVbAhsfGRawvW8WydiVPzaT86b+MzsnJi132WfNiDUGWq8L5ux3cE6nkcoyIK5JtknL86owei8z1JhQDwA9UCMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJZrJ1CyVuUgZpGnZsdge5eCrHWoWAJudQ/JYKDIGu8=;
 b=V59Mw5S3TQeumsyzO/HDUk/OEBAc1j+ioTgGzxaDGrNVErRUsJHGkFxUL0h4ROeWR6q/nCdxdeC+o86FB9tNCIxIg81nHZTw7ENntSmly2c4+a6zaxTN4qRJguh/etkxuQ9ee5UkApI1yGS1xqFXADuv05d8Fdb6/KKEtcsD+MQEbc9P6beYFXR7alCV3lgXggw87XgxiCpPl6Ju88qZdCM1MrVikjb6lwqHyC/mc0mW3tmDdMYjT9onixzsNYQvJrXuqwumGyCa2GXhvCu8cojepkd0AeWFvHxDZGqJeAYIYXS/bowFXSeCFD8UEjIotFx10NRl1GvnQgyHEtz68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJZrJ1CyVuUgZpGnZsdge5eCrHWoWAJudQ/JYKDIGu8=;
 b=yx7doTNkDR7M+7rJQIn4+Y2k2UGxii0TN0sAE3csg4x0FteV/bZD/PWQgawBDFy2PEqIAPT3xB0AH+3yh2HNNH3Cy4VpgluvFU8T1RvljBo8m4cMknHtPnBBNjyZJDTwgAzCgHYoglpivW1v6YScXrOVr3LQkGj4hsuui2Y569k=
Received: from SN7PR04CA0046.namprd04.prod.outlook.com (2603:10b6:806:120::21)
 by CH3PR19MB8328.namprd19.prod.outlook.com (2603:10b6:610:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:45:15 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::49) by SN7PR04CA0046.outlook.office365.com
 (2603:10b6:806:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 17:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 17:45:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CF86E406540;
	Tue, 20 Jan 2026 17:45:12 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B8CB2820249;
	Tue, 20 Jan 2026 17:45:12 +0000 (UTC)
Date: Tue, 20 Jan 2026 17:45:11 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
        lgirdwood@gmail.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class driver
Message-ID: <aW+/J7id+7GhD9T9@opensource.cirrus.com>
References: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
 <43cb31d5-1423-4354-8eb1-68afbac622da@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43cb31d5-1423-4354-8eb1-68afbac622da@linux.dev>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR19MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c153e5-2ea2-4298-cb74-08de584baab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KP36mqWmA7tMzoZb7YQQzQLtQuu+EYOBODJcxZSdmZb/O2o9YGNLwrjY/mpV?=
 =?us-ascii?Q?iliObr3Z5lRVy49V7aHlmQgJeMeI1nb1QQX9BPTGFL0Z5XMVqC/n6qgMXXvi?=
 =?us-ascii?Q?OqeqcoDdv9JzB/myojVx+gE+K7G+5/G31KBYcK6nLBzI/8aghv/LPq42P3cr?=
 =?us-ascii?Q?ov2x+kzjMF8uyjjBzAsg5neqLkPUIUnTHrVSxD6aEMJh8NKnoItY52U2k37Z?=
 =?us-ascii?Q?Jxi8TxtAjekyYu5ErovbhkgER2aD9VoMO6eD1t84zayGpdmouY7kfoJMt5t7?=
 =?us-ascii?Q?6Z5S3NAsEZgz6mRuIA0vk9FNre10TUGZHfDY3qiJXS93QLy718xfW03LkT6s?=
 =?us-ascii?Q?dLPjbuaILnIn2oIfWH/mtT5+vxL95hvRi4tf4T8VSqJOAYYaCpXtAxi8czk+?=
 =?us-ascii?Q?Cha3qXkftPZKKF3tLPWrN5emLWzV/DBpKJI05Z7/w9UwG8yuvTPXr4GAxkcC?=
 =?us-ascii?Q?mQ/Qx81sjcbl3ZmCu9V0xFnIXwUHRZ+bDfvOKBwmOZ7zTG2CJt+7EpMRxnA+?=
 =?us-ascii?Q?xVX2Rsl6HRB4v+ryKD+ReZuSkB5vFSou2Is+ekgH6CwtnznwaLx3OMgUm/ZY?=
 =?us-ascii?Q?VHsZ48oJWqhFjZLBDqAl5w5ImHgpAR/4oC+lEzyNIv7PxubIJV7BNu67KT5O?=
 =?us-ascii?Q?qtNdtRK1SwYS7RbfEuTdkbIAnAEc2+g9yVAXVe+kuaovO/JhoNR+y0fhe5Z+?=
 =?us-ascii?Q?rmUWfD7G+R2PFZY9WYdGmikw0qcph9n2/GvbPQtK7pgMd1KVC5HGkkgcm7Xd?=
 =?us-ascii?Q?Y9EJXMjOxIORWmA0pgrjWwheVfjwssmZtvMKZm7pdcoV0j6hEF/R8heb1ZpL?=
 =?us-ascii?Q?xptT5JPjcjhdick5wrRDKx0UdenIEiOTpNMVkoQ1IcK5Tirk3BCoHzCNYtOV?=
 =?us-ascii?Q?9/Ilje4dWh+Y/ImNuONXBfsJsVP4JQuWDetIWcwl4aXo0isoJbJpm5A2SJVT?=
 =?us-ascii?Q?e0Dmaaz7HL7KdqHLPtPQhhGzbHJe0JcAcaXGwutsnmEHOoMVPx2Qm4KkxxAV?=
 =?us-ascii?Q?DRZ9QDR+7B53E53m5CgtS7WA0e59yugjmQwVmUIXz8imWkqxmAaD4z2wmTns?=
 =?us-ascii?Q?ZbBChqE6znedBb+VltY6NID21K3dLOfeEEbDYdU+lZ3Kwy+X39f3+NJ6lSjS?=
 =?us-ascii?Q?w5EU8KXRGFAIamrk+MesADLDXRGrKjVO8+0isgtCwUEyYsEvjDbIPRm8lzXD?=
 =?us-ascii?Q?2ngiOH8YJ/DK9MexdmU8bYUJXdSTTPMyqOidQcRCohC9dEBn2V5zw19JzVy4?=
 =?us-ascii?Q?6OZpqqMr8zfNR1FtK3lmjaowq3ksbwVteWrYIj4UgW+ghuN3ntJpVZDdoBYm?=
 =?us-ascii?Q?OjPpnWKV/GQLfdH9ErXeFWe7Ibu5tnpXJlLM+eH3JzB2qHACAzINLdn5L40T?=
 =?us-ascii?Q?gw28S3Wo0G/C1AhVBddjx3XhwesTzeEXvSlB5ipSLlceTnr8n4VX34RpWGox?=
 =?us-ascii?Q?Lb5CFnta7kJuy0rr/t1PqkT/VbvYA03CCULo80Kjj8TzHRjYD0QkEL7a3Uxg?=
 =?us-ascii?Q?Myp3CAmH6VatiXdG2ibSCQmkwUoBD42FdUnm5MDX+hPJb2vF15EoJ5ajwmYz?=
 =?us-ascii?Q?o2s20np7D8239eTTN/8Nc0TxDrBR0aWItn4YK1MDQqLYtA9FBUEQSdKjPb9e?=
 =?us-ascii?Q?KMTwUSPSXsdpNKgBoVs6cVz3bw0G+xuCaiW/uzEG/90R75z2y6gS9HsrM4r/?=
 =?us-ascii?Q?ccy7oA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027)(54012099003);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:45:14.0559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c153e5-2ea2-4298-cb74-08de584baab9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8328
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE0OCBTYWx0ZWRfX9Hen3zDTA4V1
 gNnmDj8mBidJjiP1TUtx114ct6CiOvME/XLNOCP4sbW28wO2hvT6phmio2TzedJkyLc1evGxxZP
 mTKsGyhgFGWU2kMKt//SCWNdxEJrZDMID2Rg5sjE8NKOT77f1QnVIn7loPngkElLEVNMGtQg8ZZ
 NxLOqNi7YYBkk06W0splYtRXEhnDM50cWYBocp7sjlGd4Kj7AP0sNOyUZZUSStsGT10uJUMb7dJ
 k6enrj1O2NCeFcWg+6UNGkSQPjpB3GLWubdQqAWq5qM1ZIhhTCRQlRH5PsZypGa0x68wPSYqOil
 zjSVgEXe5T5VZKy+PRQVpYT28xtgl8Dc3UbLso9qXWKQ/+SQr/sjYGBFH7XrTmAk0vZWZfqnQDr
 8+CcC4NBfBb9r5lqIAlCtx/XW1YuUK4FYB8qYSkj17vh5RkTAOu0Fpszbmxl4kWA0ejXQ1ZnqBa
 yrCtZK3a+vzWTb/gUkQ==
X-Proofpoint-GUID: OUipNY2gtymbGX2bMAOJD86HTsK8YnBI
X-Authority-Analysis: v=2.4 cv=GrRPO01C c=1 sm=1 tr=0 ts=696fbf32 cx=c_pps
 a=W/yVf4yN/6DpLKuKUOvioQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jImvNv5maQe_AQZ0X0UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: OUipNY2gtymbGX2bMAOJD86HTsK8YnBI
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
	TAGGED_FROM(0.00)[bounces-41186-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,cirrus4.onmicrosoft.com:dkim];
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
X-Rspamd-Queue-Id: 9314D4B05E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:50:29PM +0100, Pierre-Louis Bossart wrote:
> On 1/15/26 14:17, Charles Keepax wrote:
> > The SDCA class driver currently expects the device will be fully powered
> > down on system suspend but not on runtime suspend. This is typically
> > required as when audio is not active (ie. runtime suspend) jack detect
> > is expected to still function, but when the whole system is hibernated
> > there is no need to recognise audio jack events. This means the class
> > driver needs to always be informed of a system suspend, so the direct
> > complete optimisation (where PM will skip calling system suspend if the
> > device is runtime suspended) is not appropriate for the SDCA class
> > driver.
> > 
> > Add the NO_DIRECT_COMPLETE flag to prevent this optimisation from
> > running against this driver.
> 
> Humm, this flag makes sure the class driver .suspend method is
> called, but does the core also force a pm_runtime resume before?

Yeah this ensures the suspend method is always called.

> In other words, what is the state of the device when the
> system suspend routine is invoked by the PM core when this
> flag is set?

Can be either runtime resumed or suspended.

> Going back to this SDCA driver, if the PM core does NOT
> change the pm_runtime state, then should the class driver
> perform a full pm_runtime resume and then do the expected
> system suspend sequence?

Yeah we do perform a resume in the system suspend although to be
honest its mostly just to force the pm_runtime_force_resume() in
the system resume handler to always do a runtime resume.

> Sorry if I am splitting hair, in the past we played with
> these PM flags and always understood them in the wrong way...

There is definitely a lot of subtlety in this part of the kernel,
hence why I CCed the PM people on this patch :-) Its a bit of an
odd optimisation this direct complete thing, as far as I can see
lots of drives don't run it without really deliberately avoiding
it. For SoundWire itself the soundwire host resumes all children
before a suspend, which dodges the direct complete. I would
imagine a lot of other peripheral buses do similar. For MFD
children they are almost always on the same fwnode as their
parent so they don't hit it either. Turns out this class driver
is the first thing I have worked on that actually hits the direct
complete optimimisation as far as I can see.

Thanks,
Charles

