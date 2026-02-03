Return-Path: <linux-pm+bounces-41951-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFqjFZLMgWl1JwMAu9opvQ
	(envelope-from <linux-pm+bounces-41951-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 11:23:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A3D7868
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 11:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5CE7301DDA8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D98314D13;
	Tue,  3 Feb 2026 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kwWOg3GF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENT5i3Pd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D4314A79;
	Tue,  3 Feb 2026 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114190; cv=fail; b=A9WpsIEZterhOwnmheQJRY5aUdLbm2WqqyYl9U/iy5eZ0drGvxmSNyKE8ohgsrq1hz4A4g0O7XTiWj+5VKT2UbPekdhzVT1WCsoaPaAWAXfAr2I++L9tdlcFT+ky8bx7WIMygwN71mn1TiJlLuG589qEGnUq1g8C8bnFAesBars=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114190; c=relaxed/simple;
	bh=pxmAIUPEgVgllxINPl8io71iLVra0zNpXp+8WFE7W/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FK7y6umV7uNHnZBbDhiYje1SUYmGKHnBIquO9H+q3Dkw7b+Vm/ki6pO6uI/S6EKQ4VKPhGtVzeLJItjinrQ4ImM5vuv3FnvpFqcWplopiptA9EFH+TjFTAszfWXXw6fW6KLeezUJSlmWmHBIJqu/iSWbN7uvPx3fJAa1fV5lkA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kwWOg3GF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ENT5i3Pd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vFhf406470;
	Tue, 3 Feb 2026 10:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bcB0ODsWnJBjvLBoDHQrUA3YgauX4uEKUWk+jIO6Tgk=; b=
	kwWOg3GFQVFN8O6SzCjZxNHWte5PL/LX07Ke2R/Q8N694w1mYxTIZuWvczqULEHp
	n8cVa/vSpSgu2oDQZ3X480YTrbCrQmyJqwPx1pNrtL/HBLq3RtM2S23P/TbLvlqF
	BXmDCDo/aBeba8vL/n81mAlSIHpCQ1SFYCkrxXr1BlLKdPguPkqKNV3/BPzu/HBD
	gIv6iG5ZTk9vqmQ9yBR5ug8BiY3AikzjBYfXOJ2KMc4Fx4Wmkxk1eqeGuwjjETlb
	DYEBmmNIzEoePWoRlpDC8GnKJPDnnpPydxgOoh40Us/QIq9VSBQHzjQmP27vain8
	gE4DqzcYFynDNXS8pSNeHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1atmbu2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:22:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6139TJw2002127;
	Tue, 3 Feb 2026 10:22:58 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186m5u4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTAwisKp726Na3HkImpuh3NVGb4vlkYbyjpiH6VQn7RkNH1022zTATAO3TtCijzE1jVSOae7jgk110ikdjJkZXD/nqC8zs/LPWAD+/m330swCjGxT1Vtc5ow3sVo2n3goSrdJ0zwcG36BrH6YdMhGdhNfmezOFR664eONgmBHpk+zewEXJs+d08S3PuLA/T1PWrAVo+PGzzcyXBPdGXB/5aSts/xuJFsTB/GotpEqE4OLZDRZg4/fM0dEBsbWawd0TYgiHlE3tOHTG2R4QtW6SiXMhcGoobyL02066p4ocAGghEMr5yotng8cszWAlmSFgpWuq8CB+fSKq1GhGJUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcB0ODsWnJBjvLBoDHQrUA3YgauX4uEKUWk+jIO6Tgk=;
 b=wAWHVJkcB3sLq1jIHgJ1qd6y/yuW/Q6TEGgKAgj6GS0YmbRc/iUBFdGHjL3Ib+GEEbDPWyrMSX7mStr91ZmgHp5Ibe2NOxApFSVOeBEBLVzBuoQRU739r/9oAKWIBI2+i+U5XeMgVdnif2uJ1JDAnfCmN00hRvfl/19Kc8uendF0MBHcou1JPAX9f+VvSjS4R+OA2fYcyoLbVZVmao8SQJjgvDODAgAInllff4uzq34BI1FVdnC8Ic1+tiMcG6sq3KdwKapNRZHqFzxQlp4ok9rxnwvnkZ6mGfhF6DlU7mKxnKZC7Acnftu6u5lRlz4t1bD9ghXkp7Er2B6KGNrQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcB0ODsWnJBjvLBoDHQrUA3YgauX4uEKUWk+jIO6Tgk=;
 b=ENT5i3PdcNxmF9M9JlIw/waTJWcj3UmUrb8AL9JOzssNZku3xQE7UC39eEj2w35cnzpKrYrHqqW2WIcIZ6PulquvpQPx8OOpFhjjIMZKvyCIEQhHwrAFBnyOzRY2Ke7CBJZDCXVJVHltPL0wIo171TjG10bPmLf9EAi1vAQ/GlQ=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by MW4PR10MB6298.namprd10.prod.outlook.com (2603:10b6:303:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 10:22:54 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:22:54 +0000
Message-ID: <943a402f-8d37-4932-a777-02a55d1ec0ce@oracle.com>
Date: Tue, 3 Feb 2026 15:52:47 +0530
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
 <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
 <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::20) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|MW4PR10MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f84e91-5e84-48e6-9e5e-08de630e312e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1OaEFoQWxlemFVZjloRE1uOHZnaGRlTVJTVW5NQzA2RHJUTGhSTURvUlpR?=
 =?utf-8?B?L2s5b04wd3hpbFpyckljbC8rb1RuZmx6bStscFRJK2xrU0dXcktYWUN6SHVs?=
 =?utf-8?B?RlREbWNEOGVoemZCMVVaQUloSldtTVJNa01DSUwrR0Z0ZnNQbUJYdnNiZ29X?=
 =?utf-8?B?N3JPWmhEcGphVlhSZEdhbnQrMzNMMHZLZnRIRk9BMXBQQ1pNRDRyZ3ZuazU3?=
 =?utf-8?B?U1MxQVNZOVlNQ1NncEJhNFJyTkEzaEV3ems0QnM1ZThsMjlnWW1sYTVZWlJU?=
 =?utf-8?B?b0lJSHRDMTlHZmVIWnczZ0lZUW1rUStJRWdBRm41NmhOOEFpaTNvNVJrNFlX?=
 =?utf-8?B?cnFzQmtCcmtndjloTWxLdUgyQkdoOUxMUUpSdzBkWDNvN1FqUkNsaEEyajdy?=
 =?utf-8?B?TGM4UC9FNk9XSmZ2LzBPa3E4Z041QTQvRHZmTlBrWmVNNitxeEE1djZzZXJ2?=
 =?utf-8?B?cEhVNk40bWo0YzhHWkdDbnk0d3luRUtzbndXU21ldHVPTFBVSXAyZEtOTzJQ?=
 =?utf-8?B?SkNHazhlT2FuMlp5WmpXRFZoZU1VUCs3bnplSzRJTEhUN3NZbGF5QTZ0c1Z6?=
 =?utf-8?B?V0FNRm9zRE1JR29aTFZ2MC9LU3JZSm5jZHNPcExqZDBxTHZyc3ZqM2VMSDhD?=
 =?utf-8?B?ckJCam1KblJtVkxZU0tXTFN1SDlYdnJER2xuem1nWC9vWWJiNzdJZEZRL2lC?=
 =?utf-8?B?enVuaHp5bU5Vbk5ITndIdElGalg3RGlEd2E3dG82K1lyUW1CNFpqZW9rak1i?=
 =?utf-8?B?bldtMmtCUVAxQ3kyRFBSWWhtVW9pazRLUzE4K1g2U1pkWlJKMHR1QjZMUjlT?=
 =?utf-8?B?bWE1V3NvY1lxcHNCTXRBVVJtTDk3ZXlFdlQ2NDVKTk1zZW1zbWpyNlFwNEFv?=
 =?utf-8?B?dWh1Rk5QWUdPMHYxcFg3dmVCRjErVHRDcnZ6cUhWTENMQ3h4Rjg2YWlCQ0hi?=
 =?utf-8?B?RElMMFQrWDFWaURMUUlsV0o3UFVOVmJod1RKQWhUbzlpa1Z1VDNkRXQyMUhP?=
 =?utf-8?B?N28vRGtmbElPVDB6WGdyL3VTNG5odklJaDBMK2ZMSVVSR2lqVVljdkVvVkhZ?=
 =?utf-8?B?RVhWa1YweXNIQndlRCt3NXpIaUlDd1QxKzcxaG5vUlpMQzVwVDZLMThHN1Mv?=
 =?utf-8?B?clFna3NMUnkvUEtwemZiNGFOcG9PdWxucG1yL1BmVFozN1pyR0JLdXo3WXdQ?=
 =?utf-8?B?N01qeXBkeXhQYkVNM0xVTzFIUFdnT3lUa2s1SkxLaVRYYlE1ZG8xbk9hQmdh?=
 =?utf-8?B?MWRxRWhETHhNOVZiOUVGQkYrb256YkYwcFNTeHNqcU5oc1J5a2FFSUZDQUZv?=
 =?utf-8?B?NUUyOEc5UGlhR21ORXRZbUFYV1ora2lEc3dQK0F2eEVseWR2Ujh4ZldUQ0x1?=
 =?utf-8?B?cEVEYkl0RmRFbS9kQWNJVlBVSFJ3Mnp2ZTNRa3cxKzR1d3ROWHN0bUtYY0VU?=
 =?utf-8?B?TlR1ek13SFc5WHhiTjYxYjNHOThLS01sek9PdlNRUUxEbFpnNW1kanJ6c2tZ?=
 =?utf-8?B?M2tDbC8zdit5WVZaOVQxZWZScWlJSzd4V2lmMkIveEhlb0dJQWRES0NCSnBV?=
 =?utf-8?B?K1FTd2l6SC8zMDdPQ0dIT0tyMlJlVHVqMkNkWGQxWmdNWE5OOTJ2am91TTJ2?=
 =?utf-8?B?Z0xCUWVpVTg4S3dIVVpRTTZiZHZxNG9DNW5WTWx1RExCTmMrSk14M1FmS2FT?=
 =?utf-8?B?dExwVjZRWUhCd2R2WEdPU2I2bHg0Rk11UzcrdFhaUVhWM3NYTzc0RVhKd3Iz?=
 =?utf-8?B?MXIxSDFkdkUwcWFvemFKc2NRRmsvUFJkYU5tNUsxeDlYZDQ4ODlGT3VucVRu?=
 =?utf-8?B?K3lzNnR1VzZnSmwrL2E0YmxabDVKRlZYMHR1REo0R2VjR2ZKZEt2c3NpNVF1?=
 =?utf-8?B?bWFwSllzTmhIclA4d3EzbmhLSUhrVVl2U2Z4RS9qWnhOcUJjVGkrUi9tOE9K?=
 =?utf-8?B?dm1MRFpaRTlhTFN2L3JpaTJrZ0g3RmVabE5iekJLMmR5cDJBcWcyUHFzVUxK?=
 =?utf-8?B?alErVU5NSHlLeFljaWhaVVE1VGdxRnlad1ZRdXdnclZJcmVGZm1QRld4ZWJP?=
 =?utf-8?B?bmZiU0lhMmdjRGhITG0wOFpPU2lIeTNTZldHYjJqSHdhUzRDVmZZb2c5UEJG?=
 =?utf-8?Q?z5QMFnyO3J3ach9Sxc+A2EZMx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjhaM1htczgreEI2U0JUZ1pIeVBZblBnR21IVEJ0TCt4cUxRVDBySDNqcGlu?=
 =?utf-8?B?dStNYy9FSnJFdTM0bDJzdTFMeHE1ZkpoemtYT3VuekZCSXJ1LytJUGJhZVZN?=
 =?utf-8?B?Q2VmcGxlbWxmZU04d0R0RlQ1SFcyYUJmdmJvZXB4YWMwZXljekIyZFVhTnBO?=
 =?utf-8?B?V3dadlpoa3o4QlZRWDk4aCttckpIc3kvNnI3bFZMQVJDMjlQYkpJdGdsTWdy?=
 =?utf-8?B?ZzJoRkUwbExEUVpvY1lsbEgrNlRmbDNNczF3bFdlUERuVFQreUNNMFhLN2l0?=
 =?utf-8?B?OW5JbWUxd1QzZkJrejl2aVcvSlpCbTJCazFzRml6Y1N1a1NnS3R2SzlnOFNT?=
 =?utf-8?B?T1hJUWNCQThuQ1NEUTF5bGo0ZzR6SnRRVmlqb0tzYk52ZjRRYUxLTXFodjg0?=
 =?utf-8?B?NmZNSTl0MVFwbEtDUTJ4ZFcvalJISmEybmhFWk9VS2ZtTmNGTFM2NjkzWE1q?=
 =?utf-8?B?WStkNXQ4WDJUdTE0RGdrQ1d6ZUJBNHU2clM3MSsweXBDaVo1a2Jnd3ZTVWlZ?=
 =?utf-8?B?SlVHNHRSSURzUnJzUzZHZ2thUUZCT3I5d1J6TWxGWGcwMktRQytldlRLR0dv?=
 =?utf-8?B?ZGJqYmhkbEpzNTI4RGpFdDV5VTRLVkEyN0hwQndXQkpGdWdVZXdCbVFRTVhn?=
 =?utf-8?B?RHlyL2tIbFRiYnN5QVBZVTIxcFNMeWQvVnFoMklvcmZFaTl6L3NJalVjZDIz?=
 =?utf-8?B?QzQraEpqWm03NUh6VEU4Qm1zQ0J6clllYmhZZjRXaHZLK1VnYXJodXUzV3Aw?=
 =?utf-8?B?TEVBK3ExcTJUbkJsSU04U2hjeW9TckRTd3g0aGFxcXlxSUtPVVF2amRJS1ND?=
 =?utf-8?B?VTI4S2NDWkttZFlFVytJcGVSOC9jRTdUWTFpWXFIbEdyUWdUM1VwQXhmQkxq?=
 =?utf-8?B?b2dYQkVxSUlMbkMvLzV1Wk9weFZNR2w5T3ZCUkdBNVF2SWh5YUVMdnpNTzEv?=
 =?utf-8?B?RUdSZE1PMEJRWUpiUEZWd0J3bHJ2YS9pQkZ3ZFpWa0UzSUVhTDBzeWhBUG41?=
 =?utf-8?B?VVBrUGpkcFcwMy9tTXVVN1ZBVjFEM0YwM0Fhb0pGWnJGTUlBQkVlcHRLRmh6?=
 =?utf-8?B?T2hNbFdCdy9QN3FpYUtPT0lkNjROdkdzczFOVEZiVkpoVENhUzFHV3E2c1hF?=
 =?utf-8?B?T1lRV01YaGprTXc0YjJXSFRqc0RsNUhoNmNaZTNMTitIS2lSZHNMZTJlL3ZN?=
 =?utf-8?B?bFZ2TFZTbzk1eFUvZlJqcWJsRmp6UDdxYWRQcWxPVW9oQld1Wnd2Nk1TMS8r?=
 =?utf-8?B?UVU2dWdTZ1Z3dXVoSmNoeFdZNGVKVGwwOHpvK3FGMzBvd2tkZlFNUkJISXhk?=
 =?utf-8?B?UXRjQURTQThGZVhESHQ1Zmw1VUZIM1E4aVlJbEhHcTNEd0x0c2JXcUt3UkFi?=
 =?utf-8?B?RENCOUNVb1h3S1pRSnlYTndBcG5vMy8wUkNSZ0N5cXN2ejFLYmdUOE95RFo4?=
 =?utf-8?B?UW5hWTlLdmtETWd1Mlk1a00yYWFtdFdWUVFzclFKanlhYVp4Y05LQkc5RXNP?=
 =?utf-8?B?N1dCTURUUU1yL2Q3b0ROaGtNclpTZ1ZDSEgxam9vejRORW9JVW1VcmlZTXJF?=
 =?utf-8?B?ZzJjV3cwbUtUM21DOUlkNi9rcFY2N1F2Zmd5REcrUnBsTXc0b29VcklwL2JK?=
 =?utf-8?B?dlJsWVUrQVJIZkxwRXZaeW5vWEE3d3J2cGR4eGZFTG42TjNhVjBWUTdzK0E3?=
 =?utf-8?B?VUJXTXZzcHRjcjdXNTF6UWp1dXFQNUFnYmRyUENtYnd2cDNIVTFnV01IakNQ?=
 =?utf-8?B?aStiUFRYT0Jib1dWajBwMEN5Z011RDhnT05yTnRIS1ZGQkFJQmRUWC9wbTFF?=
 =?utf-8?B?K0VucTZVN0ZtRDdZRHBTRlpYaC8zRUg1cWh1OGNKenpFUFowTFc2cnhSdE1q?=
 =?utf-8?B?bkNkbHpBWnI5RHB4TmpsNVJZd09wZkFnbCt5VThOY0Z0ZzZLblg1M2VwM2F0?=
 =?utf-8?B?eFRVR0twL3ZNVDBJdVh2WjVLRkdmSHlXeXhFY3kyVktKZFJzTE5lYStveHF5?=
 =?utf-8?B?Q0pXcTduWHJFVFFVdGF5Z2JFYk1EQnU3ek1vYXVXVDkvQlc5SjQyMG1hWU91?=
 =?utf-8?B?UHVXNHgwSDFqYWhEU01RbzJDQWVhWWhlbWRyKzRiZUcrT05Ta1lwSjUrMmor?=
 =?utf-8?B?Nko3YVUrK3d1aDI4RlQvUnRzWVF3ZW55eTNXaHFwaHcrNW9NSUdPd2QvNXJs?=
 =?utf-8?B?QnV6R3l2a09QQ3FpanVjZjdBQXFUT3BFTG11RFNDNWs2eEVrd1hPUGlZRm5t?=
 =?utf-8?B?V212ZnkvbjZZV3draWwwcEJJME5OUlp5NnpHempxcG80b0hrUHdoSG01Sm9i?=
 =?utf-8?B?KzVvbUpKWVlNdkJkN1Q2NS9NcG9QWWIycVVHZkZDUU0zRUExU3FDUlJoWHZN?=
 =?utf-8?Q?OIMei0muLraTBT5o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	prKtRpAAJPbCnK2E9zNLTZ6FGYgL5MP3liwMPeOYC90+DIkHil68NNlMOGp1Db8D/O0+M/ScQl7fSP8PpuHtdvPfctiXdtlv3OIdmhDA1alN5rKVyU3HLyJmVwZdtqzcpnFpqBGApsLNciUIZkHRmAsXRXfhS6pRPZwoHoWzLyd4V4zf1pEwZxFPHswncev/HT3Y+mbEX7sIwlkUrbiyt9ofxyRmGmDkgbqyOntXwYUuMB130f2NcN0RoWGqwjJmI8NUK4OnBx57jR6TW6AS/ytMOMR1VNH5fKyR5X/lIj9QoviWtv+BhcdJIGkcVOTSHWDSa6APSyDrFERZvbkKKAXOFiSD2UZRPlketnIF/xN5nzssNKIfHmARdrgtP39UqsuQCvZvQ/PdPKpfcZ0W1CFMLY9rgRdnnom/IwtmZAuAb9+k2ux8H53UFHVXTBPoyFkaO25H/JVX8dxRQU6mnujmxFRNrrshAmrQYTkf82NYL181RV39nFuUTI+Lsptxj7+8Jluqkw+Z4MlTPPGsigJ+eoR//7x/kkuBWMwvPNcSS2b5HmIWUxClivvwK3LgTg4n0yXH6GXK4g8cMsPWdNO0UdmOX2C7wJG/Pw7v5/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f84e91-5e84-48e6-9e5e-08de630e312e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:22:54.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtfSDufWQfXHCeYHfq+hGmzJncOFsNbn5GofLj5t53do0vM7y+iIwJYxYJULMefAuf6GUCbE1frIWvouYWEaFVmkUWBrRQ0Qlb12sfijQys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602030082
X-Proofpoint-ORIG-GUID: JUHRfLtPgSgjM2El2VgtKXUXw8VEwltq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4MiBTYWx0ZWRfX2UGfbHPfPb4W
 ElsXl53+V7eKK4zduyqhFPSlVmskQ9tOmC7KS5C3wulyOccl2K/VGNUbVmKBmlYK/ZmBd01poHl
 n2ouGalVzBbh+om+5AzacmozBEID60t+g5pgqZi1kin2KJzDA/kDb9jRzl34ajv9BJv4D/IGLT/
 d/T6rb/Mekrl+56KvaWcGoRRmf75RlCvaUqkZXX9z0s0vSkskgESAWWLh+ygQ4FP9dRTD1XNaY5
 TTGhngzH5hguth+AkmFkenmyy0VtApD8oTd434j2CsQo6Y0zY5UAS3YWtCFxqv0icfWlobQFxW+
 mKmURJLZ5DGeH8oL6vodSMot61WRDttdy16VDmhm3nJjr5+qzWuWM2qOViD+4rX5Yx2lpYAb5ba
 gFE4cNiMfRjmAcjySn6zZqZNKvRDgaLesGZKSyRsl5hZERsxbhez9V7Fjy5cuIJIyrgb8IZ/EDW
 +KwBzxyDqmNfnQPeAYqpyeIt4rjKdPwtbrmaKsbI=
X-Proofpoint-GUID: JUHRfLtPgSgjM2El2VgtKXUXw8VEwltq
X-Authority-Analysis: v=2.4 cv=E+nAZKdl c=1 sm=1 tr=0 ts=6981cc83 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=aatUQebYAAAA:8 a=baXvmrWHqSI4gFz32LMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=7715FyvI7WU-l6oqrZBK:22 cc=ntf awl=host:12104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41951-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,urldefense.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
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
X-Rspamd-Queue-Id: BE2A3D7868
X-Rspamd-Action: no action


On 03/02/26 3:01 PM, Christian Loehle wrote:
> On 2/3/26 09:16, Harshvardhan Jha wrote:
>> On 03/02/26 2:37 PM, Christian Loehle wrote:
>>> On 2/2/26 17:31, Harshvardhan Jha wrote:
>>>> On 02/02/26 12:50 AM, Christian Loehle wrote:
>>>>> On 1/30/26 19:28, Rafael J. Wysocki wrote:
>>>>>> On Thu, Jan 29, 2026 at 11:27 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>>>>> On 2026.01.28 15:53 Doug Smythies wrote:
>>>>>>>> On 2026.01.27 21:07 Doug Smythies wrote:
>>>>>>>>> On 2026.01.27 07:45 Harshvardhan Jha wrote:
>>>>>>>>>> On 08/12/25 6:17 PM, Christian Loehle wrote:
>>>>>>>>>>> On 12/8/25 11:33, Harshvardhan Jha wrote:
>>>>>>>>>>>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>>>>>>>>>>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>>>>>>>>>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>>>>>> ... snip ...
>>>>>>>>
>>>>>>>>>>> It would be nice to get the idle states here, ideally how the states' usage changed
>>>>>>>>>>> from base to revert.
>>>>>>>>>>> The mentioned thread did this and should show how it can be done, but a dump of
>>>>>>>>>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>>>>>>>>>>> before and after the workload is usually fine to work with:
>>>>>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPpMt53$
>>>>>>>>>> Apologies for the late reply, I'm attaching a tar ball which has the cpu
>>>>>>>>>> states for the test suites before and after tests. The folders with the
>>>>>>>>>> name of the test contain two folders good-kernel and bad-kernel
>>>>>>>>>> containing two files having the before and after states. Please note
>>>>>>>>>> that different machines were used for different test suites due to
>>>>>>>>>> compatibility reasons. The jbb test was run using containers.
>>>>>>>> Please provide the results of the test runs that were done for
>>>>>>>> the supplied before and after idle data.
>>>>>>>> In particular, what is the "fio" test and it results. Its idle data is not very revealing.
>>>>>>>> Is it a test I can run on my test computer?
>>>>>>> I see that I have fio installed on my test computer.
>>>>>>>
>>>>>>>>> It is a considerable amount of work to manually extract and summarize the data.
>>>>>>>>> I have only done it for the phoronix-sqlite data.
>>>>>>>> I have done the rest now, see below.
>>>>>>>> I have also attached the results, in case the formatting gets screwed up.
>>>>>>>>
>>>>>>>>> There seems to be 40 CPUs, 5 idle states, with idle state 3 defaulting to disabled.
>>>>>>>>> I remember seeing a Linux-pm email about why but couldn't find it just now.
>>>>>>>>> Summary (also attached as a PNG file, in case the formatting gets messed up):
>>>>>>>>> The total idle entries (usage)  and time seem low to me, which is why the ???.
>>>>>>>>>
>>>>>>>>> phoronix-sqlite
>>>>>>>>>      Good Kernel: Time between samples 4 seconds (estimated and ???)
>>>>>>>>>              Usage   Above   Below   Above   Below
>>>>>>>>> state 0      220     0       218     0.00%   99.09%
>>>>>>>>> state 1      70212   5213    34602   7.42%   49.28%
>>>>>>>>> state 2      30273   5237    1806    17.30%  5.97%
>>>>>>>>> state 3      0       0       0       0.00%   0.00%
>>>>>>>>> state 4      11824   2120    0       17.93%  0.00%
>>>>>>>>>
>>>>>>>>> total                112529  12570   36626   43.72%   <<< Misses %
>>>>>>>>>
>>>>>>>>>      Bad Kernel: Time between samples 3.8 seconds (estimated and ???)
>>>>>>>>>              Usage   Above   Below   Above   Below
>>>>>>>>> state 0      262     0       260     0.00%   99.24%
>>>>>>>>> state 1      62751   3985    35588   6.35%   56.71%
>>>>>>>>> state 2      24941   7896    1433    31.66%  5.75%
>>>>>>>>> state 3      0       0       0       0.00%   0.00%
>>>>>>>>> state 4      24489   11543   0       47.14%  0.00%
>>>>>>>>>
>>>>>>>>> total                112443  23424   37281   53.99%   <<< Misses %
>>>>>>>>>
>>>>>>>>> Observe 2X use of idle state 4 for the "Bad Kernel"
>>>>>>>>>
>>>>>>>>> I have a template now, and can summarize the other 40 CPU data
>>>>>>>>> faster, but I would have to rework the template for the 56 CPU data,
>>>>>>>>> and is it a 64 CPU data set at 4 idle states per CPU?
>>>>>>>> jbb: 40 CPU's; 5 idle states, with idle state 3 defaulting to disabled.
>>>>>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>>>>>
>>>>>>>>       Good Kernel: Time between samples > 2 hours (estimated)
>>>>>>>>       Usage           Above           Below           Above   Below
>>>>>>>> state 0       297550          0               296084          0.00%   99.51%
>>>>>>>> state 1       8062854 341043          4962635 4.23%   61.55%
>>>>>>>> state 2       56708358        12688379        6252051 22.37%  11.02%
>>>>>>>> state 3       0               0               0               0.00%   0.00%
>>>>>>>> state 4       54624476        15868752        0               29.05%  0.00%
>>>>>>>>
>>>>>>>> total 119693238       28898174        11510770        33.76%  <<< Misses
>>>>>>>>
>>>>>>>>       Bad Kernel: Time between samples > 2 hours (estimated)
>>>>>>>>       Usage           Above           Below           Above   Below
>>>>>>>> state 0       90715           0               75134           0.00%   82.82%
>>>>>>>> state 1       8878738 312970          6082180 3.52%   68.50%
>>>>>>>> state 2       12048728        2576251 603316          21.38%  5.01%
>>>>>>>> state 3       0               0               0               0.00%   0.00%
>>>>>>>> state 4       85999424        44723273        0               52.00%  0.00%
>>>>>>>>
>>>>>>>> total 107017605       47612494        6760630 50.81%  <<< Misses
>>>>>>>>
>>>>>>>> As with the previous test, observe 1.6X use of idle state 4 for the "Bad Kernel"
>>>>>>>>
>>>>>>>> fio: 64 CPUs; 4 idle states; POLL, C1, C1E, C6.
>>>>>>>>
>>>>>>>> fio
>>>>>>>>       Good Kernel: Time between samples ~ 1 minute (estimated)
>>>>>>>>       Usage           Above   Below   Above   Below
>>>>>>>> state 0       3822            0       3818    0.00%   99.90%
>>>>>>>> state 1       148640          4406    68956   2.96%   46.39%
>>>>>>>> state 2       593455          45344   105675  7.64%   17.81%
>>>>>>>> state 3       3209648 807014  0       25.14%  0.00%
>>>>>>>>
>>>>>>>> total 3955565 856764  178449  26.17%  <<< Misses
>>>>>>>>
>>>>>>>>       Bad Kernel: Time between samples ~ 1 minute (estimated)
>>>>>>>>       Usage           Above   Below   Above   Below
>>>>>>>> state 0       916             0       756     0.00%   82.53%
>>>>>>>> state 1       80230           2028    42791   2.53%   53.34%
>>>>>>>> state 2       59231           6888    6791    11.63%  11.47%
>>>>>>>> state 3       2455784 564797  0       23.00%  0.00%
>>>>>>>>
>>>>>>>> total 2596161 573713  50338   24.04%  <<< Misses
>>>>>>>>
>>>>>>>> It is not clear why the number of idle entries differs so much
>>>>>>>> between the tests, but there is a bit of a different distribution
>>>>>>>> of the workload among the CPUs.
>>>>>>>>
>>>>>>>> rds-stress: 56 CPUs; 5 idle states, with idle state 3 defaulting to disabled.
>>>>>>>> POLL, C1, C1E, C3 (disabled), C6
>>>>>>>>
>>>>>>>> rds-stress-test
>>>>>>>>       Good Kernel: Time between samples ~70 Seconds (estimated)
>>>>>>>>       Usage   Above   Below   Above   Below
>>>>>>>> state 0       1561    0       1435    0.00%   91.93%
>>>>>>>> state 1       13855   899     2410    6.49%   17.39%
>>>>>>>> state 2       467998  139254  23679   29.76%  5.06%
>>>>>>>> state 3       0       0       0       0.00%   0.00%
>>>>>>>> state 4       213132  107417  0       50.40%  0.00%
>>>>>>>>
>>>>>>>> total 696546  247570  27524   39.49%  <<< Misses
>>>>>>>>
>>>>>>>>       Bad Kernel: Time between samples ~ 70 Seconds (estimated)
>>>>>>>>       Usage   Above   Below   Above   Below
>>>>>>>> state 0       231     0       231     0.00%   100.00%
>>>>>>>> state 1       5413    266     1186    4.91%   21.91%
>>>>>>>> state 2       54365   719     3789    1.32%   6.97%
>>>>>>>> state 3       0       0       0       0.00%   0.00%
>>>>>>>> state 4       267055  148327  0       55.54%  0.00%
>>>>>>>>
>>>>>>>> total 327064  149312  5206    47.24%  <<< Misses
>>>>>>>>
>>>>>>>> Again, differing numbers of idle entries between tests.
>>>>>>>> This time the load distribution between CPUs is more
>>>>>>>> obvious. In the "Bad" case most work is done on 2 or 3 CPU's.
>>>>>>>> In the "Good" case the work is distributed over more CPUs.
>>>>>>>> I assume without proof, that the scheduler is deciding not to migrate
>>>>>>>> the next bit of work to another CPU in the one case verses the other.
>>>>>>> The above is incorrect. The CPUs involved between the "Good"
>>>>>>> and "Bad" tests are very similar, mainly 2 CPUs with a little of
>>>>>>> a 3rd and 4th. See the attached graph for more detail / clarity.
>>>>>>>
>>>>>>> All of the tests show higher usage of shallower idle states with
>>>>>>> the "Good" verses the "Bad", which was the expectation of the
>>>>>>> original patch, as has been mentioned a few times in the emails.
>>>>>>>
>>>>>>> My input is to revert the reversion.
>>>>>> OK, noted, thanks!
>>>>>>
>>>>>> Christian, what do you think?
>>>>> I've attached readable diffs of the values provided the tldr is:
>>>>>
>>>>> +--------------------+-----------+-----------+
>>>>> | Workload           | Δ above % | Δ below % |
>>>>> +--------------------+-----------+-----------+
>>>>> | fio                |  -10.11   |  +2.36    |
>>>>> | rds-stress-test    |   -0.44   |  +2.57    |
>>>>> | jbb                |  -20.35   |  +3.30    |
>>>>> | phoronix-sqlite    |   -9.66   |  -0.61    |
>>>>> +--------------------+-----------+-----------+
>>>>>
>>>>> I think the overall trend however is clear, the commit
>>>>> 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
>>>>> improved menu on many systems and workloads, I'd dare to say most.
>>>>>
>>>>> Even on the reported regression introduced by it, the cpuidle governor
>>>>> performed better on paper, system metrics regressed because other
>>>>> CPUs' P-states weren't available due to being in a shallower state.
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!KSEGRBOHs7E_E4fRenT3y3MovrhDewsTY-E4lu1JCX0Py-r4GiEJefoLfcHrummpmvmeO_vp1beh-OO_MYxG9xLU0BuBunAS$ 
>>>>> (+CC Sergey)
>>>>> It could be argued that this is a limitation of a per-CPU cpuidle
>>>>> governor and a more holistic approach would be needed for that platform
>>>>> (i.e. power/thermal-budget-sharing-CPUs want to use higher P-states,
>>>>> skew towards deeper cpuidle states).
>>>>>
>>>>> I also think that the change made sense, for small residency values
>>>>> with a bit of random noise mixed in, performing the same statistical
>>>>> test doesn't seem sensible, the short intervals will look noisier.
>>>>>
>>>>> So options are:
>>>>> 1. Revert revert on mainline+stable
>>>>> 2. Revert revert on mainline only
>>>>> 3. Keep revert, miss out on the improvement for many.
>>>>> 4. Revert only when we have a good solution for the platforms like
>>>>> Sergey's.
>>>>>
>>>>> I'd lean towards 2 because 4 won't be easy, unless of course a minor
>>>>> hack like playing with the deep idle state residency values would
>>>>> be enough to mitigate.
>>>> Wouldn't it be better to choose option 1 as reverting the revert has
>>>> even more pronounced improvements on older kernels? I've tested this on
>>>> 6.12, 5.15 and 5.4 stable based kernels and found massive improvements.
>>>> Since the revert has optimizations present only in Jasper Lake Systems
>>>> which is new, isn't reverting the revert more relevant on stable
>>>> kernels? It's more likely that older hardware runs older kernels than
>>>> newer hardware although not always necessary imo.
>>>>
>>> FWIW Jasper Lake seems to be supported from 5.6 on, see
>>> b2d32af0bff4 ("x86/cpu: Add Jasper Lake to Intel family")
>> Oh I see, but shouldn't avoiding regressions on established platforms be
>> a priority over further optimizing for specific newer platforms like
>> Jasper Lake?
>>
> Well avoiding regressions on established platforms is what lead to
> 10fad4012234 Revert "cpuidle: menu: Avoid discarding useful information"
> being applied and backported.
> The expectation for stable is that we avoid regressions and potentially
> miss out on improvements. If you want the latest greatest performance you
> should probably run a latest greatest kernel.
> The original
> 85975daeaa4d cpuidle: menu: Avoid discarding useful information
> was seen as a fix and overall improvement, that's why it was backported,
> but Sergey's regression report contradicted that.
> What is "established" and "newer" for a stable kernel is quite handwavy
> IMO but even here Sergey's regression report is a clear data point...
> Your report is only restoring 5.15 (and others) performance to 5.15
> upstream-ish levels which is within the expectations of running a stable
> kernel. No doubt it's frustrating either way!
Ah but we see a regression on 5.15, 5.4 and 6.12 stable based kernels
with the revert and reapplying it recovers performance across many
benchmarks. Hence, the previous suggestion.

