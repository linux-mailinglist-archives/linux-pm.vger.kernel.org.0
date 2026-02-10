Return-Path: <linux-pm+bounces-42395-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BIRKtvHimldNwAAu9opvQ
	(envelope-from <linux-pm+bounces-42395-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:53:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE7117313
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 788BD300E736
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325672773EC;
	Tue, 10 Feb 2026 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HsLWCDxo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jq/I9+iP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22A21257F;
	Tue, 10 Feb 2026 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702806; cv=fail; b=ZJqcAARi83mOmUA88prSMYhg3c8GMW5EzI3B+nVbRJTCHi45pJBDcYk3HuWVz6ZM6CdHAHWYBiJLfSF8f9JUs9Y4mM1vFdnkzxNIYv97eHlM/jEE+5+94FACu6/ZMuQFLo8vCX0IugnOnhqIUuvyM8peBXOL/Lqm4VibhVkrUd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702806; c=relaxed/simple;
	bh=xLFgS6D97xrvouiqcUsQngJynTeMptraAclKOJiLK7Y=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=mnXqqHl5uDq2fG+x8S45wIlXP5L7SZLc+Mg+73E0CuM2bXkvc0//GfrfMeQqRvQ/njMR+HAGITkzE4gE8Ddjf9H21cnbJ7bQBBFOHAykhQys2ozQaeghsr3tc3/SzMFd3xtpiPcnDkfcycwc3HHdv1ipn/mNPA+99vxSpa4TeQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HsLWCDxo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jq/I9+iP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619Lol2q1150033;
	Tue, 10 Feb 2026 05:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xLFgS6D97xrvouiqcU
	sQngJynTeMptraAclKOJiLK7Y=; b=HsLWCDxoudNvvHaX8DuAZct0ejue0Oywfa
	SIk3NlMy5fs6HjxbW8lUeZ/JBWAOrpy7m1aTyP3HqIuPiYncEQQp2sa8TFV8s8eP
	/bYQg4jvqeTXLbY1DULTjjfzrGOAm3VT+RBTzjbXc+YUSJoY4OqPXOFGMW/mLbnf
	O8YVfjhlncazjzIs9xWHsrXg3fNCaQk3fbOSw5VaZ5Oz393ODEL1pqXIv8nynXGR
	vBrKNc5R9F7/3oPRASf3/COg3ThRkiBZzxJRHI66mZnSYoW/rZsjFh7SIsXLPFW9
	1ke5faaXSaznqDgUT0H4X6PA0Q0J9VGWS3TJnAvD1+syzgKpNXIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjyubjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 05:52:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61A509m7033578;
	Tue, 10 Feb 2026 05:52:27 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c7ctyhxrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 05:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyXtfLi/DPhEXw9CoQY1tK3c+IvLNpUedRp//afbTw5tdC3AMTiJkjn8GeMf6FOst8hPk22whQemj7Uk92sXSbbLh6KYUiruh9d3nT4rxjZpnR+cnrn4IFF/fbmITY/bQEK6NmkiAwWPqyIfIgdR97wW3wjkk7+yGYJqjGezQ9kd+dfJQNdi4YcFlc7Yxu3fmgaGaoIIOEJG3AggrHuuuUByrm6USige40q3ghi3UKIdtZxaZ/PgqHHZZxKdZDxtnl0bOB4m8cvFevG3EbysaaD6vPKBbHlp780O3YQAZS9+bG4vds/hLXXN5ZisvAZhiy/NwSfVqvsNmmx7DXOHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLFgS6D97xrvouiqcUsQngJynTeMptraAclKOJiLK7Y=;
 b=k/UulndURXMe5WAsfGYcKlAQkYDmKzN3PQT5RUdlEJSK4bnME3NxUljxt8Vpoj8FFKA8C6C37Rs/Vv1sPSWB8WBlAvcpp6urkf+9fFszayItrGdi8Pq9I4S/QnBBkWjXJ2M9JfvUTWldZnDy2QJ3hF+MDs9KupmkD52KMfdXtX0MTDSsWkI679uvfSYONOcpD0K9ow/y9ub+6k6eZR/VYdQyga9jdYkrAotGJ5x/7YjfNu74Y5dD2wJlqjelklmjOtSgOBRP3eZrQ+10CL0MrFRDZhZCVgFQ53EfFIm2HgVOkvaEmwkreysc0nHqmWe/nD/s8+g3gBTSjYI0JgrsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLFgS6D97xrvouiqcUsQngJynTeMptraAclKOJiLK7Y=;
 b=Jq/I9+iPviWENfMXw/QKQ5dhFArytseoeZRf4t7QHnGnPUKExNmJvqCBWYUi8ItSdz64Fj7vzQrEehuOuN/SY5Y/LPpLpSAOhz4Q5esA2nAqDQ9frIekI0/t/oOJ7CsCH3O9Zf1yL90EYumVHLQU9pxRM6SUe/db+vtJdjsJgno=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 DM3PPF0AF60B9AF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 05:52:23 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c8c3:861e:be9b:fa6]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c8c3:861e:be9b:fa6%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:52:23 +0000
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-2-ankur.a.arora@oracle.com>
 <9414714a-ba13-4d17-8b4f-97a03b90d6c1@infradead.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Randy Dunlap <rdunlap@infradead.org>
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
In-reply-to: <9414714a-ba13-4d17-8b4f-97a03b90d6c1@infradead.org>
Date: Mon, 09 Feb 2026 21:52:20 -0800
Message-ID: <87ecmtb0x7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|DM3PPF0AF60B9AF:EE_
X-MS-Office365-Filtering-Correlation-Id: 151f5ddb-a81c-4a05-9ce6-08de68688eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vBnOIdu1/EyPCRjpSuBaouxdoOwg4rPioI+wtO1Nq+K/4h8w7r+Nhr9RQ0c6?=
 =?us-ascii?Q?v8PpQvCCM592ouONFIXCSO6cNjIjvYdRlP5Ab5Hm9HdSgfixeqdnY3whAz4c?=
 =?us-ascii?Q?SF82aZcZtw60le/RpTrcp+WjKFnRRG5VMeN1gAVcj969mexVg/Z+nNewRJeX?=
 =?us-ascii?Q?IIHQWBeE9RSTjJop5XZXOzWhCwyovdbkHltmzzt9y4QnKXutbZwDzAu++jgy?=
 =?us-ascii?Q?nbWyjRXVdmpzM3DFFqPcfX5gSPKjfdOF7p6iSz+pmr7uyq+BwBXKyK7QuauR?=
 =?us-ascii?Q?E0+OmkBu4kodN1NXqRXpL82Vkuyhp0Gww5hK2M2hbBhcTN5eYrwOU0Ehg+hG?=
 =?us-ascii?Q?oGrwA3QKfi23Mo3WOFoafcmN4Z3ZXGsaPIMXksX+ubdrYxFv9mPoTX9U+kki?=
 =?us-ascii?Q?7M3eevjKdX393t7r5I1PNIUJXoxEFHqTmK2WEy/G+Jb0DOex5y4vBOKE1/dH?=
 =?us-ascii?Q?vMQWiwXgzL6EWHpXfuYsWb+u8MHY74G4Ti2Ob8/jJsgB1kywAQeF69B13LvT?=
 =?us-ascii?Q?zYNLYtJiaatAgEasU7eFIiIXhHjCqVmEku16zEWQrcLLcGksZ1SfxRYYez0B?=
 =?us-ascii?Q?TlC2Ph+hbVge25z/WptN1C7e0gFtsUjHWTQhr9dpRCt0akzl2kHx/gzzonza?=
 =?us-ascii?Q?4hbSSUP8Xtdv7y8L4TvMJZRNKm63vpfDl6D5pazxY3oeEy14iDtuW9skB2bs?=
 =?us-ascii?Q?QdWZy0lrhG6U2ysIPrXfsAjNp3S3AKULrbOLIIRmkyrZb+2uojyfoJc/t7fX?=
 =?us-ascii?Q?MGVTy2bb3zcdhX4aAhPtLmyqXrNsgDF+yInaXJDn4RWXp+c6qHbYlpZjZPiZ?=
 =?us-ascii?Q?U0chYp5bp6wykTWqHmzr2XjGyfJ6l4is/N/8MVA7MlcZtAa5POtipCSZ633q?=
 =?us-ascii?Q?Ppou+qpsZm1pcUlX98BDyKpbfK9L5JOTkJXdVae+jb4RPxlfRaXd7lfAjWlP?=
 =?us-ascii?Q?lrF/xqa+sYg43OAoufFA5TuHLan1iho9Rs/3xfHeaZJSzi74uUv1IYnq4RiC?=
 =?us-ascii?Q?aYKSPI3vwfdI3nUb3og1eBGZcxQ0VtTSgfYxfMJtyALBF5K3Y673soNGCR3w?=
 =?us-ascii?Q?LZcRpmtrA6h9aDTVzWhIbUBfmPuBmqFwiE/Ru4KbFYFGT08JkEctkZlEnyWD?=
 =?us-ascii?Q?gEPWzVTjD4Z8Yrau0fsFGzozMGanpfQsnEJC+x/p+Oq5ndMuRrIkX2irtlok?=
 =?us-ascii?Q?73RXYOTRWUyBGFHLLuMtpU5Rv7MuJJohKV53n4SG4W4Vs95YdytNt7oAjv1I?=
 =?us-ascii?Q?/mEETdyFqgCQvZ89jKQoZsMucxgMg2lPkqDg9vkPp3KjvsDR4rLB79dsOif0?=
 =?us-ascii?Q?ogOq7BdoRbEDbeApSLmcREqZHLz5sQHJiZtpsf2Bg634mgFXxvtwxJurZElz?=
 =?us-ascii?Q?PwJcza12blMyS+vtqoZV+C34AKqYcLzuBs9NWQFxNuEUMdTmbirukF2sM9/r?=
 =?us-ascii?Q?++n06URrK4X7lgJGjr626vODsB/PhLztpi6fKMse6f3vW4ubPfdFRvveyKit?=
 =?us-ascii?Q?o/L9lk/NBC+VeAQhXGi2ucLIo934qzAZ52+n+eQAQ0TtQBea55PcYoIpa+4r?=
 =?us-ascii?Q?21QEvQvXB+HpdHg1W04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WL/9vaQdkqHrhRhIgTKJUuzP9zy9DUETyviQ4iRcLIyGtEsr79Ex916Yv8zm?=
 =?us-ascii?Q?FLvWbbOJm/WBlGylwu2KlqnYXeAqa2CXtIkMV8r4b2ebMHxcGtwoNNDCxy+x?=
 =?us-ascii?Q?fS3h5Vv8X3dci7DoIMh0JNvtmdX0lP0VUTMcL3C5Ase5iwxAN2kBQz3Axjz9?=
 =?us-ascii?Q?b7yhDWFyEShf6zK42yzzriEDlOOA0h1x6t/VY/gsGIzywhqWjFKq/ommPTuO?=
 =?us-ascii?Q?hsl5y5AMy3j096rLcasulaCRPWXCAgeUvfXScb62pn3n3n4zA8EJ2N5KXhQY?=
 =?us-ascii?Q?M1icSwa4vq/g9r8Yz7HWeo6wt/tTnmPYhp/cKzEQbNRyeaN7BD2MNwt7ISPg?=
 =?us-ascii?Q?1vxZw9mJnGX4703Ll1RAX8Kcz4PiSo4rYaiD/ea6AhFvjB68bzNtXY1xlmOl?=
 =?us-ascii?Q?+O0Qrskfp1I2oqHBQN4S7N/SIWCEIFg0Obb98ZJhQueSFrMfEJpYUSbnz86H?=
 =?us-ascii?Q?yUsgXbZSiKLESvSXZggmi5m3XKnB+YRnoRbfcGICzFfI8X4aBcrR1coh/KsT?=
 =?us-ascii?Q?+rU4b9wMNsYeBj7Xvpxm9Yh3M2+MkFb3dfH5vx+RWIroGAepDaXgui0hAbQ+?=
 =?us-ascii?Q?jKSn4gTQ7M5kbTaS0RLBKQQsCtQUvngaDSY5PYXq5eSFKFjEvor3odjSZ7hY?=
 =?us-ascii?Q?PYP5xJnLNpPSfdKwVqBa+CHMgPmIIeNtU2YOroZ4BuXTlxT9sd/hLvyihEgP?=
 =?us-ascii?Q?0EKzghceBIZSPKdvSOZtPZQqn7fjdzxwz6qQ6Sadt8aVm1ESdAp/hxrzPjUD?=
 =?us-ascii?Q?J0QpAq087wnU6Fo+y23cwzrl7CjzIQTR8WNh/SBbZ2G3X+ejO5fRVusE0whT?=
 =?us-ascii?Q?htPiCuJIfGqbS2n6kyHxpTSI9W+m9bYrl0kTHKoS64Yko9ZB+tflm2W3vovt?=
 =?us-ascii?Q?qWM/4K/GnvbD4xoq1zAXSTndfnaeiOIoLQjEz2H18CMoRAanXEl/ar97Qepd?=
 =?us-ascii?Q?vK9SW/VXAHg15duI3KFBiqpzf0Kot11v7cYhTwndtDwodnz/lY0Fcmd8HE9Q?=
 =?us-ascii?Q?gShm4B5VRntGXUtedFfdF5jYUcr7/Olj+XTJbj5i9O1DJW7yPAnXIfAIo2UO?=
 =?us-ascii?Q?Bw3YcdcAXxL7lou/bSyOsO9QHiCgVvvOcrNQJjgQEVg85Y8vldzC2Qil5UvS?=
 =?us-ascii?Q?P4g77kJa33QPokk6I4Ies9iHHxNAKxZkDdhukRMd5lfKuvy5iU3IuRzkcT9v?=
 =?us-ascii?Q?/6sMzDyDzKv5Z0Aaz0zlWdfRhHqgaeVPcvwMBFkXLehV/EjWGLIIiT1CMnp6?=
 =?us-ascii?Q?8xZWcpgRDCR7B+K6TKQHVpyNeQE5eANXO3GGQjJDy1BPAE56k2dvff2dlWZr?=
 =?us-ascii?Q?PXJ/GYZRHiTroL1Ufh328Jksf2xwhwDgZZ3oshRWKgqf8lU1AOQZDOGjPDMj?=
 =?us-ascii?Q?15zilAfT1PEbWx0rNh2uRCVq0RfgdcY3AG/PJgKtg9M2Z/gBlq4bnxjAeHDh?=
 =?us-ascii?Q?H6jgIEfq2GjDFL06cwij8UGuzM0pYtFkI2FNpml2vfysZFkwuOSdJKEac8Hg?=
 =?us-ascii?Q?S6rn2LYeAkHQDqB8VdB0rUx2QRmbxoGSSB2HFxuvtm4FjC1bsMJdhTPapMxy?=
 =?us-ascii?Q?ouiOiyHm9HibqoLKqYauSIU/3BVfrFAHFDznQMVkWHErRXejLMzCUKQZkPPL?=
 =?us-ascii?Q?ugxNWXSTC0Ku2XFHKupEicXqJS9S1yPHaJA2v5y1mVSBsTULoiMEPkWBynCD?=
 =?us-ascii?Q?IegLhHp2DY7SZ6+yS6nzHaXqIMSdBaUkXtpYpd8ga90qzHWXTyM9OLMWi6w4?=
 =?us-ascii?Q?JTB2FBfoMQ1gKBUW+312akKsVDvAGjE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c+28rCZyGzvWRVEQ+/WVn9sq7GTLuK0Bo7k25v2ZB7K2Npb/UxrQxw7bKwzm82+5Ags1Ow1ePusnRmBQViEnm+JCNkdAVcUX/oLVpvYg2WSVQ4GuQhXa9hGJjfD9JOJDJ08/nz0zOc2wNE8LzSz4+66Z7G95uIbZ5qiSjrcU+7/kQsM3UFYZL+HsSxeHZOmVxftvPzP30wbpGWMSFScO8/Juu1okFl68EWKOeMS5Kv9UJ8nGQ0ygSAy/2q1pJ3zZqI7E/c5lKBgibvoeSdOfG2/ebYTW0I1BevFEW8nLZsljYbXzbref7dy7/WJPzh+QLtlHhTDtCqKpi3wDkRHkRY59pOiXqE7/6mN+Q3GsusoHRpni4mCg+z6hMMyqxGJGzmjAFiX54x52cVI06I4p1MR6/d2IswD9/1lzBJxCKAGE1MHai7O+Cajj/IwUO/dILvvjZLKoBM6qfe9scNQisWwIMeru21nMEcj8vks2QtINm1EHi+2ZBFo5hC1LnRctjnb9y8/aX21fhiOqjlJEcQ31qq1PuiDNvfnrggl77w99S7w3UX24iSD9340tQZhWUFP0TbWsRbEkaefDns4z2n8S5Moa+LgNC1WLLoMCbfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151f5ddb-a81c-4a05-9ce6-08de68688eee
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 05:52:22.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUU/68t/wYx3tjZRV7hwfIp/zyUdOsdHxonsi5jN5MOFhCZ39aQoIU0Lbu3a8a4gd+H4YJBVuF0pt9ra3c3Y/TlYIrYzvhyupehFb9jc/Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0AF60B9AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=948 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602100046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA0NyBTYWx0ZWRfX4LjiHPdRZZiw
 UVIPnJACkpAgd/LASGgR7hbAZEHRzurbV6UAT5dfeAsv+JxjoCJfsxIoyBFk7dbcNqNYRN+QroZ
 wkYGHJhMP3M0Q34aQWOV64AlhHHLOOvqAdrvUONwbgVEp5URzmh8FQDI0wmZ0FmvBxX/DicB2SI
 gP5hQCbauWzni8QQb1EaXG9Y1xWIexNV8hIzb4nUDxyFE8DgZ3rjXrOhES2rKLCX+Fo9EOqpUjq
 Mtvk8aNzGM/t+cF0/8wHPOnFfOudvmdvTfP5XDAd6SmB0M2/W62ADdCWx6B9KtoEIsYcdZjeRFD
 fcL/xnuOD+SW093kXHi8+7BbTJBorkyZ95AZMfBtMMiBUha8PJez6OXWn/TYvwbTvZsgtpyevgo
 yIARS+HJq5RDenjicTct4Z/Bi6gXKww4znR62FFElVvYZA7y83gEyoZd3KJbHJeJFScdYeTBoKQ
 dx6D3sLKZMuiFCXOVpA==
X-Proofpoint-GUID: pRJyj9brpTvgaWz6D4kMOBhBSOPPu289
X-Proofpoint-ORIG-GUID: pRJyj9brpTvgaWz6D4kMOBhBSOPPu289
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=698ac79c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=JfrnYn6hAAAA:8 a=fkmKkzQ4kxvVF4Q-le0A:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-42395-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.infradead.org,arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 55DE7117313
X-Rspamd-Action: no action


Randy Dunlap <rdunlap@infradead.org> writes:

>> +/**
>> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
>> + * guarantees until a timeout expires.
>> + * @ptr: pointer to the variable to wait on.
>> + * @cond: boolean expression to wait for.
>
> s/cond/cond_expr/

Thanks! Well spotted.

--
ankur

