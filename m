Return-Path: <linux-pm+bounces-41194-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGyDM6IPcGlyUwAAu9opvQ
	(envelope-from <linux-pm+bounces-41194-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:28:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FAE4DCC7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2166DB03811
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143D3ECBE6;
	Tue, 20 Jan 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9rvp0cY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kDv2ggsw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2A3382EB;
	Tue, 20 Jan 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949443; cv=fail; b=hUSC0P3706SvIeLs5PkgLPivPwWo87lCz+rl33Y+1D4YcWgP3buT+IOzY8eiYB4ikPj57R3/MlljjObjoaAH1kVjx14QQoa22yCbUA8FM3PkAgpVFt4LEPdY7gGoXgvWKi58El+loVbw6amfA/S6MBEEZWgYYq+wIPEEHyBG5xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949443; c=relaxed/simple;
	bh=m/D2dCJb0Hu4j0IQOSzI4uiwmZJfbVyX9m8f/YLhkXw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=dYqC7Q4GTpUZ7V3L8K6cFIy5CCLwKvanLCdcnlswPq0h8St+X5GslkQyHQ80VkBS7d22zhOztZ/1dlxBAyg7NogW8RIShKfKzryzDoMHuEq5I9r7Jb8AFe7SkoRzCUU70sTmt5iqZcyl6xWAbRVD6fW9t74H3kHlpbXfxKA3y0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O9rvp0cY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kDv2ggsw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KLntC93867731;
	Tue, 20 Jan 2026 22:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zTJgPsn1kHkxdDh5NB
	F6sTa4G43Rf0eY1IBV7xHFeAI=; b=O9rvp0cY6J+mExpbpLpRGevNgmLrpdGJKs
	NLibuVlUYub6yJ7GvzuS2qmcRVBWhV0ZXyilIJYFs7UnslXN1Qjo+UC8JOqzS+NY
	zw+TfpKYWjZeRtrH22D+YJXUpXS7FAoqH40qHSTe5rYnY1rM0dOUsnmWiLFdta7Z
	xdgdXuK++giz52VgXKu0NDOFqm0FLoRYFgn8EvC5OfENgfDGvZqQSUDIL688ldfE
	3LCyzBl+CtLMzf+QF/i1fM1ulWVsoKkVHqHZi8S2QN6XxKlGmudt4zx+RuhdyNv3
	BwPbN0gOwZzHMt4d40veDrT0zbga1oXJfwevUOrVofQYRvYgWqNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd126a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 22:50:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KLan1Q017997;
	Tue, 20 Jan 2026 22:50:05 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vac97e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 22:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8Mgb5WWMsU4AHIYxRmFoKfRMhh+QGoHOK/YOWClxlrhExbfOBAMy9xrk/wSMKB/CdSTkMiWj0PwWNZXWNh9fXosFmsm2w/GePwme4i4P8/lK1282/4AsWVkTw/p4swRrd3DsNwbx8sfmd2e09rNZYn/B+xawSdvH1svjOR590griwX3mtd5T6zl96/hhrAzia6T3B1QtczsvabPEpKC9myeDwTQbUyrIz+Ecqzxr+2m0swzxO5AfUVd33S/wDE63I9M8c7Xu0JWXidRghIr6DwBoiHR3Miqt2fu8w3L2+im0ZUHHVY9hr888XBZ5454z67vgDcqn7PRHx+fSdTJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTJgPsn1kHkxdDh5NBF6sTa4G43Rf0eY1IBV7xHFeAI=;
 b=SSDq9yfw3X2/JHx28orR6QyDa4mYWd+Ho8LbTxMpBYC4ppV/1MbY3sMZ6jdB6B0jlagB6rgN0X1eW25ZxHxmITCA16G/atPVvexPXfK1EtrsG6L+Fkkk9fLJypLAQ4t+D5rEeeB8NaZkHZwjd223ADC+Anc9k1JmGa63Ps5/dogJUH1M4TRkGAWG2OCLt7sObxcFKByMabn4k8T0Iyo5LrReAjAmsfxBKp2jNhF0Wx3NlSwXnICygCY6gJTBBFp8wZZXsShY/EqcEkN239ErApd1P2lysEHRQdjSO3nTA8eafBz0pXfHl07mZdowmzC1uCmXY/sZ1YsgpFi49VGm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTJgPsn1kHkxdDh5NBF6sTa4G43Rf0eY1IBV7xHFeAI=;
 b=kDv2ggsw7iHxIPHj1LxzFANcVkYOcnWVqW/mgIurBdPPWNtuLg6uC8XT3wQRWhEulZhttI/aj4lCdqiQtUg6ENe+YC8+3csbPdZrbH142nE/IsHSOD6Vrb6E1jng+E/UXtyEnA4D9peXZQVLwhn7KUzM+s+AjuwyyDOIYc2gmm4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 20 Jan
 2026 22:50:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 22:50:00 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-5-ankur.a.arora@oracle.com>
 <aWEOALG07jHC_oHC@willie-the-truck> <87wm1qmx90.fsf@oracle.com>
 <aW-KIVQ_H1mVpGHx@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 04/12] arm64: support WFET in smp_cond_relaxed_timeout()
