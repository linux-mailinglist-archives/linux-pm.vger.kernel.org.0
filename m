Return-Path: <linux-pm+bounces-42312-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEMMD3xHiWn65gQAu9opvQ
	(envelope-from <linux-pm+bounces-42312-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:33:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE610B1F7
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A448301A537
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710472D8370;
	Mon,  9 Feb 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EfF9l29A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DoQqdu/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E82C15AB;
	Mon,  9 Feb 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604372; cv=fail; b=NkfJNDvIqWU72DtyalgbiJovKCJms8x6/XOW4AYckVaWsCuApwZrdUAiqAmqS6cn2LcNpj/55mEOBxyCJ1B+5sNUYkEiUJRZlhfUE42lOmGH7J25mlcvGLT9+3IM0WCJ8DCLTaE/r76b7f3Fdc6JVBgiz+gZIOLkpIbGlAG47nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604372; c=relaxed/simple;
	bh=6iusc09leOoC8Q31ivd+cOUpP/wiX0sqWj40mFLvUjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aezz5i7tIYbT/lKxvIIPCVT7FB1TmNCeLIYKeRWxkI6vQfiSRXqO9BV9vAugHzwaqCBqn/SePbtxJWanKqVbuZuDq04vjIpvFUoCfeHAmoi1Zj9BsMoGaJ9wp1A+o5YiHL8JGOlfuLTWvDPmeTpd1xWgMveXalpZxi2NMY7aRFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EfF9l29A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DoQqdu/t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190KniM272207;
	Mon, 9 Feb 2026 02:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KnhSRHO/e2oi/DmqGgdboWmx9wTDyHerIr052lj7bqY=; b=
	EfF9l29Ax/HUyIsGIyLGOrb7Nx7hqQ/NhVELOUSmfWMHn8YH/+Rf7spL+o5iASjy
	wUDKGacZ3gMPHDwDVNNK9ztTy89iOPN/Hl+fBwsHzBy1pSTWM86Db3U2ZSyb1/N7
	A1wcMlNlW0F/jr8gEuHhS6KP8NHqmIjbKvTcdlYno2XEaSNCVOSHB8nU4983AYiK
	e3K/aYdgCKP7G2O3CLOjnGpPG54YtezfCqegkghPonQwAiSlN/tIJor1Fk7iOuLE
	hBtNYwoX4KOnpjTBXl3aVmjydabKImY9KHhe7CyiLhkzt9BT7UuvnVULGXm2aiA3
	5b4PTyv7NSPtEjV8xtK9bw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8s981-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61924QZH019786;
	Mon, 9 Feb 2026 02:32:06 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu8g9q1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhvC1TTFPgWBxhjM4Q6i7KH5taGR5wwa88I4UdL9VMzWNNhEw3LR4QqV1ANataKCKbYS8e7G1LpSnZ9Naa/IYYAg+Yp6WjTkHoEf8pHz1Rd4BUdZKvMlNgkRCeNVHeajx8sA06hni3f0247/GJzt//hDW4+Fu6IQd/Z/4oovnb/VwGRJp+sSaSZAWgflTFkcpF3ECYbpZsHG4Dr1tMc7WLxS3eyuyLN0MoS9ib5K0s9H0/1T+z5YwRVtiRuDWjc1kHTqOZB6lEB81vVGpjC+Zh6S86r8mG+bFSGQ3GP08o2Nwo8WKfGspBuKsbiJhFTlEe2FUyDRAAK+9DJRKX+pGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnhSRHO/e2oi/DmqGgdboWmx9wTDyHerIr052lj7bqY=;
 b=YBqh3np8jqGkdM6dSPn5shlEU1YfZDNFk9r6k9DW62c54oFxIdhWwQqZ3IaIKnBuekfAnIePcjK5wuUAIHfq1QTgM5LCmW1qCN/n5/fCbi0WgjO5jECAv1YerBnN2/m8b1CR5v9XLYUNmFSUdyEShxftVN0c2sts2wg24hmerA8rrnROiYeJcZNnwnBp2sginbJIdQy7y0RJzVVYjAlu7yGu2faR1TJYV88gpCGdJjR2KS3I/1RKoytGBB7QoBR9Z0omaoqpMXqORO9S2B0rh9KtrdVYc3IT2fH5ZaffI7BJV+uU+EN3I2AQZ/0jFBHSxLAkgJlU1f/Yo+4CXBfdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnhSRHO/e2oi/DmqGgdboWmx9wTDyHerIr052lj7bqY=;
 b=DoQqdu/tM927ltX9DbLRrYoPQ+B3OALpYEOGmqCi7J00WF0Vn+8CD+91AUpa9vQpbCWQDYTqfz5NT0BZtihW/m/9EA7izox5H1tKCQZFu10oOm8+tqV5fpFWF6OKE1aC6ifxHxfLezy+BLNkASXEeUdkWhHf0dl1nvmow2Lu6u4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 9 Feb
 2026 02:32:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:04 +0000
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
Subject: [PATCH v9 04/12] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Sun,  8 Feb 2026 18:31:45 -0800
Message-Id: <20260209023153.2661784-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f8de17-e939-400b-fcbe-08de67836984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYx4fzmRWZjIV+FI4RdXx0+bauG9ni8k6Xz/N08SNEB7+Trx0XpYhMndMcc0?=
 =?us-ascii?Q?si1KBGDKEs/bSEB8jshvqWUHtVBmSBJ+x1gMDnHFm2kImwlwTWKlV5jZeNA8?=
 =?us-ascii?Q?WwjtlVSNHqB5TOS3pADuqk6wGytTw45OFNxFjRoIAqTlY6A41chYZiVz3YlM?=
 =?us-ascii?Q?7wf9ffdrPATbKdWU+3BKgCZJ0eZwYIBPo2984wz+bCq8zRQGtcevXhY+JJ08?=
 =?us-ascii?Q?/40y6hszjWQ6DcI9LLnyTzv+VAIv89nz8NDj/q+r97skYeIdJygs3KOGBlZg?=
 =?us-ascii?Q?XbFBSHqMlTKtYmIN5mAqG7IL7dJd2M9/bbNNrczzxhfWnPgJvKcEn8HkBa4R?=
 =?us-ascii?Q?8rsczzeiOy85q+2KlhWCsrkwqrvVIaBfyeLk1ktfNrm26LrLb3wOEO2+RFoX?=
 =?us-ascii?Q?mdZaAJU2f/UyR29gryxvtElPhJh9VmbLMoSMyLBQJ7BVBlX6GwgdSskwYg3m?=
 =?us-ascii?Q?o7NM44WSLhBfcVqhB/+VKlXuCklJfbEDGuhJrKgJhcmklN5gfc4sjk76Q4gD?=
 =?us-ascii?Q?wMgNTis+T1Bfs1Tq3oq/EtEyYeUjaEWMfMufpbfqEy+HnydHpqFqnAjwrBdf?=
 =?us-ascii?Q?DgtRCF5KB78Yxsx/JUrOc69p/nYa+21TZjbFGIlHe/wZ68vWNltptEGiknVP?=
 =?us-ascii?Q?zbXQZGTmdk6b0b4gveY19KILG1JgglpoL3CKi2tZveRRrAle6UMDCzWR725d?=
 =?us-ascii?Q?kVPEardcF/axhetZeNOJ7s6DETIm7KjcIu3Jlqg7w6NhPzOgOjbTEhUyBY57?=
 =?us-ascii?Q?nrVjysX/iXfR2Mkm9BxqW2q61dmDnepeiMXA2Nj502YHbFYqrS2rjGxjv9D8?=
 =?us-ascii?Q?4VmdP+pvksDvGyyGNl6Fr6NyYFcY+oH7kD87jdfUnx2iOq3kmXUk0xB5AJwp?=
 =?us-ascii?Q?C/xMpKp6eCccDz4PXD4kOf4N43Z2mlYyveCSkTG6dy2rcrzlx25wdU6slMDR?=
 =?us-ascii?Q?GTgisFqcOaXaKrProLjmB3WmWdujXlN6U6eIsH7LQuhcl1F6kRMCGoLSX45m?=
 =?us-ascii?Q?JRV8ilUqpByOV1/MxwPZ2s8NOAMuK6OYM5ifOrPfOc6YSvekI7i51tWkdNHY?=
 =?us-ascii?Q?H/5ViDYFaE7tlhqZWd719BuTm3nXusFuRczbGJl7NGqfQL3Ikqd0JTEufyDO?=
 =?us-ascii?Q?/ZL56/3o1FE14RNjGBxdZ13qPPMwb8eefihJeWEbrRQr9HAIjezf+qEsTyJo?=
 =?us-ascii?Q?JztmV5YlTWHc7Xv0B+tmxykRu5XnaFXr1VXR7chuwtUof0JGL5rwnH3ub+RN?=
 =?us-ascii?Q?sVCsoXFY3asIM2J4HSl7DSWpP86zerVTvdEEaEKz9ajlcIJO6KxxhRFhiAom?=
 =?us-ascii?Q?mtuSpEybVkdyojNaOP+egLefZfqfjRbbDEAJzX/NBafozba4wZPcaI8AfI80?=
 =?us-ascii?Q?DP5/4q6lWgdCbG7AjYfChyceNXZlR2J3aRh2vUewh8hbgah+B81MSq89aM7o?=
 =?us-ascii?Q?eHqdwNqtgeNy6UIC6m696rvmUpHbldyrWGw88vfqjr+tLcbDgqg4kPGfr2tw?=
 =?us-ascii?Q?mC/8fRDebFOQryoOUvOPV576b1GjMCB2UY/HJQBeClA6MqM+DR4JBNKfMvmC?=
 =?us-ascii?Q?uYBTHvUQU3G7P47z6+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7loHJcfSJYtbNH7qiQl1ChMthPyfdDTZZEqSPT325polfSmIg9Xxne2XDNBm?=
 =?us-ascii?Q?OTxZ2QglyUJ+WGrbRI0k5revDFPin/dYys8GMBhY0lNoITz6PMOpgHb3nMIy?=
 =?us-ascii?Q?lhGlL/9nGRVclYwn3YkhKyb2z1g1BGFy62KSBXZtw2RXfOgJg4cdF/eTm/rL?=
 =?us-ascii?Q?03Flu9d9AVFTT2OIlYi/KRJLOP587lBFAyIil7Snc8b8UN1PExsAmRdKHUN5?=
 =?us-ascii?Q?saVewxo8grINYTJKmREKYmh21knUmpZDStuoy05r3pgDsJcvEz9sd/EI4anQ?=
 =?us-ascii?Q?H4uNTCAeU1LwL6D8eP20yj4qznJa9TrGxyRa+bomfMUQJLPGwRqMd+lRS0v3?=
 =?us-ascii?Q?hVJCJHcv1kvoSx8C0EC6r8gZAgGGMrJcbHZmJqBa4YLabdd/xQgJ+qXp88oP?=
 =?us-ascii?Q?zAMqRHuHpjdr5NIuSdJSD45fCKoyQJGusCDwf2Frq//jXrptAiv30ASqXqVk?=
 =?us-ascii?Q?zzh/vJYXd1NvdQHupAFDTYRtoZHYJ2ThZtcGzIkFocAZVy6MarYERNcgZ1XK?=
 =?us-ascii?Q?1EhwNszwgZcDDEBGKK85LK+Mymf49Ln4qQ7cnwnqQAh0lJeA7ga3zMPBVhIY?=
 =?us-ascii?Q?VPE9759QlDTtMb8wfFsBD5lBIwe26h1IDFjprsuMrEvrnIPWmRfORbn261iu?=
 =?us-ascii?Q?CfYwT4OQd8MZvkGt9twY+wwUaTx83filHddh2KUt3FK5YrBqU4EfIwtpCiPt?=
 =?us-ascii?Q?vLfENL71oLT+Rw99KPqENo8F6fru9uqzFVjD6i1C8gAXKpe/p6xsOqBglDqu?=
 =?us-ascii?Q?qW1SNoL29ZphI8LS9ruHm7/M4Ia4PPOh74YI3Gth8wg3SyKv+Ypg3C5bMacm?=
 =?us-ascii?Q?khF5L/ldug3FTdIDbodKkGOekR7cc8ZKnmP12bJ6qoKIdkZ4NhyqLREuL5UR?=
 =?us-ascii?Q?PgIlv9roocPQJ4BgFe9f4L4ocjkxESKulOc9ggNRmQ0tMNxOB3PpNnoru6UA?=
 =?us-ascii?Q?kO1Vd8JuBv5bnWXXL/2ffa5Zcs8GgC+/DZx5bVLLUUCzKypZIiBnmnwD/ByJ?=
 =?us-ascii?Q?LVRJmS02kwN0k5hAIqbFyiHY4GmtyHO1sgW17vJzFtel37Jwlk3x2GnYQSw1?=
 =?us-ascii?Q?vsE/Xrw0NjOBCwdO7xFK4rqrvXpw5IRc7EitxNf7UWth9SN8U8VqyuvbmCLl?=
 =?us-ascii?Q?qoUW6VTW4gr7JFTxilJniXZF8YO8IhCn2dPbrYWwPwkhOT3tVP3oMO40c4g3?=
 =?us-ascii?Q?+9yxqfaMCTXN/PPAVKTMAdZXGB50eZ/6Abky76DPZXQv9rT7ErFeRQQoNTIC?=
 =?us-ascii?Q?0vqVFaUyii3iZl30pCNzpwUmCm/s3AtZpyJPcIXu7/kF3T4h4OQWX7miuNA1?=
 =?us-ascii?Q?D49mbEqQjeUOa9oncYOUA0AcAD1aUzdPtjjd5Cuy4Wc3dkU1hj/KqFV06/d3?=
 =?us-ascii?Q?V/Q9Bur4+grh6wm4Zoth55hjJDnV4oM5Wwon2dwnMUWxKtLd3T6ZJ/jjJa91?=
 =?us-ascii?Q?Hoy81Oqgr8iGCWu1IZ2LOfYujuCASbj6TTng1SecVDIh8Jd8rd1FeBK9NVpr?=
 =?us-ascii?Q?H3TonVW+j8nnTUCExoHLyshfRfY204hqUseAnFbY/sx7EOrrEh2FWMmBbzXy?=
 =?us-ascii?Q?awAqwnr3hVLlNPjkvs/7V5SMxfyuZ/OuPjpimSo3Ih1n8K5jkf5HR65/rZTT?=
 =?us-ascii?Q?Em6Sq5ZHoZxqbzVfKsjIOz2V/KT4XVF25PKOc9Xx1wemFfgktVcAJlnWMxy2?=
 =?us-ascii?Q?It4wKqAe23DJBuxiACzhDgbUPO4c22NcR4KxxOGQxMPLtG4a5sB2mMnn2xBR?=
 =?us-ascii?Q?NXXDHtGdg8dVmdTtFqdlKDvipKkYfGI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f0j7EAoklb00gq+LEBUaMokjV1Md3PRIijrQtxkGVL14Y3ZA4lApGUqqLK6ha0gXli0+XVip9IefJVVvCUfTlU/YaLc9EwudIAt/BMqKR0qPkTPlqfKv+hrGMg5hXO/pKkzxkgkntaPWRdADpHHT8oUrue2TFqwGVhmE+Zx0vZXIa9mV1BUXbZjId0PSr0tjIWpru4EB2KkSz0sSqtcMkfeAb6KQKSYHDK1wvfXQGaHL0O0C79yzeKowVkZDQqoRGQLF1VoT8vm9kuEoHNvltbWpedzOS30+/5PoF1Ukz4+iRtVxlfFpvCM09LgGXJt/d56CVGZAqGO2HTPIkw1NsRWIT5ubY7HFxLmX8ddlupX9tmCrDV32z/vAT/y9sFwsxQZhYP5CQZ0jmnZW6DURtt//Ny1XhneWsXZKwxS8pv5KY9QyvvVp4F8j8NZePl4GVkWJaGfEPOF0gcHYn8lEEepdSBzUS60n8XDdzrfnD0qd6PAb76mjs22uZqe9lfJ7wQwwoexNHtG4/k2axKm9x2oOFDVap65dV256RQuj6EYFk01YInTgRDxG37W5iiL7Qjqn66jk7ySZb9f7b8sw/aDHW/i9oFL+U33BUR2pLhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f8de17-e939-400b-fcbe-08de67836984
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:04.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1ueravmkqnzql2bTjJw9phpR84eUTi0ttg63h6V2YKuDJuzOh9pek49rSgCnl6nVl4YgtEvjEnlVTSScu/g/XSwpU9uHiTKyR1ybxG39ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=944 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090019
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=69894727 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=mEGQEucz3tjVRUtqSOMA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 5WQJCWlROqMpv6ehOuGhCYTGPh6iaEWa
X-Proofpoint-GUID: 5WQJCWlROqMpv6ehOuGhCYTGPh6iaEWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX3c5NPkmAw47x
 rwIw75PxjHYNxQ14i2CPDxWfbNgiXPKy5z7iezCv9zQAx6I1hiUm48RiRoAi6He2H1AHDOgHFp8
 fBF82hcpdBhldGEyb7XEAAtJBy+O3RcHtNQbZIhYwufGAiygVHO5GnbKJphCPWh5LvYv7oY3ZCZ
 dA+PADFyjjsf9AafnzRjVHJ70EcGple+vcW1Po/54F9753Wnsl9loZIem07qG58ae3Tf4a1rzxG
 nbstI0630OQmlX66bjAZo+BZuRzhMVB30+UGYyedb5+uSjVb2hc0frgQAuyqe1D6Z1twL0JtGHm
 zdN1g5Z8nhIyhyvHlwFe9cb2BXRROx83kdfmTQzRCHtSPjkVfqhKtd59+HHzs7L47cq6scel/IN
 0YIN6YycP2VTzInLjKJI4G0a8EZrm/CoLPFquPHx1U73idfrhyULFlpu2Ro1f3pnJTNyoJMxvOc
 9lMKRy0VC2OfZa+LHQA==
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
	TAGGED_FROM(0.00)[bounces-42312-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,infradead.org:email,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CCAE610B1F7
X-Rspamd-Action: no action

To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
call out to the respective __cmpwait_case_timeout_##sz(),
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - split out the WFET handling into __cmpwait_case_timeout_##sz()
    instead of overloading __cmpwait_case_##sz().

  - in one of the review comments there was a disussion of an added
    warning for long timeout_ns values. I did not add a warning (or
    __bad_ndelay() style failure). However, a comment
    smp_cond_load_relaxed_timeout() does mention that it might not
    be a good idea to poll for long periods if you don't have
    HAVE_ARCH_CPU_RELAX.

    The reason for the lack of proper warning/error is that for cases
    where this interface is used in the spinlock path (as rqspinlock
    does) there's no way to avoid this kind of polling.
    
 arch/arm64/include/asm/barrier.h |  8 ++--
 arch/arm64/include/asm/cmpxchg.h | 65 ++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 6190e178db51..fbd71cd4ef4e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for the ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
  * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
@@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define SMP_TIMEOUT_POLL_COUNT	1
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index d7a540736741..dfb7d10a18be 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -208,9 +209,13 @@ __CMPXCHG_GEN(_mb)
 	__cmpxchg128((ptr), (o), (n));						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern u64 (*arch_timer_read_counter)(void);
+
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -233,20 +238,52 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = arch_timer_read_counter() +			\
+			NSECS_TO_CYCLES(timeout_ns);			\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"2:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+	: [val] "r" (val), [ecycles] "r" (ecycles));			\
+}
+
+__CMPWAIT_TIMEOUT_CASE(w, b, 8);
+__CMPWAIT_TIMEOUT_CASE(w, h, 16);
+__CMPWAIT_TIMEOUT_CASE(w,  , 32);
+__CMPWAIT_TIMEOUT_CASE( ,  , 64);
+
+#undef __CMPWAIT_TIMEOUT_CASE
+
+#define __CMPWAIT_GEN(timeout, sfx)					\
+static __always_inline void __cmpwait##timeout##sfx(volatile void *ptr,	\
+						    unsigned long val,	\
+						    u64 timeout_ns,	\
+						    int size)		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##timeout##sfx##_8(ptr, (u8)val,	\
+							timeout_ns);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##timeout##sfx##_16(ptr, (u16)val,	\
+							 timeout_ns);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_32(ptr, val,	\
+							 timeout_ns);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_64(ptr, val,	\
+							 timeout_ns);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -254,11 +291,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 	unreachable();							\
 }
 
-__CMPWAIT_GEN()
+__CMPWAIT_GEN(        , )
+__CMPWAIT_GEN(_timeout, )
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait_timeout((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), 0, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.31.1


