Return-Path: <linux-pm+bounces-41980-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B8EH3kbgmmhPQMAu9opvQ
	(envelope-from <linux-pm+bounces-41980-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 16:59:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C5DBA00
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CFCA303484A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F33BFE56;
	Tue,  3 Feb 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J8DBOKnY"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B23BFE48;
	Tue,  3 Feb 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134388; cv=fail; b=CmFJ6frSIv9OJjfpwk4ARw+mivxS6eiGdDucHlgNL/DhHetpny2g2JpXtv/ZsaQXYanhQ3y8aVVWm7JrmpJXFm+i/RsgZgGOm/Wd26QsdoOwac6OM1C/yVFu9eP/sBXVEU0mJqtezsDo8Am5cIHAILwlv7wK3KYZ+5Kj8KQkDAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134388; c=relaxed/simple;
	bh=AXtMQ4WAWVZUzrhPi0QWJq4u67bPnwXfC9ttM+EFWlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UMVZQx3sdukoEb4IJcNtXQ1RjZwBDlbwWaAe2UiHdf+RvvVAKEbOi+7O4Jp5A+DMqfYZ/ybngZguKZoZRQAc5GIZEdYbOlaaD2mHkRMWwj8CuF31lumLQBfL6jQg7fMfqpBfpWBywk8TyQMlx6dC2SRD7yZqS7HgmzsTh0C2uDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J8DBOKnY; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L94c0x1On3eFn0i9rPV4yDsMqam5HpgGVeeRNT2EuLDcCz+yZmuC0dZDLhp+TLETZLQ0sohSokmXt9fXQw+Xik7RcMtGVysSskAK8wJh9iJt9End2aBMyZj6gOWsttFvryOmZ7EaG73RFIT1GV1odwCgQo++aF4jA6Id5XN0CeQyIeunSqSrGxyPYXG9eeJX/huaCx8vVy+lW9UNG748wOIppj8RhYgNJU9MyH0QHL6A4sMU8HVcqJQ/s6+QpwaaaWlgLMhUsazxizpgfuyhvs+asekx3Q0YiI2IdvVls0MdGX4UKaRDSMP0BaWeyrIfvbdngHI49sxoLn5mgbCUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxayv9oYFOwdjOWE6fs2W44/grfp70ZUbsJ3tFrqS98=;
 b=iN1XXSjDVD1YQDUtiKf7w596X81ou+ATNmIw7OmXD6Ik48gFBcopAKtG7dR3AlgIrmycHw+WSxQztW0ZMKJnTokmexo1i8mvKPJtE6MHBA8c04gD/ET3gZz+6AwtoAKJdZI+X5EbcTPSqKGa1qa1I5PXaM29PhV2jmNgLANQx/lml1KnDd3+20ZylskA4VPoRbSSM7wWZI+90QvEP/LzgECrBIZ69QQIIvO0aH3lxVUX0QB+oD0wRjPABn7bQFy5J84x5Q0vF3R+VCJWm2ggbzvhfW3Buptax4EK6m9ES46+jihagzxQy9H5xU96pDngUwIPl4vSJV9eDquaJ10HMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxayv9oYFOwdjOWE6fs2W44/grfp70ZUbsJ3tFrqS98=;
 b=J8DBOKnYT1YkPB8VN9pkBtcDdniKkY5zUeyKW3ADMk9umAfWvRlfHw4zVW5RjEp/oKMDkHXm8xwN6yspJoUDSRaZMl6IxXhG/4O3F2ieTbhoK7neT7Ih0P8OW2E1laa6YoAXjXRKwGOjcT0LzmzvcmFWdv5jmpIRcJ+R8SopAtvC7mHzpmOnFfLanr67/ZZIP9t8EKzE19z1gjOYTnhfFcXfRDu3ML/mUjIO8BRoYpF5o9nprhnzD5xsi6U0grcpNhnD2DukmcZKifYuG2FORoJfzXCY4Yzy65i+xtdXoyphX1hM2WeN1+R4bUvNhvNESCqn114Bbvp+Q0J0ikN53w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10728.eurprd04.prod.outlook.com (2603:10a6:150:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:59:41 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:59:41 +0000
Date: Tue, 3 Feb 2026 10:59:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Message-ID: <aYIbZ3PwiKUfp/eL@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
 <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
 <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
 <aYDP847mgleQBF5Y@lizhi-Precision-Tower-5810>
 <eb335daa-ab6b-4cff-bea2-90160892bc8f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb335daa-ab6b-4cff-bea2-90160892bc8f@intel.com>
X-ClientProxiedBy: PH8P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::23) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10728:EE_
X-MS-Office365-Filtering-Correlation-Id: bded904a-c41c-4cab-e507-08de633d3de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dpf5JjkWIzDQf8tq0FoQuturl5tzfY9i5bCf6Uy2RlKuWuL6FWDw9srZg1ig?=
 =?us-ascii?Q?RK23yaYZDYF1km20onAa505bAtIzCCppdrT3kwOjwfJVR/v1/mGd7qBhv5qx?=
 =?us-ascii?Q?S+fYwMR20rfFe31o399EMawZdUqgFSnSVOSdQmleYdd1xMc28ctnFD9JALE1?=
 =?us-ascii?Q?ZzI5cKjjW2G8rA+u9JeZOyoGJDybRweHmq8NeWmHMi9MgaO/0VQxtSbWieW0?=
 =?us-ascii?Q?PgyWgLc49F3oWVAjCgGlY/mAKAlROubciGWolhi5n40H48ZZ1U/XeCWqmogX?=
 =?us-ascii?Q?QzmyMMzEiyobPcNUPfZ32rDPMX0v2pl6FeY3a3G0/t0qLPvaJz8v3fBSZ/oZ?=
 =?us-ascii?Q?G9+5YZtk7muCjTD5UF6xpe5oRN9J0h68DX0KN2MTqhd1mnkm04USgcdwV/pH?=
 =?us-ascii?Q?dgKGiuiEaGORtY1+Zq7tnhqserQ8BIwlqhUpo5XmhEl3zfJGQgM4G27REkjJ?=
 =?us-ascii?Q?7zIGG8T6KYiUgJfkrtBHBtneNHbCR+SRpJG7e+ggeaunKYHA0GA3aW7SZdCn?=
 =?us-ascii?Q?hR5W1kG8WaldhaQIm3Z2s7KxqBTzKBrZD+lJL1ZrBdsiAv6F7gMFn1FItOmy?=
 =?us-ascii?Q?PHLLFDrBtGXyU6rbJFY1ZXE4Jeba23mVIUVXwaAVgYK6bxK0ANfdOviIXZIX?=
 =?us-ascii?Q?IDsaeaUJWwFK2xf8ud6ufp3ELDqOA0PTgHf+6tP/E1mka35av3A0XNN1z8rK?=
 =?us-ascii?Q?rB4r2BVTKdUeKR46/VIm4pPIEgJAqBWjPYSs+PjCd0Nvv5IEGfcZzhyiHNqn?=
 =?us-ascii?Q?787LuWyH6WQLSBE1HwG8l2tHDnI2EztX/uYT+MKOelsCxEbw70Suwjs4G0nM?=
 =?us-ascii?Q?EL76buTc2SBUVz4cxlgB4wvMI5mBC2jkwGsjQvdQWYGYPdMcThtAiEMZdCXo?=
 =?us-ascii?Q?od7yJlFYlBMLdPm9NuZkODa7SxZjlRCDumfB4lXYNQTFoavncO4VaqzVwNFS?=
 =?us-ascii?Q?FJyY6g0Mjedl/u2IcLv7bnu58EDgsNAIzvXeJZSYDBqxIDt3kC7WXohGlOr5?=
 =?us-ascii?Q?eEv0OEihrdgGSVNOZrMaV1QS3Py+pJd6Cuh1HpH4frDaoEbUDTYPZ5062/dD?=
 =?us-ascii?Q?QnAc2hcsU1HgP4d9k5iLJ84tRj+tkA6/BNbtS0mtuv83UHL24eCpsCTluGef?=
 =?us-ascii?Q?gfS47q+A2DaBt/d9UwFoyz/rVlkwHpe21rCJfFTMM/Et/RP6O3Z2izJMdYNu?=
 =?us-ascii?Q?MC+UGxspp48Wi9ge8WBht3QfUyGWHv5NGzbWqety9kgXd1ZeZfam8GmBiY6u?=
 =?us-ascii?Q?FbUHCFWykF2F8G8vFuLBOMAqoBVksldIPDSLfHeFyNWxOzctxTuSIXgVIGAB?=
 =?us-ascii?Q?fYu0qD3YzrUSvN+ucQ6ZsqQjT3d5JGADCDAv9WtiNxCKyDugOwaKn2IZfGPq?=
 =?us-ascii?Q?vbT69zvRHbM32Bk/0u66Kkc3umT8aDzxsrjJ7kWyNocr528jNv01j4s11cjS?=
 =?us-ascii?Q?fGdfb9GS1/Zfiy2ArbdHQDfCnMTImj0sT5y7lJyWA4bgWw7B+kjw0NtQb3Vc?=
 =?us-ascii?Q?YoroekVSfMCcekeU2nV9Kr/wRu8eqfLUUFe+E7DJYvSH+tVOd9FLu/27ekcO?=
 =?us-ascii?Q?GguJbQqh34H26GnZgNXOpGwi3ypXRPN0gLyboNWEUIOG4/6OM68UApSssV9W?=
 =?us-ascii?Q?dFXqGKIUpYWS3Yu/+vAHbsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rU2wkJWD7WhZMnYAs6K8BEZaInqxZ5AXg+sOIVzKbuh/W+Ma4yb/kptmaxU0?=
 =?us-ascii?Q?j7y2nioT9uLHqPw2zX8/RHlRvSVngAWp3RlWn/hoIM9TuvA5zKP92yMPDD9+?=
 =?us-ascii?Q?ZT9Tb7OmN/blAE/6f8+3GCo3YYK0gFbcLCmxrrBxUHEHP0su50hNK9KafpCM?=
 =?us-ascii?Q?YKO5Gq+VBLk7dm4KYYmL5XONa7gkx+xXJdFIWaTY6bB6QuV7BmZ6a7kwnyd6?=
 =?us-ascii?Q?RrRKXLfa3CXGvfHwwPdLW0NZ7p1tvhiXV3xVldrvhgxCK/LCcDM3yL7ISzLB?=
 =?us-ascii?Q?SBgC31AiPx0/jLixKAZqgaik9xVqiWIXMYpgWW+G/6zuyDYTSlpGAVpQfqEj?=
 =?us-ascii?Q?Gp10MZl9Ckil8wV3raccZAlFUO6FMem2FgC/+7OOmycNXDRMT87TplsYTd77?=
 =?us-ascii?Q?tC0Dl/N5XaW78NEJyesJcyYX2JVDiUUS0Lkqr04u0IBYhqGHUOEVYBceL45R?=
 =?us-ascii?Q?Qlwh++tN2D7n1RrfSAzKJdtJIVQ0wSccVuZzlf378Ce0Yy/aDfADj29gsJnC?=
 =?us-ascii?Q?plTI8mcMR3g0GnXT+1UL9FN7MO2WRCUkl3yGcj2G1zLPtTBTKSa4O/d4YdMF?=
 =?us-ascii?Q?cU/RMdrCzTFGFpvrAaiQU6s9jL2lkq0sUI3yUd6rprg7JXjmolbsTADps3Jd?=
 =?us-ascii?Q?CC+DGC9/0+g8L6O2TI8ZAq4OLN/cKCVMgAOl2uY+otWS7zPoUGWI1zc8k8zy?=
 =?us-ascii?Q?hmwiS48Jeeqqzp6C2Je1wnFu7ogGVc60rL54xpyjqlxU3qb15MXO8h5DRIFO?=
 =?us-ascii?Q?cDg6nL3pz2L3g138eFz1Zd0cH0+cWALA/IBd6Vg6yWQDH29AKRyWJnv8g9yh?=
 =?us-ascii?Q?DkditIFAKo7+sNU1SUoQqBR3ckqdyMQazfZN3mYpwasr2zeGXF3P7aWMY8oz?=
 =?us-ascii?Q?78jE5z9BeZIHK6qHkeBx0ViUckCHqCK/Uh9zdiiJvAvjUhDAlF+zuURyzjcI?=
 =?us-ascii?Q?Nfj0TYFA9TGPJNKpznJ0h7OvX0Zc3nHmuV4QCjTFeZ0fZMRIYpsaHvSlFhO0?=
 =?us-ascii?Q?/KQGq4yGnWFYftma0IOiPylYGsZeczUUd9GxDY7+kbHN8Uk2BBcavrt3t3Ej?=
 =?us-ascii?Q?5ObGDceuabC0/3Q+x8vF3KkulyIs1srZWMmcq9B4N8AGbA/8YWlm4P3QPe6k?=
 =?us-ascii?Q?Bi5+PvT7c86mINwPK4THlU9wHrkGr/KoeMEKe/2D8xhfPIDxqHlKjEdBh5hA?=
 =?us-ascii?Q?IrP83NqCljVvnocGwvS7CiPySUHnpshWBU7XO+kQ01AUI6WZurjrq/VDk+aF?=
 =?us-ascii?Q?EFSC1jnt60ZeF4cFIW7bHNN73LFuZuK9nvBgqOo9VanKuEykdEYXvAesiUf4?=
 =?us-ascii?Q?dyTBKTSwbYc5tbBI/OFq5jQv/e6TxliOp1bK8v0xVkxFEHJnNk9AAOU2fund?=
 =?us-ascii?Q?aVTpi2UId49s38tiYRMXVB1/dOVIR50jQXusRaYgsJdi2N9qv5QRLUBzDxJR?=
 =?us-ascii?Q?2JkvtGOLGr0Pjy+6Nun4RLAL/c10JWgDr7AepThRCxZT8Vln4NxoNQRiW2sV?=
 =?us-ascii?Q?k2p4RdE0p6krJVDt6ha+0pcC2BmFIAVmQNVUszWu/e2cTMU53Evzs7jIiGDa?=
 =?us-ascii?Q?IQEk0g6QC0hFz0EY6aI/I9arhdJ8yHJ36rNH470UfIAtD2FDw3e0qdlGTmqM?=
 =?us-ascii?Q?yCGudONAaK3Xb3/VQWrJzySWVtbPg4AVVAWlHgOMc9EO5ginAQn2pPyA/6su?=
 =?us-ascii?Q?1ibT8wgmMILaSjnM2R67akh8APEyD+nW3+VnvcR9+bQ50e/xQ/YdcsL5J8hf?=
 =?us-ascii?Q?1wl14Wclag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bded904a-c41c-4cab-e507-08de633d3de3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:59:41.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0rrZL+Iw+60o+hd7fU2j5eYlKcXPmOyPN/3bbF0wlgT4dZpA4ulHTQTnrrYEJxv2u24dfqsjc2Unf5i54V1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10728
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41980-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D0C5DBA00
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:54:44PM +0200, Adrian Hunter wrote:
> + Rafael
>
> Rafael, this is not at all urgent, but when you have time
> please have a look at this patch set.  There is also some
> more explanation below.  Is it acceptable?  Is there a
> better way?
>
> On 02/02/2026 18:25, Frank Li wrote:
> >
> > Does your device Hierarchy look like
> >
> >            PCI device
> >                |
> >        -----------------
> >       HCI1            HCI2
> >        |               |
> >      I3C M1          I3C M2
>
> Yes and no.  There is only 1 real device : the PCI device.
> It implements the MIPI I3C HCI standard which allows multiple
> I3C bus controllers in one device (in our case 2 controllers).
>
> The PCI driver mipi-i3c-hci-pci creates 2 platform devices,
> one for each controller.  The platform driver is mipi-i3c-hci:
>
>  Driver                        Device                     Bus
>
>  mipi-i3c-hci-pci            0000:00:11.1                 PCI
>                             /            \
>  mipi-i3c-hci      intel-lpss-i3c.0  intel-lpss-i3c.1     Platform
>
> LPSS I3C also supports wake-up from in-band interrupt (IBI) via
> PCI PME.  The PME only works when the PCI device is in a low power
> state (D3hot in our case).  Also the PME is effectively shared by
> the 2 controllers i.e. an IBI signal (the controller's SDA line
> pulled low) for either controller will cause the PME.
>
> That means there are only 2 valid configurations:
>
> 	1: Both controllers enabled to receive IBIs
> 		PCI device	D0
> 		Controller 1	Enabled
> 		Controller 2	Enabled
>
> 	2: Both controllers disabled to enable PME wakeup
> 		PCI device	D3hot
> 		Controller 1	Disabled
> 		Controller 2	Disabled
>
> However, represented as platform devices, the 2 controllers
> runtime suspend and resume independently from each other.
> Whereas they effectively need to runtime suspend (or resume)
> at the same time.
>
> The proposed solution is for the PCI driver mipi-i3c-hci-pci
> to take over managing runtime PM for both controllers, calling
> into mipi-i3c-hci when it is safe to do so, to save/restore state
> and disable/enable the controllers one after the other.
>
> Current situation (I3C next branch):
>
> 	PCI device	Runtime PM enabled, dependent on child devices
> 			PCI subsystem controls PCI device power state
>
> 	Controller 1	Runtime PM enabled plus auto-suspend
> 			I3C subsystem runtime PM gets/puts the Platform device
> 			Runtime suspend: disable and save state
> 			Runtime resume: restore state and enable
>
> 	Controller 2	Runtime PM enabled plus auto-suspend
> 			I3C subsystem runtime PM gets/puts the Platform device
> 			Runtime suspend: disable and save state
> 			Runtime resume: restore state and enable
>
> Proposed (this patch set):
>
> 	PCI device	Runtime PM enabled plus auto-suspend
> 			I3C subsystem runtime PM gets/puts the PCI device
> 			For each controller:
> 				Call into mipi-i3c-hci (when it is safe)
> 					Runtime suspend: disable and save state
> 					Runtime resume: restore state and enable
>
> 	Controller 1	Runtime PM disabled
>
> 	Controller 2	Runtime PM disabled

Controller 1/2 is child device of PCI device.

So first patch "i3c: master: Allow controller drivers to select runtime PM device"
is not necessary.

You can enable controller 1 and 2 Runtime PM with dummy operation.

When controller 1 run time suspend, parent PCI device will reduce ref counter
when controller 2 run time suspend, parent PCI device will reduce ref counter

Only runtime pm reference counter of PCI device is 0, PCI device's run time
suspend will be called, you can do actual disable and save work.

Frank

>
> >
> >
> > You want HCI1 and HCI2 suspened only when both HCI1 and HCI2 can enter RM
> > time suspend status?
> >
> > Device Link can link two devices, but not sure if it can handle cyclic
> > case, HCI1 and HCI2 depend each other.
> >
> > Or you create common power domain for HCI1 and HCI2, in power domain to
> > handle suspend.
> >
> > It'd better ask run time pm owner to provide better suggestion.
>
> Ok
>