In-reply-to: <aW-KIVQ_H1mVpGHx@willie-the-truck>
Date: Tue, 20 Jan 2026 14:49:58 -0800
Message-ID: <87pl73ew6h.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: df4dabc4-e19d-42fe-9bc6-08de58763dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gKJksktrnN1K+AYpiix0ggpevo3kqekCs7q4D7Mzq/5ZdM6vJmwFVAeVD7s8?=
 =?us-ascii?Q?vheWB9C6xSMe2PtbacYkZVAO/rVWAuCteoPkIFIxynlB3hDJ9cctTXTwflI+?=
 =?us-ascii?Q?BBQT4ac6gR64hxvmazt3yjxHmMsyz30ZqpnCpbG139Bf/nEzvBLK8h5prVzW?=
 =?us-ascii?Q?PVYY9A7WwCn85hdQ27Bavb364CVWSbAD4sn6kWBTV5Kf16MpbuzDtzvVmdxR?=
 =?us-ascii?Q?3X0W0Oo/Fup2lYwM1oVqfrLhPhEFQEf/L6qAW+XrM0OfoWg5fhU/rTjlRp2X?=
 =?us-ascii?Q?XOtrlOhA88QxLK33UOax8JeVCCEMMZNeKV7mv3sR2uCqxnwYtwroIIDBjdcf?=
 =?us-ascii?Q?BgaD4ReCXG9Lc6bgfE2K9MK1YU1UhROrzc/ZA4rfxBSQpjfpm9DDpVWyBXbC?=
 =?us-ascii?Q?R3cV8jXYnjjK45Ac2ScPazyeBIV1fY9TyP3Yl8wE4853LAkQk5WrmxPz7G08?=
 =?us-ascii?Q?IEukKFI03rAP0VfiUfzjb8J4b+46DgHyGQhmr1j3SD+d9GYrjqO+5MQOsTJW?=
 =?us-ascii?Q?as88SzPFxE77i6C2fW06vyUupX0etBm8Kwx1tITn+ttpccvDNp4L7TUYW34P?=
 =?us-ascii?Q?TauhhNmWH0ssd5oVZHVH++M7ISw4mMXpBcjsUO574OQzuraVstZr7Mlzp0NL?=
 =?us-ascii?Q?RDemECgiY+7IghdxmUohg1NAjpxd0D3WctqfAyzc5+hA1nvdDrjTJux3sWVi?=
 =?us-ascii?Q?URGLMqoH26TwGeeOTC/PM1vIuSNUT4pjzjFnkCtbYdLr44pEWLU4ohsCh1O7?=
 =?us-ascii?Q?qSaERqV98R/jnH/hrlpoGo2jWGdGHSS2/JydN7TKMyd991Oa1MRD6o9LPqgd?=
 =?us-ascii?Q?RDOChWoT0Ra8extIJczWXlaxMk0igxXf3xr1GlYO7EG4j/QwNZZkkIpta/rv?=
 =?us-ascii?Q?sGFt9puhravYCcm1ogSGEdDuPeLBHWHUbnB9N/Y79QdV0F2UuZD5PpOj7/Kj?=
 =?us-ascii?Q?+6hCPCXMOfr5dZjR+zYoZhuy5QxEXabUinSdN/gSo9oKZqtHihIccuDFFbcz?=
 =?us-ascii?Q?C2fpu1E4NDzQzXpi7/5F4PiXtR4+atdrNdUUjmJvdQiEJR1v7RmSZfBxsJJG?=
 =?us-ascii?Q?DkqRbZ566/VA3EpAq8TbXhf9+FYcm9zcNriXzlvGxVSje32THW6tF0qhEsSc?=
 =?us-ascii?Q?TnBet1alYa8XFsEHH3JQsDYVW/F2zHlE55xouKBjVxA+StdGSKq3+PLeFRqe?=
 =?us-ascii?Q?vfyYQSQj0qV9ZcnzNK1I1RwCPjQuvZTW6TobnHO0ifBVtHPs3TOP4yOCsll6?=
 =?us-ascii?Q?DQTJDn+RvJ7wWhR3zY6/QfW6OL3uaUqJ05b8GiJUuOxtqGJhLDGiOJgtPASk?=
 =?us-ascii?Q?J7BkXTf6YyosfGtGZrpRoG2jwPdbJCXveMKwtc6/5JSZ50EdZeF49CuARS+N?=
 =?us-ascii?Q?YrM9b+V7M4cdas0YRudOAbtSNDTi+bv3/SBt+h2xwT2YEMGBR8DDvR8VLiIQ?=
 =?us-ascii?Q?XsS+T5Q4eHAjv0/FGJ8osA+xTB34yjmBwYqLgt7wxjuzSrvUmAu5CVv1jWZP?=
 =?us-ascii?Q?L10wLvNBKNM4v9Wu9ht7mQOaDyoZkZXBXCZgKa+fIL0SXfqTmscLCIFmQzzF?=
 =?us-ascii?Q?Hj+fUPJs+zLBMZYqmKlydYaqbomi5ISRa+cRVfV7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NFwEtgArXUzIcFhuwMWzlEoVx1Eg1wXvRGL0KdEb6oosc2RbE/7YvvV3wNHn?=
 =?us-ascii?Q?/81uUKu5cYzmBWMJBa8pXFCDgQiS5EeK7v1lteQ3Zdk+9kOCa8dx+E7OS9+0?=
 =?us-ascii?Q?ySMGx41m08HIYlBwD7bMlZYxYU0480V6+PM1akv0PS12pVZDdbQ0OfYS334Y?=
 =?us-ascii?Q?mh2dc/Z5a/Q/Sf06nNWdc0ogSP2iJUjRNQmdF4ENeR6bTvebDzhj6siZXJBB?=
 =?us-ascii?Q?TBLun620T/4IEqWLitUA2xes1AvpxxA/fQIeBhUJ+WK6JxyAwqKaaAZvv1z9?=
 =?us-ascii?Q?724ARlYPLtH55KGkr6L//sJ2tbQ7IeUJRzvTKr7gqGirzlr0jvDbOI3V6Q1l?=
 =?us-ascii?Q?eozkyYZzpmQGLPo0e0Zav7ZooATP5klU7sKVFbXPCiZPkRVMMyD6ihFTh0uJ?=
 =?us-ascii?Q?M4iGLpG0p+NuEKsebnhuaGGV4GyRWlwFk9NFX13BOgc4fr0NA9gVf11N7t8m?=
 =?us-ascii?Q?wg9pm6/kDZXyHVWXXlwC5JKhqBPBHOcXGk9I9KFii+c7vjEIKWxWxa68nLoa?=
 =?us-ascii?Q?ItVnPUqRnKJutOmGVtBF936L947dMWtN+fB1GUno8dMiHM/Nhz5g0zG1j7yJ?=
 =?us-ascii?Q?v64xDdwYOzTieNmZCzAiAA+Tm3koxegc4abYefxYUBAI6kzY/R6+Z+jY2jrZ?=
 =?us-ascii?Q?uCWr86T8yioNr+Eh1IryXflz01T8K+Yc7rAlezUdxo0t+fOUNzNVk/rb5fxh?=
 =?us-ascii?Q?wLnytrf0+qpbTzgBpFN05QFKimyaNBZbO+4caw95e4MZLqDx8XbuWTSwOxwb?=
 =?us-ascii?Q?RFnQM3dmoq+nkyawP25CsJ0nVmCk7usV7h2eZfN/as5UOz379Nk3ARdYIhR5?=
 =?us-ascii?Q?AMF4C6lkqk8k0XgNeEahJaDnXJuXjbeixwhHh/zLrWyhJ4ZZWSsbg2BiEWCK?=
 =?us-ascii?Q?ggB3L0GtvxDunkVrzLBVP2PoQJtKbsT+ePC9aCccs30x2xVxyAnvEv/jjUP+?=
 =?us-ascii?Q?zHkHt+/Di9UYtlZ418ai/0FgO4MzQ169dYWSr9dRhpIoRARIpq3syvTja+hw?=
 =?us-ascii?Q?2cmhv4BD+rXYvLjdSnqAoNavbkNsNyg3blKfeUtfsRbSegRqD1e49oYplL48?=
 =?us-ascii?Q?yYyU3rI+Lv2IFUymK1DdqTgKrq+UkpxTYmnaasOwN08XEKHnr1wuxSbPNPCI?=
 =?us-ascii?Q?cojp38ZwLUsjqtY600P83rp+EQLuhmCaq2Y7MSd2iyj3vt/P/gDpYNIvpYhD?=
 =?us-ascii?Q?6PrY5gjIF9gIjzJPCLKwNYjTK293S1zYszFm9v81KQxeHSJqdJFgeMhBM774?=
 =?us-ascii?Q?0uqOx2vb+QGWd7XiKx2z4m4MZ8hCozyeTcpGaVnmdDpJYjTCPXjaMbvfd3fu?=
 =?us-ascii?Q?dKBeWsRKj/0MUBVoQqy3i4Szl5g8F3k9ia+2uXFh5p/DyZWXtzK5j1k60N9N?=
 =?us-ascii?Q?C9L4WLlCKpsDZAZQDiKXkDEyRReuNPohHx1Cc/bxM7CNQyNYuUn8BQ2vDChG?=
 =?us-ascii?Q?CkjefEo337YYuIWI3WP07OnW3MN9A90cjsaRdvIU/v8q0KoOqLIiNZWV1KTU?=
 =?us-ascii?Q?cTw8tFim6YF1GnxqE/mDw8Z/AY4QeOPtG19txXc59Acos17mnNwjivTFeYiq?=
 =?us-ascii?Q?vkjlcZb1NTRnbhwDpoyftMU2bDAbgz85WaoACA2aFl2zh8JM3IdJb+VAw8Pl?=
 =?us-ascii?Q?iemvMbwpwFbeooQdHP8uQIQnjzpVRYkdrmHLCXfHSvPhYKUn/OebUH2t5s7f?=
 =?us-ascii?Q?1rLs5W316k9LsbhP9qd50DSI8moVatpyYNxh/vin5GXzQt/Uu2u55ONjNMyj?=
 =?us-ascii?Q?aBnOgCuHQx/TWa28mh2da6qVDwiLlpQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qUALPDhNdrnRe4G8TQRZCmT5l4vPrY5BioudHBiwpULeKBVSqzmcesmtWXTKlVjOnOCXnqzxWdOZOLwzORd4/ops7DcrRaG023Jcei3JaPumFRaPq2uSl/r7+ea6HW+zDSN41zsJU3HVEsFA5n1NZTEv/vf5POpEm4vqBRcBsKG1gzCBWnAXho1wJLaupzw7Jw+u6s9T/syWwXx/r6TYIdr88vdW68jbNouUixeh0DuwqTr7f44Mzb4NjAU+WTSb7y6Z/2hjVvlDLe6+dFu1YGvn8sDE9E2IT0rLZwRz6O00k6FQcaUsaiEIMRUMqSwgawq6ic/u5rk1aAvA/teKqToMqq+jZ5KQPwc4wiDkSYQmEXFWIN5/imOojwSsrVUMbqN+UBd0v3x7kFp1dmCMKwvS9JTWkv3pTrJbPllk7vzOMcgqu9rhcrQndM7sqwE+DeVM6JBSlAZd3v7WAEJm8aycdybbZOLcNZF7nXwsYwV2cfIRyo+1JkuCZfCrAlB/IycrKawMm//BKKQj61jYzVtdgAhmayL6R3KzhxvuoiuKA7vSnuaVJp+jk3tESXGVLbpz/dXCKDHxXhfQynmUEzyZq50FxFg7ZDvyLOezMEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4dabc4-e19d-42fe-9bc6-08de58763dea
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:50:00.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM2u2X4LSks8cQUSWsaxHbkFhXJHQgsGp7st191vFC8LMq5Oy2ReqZdWo5yLBxiwhA3ddzL9RwD0RvL5I03koNtGCr5EQ8wwcvULkq720ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200189
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=6970069e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=kOAIN9rhLAofLr7hKX8A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: oq0irF-KEkM6rEPv0i1WKzQcEaJpXwBo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE4OSBTYWx0ZWRfX+gBZPvD6zYIk
 hrdhmZNobdOFvBv9vKIZ0Dakj9GPruoZvq+x856QOyvvcxGDxjxNYFMj1Skte9uscYYhjtt7FaW
 Vuoj0pN9mDU2znvQSGoZdUwXsK5uBv+wOVl9uaiuvle7plEr/sPntnq2DnBzfLK4fe92Z4bsiSb
 Ti0DVLzsVpZvHy9SgCqMOXYR7Blxcf+IYfVViTobZIL3WGNiomA7c7LPMeaUImP/lzzQWNUM+xR
 4Sn9x9sdAzb7VoM18NaNFd/atrk3MpAMo0C+6vBxk+BpKTDBNxTUCQZAVU0ZL2Aorckm2wXQZFq
 wmrXXakTM8TND6hiGAuNr4GnTRmBpWW8O5CgSGoMQ5CAqOX1bYtlQwLOS4oY0O9F0vFTpeclies
 ZNRprOEqqwyPLANuc3/l5+2gB99iRnOqdwjCyB0SfxZfJI5MthjDM2UoX+NHEWA6eEazdI4ZI7f
 xtJr/e8wMQlbLcI50YA==
