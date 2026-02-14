Return-Path: <linux-pm+bounces-42631-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WqBiOlQBkGkrVAEAu9opvQ
	(envelope-from <linux-pm+bounces-42631-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 06:00:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FD813B17C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 06:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE5C13019819
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 05:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAED13009E2;
	Sat, 14 Feb 2026 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hab0AhxM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zaUmJmy/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8493009C3;
	Sat, 14 Feb 2026 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771045198; cv=fail; b=jV50FEgm+r1ctLCfdl/rY/D3FEBQjHtaB1+9A9ac54EHMh5bTHwElEp9CSpdtJXM7nZ7QIiNttObLhdYy2STmuaU2JXj5taw7KQdc2RzVoFK1HvNhUD/Npg0b588rz3SfRX3od9q9u5pBT3kld594DY8rdggI6R2qMbDmuKEVQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771045198; c=relaxed/simple;
	bh=VYlH4yov8y9zaWmMqKZwiPYw2AjtbNCKB7eUQCpj2kc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=eoiNFLnRfs9Aohj3jewgvobCsTzEEM5RJGY/BU+0q8qCjTkYAzEXONtO8ZYlUP8SgcMmooJDXfAPtS61vXvgXCkkjREJPQuAjGkwvmK3ajqkrwfajS5TiOcTRwRLBnXtA/fxPX5vT8XRSCETckaWUq0GXWuqSQd3qsAstWgCC4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hab0AhxM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zaUmJmy/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61E4Xw0B764139;
	Sat, 14 Feb 2026 04:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EHkC9IsioMYHMVOfEi
	enVuUuE8wgnJ+eR0D/HoxBWo4=; b=Hab0AhxMff0A9ZqYUaUJxfhzVwVJpu42Mg
	Eakuvr+PidjCX/BYN0NiRa3yoBiJc4oQD7bcXkGbp4mj4D01u9I+KhWbLLGMk4Oq
	2WMVuAd07pz4NM4WnrtOyB3cSEtB260BXGNBg2y8pDkmzIc6FdrOZl/3eBv8RuDO
	4l3WFAGe/FvI7Ys3IikM6Gg1quuLCo8U15ZBUxXmvvFa75mXUchV54EokFTNnyfV
	ZnaFbfcN1QDCjpflwYAgtg4BfmeULYSuxMsMusS3BBGVpkZkYy2Z4L1+nKTnsfAW
	2/LsB2cnQ5tLxB8MZANgP+NOHZRB34+fQn+R/LP6ePiSrlOCoHxA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj4ar08v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Feb 2026 04:58:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61E1YEZo033941;
	Sat, 14 Feb 2026 04:58:55 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cafgakctm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Feb 2026 04:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxcT2+j6deis9L9OXnTATO2Y74MI7ierme0p+isDqjzJaYMQ7+5xAVZuTEULDy/3l+nEc91XI8UV9aaDmkXjfadCCI6JXtkeVLSSJXW5fyHYwo/Bn06kgZ0hTxSxegIzhgZRjrmsvZFM64MgACqz7mKVylM/w8aEnq8ZsAUWWZf8x32itsiiY3HR0xA5KS1aofVc5kuDxgexA9ioatXyGUDuSa5CAg9zvjMOylAinC+GKtxi/5h8RwC6/zHuNX1ttUXLAEj7EhQKrchMoxCD0SmkQs7GHlWnsHLOqTmuiCXFcpdBAPh93kHFg5wBFEdjaAv89OqhWAyNUKusjUg5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHkC9IsioMYHMVOfEienVuUuE8wgnJ+eR0D/HoxBWo4=;
 b=karhb35evCsbxJfJ7BqWdT8iGRUyivAl9q3PfJm1BimRgIxBu2CN6HOEyYGbRbF3rT0wSUEqihbl2CsirW6eYUxaCOppBNpwe3DemoCYki0SUWXSazytMm4w7eADF1KHhVapEpgXK3aElVwFrzL45+uPqETPfGe96zbrya/jHoQB2/HAANZJ0G9PjTUvHVb3bm4DiWEaLVAPLk3zidyd+B3SLg56CHHqt+el66I0RBR2Pw5+eSSmwi1i+he5QuotSQgHVSrzuNnwRVSfaXMCqX7wObA8UWi9f6XCzm1KWf7o88lWxRBHYN0X6VN56RYusHYeyWETOexw04e0XzP7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHkC9IsioMYHMVOfEienVuUuE8wgnJ+eR0D/HoxBWo4=;
 b=zaUmJmy/lDVHvp6rbzGqFoBMj8Hbsry8uvujPzl9DYTT2P67Ya9UumnrC34lJ/R1x/DkocOwwjZShmh+ShdSBSjFhzTwPv1MRK5CpdFf377zvdeGDB8wBWl1iHVRnwcw7o/2uUeUgtEVOubfbALBqR0Cpkos5R9HpeuTe5UcgRk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7186.namprd10.prod.outlook.com (2603:10b6:610:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 04:58:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 04:58:09 +0000
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-2-ankur.a.arora@oracle.com>
 <20260212095621.4d99317b@pumpkin>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <20260212095621.4d99317b@pumpkin>
Date: Fri, 13 Feb 2026 20:58:08 -0800
Message-ID: <87tsvj6hwf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef5da07-3c0c-416c-ed7c-08de6b85a604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YQOb1pIt8SfBaE+7Ax6r4b0ULz3E6Gwpx2G+c5RuTe5V83rS/61/1Pov9zNy?=
 =?us-ascii?Q?U5Ccort4JPNAtjoB7d5aFynHRlW/L9Hnc1BP59xOBTKJZqfFrpVBVOSz+jr8?=
 =?us-ascii?Q?SNes0eVy+4ouLztqMwTEKA5wqilb9Y+owXYVlMK3aqi6YBYIEKyGfYCnDHwO?=
 =?us-ascii?Q?F/Ym1OyEFxIOCb58rDtOZH7s9Az3+02YPlVmGVtLMwLBczShzEjZfjY6yt8n?=
 =?us-ascii?Q?qxpzP8Z9QuewXLUmboNONr8zXuGkDi7Q5mKHFxzxRqMw3a00uFCw+n5Xb+03?=
 =?us-ascii?Q?7ACAYSUmbKEUUbis7m2r4JS54J7vL4RHYpSGjBxOuNituDkk/jh20vplz82n?=
 =?us-ascii?Q?T8q0/76nPRFTM1p02f2I/YS1Aq5O2uQSJaQCV6HJHf/gVE8rANmu+h5ao+ZN?=
 =?us-ascii?Q?SRIvAM0sT3UO4AatxItOJEHi/QPrpaG775fUPC7srhmf/rpxGMwgV4tZOyRE?=
 =?us-ascii?Q?unJEqPxCSpui1CR2MTP7EI8O4cZRxPo4DEVx6mc+XT5zzdQ/n6Ojic62x2OJ?=
 =?us-ascii?Q?l3XgmslaPB2R1/ooZUxoEL+AI1Jj6q+m8TlR0msatCcEG/h+DOMMYuVG5i+N?=
 =?us-ascii?Q?hjydtNy77h8xksGpEqHq3Ri1BaM7Jml/c4yqjMl1cs+Fa9pC4XkPPC4EsnCw?=
 =?us-ascii?Q?s92h3552oZg0QWc9kL+w+t1LFQRt37DeCwPdVXIqesda+VjiS75poAhhnaSY?=
 =?us-ascii?Q?umuimItfZQdUGjCEzlmLwBb4iMNqhftpqroVcPjr+XEst4P2eRyJjAtLeEkp?=
 =?us-ascii?Q?Y/z1/QjOVY4srlr7rF9mbOmpPgk53BKCqiBg0QtfbmmhWaZnyPzY/Z5rkMfu?=
 =?us-ascii?Q?ZZLnAk/3ixI40geD3wzvTg1IpHnGMekJhVA5Mt9ZC4RaDnCkUxpcmBk5OwSH?=
 =?us-ascii?Q?AbNCK8Jxl2Vm4qskCa/gznXOpNBUBL9M5LmC+2mtK+KbgkMKIlN6Cqr2L9WN?=
 =?us-ascii?Q?7fwNO3lKNeCaTlzHqLISBRfU6pdh3d4PiiiZCoKcJsuaBgAEMT7q28U5HBC9?=
 =?us-ascii?Q?nJaQwejGPUncvqCbK1XWrX5G+DoD+gpsEFCUHorwC/kuF1IzjIxdX5jgb+By?=
 =?us-ascii?Q?622Q52/b7afu95XCvgxelXcjrDRvcRyBpvaxUB2AadWN/DpPOM9URHUy92bT?=
 =?us-ascii?Q?EC7Ek4lPCQw0T+bGIiq2QlyyHlKIo6IoFRvSfUgJgMBhwaQK4AtCrXGXapIb?=
 =?us-ascii?Q?EqHto3z3zmJEchuQiFrs/Et2nAsX37xOUcN+VLYfZqh60qJLmMSKBEiHF4SA?=
 =?us-ascii?Q?0SX18citCslBVbniBxntk/iv4KAJ4BwlCwZ6aRuu78rk/6qNive0ZHb0JSjD?=
 =?us-ascii?Q?rey6SEt6owvjc3jzLT/TchalDwd10NzTWi0ZTkZ78zfhZlkeJGDVRoLzK4P+?=
 =?us-ascii?Q?67X8gFS4KDnBHJEYV0+eyTRR4i7yR8epdLGys898YmFBADakogTr0qbDwSiS?=
 =?us-ascii?Q?fdgm5t2yaRiIUv3rZeTnBF2VL4XXWoy6idkh1Ixlr8QzTeDU6mTNFz2W/PHt?=
 =?us-ascii?Q?795gp9+X0DzigJgjqJKZduJWz3mes3YO7hoKN+8Ndf+Y5SJdGUoCZeR/sZxl?=
 =?us-ascii?Q?uR0K2576gy5J+KQ7T64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sI0lP7csfKUC4C7j8cupOCsH5e9Gm6Os8QQgFU1V3julFEHbpJrZkiE3KohS?=
 =?us-ascii?Q?gYEdYGTP8jNIGX2U9dXbom/iqYCJ0+YrpJEZ0vaQV3W/zBtkSoMtWDYcecqi?=
 =?us-ascii?Q?SY2swQOUWk+8iXsKlN0fdzzf3U8DVQie+FOJMGsSoK/r5jLfejMCrMK6B1yp?=
 =?us-ascii?Q?TuoBdAsE1OZlYPA6x21G2Aa1/SteDwtYIkb1K8mxLxa2qO2tErxOOMq0cWfk?=
 =?us-ascii?Q?uFhBgb42g+52tTKldy677jEdYCUMccNrEhh54sFYjHNuUdqmXLWv5a2F1dPm?=
 =?us-ascii?Q?AiJ6pDD2d/7HhgMooe35lAOTTB5e+ZfLpj9+KTeQr+JRj2P1q9tJbAHYhXFe?=
 =?us-ascii?Q?i98oC+RCXEHYDVCHI8JGd7muoOfDv7lduPOuqkxLHXj4qL8iWsSOjWyKsxm/?=
 =?us-ascii?Q?O/cKtn/13SVohjK3mGLVC8kPXEiehgGAOXCZi97bByIc3MYOLZ9rMvw2pkuD?=
 =?us-ascii?Q?0O8us9w20rmaHAIXvmmRX2b8UyKLlWJRBIXdgK98SwGid0MCmvlZmUEredKx?=
 =?us-ascii?Q?+mQfkYLbGeI3vmsLAF10EOqApyPBiUzDiFDMk7PzJn9ck4lTOzjuL7mrcA5o?=
 =?us-ascii?Q?yigj8DcpW8Od2+mgZtIrSot/7otK51MouuCmMQ4V77sGgju3EpTVSg+CpOuv?=
 =?us-ascii?Q?xYl/PS1cSKqZAZB6ikBSElFArQgg3rmNbA9VfD2xk91ja5Ipd+20gSD5NKnq?=
 =?us-ascii?Q?79MJJyyRISCHsR0bKLdm4QNYyyoa+TX5fZ3ECAIzhweU8kQos+g5onRwPPpE?=
 =?us-ascii?Q?OiNNOfV8cchX2DoYEID+l2v0vCPSERssL3kxU/dHSkNovyc/Tr/KvZQ4/XDE?=
 =?us-ascii?Q?PYaj0XCftLyDhCN3R7q9ZSo7wmb1YFC+jXLmUcxCtdXPGpTnG3T0TctYhx7T?=
 =?us-ascii?Q?pjzA9GYoCBO1LBFtdYs74BcxEHo9sVZOhb06L0Ic/CbrfyZlhlVevvq5k2xM?=
 =?us-ascii?Q?ndqf7D5TmZl3xZv0rGYwg3on5RRFFEe0hGcxuyn+GZuF4WDBkmuPiS6nOMp6?=
 =?us-ascii?Q?qrqTSfTzhPPwi4YD3mptxVuhbCs9tES3CvCZwqqkb1M8gLVy3xgbEIwXYYSP?=
 =?us-ascii?Q?OXInRMa3L3N7IeytZUvAMn/OOpl8naOaeXYzN9t3Kss2Pc3OyshzbtD8EC6t?=
 =?us-ascii?Q?br2lCJNrYwp61AI38PbWJNnZxdl8re5rKSbYeea4igA9uKMhgT00PA37VBcA?=
 =?us-ascii?Q?oATws7z+rxsD9BYmRZzKuolgWi+JFfNF3U3gcppMwUgp/kyAHS84hf9+3n3m?=
 =?us-ascii?Q?jsTayXx76bbHa8+mnpeX7OH1nsI6Eh7dEaBdiw694Bn8UaDZd4XT1hNzH1MP?=
 =?us-ascii?Q?y3gQJBbfYDrrk8cnyYh/DjybglAOJG6rtrs7S/hdMOgquyUE1nV0AwTb1o+N?=
 =?us-ascii?Q?XkBaey+POYXRpziIMscJqyB2N+ZC8qx+F/ErdCstB74hpZSRTaRHL7878VB3?=
 =?us-ascii?Q?9tC4oCEWmi/sEVUqxf0bTjubNlc7Z8bCi++hoVgzCbmlbIU7PDIqF5MsyUgH?=
 =?us-ascii?Q?XPLJOL66RckaGftm6EtCyZPdEHxHt+np9ViBW9TRpy5byzVTkPnknpfjBiko?=
 =?us-ascii?Q?7kcLKZiVyx6iTVd1r8Q4T17MN6Tm+1UxSC4SI0EZJBVuHffIcDa5Kz8eWBCm?=
 =?us-ascii?Q?us6CatWWVKEBZ88Fb9DanumlYNbQm/KcYZZa5dwfzP1I/pcCtpbhzaJmDQH2?=
 =?us-ascii?Q?QXBaDVmS635CAkK+0l//KCVmBrS4o0UBYwMdUl10xKMjDwAPrTVVtCuZpVwQ?=
 =?us-ascii?Q?gdF8ZhMXl+1MynEgyeMdwZnIX168zEI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O1B5Diw2HYGR+uNVHB6oTSI5AzRdFoHcTZPZFOImr0F7JkoTkHEXstA9KehLvUku3SUbELP+a0qsNfI49ihE8J/dg5ZTOyIO81YpAnY8Pf01IoxFFpI819gpvtAJ5dW4ubRYjN/godaq19xKcMh2rrWIN/ErMXtHv0ClIAdBaRvrHP6ThV7Jybw3y8iK0k+mM7ojb3Bg6VP6B9zqZlTjFZ05+Ny5EobCR7MocVRNJr1AJFDvEKngAqFMKuOWkRWkCfPWiLaQRVCg7vlfYitVjvHPZfnN1r28unKCJTasQvbJXnMmaU6Lg2efV8z+6DZvjn4XJyMq0iUZ2o1JYfXDEHEskxLKK06Zs/fnodaK5MJt7GsfIYl00LJDrQj/0EmKOkBAw42FWAAMtiFdZMorOg6dqaU0VuzSb8TIvU8ZfQKj8sMB55L8jz6Es6wzx2lcm0wwMQRZplxmsE2Gd4GSL9/QAutp22nlaDa/UB70QRcjDb5F9rMFvc5lXksfcx1K2dzi5VfMOf59I5cNXCzXRSPudKxfVD12P0qumgssxKDN4dFy5uD7ujY9GJO9pePRnizVGaHM8JZb1HptEefRVca7UpTpinLiE0kWSm+JBds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef5da07-3c0c-416c-ed7c-08de6b85a604
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 04:58:09.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c30k9b7qjqVZwUSpEQDYBAJ0BMBFDom1b+62iunGyxrXKkuYjpBzYCqc36m+OW9IOn8mEMnVhIirI4MAXsBMzOuc1boXqL+80P8KgAXoKoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602140036
X-Proofpoint-ORIG-GUID: evvFSjUi11CQXjD3aviz6JNOpGyRw--1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDAzNiBTYWx0ZWRfXwspiisIRquPx
 DYuEELhhs1Q6b2bHA5Lg1nAqdcpz50Si7zQtEQTRdfrdWtkLZUMLmQWZRJMbMhggP1EOQRe7rQ0
 xgToxdKHO6sO+xo4KoGLaPj1mlcDsVVv4fTQOHWpTFvrsnfItVlUfOR0or+YSqKMdH9GdHdwqLT
 9+5Wvrw6VFD8eAfMNCXxMVAGslDSv70bf/SxEPzdg2OBg/x2RXG0yDKfCXFZhxKX7KbgF9134Lt
 rddjME63BX45oEuijnaVmRDiArfHGuK+E9tcSiYwU0raDpJii7KJmEnpkOUZzAmMJjBGb+otXu9
 cmW5gz7tTILFM31HJVSrUneOdbH1TB0GESBLz5u9I0pJ0Onrp5Q1HuBNWKacRFAiIW++zSmuwSo
 t9f6xCbZRw7fGYZBeITG0pusX7MUIqDwQibZNDV+ZrAfCNeh0tevcfW9bHorZhmk4pmAzt52o6b
 WyX/rTQI5hZnkwrhL6IRJKsdb8kgT5iBjjC4CZlk=
X-Authority-Analysis: v=2.4 cv=SI9PlevH c=1 sm=1 tr=0 ts=69900110 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=LSSE9_BVstAhFVXBCC0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13697
X-Proofpoint-GUID: evvFSjUi11CQXjD3aviz6JNOpGyRw--1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-42631-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.infradead.org,arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arndb.de:email,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 45FD813B17C
X-Rspamd-Action: no action


David Laight <david.laight.linux@gmail.com> writes:

> On Sun,  8 Feb 2026 18:31:42 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Add smp_cond_load_relaxed_timeout(), which extends
>> smp_cond_load_relaxed() to allow waiting for a duration.
>>
>> We loop around waiting for the condition variable to change while
>> peridically doing a time-check. The loop uses cpu_poll_relax() to slow
>> down the busy-waiting, which, unless overridden by the architecture
>> code, amounts to a cpu_relax().
>>
>> Note that there are two ways for the time-check to fail: the usual
>> timeout case or, @time_expr_ns returning an invalid value (negative
>> or zero). The second failure mode allows for clocks attached to the
>> clock-domain of @cond_expr, which might cease to operate meaningfully
>> once some state internal to @cond_expr has changed.
>>
>> Evaluation of @time_expr_ns: in the fastpath we want to keep the
>> performance close to smp_cond_load_relaxed(). To do that we defer
>> evaluation of the potentially costly @time_expr_ns to when we hit
>> the slowpath.
>>
>> This also means that there will always be some hardware dependent
>> duration that has passed in cpu_poll_relax() iterations at the time of
>> first evaluation. Additionally cpu_poll_relax() is not guaranteed to
>> return at timeout boundary. In sum, expect timeout overshoot when we
>> exit due to expiration of the timeout.
>>
>> The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
>> is chosen to be 200 by default. With a cpu_poll_relax() iteration
>> taking ~20-30 cycles (measured on a variety of x86 platforms), we expect
>> a tim-check every ~4000-6000 cycles.
>     ^ time-check

Ugh. Thanks.

> Plus the cost of evaluating cond_expr 200 times.
> I guess that isn't expected to contain a PCIe read :-)

:). Good point. I'll see if I can add something like "when polling on
a memory address".


Ankur


>>
>> The outer limit of the overshoot is double that when working with the
>> parameters above. This might be higher or lower depending on the
>> implementation of cpu_poll_relax() across architectures.
>>
>> Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
>> cpu_poll_relax() that is cheaper than polling. This might be relevant
>> for cases with a prolonged timeout.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>> Notes:
>>   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>>   - This also helps get rid of the labelled gotos which were used to
>>     handle the early failure case (since now there's no early init
>>     to be concerned with.)
>>   - Add a comment mentioning that the cpu_poll_relax() implementation
>>     is better than polling if ARCH_HAS_CPU_RELAX.
>>
>>  include/asm-generic/barrier.h | 72 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index d4f581c1e21d..2738fe35c1df 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -273,6 +273,68 @@ do {									\
>>  })
>>  #endif
>>
>> +/*
>> + * Number of times we iterate in the loop before doing the time check.
>> + */
>> +#ifndef SMP_TIMEOUT_POLL_COUNT
>> +#define SMP_TIMEOUT_POLL_COUNT		200
>> +#endif
>> +
>> +/*
>> + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
>> + * that is expected to be cheaper (lower power) than pure polling.
>> + */
>> +#ifndef cpu_poll_relax
>> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
>> +#endif
>> +
>> +/**
>> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
>> + * guarantees until a timeout expires.
>> + * @ptr: pointer to the variable to wait on.
>> + * @cond: boolean expression to wait for.
>> + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
>> + *  on failure, returns a negative value.
>> + * @timeout_ns: timeout value in ns
>> + * Both of the above are assumed to be compatible with s64; the signed
>> + * value is used to handle the failure case in @time_expr_ns.
>> + *
>> + * Equivalent to using READ_ONCE() on the condition variable.
>> + *
>> + * Callers that expect to wait for prolonged durations might want to
>> + * take into account the availability of ARCH_HAS_CPU_RELAX.
>> + */
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> +				      time_expr_ns, timeout_ns)		\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
>> +	s64 __timeout = (s64)timeout_ns;				\
>> +	s64 __time_now, __time_end = 0;					\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr) 						\
>> +			break;						\
>> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
>> +		if (++__n < __spin)					\
>> +			continue;					\
>> +		__time_now = (s64)(time_expr_ns);			\
>> +		if (unlikely(__time_end == 0))				\
>> +			__time_end = __time_now + __timeout;		\
>> +		__timeout = __time_end - __time_now;			\
>> +		if (__time_now <= 0 || __timeout <= 0) {		\
>> +			VAL = READ_ONCE(*__PTR);			\
>> +			break;						\
>> +		}							\
>> +		__n = 0;						\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>> +#endif
>> +
>>  /*
>>   * pmem_wmb() ensures that all stores for which the modification
>>   * are written to persistent storage by preceding instructions have


--
ankur

