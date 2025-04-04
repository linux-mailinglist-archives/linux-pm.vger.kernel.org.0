Return-Path: <linux-pm+bounces-24808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B7A7BD2F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 15:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6FE17A4ED
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3F1E1DFE;
	Fri,  4 Apr 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mIQRbl7D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kDhkpNtA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D712F5A5;
	Fri,  4 Apr 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771995; cv=fail; b=awrvChIJaBIB6mviqEMOc2b98yJ5OAjGZOcpErseFnePc6r4dTZbm3Ps2MGafMOkMKhqSn0VxYHob5Xt+W74w0MdgVOUk1LCIlNco6pTBz8smhUI+EknXRGWBbN8WiWcuFfKy/TcRw8noS0V+bkSG+6iOL4QME/o6c7Tt/4LRDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771995; c=relaxed/simple;
	bh=XG2EUDqajr1U7+kLSfY2/DG9ybIkeFVu9XyUwjNK8Bc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ph/lV/s8RbI/q4jws3XhDzXn/0dc76TODyYn9+Ixyx8uAIYHlCJi/JVqm2w+XT0uNoMZ1Uxr/thpb0vEfci/wObzaGnM1dF6iUyB66o8V9JGCQTAKgzKF4b4H3CrEYnSUnIXyUqgiGtibHYXTAIzf3aNNyTROf20dT2Gergdguo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mIQRbl7D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kDhkpNtA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534Cg1l5004880;
	Fri, 4 Apr 2025 13:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5IiUXieGvJ70o+kzdpB2Db20tXiZ7Vb4jBVc0FSeA+E=; b=
	mIQRbl7DRMxNIOwbFNpRdCJCVzHFdD9CdCZySm1Lzu3Q5+VIiysY0MzW59meg1YR
	vJh++LaMlII401MbYi/M07yMGpMWHjIdUQnTBmC1EWAOs2T8HvO4glTfVUBjdKss
	dsqOJIz4MRzJvSjzj7balytENMQtusXUpqu5KVncRw5DthNwIceCmlk/RdY78kXK
	7KjykpQaZCiDu5La09Ap1Xxq9yFTCZQ602GMU5HoekP6UbdEGfMViKUevsiA+VQy
	qQTxF8FFbFyt3romqYvTmSynN+dFTEQdAo1dR8PXA1Mm+eRXZLOFJ7IrgqXPmuhx
	LiQXbZXjoDyX0YhdcSCAIg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2f9sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 13:06:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 534BaFfA024401;
	Fri, 4 Apr 2025 13:06:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45t339qwcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 13:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f07kEYrJVXMQChDf8eHvVNmLhqVEsRU12nxgA+raHGFkIFXpCLZCKIP0cXAVJjxxiEdL8wOClAHVjNqoxjHkfD2C7mJUWRjUjlwYXYrxJoAA2OZKajFLzCKGb2Z3qBbfkikw1n5Hq14WhCf3tHxu1WM+Vzalx9Vt4b34Onf+Rj4FHfv27YFeV24PI6BsxHNJzW1UaeBTSwrDHluQKUSIcHedg/FP+AeCA4by+Y1cF5upw8Kclf2lGpLPXaakW91tStIqYId6c+ofjGo1zaLnHUwmofr48rD2k1UFmAutPenja9uF+pvCNWjjj44EKmb32FjEqi5uydz/QQSmzFdGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IiUXieGvJ70o+kzdpB2Db20tXiZ7Vb4jBVc0FSeA+E=;
 b=sB2WKpy5eKysx14JohfgXQb9u0RZo7+HOkglhYa0w7MrDAjc9WvftlD/FolT3/wldci5phxWED+1MurxNMgCCFpBRVbnvTxQTFweJ5URUcLDgx0sjQveRULAdFlnzNc3o6ObXRBUaltTbM7WQsbphXQvLEEbJmPcPS6DeRXAhtySSkPINNsUJ5narw2U2HvlDEIVCyMvT3nMUzX8yFZdIUwWZFx1Aab7LO1DPOEN3x/hjM2RBksQkEjqbZ3w/3/b4Qs83kNtqn/QpwRdkEXXHvKhSuzVygP3s8w15Xq9AC/zRn/KbWMDzJpkmDhTE9ZIH3QHHezJi/zpUibzWWoIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IiUXieGvJ70o+kzdpB2Db20tXiZ7Vb4jBVc0FSeA+E=;
 b=kDhkpNtA/t4FQCMaCRXzroEqnt1BJdXysRKsGUnDC13WhXznsFJoMe2ULCD49d98Nt6obFHLPfGfpJNYvRqjWPJbcuE1igVdF5fU6WYWOLbXdqjGs0JiIJqu4/qOclbu2KYfMVZnF/glTldDkLI8zbdUxxiyAkVKOnsNKABJ2Cw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB6824.namprd10.prod.outlook.com (2603:10b6:8:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 13:06:11 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8583.043; Fri, 4 Apr 2025
 13:06:11 +0000
Message-ID: <13cc72b7-735a-472c-9d5a-9d2e403e69f6@oracle.com>
Date: Fri, 4 Apr 2025 18:36:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : RE: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add
 thermal driver for the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "robh@kernel.org"
 <robh@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "john.madieu@gmail.com" <john.madieu@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Biju Das
 <biju.das.jz@bp.renesas.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-4-john.madieu.xa@bp.renesas.com>
 <a380c593-a2a4-40d2-8b2f-e3e1a2cdbe9e@oracle.com>
 <OSBPR01MB277527932C5570EBC3D877C7FFAC2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <ca50f9b4-feb5-4365-927d-a2c931e268ed@oracle.com>
 <OSBPR01MB2775B41C98F595C162E8924BFFAF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <OSBPR01MB2775B41C98F595C162E8924BFFAF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e99fa8-703d-4102-07af-08dd737978c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFBQRm1pSmVPWDI5RFp1eVVKWHdETzRYMnJ3OVY0YVYzRDJMZVF1b2d1a216?=
 =?utf-8?B?STlsNExZLzllSVdYQW5FbGJONjlkRHFUZ1VmLzhZem9TMlltYnRMOGhBYU9y?=
 =?utf-8?B?QVE3MGF0WEJ6ZC8rUWxuK3pIRnZidXZYUmNOdVUrZU5CSE1jL3VPKzVIVjZy?=
 =?utf-8?B?djQyVnlydVMrUzlTWlJYWVhtMjlYVy92UEhKcjBVQmdFMFY1SjVONm9jRUpz?=
 =?utf-8?B?VlZFRGR6ZFpYaHBYSENKTUtjUVFFbXV2SEN0VkpBM3krOE1pcmF5TkovQ3lP?=
 =?utf-8?B?SWlsVTdRa0l2MVRUeTlOUkRqMTllMEFiR3doZjZZUXlLeFBncCt5QWs2YURq?=
 =?utf-8?B?WGd6STJQRWxMcUV3L0NCVCtXd3RSdUloNXBiWkR2MHVZNmFpQ1Z2SERERWdz?=
 =?utf-8?B?Q2ZDOEpFQzlROTFkU2pwT2VkTDFkamMxSVdEeXM3emNURDNZL1V3YWRHY2o3?=
 =?utf-8?B?UGNnL1pGb3JRb3RwRTFCc3B1eHZidlo5a1pwVHBycDBPU3Y3RFVRN1J5cjU2?=
 =?utf-8?B?Y2ZMV3JnZUxxOVc0OE9EbDlzSE9TMUpiTGtZSko4WkE0NS9PVG92RFlJY0dn?=
 =?utf-8?B?OTZnMSt1RGtGOFpxbmV0WmNpVDVHb2hTNmNNMnhlMXRYNnN1VzlyNnBWVnIx?=
 =?utf-8?B?d0xGdElVMHJvcUlFZmxBVW9vWE8vWmxFL0VzbGhnOHVMTGdDNmVwakk1WnV2?=
 =?utf-8?B?MTRoVHB0L3A4WWlaQlo4KzVNdTJDZVlHMTA5a1E3VjkrVFdtVlUvRlhKcjhW?=
 =?utf-8?B?QU1rM1lTRHUvRXNNaXhqMWhRWWx6VmRTbEU5ZGhuQ3p3M3g0c0JkU0h5STBx?=
 =?utf-8?B?SXU4cTRrcjNkQ3ZTamt1UXVMZmRPdnQ2QURMYVl0T01GSkFJRGtjSHp6VElY?=
 =?utf-8?B?Q2JlQ2M3YjhLNjIxY2Fjb3Bvc045L0d5bFM3RmNsOTFpKzRCZFpOSlZuNGlq?=
 =?utf-8?B?TEFCMlozZjBDR1VkeHFLc0ExVmJJdGI4LzlnRHJmQitQcXZKL09TNXpvR1VE?=
 =?utf-8?B?ZkpYWVBCd00wajZUWjFlMnVmUlJnTHQ1TnF1aEdvTExtdVFXM20wNm81KzMv?=
 =?utf-8?B?a3htMjRpRVYyaHZxdmRrenVid25GYVN5azNDMW9jbkVIYW9RRiszTmpSOTla?=
 =?utf-8?B?b2tEcTNEMVFxK3hEVXdadkV6Sm8wdis4amRXS1hqa1VDSHZGb3ltMlQydWNV?=
 =?utf-8?B?T2FsZ3pvZ2diNzV3MHlJNTRvMmRDZDRtc3VMU3NuL1ZIVk93YWdWcDdYTkRl?=
 =?utf-8?B?enRiZStmY04rUCttTFNBUUNMV2VkeUFyWEtjZDMzS3FRY1h0YlRXS2pXdHhk?=
 =?utf-8?B?aEc4UGJPc0p1eEY3dXc0LzFBdWVxNDlLVWV6TjFBTGFwNnZOQUJjZlBYa3BF?=
 =?utf-8?B?MXpDWXNta2haaUdSbng4aVRmNXA2L3krS0djQU5vUzIweng1b2szZG10ZXh3?=
 =?utf-8?B?bGh3OHdFWUh4Y3p3QmFIY0c1eWFVcG5rb0Excm5rTXB3aDN3bWszYnVmZmZF?=
 =?utf-8?B?NlQvMUd2MU1yV1JDOGFkeFFpZmVpRWFyTmFkelhGQXJxU1cvY1pyNkdnbDNT?=
 =?utf-8?B?eTd3ZUJZQUF0dFpnTUFvcDN1THN0b0hXTmt0eTBGZGVjQ1dxdlJSRDVoNWxz?=
 =?utf-8?B?QkRjVjFVU2pTSFA0M0NQbjR1ZHFKLzA4dnBBSlpKcFIvT0c4Q2szTGs5akhp?=
 =?utf-8?B?anVrL2lVL0JVZVh3ZHc2dlErazNFeXNTWFY4OW4rQUM2U3g5Z2xpQnFHM1pG?=
 =?utf-8?B?aTBCSEtmL3MzMUtNQVN4RU9ycHBCL2VlamdpYzdiN0pyL1p1aHlSNVFuQnNR?=
 =?utf-8?B?U3d5d0x6d0pSYWwza3pYNlJPOWQ5K2t3cVhFTmNYS1pSNzFCQUJiZi8wMFdG?=
 =?utf-8?Q?drb41hI7W3lZj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFoeGlxWUh3V2FKejMzRDJUbXdJOXkwYmRCN3hnL2pLcXF4NW1pdkJYOXh6?=
 =?utf-8?B?OWh0ZGExWlpOT0hsN1JVSjYva3k3THQ4QUdNMWd4UXF5dk5LRjJxTzhheExu?=
 =?utf-8?B?M0hjZjFLYlRSdXJ5UFg0RU1lK3RkYTVyMzMxVC9qRXZZK2crejV1UENSdElS?=
 =?utf-8?B?N2lCM2haVWNjT1hkVTM5TFpjZ1ptWDdORGNiUXk5NTNGNkF2N2JndUVyb3dU?=
 =?utf-8?B?ZjNoOVExcnFuQXc3NWliN0Q1YlhrSnZjbnpLUGgySzVEenFpR1NSRFIrR21Y?=
 =?utf-8?B?L2hsN1RyOHduNlg4SHhWbjVTMXVadzhCUVh2b3Z0K0lKdXBtOWFiSHBKZkVh?=
 =?utf-8?B?QmZvU2Zzbis1TzRtZ3pYQ2xjYXh3VGlnSjJuRWVYb1dTc0kvODZicVRUSWpw?=
 =?utf-8?B?aGd4MjJHY2lobU5rT01zVEhUdzRaY0ZMeHh6R3Z5WGo2U1BVOFpiamVXSnZj?=
 =?utf-8?B?UzVTRTZRelArdXJJV1hGY0szamxTOFBsb2ZKUGV0RGFBZjRQM2dHVlhVQjB6?=
 =?utf-8?B?U3lzOGRWRmx5c1o1SmRHRU40bkxYamEzUFdJaG0vNFdGOTQyY3Z0cFBadVkw?=
 =?utf-8?B?dmdlNm9UUGJrWGtyelB5L21mRllKc09wTUdCTVQxcXZWYStPYkhQOEJkUE93?=
 =?utf-8?B?QjNZbTFYSlFnaW5kZW1vWm5UNWxQeXRhMnFqVmNlbXdoZnc0Z2NjL3dIaXJw?=
 =?utf-8?B?WGN2MjZZaXU3cW15TEZoRitIdlZGWVR1ejQ2YzViU3VOc2NiV094SVdoTTZn?=
 =?utf-8?B?ZisvcGhHSkQyaSs5OHk3QVRxN0dVSWJuT0RxcTRXWjYvTXoyQ0xtNlVSZzFE?=
 =?utf-8?B?c0VNTEhvOWFoTkhJZGVVTG1ZaElLOEJDZmJET3VWcDhzWHFzRlpjTHF6Vk40?=
 =?utf-8?B?NjZLUUYyY3FMM25uTkU3cno1SDRBL0t2UG13ZDliTU4zaVVJdW5hSGtFTE4z?=
 =?utf-8?B?VzdGM1ZlVnh6blgvK2ROMkM2ZTdVUHZWR0FkYzI2NVJlZVhSRTBrWUhDZm5p?=
 =?utf-8?B?a3M5RHVoMTJCeFQzMHkrTGhTZk9ra2RtZ3NEYU11bnZ6bzIyTm5yajdCaVdD?=
 =?utf-8?B?NUhCanRjL3lvTFJvS2ZmMTU1Z0hUd3hiL1I1c04vVFhXcURLOUUvOFlPazlQ?=
 =?utf-8?B?cFJUNm4rVUxzeklTZkFMSFRHT0dTWUxTSG5UcVloSTVrYWJMamRpb0x6VTFD?=
 =?utf-8?B?cWFBclc0QzlyUDAreGRwTTJoQnVGeDhCZWlmU3p2ZlQ0MGp0ZFFyM1o0ZmQy?=
 =?utf-8?B?eUFaZGhaSzRFWjNGSUxRNUVPR1A2VVhzUENxOEk3dWE2c3RFVklnV3hLdmhL?=
 =?utf-8?B?ZitDbXNKZzlHZ2hrcVRLMjdCcGJINitwd3R2Vzd1MC9BdFBLeDdka3o3TFZY?=
 =?utf-8?B?WkJoNXJGYjA2NGY5VFBiU3R0MldjM2pscGVFRHdKbDN3WDhZdU5NQkpWaFFt?=
 =?utf-8?B?aDUxcHI3QzBDeWE3WUp6RTBaQzFsbG9ubEFTMUVtbm85dUh6eXRXYjVOWGhM?=
 =?utf-8?B?TFJsaHB1WVo4WE1ubmVTcmwvTi9UVXVxNFJoMm52TzRtN09WTlZ1T1VRKzFX?=
 =?utf-8?B?VjNjN0h4elNIU2VhL1NMSFFydlh5bStEb0RLVTRnUU0yVFBjQ28wdE8xRitR?=
 =?utf-8?B?UkJGUWNISjVZaDZSS2FGa0U2c1AySzRSRHFpNzVUL2JmcEJXTTN3WEJMV3FP?=
 =?utf-8?B?MVhwSURScWR6RlJqVGVtbVRhWFNEUkxhU2t4NkoyajdlbzZiQmVDZFozYjNS?=
 =?utf-8?B?eWg1Nmx2NUJ3UkVIaUQwS3ZCWTdmRGUzaGZCRE9TNU1VSE45Q1Zac1JPZmhS?=
 =?utf-8?B?VS85QUliclhaM2djWlZscG82T0lFaFZ0anpUWEVpc25VR1VIczR1OWRaQTkx?=
 =?utf-8?B?d2dlVUhiNXNnbVgxR0dGcUN2NEJKc2p2T2V6aWNIb3dpQTQvbUZzMjZjV01T?=
 =?utf-8?B?N2tYTnhHem43QUxWd3ZsYU92TTM2TEpsWlYrcjJSMXhkMXN2NjZKUjg3QnlF?=
 =?utf-8?B?aW9ZNDNIZlZ6RW1iOUwvS2FkYmJacitaS0djTWdXaXpuN0RzbDN6OGN3ZVhP?=
 =?utf-8?B?UkZBYms2K0JqWkFveGpsU0FWcG9YRk5TTXJ5RzkySzZBT2dEOEplVXpncW1j?=
 =?utf-8?B?WStUanhDajg0M1k4TEtodUtBUnppUkk3bWJicnhJQkVoZkJtSTZsZnFCTHNX?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ru+AdCLKbVvCnzs+DDECf62vkS7+iMx9QTA0n8BdnXGdKed2F3iqNX4B9KNm/zhhHyt31uyKda8shDISKnh5PYU4hPYZWzE7FESMfQFaqm5uJtVH21duGVkjOfy5kz7QaCk13L+m0eUHnFD7zXO8PSzIHa+TEC4oSwlCPF7fpj3VjIU/0LZI2WJVdBbfwTSuti/WKluZMuqe2mWiXxzV9lFIMd6DKQa9OT4UsAio1HGEKDfaAguNqJds/bQimxQqgAbjsh7IlyFeejzV3yWXCHHViDE8lrXdK+DkbMOrbPy00pD6XHWh9f5NUF58N8H0XbvUYvH/6r83g7NOv3DKFDcSnFpCIKPT2jo837PBNw39ba7hvkvQk65OofaRHSkinAiwaACrKP77Iu0SQtqILpVnHXIFgBcHmgRfcUetZsLTvFPFU6PdG36FgmCOdqsKDr3viLvsJwQ2kfbB4lsdfawNG6rt8o0zLOnFLWt63UHkAVNHqZzMWFusIvuzkdVsKSKgqJPaX78QvOH0IT58LYP/tFKD7O/tQvGZ8/lLTSozelVkH7Cj2n39tPfakPjIWCs1Tq0OAtYoGdjphRKdgeQnOb6KZfWa9UnC4WruOSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e99fa8-703d-4102-07af-08dd737978c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 13:06:11.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55Pzv7dxXUFVEhpenGQFJPVX8XEbPhmJYIPcxlvImhXxYyKbW5xJFdcTP1Cl9SORRx0648ulPBN/CwZLwewJa6FeZU5t+11bADb3gOiIwAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_05,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504040091
X-Proofpoint-ORIG-GUID: P__pPkafx85v943P0nTHQuzCUxyBci73
X-Proofpoint-GUID: P__pPkafx85v943P0nTHQuzCUxyBci73

Hi John,

On 03-04-2025 00:52, John Madieu wrote:
> Hi Alok,
> 
>> -----Original Message-----
>> From: ALOK TIWARI <alok.a.tiwari@oracle.com>
>> Sent: Tuesday, April 1, 2025 8:24 PM
>> To: John Madieu <john.madieu.xa@bp.renesas.com>; geert+renesas@glider.be;
>> conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org;
>> rafael@kernel.org; daniel.lezcano@linaro.org
>> Subject: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver
>> for the Renesas RZ/G3E SoC
>>
>> Hi John,
>>
>> Thanks for your reply.
>>
>> On 01-04-2025 17:35, John Madieu wrote:
>>> Hi Alok,
>>>
>>> Thanks for your feedback.
>>>
>>>> -----Original Message-----
>>>> From: ALOK TIWARI <alok.a.tiwari@oracle.com>
>>>> Sent: Monday, March 31, 2025 8:11 PM
>>>> To: John Madieu <john.madieu.xa@bp.renesas.com>;
>>>> geert+renesas@glider.be;
>>>> conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org;
>>>> rafael@kernel.org; daniel.lezcano@linaro.org
>>>> Subject: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal
>>>> driver for the Renesas RZ/G3E SoC
>>>>
>>>>
>>>>
>>>> On 31-03-2025 03:19, John Madieu wrote:
>>>>> The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block
>>
>>>>> +static int rzg3e_thermal_change_mode(struct thermal_zone_device *tz,
>>>>> +				     enum thermal_device_mode mode) {
>>>>> +	struct rzg3e_thermal_priv *priv = thermal_zone_device_priv(tz);
>>>>> +
>>>>> +	if (mode == THERMAL_DEVICE_DISABLED)
>>>>> +		rzg3e_thermal_hw_disable(priv);
>>>>> +	else
>>>>> +		rzg3e_thermal_hw_enable(priv);
>>>>> +
>>>>> +	priv->mode = mode;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>> always return 0 here ? what, if (!priv) return -EINVAL; ?
>>>
>>> priv cannot be NULL here, guaranteed from probe().
>>> Returning 0 here is expected by the thermal framework to notify ops
>>> success.
>>>
>>
>> I agreed. priv cannot be NULL.
>> It appears that return 0 is deliberate in this case. can we add Meaningful
>> comment which help to code readability.
>>
> 
> This is a standard tzd ops, which expects 0 to be returned
> for disabling/enabling success. This is how it's implemented
> in every Thermal driver I've gone through in the -next tree.
> 
>> not sure if user call ioctl(fd, THERMAL_IOC_SET_MODE, 2) and it returns
>> 0 with thermal enable.
>> that create possibility to thermal_core call thermal_notify_tz_disable if
>> any case
>>
> Am I missing something ?
> 

That's fine. it is not supporting ioctl.
usually thermal core driver do check if(mode == THERMAL_DEVICE_ENABLED) 
condition, else part is by-default.
as it is supporting only enable/disable case from 
/sys/class/thermal/thermal_zone0/mode. it does not create any issue.
LGTM.

>>>>> +static const struct thermal_zone_device_ops rzg3e_tz_ops = {
>>>>> +	.get_temp = rzg3e_thermal_get_temp,
>>>>> +	.set_trips = rzg3e_thermal_set_trips,
>>>>> +	.change_mode = rzg3e_thermal_change_mode, };
>>>> other renesas driver defined as rzg2l_tz_of_ops, can be used similar
>>>> one rzg3e_tz_of_ops for consistency!
>>>
>>> Thanks for pointing it out. Makes sense. Will double check and update
>>> accordingly.
>>>
>>>>> +
>>>>> +static int rzg3e_thermal_probe(struct platform_device *pdev) {
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct rzg3e_thermal_priv *priv;
>>>>> +	struct reset_control *rstc;
>>>>
> Regards,
> John


