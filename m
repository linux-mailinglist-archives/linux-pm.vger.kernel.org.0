Return-Path: <linux-pm+bounces-42316-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDmGAsxHiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42316-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4410B293
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68C29302DF41
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3982F9D98;
	Mon,  9 Feb 2026 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZIVVq0P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="deQRp6Jr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450592F6931;
	Mon,  9 Feb 2026 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604375; cv=fail; b=KLLWbxx4aASASn0+cEQ6uu+mJjjt+N7+2lQs2+4TfS7bnHukuVVnxLK3IOXDIBGRX9jki2A4Q/ai0rDSLFYbFFw4WHEKPEI6FmPc1cqvZLAg0GIL+fF5uOkuq3JsKzlh2h1bLxSJouY8gj1ClmsdIRO5Ks/J0BNXyUNHfUeBmuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604375; c=relaxed/simple;
	bh=EDUHX8kK8pS+vhQmVN3OKc0mBFKaUOMaTija+to4XPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cA5oSnFTU/xZVTQAxLG0CNMiNxkjyd4LwL9RXwhNhqdJoee57eanuqqy8fDceCstB731RobSkJzB0BJdzxLzn6aoIoFu4i+yMrbuIn6zqHve/lL1altHvxoocXnzqGrquqoCo2M1fOw27WIIURh5g9hDM/cNXVq53FSvS/eTKMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZIVVq0P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=deQRp6Jr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190EmC1263733;
	Mon, 9 Feb 2026 02:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NF45OX7VY6gHsg0QT9OrrV2ryjWIczmP16k6FMm0eBk=; b=
	CZIVVq0PFLZPymKWYN2aOoO4NdajbPtqT1H3xtw9WztmZtIUdUa3CRTOkXxUBt37
	biLTKDDtcXhk7GGzxW8aL+o7GKDcL3VPzKLqdpZpwjZYyibRqVWMCRzHrDOS5PLs
	46x4nAT3RsxZiMXR6tWWwcLdB1oaQnTFnPzFfb6t1d9mQBXomgscO4mFbu+3X0j3
	6ws919pAa6PMBuhAhUKgzRxEZrCaaZNrwNu8Rfnjp6vk/eVx/97OygT5U17bNgfW
	6mM3wzLjYPUyeQepoxwsUaTlRUxlXQFrUpU3wBUEubMaybvz69OJbqPFPFkGsGUi
	Zx+nwbH5afwKuJdNCUU5nw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8s989-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618KWJlL031967;
	Mon, 9 Feb 2026 02:32:21 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu8g8bc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cENsJaRSY3RND8Vc9Quj7FsAavPIm/YyjIyw2gZPKRJlpj6uDTwMKydDVB8Tb2tj0zkyUvC30ZMvaWe/urz9VwMqmUys7uKJriWY+Z+jb+27HirYufQl3/1/E/BFNOdmhpILF8SNSmpgxMfr01z3pIuBSQcAsiY5Coh2mLTXA8nw6YfjgH+wLS6tMEpTV2loo2dFAWnSwpB0RLLn4DaVN+AaQgEVQ8ul6r6FQZkj4mfiLTgxo+SDF3nv/0F4bun6B4XfIOkMVl2FGRiF7QQ6aieupNQZvoLhVuniZxZhfVdKy/lK4hygtviKicyuQafO9p7m58NXCCPDL+Uk8AhG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF45OX7VY6gHsg0QT9OrrV2ryjWIczmP16k6FMm0eBk=;
 b=v79++fCmCiAfGzOU7bNRnTL35mc6nNH/NGqifro8WIpqc8YJD1IzAeVEDO/72xg5FuqbyL+Upsgt7CRJ69BpI2TtxSpgoXFHGJO7VCTKih0wzq0d1iaSSav5KJBnFmJkSX3KRrAfjc6XLW0vGcmgCn9zXJGYFxvEP82nZsLhuoYLUvPh9VGJ6w7L8SwcyE4GaVzekHs2tsgdx/lSPwoSqYa9Iox4seXULq1q/OaSf5vCOZ9L3YlVZBXX2V2sZFaBNSVq4PDsiKhpnV9heEkTUBNwUxdWuojznuKMqmCuJGLA5YNFCw0PWUlybTAA+IrO/YOQrDp9OZ2snivFmcGPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF45OX7VY6gHsg0QT9OrrV2ryjWIczmP16k6FMm0eBk=;
 b=deQRp6JrDzy/06M46mcKAOsqtOLTNY8Ltsf9ZcUwfKXaNZHhtw6zLA6nTWSBmDhIhnua4ydGNIgAZ/H35akcH+3AlGxn9V0TWsjJslqL8+xw2KVj4m5PR5mgcKIis8rrYKH3B3RGjjeUVAmVtPQoQRJbavNF/V0J0fs4k5EGVlQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:32:19 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:18 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v9 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Sun,  8 Feb 2026 18:31:51 -0800
