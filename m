Return-Path: <linux-pm+bounces-42317-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL5yL85HiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42317-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD110B2A1
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C5B7302E85C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7492BEC45;
	Mon,  9 Feb 2026 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzIieFHp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vJi6+8F3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDB2F691C;
	Mon,  9 Feb 2026 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604375; cv=fail; b=oJJULx9p5WobBO1UZuzytgmYfH96N2s9iqG87z9l4OQw3qaw8gs1L4dKBzlrsUAhB5TVxB7nuHaEeesAlQzF4oO6RgFyDkEubzChBtpxLA8Z304x/g6WChrAguVkDVgx7+oNEtWHeSyAGHV4h96DsZCH7Tr5v9MQJjQN9O2MTXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604375; c=relaxed/simple;
	bh=jJvdQ1WU791pucW0ca53eAcVa+5xWuEb7myjSwu37ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaBWH9qrA5Et5U2F+9pssGFTlklerIf1l31yxlF19+jJRjqvMLsyGSN3yxr55wbXVdSnPixXzdsu+iOB5d/A/BJoUDiyvU9/KUQm5kYpYLF8Fg+nMRsjJXEpNX2WlNAaCkxyvSsH5N9rjROhf911A5kfq7VWctjFF4xdaOnKhcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FzIieFHp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vJi6+8F3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6191qr564138311;
	Mon, 9 Feb 2026 02:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RKE71GXtK6y5VtkX2rZvX70tQVD1983A9NPkAJMTk1g=; b=
	FzIieFHpBtYAyFb9WlOCXv7Egqdv+q4KBnfd8014zCqjfZ9Goiy3tiFBLDUOOhRE
	07cNLQTTjrAU9vhJ+KE9Wn5G1w91t4YhD2EjdRcgfKGvSdfDPQuV6Bj+YILgcyMq
	1eZCRZRiJrPvayU81ImpHPPcDvEDaZxJVxGe4VrqFZW/MgzEe0/YSTP3LNKej8e4
	/bs81KcbHFO7NvR66cIl5RJO6fp1V45qOn9cdpuoYjVz4fR6e8hjHY07W197b/o0
	d9/ndgoYu7Rm06YXKpnD1OkvJsEz3sAxFyCDTQ0fGbcbMf6zmZ81zeLz46keEVM+
	Jt/SqiJJY9Yd5FZ9wJQV3g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjys9cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6190g34H032342;
	Mon, 9 Feb 2026 02:32:13 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu8g891-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2Gp2aiG1LMeAZXohcoM+cGR/Wo3xn2oFeaxyGj6lPFoDkfL3j9umWbRSk2W0bL8qmLSv3fCZ0wI4K2jtgSxVAVHscnnZlMZ0MCGYYJfRG8pv8jPf3uDBYaAgK5MK1NAcOar1+YTJB9tGCWGvgZgRTCINM7YBVg1GpG5o+bYHiV9PRq+HSqaErh6Zlm/bv/rnXBDR0tVY8Cl6KqR+dii0TDQEDOdYMhNUbpxrBg9shBUZP0n1JbdD7ktllQg8SG0wE3AR/OaISVWYAw9wwTHBd0yXLF+OpJxtpVrDxkKHj1Ubi31T8+nBEFjFrmIx3R1VZiU6SYUXRfqhezS4oSJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKE71GXtK6y5VtkX2rZvX70tQVD1983A9NPkAJMTk1g=;
 b=DkvXACVJ9vMEB688To/IMXZ55WlmuMpTeLt3RHUfz2bYLUDbZWULs/MKLFhU+9X2Ae1KR4vJbJdskOitBX/Ra1PxjdtozLXUUM51wMNN3cNCWJmwTIBOsKW/9bJnquYXzhf/v0mLq/fn4FW3gVpGnwvNshQbGxXQcSmkolDYf1YzI9xnWoEIBnusXYm2vDkwE85JDu5bw5PofsVp03T9yfSutmZzxxyvo7ys1IVQB3gR+PT1LcKQoSwYxvS09hVhfpkBf7J6HM7/C8e2YjXr/UrS50dfL8ApqmBBfU2RZ4Mga6V6g4clGQDh3Mpfj73yBv76+SFeGD/lIv0Tu68hzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKE71GXtK6y5VtkX2rZvX70tQVD1983A9NPkAJMTk1g=;
 b=vJi6+8F3ZlQrrxy5PxTajvRLvMNo6IxUe93naAIKVyB5dLvqX0G2QPcYzE+yTay3HEI2nIZ2fOOvAVB8OP1cg7CRcLNyU49a7S74j8DWZmU4LC4dikEm+a2AqPTKGRWQ/FbS0WKzzwLcF9bbHNEDKr1kf8DFD3kLI1W6jSUDpZI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 9 Feb
 2026 02:32:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:10 +0000
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
Subject: [PATCH v9 06/12] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Sun,  8 Feb 2026 18:31:47 -0800
Message-Id: <20260209023153.2661784-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a4905f-13a6-4386-1e85-08de67836ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZcX3m9UVOPH/mECaiaSgwvauabyH0kOy6g9OJMWnkYipBs3xnPxfBQ9OKgi7?=
 =?us-ascii?Q?XMjnp9UecOVwpk6eLi9zEMXn+o8wbR3/3kBI7I+LWPpHC0YZuiFWlgvrIfCr?=
 =?us-ascii?Q?OVIP/BgfGUQHdPUYrxqU2sYtFzcG87qAFJhXin2KF1uJyswg0l0dA2e7rG1o?=
 =?us-ascii?Q?ie25+q8rqGBxdgqcKM62u1N2qOfgl8XiPKnsDSF4oVp1JGNnUm+IWZyKZUK/?=
 =?us-ascii?Q?Se+h1Cj2vu2F2sp/1oyxzyJuFZu/qKy2rxlxBA8aR2FIKUQmHQdUznP/vMuL?=
 =?us-ascii?Q?sTo5KASvuYACmzj+cjsgsneizDJaj9ZcWJU13GotLgrXrrW0qL+COiHAad2Q?=
 =?us-ascii?Q?9T8ERQ83OCIbm4z39gicRDQa8K7/dvq7/zNcOMcRrDOUqjXQ6DUGpx7GUt5m?=
 =?us-ascii?Q?jniFoU95Xzh71G+HRvqDlHCnoV9K8sSKsOMWzWE7LdlIqq0qTj0UC8u5ZbBi?=
 =?us-ascii?Q?dWYJ5xCIJXyEGMWsep+BcZOB1+kcJs5Jz0d0KkwLj0es8gYtYeqqVG91ctWi?=
 =?us-ascii?Q?jm8e7V2wmWpuyLeRaveYU6UJjRnEV3NynJ4Qu3vi+AQhhrnksBW0LPdxUhTn?=
 =?us-ascii?Q?V70l7Ey7QHE6qxVo3lmki1MNIO3thilG8vyquWvhn/FZT3U+CWmxxRb3A9GO?=
 =?us-ascii?Q?8AbQPUztSg6SdV8gTiMK/az44eChkLAGWsbKAbXClvibktEb4ynShpw6FqSB?=
 =?us-ascii?Q?IeK6/c/Fe/+ohLLO92Gn2hquesqh11eLm8z3Gr5vZsWJzaWlLrd1gIzVOptg?=
 =?us-ascii?Q?MDSe+0QZzTIHOg2rtqr9NkLjkR5blUwmArB8Ex4ys5nlp5FxASiEqoHLBX1E?=
 =?us-ascii?Q?Kg2swFi0+CS+RndZ/OlV58h7TSDZeFAlP19fBFrFFlamxa3Q1tAc4V8NDDA3?=
 =?us-ascii?Q?S623Ypyl25Eiv65v9HTS7wW+tp2msuDVRTUY2CRaOW5jzT4QV/lhhU2Mf4G3?=
 =?us-ascii?Q?A4QPYl/ux76H+gw6DhdB8Z+vw2m4TH8sl/CAIrttBN5JL31Wvyo927+NJHCX?=
 =?us-ascii?Q?TpLo+PWrYJ/OLnuX9i80D5q+Zpyaecq9hPgii1+8v6rxTYkXPmYXKDHaE0PW?=
 =?us-ascii?Q?Wi+gfgVsjZURYI4bcD8fqs6Tx5b1IwOk9n7/HRUEVYC/7SYfiL8lOKLaD5A5?=
 =?us-ascii?Q?gQsKu4s+On7a4CGu6asmUx5/Wz746ZxwJCnnzx0nXW5ECjWT/qPuNgenbZCR?=
 =?us-ascii?Q?se94A+bQuzNoQ7Shukt8bJxznCS0qgAZKG5L5qVr99lcPi2BSzMR3RhmjKzu?=
 =?us-ascii?Q?RgHhs5V/UxEQDnnVwcbaFc8NS7B38B/gNeqYFMwxZhhQHbNFl3VJKeOE4/bv?=
 =?us-ascii?Q?lORU0bC/Tgk5LnwSHJzAV+I6ZUzb+mMQwzGQQbmzRsd8Ai6OpUWLKnP4Y6nq?=
 =?us-ascii?Q?iT8PuKhdFxemmysoAWiCWYZFAw7vz2W8t7giopgQ9MJJIeEpoEYveUExMwUR?=
 =?us-ascii?Q?ZIUqGPcvQ3dZAqIDdJkT4oNp70Lke6l/cvyirIndJMFUt+7+6OFmKQZCFFBl?=
 =?us-ascii?Q?MpIgIT8OdK3t/daGYtswl+MtHZctij5ptGdB8IQ/87+QT6yJEvvKNQDf1jDE?=
 =?us-ascii?Q?ohqtUWgRkw36Je+vc8o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DgorMbVGuKMwy/x9GZQ40JFGBKGkoLHpfEaIonmkFzrJTnuoVA1mrF9bqaBg?=
 =?us-ascii?Q?0zJblK1kG1U2eeryJ98dWd27AwfYe1zEleTVLMEIe1yWYKPn3XXCuuumjltf?=
 =?us-ascii?Q?P6roB7x9JGPYYLeHfg574+pk3pQmWkC/cwgZpkFNSXY/C3sI8dKqvQB7iY/9?=
 =?us-ascii?Q?2Gnn7M0z4wAHOUPSl6+Yv/pbhqOO8oHE12DtVRBKa5N0OYVZWumM7/r6/IVH?=
 =?us-ascii?Q?nhwetmGs12Os44jMTg/7eflxtaFeyg3D+uwLNZt3vlff6BmkZ6kTHJpTb5tE?=
 =?us-ascii?Q?KmE2cmAcDOa1lIFrUFgVs9bQyeNIhk2uGPp8GJvZjyWynNyX5bKT3i3MGzTF?=
 =?us-ascii?Q?vUZsf0lNzR/fD6qLSoEmrt5F/JTrQaZRH85aEuLXtWnbAfypuGfkHgeughnG?=
 =?us-ascii?Q?yW4P1FSZAo4zEv2K/sXTMw51Gpv8eaHDqeRtNdNs/CiUJNojrfzeM5mypvSD?=
 =?us-ascii?Q?JlnUSJ/5wGldD10hytwE3m8+1KByeJzZelfO/Oe7Z5srWjaNEmn04gXM8Urx?=
 =?us-ascii?Q?Khv4iqLTwbEbTHBwnB7w5qRNp7CkA2pBAh70B3MLAmV9Hm9SsmPEdaIxr5Dv?=
 =?us-ascii?Q?/40bxFFMOAvle8JTg0ymwNI/v7ft9hxsGa43rw1VS5zjniKdD9jzcO1cSNO2?=
 =?us-ascii?Q?k5vOzm5gGafpxs6deI1cxnb5qy987d5pJRwPqstRLj7ipRl+ROtCKIgYRaCU?=
 =?us-ascii?Q?X7B+fQaHMDGM9dmkHUI2mGUeczkbcY3JNOYvqXKYglRTE1yrXFeOGi/JSm8N?=
 =?us-ascii?Q?AcEO/NeYziyBljWhUKG1uvhPh0NL7c4EOWz8cI3GAO+QtjEN4V5SZliQ5/eP?=
 =?us-ascii?Q?OpOhw4IbqmbKxMJNL+l1AIOd1L8ppD9lSYKUwRHIVjLt61GGjKWeBAftIbJM?=
 =?us-ascii?Q?EuWi/vqJzAVlDQlDnbXw90F1jn02C8WFwOj/q7o/TfYdt6JjBkeH1kEiGCVj?=
 =?us-ascii?Q?UDUpIEDF0wEWD3RNwINrw0CBbl6jCmlcE0OwdXKNDvria8kT0kgVAxky8tsm?=
 =?us-ascii?Q?imPLswcAEKcTsGXRbTl2mQzD6VPXCYsiNCAN0smbilTGWx9z8OmvirU3FFWF?=
 =?us-ascii?Q?0OwslSZC4MvHPyn7coqDDWU75SJaWVjteUzfrTEZZX5YrjUZlEEs01XuHurj?=
 =?us-ascii?Q?McKPZKdn19KOQf1k4GZamTMfSllHxojvVuLPWU6Gk0aY+UfZ58J6Rv5/DQu7?=
 =?us-ascii?Q?AZuzHEcE4mtM4m/9+PlTMNL+srdQjs0KepGF+vU89mhgygbYI0i1aWIHDaJ3?=
 =?us-ascii?Q?L7Y/NG+wOWcJpio/jbCXW2EA3Cx9LhkefiP8/sZZp7dIEOP9Tn9TdVlgzdKh?=
 =?us-ascii?Q?p5CrWFSNa2RyhVxd3PUs/d/omtU6EcL2FLVnXoRM3n6me5UaOm5tiAoIRyfS?=
 =?us-ascii?Q?VMWdmuXD74dESi8T0tTURmWT8ugqw8yOW/827CxQpYhIYN3a21LLufbOHOE9?=
 =?us-ascii?Q?tcZig7gQ9VlEPvxEQle/5pRyIlVu6a9U554J4Tlwl/ugZ4QuIVM6vC85LWyB?=
 =?us-ascii?Q?ivxUm6AZt/TvpSVmO/TGy8H/wh5t+kPYDGA+mBQ2WBN2Ycn2i4sjxLHMKQog?=
 =?us-ascii?Q?V1Z5Ei6S8S3OQMKfbSe5KzMk4peHMVYpy1DE6fzC7NGDU3T8JugLmaDYu1XS?=
 =?us-ascii?Q?dta1kKnh38Ot/Eqh9tyeWdiiS76l5RaiYw5L1uf6bn8xhoepiLfrvYFaEL+c?=
 =?us-ascii?Q?AebanKOPp58yFJPwEuF96Uvz+PzFT1+voKp6BS0J2+c8RMtZwkn+vzLCohQN?=
 =?us-ascii?Q?7tn9VF1+LnShDAE+HvCQ857vtC7ewVc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W2MWRvFYxCT6TaPNctimI1slTixoaaGT42jx3TWtnEJFfVh3uNq48i76DU0p94gcp51nN2tKx3l+rPDU9Xw3Ahhv7ZiGw1Cjaj+mmWc+ibsrw2e88SRdXmD2KtVpqjJau/vGpmhF/0atdsNQAcs1zd+qisBfxNGYCGegBGyipWnZgmgPNiJ3ZSwPrireFp7jLAg1KZVhdzSD4SLOv17F3hpvPwzUow8p2OagrHO4P3tRDVwQ5hFrfecKwo/Eu6dzXbyO7ePHLO0rUC/ztzQaH6CxY23Bseo8m9KWKtIQl5usHDFHNf0Z9tLAwifB7j3Y2t+IgYW3/aMF/kltn98qF2nZd7E/pt6rRnARM0hKes8BiSqjgoTEI0CXsX6q1mBlMSNRL2LWhyNKEt/eT0TmhJ3uXlC+rRMClDo1n7bYxAYXylb+UU4bcdWP1wLvHwpxHH4yDN8jXQJJd31vmBZas2oC++hIiLChvMu9w3BzqvLoL8goCs9/UNGyFXMd/+2TdppzhnAGojFuRgyznJW6Lm5p+ZDBr1jiEQOCzrlHseJqeNjUgtXj7P/Tv9tLpgRsK3bcyEpAWRlnu01FAly5aByX5n6OJVMoD2I14pAqvJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a4905f-13a6-4386-1e85-08de67836ce4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:09.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byQ/5meTTDRN3xNw5pKglqSWkFJLsqSwcOp4JNa1WhO+0e6Jz5yrEw0pliGWlyrO+WJQrNCsv64rKT2QwiQnCdZ5O0cyVjEv2ib3sS9h8Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfXxDr0QVPCnhVZ
 +pxIkcrKkOVfIwb437aH3BaL4iDGH20E2RtFn2EbKg8J0zjP6dxwIKe84j8/9XxqnFy0thWJRVR
 ayqdL66ou+tfENtM+WLOZ9iNhaKESTjxCzTUqnsKblTY7akoDeFZnAAT+BkCHBvx+dI+F9Ui+TS
 Xl0DTSIBjecYtGMq3F+63Ctf1q5CTJCr9L8ZjoC1+DmDshVTUMe6awWOVyyIgyTHBipHrc9wz6g
 3gMRZwYrWPSBvXOghqFnoosDkmwnKUOBsJruLrdsZq/+EuOTW8F7DPDCoNapXORNzPo58dRZke8
 FqJxggmbQb5uPLMIuHXZ/s0FhPVkqj4BYknFB4jPQPEgHiHaQAXkSdjcuwTaOU8GWlo7mkbFIM4
 jh24Gs2ptdqEenbI5LO/lNH4VdcxoF9vad6kwM9Lj4aSONVMpMjT0frXWngXUWSt0xRbulzGRny
 BmvLB8ZV6d20rH/w3YA==
X-Proofpoint-GUID: h7Rp8oTf_eNMHQSoT9aiIerDXCBVUUOC
X-Proofpoint-ORIG-GUID: h7Rp8oTf_eNMHQSoT9aiIerDXCBVUUOC
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=6989472d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=9GcLsRiznYava-zPbe0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42317-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid,infradead.org:email,arm.com:email];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7FDD110B2A1
X-Rspamd-Action: no action

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with additional LOAD->LOAD ordering.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 2738fe35c1df..ceac834c9e6c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -345,6 +345,32 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					     time_expr_ns,		\
+					     timeout_ns);		\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1


