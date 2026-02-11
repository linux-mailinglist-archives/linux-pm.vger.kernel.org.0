Return-Path: <linux-pm+bounces-42533-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o10dHIMJjWkoyAAAu9opvQ
	(envelope-from <linux-pm+bounces-42533-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 23:58:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6423128310
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 23:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C32D4301D31F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC9356A11;
	Wed, 11 Feb 2026 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZCl4ctd8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PZAb2sNg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C95347FDE;
	Wed, 11 Feb 2026 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850686; cv=fail; b=TIfaaZt1nMWutG2oCCiBJQdFahoeyNhS2jYILsbCuI8hmCqkdAJlnT640zEgBiDpsLTkkqEg4tX22EHgR4Y3FhrcN2zUiC4oCjBox8e1+mKeFnJzwIce8eNu5lP0q3lvoZnV23o3t0Mp93gMvoojFkOdUPCvVTYrLOCTcYX9/OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850686; c=relaxed/simple;
	bh=8BcbLxQRVBp1yzeKOu7ZVD0JS/2HvmomwCN1ewuUi14=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=rBAr2x492mJPXC4OLhEpTrgBhWGInkpRt7kNNQi7XwPaa4waK7I0I2KUTOJiNnpYssalM4MoIEx8WIHe3joPjSZWHTfiRmUCRxUSXS8aaDGz/jJojkiahTmLu2ZvQljgTJ7aOqtf8tVY9rr/cCuYJJnjmgD+V0sUyTaNdui7TZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZCl4ctd8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PZAb2sNg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BJUfcp1998041;
	Wed, 11 Feb 2026 22:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2jCcXroO0SwX/hraob
	JKeKYxndJeX6JUNOHJqOSFafY=; b=ZCl4ctd8XNw4ElZt53+xoayf4MB7GDfWDh
	60mutMySwZecxV7Gfgxy7DyeJ8uFbGqh6gWdBWRu+IruCoKuzHFAlI+5ZIBwrxI7
	EQuWbVeo80tYjh9I6UnGAhQFrK0cOiB8lPl5uW6yr3GSjWoX5ONHzacDeXtU4fT5
	hB6N/XdpxMSZDd881dDLd1iuMyAEzeE2O+hBrEoo87Ur947xFgG1Y+sgzcW1WRGV
	gREK3jPNAS0MQ5HMQxGWsh1+TUP+/M7JHzJ8AYB8NRlvnc8Iv9RzU/JVSOkrCSUa
	Ljb0ix/dlDWAHmd2HGV0uXWRL+aXFM9kjzA7xBba3ye+nCBlHeSg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c7s7rux1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 22:57:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61BLceGE030205;
	Wed, 11 Feb 2026 22:57:33 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c822a6ftk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 22:57:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knKTZbVN0FlCV3mWqCFI8KFWx0hLh++j4MZQqZC2E/rCmdYCo/kGjvFtMPkHAy4n3rur7zHWRPBta5DqdVb9ZlPuctf0Gb7UOnyoqd3oM1JbzceTgQgnkPIGV32WdaE8HWIWRZ/qCFgks9um890n+VHAHG5LzW/Nuw6xzqZWPyq83fMiUNXdtfY/shfKPevXu5BTwJYrwOGOurZRcgsLesLEtgbzVRmuyZjYqYEy4tR/RFyjrIWhi5Oz/cemgHnIWx3mJMXU4aqg18eI45atKsvXp2zC1GF0JHe4GY7YyaDqliCWRRA7I6733Jtc/5zRA2qpmuDA9rlVA5TZMTKWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jCcXroO0SwX/hraobJKeKYxndJeX6JUNOHJqOSFafY=;
 b=hvXMXTVG11FDPQON8soLRFY4oOdZ3EWyduWwouFU3GBSZfYNpOxs5/t0CLUe2vMUWaqf8tQL8rk7I+r1Yh2K0wqwDsPBQqq7wIXPfRDEj6b5ZmZj/jscfyfSvs4HAOMyV+4XzdVPdLauJ6I9H17XXS6VnQ0Y9i6JR/f+dmhavkLsddT1mpnAsXGHGo7ap1gZk492LNpv7elJlNAIdMM9DLjVH4i1ZfZm6qAfVSG0EQBPJDpFxkQSmrsOzqJzdpFy5JSEB+5C0vz50TzMMqSYwEawwXzSwgn+FbpVXhU2TsKxfJJhS4Gn3CFzgrJWWIRjtI2qP95IHUc6mUej9bQ6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jCcXroO0SwX/hraobJKeKYxndJeX6JUNOHJqOSFafY=;
 b=PZAb2sNg25XwI8fNbOvdPqKiQf8bA8FsiSJyWZH/BL4zHk38wT37IjeG4T9CjTNSXvy1oXpXHqqP8orQdrw0v7gqYuHlBpJN0eM51VQL+W2dQReIMk48VEby7vAyRuZuNAXD2jovMqYapn8oWcbBoMZmyOYBTRne8NvQatX0dX8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:57:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 22:57:24 +0000
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-3-ankur.a.arora@oracle.com>
 <aYymMze6Vchxe6jK@arm.com>
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
Subject: Re: [PATCH v9 02/12] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <aYymMze6Vchxe6jK@arm.com>
Message-ID: <87ecmq99d8.fsf@oracle.com>
Date: Wed, 11 Feb 2026 14:57:23 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 50461840-2542-455f-2567-08de69c0ebba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2ql/S7Rabi5ziZKLNd26etxA4JiwD9cjPIgqtyQmoJ42+KAYSRpxCV4FXwv?=
 =?us-ascii?Q?aJiDSyrhBYhrK6zmIo5Qvy5DZ+IswJkU7F+XqfvZpvhEt6TIqW+xpmWI9und?=
 =?us-ascii?Q?api0TIdzUuPaIL+Fd8HLGIWzuo9THV3OZ4KRNkymiINZYLv2Lls5X2nIO7og?=
 =?us-ascii?Q?p3679WNhemUJ2B+h/CE5cd4D+ImFZ+UJoGXsJBtYkajQ/1VQVg9UqblrGvya?=
 =?us-ascii?Q?peJocnMVNQMRzLSgrcHC34k+oB8aXnDxcUaLMCmZC2NIKH4zZe4kNGlZFLo+?=
 =?us-ascii?Q?Zla+Z+G3zGJbBTu7z0vIoqxo1Ozf2nqW9zOwrb3TMWOSp53QG64KOTqlusrs?=
 =?us-ascii?Q?6lLl++pgud1iV/FANh2Qnt4nNGxlelAUkkmW6jdWXLHdE+WtPQBXfuIXDUln?=
 =?us-ascii?Q?N+w7jeqBaa6n0XVDvTgXgJFVG65IN23mfuVv7bB8+gzAkGnjdAt7HIzQpa1e?=
 =?us-ascii?Q?N+j/jZXUz+Kls0BLuePrURfvgJDKH0vltrfR+eD4tjtM4NZACFnELBW4OsCF?=
 =?us-ascii?Q?R7ylxk5e7st6u+12Z0Gy96YZzOzENYrHOnGd9QS6jp10xASODmGNHJav6J04?=
 =?us-ascii?Q?AsGI66fXqvEkQ4CQUC6bInxsxSXOuwn3CWAu3Prhe3k/w5jg8O9BA95FLWIo?=
 =?us-ascii?Q?XrWeiXY0VbuqK4nFYDj6r1aGH8HNtVgjEJkkcBbZ+4A9/iWPuWJjTLD/3cS0?=
 =?us-ascii?Q?t5MJRK50mINw+T0wwMLLeeHqD1vz/Sw48RK7Dc0padNqpALTkzfH8/TTdfcg?=
 =?us-ascii?Q?w9igkzKxq6Sf7DR5ynLWtyEWeh+9zdtRpBqxBLLTyCjHfNnoSenAVYBXFuzd?=
 =?us-ascii?Q?Flk1ky/iiz9mIuCy2Y4DUrHXiw4hGCuvtV1yNZZSXqOL+YRPx4nOGeBrQjBI?=
 =?us-ascii?Q?OFQ78uwVoZ3LdoTVTM+kDz3WTx/OeT1Y0eSxF5TPT7J//HgkuxW93AHJoTkA?=
 =?us-ascii?Q?CMOHI2rRWyOuhPRFcO+3YXJVg4GkKsz3Bj2X7JM5DD6myD5+Ivv8VfFeOLVc?=
 =?us-ascii?Q?Cuz+mlr3UES9QSqyyrX9N87ast018Fs+gLAATbMUtlc/ZCDbxuwfJfL0/xli?=
 =?us-ascii?Q?WUyO3Pn8zVk/k8uHLsRU1z5qQXRrgu3Gqea6cskTslk+CiOgAYF+7m3399LA?=
 =?us-ascii?Q?pH4aTldU9YnA27igYNc5tkYNG0B4VqvTIZdnYXqfQxekwzY4kUH9WBiUA/jo?=
 =?us-ascii?Q?TA1cYkzp87FMKPkcSwMIrnB3njTi6yA3Lrjtra8Knd7b2FlxVvl0rt4qhdc+?=
 =?us-ascii?Q?j2SG3K4rwXeEoBBKzorj9VFuLz5NGgok7NXAvXHZsWEutEse/K32UvVL7epF?=
 =?us-ascii?Q?cQfEEkyC8Lsy0jNE39XPiACXXRTqK2NWdzxJOgcvJJHIrUTzE/jIpOw/unvi?=
 =?us-ascii?Q?fDuIjNAKbuGIEATni19ljfdpmNhLsKWdxNsQOU92Blp8WRhT+CtiKLbWmq+z?=
 =?us-ascii?Q?v3b7AkotpOJALUYbnfvbZSicYboqZ8lW5GPcsNL64Lt3VOLJkbwV0oFaR5Gb?=
 =?us-ascii?Q?+/Z3ctV7n1AzqOIR7A3lN9YGXITCvnmKiLEfqYAqLhj7wHy9oKpC0IGUfl7u?=
 =?us-ascii?Q?c6OJIidnQctujblmgrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2BT9fBPdBlhcPgJyR32qAy01ajwPXTFc36bzuGMORByuXGdFdG4C027UbPpE?=
 =?us-ascii?Q?QxHmH9mES+hEfx+HYCz9tbEW7po4cw9mZigdcflxiZGjPv7jmqlB2R9SePp9?=
 =?us-ascii?Q?wWR0vWKqstTG1jcJno83tAw9JFNMdQrslukbDVmKPVLYvw7eYm6pj0dl6oFg?=
 =?us-ascii?Q?5WpgVNrc+e9I5U6xMFMMgHK2Ic1m1dvjtrwshpIV+vYrUSGr7xvwp9L/rISI?=
 =?us-ascii?Q?MrULYV0z5GDAXKg0jYI3EsnRxHidxTegM1E/+oIezAhfWg/5CGlaIbKAr6tz?=
 =?us-ascii?Q?rtJn/cpWnpqqrtQueYxk1Zv3+lWnLe8THOwXPDBhkPbKEb+9xqP5qAj4YZBw?=
 =?us-ascii?Q?OtD1G7nwJqPtUfZpStqpnhsElfGe6QaGBIlt52Xse9/wPWftfjiwRtIv85u/?=
 =?us-ascii?Q?XHTX+Jgrkzs9N29w7V6FENWWbCbkg+5Zd1AmMNSxxVW9LFbXXdbQg1qcdWFC?=
 =?us-ascii?Q?/OLfKsb/NkcaAXTH/zjFwciaDmUZo1bf2Qu02CODex5/1CREc+wYQL8a3GPz?=
 =?us-ascii?Q?q2e12XoE1kd3dmMnEUUYjCn7VI+lmgrDCDc12K68loOam2Biv+T1SVw+X10f?=
 =?us-ascii?Q?A/SMgXXmqTamoBvbRCJCL0sIa5YcBjSUzLH1sXHmA5pXOczWnBeToryLWB9R?=
 =?us-ascii?Q?OqFhek/r7sn5Q/JCxzfbG18MkYxL6NycD8gj6Cgks3xk2EoTm2qfL6ztBvyR?=
 =?us-ascii?Q?HB5UwlNPRTO8cI5auQn2zYjJidMjscMF7xC1unUQ+8hNVBd8giuKWYxj9dnU?=
 =?us-ascii?Q?/pHY1ctvrWQd+G8Y3agd7D0eMJK+cTXRhBnarDQ9gW0CJh8jMYLi8kEVfZR6?=
 =?us-ascii?Q?MtgwQ1gLyq4e5yQ5jB4tuQZW6O99RHEizeF7T0Rg8GEaMbafylhGG+Ni2gIo?=
 =?us-ascii?Q?N1q/Ylfc5yh+oiC0HfGgqpxUvzgfaRvqaBXPk/xLM+KTrn9NigI2NZlfS7/Z?=
 =?us-ascii?Q?yZqRFPpWaAvY9HASCI7fUIdSkQxipZhZnbY4cZATQN9D7JYodXbC7D6vPdtV?=
 =?us-ascii?Q?UGFcZngTsFtJmFXxk34OBT1lCrmD7vwKXk8EeefyO4yRo5cLd7v36ilFywio?=
 =?us-ascii?Q?cgFhmLToyGCddFsChv4BntyVlA9xlhxuGy2NEy3YxlwMvAEUbeY2Z1LcsEYS?=
 =?us-ascii?Q?Ob4+mzjsMgz+1mSF7DWLtzAHC82JXFxPv+A9iQLgVk/EzKbb1/PS1uclUhKf?=
 =?us-ascii?Q?HwJfF8sK9HAZlwyzNqtIiKys1O6m/AJ/9xOaX47Y+3YQlfETAxomYXRE1YDq?=
 =?us-ascii?Q?Y+3He7tmZd3hl3CcM7pAuN/bMjuDL4EL69kDx8WB2zxiOB1Md0WQ/Fla9Nx/?=
 =?us-ascii?Q?khARaI1EDm2Dyd5QY+mfcbivdOv/QWWw4CL1D+yM9byyNt+NC+lYAP4LU5Vg?=
 =?us-ascii?Q?WZemC+9fFf37oZc1P2of1uFM9ZXYuhk6DlxQ8y33vV7weLqOdbsIGcR3V4VV?=
 =?us-ascii?Q?I8ITQ1dYXSU1i4p449IHBGvmSQuoc3fwDSgEEZgsRfs9fsxnioem8m/xuvOw?=
 =?us-ascii?Q?YkFoirURmNQYHks7gOFa+e3nk2G6dFKkpQcgE60D7ECCVFkZvOkHZX52sqwl?=
 =?us-ascii?Q?x8deRZ0rCBGFeHDsqtQyGTSAiOQRQOpEUspJuynQIy3pspF/fJOBYAHR5/lN?=
 =?us-ascii?Q?asUxPhgiADgBJ+hnGOaMmt1kwJmLl/6rX1wsqICoLffOV7TAgtBQWj8+TuWC?=
 =?us-ascii?Q?N4T1a8+dtV+qkgN4e2ELQx20gJ0UKaIghUYJY57JmiukfzATJwfJHp54ztWq?=
 =?us-ascii?Q?LsShj8om/VeGJYN0yfYE2AewUP1eTyM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wBiXwWGY68Qm/CDR7ylv2FKu+zc2+mLCaFc1oJ4vOw/GgXmMqwI6TXJ2+DPCnPK06B/Ngui7meG9qcQ9PjKzN/uv8Hl7zKjmccBkdCdF/djcxvxQG+bih1dX58aAeEdPS/5WmdaOczR0rvXEGOXOG3ckRUjxl9rEsukSEo6RS3gNIm9rfhgfxKlJU8RMWXvggeNFE0/2xhsNjHQUI86XsDzoPZxegovedA3aXb3RvTvA/uPXKT/oa5g76RUqpNWKy4QKatJsyxva5FIvVrGmpiF2BE8mXOcztFQuYVpYWgSJdfj0poKy1uKs8FBd8PewFh80wbNYtwJRxmdVDvv0pfQ9mQLFZo9PWrspPIK5+jUMDIl+4F1pIAetF6N+qRWnTT/Lnu+I1uxCYhPZIIcWOVoL4ramTVXtBeefcrF6wJHYz7ktdxjYkY3tJHPoMBnj7G8Fw+oiPMIV100dkjuGpBqC8lcUkufI3cXygoFXm38IDDKAfZDhSJ+p1HbJE8cJcAMfXp+8GsA5E7EytCTrFj+G7vK9qQh1uFWXaE8EANhR9+kfaQeVEd+Mrw8BFLqGfexA7eX6c7qw9KTlxQ5ZhWg9JaKh6A2Hhh4SLITZH/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50461840-2542-455f-2567-08de69c0ebba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:57:24.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/NzyxxNt+Dj6dLqbDBfEr/lDaJkfKdVg2Vbpz4YAcBO3O6Ef6KSyP7c8XSvZjy24tbuE3Yi6EGQ2fvKCizZ/NYXn2sQlYUg5RSc91G2xOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602110177
X-Authority-Analysis: v=2.4 cv=PZbyRyhd c=1 sm=1 tr=0 ts=698d095e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8 a=7mqamtKPcH-GI9Xig8UA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3NyBTYWx0ZWRfX42NW2k82KTh4
 sLWxaAC3OImM9nWSZYjNEHfT22ck706ihe02dbemYdHhxMugvTUbmtehNS/DtzJbW/5F/4wYZbo
 RKL2A+u6YbUcYc6kfI0wt6kaxU/Lp6dTUR66FB5BHM0RJSxOapG9YckWjXmTfoLaviO+uU89ECI
 c2bgrthHIKp7FZSpfaOqeZKEWhKw8wqNMY17pSPZv2mUyM/o25os58qNWhXEeRIAV2pkYXcUtnQ
 Px/JGWhw8olF0FyPEbcBFr02q/wVRzWTAVtkbdJhYUfk0M0D739gn5msKPNbRSKxGS/DR/Oi8kV
 kuvAyaI1HAk0YMhbSCdZrFcQs5o73uxHZXpyalwsUssQukzcJRlNKrSmt8Xno7Ed3x//Wo4R/6N
 Jm3/2sVDGc55Hu+5rNuu4CP05S6DXRlt662SZfR+NIwGyaAXpRTjTLVW13qfoDAEjaNRSx1CUkD
 3OAagvWcrlDSDO6QnMw==
X-Proofpoint-ORIG-GUID: Twk411wjypVN5b4WiJt7VWlPiX8MPxrO
X-Proofpoint-GUID: Twk411wjypVN5b4WiJt7VWlPiX8MPxrO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-42533-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C6423128310
X-Rspamd-Action: no action


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Sun, Feb 08, 2026 at 06:31:43PM -0800, Ankur Arora wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 93173f0a09c7..239fdca8e2cf 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -22,6 +22,7 @@ config ARM64
>>  	select ARCH_HAS_CACHE_LINE_SIZE
>>  	select ARCH_HAS_CC_PLATFORM
>>  	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>> +	select ARCH_HAS_CPU_RELAX
>
> AFAICT, ARCH_HAS_CPU_RELAX is only defined for x86. You can't just
> select it here. Either make the definition global somewhere or add this
> to arm64 Kconfig:
>
> config ARCH_HAS_CPU_RELAX
> 	def_bool y

Ack. I had added config ARCH_HAS_CPU_RELAX in arch/Kconfig
for my test builds but got rid of that when sending out the
series. Will fix.

> Otherwise,
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

--
ankur

