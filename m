Return-Path: <linux-pm+bounces-42311-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AeaNW1HiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42311-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:33:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41110B1DA
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 065F330015A1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F012D5C8E;
	Mon,  9 Feb 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aMG9/uiz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xl26J9Mr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDA14A60F;
	Mon,  9 Feb 2026 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604372; cv=fail; b=U3d7m4d31YewtDpvbTIAZmnBv2abw+F/wGd48t8RmBIxa4GHq7+AY+zzu1jvOlBYYp/E9JQOxAEoeC169usjbDwxPCIzvFRkMCsKWuoN77oVhEgm+MRKzJxiHuch+K4g/nOpRZq0oht8im+3T5FDUQ8Q+Vwx5ruPIWM+etlH3/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604372; c=relaxed/simple;
	bh=zvEdHyF7iUcQI1RYK3lO3Y176opnrJTsI61GBY4z97M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YiIVU/T1fGuxvqSGavZZF3kTOJwNwTbYQwvspnuzQf/0XV6WMDlo11vMMqLzoFhf96TuFhPeVb31Fl082dGvKFROiyCWf3kwA3EUuw9wx76+qB8e2kMfJCsj+81knS4RcVSKfa3FUtnQQe16Jmewbsdp5Ok650A+LCh4cerKAD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aMG9/uiz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xl26J9Mr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190sOl24047619;
	Mon, 9 Feb 2026 02:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qTW0gWfQMfZ+XQdqAUEsYCbTLcxbTTH+TFWPZPZsbtM=; b=
	aMG9/uizmm60s4eT7vMM6Th+czYbfDUdE28+vcFDp7jrle6GTlq6mjR8Njeiy/Oe
	j8uyZ4Rgj5xbNUVi8Ao3LaItC2Tl48hli90qmi9yLSrAaboOEm8ANTYAt+mTqp7O
	SBx73C3/314/zUdVhKVtJ1Dsaq9gp86K3tGZ7imgn8iZSEdDcXM3pw4ba9fN7WRI
	kEre9IvhCGCpHdAcbOVi+cdm9ZcnG7skqYQzFGV3QBLBlnb/J3f1ZOaGGEo+zvj/
	hu59MNCRkyTOZx5N/6gk/edN5NqwEjVms941ndZII7U0D5mHi+8xz02uwH8gFVwp
	5g3sZX1zpMiHZI216XvAbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjys9cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6190g34I032342;
	Mon, 9 Feb 2026 02:32:13 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu8g891-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+pBsJjthCT8bK8UO8gHhw04yCoBgKf6ysnslGC6sQNNWka6c/GKuZiCUFOJKbHdjYaKvIco0N3X86mKQiR3aPzKLfh0c+l6PXWnyYzMTjrPmz9w3Do+gHb/+VIt2H/x4ozcI0jmVjAXmvWtzd3v8dwt4CmFXD8E/AB/ZSCkgnVYc6cx0gTJbmEO3vushX35+4MSqZ8oaxiKWIJLWSdIAbzR2qlgPtSOHBMYz3SN1X3pgo80XSaoyElMQNfySqY1+lh5srmjLUSN4/pKGrrmVBkRH0IBDQ9z8zGbeRXvF/7abCwfQ2fPJVdIKO9v3oS8OWA7iZX1WOOQ47lr0ZF1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTW0gWfQMfZ+XQdqAUEsYCbTLcxbTTH+TFWPZPZsbtM=;
 b=bd/Eny416tU+03G8K0sPugzn/fjuagpm5hDAs/NjgUPpwqVSyKaG4XI2l1hy4FiGGVgcODDAcn6LEqeVj7OeTETS+Ly1F+ogAz9+BY+PUzkUdR0OzHJ1bJx6yynvNfCp8I1AIkHB/42IZdiO/pdevBZFYDiTHVlmWT1+G3Ho303DNmXg9BRqCq4TFOrTX0wHYFzl9kZmIloZ6A8D7zlQiL65zOyWLJF2cxgNgfK1R3pKFkD1lTtcbwTZlV4lPSoRBROiFNZs+lqly2OUTkrpQYIOQmONYV3onj6OytH+vXaI6ThoAouYGbZ0kAoBHIXiFFmPTseR3WI4BjJ+z0Otiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTW0gWfQMfZ+XQdqAUEsYCbTLcxbTTH+TFWPZPZsbtM=;
 b=xl26J9MroLHEtf0EODuCNpM2SF0haM6AE3KyemOjwK9LZ+Zisa8vyz1iUd0MCGHvTR2/uFmxUkX68Ewqi5xY4yqbS56lHrDD6/CucOPQBv0rQ9prAxHyNLIzsUQ1NrLkLI6AJbIQV3VncYxON7LzRIgAOarH4m4db2PpgEG+hYw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 9 Feb
 2026 02:32:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:11 +0000
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
Subject: [PATCH v9 07/12] atomic: Add atomic_cond_read_*_timeout()
Date: Sun,  8 Feb 2026 18:31:48 -0800
Message-Id: <20260209023153.2661784-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d02481e-5e78-421d-dbb3-08de67836d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TDi2mnH+t9tueECwNXExacfsbj78EXcRZVAXkHF5JyGHUMNzucgGgNRFLeU3?=
 =?us-ascii?Q?dxBaYKs1TDrvEswmdxjLYm07bEVVOnXGKrvYLVbJOK22zYFfg9zHLXnVoxfx?=
 =?us-ascii?Q?Vj4BitFwlvp3qNeBr/t/uiVw+gsYUQu7HuStmDWhTOp6ML/nINowMUQCpDUt?=
 =?us-ascii?Q?fNIdpX92KBA4J2vLBKctTyv3L4RXlffZvuAtwRtVXiuVC0t4TvOOzXF+fpdL?=
 =?us-ascii?Q?Zk7hGWolBFT8k3J8HJI/HOgZWes9sOW7jEQTv6Mh78hMmyOpD/Kpw465cm1j?=
 =?us-ascii?Q?IFbhAo7SrixSojGeFSedfI+znddHdJ+zIcnZpKNYJRVhp7Z57kamcj1S770e?=
 =?us-ascii?Q?p/qKWUXWez0fnGGeTcZd4XsD/vWYoWd46w0Up1T82gvMGU0bdrEDuNVjaAhM?=
 =?us-ascii?Q?1wzV3EvF7HnuwDEFtjKmCXjprzNuI4b6kylxQ0FFBfTjZL5ipPDp4UDalyn3?=
 =?us-ascii?Q?Kev+lYrWbFkpylczEdmsihkQuPSaz3ZClTdpv2Jk+114k971r+JrWQCEuWB4?=
 =?us-ascii?Q?J0wd5FrQa1VV9DC7Gh2LawZ7RF7CEHx1302oT/L7FVZOi+Kp/kT0qdu9zCuE?=
 =?us-ascii?Q?FjLVbJiMHG1+5yNU1BERoi3Y2VMNCfiKx5lmjXrQwiNed03rbBaQ4+rIW23x?=
 =?us-ascii?Q?B4nFG1rGSER/mQVqGbQnGe7gsHeL/+RFijfI12BqnmvuOILatllgxpHcyek6?=
 =?us-ascii?Q?Ejv+IiY4zAkGm3hx7sYCg9KAA5t7O4mk6ZX8hCu8RQ/IcEN5+LYOyWzmxiFF?=
 =?us-ascii?Q?Il5V3hBT/9Y8kSsxsHO6IX4mAMK7sNkW1eYgoJL0v7AypD04IEtch51sTyqn?=
 =?us-ascii?Q?DUOtX702mpOX060DDlMDQJ3lO33eUt2lkZ9kNFItbp7tCObaGIDggs+5wpOQ?=
 =?us-ascii?Q?ZwR4OgbTMvIDaR65AyB3nQaId3plnoOsCVbkW2IKK8jqd+P6VJ8mqOiFVu8S?=
 =?us-ascii?Q?QV0dmSXvUKKbZIXndo0sYXlU2dS91uRhCls5flYPnOdsIT1rTuzMsR/B7LtJ?=
 =?us-ascii?Q?xedF1XtlEliCcMq8i/gn2zc5LbU3SAiDRFtJrhSr6PDXd3S0GX9P/xYGofZB?=
 =?us-ascii?Q?2L01hrgQnopiwkgNCsPlLU9jz7jmnDsoWmEwOXiDL3Y79Ch0PeyqguEJUIbT?=
 =?us-ascii?Q?jCcgtP4UCbL6MEySoFOUNpm2FCiG5+nKUNfdpzQmfm2xT5xXC30RHlvSSOZQ?=
 =?us-ascii?Q?L231TmcO08yp2KgBUU3TuaB1AqmbKTbe1BNyh6JZtOO6zPePDFu8BZZcepjN?=
 =?us-ascii?Q?+PzUpFPxdzadRGj3gQSFZWJ38W8YHcLue4MO3tWwbxc5YDnndncje6aN4gUp?=
 =?us-ascii?Q?4PY1vTNmIUKtdCU4EaEJ8ME1iO502FivYt/Rp0U8o8cBrVN/JxhLGDss8BFm?=
 =?us-ascii?Q?N6ErH/GHUhvdoKThB8fIbbgYhWdzPTHCAW2w1CLfgToN7vO9sHJNu1g+UcfW?=
 =?us-ascii?Q?FDRKPxg2wwCh6Msydp9E5cwbWR8DzImvkPy7MOqU/SYEkjjfqjaVLUlWvywU?=
 =?us-ascii?Q?0X19xN9VTTPbsgqtAr0PgXT0YxERrJSwDyW8pZ2b3yM0C8+EHkDrTpvpDJKu?=
 =?us-ascii?Q?jdtDbNRR5y9VwXOS04o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMMVeDncHG0v6afCybQRfr3Di/62jrOamABHSnHB6U9DeIpQ8wQPOPZuXmcb?=
 =?us-ascii?Q?TDUP4OCmcoSBZo5c+NzrM2LFBsvJWjzHW9GBRfiGpSY4v76vXbb1qdd8RX3g?=
 =?us-ascii?Q?H7SG3rjQm0TTdK04cjLIgVurPLucPfECIx1w4PedupAuTEblx0TE8wkRsl6t?=
 =?us-ascii?Q?Xu4x9wYO1oHQLihMKF4Zs4SJQe6GGalusQ9av1nKHZ6lP47jE4kIkSEKeapl?=
 =?us-ascii?Q?qatxqItd52/Z3LsyMapJq3FGuOIHaYoMmwRue5esXMEpHfmH+7qISnt4amLk?=
 =?us-ascii?Q?suG7dBhhhR810hKVUiOCF7dyzpTtUTViS7MTAAac56QxXXukYGn9I4vlY+7u?=
 =?us-ascii?Q?m3FiWICkgXvcmMXBHnURj3U6oXepCdGueyCLQTzXUvbqHxI3+FXdIin1dEE7?=
 =?us-ascii?Q?jwHBGkpCakjCA+osTRt2gGBIH3Mg7b93gAKtPkNW1nR0BxtyISH6lV8qctGe?=
 =?us-ascii?Q?koWF/occaLGWVYvrBb8m2dcK32hj9bMBXF87rx0trWxMLt7ODvTxbzdNvA+S?=
 =?us-ascii?Q?VICASFCQxIb+qPnbFaWsX/7iJ6PijrEcgm7+1GvBlCBBLaF0hdIMuwW3KeMl?=
 =?us-ascii?Q?CHER7i8Z4DJ1+hrK3/dTOCR9VlVl8KsBmkuh7RYJFITM7ErPMW1nTIPwvSTl?=
 =?us-ascii?Q?6RcMXOlhgkc+OlRrJl9gMGKesbQp1nf1aF5dkoKsXBDeHHHgfJUkKlP510gm?=
 =?us-ascii?Q?Fy2DczyET03PB8rvbwLmpEtpr3fYiWzIHcRdjUhWPqZ6xFhn2zPlCD8yiHSI?=
 =?us-ascii?Q?Ek105Z4oNAGBhKU6gtOEANzlfzpj9LU79VfoJS6XSuCujJeKsiqJxP2RI5Ak?=
 =?us-ascii?Q?qeLf05ofFkGdziDQhyh01bMMEHkerlU1MN7DQEnVFyVzCaYUUM8yEQqP5i+o?=
 =?us-ascii?Q?LtpLfUC5txBa9cQE+is84Z5eVrCF6Z+RAirmVVqprKEc1PzHMqXoMl+vzZOX?=
 =?us-ascii?Q?TILIrcWPpZ9e9zsiCvjqYQF6QYq/5CHSc4G2pPyppkwpC/Y0porC683OrlPQ?=
 =?us-ascii?Q?tUO0+5Ru45qK4rA1kupABNZgb2Ucp62j7YOHjXUq1m3Rlxs5VDq+BDcYAsPn?=
 =?us-ascii?Q?IxaZPALYymQIJBb/iJ94vtJ4tIpe9dUAmaoLYHc/xQ4b9jQ1FMcdce/nFPqI?=
 =?us-ascii?Q?X5qWd8avS7tjZJRSbNPu91p/F02NUX+oO24advWWVIrP0dV4GOpGfg09sIwn?=
 =?us-ascii?Q?fGSE3YB98OnaUvOmCIoEjsN/dzmxmlir5ERtEm/M0X7aPO+pc+dY6YiQVSx6?=
 =?us-ascii?Q?OHR4knCGbXLw9ts+EJ8wm/Irlq5oGNWagigTDve62mi6jFvX7/yfP6dZ9Znm?=
 =?us-ascii?Q?Xxz9p9RLPc7NHX87ABRVqYijI/ogQDx4AnVzrz5TBLfFnNib+AXXNfH9e5Pn?=
 =?us-ascii?Q?dsgGJleBSSKU6d1lalIto6pYupHvz8tIn0e7TGJz3figf8qO1NTB6EXwwrWz?=
 =?us-ascii?Q?wk7U6KB0gFzmmfjOfsI0vDkdl2lm8RAo06qx83uTfokjBRekMQLqwB4f/1N0?=
 =?us-ascii?Q?/UkNkd+oBNjZQ3D7mKk9Wy487qGNSxV1dVwO+8zdcn9iJ8TxlQ7SwhpV0rL+?=
 =?us-ascii?Q?lLNh12BjDMb9CIB2IVxNf0Kza0e0RsGP5kyloHdBbg+l4wMn2D1WsLvRh7A1?=
 =?us-ascii?Q?+uqdCMOAdVAAHHe3VBPBmoXHAJuayh+FfkNNkgcDORALM5/XM4WAvv+OXFMH?=
 =?us-ascii?Q?bA+Cpk3NbOii7e+mk2kBElolpSqKeu7C826qCzO7u2wBkBYixXSyyTfn/Ykj?=
 =?us-ascii?Q?E3lHI+19hgoydB9jVtwPs1YZgqejFbc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UhO94l+C6p0hkGQ8pyNikDwyoHfTbnZ5heAkQAoIpldZdTL+MTDGFvdqp8dCA6DL6m9wASfMSnFnFp1X5niikQuXJkgI5Ueun9g4dBEjJmt7pI5Q8bxLzqH1EzGW3uRNvYXOIcpz6ovUt4RAatmkqwLU7cYMS7w7uzosHPCyp9PslEY3vB//66jMivVRBIZgWqe0YwvFk0o7bFPBqa/av6pJy88bfRaK27sFteVDwjoXXsYiCGJ1i1B2NQ7Q1qc6UQBakreMwOs0wWZO6rgxHG04ehZHaJfru3Q5ZtM0PcBDhgSrM4m3aB+TMOVNlH1+V5nggyrrh8NNg2TPtA6Satnw02IWVxYrOL4gA4EqQp/t5MWMyW0Z7v/XxEGHbUoFEnZpCr3F6UbLEDW3iV0TB0BF0ZipC461SRW9Z7sIYfbokCbujmFPoZSbo9tAXv4Uig3M35VHXz1i8v9ga2aGwCyS1jGNpktZ6mzpJZuakk8yPIzKpwxqYaFl7/Vd3BWzXLApSK4yJLUX0aRZaNqz6wRJgCIE6dWioU67b1Q3U5eNriODaATvQB99yXoBk9ZwsWH3Ataoy4tYJ7fManUpO+F4zF6rkIK2CMR+69YSE9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d02481e-5e78-421d-dbb3-08de67836d9d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:11.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNgA0lFsIkQgz5JuHDnQLvdRnm61QrHJZnLIoX79wtCs/ukyxOF7oe1EjeylNvAhzvuz5S0reT8aF+OgT/t6rsIZni4k09kYcn5l+Pc+6DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX9eWGdysgbFQs
 pXTFnoIqhy11sAfP/602R2W4i0HscGTcFf20/YJZbzZy3OedvCt9AuFGu3XRZbHMYQUfGvK1Knh
 djzMLqf2j+f9Q5WTMjD2fTHegWzuhkzoCIrDVT3MwgKrbxuXKN5TzMvEBa7L7nikIrHiycW1yYC
 imrDcg0JupKqCzJhkmlVtwfDueYo8zYAkRg3yBZrpIN3dcUGb4D+gosguiDPrUOPGzWjfmPijB9
 ZQGssts1AXRSFg3qMPzEzPLCp19xUdf1me05Z2jt6ttYpAM7Yo0hYLx3njAxi6OW52XANAx8d50
 JgtJRv0NnRITFl8ARsXTxIZp7Vbnkjw8psxwozeot+yZ9wUF9H9SXIx5n1GIpP4a7tSRQWP6hln
 FvqOeWSj9Gq4VYikbdTr4U6eLuc3ZaqaJTVWD/ZsVa1FrQlG7wqOZTD70PpLCcuOb+t1pzVc4rR
 +G73wpMfJtOvoIUB8Pw==
