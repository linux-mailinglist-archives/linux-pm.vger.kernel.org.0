Return-Path: <linux-pm+bounces-42314-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AxrMJtHiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42314-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D04E10B240
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 093B030233D9
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9814F2E7164;
	Mon,  9 Feb 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="niRcZ8BH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jyLNdgs0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB762E1722;
	Mon,  9 Feb 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604373; cv=fail; b=MGlg8KRPCV9zA+Xa8+w0Fnnh12q0LqYFPfKtOTCprcASYsZubNSBwyNuhu8boxR5g2z7/NAAtzkCCACQCH15XJWKH2jAa8veVf1dZ4IAw8NZ9SgP0sOb30sw17B1lJuxL1mZU7CjJLkoTdGvpmFYu9HpJK4jNU4GfbSY7lj0soY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604373; c=relaxed/simple;
	bh=kSUCLLCvs184nHLKCu044ZI9rllsTIq+/u9I9Ig+RNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CVz/hJ6ZOoHVdQRNpAC3t0j8uJ9rcEK92ALfoUX0k5InDOZbUgcBTROGPX9Asu4DVAh1h1n6F353y1s0ROmUCqT/kVBaJIpEdRETtx7Nl6UVACHEqmpKcXWgj0Wt91s+yfewSPyzGjxbj+yPXKIzv/FGHzNjJ6QkE0Ycw3yJCfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=niRcZ8BH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jyLNdgs0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6191qr574138311;
	Mon, 9 Feb 2026 02:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p3ugmiucsT7MPRQrsuTGwdXGivxpKP7hC4wP4Iwyc5w=; b=
	niRcZ8BHkDzD9mPOOPWqVdizD0HEzS50X9gVfMO0z6wiqKCrYPAW1NnRZBpBsAmE
	cFJDqslVopKsI7KkuOWhdRlSfP+BKOi8jlmNcBcZALVSey/C8AEkDAPnzuCjTc8d
	jBmdmvwfhRCp73+1XLeo6ibjrrT8Uf5NUPWt0QNYz+DqAx/OH7GuvoSyRFsfIj4F
	OieY2rZ/5/iA9LgURWBhTG6ioLaAW9xYGsYez4uVJB7B31IgWNXDj73cBgTmrC25
	bGNeraWqh59G3XhB3d0cuJZ8XixEwmXLcrDdoMpcLaINNWLQeIF7jCqx5wLD65Nq
	1ovPwH9iV/DZHBBNz8ceWQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjys9cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6191twQx020892;
	Mon, 9 Feb 2026 02:32:15 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c625g7aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6ervmGJftwr91lL9HbRFb1FqJwh6ZryPTmqoI+YrolCAOfZ8nNvlbEVMkCQPzN5b4uOhJAch7+q5g4Vfo0aQ4ql0CLmCSJjp5UjlY/1E5ClA0y5CWxf+g7z+U2dZwXqwzYRfm3Map8rf9Fh6yZMgyfr6c+Lnp1m+pDqyIs19DLq7arjqU7bfzrF5AhaM8TSl7bnQ5BPeYQmuOzXydc5ZoUvE3tTmUuasFvcBcTdJlobbbT+xo9P98O+soqWGnsMrhOPbXRtf0lnv+ihrXGwwKq/F1QBIfPlvrAf9NP7Nu6O66ztf4Ped2kvaYnzitsWB2Chf/trZI6osjD5aP6a7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3ugmiucsT7MPRQrsuTGwdXGivxpKP7hC4wP4Iwyc5w=;
 b=TMTJNWTYbtFl4pxA3CLrYNusVWCdNvQX32Itfrly0dAgkaaJzeXR8i6+150R5pMBeB0m/uaUj4RhMPLWeiD2S1YMT35PEKrGqa9GSXLf5P9TbZTZ0ZAe9nAT6CtBnhD2PXq0MVPsG6mV/VQjLWQjTU0GtWEC7wEW75uJ97XxkbFjCb5SZixWNriqW0OKkZekY+5kanDyKZ8AHqLv8PSDK2trEvILYs0kUBCNxe91AiNWQMyjrhI3+k5dKt059NCmBglXHl6gafy2/7V7UTTAGV/xFPvvL3W41XyLiuAv79ybILUlnc3i6Zu4d5Gwqsa2nPWnuOwYB8tmTQUav9hh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3ugmiucsT7MPRQrsuTGwdXGivxpKP7hC4wP4Iwyc5w=;
 b=jyLNdgs0RiXJJZKGGr2v1tgYysjefJkuK7qtj7oGROAFSE+lavrTD5e7eQO4pUwXmQ55T0xmmee829k1bYTgrcTnTQznEIgwC96l87mZJOfUysDK5mpqF8vOrRCHJ4r7mD/QYyg0KPvZnuHXqSL1FFBam9ULZaL7oMwxLwso4iA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:32:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:12 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v9 08/12] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Sun,  8 Feb 2026 18:31:49 -0800
