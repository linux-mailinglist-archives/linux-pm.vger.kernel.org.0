Return-Path: <linux-pm+bounces-42315-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOOCOKJHiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42315-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0010B250
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2061D302445A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC54D2E88BD;
	Mon,  9 Feb 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HCtUvoGf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U8wn6K8O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87702DD5E2;
	Mon,  9 Feb 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604373; cv=fail; b=a/DLQgX4l9BtU84xPrOajX6139ZZOH8Bo0wbnXWlOLEjurWNs0OD0MK4o2d4u2iKo2OnXlwj8dhF94/iB39puRUKorO2zY0nBUbwqMfuD8dP7TAX8dIzH8wcfMzlsK30pzDU5chMSBSm9sviR+CygKXEVYGralI1RugHtWfY/j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604373; c=relaxed/simple;
	bh=+UBH97J7IlLDZPVke7D+sQ/Lwqzmw3Tz08qbtYD4C18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mm59Wtf5ECOPINgpN3+KqecVdVfI7imGhL2ioJvq8nd1czxTAu6hFn3wZPCImYCpJ7GfS2qYGh0+ZPPEEB2D0moG7mYTmvJiGcYscoGKq6nFDyxYBdLpqABMTZ3OV7fLlbN8InAIBikeab7LnwicSKhUvAAtHNoPeinFXZLhh4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HCtUvoGf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U8wn6K8O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190H1iG194061;
	Mon, 9 Feb 2026 02:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2YyjxmSo+6gVm4Xc1c6CzC0hgCUrQbXj4DxMGwTnzLQ=; b=
	HCtUvoGfX7gnDqIkp+1D9Nvo6AYoDtLRDjnLJT4L5cTB6Jy+4l9AKfDnxmvystil
	o+JQBVXGq3wQQBVFSAjwrrjFcyc9zkmgOerL1VSXkUEwCkL2VrasefvgTTlpaKcL
	LVs05Gti7zfPi/cvurTmJ9RK8Me30IXYl6uOhPsob2VAfvQI9EDeTkSu8fRh2+Jf
	lx56b3qD4u9xFc1ReSZRPYzUNyW827Ohi4jLd1b8RuYwiZQuhhhC0leMkoX0Lq0r
	xbBpVk3dLD934OQiLnsz5ha0vJlfr2jpaXcuPuWhcqsK8ePR1P2MXH8SsVeDSUrj
	lK3WeYWwcy3N5Znt/udfsw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xhu99mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:31:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6191gXsI020839;
	Mon, 9 Feb 2026 02:31:58 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c625g7arp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdFDQumXwOAy8pHHmPfHzxhm97H5MRms8X+wN8MMDAkRtnIVoBSEDN4ev86j0Nau3NJpx60/9MvXtcLNJArIz5bKgw2scKbkhRZZ0piRNydvEeU7dBc4hpTkuodCZ70NNmenG55p15Umu/9CIv9nQwjvAkPdj9NY2uGfToPku5dlM2MD8tHR0lFJOWtTNWhBpN7QO80N5Q6BIW1phq1mwAREOaNF7MR5rMgtDzmmhsVcEQDvcHlYWsgAsThIXzTQG9SwFulBvgu2fXiQ+WbHsdZ/lLKGct25h3FGgD+RuMdH4bRNjMxVNBQDXCHkVlaHza05e9JNpCYKb7HTebOfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YyjxmSo+6gVm4Xc1c6CzC0hgCUrQbXj4DxMGwTnzLQ=;
 b=erAI9XYUScW08HxJ1g52IBspebZ0HVJZMoM71fOUWfuHHMoeRyKBDXvPR7SifoKaimBVrxZX7lwS769TBiYm55Qu5JbJL48qkWXtiLiTFJLjRfA3jhCYvTnT0ZtreaiqwTxFVHyYfjkayrydHqHVxTrG2DIH9wg9I0gxrp7QC/63oNlvN6LVNRKwCQbmq9chSC+qzIGmatIGnx5yHr50OIKB2D97it0GasfMYuJ8Jvl/8hwe5a6rJT29XdqJdYUkKB1jxpFvIqMaby4yLPbwWHocK2sBvWYJrNAt5I9Bk52xGIevbWWpTGruXuuCgr4jgX2XeAXSKS/9HNI1ikQ50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YyjxmSo+6gVm4Xc1c6CzC0hgCUrQbXj4DxMGwTnzLQ=;
 b=U8wn6K8OXavuU24Zc5BvgravGgxKSicQmEKAdNL8Iztcog/2jIBV9mOObUDpWd9Iz2ChstbreIcNu47ldyFdq4QCqj7hIyvzg6o3VO1wjX1iE1zWipIhJLI3NPy5RHOAsGmbxPRE/N8CvS4GUElH3Fa7zq7qw1mCiBC5QDTztOo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB997601.namprd10.prod.outlook.com (2603:10b6:8:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:31:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:31:56 +0000
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
Subject: [PATCH v9 01/12] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Sun,  8 Feb 2026 18:31:42 -0800
Message-Id: <20260209023153.2661784-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB997601:EE_
X-MS-Office365-Filtering-Correlation-Id: f9127201-dda5-43ee-a5bf-08de678364b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56pLfn+vROLdZvPD4dQT7kL0m86SlXhrJL+NUrQUfCe8EBRq5Eykq36JA33K?=
 =?us-ascii?Q?f6M/dOlQX0b3nd3t4d2NXTqVg3Gy38ztpUytX4JP+DU5SmbldeoEYu33DpJ5?=
 =?us-ascii?Q?2Ni59tUdwFqYUKKNFLCv2nyldbeprvU2WgiZLdCE1UovNTP7wNEdnRkeocps?=
 =?us-ascii?Q?dSICjniYYqJfF4iGTEPAJzgd1Pv8eLeqXTyP8NmsrJcVuMlWQN4vmD1H4cZb?=
 =?us-ascii?Q?WP5Qsj93LXB+etWMjAtAAGiXHzmML8b754RofLeqvKsWvx0nI8jvNAIoPTEE?=
 =?us-ascii?Q?keyF1z/RwulRMDDublb2A7t6ZC6c2zk9HnCyV/JCn1NXaSicRYE4PSfvB0yz?=
 =?us-ascii?Q?DstwrfYvddFz6tYQSZ0wu5xZnqK9uQgcDlZClKwE5KW8x2oruDokc7UZ42AD?=
 =?us-ascii?Q?ZpwqsAptRDJq/GA4VV/qHM+4054pYPDMYkaM9ces34vZ6Kncz/vZm/IEijaP?=
 =?us-ascii?Q?OAe1ZdoeXbdGlhLZhmVBReGLrkTNflarvoUvoD4MPA1sQm1XDmSzNiW94PAQ?=
 =?us-ascii?Q?1Lzjkn30FytgbHsz9OpEFffXWYdUk/wDCyMPXQ6CakNRhIDvyc24ylG7k3r3?=
 =?us-ascii?Q?k54/EqWdKiC0OX15ROWrlw8XQePMfLHy2UfqBrCU9yNhP4LqZzHMoigP7H7V?=
 =?us-ascii?Q?+oIcEU2jm+NRCsNV9Z2K1TJ6QDS2VFAx2aGhgJSUc+EYUD6beDjOkQTmfBTx?=
 =?us-ascii?Q?SyLlW9FRUfkRCwKEoG4MPGlEyP2sh1GQmumBfMysFHFQdQcf/rHEofrtLmk0?=
 =?us-ascii?Q?nxG+hZ2kAvl9KlhdLD4d3fPqw5bct6w7wwYGdxfwbUpThbrzAfZincbcPu11?=
 =?us-ascii?Q?UODIqKZKMavdrsgcX2hSOOuCMsCGtmnKWYbV8pTKS2wbvn83BhJvFPal6d2y?=
 =?us-ascii?Q?7bIHSpBeNIL+BsA8A7wp/eafwH5rZQR9mtAATV0sbyDxACZyLby5lQywGL/T?=
 =?us-ascii?Q?++hfVDPdw+H64ycdBaZfOeBdxtWcm3BQ/me/5eLZA7FtlHu41WE4PjJdQJvl?=
 =?us-ascii?Q?S4Eu4vQbINi+kFwhbmdUSTeRVulWXgnzC2mVqOku+3ec0m/p7BJC2B0faxMb?=
 =?us-ascii?Q?/e+Dp+q7nu5oQis5h4jZ4TeCLclTtUUMID5AiNyacjMVfy2DZGsyE+B6iz8k?=
 =?us-ascii?Q?1rpkvMXQAmHx0ndjqFy91MR6rIf0gHJ0A4/Bp6WMj8fW2rNLCUfuPeTiCh3G?=
 =?us-ascii?Q?ro8oy7RIVeDKYTihYfj/2VDDW+55btGge/r83dcBKtJdta10QgyA9rCOn4+V?=
 =?us-ascii?Q?Zk/EGMJIvkkg5afku/uYwAx47ijH4A3ZcA1u68+aKN0YJj+83LPeN11eqdRy?=
 =?us-ascii?Q?CcmkAzeCogsWQpS0IgGgrWYGRbbhB28itGzMF68rROl095brp8G54hDc1RSh?=
 =?us-ascii?Q?sEVV11+ETsOtFNGd7iwhuaeLvM+KHaCdw+BXtBhhzVne3tWvKZpipudJYQpn?=
 =?us-ascii?Q?t+JsH8B2wworVF+xVFem3dtnHucAmxqy6iDQurIRRbejlmLYW/4BtKvUhHUS?=
 =?us-ascii?Q?6v0JdCTvQph48sbX8Ps9JB1dAW94BLffD6ObpaWkmg2J8qWTCB+wmzAbhzPP?=
 =?us-ascii?Q?SyyOkkBVRvWZgAc3/dg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pk7GjrgsUqIFmpOSchqCDXJwVBdgHGINzOx6lzmj8j1qVtDbZjWVHWAIJto5?=
 =?us-ascii?Q?R0OXGIsNNqqbmIfUGoMKMcXwOoaW6ab3bVEmp2JZSK8WNlhMlZDCncBwMWj8?=
 =?us-ascii?Q?F2pGd3bQVkx6mfleXTn6n3rYip571Sk+Cbayvg6PBWYABWzAenrc4NKvBwGn?=
 =?us-ascii?Q?DdNbi7v9VCQxnKkuaUit3HWKq52+OXz4TOTN8l1O7qowAPuNtq9bsBrqHTdb?=
 =?us-ascii?Q?ehOkHDtyGxIHHQODnI1M++LvE0o/7czfxDYmXioajvqypWk+6UjN0uHSHxkx?=
 =?us-ascii?Q?vH4SRDDAO4oM7GEzcgkuGGQ1fKmB3mm72CZQFOe6I5Nh+aP+xh/rXzQ1lCzi?=
 =?us-ascii?Q?xa5+Zwvy0v0vI5b2sf/ABjg1RixS29Hvc2VoFMdo3luNX8r/d7XXr5N1Z4gD?=
 =?us-ascii?Q?z9YlwlYy1ZUeeY/qzdue6bAVTz/V5bAG7AyK/X2eBGLBJh4Dpzg6OsWQ9dFF?=
 =?us-ascii?Q?f6/qfpfg2ci3Gj9MyR+SUnzOu+gF+d/edVbFvQm4BSw+ehaYCy/Gknczt3xW?=
 =?us-ascii?Q?rrsTAyZK5HFAQ+ubL3LEIkhwRzlJQHJM3f3nLJbO1HyTivRubPSSuNhBUYkE?=
 =?us-ascii?Q?4iNJVAANY1o0StfvAm3FpmZaugB6f89eRC6oNRqn+bKFPMBwvHGJXCTFuFCO?=
 =?us-ascii?Q?GgZyNaBSJCMQIrlLtoozMJtjK1YKBA81IkWhFxaEH8QCdOs0SXq91QPjFK0r?=
 =?us-ascii?Q?x7B+MNsr1tV6E2gO6fsIYZk989ylOK9bPCK0j9plEigcBCGgTVNTJQ1ZGoyN?=
 =?us-ascii?Q?SzEOC5w77I6tnHTwj11WH0Avk9HpnbM0O92veVUJftueSabJvIXF243WU6s3?=
 =?us-ascii?Q?VSezC7SqQSiCFS1pnbWaP7GIQ1RvBItx6MfqXCzHhFzufWRuhFWbizoRMm9j?=
 =?us-ascii?Q?pVcLowmkx6zz6iJ4rXiBDIkddzpcAYixDl8Lvvtv0CaHEUpU4e7hTBAxkTLM?=
 =?us-ascii?Q?fkkM/xyXb6dMvGy/L9RXsg4fuTklTuKN2b9wbEKVn6BtV9zRDAcqaZ3+CH9M?=
 =?us-ascii?Q?4gFnFvmfqgyW+vqnt44A1p2TJ9mtY8Q93XKyWAYlBzlU6F+XGU7yE64vbpgL?=
 =?us-ascii?Q?FG0gzBrB/weN+0eB1vXVQIckruFnuPYW7hdEH/WPOolvtSLvtVj0GVQiBCIz?=
 =?us-ascii?Q?JP84HDiSO9sTXW3WVEMLwb1Kib3lvy+Oakz+DCRby5EhlxUKbGARfz2yy1Ib?=
 =?us-ascii?Q?eLpjdwfER1TZTfflNIl2Pazk/9ICuloWfbf/d+wqDXH2HFOEElxFeWxlz2pk?=
 =?us-ascii?Q?g65k68lVkpQdlBE9lJhS7w+bka160ovZXJvWydHR9jZTONTYNaSBfMVj9IyQ?=
 =?us-ascii?Q?CN+8ThDTLEFMdbsFPnZ2+wN8QNaBENSaxtNO0Kyeoyi/cMXhP8nHJhmF0kuU?=
 =?us-ascii?Q?73kPBd6mcl1RVx3RFOAbgZRxDyYeCl+RbNBP7u6JowDyDuVWbE2nOaW2Dn1D?=
 =?us-ascii?Q?ekolb7DMlPZ8d2/gZSWcS5yGJdUldPs5Z8rtr25u/amLgYn7EEQs/Imi8/kn?=
 =?us-ascii?Q?cktsTuYyJgY0/h0CExuSa9t9sVeT6cVqFE3au1xWWfEOudfHr0nqt75W5jW6?=
 =?us-ascii?Q?S6Vz52LDaoxUlc19SIXvg57gKTFY3G/9YuD7a1usdTVMHKlzFbP3C/Ryhn0w?=
 =?us-ascii?Q?lKaT+R78qT1xmf6p2S+yzol4s+agacr4mCI5vsM8RKDTzHRsNpIQa/aGk8SE?=
 =?us-ascii?Q?4AQdtHBpWBFDYp7eZRDegxp+5gO84RjPPRf5eBWaU7LxIAaJ8nXnsaYn/alr?=
 =?us-ascii?Q?1RIZC77/NZGjERJOt7AyEYd95zZa9r4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqkUbA4D4cPTHBIoxEFLgrKgXboow5Bg2wib8Fsm/FxQmdGElx/yazT/WP2qwvQBu5F70mbpGuVurxvQGTWzHodjUcQuYHW1aUZDKhFbNXrTPuWsmkkYU0tB4skC+2fJwZ6EQp97s68h5rbrIYCLhpZ6vSa3NaqEetSjM7TfvPNRf6XcSwFHjdGbsFPmkJFSi9IkDu+wCCdJDpxB1tWig09eO46mbJUyKcLTnMaTs53qIIkSxs5D95cK4IViWoQhlbNRNUrdSSkGvwgvCuyzVE2wNE4n4ugNonFBf8K39IXOt0jATqjgUcouOu3wKuQKJXGjkU5fKZRvfs45tWF6kABf0TD12ge78Pd81HEiiJQgqJU74V1mXAjuMNjtLxR/uibyhavLncnJ95YuxU2aNhFe7IRHntVqJzq7tuU5fe8KbrO84o5Wjr9+VNidy1R2bXVTD35pw6TonCjAtMkq1nZ7zRK6ixAwuaDHUCx+X6A7AUW3OvTvAKRr2+1aC/+uIc6ew9Na8zJ62NUUs52Y6u70xtCLmcEjjN60bELkyKUMOmSDtcNUxmNjQQhVNzOL7k6Tc1rFFNfRlIIZbQXI5QExraZPuYNrgU1/+SP7WV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9127201-dda5-43ee-a5bf-08de678364b2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:31:56.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyEahkHAYtkqIf9ai+48LAvT+sAh4gSIhP/PN6AYwfPOL7i5In5HwOICAo6+oqIIkCqfR24/3AENmLzlsN/5Is0gMlKz9c/6SVl0XwkT9aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090019
X-Proofpoint-GUID: dERFVsR4GD5yKZrIfn6duGlstSZZBnCU
X-Authority-Analysis: v=2.4 cv=FIsWBuos c=1 sm=1 tr=0 ts=6989471f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=DPZ65ha9606nDcxGDwUA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX2MONHpkoAWEz
 JMYOPA8gfqi2Ppbtzz+CFISQ4M54mu40PQG9MoFarNemRT5WrTf5bJLqaVtr/9Kg0U12K5ziOJm
 U8//xg1Byf+BQzfzXG1dlxHAYSoPJ5Nwax6BnUuj6qltY+FnMXQFyZP3HOSbx8VHDY7cT0kKaD4
 vvqkw/SgRKIG3yKGwB0BuFO/0FFH75SIm8puHSfgCewIAfZVVSFhdJgGV766TVZAvMOvrfmxet0
 Z2U6Oi4KWAG9WREOdI58qTemhna0j5vS1QZGHLZwnqy5ar/3hFhB2kXreBroEOJLSUv69TT6UA8
 j6dkVRkL3UZFObvXkk33ottSJ5PeLjHLxRjyEeMLdScA1HxokVdQJpMSrPFhalzvefGfu1kckCD
 0USDZ80wC+XwGhumWnn7IpcKSSD8vgvta/9ZwsCpgNV7ZBd17CX+YwxfKSYQqO/+qNSk9AEsmXH
 HhHpe2mPccce/bAlRvg==
X-Proofpoint-ORIG-GUID: dERFVsR4GD5yKZrIfn6duGlstSZZBnCU
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
	TAGGED_FROM(0.00)[bounces-42315-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,arm.com:email,oracle.com:email,oracle.com:dkim,oracle.com:mid,infradead.org:email,arndb.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 97A0010B250
X-Rspamd-Action: no action

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

We loop around waiting for the condition variable to change while
peridically doing a time-check. The loop uses cpu_poll_relax() to slow
down the busy-waiting, which, unless overridden by the architecture
code, amounts to a cpu_relax().

Note that there are two ways for the time-check to fail: the usual
timeout case or, @time_expr_ns returning an invalid value (negative
or zero). The second failure mode allows for clocks attached to the
clock-domain of @cond_expr, which might cease to operate meaningfully
once some state internal to @cond_expr has changed.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). To do that we defer
evaluation of the potentially costly @time_expr_ns to when we hit
the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time of
first evaluation. Additionally cpu_poll_relax() is not guaranteed to
return at timeout boundary. In sum, expect timeout overshoot when we
exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we expect
a tim-check every ~4000-6000 cycles.

The outer limit of the overshoot is double that when working with the
parameters above. This might be higher or lower depending on the
implementation of cpu_poll_relax() across architectures.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. This might be relevant
for cases with a prolonged timeout.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - Defer evaluation of @time_expr_ns to when we hit the slowpath.
  - This also helps get rid of the labelled gotos which were used to
    handle the early failure case (since now there's no early init
    to be concerned with.)
  - Add a comment mentioning that the cpu_poll_relax() implementation
    is better than polling if ARCH_HAS_CPU_RELAX.

 include/asm-generic/barrier.h | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..2738fe35c1df 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,68 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+/*
+ * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
+ * that is expected to be cheaper (lower power) than pure polling.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * Both of the above are assumed to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want to
+ * take into account the availability of ARCH_HAS_CPU_RELAX.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_now, __time_end = 0;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr) 						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
+		if (++__n < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__time_end == 0))				\
+			__time_end = __time_now + __timeout;		\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0) {		\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1


