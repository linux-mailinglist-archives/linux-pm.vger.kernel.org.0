Return-Path: <linux-pm+bounces-41212-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LW0Cfh0cGktYAAAu9opvQ
	(envelope-from <linux-pm+bounces-41212-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:40:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3D522FA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5655720305
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0B449EC2;
	Wed, 21 Jan 2026 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kfDSXS96"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E534E751;
	Wed, 21 Jan 2026 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977529; cv=fail; b=oIHHpS8MRyZILwSP7y/j2vSWipZDeWymH1XM2bmJvoKKa+eGYNXM7DQ53eRy+KgG2+5DUC/HKF6vch5BQ0avm1LUJKoKqEf2mAnOOC8svWD7s1zLMxFXmC8CDkJUWhCbwDn+n8rcicw7Qjoo+DsH+wVxwMyxAmY4oCgS40GPlKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977529; c=relaxed/simple;
	bh=qW0gNw1Nm0/4x6vf42T6toV5LKlK35RUlfpBKP5/K9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmyxPgtTP5nf8i5t3Uad+1cbN+Gyail1bcM7AW7KU0yTOSaTsKmmEt811LjFpqfNzvDVwE0dqMPmEXuQJlN4GKU5LFMPTWgrs2a10+080aQONHde7SjJ0myw2nYxOs5dCp9IT99OX3BbB9nqorRiM9x9P2FT5GQoyS/2bH6zWWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kfDSXS96; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOA0THjBG91E5Yo/dyaFRv1wqeP6z8C+89GKY6MzWNs+gHLKy46MamyV2+Q4hErg0Eh51r+d4EDMcsOx+n/amE/IPO5VqKnLfegKKr9nDxmczAuwUvwG+5zWAIuYry5VO3xbMdOpNkFWeL7eqbhB5Lth4Cw7e2C7TxA5EgkwNXtuwhjpxNlmulsC2iFvQ62E6utaEoPRUuAmOLMg+Y7ggMgBXCtvWiaBYujNkTAe7oHlNthBBAb4MjvOAl4qrSYCCB/lY3FNV0ljFEPtGB/vA/nKrj3mxzDRfH2vyuZosdj3EAgAh2cy/wBI4a67JMUpLmDDhzNZ1zv9zDbXdPsUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG+bnbMbndjgHIVfw7MzWNqqZg9uNKL+CmdFihtFAww=;
 b=DSLhgUmAeLtaeElyMzmJX2wZhRN4CRtCjrLFAOuXDts4AG8pBmrL8f5kxlfFTcg2IW+nYdw6e5NG05WtpcZrt1goNDzrJgkQ9aEGmhZoNQT6RPIhCd5P3oS5R0dkcxJ2RDhUcC0gajlixcjW3AxX5FTbDMiVHRaD9XOFdzU9qIErn4xICKeeHhnYwQ27Rjb8SNs2jIG/mhl7UN5T4u/q47lusGWjzLVYJXcgaK6da2KEIsnY65DEj/UNiEVE8q70izBBi4FEKjO7+kvWD1d5siWOhJ6gz0vNk/xAtUiacH8GsspcDtVMbpcLPPTzEjYSz36DpGtNG7hJJi7+4cNh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG+bnbMbndjgHIVfw7MzWNqqZg9uNKL+CmdFihtFAww=;
 b=kfDSXS96R9pgueNZ/sj+rg4RxeT2w7mJiLto3lU5fq84FHp7zNgLJOf2wZLhOxk14Wt6rQn3zsZs+33WbPsP6w5rvc/1w3sEVmgIozPKuuEXIckdK0eUo8F7M1GRoFsu6BDQfYq7QtbuSw1gNPpuCoaPnmqFc7E9NpgKTIQ+29Q=
Received: from SJ0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:a03:3a0::23)
 by SJ2PR10MB7109.namprd10.prod.outlook.com (2603:10b6:a03:4cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:38:43 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::8c) by SJ0PR03CA0258.outlook.office365.com
 (2603:10b6:a03:3a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 06:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 06:38:43 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 00:38:42 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 00:38:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 00:38:42 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L6cfvl2545237;
	Wed, 21 Jan 2026 00:38:41 -0600
Date: Wed, 21 Jan 2026 12:08:40 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Kendall Willis <k-willis@ti.com>, Sebin
 Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] cpufreq: ti: Add support for AM62L3 SoC