Message-Id: <20260209023153.2661784-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:303:b5::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 2239e3ba-19e2-4951-73c8-08de67836e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AfQPnqxdh/eOT2YOhJN9ycfgL407uKF/Q/85hTpPeY5rJk0yKNC0JJAnw278?=
 =?us-ascii?Q?Kj7SomG/+s7/VkoKR1EIWLmW487Dd5ysaAkTc35SqL/r64Cx2hibRauuNZfN?=
 =?us-ascii?Q?ceaAx5OXLQvP6s2lJDt0tX7iwfKcnoS49dBZepkHeGECJreFT4QoDHONGuSf?=
 =?us-ascii?Q?BOkLRUBb59KHV2+QKieVFtfUW6ciN5NWQwi5/6Xf5iTLF0qbpwEutQ5LYwt4?=
 =?us-ascii?Q?mrJcFT+kWMs2rmXFh96YvfW9/8UfiIu+fFLG11zDlvpIsVW/ZaaxFPGE1N3C?=
 =?us-ascii?Q?KnE5atEntLKKXZbBHULpRoARsplsR2cWvt9nSS6sUjxV1hJN7IvfwyZ3zM87?=
 =?us-ascii?Q?lxTnHd/H84v2QpqgiX6TuI9PnOrCa4IOtPVZPtGOb/1upgYfVKlaVhItvpey?=
 =?us-ascii?Q?nXJWIwxo0r6tvngWP/sNsAYBi+DICPgHDY17OVVlk2UO+lTbod9MKNaBiri0?=
 =?us-ascii?Q?dwnj1nXkKa/IjXtk7yI3KQ/sTKp8srX/wVAQxES2nZANdCGk9omoiPyixBTS?=
 =?us-ascii?Q?AlAWYeSQ9tKvgxolZMn0hyt5JDwYGBDDqHrn2SNtM45R4BKih6FKWqCmS+Li?=
 =?us-ascii?Q?y5s5zLwLqvwMKAOpzxGz0yWazPvlDF8vcVQxNX0UFMpInKurkfuy/ySyi4nY?=
 =?us-ascii?Q?ht2GzKXyn9YhxrHLoKM5aKMx0Uz0KyHME4pahNe645Vmrug9YI1MtuiehTDi?=
 =?us-ascii?Q?5HSrtsAXTHL8bvCW5jddNWFcmxqZpSvc1XCYoh5c2wttPRswQndzmiLCkfHI?=
 =?us-ascii?Q?w3UNKSi3i4F863+vJdEHf7t/bN+1SW0sp5/5MXXIm+IUM6ZLzXq2JUk/0iUg?=
 =?us-ascii?Q?NAFOj86eYpZu5TB3eTGhPo5VBf8XCN8iRWGekvD4g/gbLxr3G7UC3tRN0rBU?=
 =?us-ascii?Q?4rkgYhd0fAkrar3aAi5HNBGt4cOrJ0EW/b/LImtkvhzYkxahRSNWl8MqOqTM?=
 =?us-ascii?Q?pvNFacbDlB0w87XIQdvl7mezMSSGF9V2rD3eq44Jdl4BtkZRaEplGY1IT28u?=
 =?us-ascii?Q?uDjkjVO35inrrZ8fbHf0qzGPUf5pPhJu3yId40RmF7EFS6Yll+v5ieuo7f5b?=
 =?us-ascii?Q?YiB1mblc4MNnx4tkUFZcBG8/dwiguLwCb8nRnaGCcBL2ohiKJBNVSYR8ruoV?=
 =?us-ascii?Q?ncnyrpdg6o83ZWnax2oZmHHbA6xpVCkofWXu00tI0DXB/U37ou4ImJN53oT/?=
 =?us-ascii?Q?jGyGkgXI3nZHSzohIa69InWSVD8uEWLHrMcsdh6mvmSHKgVDNnMhK6FbkdjP?=
 =?us-ascii?Q?ZHq3xpnSwr9BzN5+f4BpubLs95PPpDhXFEosbKZnv11V6tAhgjLzh7dwYcPg?=
 =?us-ascii?Q?RLJCO5u9T+4vLY63u7BDvU//lQsb4z6OIlFhUKsQQXfE8EZwfsws+yF4qref?=
 =?us-ascii?Q?mGQRgGU6Yi6SAmojdKJLTI4ZuLN0Lnq4LRqyWYMb2pSk03vGw2t6J1bso6fz?=
 =?us-ascii?Q?3VTgkSBWdPm115A/MSd+GonnsUN7ocuFCP+Os6Bi6gEDsbm7o2tIZOT+OyrB?=
 =?us-ascii?Q?b2JXVTNZ3usJORKpxzfs9uuhrwQVj0Jy60otwy7j0TsSKxYa2Hh7shhWC5HP?=
 =?us-ascii?Q?hvB3qBUCwFbqTn4hDKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLKwOKsCL/pmgD9pvrK+CiogTIqC2khZlRcZKen9WpncQ8EFVijbY109i8h7?=
 =?us-ascii?Q?uovZb32wzOMmd30gYrOPmDH7GQ8M4WtJM4l36T+1Oo6xRAt1BtXalsn5iSCW?=
 =?us-ascii?Q?7b38/aXbcgbeuaRRmL4WQtJDGto2GsXG+yzrhBCijl7LsKFbgRQEa404k9EE?=
 =?us-ascii?Q?+K1x6tM0kk0wUQcB0xrQM9DQdviHHbOm57kY9xQwnWJi7W96igaRbNrD36pl?=
 =?us-ascii?Q?4CUCKdR0duFVlc0rxPps244pNDsViW4/HoJvJtU5S9dGJ7sKBPf/m1rGlnl3?=
 =?us-ascii?Q?R7SCci4FYhQCL57KG37zIIaH+ofZoO2NnCI0H1JwJToxw1tovsQpL91HzDq5?=
 =?us-ascii?Q?Lc6Za38pftZgZtxEglxlseYn3+5r932HD13Dvxm1V4IuN4XvuLxqMnOc5lRH?=
 =?us-ascii?Q?9sCcSsI/7z2v85jQ5dTvWNBJd3B0Ed0oIh0hGgFTxS49Qu/iSN8LT9zyUjfq?=
 =?us-ascii?Q?YSfvFLtOQ9avQ4h61rfo0owBjkCYb9y0rHgORL85KaJJ2FtM/zV9gme6jS2s?=
 =?us-ascii?Q?rpGeBf2szcxRyMH1chzrs1VYML0rlPhn0dyqwY6h4e23MlNN+s8cOEAawA+d?=
 =?us-ascii?Q?F0rcxwBFIhooyfy5MX04rt3D+fX6d553inC9C76qbiMW9DDWmZ5k8MXfAoUj?=
 =?us-ascii?Q?5VC8vgnN6exJbHLZyTuJjDqyO9B2TF7KtDWtG+x3qRbTxN22NjDEBCrvIA6m?=
 =?us-ascii?Q?FjE1Uh+OfzQz/VTdrzDIUtTPEyD0GkvoECCE9sFNChw7d7aewyCMD/yS8yaG?=
 =?us-ascii?Q?tDHKMs9lLOg5h6LCgqtvLWYSzIwFozizXB/kX2MB/YbAZAheY5uW5tBVOEoj?=
 =?us-ascii?Q?r640kuYQPbnBbpkKtgAqgaxLprO9QCN5ErrkHmXzL71Dp/2OBumFoPLFHLUC?=
 =?us-ascii?Q?m6LIrQqGNMrGRWeee+yuDaVWF8NbktR05NrMNmNrwVZJgS/MH/4ATeJJbgX9?=
 =?us-ascii?Q?+s5badn3lqQs0lIIFsTe52bw1o1EkCQG7npO1rNl/5Pi2X/wNX2BhwsA2VWe?=
 =?us-ascii?Q?+ZN+ZbSyoikTr64mhESwl8YY7KJ+iixuzQaZlsHjj8cG29a1u4NiHIIaD9oa?=
 =?us-ascii?Q?RsVAgDzwVpvyKuXXn98wmvxrp8tG794btlfdRHZxK0NzOPhF2Fa2CRCOUo1V?=
 =?us-ascii?Q?mijozcqBsGkewqYZUI7kvKhJXC20dcbfEqhq7kiIC/EV8u3MxHFmMwuLaQD3?=
 =?us-ascii?Q?Eo6cMv+vujJgDURI3ZCostDSIdB3mtXV4eR1tf5HZxgPgmZz1auhcriOTg1G?=
 =?us-ascii?Q?Vf/8uQw3Af+AU9UpDFkmku/LG4K5T3nU6z0QY7tLnAK3N1NSOqLKap+Ip2vA?=
 =?us-ascii?Q?dT65tKyvVYYoiAKcTn1s6vFn1UABuNnBcyQlXdiMnSEKYho8+CJ4kQj54ssD?=
 =?us-ascii?Q?VVNH7765LuUGho/PnOF4JQBoXZxKxsqnTlnYyjFep4t+Kio1klFZS+zYiLDR?=
 =?us-ascii?Q?4JAm3d8tH6WIOLG0ShMsxsnfFoXyCryjwns65hHy3hnO7qoUew2l98yWYopl?=
 =?us-ascii?Q?ZzcV/mfwiS38uswjJbjvSqmY2fYimcI0SNp8MMq7SCwhtOxV2h1la+CuLhYh?=
 =?us-ascii?Q?DawHEVjuovqMSmMRi5py40vmID5mLf3wJOenpQZyeWFVWAAl8dHRhA3QaXAS?=
 =?us-ascii?Q?G4bPb+tklsoats8XD7s3apiIdJ0adAVeM4ny0F0cEiWmBiiTiwDxn+AIGPOE?=
 =?us-ascii?Q?K49qOxxqo4J+UsERRQz/vpH5NTALceyuyjLrbkyOCn4912yjx/XTcmi8uSxi?=
 =?us-ascii?Q?RUXVe/WrqXMtSi5l0R3cJfi6YKCapIU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XRKGXArx6mlaIpolV7UdjtsB/hr5sxxGHPave+xcXYfafZqQKBzxpzP1suLhoyG1hBH1fKI9oFyOyGopijRuG4Y9YYDqbW3zRZDfbth8at6MK18lMUB5pipg09islzqfA2RZSkcDhlMnok46E6+D9+ooJWXFjgzPNX/HyssXj8N9v1jFbLHr0oxfTt5D7FqubbJ7MDQ1XEa8Gy826N4HDZ5igbjfIsGoSFSlWy/OFiW3nkkR4SRmuSOjrGDhGrGe3b3f0H2o+FBZ0u0gF2TX85WJ9Jtq7T0+eVmp9Zb1XCM18MJMDIuuhevfilcmf5cdhbHpqiJj4wFWCssM+RToTgctGTA0mmTt+QDtGLSPVkt1U1BCWE4LdnKxsg1y1sOVj6uBF0BRQFiiev2q8u4t2BiSSXbXM+IlMymDH+6GYS2xfG8wkHZM2i7YGKZhwNp1MBb1dbrR7SUhtVOfnHu5V/pyFlVdleTUd+Tyyz4kqYzmKTsXyI1LOsbBeH84oefpeup69cYL2wqxyfviAxFyg4RYHkLNd7QdjbsYshCToMCO5zaOw8d7EkXIlm9avAsVpf3LEBEcmGnG2vntOHbh+ee4nXDYXXiotZLFCPSm8uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2239e3ba-19e2-4951-73c8-08de67836e57
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:12.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBrAXmmqIOcCVJsujNs9Vr7UMkO+YTxAnYvs9upG5HPq6udFoznVLhtjZtKmHnLTpARI4l37MyWWU9yCZFjPhzkxWIlHTdpUtWlNN6/TCSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX54RQlKtrMnCB
 ygWqHwVyglZZE41P2Z8BptYZ8NrnRCjLsGk+6nuBFC5T7sKc+QDxvJXUigboYNlOR5ffxLHi8y9
 K2x5wFmuQD4Uz4At/C47bu9kVW3cQU67cP3YcoPfYxdfbkiFI4/1/nsip6NEvpw3wS5UG4gcvlF
 8LpIDt2MWD/Z4Of/tzi93ot89pIGywBRzDynSUNj1qYFEirr9JYYQ1aFUboj6vNrn3Aloi73aIZ
 V40srLJOQneR3sbmpidwR40rm88/xBA4E/2rtfO9tmL+TYMlUavZyHK3nXiGl9y6vXjpdU3GPhr
 uqRHbm6pQ4VTDJpIYXBUvemWqL3pjuCPJ/7j5jDdFUC/1yoJDwnAMU5FbGixvOMfjBSjVdzrEQN
 v1UQU9L6lGcAmPuoyBAp93GX8FZivLFa3ja5VTG8VvWOFEPE+2Xmov7xy30ib1Fq5ns6RBedTZC
 V0PD9vHUgeXPziohNNg==
X-Proofpoint-GUID: KHfuKoKEmGaHXo_gOSTkOcjHBXNJicZI
X-Proofpoint-ORIG-GUID: KHfuKoKEmGaHXo_gOSTkOcjHBXNJicZI
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=69894730 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42314-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3D04E10B240
X-Rspamd-Action: no action

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index f86b29d90877..e6da0189cbe6 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// eadf183c3600b8b92b91839dd3be6bcc560c752d
+// 475f45a880d1625faa5116dcfd6e943e4dbe1cd5
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.31.1