X-Proofpoint-GUID: eKVCJ0rlsS2EF1On_dUP-2R6nVidSfrg
X-Proofpoint-ORIG-GUID: eKVCJ0rlsS2EF1On_dUP-2R6nVidSfrg
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=6989472e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=RgR6v_fFY-8vhBXvnRcA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42311-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid,infradead.org:email,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4B41110B1DA
X-Rspamd-Action: no action

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
   - mention these interfaces in Documentation/atomic_t.txt

 Documentation/atomic_t.txt | 14 +++++++++-----
 include/linux/atomic.h     | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index bee3b1bca9a7..0e53f6ccb558 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -16,6 +16,10 @@ Non-RMW ops:
   atomic_read(), atomic_set()
   atomic_read_acquire(), atomic_set_release()
 
+Non-RMW, non-atomic_t ops:
+
+  atomic_cond_read_{relaxed,acquire}()
+  atomic_cond_read_{relaxed,acquire}_timeout()
 
 RMW atomic operations:
 
@@ -79,11 +83,11 @@ SEMANTICS
 
 Non-RMW ops:
 
-The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
-implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively. Therefore, if you find yourself only using
-the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
-and are doing it wrong.
+The non-RMW ops are (typically) regular, or conditional LOADs and STOREs and
+are canonically implemented using READ_ONCE(), WRITE_ONCE(),
+smp_load_acquire() and smp_store_release() respectively. Therefore, if you
+find yourself only using the Non-RMW operations of atomic_t, you do not in
+fact need atomic_t at all and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
 atomicity of the RMW ops. That is:
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.31.1


