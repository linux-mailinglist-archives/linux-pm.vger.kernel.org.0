Return-Path: <linux-pm+bounces-42319-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEf8EQZIiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42319-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:35:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E7E10B2C0
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D2E4301C129
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642030BBB7;
	Mon,  9 Feb 2026 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BIiSkG1x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uknxY/GA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA87309EF0;
	Mon,  9 Feb 2026 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604377; cv=fail; b=itomhlCydlh2BSIZI1JHMPzkpepF7A0vrFNRhUt6X3zaCROlePZgBE41MK4F3/g/UttcKB4m0T1nBgnu6XHjPJ6cSctIKZAN8eArA/csJJadEliM0uOuj4ENAP7OvXipm+7hc/mdT347PsaV9e2e/kp5ynQxKUJzAcQ7I1bbD0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604377; c=relaxed/simple;
	bh=kAX630dNgaSSWm847jv94pt+YACI49DCjBIg/iXB7PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8F3z7/QCI8izv5R/gmwrmkn4DPhVJxVsHuaqoPfotDQaTlev1Q4muFX+JT5UkGMLYe6/zXoGBR9H5D0RfcvFQSptsksLH8H/KFyPnLrxAY6oeHGlTABCb7kutapRykmwAhGW3J109aPecpOXmv6MAaStsJ8MKXWWncHi9NK4QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BIiSkG1x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uknxY/GA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618Necuq136611;
	Mon, 9 Feb 2026 02:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fJM82hUDm82PI6d0udMTBg8/ANwCQGHQ1mYcxVr1nIs=; b=
	BIiSkG1x7Rtrx54ejdJ46Q1ou/FcDW71RlTtl9AB0YEOLtgTOe1CFgRcO4mQEWz8
	QwahFHG1czHCjNE7WjOkCBRO0wOjfNKkL2t1jjwDHuoLIU16ukcKH6Vv+EQbKF0+
	mWGn/aseYeKjsFGexGxkiWbsMJZ12ygUK+KI8xQYBxCUX+/gb+tY/ef/G2gg6iX/
	k2DGTkvR8udEvFyESOdXpf3eFiq+yIk05sq+Rtn9MIlsLOHHv82ShlSGWfBSW1o4
	X0Ku5QMzNLxVHqNk+xir9CxOIIBUwhHgqdO0MVhZdnZRH/ajA5mefborByTJHnm5
	O2fW9p02qUJPbz0BowoJVA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xhu99n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618MAwCp015012;
	Mon, 9 Feb 2026 02:32:23 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uujyf61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4tJUuFDAhKkOZwcCw0YwyLXZzKJUh7w8MdJGRCc5RaoDtYe+9RqNpCnLBje9/6sEigRwoXB3aBJ9GBDzlcE4yaFWL3647xiJppgZ3YupxrRjkEixsdTzx0lZSwuShg84m7gDas4G+4oZWqVyMG/DUxXhXrent3L/lHdBeT97h11bZmUmqaM42w7PCMBscxkyAgYAWkv/Xj/OUFGH51r4rwEW1q8+8hd4kEpX9mASxxMv552gj0rlKxZc3mIf9b0X/1qhAsxQcU50+rGDDadpA06j8FTiHAbK3kHswsN/RHsqNVh41K6rDeCVTZ7D/JdyaGwbbxooE5F0CZtpx9fsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJM82hUDm82PI6d0udMTBg8/ANwCQGHQ1mYcxVr1nIs=;
 b=tCAdWdPcrRc7cK+EJKkapX9Oy5a47E504oMyL/FmVgmG58VtoBVfpoWDopQw6+O8VINuUhXWIxExthVbdiNseprMMG/1aGNeAvO55eMDBCQZPphZOt/vQOgftB+IB2JPMqzteU2kzdpBG+lnpLmrASzFDKvwDY0Zbp5No1AaFuYDh1n1vQg7eTxlhFFb2FIBaTRjIz9lK0fgqgU1lk6YTz8DM7YZCxaH7rcT40LkjObQ1gG6kE9SRdorFHpeXfKbBShCHwQKXsDT48TqhhjPhjKxBx0IP+avID3oh9rYyL+Ca8Ye5eCSN/OAXx9d1+wlsWGb5A9I+C322L0Q71xeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJM82hUDm82PI6d0udMTBg8/ANwCQGHQ1mYcxVr1nIs=;
 b=uknxY/GAk+vlGzwCANNoYP0LzOWfDL5mNBh09I6jKOj+CKddo2JPMyeLypavZvhLNyLpjpooDqUg6jcHzPVEsn2ywDi0bhICJ6QjVd68EqrA5QEOPYtq2Rt7PqKqSV5gYTRW3hyRUQzN0AHijfVTb6zI9kzUhhTjW+f0e5r5c2U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:32:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:20 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v9 11/12] sched: add need-resched timed wait interface
