Return-Path: <linux-pm+bounces-42802-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIFMD6hdlWkHPwIAu9opvQ
	(envelope-from <linux-pm+bounces-42802-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 07:35:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE2153739
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 07:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77A113012BE4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2217308F13;
	Wed, 18 Feb 2026 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OdZtEdEL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IyPU/rNP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256626B777;
	Wed, 18 Feb 2026 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771396514; cv=fail; b=JiTrdioVt5zFWt4ojp12X85h1wvIlGFIq31M+I5fIhDqvCI4mJNkhMm3NmazEmY/4+UI+1rflqjqbWGwoUYXwcKLZKQtIfhT7tWFCslGaOq6pCI+viZBc00EPwzb/ukf9hQYEK05RKAq+cZRMhQtPS0QnZxhnVghvwlid7siVRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771396514; c=relaxed/simple;
	bh=txqRZiNFyvobNeNQ001cbIYW8iTCX+8fZ6/JTv8SYhU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ak6yQdsOqHmqCSqmAuKbC/iX8i9Yr9bOU0AyCdqoqE1F44cQU54BO29fjk/kmhRlQg6S2caFoibNCz6jQm+wPs0TC6xy9xqZV/wPtLGrBPmIF2UlZYEnXQcrYCU48XlCofevOHouPi7kNKAEbRScv2ViIIWOSK+KMq07MdKcyXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OdZtEdEL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IyPU/rNP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I4rjOJ066232;
	Wed, 18 Feb 2026 06:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DO3YgnBbWtR3S1f0yo
	o2ufd7RY2WExUANCvoAuv54s0=; b=OdZtEdEL1ICg0V0cbAU35gAYcq747oRmao
	saZm5IjmZCawMaqmbgbMliTJwk4wpBwFt379s2OX9EuhxipvJ/zASB+g1PKOdIDm
	1GF7JXyTWiNJ6Upj6/GKtTEOEyp1/j4MMnBgrpGGX5FXjS34WscTyBW440k5SUyP
	qa7UM/p+Tti1hBseeyd2m71P9RF8KvjNUsZ/Ngi0vvmgXfnw/65XIGygCAYVB0Sn
	gE0FJa9fHBfdFFr1PY2bOM/J2tIx5qVQ+b/06Pgs3HOBdTpuhHYsevxiYOTmfdQ4
	taRlEIKMTiadZxLghJ9ckeHRE9ALo6SLYL5FNfJ+clEQ1ZzUGnoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj044xr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 06:34:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61I5EWFZ037228;
	Wed, 18 Feb 2026 06:34:32 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb287jar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 06:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMSbjmxiHzSNssIoQc6gpHe6mhbukR+7haiIOTj7S2XmrHRDSxuLCENBjnr+jrPQ51lu43iQBRnWEr71bk3CUMVY6nGMBenKUZoMWBMf7SUe4+qscayFBmhrCqmSuvMOmtsoJHDeY3rer/uM4L+g107+wo0vSKh3AtrjdzbP3wW0GSjHkLTXj50yWfkBXu0p/V5n76njcGlbrtQDxgZ89dR54PmFwNXKMSwylLB6KaLO5LopfcTAvROyetwVK5uMLavj8YIB5WtnWk0sG3EFebk5f4tRxnozl58JMGgrGt2cWxd0XdgGrb7rImoMwYMzmCnAZ/vSKi0nnMt3jpySDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO3YgnBbWtR3S1f0yoo2ufd7RY2WExUANCvoAuv54s0=;
 b=KCqqVmfabGFMhKh1NNbVmB7JcOLiUG8dBRHPEgf2WIjwrLzdpmTJYd8LSWa5baKr6Th7bj2o8vXCGEl6Q6pf2Eu4Nx4ttuVcWluWBxDmORshKFyj7Pp54TtTpNKx3DBje/iQfSDSJebWkUAY45wgyeR929FvysqvWLkBED1V3BnuqIgTu9BoJ3FwdB6AVHS/CZsG1BtzJYxecJVGR9K/TF1F/nCrWBJ5qSPqGFASK6Vl506tByxck+UCvNlkCEY4XQlWKZYyeUtTIuU4JvS2lTg/p13Foi4Z7iActufu84ugZ3Wo88FG2p8lyqbg3+tTd6PpCPov1pl3CmjkznXI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO3YgnBbWtR3S1f0yoo2ufd7RY2WExUANCvoAuv54s0=;
 b=IyPU/rNP1I3xNjK0vXtH9uqK17FmCt6Wfxt27bX/yLsvaY+CY7TwmYvqZVZfw8YrOSiEeuCnwGgyBMouWkWxKbDmAkqmPdc8fVuxYCA8wEgDFsvlnD9+763TwwDl2MadvNGyBNpjjs5SPlBbOtwDw+Q+n5HJbaWYsgUKTf0Pxeo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH3PPF54C97C915.namprd10.prod.outlook.com (2603:10b6:518:1::79f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 06:33:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 06:33:53 +0000
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-2-ankur.a.arora@oracle.com>
 <20260212095621.4d99317b@pumpkin> <87tsvj6hwf.fsf@oracle.com>
 <20260214113122.70627a8b@pumpkin>
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
In-reply-to: <20260214113122.70627a8b@pumpkin>
Date: Tue, 17 Feb 2026 22:33:51 -0800
Message-ID: <87ecmi5zn4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH3PPF54C97C915:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeeecc0-c6c5-463f-22f8-08de6eb7af70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tCbUtWJp87tmn+TtneWoF/w8t3cU0BAcurgxW7LNf5Oo+q2yaZ+YbKgnhL9f?=
 =?us-ascii?Q?jdJo0Z+JWnwJxYmG/L4A0p62mrc9sOkrC771znvljz/hRqNRsAokhSBOUDow?=
 =?us-ascii?Q?/gU5A5z6KgFrU8yq5B6QDpC+BtiHnyiTAuNeD11fEUdkldU+76ISl3tbz92/?=
 =?us-ascii?Q?Bbd93I78mC0GzEmb8m2hicJTLmveScVn8M40EmR4hAMASXtc2hHQQlytpYWt?=
 =?us-ascii?Q?9EnIYTDqjokE53EA4HDIprTAHak7j+hUQfzalaqpY2SymM/VJL1st8f0SFEB?=
 =?us-ascii?Q?v7PbN6MK8Crfq7ngG7bR4ZLSraH4AsyT1XJkpnptsyX9SCyo3Url2A8SAULQ?=
 =?us-ascii?Q?p8WlHj+rdr92G68JswNqdoZjgspDy2hLPCt1Fra0M8jfZTg4D6pR6fOKhUkB?=
 =?us-ascii?Q?EKEzDzZlbEMtkcS8qci8EQQCgdlivuveGGwzbRhZ67M5/txxISlHoZneccEh?=
 =?us-ascii?Q?FDRrKoIOX4nlM5ZAnZtjJOP5o+KfGXrf6GfZ0IjyKni09sAlRbdBCCkJ0p+F?=
 =?us-ascii?Q?Z38qzcT8ImCb0LqK9nVPOZu/LaJ75O2zuJPGD9tCVSUf0MuX6UkcDffRZFW7?=
 =?us-ascii?Q?TbvS8Wmv1EYsmvJEbUKRHDgcdqkV3blC89rlC5F0t/Ufg8ai3k/Ffe7ZH6J0?=
 =?us-ascii?Q?U1r5s5XEDCKwjzI91cTCB95edcYDGr3MPqDT1yj48HACkfn+CPWHW2KcMa2X?=
 =?us-ascii?Q?3omZNBWuz7uvFGlIEgqr+3btuVZt5m9dpLXGbreHK6STVUccYBsBPg0F1lVb?=
 =?us-ascii?Q?j1AHH3DTHvscBWWTZaFFNvJNT2M4JFod3H2A8okJdISEGJZa5C1z1aGyFrif?=
 =?us-ascii?Q?2dEr7nj/dlBlF2TF2zhm22nL49772otvfSuVj0GHXrXocnuBUfJhFJ634DAl?=
 =?us-ascii?Q?3Wx3iFm1McUDdJx9BFCdqVO+UjrizcMzYWgbrq5N5hwKp7ZO0uccncn9IJiM?=
 =?us-ascii?Q?79Z8+S/k6h/eYGEQHCr1HaP6I5tG5jWC8JPB3BRUCmuvId4r4zctEiR5bVaI?=
 =?us-ascii?Q?kZcKkB9NRZezK/adR0YLa1LQfI+767djAHyY6gLUuuK01Pb8ccpgrejoRhf3?=
 =?us-ascii?Q?BTghZ8BtWiVZcwvuprw/YcfP2kaqvT/034EWwO1g6c0/AnjYCmn/vOL+B7Yr?=
 =?us-ascii?Q?wMCH7sw97VRzYHVwDPEMUrXDIaYrtmad2RPqBUbYgCmqjDqPsjTrlr0Uq0V9?=
 =?us-ascii?Q?P+NWLqUsjieOuF2zR4kkXgHcFvDnb1SYIfn7/rh5bT2vSy/Aqy8nuaNROIqi?=
 =?us-ascii?Q?TYTkwrC2DXzvr8YbHIQFT9fC7WCck54//7I202yZXxl8YHBOQ5NghzMjvIg0?=
 =?us-ascii?Q?FR8qGCTOwnb7zG2pKYc0aHbL8wpMyDISs7cAQV8x90FqJcf3J3NOKZr/gLkq?=
 =?us-ascii?Q?Huo40MemnNaIsitfmCjkqAbWDfClsaB9kZtQBcN9FjmD/9IGQVXAzjxg40xz?=
 =?us-ascii?Q?Ah+9sXdrioVjFVycj094EpvPDkbTjGaRjm20cLmoKfpkZnzE6taWkkFY3i55?=
 =?us-ascii?Q?RlxT1PF9F6kCvRdAdUdKyl7lRMvZPJnsbjtDPL5H5cInzSJikZUKRjnhLoO7?=
 =?us-ascii?Q?fV784ckio4Sktj82ZEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxeFmxP0EeaVwIeHfmE93SxBJoHyN5hEHMTB04CEzUzfk2BLPQe2mDQr1S6i?=
 =?us-ascii?Q?xCShCnlL8iqREw46Dz2tjp+dV9USLS0ozy9uo9HdxfJsUR/Tx0/wet6w1a9W?=
 =?us-ascii?Q?VgsOp0qKXRaZgsajUpcDEcPIGjuD5IxbFtHN6yjzjTl1o5m4RytvtLarWfz+?=
 =?us-ascii?Q?Dn5dx1L4zhzfwEp12dYMnvbj3ImcKQ3Ov+IPWBiukyfKl0UrBT0mvzMvg45I?=
 =?us-ascii?Q?n8GXg7vGw9zq+6QgZUY4ONZKW8ePRzAkpiJFmQIaxB22aEzMNI57qtF7vhKH?=
 =?us-ascii?Q?9DQeSS6CF+jOw4+LzvtGV0prpoTl0BcErsdas6XwN5RqmYkcFPK7ynEKRnUg?=
 =?us-ascii?Q?MySva1PXKtsruZbisJ9UT3HVvrT9o4t+HvACk220BIfgYLCthLBh08GMMZPQ?=
 =?us-ascii?Q?lkFqJ7g9cLH8FLOPjM8iiTo+iRS531z9KpVl2YVGFF6+kX6FCahVG8vp56ht?=
 =?us-ascii?Q?UrhqY5rZbGByxFZXSZa9f7CWUx2RXUK/y9XE7NA6GvxOE7EUWK88rB6kSYbM?=
 =?us-ascii?Q?6Iy4Xrxzlrgh1D49rOGU2tLY5xF57cGpWeZxofLvKQ/ZbVcUzVSbffSdKSYE?=
 =?us-ascii?Q?ki4ZsatALinti20IJutXOKaBqcLgHm/MlV3eoN2mJ5dB9KczV9q8P23vZQqR?=
 =?us-ascii?Q?N9ZqweJ0qL6N++v/mDXFl2UFwtmYi5IhyYVxoH+A0csA+RjEGCwW4cgtz0u6?=
 =?us-ascii?Q?y2+82xZuCtN6U982PXY9qZ3Hn1abUVj4s6kL+GemftZQkSxkE2i5yZZguwJ4?=
 =?us-ascii?Q?tsZKoBDhS24XGLvECJLjjS2ctkNxXYsTqhmMxvCzm+1tP32j8m0d4hOuo3eS?=
 =?us-ascii?Q?JS103DfXOUD/kN2hkv99qhcG7tuBx2MO2QkwkECfEQR6hnd2jO0+Btu4LxsO?=
 =?us-ascii?Q?PhgMGaLLoOatf8RFS28SEEHoSOB4Y9gOpe/fPHJG+B6frR3yK/JG85mK0zl9?=
 =?us-ascii?Q?3UEX6U4Gi+Vf0BHVnM71mLfwnbrRvrMDie8GFJ9Ov9sJ7IKd6+EdGrFl5N/C?=
 =?us-ascii?Q?91rzcVcOSAgDHy721yaJAnIF00l33pnrYJ3Nw0E3ZQsvsbaWTEL1/EUFZqAm?=
 =?us-ascii?Q?Vt6fzZIHYLOYPNuRwDz1zdQDm8BFtK5Q4J18PMLnyxDXtYXY9ai9fsrPU7BX?=
 =?us-ascii?Q?nhSl++df5XUlX1vJk+KIjt6LNVYdWLEqAfnNosMFxuOsX6p1DD+sOHXvzwc0?=
 =?us-ascii?Q?3N6bodKVt0NzTGh5oYwTROSFigFPBcSWn3wNf8EsZujTTslHoItsBsFNoI1y?=
 =?us-ascii?Q?4dGefTksEtGDwNNSeF3rn0Ad10gLUvGI2ijJxT6yNWz8hGu5/lh0UWwaWwk0?=
 =?us-ascii?Q?pnz82QBKvYHSib2X6tWjZCncO/ew02m4Hff+L6CtS83yOva6tsnbBGg5zyQu?=
 =?us-ascii?Q?d9XIctMzvvLMYhTxq6krwgqXsG7ugirjBZBEJAlYaR57pG7J2TclQfKcbsAW?=
 =?us-ascii?Q?+SM/inv4YZmSV/xyCOW8VdPUV4NGyfUglKhHE4qJeTzR4rWywaXGCBu4rrnz?=
 =?us-ascii?Q?C6ZD+ZNeNFUHj32EmwPrkV3iv2vEKYIp5n2/i179hmJQo8d1YH+N7Pm6Xkzh?=
 =?us-ascii?Q?TwZmTwRA5ZVDF/FbizQGyNjWUHmmdg+zJNlyVpbHQfdetaL+jD0YohR42t7w?=
 =?us-ascii?Q?6EH15OroSd38sxRO/kl7IrnPuFJ592Me/+sqETrFLMVcWUe67I1WTt5XCAwR?=
 =?us-ascii?Q?2Zj29B1eho1B19JseccL3DKb8Yf9/B4SKMuHV4H0+tzU/SP0xDecfEZhrnSQ?=
 =?us-ascii?Q?cyRq2ck755c2HduflPdEY3WOf6Lh7rE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VNhOre8bJnEhxc1FYy06MUKr4ezuljV3AYRh/wP4gG993R/1sqwd0lRwybPof3CLSPZ1Ivb+xYkKX49EAuPu6lEdhtHQqOk/tkwwLID2XC6tkCBl4VZU7IC/eeAAiFYsHtiu9BoQEgcV5VacH5F28Lfgn8pv6ikEAnEAb83VSHu2AlyM8/UNJHxBhMd87BiIa1vJ6VImCLH6zoPwfoKPabzS7dqcyxzM2prcsrmB8gWJRXfb4H1dL2i/zoc+8DQA3cNJC74MUgEw+7THfGxTTQjuvQnvjo6GIg2kydRbIXFOR7C9tTGkhNe+y7PNgsnFuGDrx9rC4jserY6buQ1/Bc/yZia2D2AFZMVPl8JmCfRpc/Y8ERq3JCN+/okZIgkDPUkBpJbPkZu8YOKbRLW+p7i1IrCzSX/MDGbonw6mGu0+MW5Z/3ar3mPxeLNAD3Eo+JTHY48dZuWlvlHelCaydrgMiM5eWouT58zPSo/Z/KvWAGbNk1/ZWwL35+BpdqgRo8TesRdGWI0uZEQ5yQjmUeLuuQlTNwPI2yoYLyImzpnr5FDUPgPcAoQEeY6Qxsmtm3FCIsikZSHNkiRjIdVznmMMQZJkk5mpRo66XfEWYjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeeecc0-c6c5-463f-22f8-08de6eb7af70
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 06:33:53.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GPXTFqQNMq3Ry6iIg+4BRIZMzy7DDqoOMmp8WbHqzgfA94qTooGWBv2n7s3FP2cifC6d413wT51p7YPk33LTHItJq2aWmBhyo1SLhw7iS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF54C97C915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA1NiBTYWx0ZWRfXwiMy2uTmPP/e
 +tDYRdleueQJ9lO51L6BkOPzDFaBd5hNz9+mqgI4drVHNj507+GC4fkVedkvVjZutA4pGgMAfJu
 GAQBgjNm9h73xHg3oZWFW0ZkBRwGOj1GoLpdCZKQu6JAY9gkwT9ksmYyMh94U/cZcyoQg0pymwS
 Anc9RUcbDJ77uhtmcXaAP4eZJnEmm40zb4n9wLuGQ24/rZpe/zENrxVKWx6ftMe9s5CH+D9Nr2v
 zH/vM0Z0O+ngKA96dvEUvvKdtU5TqmkT6NyhuwtDk7jW+Ycm5mOH1o6vH+z+mLsRQeiI8c4xtJf
 UN2Uz721iYrxFT6sSelB4wGdgWIYSuLgrImJkBmkAsiQp4EXTxRlaOa4MGiC3pMPRsO4evdNg3A
 1FCNEoRltTgJiIh9mQPus4Tobu4uxxDMKM7lPBpdM3S8F4ty+KtPY5sETEnDE42SYyhO1b/Nq5Q
 KqBkgemOEtvvkfCvtRWXqDW3gez1ryVzDkmIT8so=
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=69955d79 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=NGBFiY301OB6yL0FmD0A:9 cc=ntf awl=host:12253
X-Proofpoint-GUID: f3er3vAOSwCSzaYrpbPeC7xNVUWR0V9j
X-Proofpoint-ORIG-GUID: f3er3vAOSwCSzaYrpbPeC7xNVUWR0V9j
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-42802-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8DCE2153739
X-Rspamd-Action: no action


David Laight <david.laight.linux@gmail.com> writes:

> On Fri, 13 Feb 2026 20:58:08 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> David Laight <david.laight.linux@gmail.com> writes:
> ...
>> > Plus the cost of evaluating cond_expr 200 times.
>> > I guess that isn't expected to contain a PCIe read :-)
>>
>> :). Good point. I'll see if I can add something like "when polling on
>> a memory address".
>
> I've only timed PCIe reads into an fpga (Cyclone V) target, but those
> are about 1 micro-second - which is a lot of clocks.
> Hard logic will be somewhat faster - but still slow.

Yeah that would be a lot of clocks.

> There might be other places where 200 isn't a good value.
> Perhaps add an extra #define that drops in the loop count?

In principle that makes sense. However, if we add a variant like this
where the user specifies their own value of loop count:

#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,
                                        time_expr_ns, timeout_ns, loop_count)

that means that the user needs to define a sane loop count value for all
platforms where it might get called. That just seems to shift the problem
to the callers.

--
ankur

