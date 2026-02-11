Return-Path: <linux-pm+bounces-42534-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ElIB5oNjWlQyQAAu9opvQ
	(envelope-from <linux-pm+bounces-42534-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 00:15:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82204128454
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 00:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D3AA311284E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 23:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED19357738;
	Wed, 11 Feb 2026 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j92n3MxA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vXpmvYXH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D0357714;
	Wed, 11 Feb 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851649; cv=fail; b=dx1qexfAO07nxmLnZr56LEeW9YJYAG55Lki4ApkDUxsKermDgV7YyhZgwosdlF/iy3ZO/FSbGiYgZ5KvMjy3rwDb4BiYEeF9zs373O0/BDU24vjl9XxMz/e8iHDd0r3dD1VvRVqw4St2o5a2ujGm7hRZYUQsBQb7B1mgWbFyn0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851649; c=relaxed/simple;
	bh=/Pm25qx1PzNY0AoSNIL1PLaEmAr/43yDOL+L/3qz2Mc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=S7xr6IlAz28cOXzTwcI1fPPLgEPRCscbOSVqXtX7uX86cHDA+kB/yht0eNavsLWgUJiPjgHChtxe5FNy4swGYwAstm71X2W19eOOWw9k/CqMXW96+EPdQJ56AfssO9lxpLq1wHSmwf8JVRTl8OSXiQBQZbwgGh1Ovwp+BUpI7iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j92n3MxA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vXpmvYXH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BNDYrq3163450;
	Wed, 11 Feb 2026 23:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AbWPnRL3pLZCPD3w7K
	yMooYhIQcW5qi7viiYLsJM9ZE=; b=j92n3MxAuVMxSxeIwcF5tJcgX2VWR5nSr4
	etzJSxJqCTAmXIx0Aanuj3MQSoTN1/wt5iVSCSkOamtA/bnUI8rXlppJp1lGQWnO
	Tg+b/phdaHeK57FhXugYp/PKtIDa+RuEWRtkqea2ULc7oO6yMMV/22dwlOI7UHxH
	EGqhRFobCT1RruvTGruTqbcOHCbAT2fEJhvFjYV3cwRz+ZhE2AipxF/89AGSmdur
	VPWNZoEGJe5RrX6gozfuRR+IH1E3HhzaV4x8Va7nSB9PUCooChH13aueHgO+Puwo
	oXpFEQjqCg1x8sXbxLFEqkC1+DOWb070mvoc4WBOlt0rpfgts7xw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8xw3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 23:13:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61BLDn1r022690;
	Wed, 11 Feb 2026 23:13:35 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c828c69p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 23:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgKzYxf59/0Dnf0CpgB+J10bA6ImFycROdI9t2B3mXhv7puJaYL3dyWZT67RHLrMICAb/9QHrdEGFL7B1nX36ErcpkOnpg70d0PmN3BbcWs2xmp2OQowbnQ9r9Cf23BAWD4UYANZ6LJhcEAxw9wI4LLpFfK8jITJ8gK8h7tKjVoVlLPOnA0OkymLjJpjHQtuEWhUAmbOCcRRjdJlmAVxnc10odsiqwSHsT4J77eggdPjnYRWdgPNJ8R4lXkdwgHdmqlplLOCnC0Lx3yOfKejIHpJrqs2HVCzxtIshWugbXtA8gJPjd8tjeWyLW/dpzCOIYLFAR8PFdGGDxlFSRX3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbWPnRL3pLZCPD3w7KyMooYhIQcW5qi7viiYLsJM9ZE=;
 b=XYIICNSnrK/rxZtq2IKPT07mK9d29HLE8ifMw23oLm7bD3l+ResY6xW3tVYuQfcyKWkjlu5tMYth2uOBFSpnYsC0dQ25ZChfZtHifrlfWKGnscR/uh634Wi9kBt+mvfFZcWnfBU2No/4sEK4+kpVNROWCa8iIq3byj/zU/bKU+04xnPHG7WhVWvk60zXy5Ci/f4OwjSXawT9iRf06IJ2Ab2+uNXXhIj+HVsyY5z/zHmllv/kQo0YUZsEEy8yK2vqNMgrRGgRvDgUx7hooB9G22ETdnSdrKuyBIKBxrx1K6b5+sssZSPfTk55zB/+A+EN3aMGAdy6SxpW8Z20UDE/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbWPnRL3pLZCPD3w7KyMooYhIQcW5qi7viiYLsJM9ZE=;
 b=vXpmvYXH/GFRkYHqHmSHETY7PrpZVZByTBm9YoEsGi8wSjobdKQTS2dwo6ojOWgN4qMRQvRZ8rW77wOXeq6IlZv8Ky8dEf5dBTOGuXkRHRciWUtHQrPk487N/qiga5XfQz5hw6C11PzVfsZX/28wW7/5CuWoXD9DSh2Cz/UrRsI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 23:13:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 23:13:16 +0000
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-5-ankur.a.arora@oracle.com>
 <aYy4O66B6T63tRaa@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v9 04/12] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