Message-Id: <20260209023153.2661784-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee8dc46-7fca-4ab2-3dff-08de6783722f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LdJfmR/d/778/wkRujdjGxyu9R4nMIYN1JGS0n1Q91xiS5bJeyN3qqxobjvn?=
 =?us-ascii?Q?kHgTDE8dzI3E1djmrgLSw8nT0tQyu5ISCvOPEobLZnmcME1lzkF+chTqJZYP?=
 =?us-ascii?Q?CzlMH9OXljTOF7DgO6yOYb27La/3tYYlwJA7FDyYGyaptxBk19XBg2Sy9GRc?=
 =?us-ascii?Q?PubFQlGt12Xf70ADVTbeCwDaUEM9xUI3xKmUHuN15h0O3u6edx18NOpdbhuO?=
 =?us-ascii?Q?VazgDmueJMXp9q0l02xlB8Qrzp/0ceyh+gGtLyeGlogJ9lN7QivbegVToWPQ?=
 =?us-ascii?Q?xOqBiLyFSqqKJ6DgCpvgwjMhFhcxwSB+FYJpbrALUuM+S+Lx49iC4xRqbbvf?=
 =?us-ascii?Q?c16p+BgVVR2b5S6o/qZHRjPhrggfTXBqUhbAsKPD/DGR9piG1LGEAtYobQoI?=
 =?us-ascii?Q?+EWXDUGcc0OphB49BAYuYAUmRSCKF2kl+iRCYuhYUbJg5/1VFEsgLnVX8A0T?=
 =?us-ascii?Q?kIV6OKd77filNC65Xk+9lqqL1oPNnGCzvIemCqD3+2DGfNoBTJRXqghlgz3Q?=
 =?us-ascii?Q?x+FwP6ksHCMOrtChG+O7Rlj8hHoIDRdGtEm5jngcXWcyWpkq/Pyj6yDYru8v?=
 =?us-ascii?Q?cyXXFJjNGEw7845URIeVOsQJT1oZNUUIKwAslXSMUz7HQ1Eub7FUGD5+R0v+?=
 =?us-ascii?Q?9M8Pq8skwPYrgyPgbvBgoW9vflDE4AeV3oW2na9dilZ+0c0NfdLT7QnNglHx?=
 =?us-ascii?Q?yFkBsclqI2o5zfIbTXXABdGVIYMSDlD+lTkXiQ2bJ2IcO402GKg+OGni/gcz?=
 =?us-ascii?Q?VGAjdKukjgzE67iqtTgI3lUmrW9piipMofTmpSvHhWQZjYA1dAIWtiEDrUtZ?=
 =?us-ascii?Q?oG+HYl7p++KpauPZGvorU4GDO+rg31eHivJWfRanznu1y7WDIODWQ4LTYFdx?=
 =?us-ascii?Q?bxlJEoS/ax4brre+1acS+H2TkE2yJARgdD0tTrm+/eUoaW+0jSXY26+VWt++?=
 =?us-ascii?Q?l36nE9WrKW5stJeBVNdg+2q+ayE6Ix30Xg+UE3062QBVX9Oib7SciR32Lp6M?=
 =?us-ascii?Q?b7IIDd61ng6idwSAH5nMo6BCP2W+0ENrZpbvtWOwdJruVmd36Fx35EBAN4LK?=
 =?us-ascii?Q?pfgb66RQDUrKiDFcGEfG5GOKKSc9sFQ3SWh5SOtpParpQsisFUFZ3AXLFde2?=
 =?us-ascii?Q?lS2ZQKyyl2uzHQw5lTTlEOcCnj5n589TmeLJpaTgyQ2goBgH44DHtCLTOKFG?=
 =?us-ascii?Q?KvJ8cZrEjn1leT7rT5BYcxcz32N1mFQYVGmnQrMcB88ZML3TAkqKQ08ArEhg?=
 =?us-ascii?Q?Q1Lm5VDEaCR7pMzDtcCO0JkOsfaBmF/qvlEa9WiSLQqBsrGFcomZ4xoHX4q1?=
 =?us-ascii?Q?y9xay8XaBhTn4VoxZLVGuYaAHvJvKMyTsQ5ML2WkqeCy+eYmafx0qt23t4nU?=
 =?us-ascii?Q?/heUhXHxWNUGNVw9OQtSQwfsxOS1dz8MfIz26GcsaTjq3DX7yieFjZPgZmrA?=
 =?us-ascii?Q?WugaxjCP00WZflVT64dxtM7fu5Q0VuzSbW8HqpnRBe329s05apC0VlqFSf+e?=
 =?us-ascii?Q?CoUscQYBf8T1zxx4SWIIZE22ya0cOrlrplr6wwP2/rBUrwHBlq2IPBQWnb3x?=
 =?us-ascii?Q?2lMhkyKMV9E8Tnnr8I4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdpJdYGn8uEfS41X0tGlqwsGcR+qR7+IXZLOR0ii9Aac3ktfcdp7+zLqJ/wq?=
 =?us-ascii?Q?h2w7XPmaJP1JeglSy7FWBK14AGZ1WvR3OWpNeR6WxgmiEWQQU6AD0rYndguX?=
 =?us-ascii?Q?ggYM4zMvgnZ0VEtYWhWuwamCw2g8hhEn0qJdPhrvpBsxcUPlfIkf1OXi7sAL?=
 =?us-ascii?Q?SsaWG8JgXrjKsK/VahbEMBpO4Frkdm7K4/jP+pichPwiySNahJ1cAJTEj+rl?=
 =?us-ascii?Q?5mOmeLJtV7nBcIocYrpbH4isoIhmj773rNDS3M/JqsWg6ocNhxZ4Iw9N8w7t?=
 =?us-ascii?Q?9ahWBIkCY4yh98ly1xhatu81SNl7NlajNwsqHDQty0TqnOcziwAfHHTwzaBl?=
 =?us-ascii?Q?U9AvqEBhogXvvKqZxfPEs7+IcwX4LU/ET2EMuYaByeVma3kgt9JRCTkMhVEV?=
 =?us-ascii?Q?QIGToJzzgFMXPoITXExUDouSOtKbl8ofGyhNochhF2pyFlp2YKac5/wUml8r?=
 =?us-ascii?Q?dJgkitA2xUcbQUVsmEMTXUdKnI5PLkd/n7ma10jG9gcAR3HRv0xs7+ihrjuw?=
 =?us-ascii?Q?3HP3EEfW+r8tvtr0hul3+iaIrBV3aE7hBXz83b2Uu4v4WfjfI6rEdsmKiVXT?=
 =?us-ascii?Q?DKo7AFwkLYWDpWv1kfLLtYBPGDYuutp7aamp5zfy08Gw9HJOfYjStjQ3c0mf?=
 =?us-ascii?Q?98qBTil4Xg1d5MsJsYSFyNXqYfQyf665qcRNXx4uir7tAgXkzRLJ0b1z4kxd?=
 =?us-ascii?Q?n+RnPqIs7aS7p6o58sZ5Sb/MfiUoc8sP5AisprlGA0UZx80d9CqdQHiCX0vc?=
 =?us-ascii?Q?kecwx2qVIYp6cZfqbc6P7rBoHNY5o8uPQi9wLA0gv7iiO+L80Du16afRm5Lh?=
 =?us-ascii?Q?w1Il7vGmGYYbt7fWdQlEPtcRixSw0RZcz08/gfOmCzRlYLjh2sv316NRDfxT?=
 =?us-ascii?Q?04ynQPL/jlp3JMygFi+qAcuHv8mlmTorBrxbm8evxdjSi1zdWjQB3JgXhOBB?=
 =?us-ascii?Q?viRYisjy5MeFczXUD1Qtly/aUDug/FWZdWj4bAB/KjS7NzNuUOTq2NOK6hf/?=
 =?us-ascii?Q?gQYPnp3c9hMTlSye9P/ehFbzUjE2gdNjp7tJRIvaPPECgnMYye40/7+h5RjP?=
 =?us-ascii?Q?XMzdjpJEGkoZI0i2/oOLc8RT/5KTNL1DIjY6WMAhY+rmGkiY20dHHD5Xx/r2?=
 =?us-ascii?Q?iAAp9235SIaFd771i1sBjfWUjaZUWgTLIEsiHFL1pUItmJw0XzLOOqW90iyQ?=
 =?us-ascii?Q?bKF6raRv6rzkCROAlPME8fjBH327SIqb3IrsfVrKFHVkQD8rd7kmsAJfC3Es?=
 =?us-ascii?Q?LWwImDvEuYpGWugK39wCoDWQzMoeyECLKoxXInElTaSvjNeqlqfzzjQOy7BK?=
 =?us-ascii?Q?keXInYA9OM/oTNzb8lX8NJPM2GOFgrh/VeY7zzOmjarY+e1e3R5ep06QgWZu?=
 =?us-ascii?Q?DjpUL39INHOIBcF5ogkCvEcvWeIVQJraKhHi07hwei9sohXfpp5cXlkfO9Ur?=
 =?us-ascii?Q?5L1brRmnRVROtDN+/iEo7Ydv8bwBUlLdcyPoHmMwmSDW7HOeNG6FFDpFWlm5?=
 =?us-ascii?Q?H6OEMfaOAMSyl7ViwdAjP0fPv1lSbTGDQoJz3MM3kFY95uSAFBXJwtvCi+WK?=
 =?us-ascii?Q?haAVKS0uQq9GwUBkR8euA29yvSiT8/h8B1E9DDeSd8UFmlvphuoxZ4ejcs/U?=
 =?us-ascii?Q?Uzhuh6zYynW62CzAyroN2Yi0XPF4wNIHMaLhjJEvG7frVUPa6k0tacCtAUzB?=
 =?us-ascii?Q?x0WVy8/GcyhXOvy8XL4D2fedQmwaCyqOyrH5BHNnQ0GDbxBgFRYxGxJ3p65J?=
 =?us-ascii?Q?UtvzFMuO8oMHtnk9sE81lZ94H5aTFxk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vPjuh1Fv1QYWmI1nl6YN4ticTDKCBonGU652hkw5+gJX1I1crE8Qg9Kasecp/4Q7hbVtuNJaEmSF1z5j8nei4LZbyOewIii3uaGbmM48yr88hjoH2OL5UdSPnkYhgaf5Yen/DCi0+7/xk1fm5tyrtb4EJy6g4INUGRJX+iAOoKv85ajfJUlG8oyUIkgmRtsiCVxOcejJqSUS2LrVgrXjRzS48U+C40MsdHWsfGXyW3eHsUs3MdUfTbX78tG5zltjRc+NynpTP76uwBuwF/Ld418jGqF33r5RwOKRCQxD+z7sSbhUQoGijv6xYzTmJ5MfleLASA4aOsOHQ6L/FxznjBF2dcVJCFlnx+OQNxUcOsv+FtvcxPdDwz3IX0bfjl7t6cG9iIrCCgOgirob6CCAUU3Jlj1TiUH5e/UHX54Ivf1y5R+/f0UO+hOzjHBYX3wnyDPux2NUmueO8RZnaBbQ4S/hVC3wIBMajJm9dzgXzlX4hZKocIsM4dHRkXl9kmM8YdIruaJRxiv4ZdIXkVo8GjpQPnJ3KMcbEWt3scTkALYApBqVVC/79KJLTuhbYRAw7fyvocF+PuN91L9rHvil8zJWiG5gU5dWeep5AEnuJTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8dc46-7fca-4ab2-3dff-08de6783722f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:18.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc0r0K5WHOGWd6uw/ufDrNnHaIH9jvLUsF5ypuu4CRQCSrQiwwS+SCiG+erU1E+CmIILHJzienfL/QjeL/pVobPxTPHrg3jHzfqxFcg8V7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090019
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=69894736 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=rUJF80uJHZDRKD-Yun0A:9
X-Proofpoint-ORIG-GUID: NakFtqTUPF2cAteR67oLUjAi793y8zut
X-Proofpoint-GUID: NakFtqTUPF2cAteR67oLUjAi793y8zut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX07srS9+BIh3u
 T3Tndjohns+y9JDs61Pstxjoxx/eOXm0EP59Lt3E9OJWTFHZrSsapW4uXTyPUoLHWsmaaYJYglb
 ZRZ0n4igH7NasqqucY1FsuUtbugpiepGYU8ytF/PPej0Gw1oHWrKYLXtSGEBpp4enPdJJiuIO3y
 1i7yj9hkclGV8gjEqfNvp9bMcGJnhC4FUQuM7anELTRFn6oJNO+CTCtOEh5XMvaQQbee4OOvIYH
 2Czvy0X5Of4pKtboTsRq4IPacNZ2PBY2TSk6yzIiGIFo3K3KI77dZJZi4VxoA4eyBVHmbjYYv+6
 PhzacBJR00du1BEELN+KDBp84/xgK6qTxae+K4785A5Eq9iRTCwzKmwsleTCt7qfbtmEpLpLfdT
 6BZPFVwPd77GMavWQ6J3taJTBeC5vTHVd9HL1B0QT4sEWOO5HlqC4q8kHA+GYs2ea7xRb8aLBCS
 cTvYsouacmpBN3WoINg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42316-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7AF4410B293