Date: Sun,  8 Feb 2026 18:31:52 -0800
Message-Id: <20260209023153.2661784-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 661e231a-d6f6-46e6-3c09-08de678372fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QjbQA+hEOFzawM5xcjmTt2sIkdSLmqsdcsFPZIknuWtVYic8qIWexo5g3ZZ/?=
 =?us-ascii?Q?RPo+/wZRhh0KmpNZmw73YEiaMkSnDgngtvHs8864yhNe5v3sO+9tgSC8NSA4?=
 =?us-ascii?Q?/JUdOUYx8bmBuqPYY4IvuH2TWSy8Vw50ozsXqb6nm04MkgeK0b7n35IhOnN5?=
 =?us-ascii?Q?hC0yZh+v5tCuoI4EM2cRwHBx9GPzCz0BUaMcsc2iR3eyw5wvhNY/2rlwHiLx?=
 =?us-ascii?Q?UxIWUNlsyrLnbSDZ+5JKY34wqkGZzsiB4FI+yglTEHLyFRctlVgBsiyFPWOu?=
 =?us-ascii?Q?hJ+/vXRn0po3BY9sxzryRy/32ynybFZ7tZqzeE4C0jFPrwAvlY/RtFPUAtQQ?=
 =?us-ascii?Q?EVWlfX/c0ZdBJJVlHg1bBlqGmGEpYcSKpsU1aO2fKi0WqF7z0hqTO4fW0WzZ?=
 =?us-ascii?Q?BpgCX5quxKZm7jTM+KSaxhN5Q7d4DX+NKKmZDybSGz1vrkbIsbURgxyWRBJ/?=
 =?us-ascii?Q?4bT0IA7Inow8UEL1kZ1av4uPvM8knW+CPNqMYbbKDxtrUx6i0KNVlJGW/Wv9?=
 =?us-ascii?Q?Gg5yDhNQFbMMf9FEGMKthAbpdTfD2QHSGDE4jC1qLFXS5hwPZJ3J+0kWTxJ2?=
 =?us-ascii?Q?VJscIuBA8NUMqwXN5p9WtdixukBlDC/4HeVvPYQhgFqgN4FhLVq0UioIpYpH?=
 =?us-ascii?Q?LbKwpoAaZjB5agVfNo06wrDjYPQi8ex7UcQty4lmHHWD+ff96m43jUvBG+VL?=
 =?us-ascii?Q?3k2aS3/cP08EqR3s/7aSD262W8qVIrYdBvRpeLJBFeB+1KNt643MAEia5VTy?=
 =?us-ascii?Q?hVGUJZJydUhDXXbN/kYDMLRCXpPaeRSMyXZiIj2fyELac2YMYqnlRLWdhAFS?=
 =?us-ascii?Q?Xval+TNVX2ZyJocU/7UkFO+D51E8DgnQ2zTmmn1yRQ2tnwCVSS/5eutig8sq?=
 =?us-ascii?Q?9emGWk2emJrV9tmN+apblMrxiixGczczew837PxUQVIXTfUZkZ3PHgnyJjN5?=
 =?us-ascii?Q?dN9RKeIMeI4nOjn2/mQbJLFi5VEq9F+NuCCLYCWMWGlFvYGRt89RQwz2UvgL?=
 =?us-ascii?Q?4Pm35XvMvsA9rxA+BVSPQYWVgPVfNPBjUzCJe+d1erwZ9aPZDxx99eR7g2Ek?=
 =?us-ascii?Q?fzr7aOFEYUMw14Q7lJtX8U4nsGeCL9dCFQs6kW4qw7o+80yCi/B7gocA9iZa?=
 =?us-ascii?Q?30Ij4+7UfMckhqNEjkk51DY+SfqxbQGBhqJpnzj3MfxbdWaIol3F/WD19qAp?=
 =?us-ascii?Q?er3JscQlPwb5Q5UfrwfTn5CEOKPDLBiG/qDUFwfs+OBzS8jgWAYuCbJVrHod?=
 =?us-ascii?Q?z7VLWACRQTEp8GKnA7uRcDBPqOLorXcrmtV8Urm5RH9BCLYcXxjp3VONYP5s?=
 =?us-ascii?Q?rs78ZMRvgkMVIc+Mh1KqNdpQ1ExtNsZZ+3KqqrSkX4YEM4D13Rz3ZPunstds?=
 =?us-ascii?Q?NhAIg9geBE541yNIDkBpxTKUnopvh7Yvxx+5foB/+7HHrEtbWdfD8MRIjiYq?=
 =?us-ascii?Q?pjR34Ry+eDIIrju8px5RvpAsOleioV3Nlh47sXB89m+x/OqYSXAhhL3dI4mO?=
 =?us-ascii?Q?Cg+ylC9FnLiB+3qn8NfoUIWMKYjhgUIzA8xi7KYVcpuLMj9XmZCRVzcgeXY7?=
 =?us-ascii?Q?pUcSSvo8GAiPcVhJObw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g5WYZKbaaUxlpdGK4PkAgheBhaw5zL2ZjSSbyReaxc5bBdnC32i8QLfGFye7?=
 =?us-ascii?Q?yOq2WRwfo7/IiQDMNJR5mwI3V1ZacBndt4LkBGnTmxftccuRlFFiH4s6J5l+?=
 =?us-ascii?Q?xp24pttOiMAtOQSaxzpROZfyO1h2bjWcvzxtd+QzVgCncl2E8aZiLgJpaF/q?=
 =?us-ascii?Q?gWLWsCymKKut2RLjsw/f6usKnUiuGMSd3VopjdVRIG2rLthGDvRhMQ5FfuMj?=
 =?us-ascii?Q?edSKeWKWixAnsGyTY0Bw86uscwzyvwycAz5KD8mUYo478ET0y+ZE/Bubc+Ik?=
 =?us-ascii?Q?vwCIKCam5HXdPr46CzDTWFJ2rVVA06UYLLYWl7SJLHriN/WTL018bH9kXEu3?=
 =?us-ascii?Q?2+2XhiQT/2BkdIKDZa9mzbEN/rhWSHgItoyMrVe1LLz71Y7B13UPYDrzS+IU?=
 =?us-ascii?Q?6Yvp+xpkcvUHZ9Js7iotDqV+/E0Pa8p5/UuR2MqI/QJBqm+KnqDOqT86wMvc?=
 =?us-ascii?Q?4q/pIMh3t5Ki/9wvnQIolZOLfqDJr4/mkgCZZ5YoBONG8mEHo9tCaut+oSMH?=
 =?us-ascii?Q?kGumNIEyjr7Ri/6hytbH3MbTg85jjYIromLbEj8yHmbw6mHoQxO3lC2l4exq?=
 =?us-ascii?Q?vFeW1Amiza/Uwo3S6JKuxIlOlbdmo8pxBJE3mTDCnjHheLTSJClX99m5ba3A?=
 =?us-ascii?Q?zbA3F6dZL3MffM2RF0kmYO9DIc4DoUkNSZlco/NG9/lOdSqZczhb50oexkOd?=
 =?us-ascii?Q?i+QST15RXUSpVzOCqYn5XaiHE4c8xo2GZhuAN+ELRwdFUBeAEWURjUDydJqw?=
 =?us-ascii?Q?vCIFEmz7UTf8/LwGZAbiXFLJAiHp4fdLgRBYC5ubzzTeZbUuUItEJMuA66NV?=
 =?us-ascii?Q?zEQi7od5SERy185hA8HVYrF77397DI7w7KXPW5GAiq0/AzEUtbypgwjKUtP/?=
 =?us-ascii?Q?6CryoHDYBtXWo9Psxz2pdd7gLtTIkubU+WojbJlcVvp71lNK1ghKIwA+t5Ib?=
 =?us-ascii?Q?VupfjoxSCKx07Kw+r0nA/tO2lS2+Gc8lmh4c2cSrOYSdO3HkjOkgRja0OK5G?=
 =?us-ascii?Q?fQbBWamt/SRRFIwXCa8aUxz54H1G+0oM8BpGs93zJxhJHFo61OdHnkQNd41/?=
 =?us-ascii?Q?tRO9uDyk0Jkh7uV8+t6IlnTgsDJ3GiSjAh9NtVzQJFMcXTQuVlh+RpSBZl06?=
 =?us-ascii?Q?XFUn0Uw78sFr7tIDi5HzpjNlwjuesFv4ssz+r74dFtgqgyZA8S8/47KSicFy?=
 =?us-ascii?Q?SUzjo/5sQEMjE56H5XMk7tufBOdRunEyOWJC5Y/RMvENvPTjNF7jJ35kIfXI?=
 =?us-ascii?Q?fXMl8x0OWH3w01JC5DbBHRcClzY0kCidB2GSmmtx55qM9NnOqWUtUXO4WuSC?=
 =?us-ascii?Q?eb+N10UWXMB8i6akGsnu3ovJTFH/omiGa+YEs68SCwoYRtmKhK7811HWkccI?=
 =?us-ascii?Q?ZEGYUNrInFhBocUlheyn8rY3YhuXmJWMXYTjETcWHlQRPC3jj1eOLekhyPmy?=
 =?us-ascii?Q?Dake5LZmR/AN8JFR/ptKwNXQGSTZq8wDWZGp2/lp5hTAPaObUNJksitDiaVL?=
 =?us-ascii?Q?oS1gXWoL8Ufz5xRnRfXqgWOJ3SuuriW3JdQBC3jzxoH1ZbpOUhAZiUEi/Cll?=
 =?us-ascii?Q?u4hAIxDEOwRmTLptW49n8pygnTp/gzG+RM0EFT2GHEhM1NlgkqXEogbhXXjT?=
 =?us-ascii?Q?N7MIdyznxY1gGmQgNzFNJBZfKqyYny7aGFun4iPiNg8S/hYscrRTLfaLxiJU?=
 =?us-ascii?Q?mQTomQD/HdIbScUQvUOM2Pk8X6lul3mZjnXeeFbR35VAuLowY/VzKVUdh3Ll?=
 =?us-ascii?Q?icgOnUSpXqVYi0iuU8WR4FqQHWw6d5g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LotDnL3VGD19Bj43/2T4A4Fx2nLEiBoJUrEM/KTxWak6hwwRrJXWX1eIR5QtslhxEgT9faldEZFWySy8aXQ1QJ8EoG7JPbEjDsRVJXpko1yeoD2yn1tr/JW2XKFMpBunv6A8Qbs4ddq9+9rtOgXztaOhJSNXd1eM94bCjt2Vai5mVgQ8yPEOxdBcsiuVrG/+uzKknVfL0hgmMTcZoQacV6Qd0AK9GbR5/jDyvsB+2dPbSiuO6yj91iMknQuIbLjR4NrPmbvT6dpbiIwxfdEDKJa8h9TEp4u++BgJFtvdlrwVtNapNF/7XdP0OGCwx/msQZBUpvT+w/P8xSdV34oix28S5u55+INKTSSkxtWxD9SqlXbHLgaDKeJ9PtLoFfwt0MiVx6SyiiRQFnR7cOWaglP7xKZUSoFiTOv1GgfIP9A6R14wxmBcb7Tb2yeihgHAd0EpwzF8Q2e/vSO3FTESRrdJes91taQnjHnkPViCchHnqn5/2IyhKQY1bX23NBI9ufv/zBiju8smCgqh+pV0wv+1l9iGR5nfkzxGbt1xFfPwxtyH+OgdEKqh4ghw8lHd5o56ixcHWd0P+oh2CuvDeiTmCk3ByLjg0UCXOuqLoOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661e231a-d6f6-46e6-3c09-08de678372fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:20.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQy6XYQkezFWeGhyWdZZ97ehILfvxH6raX4K9fM8/tXXoFOJZwp2dPObLBLB5SC6roF0DuHUYPkjvwb7Aa1GHIHvwSg6gp6TNi6EceMwnUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090019