In-reply-to: <aYy4O66B6T63tRaa@arm.com>
Date: Wed, 11 Feb 2026 15:13:14 -0800
Message-ID: <878qcy98mt.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 436599f1-4eaf-45e6-ed29-08de69c32300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?splDYnEbYAnfNlnrtYAixW6suDf1rpk6jHe4hDtr2xW64TjnEfRdSQ8M7dL1?=
 =?us-ascii?Q?z1QPX4QKzvk0RVRVbwQgrZNUiYgj+zGzwP6Ac5y3ivFY48uXz1do9iQkS32w?=
 =?us-ascii?Q?5byoXV52olxh0peloXj8moE9U6S720YtV3/wDZ38jxPjWn5nEgyuStQ8Lom4?=
 =?us-ascii?Q?UWiIAc+pU+WUmiyCKrEWXl4///XmmbcoVHeNfzJzNnbkHdJ+6gIu8JC5zaqh?=
 =?us-ascii?Q?MlTzcBF2RQWa5LMwybEioA5nt8oSqO0tocTLXBiaEr3vlr8QSnZ0GcZf95ET?=
 =?us-ascii?Q?3yJdiStt529SQLxnRDgENIECazaSSgEhXCc8fkTtzeFk/XsXHRVHzveDA5hU?=
 =?us-ascii?Q?iOXHhcbT+aX5xy0q1mxos16yICXTl5g3T0CV7wTmP144bW72FgrvWv+kfa5B?=
 =?us-ascii?Q?QJu6Ha+bJvy1if9Wwsv9ruk7FEqRwCucOgyw/5L8gtbuno4dKHTBvRnT01G3?=
 =?us-ascii?Q?xVsaF226BmRd635xUuabmPmA5+EFyNQOUHSkMTssIi4tTuW7T4VwjAskAhau?=
 =?us-ascii?Q?SLR4Zbmp2Ee1HHJdn3VawJZLd0rLJXUfAWvSqyOyilTZ/pZDOd2XGo7pP8jP?=
 =?us-ascii?Q?oK5TwuOSU5c5qloVx/M7SNhc1DBqvw4pwDZHP5whi8/7Y4bOXpcdls1zbOVE?=
 =?us-ascii?Q?2j4YcmDKfJ9qAAVU54DfNqBLa0mMsEuRl1sMjuaP2NX7mno5ryh+qLOn+Ksr?=
 =?us-ascii?Q?l6DZc6jdAxsjacA9oxC7y3DOByG0sAg7ND65EHdxmhwx0TuCqQk190aO2K2f?=
 =?us-ascii?Q?wle+P4qjEOWDxDy6UV7VgarADLQHZNeN1WwF4uZ0C2wkMR23IdEYI5y3wtRW?=
 =?us-ascii?Q?HVtO8tQtLTwBZNX3D2D63S7Cw+7go673Vy7K+JbcEM7+RranPn1ewUgmZxU6?=
 =?us-ascii?Q?h8yoP15DfxFl3o3+K5/aCU9S8qMKPU67UjfkR6jUpFnGVWffa5ENPV/qM4YL?=
 =?us-ascii?Q?O7Pv4GpVd5IeDwbSGQeJ8wS8a117ydit95mAPcn3YHoopU//fIuuofz7Cs98?=
 =?us-ascii?Q?JjYN+chWf9tdklRNX002LoEzyvf/BfHT85NlrKfvJAXrjTxTqGYDJAGPnBl8?=
 =?us-ascii?Q?R57vv+P38JniRli4GsQt06gl33a1gXy0TMoa9byuBUX9+RRIohwAenI1iuqn?=
 =?us-ascii?Q?ZyT9iKUib2kIGHsstO9MPegT9dmCw+ApS0JBVIR6316Jxo+U9C/5tO4O8qk6?=
 =?us-ascii?Q?bjgnx8G8wEzo6yova45kG0ZuhVutWuUO7vouPJKT9ttID+xm6oOgQWY/2skI?=
 =?us-ascii?Q?e9BD5Q8IwC5AtvCcw41RizDlGXhcTl5MewiOcKyqvn94JZxLBXov1ktQxGCu?=
 =?us-ascii?Q?HpQqTMlU1nU9lWLltva1QovON6G1qWLjaHamjs3gPbfBa1LxGaWKEq2DbZnt?=
 =?us-ascii?Q?2c9FSLzzr5Gg7taKpXtKqV+9PUwnYakhJy16/mFqjEZhydkWxs1xX/lt9XVM?=
 =?us-ascii?Q?TxFCoApBNDOlbyxA7ommvPeSa786e7yrXYlKWCZzVMA+vVVbjkZkvP0TAbkm?=
 =?us-ascii?Q?LzxyBe13bX2MjAMjW+eVILbWTX9Agn7LuCik?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qSU2gslv3uMBXiutLPq1L7G/1Xp81tSJD1odV8uPUPE9Fk/F+7HAILCNW7b?=
 =?us-ascii?Q?QyXaphtH4zmZI323GRwK6nE07w1IcS/pQb7xflrUZqe6pVQUUhZPOLczjwzP?=
 =?us-ascii?Q?RSbRCNjD8BAj5nHSyMgQgYtZ0WOJoMCQZc8QOzgp1Khx/HuhIqMyOW17/Ewj?=
 =?us-ascii?Q?FQGu4OBRsXlgshhFF+RnXkj+2VTEYA4SUTSFfT0wPL8cZmyd6BF6OsFcOVCt?=
 =?us-ascii?Q?oqasBkyoGuqORy9xBQLYx8/hupdY57/INuvihRctv7mVZgS381/mDmhO+eMP?=
 =?us-ascii?Q?D6tnQEFXbHer7cgE/fNXOvT+p/YjfTQ8Rk3Uas39U/lngckqR26vacW22req?=
 =?us-ascii?Q?pCEFrWbOSf+QGqnFFrI+LNJVArU/ARCQw4fMst23gT14YpyXdLrsTTsnOuh7?=
 =?us-ascii?Q?Vy5XPl0bJPrvA3S2l+ZMy/sf4IUXcnUgpd+osqOXD6UuwzVKWKutrWJENpFQ?=
 =?us-ascii?Q?oKnMUAQWChmvsTyRuAdSB1RTeTDiMviD3/fLqJlx3HowZNwSqr5QFkrb8PZh?=
 =?us-ascii?Q?Ut7Ej0SRFu20XjpevklRG4/effmBxOMQCdjxK3H1jHQj1PT9cdT/ENrgBQoV?=
 =?us-ascii?Q?qLHueZcjb4KgGZXaCgQ6/6oV5Qs0U9aVwq1lpGD2bzldamyrR+XR6htmVX/q?=
 =?us-ascii?Q?lNcDgo8i89vTGn20dX9qYYoKiJmR+nFtQAXGFA7LG0Lydf3R6pCtg6CAb8Q6?=
 =?us-ascii?Q?YJ0CkXInfupCkImhWRDBt5pIMBXjQMCSlFJ7Lbr/SbNLcOlfUTZlXwkyqFBz?=
 =?us-ascii?Q?HjyuMcB1jPY270SMEUk8InQsIgTxEnb7JMGl0cgT9/CI8bKmSOJEofWmPStD?=
 =?us-ascii?Q?Hud20GccQljDdT9sfM4yRK+kDXA/oTlOn0j4Bz190r+FvkF/0gvT8icmjxCD?=
 =?us-ascii?Q?maEWlY4EoJXzu/X1Q6Bp/vyUfnqDK2oys3vtwRERwYFpBuXvOlwvezSgjThz?=
 =?us-ascii?Q?UqL2Trgb7Pufy+zieVw3vdJWuH/Xv/SXSzxGabgEoPiHbbon6aLz3Bj4Or+A?=
 =?us-ascii?Q?iASe23nvgTv7dXlxlsHTnSXywByvx3fF6R0UUOdHPWqpOajLX67AF7BAg44d?=
 =?us-ascii?Q?OpNKWoROrJITl7NS5P5GO67BYUrLPHuHHTtbORlbcjC3M/O8KS7ISvOZG1ye?=
 =?us-ascii?Q?RiUBOBFFWFzIZmjEUv+aLOUyaNl5dEPWZqfS1ZiCstxbKA323HgZvTOtEwB6?=
 =?us-ascii?Q?uMz74Z7qteWNR1Ev0t6062htmUo++vct1hS5kE68ix76O7ZKuig6vJNE+Q/4?=
 =?us-ascii?Q?B3dk9pvEf/Eoz+bfzKk/XwCtIt27RGeTx59Mpu9LkghSKblp7ELTRWzOq+KF?=
 =?us-ascii?Q?+BReTrPwj6/cDN0wL3JFhBdl953Ht4yoUBtuKXXycWVJdqW5BbyUT/0J7Bb3?=
 =?us-ascii?Q?NW1bUoUCdy3XhdyLZPUyU4qk1NsP5qOY5HSTFbrIpsIsgt5hT++mG4tsBVal?=
 =?us-ascii?Q?72K+clcjftXzMEmnjbf1GEooLg+TfQHuN4mhxdEbRkzESoylUOz+Ii6BwNaw?=
 =?us-ascii?Q?JHdfes0tIeSCanieDutTn8xEhu83HfI0alYJqjtpIfa+5XkaPFvSmJ6ojbdt?=
 =?us-ascii?Q?VcVntpiBhEOdkV1s5btkC6XKgvFcV8onupSs4MQ4MJtK+yIoTdlPrqjM+WWU?=
 =?us-ascii?Q?IgsvtlYKXf58JwmZbyfxGnje+dlS16IMUid+mITTFSmsx5JXzSc/6E8dRlJ1?=
 =?us-ascii?Q?q4nGgb5HdCC4uHPIeFz4CzmIN+LxhB5mu7UW5z3uLF+n57JtCy5iXT9OBKmS?=
 =?us-ascii?Q?YHbZl/LMeBBEXpC/bYCPFBoBDwcq9ws=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9E3BRFLVdfmdaPmP/fNajsa+PKIvBuvkiUuF9cJd8jpLSH1yGvzrDgM1Ps1ZVW+jR9GG6P16VDg/IUVDsqDZxBFMQK2q2R+e8T6GXyID7BGIxMNZtrI7YRvevngFwIVV1nIUBx7eR5nR/acOV4swQkL6yeeQ9K7Pyzuycd5KOsIcGGOfFHprvEMTJPPodKRZffd9zQo3jGQvJn+jRK3VfJhlzPQg0NNNCDjSv5UOVJr8JDNoRqMkxnVBVRC/OLTjKlIOx/6cEX7o4GTakcNyzv7Rb4pYtOfwjqR5pqfYvlOErxs/5/WSc5DruTDf8NvPcxjvgf/TK/zKcvF1VpCDvHh6wAAvB3GaFnrfIsNuP+HhpV8AzTpkevuHceyCVs3Ch0A/EKprF7wGTak4rj7DCNFh7w1OkLXUlHduMIJN/v2frtAz793jEQxGQGEdtKeVS0EX5P5CFkEGj6HHd8KiTy0/tTCvidTscBxJprI2k2PVnirdN5GTzjAE9axw831wnSDW5u3lfsMMnFhkF4BGltzFSU0wqRznBMPmGZvpEXOD14XVpwCVkap07AEC2AsjMgD0ZVxj5QaDQpHFg7uvb0r/v78wdN8Z06R17mQp5fY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436599f1-4eaf-45e6-ed29-08de69c32300
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 23:13:16.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OHJ7Ptxgw2jCYzwZ+LyAbwCSZu1Z1uX7bEQTkbYbiiB8K6ZEMuY7DDq9y+z5o8QK5K7CY6Gnua8mAf3hL9acwvumu4CV94BCcWi2pYx+bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=868 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602110180
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=698d0d21 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=FD818APFoX7DtmaT_24A:9 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12149
X-Proofpoint-ORIG-GUID: msQHM7ZTiDtOrAWb_IP1LI0dmKpJkpAF
X-Proofpoint-GUID: msQHM7ZTiDtOrAWb_IP1LI0dmKpJkpAF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3OSBTYWx0ZWRfXz/q8l1j046wf
 XlyNrFzcFhwuA2d9UpwIGMqghD35ANaiClI/415+yQs9A29cY66T0C+6T1XIDXByKOVuid6xw3x
 I9VCJSvQa+8xvmNv/wmNq6QA1dbXybGKUDE7G9wPGL4vohQf1oKAcdjO3f10v7x1zCTopB823dy
 YE5W4oitQqnZJCLiXj0sK9Ofp+h4mtxhfWaWC1V7libnxsyM3R98VV35oBiy4pztESeqN+8nHX+
 7AyCcCwnFAJB3fPQiV1n4sF4mGZE0D+EwwbUJIAHSQ2unfShehE5ojQmbzmshihj5Rxm4+ep95B
 Nut/3aoDS/lrDsj4I+tZSp9LZrFW0kxSOTu4dpjWsuzeRQVnQUvEjmQ+Bc6SGyJXtK9q0PDekqG
 8iQwMNFZ5faX50Wwc5IeX1sU7v1wkPVboYLKv1r6AxVHxYqwzWcgzjlbXCtstVMlpHAQ3rlUUse
 9NFvJwb6Ukhfk8+yeRMpwu+fNptGDOue8epL4IAM=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-42534-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.infradead.org,arndb.de,kernel.org,infradead.org,linux-foundation.org,arm.com,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 82204128454