X-Rspamd-Action: no action

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_read_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use
clock_deadlock() directly instead of going through RES_CHECK_TIMEOUT().

For correctness, however, we need to ensure that the timeout case in
smp_cond_read_acquire_timeout() always agrees with that in
clock_deadlock(), which returns with -ETIMEDOUT.

For the most part, this is fine because smp_cond_load_acquire_timeout()
does not have an independent clock and does not do double reads from
clock_deadlock() which could cause its internal state to go out of
sync from that of clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {
                VAL = READ_ONCE(*__PTR);
                break;
        }

This runs into a problem when (__time_now == __time_end) since
clock_deadlock() does not treat it as a timeout condition but
the second clause in the conditional above does.
So, add an equality check in clock_deadlock().

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to the
spin-count used in RES_CHECK_TIMEOUT(). We only do this for non-arm64
as that uses a waiting implementation.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index ac9b3572e42f..2a361c4c7393 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,20 +235,14 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Amortize timeout check for busy-wait loops.
  */
-#ifndef res_smp_cond_load_acquire
 #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
 	({                                                            \
 		if (!(ts).spin++)                                     \
 			(ret) = clock_deadlock((lock), (mask), &(ts));\
 		(ret);                                                \
 	})
-#else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = clock_deadlock((lock), (mask), &(ts)); })
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -262,6 +256,18 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * (ARM64 generally uses a waited implementation so we use the default
+ * value there.)
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -312,12 +318,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -415,7 +415,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      (timeout_err = clock_deadlock(lock, _Q_LOCKED_MASK, &ts)),
+					      ts.duration);
 	}
 
 	if (timeout_err < 0) {
@@ -577,8 +579,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       (timeout_err = clock_deadlock(lock, _Q_LOCKED_PENDING_MASK, &ts)),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (timeout_err == -EDEADLK) {
-- 
2.31.1


