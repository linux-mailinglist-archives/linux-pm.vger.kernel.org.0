Return-Path: <linux-pm+bounces-42321-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ea1KVhNiWkL6QQAu9opvQ
	(envelope-from <linux-pm+bounces-42321-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:58:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C9310B437
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68823006B5A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7652E7637;
	Mon,  9 Feb 2026 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJiJUfba";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xBGa9L7H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808AAD5A;
	Mon,  9 Feb 2026 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770605907; cv=fail; b=PAy9GExkxme6HUl1Tq3D2Z5quQRf9QxnjlKdwkJ7UNpjKe+TQkYoSDl/u2rAGi/3VTKmNJY8rg4XZe6DjbXNvqTMJkJRCRE/mw+hVG8nfDO0t7TIVbwwpQXjD6MQ0QQF1bGOBwDauwQCRoIq8MKZ9n4Nr9EvEQaqVUnJrWGZcHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770605907; c=relaxed/simple;
	bh=fLzo2MKS3zcjLUWyddaAdPyIlMm7AdzWYGTGhHuTrXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePOy1NsueSq0trLPJRgajRQ5sVi5uX/KEdFVM+eB+J+2mT3m0Xwv9H812nNtNnlXiPaqrTgp3BgmLKcxMwTvZ7Vi6/u4twJKY8cPCvZ73i0qsrdn/tOoGdb/8KqQfKMemrxZs+Ihf45rl/vx6dlBVPaDuekAHQaJFG7scpDUyMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nJiJUfba; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xBGa9L7H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6192Pmbv077481;
	Mon, 9 Feb 2026 02:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=; b=
	nJiJUfba8qus1UDpnAMtQ+MKpPhGYwSX3cAMK05+uVJZs0+0uh7OEDNTgpXPcLSe
	ewA+c6Lu7kCZr/ZI4cyMxCEiy9+uG4wMfWYVO0vyIhSqAdVB7UF2z6aoAmGPMr5t
	kKpEIjdxCGd5Lfu2cSfxjRdizJEU6yB2VaxzPom3JFFRQxBY/FaFzr954OrLoeMq
	TIxq8YSUGBBMXVpGe1n0j4LD5SDXmmabM9VhOLsUiaG2ZHxaOXaDsi0w+fRh7UiS
	VUhHz5Woi6Ru4BLattqgEhgv7OIr0slpOeA75t+SZfSeja0iKfzgGZYwuhkc2a3o
	4d2xkf9sEwW8hbYDiPuGSQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xes1a5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:57:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618LiMSg031565;
	Mon, 9 Feb 2026 02:32:08 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uujf508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmcLFekLBIhUItZujqZABmONnC/yBdNlbaLSoWKcIWIYhGReQJVKvwkBgMnh5An2934LaUR4m5UZJIvjiap53qtQxEu7JzZepQ2/SGZXF67aygLljFLuL3l+Q3HeGlfPv7O44qPdTd5IuHXTH8KDCM29BqOjXkQupZNVosNSSFtvQtNQAib7YeFB3qRh0nRyza/nYAofEul8jcCJLhD4I9voHF9DNyJBLmQSI92jGXsNcrGMMTw/CIUzUlqpWp+Tz6eNHI5jpx0s76n3IBjQAjeTvM5CSZoz8hrL4gE16v1NqJlcxwcmg0UtFn/VPH5qKKhK4cXqlADBJZbn0YV4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=;
 b=ofYMQk4V8shoIqUwdsIM4tpDaeAlTThBbDBZ+Ahi5w0VOwUptT9CH5wJTTwp9LO/gVBgb5Eqv6hpydANpU+CeOeD1HWjpS403DDOjgqm+E1WY5Cn9N7Z0Ezc6/eQSc2KXtr6R2hRmMzf+CK96Y/RRmAqi7J3nzaqWupGEUw9oB5+nuFHLYPh8jiiFpRujt9Fver5NZhJgoxV+Hq50aWmGE0e/ypNT/UDNawNXCpxUUJanwCqSaNQ2fz9vEfeA9+tc2BZCf/mt8LlYVrw51d3uXPZK+Y8rb/mzLuQX4nlvMghtwCOka6f4LakXd4xOrRTtUO/Ziy+0koc4O9ZkwMRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXCy9muAbULpfxKzJbhM6JR2PeL+Ud2isMKaxDrwNv0=;
 b=xBGa9L7HIXcrv4DfGmTtBeK+SBeNe3k5vIkjQGRc7EoVyZ9Fa3hoIViyMFkIf6CzNFoqILDw2MtsZTTSr75gSZ53MgmxKc6lgHHAEpya6LcSl6Ggzrgn9qCBXpUddy6GFaekyO3oaoYzt2fj6p4zqCsk+m6KJB7G8cEbRyYMLAY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 9 Feb
 2026 02:32:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:05 +0000
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
Subject: [PATCH v9 05/12] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Sun,  8 Feb 2026 18:31:46 -0800
Message-Id: <20260209023153.2661784-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:303:b6::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b16a8e-470a-4734-045f-08de67836a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LnYq9E7RfhWYkMcA6/Hj7P5gcmDoQh1/aGbeaa2NjZw+o7T8erHWD4mz9Ztr?=
 =?us-ascii?Q?f7ieygfHd63HDAiR4yXfvG4DX+4O1hW3o61JIqU3SibbLRX1+XndjaaeLpen?=
 =?us-ascii?Q?Plw6XYKEzpLCcht9Hvml+bRXcSgx+HWS2bDocQuc4hHT0GEulKWLYJ5pDXkD?=
 =?us-ascii?Q?23vwtvu4ui5L1u4Rnv8i64bhKEwNvp4G+acfjSuAmikOUOxqoRHLtZ/RzWdA?=
 =?us-ascii?Q?Q+H32IRtQMnNMKbjmqA1khSJ8QGV1r3QaKFGjxXxt4Kn5nteaOci+ODAM2LL?=
 =?us-ascii?Q?LIS4Ak6vExTrg0EdBQrfnmigDys/9489cjmDtsdF71WIW88eJbX9AOlS8kQ3?=
 =?us-ascii?Q?XOdt4oewhpbCG4YO1Pwiu/BuFJKKAA7kt4rNbSt+FDXw3aqrOkl+h+9RBC/u?=
 =?us-ascii?Q?XXCLhx4nKsIkuzJCRJySB+PU1ur04XyVWVIIodAFZAd/Zu9XY7qypFADgpXL?=
 =?us-ascii?Q?iPYHHErv4IY29VEzDIQZAdlHc7Ep5lZxPlL/Qg1AVoz6r9cQ1ZqPDeZTKqwN?=
 =?us-ascii?Q?f5SeCh65Qvh8Q+jIewcwuEaLPpFMZ7q5h6Zc1DjMCGrnWADxm7dWfyRosK0o?=
 =?us-ascii?Q?Vd4PWqdCntG0didLPWDfjRvVJNFQCBbGkEprDyblHKwMenq7+MCcCxYaacLM?=
 =?us-ascii?Q?rMw0sXuzYJGzEzrlx7o9KJiKw2s4LrJ87V8IcMMADw81G8VUdQmwmafWlNeA?=
 =?us-ascii?Q?sY9ER646Rz3IhfRlyOWTDG3M9lSwYi2htKn0Sdokm6zic01gKW6PQJGmlTFH?=
 =?us-ascii?Q?eDOWLRtbUeCihiI6V0fVHiEaKJruq5w1orugXVe7FlO657GbtNIgbCaayZyV?=
 =?us-ascii?Q?5dCTJEObdX3slP8bsMD9V+VVaLKVQyE534FNSNw1MHi+ozpA2v600BIBzMwk?=
 =?us-ascii?Q?5JmZ+GZ2sJZFN84wyogv9QPp2FJM1EeFfcWh3bKBBXFGkZnOR1x4wLk0OxA9?=
 =?us-ascii?Q?uDsbiSvTVaJrIY9/lCl+1Bz6IbO75sCh95zoPrRgBR2TeHyXkyuYnaY0fGYK?=
 =?us-ascii?Q?x3eDOPvunKN5tDpJ+t0NBsaSDJoB3e8niJPz+SLXjmtfKnGKDGV9KUg3mGMJ?=
 =?us-ascii?Q?qXqmTBTCP5DWWTY2aSv0iZ2iUMzsvstAoEIENepbNO3UsLiHaFH7QjOxXKwH?=
 =?us-ascii?Q?oFl+aeeYFsx4JHDw9TPA+b71JX4urx2DNJPa7x0/brCm8u+gDfqjtlkN/EDo?=
 =?us-ascii?Q?B6PWJgymiT11Uo3wzYeR38F6rPrx58Pp0DGPdpRKX4gBij50YvMQBecWPXgP?=
 =?us-ascii?Q?qf9v2u8epy9fxUKwCK7BCLZKKF66j9uHRx6s4HiqWMHTQmgQiJVKIrV4wITw?=
 =?us-ascii?Q?Xg709RRqqOr/emDQUZwoW1sX4QmeUUkz+mX6793Q2YyqqFtFeBEc2pDDKKd4?=
 =?us-ascii?Q?d6H3c0Kz6JwY7rcLu2hbTkUksxqOK6LsCzeQexY8xaMilmzi5LduCcBnAlpf?=
 =?us-ascii?Q?3EComQbsnufLgVyox/orhAr7gsdRwNf9IHk6kn3qIirCJjmm2XckKYPqIZrX?=
 =?us-ascii?Q?GeT+RA1jhO9GkBHXxbUPjsMDbnpdRYYtqnAyHSFgucegznYyFjj0tebbwKhF?=
 =?us-ascii?Q?FD+USyp3DKK4QrGePfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nH3t1jP4Z46WqoEVZt1wffshmc+MG7U/c+Z+EhSOLfXkf5T6JF48A6YlsDS?=
 =?us-ascii?Q?BYxrA1NUD+lBSh7bogxxkjL6jXUczfzP8fPiXfz6EERnRu0gynnUKN73AwyR?=
 =?us-ascii?Q?99Kjhch6HrVjKmr4e9G/lkJj9qunWnSxPvOb5jtIIKMo3y6Aw5sKgM6Fv4ys?=
 =?us-ascii?Q?cRHCBXOzKB6ZErV81ybeN78q6SIWpiuF6ksmPwLDWs8Ik0ImCQX22Rfd+zzJ?=
 =?us-ascii?Q?KPh1JAmHDD3EmegzKcu/bNvrzx9tpqd9QShajrzvl0H5hoRdDq+fO6f/7O75?=
 =?us-ascii?Q?Yr25j84nlxeKOvCXYRu+t1VLdNmL9sTiBeJhqlaladNGKTSyXs4Q4lPyZha9?=
 =?us-ascii?Q?cVYuaKW9sOI8RokoGj9KXWD6TLT0kEEL5FHfLl8KJbNYQQKVkzmMQZ6bbOmm?=
 =?us-ascii?Q?tNp2pLIdYRlK5CGxB++a0jospM9xyw0McdavHpbptaG4YWz8kIpvPJzQP3fi?=
 =?us-ascii?Q?Asjz4XFkcU7ELupLMtjDY7rxyw1UBD9189Y9daBvNMPxTVWQXbKzg38bLiv4?=
 =?us-ascii?Q?m0ip/uIS6gwrLVtanhO7VftEvIwYo3zFGX+qbY3nx/Vj2h4F3td3r/g2ujLq?=
 =?us-ascii?Q?W8/42Zl1NF3KKRJ2jb1EDRONuSjlfLqVZw6w/A4szYeJrbQEqoGk7GpJvQHj?=
 =?us-ascii?Q?d2vboq+Mue1cSKftgbfiMzU6avO77chufcZ3EB2QYx786f2Eqr/ru7vXFdAB?=
 =?us-ascii?Q?n8/ZQWdpJ+KX2sVl5Vw15Y5jySkI9kwOptw7ylSDWqTwEpc57rVnjFUagOBg?=
 =?us-ascii?Q?5fMBa3/CU9ha51NbbE8qWZ2dqVP8Blmj1/dNV8oTstlpyCGDA9X0i9FBQChk?=
 =?us-ascii?Q?nBOK5qQw3zB9Ww4mYjK1k//2ouI4YmC2ZlCFbfyigPM2ue01y5xfJEmIiL1Y?=
 =?us-ascii?Q?fCxlbNLz0zhIcdGbnUZrZL4K4vR4NLIJ7IjS4jDn7L6pPBRMKfHBgB8EMzbz?=
 =?us-ascii?Q?5Yo8/Iji4knAyltuIqNO3/LwkZ+qq1W1PRFJnazM2cR7j8XGtIFusB++AeyR?=
 =?us-ascii?Q?n2owG90mCPO3F9Y+mxiip2GLBmw8ere3R4w4xJ25JfK53PwSAgtFJ51mO13s?=
 =?us-ascii?Q?78mMXPypVJOyFlFEXOWtdhvwexQv1coUNrX7QGKML7MgUOUVcCOepPODmXOF?=
 =?us-ascii?Q?9LKiDP8dZGSVdugQT2E7teqS+Ouituk75q1MXv3PMe+RvYXQTqeCL/RD/X1U?=
 =?us-ascii?Q?JyqxivadK3+nfKgr4HDFp2ZTQLUnISXUf4Acn0Y9DXqNzANjyy7vwS4Oe7nE?=
 =?us-ascii?Q?251obz+vMaqwPo+HhvJA5vk1tMcacrVyozvko8D5ZIicbj/63jdkxugSzdXA?=
 =?us-ascii?Q?fn08PpIUB2lSSnvxTt54mYVeyR3FPCzxHmAK2K965QNTBDCQ3vc9iuPq5Gz/?=
 =?us-ascii?Q?GJaLE+NA8ecTKr6LhvFxf7nV2nU++yJDVL+ZLpQfAtXUQdqA15WV3+mV340u?=
 =?us-ascii?Q?dT2+nc5lECESWSrIjNuw6YA+XmdFpUIqy98oLHb2shkBp4eO88aogp0FGvqk?=
 =?us-ascii?Q?seniGsk5+mLGj+MMVzdY3XLWH1GY981OAglCrA1Eml+uQnfM9iOWw71i3nO/?=
 =?us-ascii?Q?xVBKF7+ahB1S35t1Q0ehBbvy0LK8vDpz7afkKOQRbKccXqPDkQk8wb1cNjId?=
 =?us-ascii?Q?nXY/eSPm/9R56T9Ay0bSn8V8MdeXIgu+FOetaUVAjQ7NKxu1Iz8StVVbfdCj?=
 =?us-ascii?Q?BT8tsYjJ4UJTFJ4/yYzIlFzFdVG9PSgLLv4S0pBFiBV8yuc3WUq+z5AwFNNx?=
 =?us-ascii?Q?+XXNFg21hfsOC6Ge30wLdMYRFEiS9jY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tEAqNhd23e8iXzkuFm+5lhmzCbWMAoJOOOuvHGG5BWU5dNlBfYRj9MFGBcTpy2DG0aCn0JL+UTIqwUpnhHt89PPHe866rjZEsTJYtbjnxvu//MWBKQ2K6cfv8fCyewgrwvlJDiDvKJLKPmiiTAT4fxiJJPuETAjPad2ewzgsy2qV/YtCZSZnPPKmmC0VahUApZ4wLMzvL2Ulonu0SMpZUDSfxD6v9DXIF55YTsuq+Yc5QkuXx5WzGzZsrdeAKMeoo/sSG9g5M6DppZ4NmGCdd8J0znFW9oLHJ97OGo8lnlCD225p1IvHKe9n5A0WP4l8v3bSaTgh7SItQ5V3lBs+eQQxIBeZnR0UxnNa+bWIs5GRndptOKkk4VYbxHUa8t3ePgMb9C2pu+CCPGE/5jrUQEw7TMmv2MoFLNPvc7XYhjWkLmiKk7BpzwclE7AjW39o8pdfYjW3H77VqN86h6+adScyUd5UPX2zD2cZKmL5OSS4NqpD8QS+ZBf5t+uV4xWPaqrejvjnYCR6nBwKc9LNioRKR5WeRzegWZh0hDWs1QEqntjLuUZN1i8htsjV0cdxxZ3KUlUnLMhI2Cin5HIbL08Az0g3RnrRf99+WnrcA1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b16a8e-470a-4734-045f-08de67836a70
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:05.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsA/GCS3llZRx7a/qcyGqdwpqS3ihbPuS0NgFsd0hHcZNlX1IvAZcId7XBRW33fibGD+ucDBi/5P6JYQyaP1zeavr94QUuGt8Bw8wxYH9jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090019
X-Authority-Analysis: v=2.4 cv=KaTfcAYD c=1 sm=1 tr=0 ts=69894d1a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12104
X-Proofpoint-GUID: 5iQhPrqzYuHTAA48RvwSBYlZzmpjJ6dO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMyBTYWx0ZWRfX+P69FkVWLuDK
 JatG/1dL3OvzZ6DIGjKkLxXVievD/DcSwcK3Ha85MdJSlt6R5STGMuO1RRgE0Ww2jkI7T2ZB1fR
 aLDTtWtl0FIAmIYgbFRGtUFbbmYztqGIXSFwmSAc2f/T+YHGG7vlMNFCIRcOZ9e4NRy1kMH+K/j
 hmVoujtQe8DLGr7BGYgylEmFrxwOMTmR2heVonDB/X5U9My+Cwwnxvu3WsYbRDZ6bzjYYBTz45r
 Qxibe4manmqp6lAhHbxZaHIH5Uccu49Vopf+cXxHCKn1tbEwn8pXlScuHQwn6zWY38M+Gi2vXMn
 rVuZZUQgvufQlmTmU+52gW+IZnwEaqYfXN9vQO/RysSO45/mbxsDN9PfLs9NRnrUjamNDKBwfaN
 lOlARsrYd9XVcq6fLY/txSOi0UNjh5cWXOlvDKVj+JfluURKXq2ugeCgjoxEMtpcUtLvRmJvb/i
 DdN2Td7MEtHBPTDAMxVOfyQFsia65v6vHdzow0pg=
X-Proofpoint-ORIG-GUID: 5iQhPrqzYuHTAA48RvwSBYlZzmpjJ6dO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42321-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 06C9310B437
X-Rspamd-Action: no action

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.31.1