X-Rspamd-Action: no action


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Sun, Feb 08, 2026 at 06:31:45PM -0800, Ankur Arora wrote:
>> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
>> index d7a540736741..dfb7d10a18be 100644
>> --- a/arch/arm64/include/asm/cmpxchg.h
>> +++ b/arch/arm64/include/asm/cmpxchg.h
>> @@ -12,6 +12,7 @@
>>
>>  #include <asm/barrier.h>
>>  #include <asm/lse.h>
>> +#include <asm/delay-const.h>
>>
>>  /*
>>   * We need separate acquire parameters for ll/sc and lse, since the full
>> @@ -208,9 +209,13 @@ __CMPXCHG_GEN(_mb)
>>  	__cmpxchg128((ptr), (o), (n));						\
>>  })
>>
>> +/* Re-declared here to avoid include dependency. */
>> +extern u64 (*arch_timer_read_counter)(void);
>
> We have a bug in udelay() because the above might read the physical
> counter while WFET uses the virtual one. See this thread:
>
> https://lore.kernel.org/all/ktosachvft2cgqd5qkukn275ugmhy6xrhxur4zqpdxlfr3qh5h@o3zrfnsq63od/

Oh that looks painful. Thanks for linking it.

> We could use __arch_counter_get_cntvct_stable() as in Marc's suggestion
> for the udelay() fix (or just wait to see the outcome of the above
> thread).

Yeah will follow where that goes.

> The rest looks fine.

Great. Thanks!

--
ankur

