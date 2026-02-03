Return-Path: <linux-pm+bounces-41944-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HWMMiu9gWm7JAMAu9opvQ
	(envelope-from <linux-pm+bounces-41944-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:17:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BC0D6B06
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A812300601B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791B0393DCF;
	Tue,  3 Feb 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EExwphLF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XYRzJn/r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC3232785;
	Tue,  3 Feb 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110245; cv=fail; b=bd1qQnbEaanYUvXXXfSZIkB7wzW9rcJoXK2HWzudeVmUDywgG6+mv07j8AJJwDDudbHNkmwV2/eZXJ2bq7oMvmMuvSSU1ewWNwbumSd5DI7pro5a6DERwN8FSPMnWQt1Ir0K/40aKqwtFQjKM6DLablfaHkpfeH24KzWT5JseAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110245; c=relaxed/simple;
	bh=bYW/JdzDhH90cS10gRrEU/S7RqBjoUGFNdB4ugqYvT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PR8JdW3SZ8/TxG3zaUuzuUr31Ivu7jgRvpzv2zQp3N9iIzKpMVmvl0yfH57TJfMSOclfNgc8wuM+cRmCwH7ybX+0QXr7YxgGxybOBcs/lmPy3GrRKCIj096kQ/Xbm0MsHKcJRy4c2R7FKPD0m02kRAa9CcSf6IiXvoMAz0xIVcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EExwphLF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XYRzJn/r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vHtM3502485;
	Tue, 3 Feb 2026 09:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZbOiC7YY/nNJQgwR3iJkbYt1/b8UCHoclHfI/aVGYSY=; b=
	EExwphLFeSV9KIQ43juiHDBuHz9UEO7KsMTd5mDRXEWYiptAvKErIopicR7+zDRB
	+aNt3JbtCHFqFUxr2bdgbpds9sqZmRb9HW+4sOXRNVD5hcm2/zBkpPz8ORGq+1rT
	BkX0dT0u3wYIyTljLRTeJky0WYH+UAY0nVIT7K2QfsIfzlLo6cbR4CcIkN0vUVL9
	7XaTaDfrfhAK1tpJL2fbX478hPXYovGsKpeiXcx4AHcqzSyOYOTl4w4rJTaFJbYn
	fFmiL5otM9CTTKHr/B4GgzIiRFMWOaTnXlkPhFC9beNv33sDQM4FsZ/D/DAK5pZK
	zJ/FCVLahrA6Cmk26yNIRg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1avj3qkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 09:17:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6138nKkk001253;
	Tue, 3 Feb 2026 09:17:08 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1869k8tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 09:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLgtmiJAG6J6eGGw9vLI6a1MMZChf1j4OkMrDxlJfzUziKDu7yecIeb4WA1mbOgP6v5SZtQRpx2spEuJDQBEIGiR92dAw7a1RHtdZ6l+soyixzRa+RrGpPNRg+Cdzo5hFY23ddLgA9ocZAKWMBl38n8Su9vIaG4uTGqQtzhfBXuUvyjcM5dpDjmoUjAxt4fwtUY56jem/SQwd1s4A8m6ssxGtu36TjZb7hoky8inVaEdtU/ffpx9Z7Pf3MUjrLr/hZCEFLPRQUNQJucegn7lNBL5eXzq/QbvDeekuEP2e9ZUbHxgzLJ4F9L3/YnS0ge+fv45ggW2iTvhD3mClUzhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbOiC7YY/nNJQgwR3iJkbYt1/b8UCHoclHfI/aVGYSY=;
 b=LfgtEPX8pJ6/w2UmkyfuVnpokeKjL4F2Mm4GaNC4lk36q+1MeilRAwO2qtt7SA5AtHtszreE+DcBX7kR2xCBg4YqkI9Gzus1UY9oq9odcAAn5iKeyUldo4biKvGzodBc9PAk/DMZXOJ5QhxhNGIT+101dXO5Bi4xdGEx3inDv8lBHVaKmvTL4fC6PAE20hsVH/4umXQuzbMI/NiKNOdRkFQf6oZylnGKeMfHTjkXXS1RMsHPhyW4aNq+CkiWcjJnEVx4EHzNi1pVQKJNJbI4EtQMLNPFYvYz0pm3SlYenN7Nj0gSjZexYkB0RBO167aJIk56Sfd50yJDLOjR3RDeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbOiC7YY/nNJQgwR3iJkbYt1/b8UCHoclHfI/aVGYSY=;
 b=XYRzJn/r9H1eBsiKmID4gtJsu/mu0wIdLAbALlmLJmkd13QWhQuSy9RQ8cuXxF4VEPP5tdJQ3AUlDgpRw06/PXqU32Ioc7C/cS2d/mAeO930JtE81i/1dSMwptXflvTJpbVgBsrgQ+9eJLSm++TR/pmhKMx2gyRPXME2J+p9tIA=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SN7PR10MB6308.namprd10.prod.outlook.com (2603:10b6:806:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:17:05 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 09:17:05 +0000
Message-ID: <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
Date: Tue, 3 Feb 2026 14:46:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc: Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com>
 <003e01dc9013$e3bc5060$ab34f120$@telus.net>
 <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net>
 <002601dc916e$6acbe650$4063b2f0$@telus.net>
 <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
 <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
 <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SN7PR10MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: e75a9cbc-fa45-4d45-b7d6-08de6304ff5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXFickZ6cjhpVVN0Qkl4TXRJeGlzK0pRcnhFSzVia1BoRUR2YkdJRkRyektz?=
 =?utf-8?B?UWtkRlFpRFdiaVlROXNPNzB4SUJjRVp0YXRKU2xIVkVlS2xoQ09jWTRJTVk4?=
 =?utf-8?B?cUJFT2RhK2xDNEsvbGRRM3ZRYm5PNjA4N2NYZnlpYlUxdjBHRTZVZEtVMStC?=
 =?utf-8?B?T21UWVlrbzVDNFBvVU1oVEp3bTFBU1g3OGNIcFg5SFIvZWtiL1dPK0l0eG1T?=
 =?utf-8?B?MGZMVng4eDZNQk45TE44N01yWmo4UC9ERHd4ZkZncDJ0WFdRNW4zVkRQUTdx?=
 =?utf-8?B?Yk1WTHhtUmdzV21oNjJUaDF0ZVVNVU1wb0xMV0dFWGVFM0w1NDRqOFFGNWtT?=
 =?utf-8?B?Z2dEOXkyNnR3cS8rbnA1ZEt2N25aN3B4eGFwSU5zVE1ScUlQQTFQZ2RydmVm?=
 =?utf-8?B?Q3J5Wm5JUE9ZaHJVeVA2STlQVXFWeThvT3JsUm5wcjNxNnBLdzduR2dKUkox?=
 =?utf-8?B?ZTM5UkJlRStvK0JvQlFMa1drLzgzdHZ2VVNuUUNBTDFkK0pMYTFzaTVaTmdw?=
 =?utf-8?B?cEFORXU1V2syMFBMTjNFVjgwV1RFWVUwKzY5REtnVjJuUU9EZXIxbDBRZ0RF?=
 =?utf-8?B?MTV2RUM2MnNYbDM2VG5Xd2YveFFKL1BCLzlNbmlRUnlBenFuSjNVOEliSXA1?=
 =?utf-8?B?SVFReXlSMjNXaVp1alM5Y3hIa0tTeVdKZkRVNU9vTFlrazRWS050MitlaWhH?=
 =?utf-8?B?WVBBa2JuK253QnA0SmFQRVZqcmdJTHB4c1M1TkllclgwL1lVZmhlL3RYdWNO?=
 =?utf-8?B?TGI2czhCZlI0TWJzVm1LY0xHOVlmQ3NoWVplYUpsdDd0UU9GbTU1bmxGSmd6?=
 =?utf-8?B?TkFyZ25ENld5VmJaN1B4THM1ZHcyWGNUWlpWUmpvd2hhSlV4R3FNVmtrU0ZT?=
 =?utf-8?B?anpyRlQ3Y3lscDB0VlNJN3dHbEF6UCtZT2FDVjl2cUwvd0ovVFFnbmxFUm1C?=
 =?utf-8?B?ODRPSFBkL0FJMTV1Q2QxdERBTWdVdG1IYkg5L0MwQzhFOFR4MG52ZWZzYnc2?=
 =?utf-8?B?RlpFYmhEZVJnOUU4dHUreGxWWHI2enVKemV3U3lKSkszSFhmNEFCM0tEWWpB?=
 =?utf-8?B?eVJUcTRXMWlrQ0pNbmxPVnZXM1ZhMjFoU3pzanlGVGZYcW43YTdselo5bjQ1?=
 =?utf-8?B?VGlYck9RVG1lR1ZmMkZmcEpPY2laNVJRcjk1MGdWeWE0eHVwVnhNMGtFaFEx?=
 =?utf-8?B?bjRVZXpzVTBscHhmRG9OTElPRTVYSmRoL2daMEE1c1h1Q1RNUng2ZHlGVGp0?=
 =?utf-8?B?bWxsSnp1SnJveTE5L3F6anpIV2JEVlY1OFVYWFppS2txN1JSVWdlNng5cmtx?=
 =?utf-8?B?L1NiUmpBVXNVQXkxdTVET1Y2YVFBdzNnZTQzMzlYbm8xeHlLZzVKaGdkZEs3?=
 =?utf-8?B?SlFCM0NWNit5MENwWkl0V2I3aTNEVmg0TnI5b2t4clh2dDlPMUYyVU82RWQ2?=
 =?utf-8?B?OVYrNjF0a2g0ck1tWUVVc0JiOE9FOTRocWd3MEtvOTRMaU12Q1FtMHhwMVNv?=
 =?utf-8?B?MTFHdHlyMWJPNVBDd1RCakFGTFp5K2Q4bnJROXZISWVpemR6d1Q4R2ZsSmRQ?=
 =?utf-8?B?K3FKNENzV09YZEZKbjFiNUplN2VVMCs0S0xwZ3FPRExtdjEvRGVJVDRld0dr?=
 =?utf-8?B?NDcxR0l1Zm9tYUJvY3puUUFzQmhUWHJZd1FuYWM4MFBFUmNMU0hRU0dIOHZD?=
 =?utf-8?B?UDV6Z2crVFliUUFCcm9abmZVdjBZY1RYb1Q0cjFIaEVicnEzQkh1UkxtQ3ZF?=
 =?utf-8?B?anExT0MyY0orRWY1ZkpQOUJJWW9LSnRwUGxSdUVIbWhack1wL05HZ2pzcXky?=
 =?utf-8?B?RjI5dWFPY0RvZmdEV2plS1FZQzB5ak5Wbnc1c25FcEJ5Zk56YnhSRmswQndn?=
 =?utf-8?B?MC9GTEdLN1NvSlJwbGZKT0hZOUxvRVRhV1BDb3hiVDdrQ1MzendneWtrcW1z?=
 =?utf-8?B?VzRObW0yYzkxVGxXRVNtV2RwS24rK0lHdlpMSWxaekFySVFqbVZiM21ZODFs?=
 =?utf-8?B?cmdiYmhUaDMvdVE0UUJYODNGTWhuQmdvVjBOTUtld3N4QmJZc1VESHBZa2VJ?=
 =?utf-8?B?RERSN1IwSlN6UHkxeEFTTy9LVVlUcFZuZGpTRDdzdEo0dHZ1SnpiVmdheHFE?=
 =?utf-8?Q?S08mKUpAOxteokuSTmTcU4mLg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDYwZ1c2bzBLdk05Tk9ET2ZmMkNKN3MrTlQwdktrS0pwbkFlRDlGb1FpTFJu?=
 =?utf-8?B?Z1J6MjFSdVIybVhFOWhKcmZ4RlI4N2Z5WW5FbFY5aHEvSCthdFM1VFJEMkti?=
 =?utf-8?B?NXNQSFpraW9YT3lENXhIeWlFZVJwd2dnWStJVkJ3NWxQSVZ6SUNTRk11eXBi?=
 =?utf-8?B?VU5OQ3orMWx4cnZTcTVzWE1wSXZMcWZFRi9LTktPeUtHMllEc3o0TGx1dnNG?=
 =?utf-8?B?UmlUTWI1WjdTMEE3dm9MRGxOMGdrS2FmTGRLS2xPMUJFOEdVR3Q1OGlDUjF3?=
 =?utf-8?B?VTI5Ty9jNzJVYnc3b0xWeWFFUEpuQjNLbEhJUnhUbWxFanM5dDZiZ2IwOUcv?=
 =?utf-8?B?MThWb0hzUy9KUWxVa3VNQUcxeGtCb0NhM0M0ODdZY0IyejZDS1lMQ2Z5UWxF?=
 =?utf-8?B?OWpOT2dpcDI1UFZLa0FpdWJEK1ppMERjSTNLVUREblp6OG1DZHlPS0RVQU0z?=
 =?utf-8?B?RlNsaUhaQnAvb2NOWFpKVnZ0a0haOWNCcTVqTlM5UkE5N1JNYTZMTlRkNDVF?=
 =?utf-8?B?Q2czcWExMkQvWWdGcUM4STlaZ3luODVjL1BVNFQyK1hSUm5aWHM5T0dBZVdx?=
 =?utf-8?B?cVRzU1VYNkpOenRNZWV4K1V5eWtqT1F1TTBYMFB2KzZFamxMdWhQZ0tlNzg3?=
 =?utf-8?B?YkhJUzlaczhTbFFtWUxSZ21VbDRkMnBkTXZjZVZhSDdVVE55eVEyc3RseGZx?=
 =?utf-8?B?U0llb3JON084L0VlRklDSUJqNjFtUUV6a0tMNDZCbVpmSjVrVHJwcmVGektY?=
 =?utf-8?B?TzVoNFJUcHo0SzBiSm1qMnU4RU1tQ0hVL2VmYmxKcUsrVjBuazc4QlNGNU1P?=
 =?utf-8?B?ekpEbnByKzQ3cCtWaTZ6amhoazZqT2F6MTArNVhWMnhYZzlzMWR6cXJ0S2JB?=
 =?utf-8?B?OSt5WlV5aVh3ZkNMVGtyNWdCcjRhQ1RmUlQ4OEVCbFFieDEvamVFRUVsK1ox?=
 =?utf-8?B?eWhzUUZXUXdKYkxTVjZ6YytXem5LTklHQ2RJVnBzVlRlZzB4TXNCWE91VEFG?=
 =?utf-8?B?SWhoRE5MTElhaC9VeW9TQXBHUzFGRjN3WlBCMCtlWFY1b3ZrYnJFSnl0SmJW?=
 =?utf-8?B?ZG5ENERkUHdYY1hMRDFVM3F2Z1liVkRpeWo0SFNpSHpUQnRKS1U5WXZBNTVF?=
 =?utf-8?B?bEZ6aGY2TnlQZERDNlhKclFwK2hGYlQ1RmR3eXpnemFVTFptOVJFd0ZLUERN?=
 =?utf-8?B?aE54Zmg2Tng1WmhUWDFsNGlUM2N6REduZlY1cWFMMlk0djhKZEpFKzdIejNm?=
 =?utf-8?B?K0U2UWtwY3BKajBPZ25JNit1b2FRZHZzMWZhZy91UlJsNFQ2dGhCZHptRmlP?=
 =?utf-8?B?aUV4UFg3ajFEZGYvT0hPRGFXVjBuYXowTU44dk5rR0YrdXR0Z1A1aDRMcE02?=
 =?utf-8?B?dDJZV1EwV1IxejZlK3I1clV0cWxxd1FqbUFBZU9kZzBmRmpNcTNIaTAvY1FZ?=
 =?utf-8?B?T20xdFZHVUlOVmtndFJuK2x0RDVtc3NBSTU1TTJRaHZXMWNTbWxUWTkzUVFI?=
 =?utf-8?B?eUFaa3N4OHlLalh6SGxIakY2OEVJR2R1VjladEJtK3JLZXA3NXB6cEJwRGw0?=
 =?utf-8?B?UFBlMWVGYWtHREttRlY5SGwyTXdNOXo4bURzYzMyNnNzeWR6UldzNU1EQk1w?=
 =?utf-8?B?aUV4WHoydGt1WDNvSXo3SVZoTlRkU0k0eENScG5KTWxFK0ZpQ3krZEErNzdm?=
 =?utf-8?B?Q0paOXhuM0JuT3lZbnF3WFBPandyMFBDeEZiNFhrL3d5THhXN0xxRjhZM2g0?=
 =?utf-8?B?T1k2TGdXa0hadGNpWlNQbGZNMmlMdkU1SnlTQi9pZ2Z0d0MzRExlbVZVc1hR?=
 =?utf-8?B?WHI3VzIrQktJYXBMMVYvSFFRZW9nWTRWMWY3SWFuWjJpaDdtVW90eFNZR3Bo?=
 =?utf-8?B?ZVRaemxCRXJZWWZZQWdvaXp1T29oTGo1RVdvakJOS0NmVkcySTl0aXZRRWpm?=
 =?utf-8?B?b01JMVJPMEwwTCsyOVVsVVFjMjFjbUZpYXkwRE1heUxXZGlXUGt4c1lIV3pZ?=
 =?utf-8?B?UkxmR2Jyc01zcWFTb2xQZmdiS0pBU0VaOEFFdXlBUjEvWGpaVmxIQWlrZWpw?=
 =?utf-8?B?aHR3T2FkQTdoaU45QndibUVHdEs1WFBneDdJV2NtSTgzRjYvVWRIY01FeUV6?=
 =?utf-8?B?aXZhcVhNYk1GRjlhNG1aZHNBR1lERm8vTjM2b3p1N2RNSVRpSEx2cytnRnM0?=
 =?utf-8?B?YXhXN1M5ZllMTHRWK2dsWUFCalJReEJhM0hIVGhTczRjcGRyMVNZWE15T1Rt?=
 =?utf-8?B?VzlxRVM1eWhlVy9Ed3lqdEZnTEZKdWxqK2JTcWlHWGlKQjVKSjdscXcwQWMw?=
 =?utf-8?B?UE0vRkc3YWlqdlExdUZEd1dBMXdWNnp4cUp2UjlxZmQ1QUNwdkUybUZoZnpZ?=
 =?utf-8?Q?N0c8yBpfL/m1jFPZ+Tlhnt0acnetQXKbVyIQtmhynagxW?=
X-MS-Exchange-AntiSpam-MessageData-1: b1l0J/Uc6ZEjHdDjdBd3ev5+OE05Xnn44no=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tgFC/lX4CPW1ArZi1CmxagehKQDI7bSOtzS5JESpvwCrUFy4xdJMDgSuGj4SX2DNtqF5KeFJt75dsq+NUgjcviRNft8gAJyhlEZ2fQjCt19fcIV5Y2qwf8IdBgBU7GvaF0gl3nmwKjNdw+OSlYMso/QV99LCjuRWO2b9Zm6gtnqdQHxXrkBrUPJJTWv4jsQ09soa0SSflPfsdsspXonbfk7em2ojOn0h0v8dLf/FD6Z5gBTL06ZjAKC43rA//7gLx3w0B/EKn+s7g+Fa6WZMFtIXRLyuqlfnYq97cHrJSTgQfrQ5rXQP99224PzAbTb8iiXd9RLiBE1WLnruB2SOUqKRou1UC+ixIEVBVYL6xbAeaMp8VOUnXlJX1W5xHLym9yd0/IUse1wC7cPgLW5JbLfV6V31vKpiRMTxmX69P5kpi409RZEJ90yAqsUMgjeCs+kq3co1c15ZG4WamzVyx0BglN1AgAG3DvW0dhx9T5wFOvgjod08yVrVakv6iAui20Ka5AGtWdGOSyfUnHUdRPDftxQCAMpQqJ4Q5td5teZ5UqB/nAjAkB1qxajbO0swwfg08v1a+aw89OTluYH+NkaAo9Nl2Q6r+ys71DwNHHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75a9cbc-fa45-4d45-b7d6-08de6304ff5b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 09:17:05.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7ZWO4hfBKruy7AWMYDHKVP0lu5NBaghGBUHConZDA8FulCLETanveImezsBz29BxQuz7vofKc4tlgH98Wm/rfKYEP9HW2YCAo7oiltgbkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602030073
X-Authority-Analysis: v=2.4 cv=C5DkCAP+ c=1 sm=1 tr=0 ts=6981bd15 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=aatUQebYAAAA:8 a=8C0noBWm-XruWOSc3mcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=7715FyvI7WU-l6oqrZBK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA3MyBTYWx0ZWRfX1zKaJ0BZlH4j
 Z6Ujczxllx0y1LTT2DbArtMtidDBSR88XZpY5q2Wj2mv5bv6VR7+/Mce7+ghgejk5zn2LffpSNh
 pMWQhgVrylWikcCIoKsYlu0se1Gxp5BqJTDLuDzpl40HWvu0IG5EZTJP/euHcjkyFwtY8y5XxFq
 e4PhghviKYpNdPJdAWOqfRNv5Z1r8GEndgPXEOKyoRojV7mhsSr1hw0dNCNfCmUbLfsKNVFkWAS
 YHyvCH4XWGW/cn9TiIC6squS2+NoqgJZEBPreX/2CwjcPPBYYmLxqNO7B0EZZlhudz7p9SdkrHJ
 ikpCj8hZI9/Ad2XME5p8pLpqkMijkOhz5zoBjGZfSY3rVUoaCGAphOdJgHo8h5n0I8wUixxpBQ+
 US9i13hWZOtYyHPcIjr3aq/MIacdM94Yme00AX0LxRxaL/dLXR9+aaZHgTgxfChV+GCnNcs0lvV
 gSVeVf8zKyCa7v0AFlQ==
X-Proofpoint-GUID: mp_xip1YxJJiPWLI-HByP-gBbNfAW5E6
X-Proofpoint-ORIG-GUID: mp_xip1YxJJiPWLI-HByP-gBbNfAW5E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41944-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,urldefense.com:url];
	REDIRECTOR_URL(0.00)[urldefense.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshvardhan.j.jha@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F0BC0D6B06
X-Rspamd-Action: no action


On 03/02/26 2:37 PM, Christian Loehle wrote:
> On 2/2/26 17:31, Harshvardhan Jha wrote:
>> On 02/02/26 12:50 AM, Christian Loehle wrote:
>>> On 1/30/26 19:28, Rafael J. Wysocki wrote:
>>>> On Thu, Jan 29, 2026 at 11:27 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>>> On 2026.01.28 15:53 Doug Smythies wrote:
>>>>>> On 2026.01.27 21:07 Doug Smythies wrote:
>>>>>>> On 2026.01.27 07:45 Harshvardhan Jha wrote:
>>>>>>>> On 08/12/25 6:17 PM, Christian Loehle wrote:
>>>>>>>>> On 12/8/25 11:33, Harshvardhan Jha wrote:
>>>>>>>>>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>>>>>>>>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>>>>>>>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>>>> ... snip ...
>>>>>>
>>>>>>>>> It would be nice to get the idle states here, ideally how the states' usage changed
>>>>>>>>> from base to revert.
>>>>>>>>> The mentioned thread did this and should show how it can be done, but a dump of
>>>>>>>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>>>>>>>>> before and after the workload is usually fine to work with:
>>>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPpMt53$
>>>>>>>> Apologies for the late reply, I'm attaching a tar ball which has the cpu
>>>>>>>> states for the test suites before and after tests. The folders with the
>>>>>>>> name of the test contain two folders good-kernel and bad-kernel
>>>>>>>> containing two files having the before and after states. Please note
>>>>>>>> that different machines were used for different test suites due to
>>>>>>>> compatibility reasons. The jbb test was run using containers.
>>>>>> Please provide the results of the test runs that were done for
>>>>>> the supplied before and after idle data.
>>>>>> In particular, what is the "fio" test and it results. Its idle data is not very revealing.
>>>>>> Is it a test I can run on my test computer?
>>>>> I see that I have fio installed on my test computer.
>>>>>
>>>>>>> It is a considerable amount of work to manually extract and summarize the data.
>>>>>>> I have only done it for the phoronix-sqlite data.
>>>>>> I have done the rest now, see below.
>>>>>> I have also attached the results, in case the formatting gets screwed up.
>>>>>>
>>>>>>> There seems to be 40 CPUs, 5 idle states, with idle state 3 defaulting to disabled.
>>>>>>> I remember seeing a Linux-pm email about why but couldn't find it just now.
>>>>>>> Summary (also attached as a PNG file, in case the formatting gets messed up):
>>>>>>> The total idle entries (usage)  and time seem low to me, which is why the ???.
>>>>>>>
>>>>>>> phoronix-sqlite
>>>>>>>      Good Kernel: Time between samples 4 seconds (estimated and ???)
>>>>>>>              Usage   Above   Below   Above   Below
>>>>>>> state 0      220     0       218     0.00%   99.09%
>>>>>>> state 1      70212   5213    34602   7.42%   49.28%
>>>>>>> state 2      30273   5237    1806    17.30%  5.97%
>>>>>>> state 3      0       0       0       0.00%   0.00%
>>>>>>> state 4      11824   2120    0       17.93%  0.00%
>>>>>>>
>>>>>>> total                112529  12570   36626   43.72%   <<< Misses %
>>>>>>>
>>>>>>>      Bad Kernel: Time between samples 3.8 seconds (estimated and ???)
>>>>>>>              Usage   Above   Below   Above   Below
>>>>>>> state 0      262     0       260     0.00%   99.24%
>>>>>>> state 1      62751   3985    35588   6.35%   56.71%
>>>>>>> state 2      24941   7896    1433    31.66%  5.75%
>>>>>>> state 3      0       0       0       0.00%   0.00%
>>>>>>> state 4      24489   11543   0       47.14%  0.00%
>>>>>>>
>>>>>>> total                112443  23424   37281   53.99%   <<< Misses %
>>>>>>>
>>>>>>> Observe 2X use of idle state 4 for the "Bad Kernel"
>>>>>>>
>>>>>>> I have a template now, and can summarize the other 40 CPU data
>>>>>>> faster, but I would have to rework the template for the 56 CPU data,
>>>>>>> and is it a 64 CPU data set at 4 idle states per CPU?
>>>>>> jbb: 40 CPU's; 5 idle states, with idle state 3 defaulting to disabled.
>>>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>>>
>>>>>>       Good Kernel: Time between samples > 2 hours (estimated)
>>>>>>       Usage           Above           Below           Above   Below
>>>>>> state 0       297550          0               296084          0.00%   99.51%
>>>>>> state 1       8062854 341043          4962635 4.23%   61.55%
>>>>>> state 2       56708358        12688379        6252051 22.37%  11.02%
>>>>>> state 3       0               0               0               0.00%   0.00%
>>>>>> state 4       54624476        15868752        0               29.05%  0.00%
>>>>>>
>>>>>> total 119693238       28898174        11510770        33.76%  <<< Misses
>>>>>>
>>>>>>       Bad Kernel: Time between samples > 2 hours (estimated)
>>>>>>       Usage           Above           Below           Above   Below
>>>>>> state 0       90715           0               75134           0.00%   82.82%
>>>>>> state 1       8878738 312970          6082180 3.52%   68.50%
>>>>>> state 2       12048728        2576251 603316          21.38%  5.01%
>>>>>> state 3       0               0               0               0.00%   0.00%
>>>>>> state 4       85999424        44723273        0               52.00%  0.00%
>>>>>>
>>>>>> total 107017605       47612494        6760630 50.81%  <<< Misses
>>>>>>
>>>>>> As with the previous test, observe 1.6X use of idle state 4 for the "Bad Kernel"
>>>>>>
>>>>>> fio: 64 CPUs; 4 idle states; POLL, C1, C1E, C6.
>>>>>>
>>>>>> fio
>>>>>>       Good Kernel: Time between samples ~ 1 minute (estimated)
>>>>>>       Usage           Above   Below   Above   Below
>>>>>> state 0       3822            0       3818    0.00%   99.90%
>>>>>> state 1       148640          4406    68956   2.96%   46.39%
>>>>>> state 2       593455          45344   105675  7.64%   17.81%
>>>>>> state 3       3209648 807014  0       25.14%  0.00%
>>>>>>
>>>>>> total 3955565 856764  178449  26.17%  <<< Misses
>>>>>>
>>>>>>       Bad Kernel: Time between samples ~ 1 minute (estimated)
>>>>>>       Usage           Above   Below   Above   Below
>>>>>> state 0       916             0       756     0.00%   82.53%
>>>>>> state 1       80230           2028    42791   2.53%   53.34%
>>>>>> state 2       59231           6888    6791    11.63%  11.47%
>>>>>> state 3       2455784 564797  0       23.00%  0.00%
>>>>>>
>>>>>> total 2596161 573713  50338   24.04%  <<< Misses
>>>>>>
>>>>>> It is not clear why the number of idle entries differs so much
>>>>>> between the tests, but there is a bit of a different distribution
>>>>>> of the workload among the CPUs.
>>>>>>
>>>>>> rds-stress: 56 CPUs; 5 idle states, with idle state 3 defaulting to disabled.
>>>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>>>
>>>>>> rds-stress-test
>>>>>>       Good Kernel: Time between samples ~70 Seconds (estimated)
>>>>>>       Usage   Above   Below   Above   Below
>>>>>> state 0       1561    0       1435    0.00%   91.93%
>>>>>> state 1       13855   899     2410    6.49%   17.39%
>>>>>> state 2       467998  139254  23679   29.76%  5.06%
>>>>>> state 3       0       0       0       0.00%   0.00%
>>>>>> state 4       213132  107417  0       50.40%  0.00%
>>>>>>
>>>>>> total 696546  247570  27524   39.49%  <<< Misses
>>>>>>
>>>>>>       Bad Kernel: Time between samples ~ 70 Seconds (estimated)
>>>>>>       Usage   Above   Below   Above   Below
>>>>>> state 0       231     0       231     0.00%   100.00%
>>>>>> state 1       5413    266     1186    4.91%   21.91%
>>>>>> state 2       54365   719     3789    1.32%   6.97%
>>>>>> state 3       0       0       0       0.00%   0.00%
>>>>>> state 4       267055  148327  0       55.54%  0.00%
>>>>>>
>>>>>> total 327064  149312  5206    47.24%  <<< Misses
>>>>>>
>>>>>> Again, differing numbers of idle entries between tests.
>>>>>> This time the load distribution between CPUs is more
>>>>>> obvious. In the "Bad" case most work is done on 2 or 3 CPU's.
>>>>>> In the "Good" case the work is distributed over more CPUs.
>>>>>> I assume without proof, that the scheduler is deciding not to migrate
>>>>>> the next bit of work to another CPU in the one case verses the other.
>>>>> The above is incorrect. The CPUs involved between the "Good"
>>>>> and "Bad" tests are very similar, mainly 2 CPUs with a little of
>>>>> a 3rd and 4th. See the attached graph for more detail / clarity.
>>>>>
>>>>> All of the tests show higher usage of shallower idle states with
>>>>> the "Good" verses the "Bad", which was the expectation of the
>>>>> original patch, as has been mentioned a few times in the emails.
>>>>>
>>>>> My input is to revert the reversion.
>>>> OK, noted, thanks!
>>>>
>>>> Christian, what do you think?
>>> I've attached readable diffs of the values provided the tldr is:
>>>
>>> +--------------------+-----------+-----------+
>>> | Workload           | Δ above % | Δ below % |
>>> +--------------------+-----------+-----------+
>>> | fio                |  -10.11   |  +2.36    |
>>> | rds-stress-test    |   -0.44   |  +2.57    |
>>> | jbb                |  -20.35   |  +3.30    |
>>> | phoronix-sqlite    |   -9.66   |  -0.61    |
>>> +--------------------+-----------+-----------+
>>>
>>> I think the overall trend however is clear, the commit
>>> 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
>>> improved menu on many systems and workloads, I'd dare to say most.
>>>
>>> Even on the reported regression introduced by it, the cpuidle governor
>>> performed better on paper, system metrics regressed because other
>>> CPUs' P-states weren't available due to being in a shallower state.
>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!KSEGRBOHs7E_E4fRenT3y3MovrhDewsTY-E4lu1JCX0Py-r4GiEJefoLfcHrummpmvmeO_vp1beh-OO_MYxG9xLU0BuBunAS$ 
>>> (+CC Sergey)
>>> It could be argued that this is a limitation of a per-CPU cpuidle
>>> governor and a more holistic approach would be needed for that platform
>>> (i.e. power/thermal-budget-sharing-CPUs want to use higher P-states,
>>> skew towards deeper cpuidle states).
>>>
>>> I also think that the change made sense, for small residency values
>>> with a bit of random noise mixed in, performing the same statistical
>>> test doesn't seem sensible, the short intervals will look noisier.
>>>
>>> So options are:
>>> 1. Revert revert on mainline+stable
>>> 2. Revert revert on mainline only
>>> 3. Keep revert, miss out on the improvement for many.
>>> 4. Revert only when we have a good solution for the platforms like
>>> Sergey's.
>>>
>>> I'd lean towards 2 because 4 won't be easy, unless of course a minor
>>> hack like playing with the deep idle state residency values would
>>> be enough to mitigate.
>> Wouldn't it be better to choose option 1 as reverting the revert has
>> even more pronounced improvements on older kernels? I've tested this on
>> 6.12, 5.15 and 5.4 stable based kernels and found massive improvements.
>> Since the revert has optimizations present only in Jasper Lake Systems
>> which is new, isn't reverting the revert more relevant on stable
>> kernels? It's more likely that older hardware runs older kernels than
>> newer hardware although not always necessary imo.
>>
> FWIW Jasper Lake seems to be supported from 5.6 on, see
> b2d32af0bff4 ("x86/cpu: Add Jasper Lake to Intel family")

Oh I see, but shouldn't avoiding regressions on established platforms be
a priority over further optimizing for specific newer platforms like
Jasper Lake?