X-Proofpoint-GUID: oq0irF-KEkM6rEPv0i1WKzQcEaJpXwBo
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41194-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.infradead.org,arndb.de,arm.com,infradead.org,linux-foundation.org,amazon.com,gentwo.org,kernel.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.onmicrosoft.com:dkim,arndb.de:email,infradead.org:email,arm.com:email,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 43FAE4DCC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Will Deacon <will@kernel.org> writes:

> On Fri, Jan 09, 2026 at 11:05:06AM -0800, Ankur Arora wrote:
>> 
>> Will Deacon <will@kernel.org> writes:
>> 
>> > On Sun, Dec 14, 2025 at 08:49:11PM -0800, Ankur Arora wrote:
>> >> Extend __cmpwait_relaxed() to __cmpwait_relaxed_timeout() which takes
>> >> an additional timeout value in ns.
>> >>
>> >> Lacking WFET, or with zero or negative value of timeout we fallback
>> >> to WFE.
>> >>
>> >> Cc: Arnd Bergmann <arnd@arndb.de>
>> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> >> Cc: Will Deacon <will@kernel.org>
>> >> Cc: linux-arm-kernel@lists.infradead.org
>> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >> ---
>> >>  arch/arm64/include/asm/barrier.h |  8 ++--
>> >>  arch/arm64/include/asm/cmpxchg.h | 72 ++++++++++++++++++++++----------
>> >>  2 files changed, 55 insertions(+), 25 deletions(-)
>> >
>> > Sorry, just spotted something else on this...
>> >
>> >> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> >> index 6190e178db51..fbd71cd4ef4e 100644
>> >> --- a/arch/arm64/include/asm/barrier.h
>> >> +++ b/arch/arm64/include/asm/barrier.h
>> >> @@ -224,8 +224,8 @@ do {									\
>> >>  extern bool arch_timer_evtstrm_available(void);
>> >>
>> >>  /*
>> >> - * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
>> >> - * for the ptr value to change.
>> >> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
>> >> + * __cmpwait_relaxed_timeout() for the ptr value to change.
>> >>   *
>> >>   * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
>> >>   * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
>> >> @@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
>> >>  #define SMP_TIMEOUT_POLL_COUNT	1
>> >>
>> >>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
>> >> -	if (arch_timer_evtstrm_available())				\
>> >> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
>> >> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
>> >> +	else if (arch_timer_evtstrm_available())			\
>> >>  		__cmpwait_relaxed(ptr, val);				\
>> >
>> > Don't you want to make sure that we have the event stream available for
>> > __cmpwait_relaxed_timeout() too? Otherwise, a large timeout is going to
>> > cause problems.
>> 
>> Would that help though? If called from smp_cond_load_relaxed_timeout()
>> then we would wake up and just call __cmpwait_relaxed_timeout() again.
>
> Fair enough, I can see that. Is it worth capping the maximum timeout
> like we do for udelay()?

The DELAY_CONST_MAX thing?

So, I'm not sure your concern is about the overall timeout or timeout
per WFET iteration?

For the overall limit, at least rqspinlock has a pretty large timeout
value (NSEC_PER_SEC/4).

However, it might be a good idea to attach a DELAY_CONST_MAX like limit
when using this interface -- for architectures that do not have an optimized
way of polling/define ARCH_HAS_CPU_RELAX.

(Currently only x86 defines ARCH_HAS_CPU_RELAX but I had a series which
is meant to go after this that renames it to ARCH_HAS_ OPTIMIZED_POLL
and selects it for x86 and arm64 [1].)

But that still might mean that we could have fairly long WFET iterations.
Do you forsee a problem with that?

[1] https://lore.kernel.org/lkml/20250218213337.377987-1-ankur.a.arora@oracle.com/

Thanks
-- 
ankur

