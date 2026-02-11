Return-Path: <linux-pm+bounces-42531-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OnzBDUAjWm+wwAAu9opvQ
	(envelope-from <linux-pm+bounces-42531-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 23:18:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB071280E4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 23:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8FE23027803
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93A33F373;
	Wed, 11 Feb 2026 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EKgOZznU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A/FKmSbo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F06BFCE;
	Wed, 11 Feb 2026 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848303; cv=fail; b=o+DCFO8+c8nkHBdvWP/oaE2pC5tlfUdUQXy6RsXPR06vPhBxR7qbvDcPB2JfLFRS5QZA4CILEzUQxjPgBgMQiOhiFH07Ro/VSX6by/Puw6GkJNVfZBEx+ztGb/PMutuZi4Z+h2BVd6WoQqsXMpPhVN5qX/GfyoqUmEzuiPSISVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848303; c=relaxed/simple;
	bh=vL1iBdONNS6+q7aMSwoAwVTGkBISyXWAES1TGuq35pg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=YjJDj637NHZanm30+QZV7cE6O1tU+r8bR07INLZDCK4sbQVymjbTXZsXuphejnkep1mYWGaQdW3F82qG0/8TFeAABenvkea6VAa1VTKfgjxR4TUi3Ajo/tHmELJvIGRC1v8jiDwVbi1O0TXSj7620IjfwOjTn+40CLgHm7J5AI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EKgOZznU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A/FKmSbo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BJb6Bg1815510;
	Wed, 11 Feb 2026 22:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vL1iBdONNS6+q7aMSw
	oAwVTGkBISyXWAES1TGuq35pg=; b=EKgOZznUUSUY9FHZto6VsWT/xp00FkKsx6
	vEnNkvxb+CqlSkEHcwRoMIudO/EIaMwmnGFWn1L/H3TI8rbu2HIMxrL17y3n4ryO
	s/X/wDqniXmyxMjy89jmDDW1kedYlgxcBW0SLD7IssOT/w/GWgjHcXXHn6v0UeIY
	G3tJpUkUcfgGXXUn7LT1LcEnnN+PhokUxU5mIMlsry4mcZN1kWTHGVat98NlwkNb
	HvIGOijGqBkvz3YsUNFKD7zFkwB8rAWK87SambGiK4lhjEf+Ppze3qz2lve5UHuu
	bH7h/fRaiFjt19AS5qFdBePcLzprAVhmVj8NsXobZqu+NzOmXR5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8xtu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 22:17:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61BKWjsm022545;
	Wed, 11 Feb 2026 22:17:41 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c828c4ty4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 22:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU1pQntbDecczOFyCSHPnHkbN4H17S311/6U0HXMXhNj1+3hDQihgzy+Uqp1EH3/RAyg2x3BQcbpPhQo5DDR3ACzyP9xzmpvGjGFuvFrskb3oqAvdT4/GeFeKf16eElv9ggF5XNmomISVq52ihM/5q6/RCZNgb8u1v+p7JowcoRAYlyEXlv8gn8Ooto9aH7qb6gTkxPjwWm18pMzCEyxzha5MAxIwR9sn1YaFYrhdXDejVQcuRt0nXaOq5PeiHZp9dlZGvIgWPr27tEZw22eUdDRUWz+iImOrDWUFScTcTdwtdUBNbnaYufho7Hvzx4QWediXfCEUvnkXAZE1VASNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL1iBdONNS6+q7aMSwoAwVTGkBISyXWAES1TGuq35pg=;
 b=S+SmXQ9UTT15pqLOhncFUFcpRreNvFDeXkzAK6/YXDFNQWCFRB7RvBXTit5rhx4nsl28X25i0p2dfFaQXjbj15GpdAbUzsr91pDEEOwnaL7Gbq95C9M9Q7foCNQRSlqWm77il2A15L9ZNp/KMB67u95EWaMkWADfShtds9s/D/If3I4BB9633d8OsOc2nK6xemEXL3Vtyn2z5pde3RjltTEAqdfjntfGxbzN0DfTZ+mtg5S7RJRTknC5qqGEpnWPKq6+COZ3L1aWE0Hlf8tYRngXR/rUec2YMr45mqf9FtmMLwX+elOCZwxQyenlnUP96HyaDXZunq6Xwumx4mFGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL1iBdONNS6+q7aMSwoAwVTGkBISyXWAES1TGuq35pg=;
 b=A/FKmSboi3bvI28trZGcJcbOsPUjjwu6nL5TgLZOeMkXDIyl8X/EHWuClwJByiP+MNizzA/5Aww41qW9yt7/qTqxuyQKNKu49XJ3m2i2sAotP7e9kllxyCZBEr7CXCAO26B/sRx7KKKG7YENXLdW0nYjpAUXy//3iGTyV4De0io=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM3PPF1F8A3E3BF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 22:17:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 22:17:30 +0000
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-2-ankur.a.arora@oracle.com>
 <aYyivg-6aYspHIHA@arm.com>
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
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <aYyivg-6aYspHIHA@arm.com>
Date: Wed, 11 Feb 2026 14:17:28 -0800
Message-ID: <87h5rn9b7r.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM3PPF1F8A3E3BF:EE_
X-MS-Office365-Filtering-Correlation-Id: f007705c-f68c-4f0e-6d35-08de69bb587a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bDMvihwPHEPRpgk7CoNrxwHfMQYYf9+XZR7psFcolcp+7UPZ1kjad+VQi7AY?=
 =?us-ascii?Q?wBVrrh/ktO4uPDk+PoBdejHnFrO6WW5z3u6sqqcBSFFv6rOXMbBMePR4Fud8?=
 =?us-ascii?Q?jDbyltFrwJ8/xOdjfgsFJ6DWUx0LqM0LkuslQoLu57s9hHGyQaWHmlb47OSJ?=
 =?us-ascii?Q?dmOfyPeMwuXd+WQfcTScWFa7CWSgm+htz43Txpq+HUzzzO7ZnrRfT3XJB0QN?=
 =?us-ascii?Q?og2fsXU3hGnlaSba7urCk5ogm3wHkqOTaTar74mSmlLM9FJrUuOCr+iV9WPX?=
 =?us-ascii?Q?m0ppimFBY50xpYN5/AjEv2L5fVrMkm2XUReqCzw3oS7hkaxWihYfmJTAMa4W?=
 =?us-ascii?Q?hvHceUExr9dCWo4MVlLjYYE4vRuO5V0bV6JVKe+IOYYv+O9eWPZhTVI3MtuG?=
 =?us-ascii?Q?evjUajaZRdto8dlOLfQcZZwI901heOv7PTSUxnNLwxim/uYI7W1iRL4ucF9a?=
 =?us-ascii?Q?sgRBI1m0oNTFnLTAhsPNtplPyDqROWKu0hNJj4D/7y5ohhx6sOqfdee5sGQk?=
 =?us-ascii?Q?XMZnP4yp3x9sMwgBsPqYNnAR2EcsISaksqHCtXHPiIvKXVe8FLDt/BurjBDV?=
 =?us-ascii?Q?NswSMWr0lFdwakml7DGF0YjlLYagrhFKI4/oQmKKCS5VVCKAJzSMyE+nIiQp?=
 =?us-ascii?Q?Qlgr2XGXZEIpABY17h6Mt74TWXa8QabaBMgWWotZtkx4tZfoHbm0pEsdCeJe?=
 =?us-ascii?Q?dookQtL4NB6miEcF/xMWMP6qRT7i88FaGrgWUqiaD61KrbIxnYNoJmA8sjUo?=
 =?us-ascii?Q?EGWrDgkka38LjVhgk40LgUB/gpdsqDHQwheGZ7dBGMY7Uby94xovHeCeMvzV?=
 =?us-ascii?Q?CKgzzW8c1NlAe73RBrdO8eu2EAZFwzlkd5E1mKP8lhkeO72Pan3sXetUS9ej?=
 =?us-ascii?Q?XjKlBUeuDqvRp3iZlRkhkAWPlLq3MbcYeEnWc1W303TN8FrCQUBmKO7TMHjG?=
 =?us-ascii?Q?m8uI8Igy0kjXg7c5eb2Eh8+DS63OF2di2I9R7XwrPBE6IhGXnYYNXDzAXjun?=
 =?us-ascii?Q?P2dZbmN0hGxTGd6H4tB/bwz20CDvczCiFvXet7KcC8BfhC6f9F8lX/WqQEes?=
 =?us-ascii?Q?a5Knm2N7LyIfCxmiVw20E6+WWUZizFan7B0oPTuhbX3/QqM0USmJEyLTmsUY?=
 =?us-ascii?Q?3rPux+pHkryqhTd7UH5Ro3k5hFWW4mrhSfthr1JHZhU1LqnGOmBAroJf6N6y?=
 =?us-ascii?Q?LNC4KfRw201MDmaPEINMVX05VaOht40nHKniCVXLXbzeTpWT2QbSonvOILD1?=
 =?us-ascii?Q?/+4SbtYUFVYbfawYgzM7dmJ8p5VHP3Od95ZZ6WroJWyT+tBtw/7iOmHbHutz?=
 =?us-ascii?Q?Iflspzl40iEdb8IZz22VxwNeBdHaPSUxxclXYaGDcSBliemAUGhPaddzNErM?=
 =?us-ascii?Q?Knm6AwZ0HsHStVe610F8SrdzjNqfcZEC3QFXG8CN7C19W3iP0N7l9SpPP5ME?=
 =?us-ascii?Q?3RWizPS5K47HjT5eriiqlf1TVSlwrHG8Xd5k+epyYK294Js8E7WSlHa9lhvY?=
 =?us-ascii?Q?OSHqRu0rsPQNxozAPtRmNQ93PiY03bHBf7rb6uxeT+yOs88E7fVQVmO3ZUJY?=
 =?us-ascii?Q?lTh6EVXi7PeklAyliXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pw+3lqdU6/YZYkIrvsUppute15JpqgHwRsOmbB9HnzCiMftxxmqdW+dEfWot?=
 =?us-ascii?Q?TA3n+3sVXBUEEB2VPme2P9Bk2/ykWXBqnYo0Ht4GyPnrnYq9CMZYKN5BtI6B?=
 =?us-ascii?Q?zRefo+u8MKLrqlSC1ZaSDdbvTWxPQKGgWTM0hRMB3UYu2G/7ILpMxPOuo1w7?=
 =?us-ascii?Q?Tr5VyPPNHg3aWh+zzZgWhZKd4IP5wfvLIxUVX0Obfw+xE8Qim/ySqvkNdJOa?=
 =?us-ascii?Q?6zJnDzUljHVfju6k8VOXiYiV+FqvcsK8AJeQy1Tg+GS+WMSOQ/oDG321z/I+?=
 =?us-ascii?Q?dGPmU+Jjrvf41c9KNuFxJAxHiFM+ghhLwrYuV4C46xbB2ydZs3+9pKaDImg8?=
 =?us-ascii?Q?pM+49OypgMB6I2ppcZllV1Zmd1FzC+3LBZUClZx4gt5lT4ixnVeOV28BE88/?=
 =?us-ascii?Q?xDoG9fSYbNONPCIIuWogXGqa4c5sgBxYAQKe+CqAAvxD/mQdwPBJ3AWFMgbP?=
 =?us-ascii?Q?CryvjSEjCiR7+fAoR5sPHr9xcreo2HISMXAW3UX4tz9NzN7dmBA+upukB+GY?=
 =?us-ascii?Q?iljBpWSiCz+qjTkyNkLV8HG3u+DB57GjLRIYmqDHb3gVtvednA29OfTqWPj0?=
 =?us-ascii?Q?WOW7QmmspVWsKXbIlMaa2ruLTz8ps7wHfLcFx/D1m2ajbPGVgVrupI4iHwF4?=
 =?us-ascii?Q?ci/dG68IdsGx6npjZnZfIsS2z/EOyfZH9tGPEnCEsjh/rVy19q64FtbJcJAh?=
 =?us-ascii?Q?hpWGoBUyDdODawh7ZjHl4p3sPOzU/+Qo23taKMHJqtbFAj4Kbi91KgabE/Fa?=
 =?us-ascii?Q?q/ErjGIN+vAmQk2aHkcB4XzVSnsbhtRJJgOIiWR213ijiHk3HVCNxsucj+rj?=
 =?us-ascii?Q?YacPh46C9ubXxrg0h9fEwXc0a400ayMbvliTAbnp2VjYhxeuiWlDoYiUwia7?=
 =?us-ascii?Q?ryIiSsEnD7SWPIdFBm+0569JtOKC8h0ZOm16VHKNUTasQThIh174ysK10y6Y?=
 =?us-ascii?Q?BWTEMwfVzmcguRj2971Q1i/rxByn8F5wDX24Lq1BVkTSOeQ2OQfmuC2aY60V?=
 =?us-ascii?Q?XbI0dBBVG+BQ2fsKWjAPrgyhu1Bss6F7on5+9fqm5h5xVS7UoB2lOdBxNPCe?=
 =?us-ascii?Q?0XsiRoBnnhSjDMk2jBheLnGxnGOmDuDnYrZ+5iL8jfjLF2NdryFy/uCby2OI?=
 =?us-ascii?Q?apofSM0qjVDdDWkfjhvsVz31t/TnX0zIco47ForseVMEA+cxzHVuX/HvkKlD?=
 =?us-ascii?Q?fVMojC2U5DonRX/hXSokUELSrzOd9la+z1SamP5A5/1WFjQpm32bACQDIzBx?=
 =?us-ascii?Q?A9ZJ5eE863TH4ja/419cNZE4hymAMQGv2IdYHdSOgA1AWXA6l+FY6IDK/y/f?=
 =?us-ascii?Q?ZzGXzuR6nBe9ZqyP7uYtYv9YnAu9f3AYWHX2bYeGNboBqg4jEbN0ciCHYGIF?=
 =?us-ascii?Q?YRGcYy+/HkWDWxKbjbAxLf07VD61L/p16SG+yVoXqBqhA3qL2VbIGR4nr9oI?=
 =?us-ascii?Q?w2H2Jil0ADCsSvHZk2QTi4zbDjWa/8x4PZR8G7DEC8caWet8ZXlicRYQz6nj?=
 =?us-ascii?Q?lSygADr3bAW4dkjalgmBH7k76lVckd9w3/EmUNimYGEg+mBx4xpnTV87oOj2?=
 =?us-ascii?Q?QfDX5iY+U1kM0+oZEJrqhHkTifZ6nVifQ/SHyxIcR8qA9nkyXyy6BYHk7Zb4?=
 =?us-ascii?Q?rHXR+e8SeI/dMNqmMLq5jthTVOazzwQ4HWBhFkbvP8rUhyu9ei3dvOVUhwzh?=
 =?us-ascii?Q?PsEPNtCxdMFC2az7MP9R79HP1FxZ/GVCHUcyEybEIIyvkm2+yUe6NX7Jf5jl?=
 =?us-ascii?Q?ZJ+67XPdPMSvwfvTAY+OS4Q1am7ospw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k6FosBnSUpOzFSEsAm2Y77xgxeILVjUPTyNJcULpXwqw9XbzHdDCRNiATV3G9Z3+v5jlpLQiGz0nOWE4Ryl5dvJCsQYcgOUqHWFuczaxSIkEo30uyop1iy7hU73mqyPECIVtl5+ACfYX8RFCXPOckqrQnPv6rC+AKi2fts19uIldvm6uek4kYbTWD7guMDgrlaNEeemXCNFsMkeLUeHGlp8oyGxJvShmuBuohxEHjUMCWFiXUARvzq7oW0M0SqBhJhg34oX6wSjYjFVoj75UYE9gGcJblf+oxOLsgcn8R48jRvWpALKQwwsdonUN7+g0Ixf9gnUCOHVddQpc3Sfrt/h1eqODIdZ34zNNv5/tZ5A/2XVzDUi4u0fiwq3WukJFHMFB0Fu48lzluK7+ZFJHBGCEkP3lm0D19+B4X4RXdmzVzZa16IYj5EW/a4mP2dkd/YVMBq+HbierefCzXnaT+k4cv1p1qNXe8RlCpnRI8uiNKZi3YcSp+73kwfBe1n2kWLXWAHkyjAGifmxI9eR4fU03CbMbP0X+b9ivDvIU2ryTu9J1P417liFzBNT7RhLwFK1aShRzq0x3sz7eUj448c7bLpVq1er7WebBofvf92w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f007705c-f68c-4f0e-6d35-08de69bb587a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:17:29.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icBcRNq0r1D4xMBpzV/MXy6S/y0zmoFE2t8QOz0MwaH6hgiEdsG+YAXKJabud04hhgPMp0LyczesgolZ7gQ1MhTj6e2gASbvfnINo7WUoKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1F8A3E3BF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602110171
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=698d0006 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=UFsxuguZOQtbZFnd8moA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12149
X-Proofpoint-ORIG-GUID: hXgmEBq_4-eAl02w8lUHGzeMSZS-a41t
X-Proofpoint-GUID: hXgmEBq_4-eAl02w8lUHGzeMSZS-a41t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3MiBTYWx0ZWRfXy2q3X4ifz0Hd
 WQuSj2a0J+1ygXM7t/uxNjWAk5RAmglMUVwwACypPk8FgSjoqJhEb7HPwPv9PIgA3z++qe6nIzm
 RcWZhLYaMTX/mtuzY0GUc45/5HE2TpHNt07TeVadRV3y0xVVYyN+dXv7PPOgCyYd2EkRonRx5e/
 19e/A3LzTDx3B2dFt+hQ8azZXvBjm5ky5ZC6D8Bs2L/qbTpFyDdqySGAHnwH4H60m8+/bZJ8F0i
 1cGUZXtxSLkHBWO424ns0NAcWP+HdlSSauExibDLKYa44MKNcjvzxBcFd7K4In5jRjDV/XxuSVW
 EKauHLBPqQwZ3jwIrbruM8TIYnfHJcx0DYnvFsfsMMYFAUaNuYHPWOmUGjZo4UUm8GnC9j95Sx3
 otArOBq2Dg2jXYz/YRVEroSlZEsj2T7g7bHaDsJEuapvXKUHn3gNDleFO9M9CPjmatWck4mOARv
 DRH3BfbisCHvJNQ/tj1uKy2Nm7I9R4Cl8HBjo/xA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-42531-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3BB071280E4
X-Rspamd-Action: no action


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Sun, Feb 08, 2026 at 06:31:42PM -0800, Ankur Arora wrote:
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
>
> This series evolved a bit since last time I looked, so going through it
> again:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Great. Thanks for the (re-)review!

--
ankur