X-Proofpoint-GUID: ec3XnYYz3FUzwJ5E-NkxHHsoDRLqR72T
X-Authority-Analysis: v=2.4 cv=FIsWBuos c=1 sm=1 tr=0 ts=69894738 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=DC2jtUcBNbVnd9lHvZoA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfXxyVxDAUlp+Im
 QdVINsqXh5+ZPCrbLi8qAHYWhpBYDeuKwmP9csUGMSV4pOdDxyF51sbFF08mQs3uijRiJpskajj
 8pAHH4n1oEfoxPFAFRjGTROedQmlbTd4OmTsPJYfitJZo8ijTQeNrE+7crLx4njoVr05O8AjCD7
 WoiSh2Q34PlTLvuSk7wpC8DypimoBHIT9trTAxmNg8vZg0w5DGCexuvukE5dLvLtRuZFq6MadmW
 U8C43gleYvACA7uzZ7xfttnvOs6EGsfrc2afvtPzFeloXvrRNx64wV5ZcIzNjdqrnPXBTJClRbj
 UJV1uJBsPT7f9JJAH907QI3VgXWB23HoWWyQiXwPUir0fW56KJjGLapqL6Hv7v81PTjFK4470ep
 aJXR9vGG8KSD2f+DzmUOMAKj1sOKh2Wkw4pkXyDtpU8Sozyku0SDhPuvnBApPmuZg/yDv2TzqAI
 Kh1HZXzv/zYAdMmw/WfEQBLCvhBbr+N8yQ4R5F1Q=
X-Proofpoint-ORIG-GUID: ec3XnYYz3FUzwJ5E-NkxHHsoDRLqR72T
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
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42319-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,linaro.org:email,oracle.com:email,oracle.com:dkim,oracle.com:mid,infradead.org:email];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B3E7E10B2C0
X-Rspamd-Action: no action

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_acquire_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - Make tif_bitset_relaxed_wait() __always_inline to work around the
    noinstr section warning.
  - use the BIT() macro when checking for the tif bit being set

 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.31.1