Message-ID: <20260121063840.tngolbewageekveb@lcpd911>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
 <yjpk2duxzham3ky7bvsu3majkjlypkvnc23dsxenfx4ykejpcp@uuohmp63qhwk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yjpk2duxzham3ky7bvsu3majkjlypkvnc23dsxenfx4ykejpcp@uuohmp63qhwk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SJ2PR10MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: d56e926d-a326-4442-45a9-08de58b7b899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bv+9cQSW1DKgfcErIsCEbIy4ScvOwNcNM6tXxvk3FDi6fVQlialKhgj+Ur+j?=
 =?us-ascii?Q?Mt9AXKSu//AIpWck6A0qtifqzHS9ri7vH+7+qW/1zS63gsvkpdwceGif9OUG?=
 =?us-ascii?Q?z2Q8ziedRJVij1CAQa1uTdHBMzw+vduhlIaiHSvlBrlZ9kApMlFBg2XBsWMa?=
 =?us-ascii?Q?AOF9wt0+D8j5ou1rFCRvEjDUPsZNRUXjC4RkAuyA1+QHtUs6MaNCwMX0/qeh?=
 =?us-ascii?Q?Rmdrg9wfvKfAnexcvjJsqm98NbA22AdUtgB9ZdLAjiXcNkx8bP1SGK1Ybddy?=
 =?us-ascii?Q?1ONs7Jy7BcaAyA9oGtLxTGnACKVZXDiVnPeXYUGeKdaP6t1f5QrTwX2mlNoM?=
 =?us-ascii?Q?Kr3SqOmQ3oQcK+/+0B9gMWPVMFqaSuk18Y6XzgXYeI61N8gD5UQmoFZKglp/?=
 =?us-ascii?Q?TKW5Hmyg18wT57OYEA0tjL8DDGZqClqEeOEf7XAlZdsrS9pdpVkcMpePryUH?=
 =?us-ascii?Q?asx968/3PwVvOWOWKvjpAW1NgvWmKNCm+q1kiBh7rMQDMJeLTDzp4LHytQMm?=
 =?us-ascii?Q?EWXG62a8S8wckSh0KWVbV4U0nPCHtti0XD2FzQ4+1ZAlP/9vNWwFq/aaFIB7?=
 =?us-ascii?Q?8PQUwZOflndVm/49vTFoXJCmFvXjBaPAK/8mEPWjkN3wQZGS1CxeJ7gNm+6w?=
 =?us-ascii?Q?k+mZQ8tyRZduYyt5E0SkG7DrVHkrQy69LoPbmAsZt4WAoiKy1jxXPzQ66Fkz?=
 =?us-ascii?Q?/x5gz8MNmpPnNhaUfdEttQOM1E3t+EI6bwuFFX7Fd8UkmpsjABOOElsmsgOQ?=
 =?us-ascii?Q?pdhYvkO4Nonm+YEy3inMZnt7bKcRzU82R/t0NAs+AhC4Cw6El9p2wPbqbWwA?=
 =?us-ascii?Q?Gh3VE+pGs8itVARLUJF9Cp65NwWgntP5eDoZiFwR+rE/YDZJfgp7B/Vvl1Ch?=
 =?us-ascii?Q?yKpxMVo7DYbTyx6YKfaeNxcG1AihZPwHRps+6Tt4VGbxto/ONIQ3kWlEBlVL?=
 =?us-ascii?Q?sCvEqGa2rdDiQVAKCWlnSOENTqWzq4SVZL5NNO6q5D6loAz7X9SSuFNt0Dc3?=
 =?us-ascii?Q?liCskmNXdnSPr2pOMx7nJ0HOmu47ZNwfBciBYpt7LSjHOJJ9jqqoNgNqVJAD?=
 =?us-ascii?Q?0DJd1G28JJfTR4aMZ5w1R6z90wtKPPwz5bIX4vONuHxiSiKfKhBqmVEDuApl?=
 =?us-ascii?Q?4dGJblRMk4nrG6JOyBJTPVGn1mXZ+cqjfGBiQVbXJ0GgMhkEJ7cyyuWjYUFH?=
 =?us-ascii?Q?wbyKgTdO8Wo8LEAxCbxyp+iXortdYkNO9yCVYax+QD+TGHWe3xfUIQg2zcPy?=
 =?us-ascii?Q?Q3ffjzKTvBG7rAXSZOLLvq1Jtbjmgt5L/acxTnC+zPIhHN9GDMmoTF6hhnMA?=
 =?us-ascii?Q?wwqUcCAQgHYDci7ggX4pMH5Kbj+3kPfjWcPI7PpdV13modYqAoraHDeSa/G2?=
 =?us-ascii?Q?nsGVYHymiR68UNgN2c6GJz5tgc0to8+OtdA3kKFuVYDxOg4WoaTmh7qKkAff?=
 =?us-ascii?Q?Hi9nEd7ZzAD22RYSybcbU7/xDTqsLnxqo0GaAe53rODD2v4iNPzA/6Sx1es5?=
 =?us-ascii?Q?pR+JF81FpuwTGs5sKa0HGkW9kq/0aoyQFBm2x3wniYr7kU2ScF3M1PL5fIz2?=
 =?us-ascii?Q?aTqg2aTS2D9xsUqfDbOEb33nfUwx1sBn5hRv0f7Z5FG0OABR9YgE2GMzVbPo?=
 =?us-ascii?Q?Ce76ZqEOe90bC/RJI2dlr/WIX+Msepa/oGFwI1ua8N9+1dvpkYLW8yojQVvK?=
 =?us-ascii?Q?3eZh2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:38:43.1094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56e926d-a326-4442-45a9-08de58b7b899
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7109
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-41212-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CCE3D522FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Jan 21, 2026 at 11:58:23 +0530, Viresh Kumar wrote:
> On 20-01-26, 17:17, Dhruva Gole wrote:
> > Hello,
> > 
> > This series adds CPU frequency scaling support for the TI AM62L3 SoC.
> > 
> > The AM62L3 is a low-power, low-cost SoC from Texas Instruments. This
> > series enables cpufreq support by:
> > 1. Adding the SoC to the cpufreq-dt-platdev blocklist to prevent the generic driver from probing.
> > 2. Extending the ti-cpufreq driver to support AM62L3 speed grading by reading the efuse.
> > 3. Updating the device tree with the necessary operating points and clock configurations.
> > 
> > Tested on AM62L3 EVM [1]
> > 
> > [1] https://gist.github.com/DhruvaG2000/6dcceb80cf7bbd1e624ec210532538cb
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> 
> I should be applying only patch 1 and 3 ?

From what I spoke with Nishanth yesterday, the DT patch (3/3) will have to go via
his tree as it's ti-k3.

The first 2 patches are the cpufreq subsystem ones, once you apply those
and they are integrated Nishanth can pick up the DT patch.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

