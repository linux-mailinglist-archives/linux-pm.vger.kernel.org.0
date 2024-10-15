Return-Path: <linux-pm+bounces-15682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E199F4D8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 20:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A56B22622
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9568D1FC7E6;
	Tue, 15 Oct 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EHXZnsZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9D1FAF1F;
	Tue, 15 Oct 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015790; cv=fail; b=Frn7JB7jyUM9VXrtgFyF0SjVOJRwBS2j7qREckQTZLMHfRQ6NdD/sfgLCM5iXqPDtEMjUIQN36rPezgnsell75C3FZ2uvPRPDCOjYjWsmhxNlh2SBB0A4VCXz7H7ABJ/zsHjB2B4f+nFE072ZZCB8d56uiVmfdlz8EcVhoju40I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015790; c=relaxed/simple;
	bh=xqQVgVhDX593Q9SlaT4heR2rInN/YHQEg4B9bkOg8mY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IDSMm3BsEPw8nq3dj6vWT5AWnczvj4pb2HMjwUwgcTtM68jQZvhc7kV/dxA+ElYza/KZE5JkxgirCCFPkYSiX87OJUDoo2+2lWv+WrD6Ccqt1+o8n3zrJIopifid1Jei0kWNiXTOApaPPmVNDRmFXP6bjZqLBWi6NBDdbZA/ZtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EHXZnsZS; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CI5nq+MR3ZkwJgh0jttNt4aRPOS7zS1djHxmkGa1wEoghI5Q4S66SknyoKZrB9D8MzVJeyX0uJ0Rn5j8YBKldlhWwDyzINF1M52o6qFutaxCjeGH/heApb5NOhWXNqPLTaxe3J3jmCVo207R74y1i+jdN+LX6+Q4RktwFwMvIRyd9oQsKIp/prRrq8ULJ9t9om9ReLVtBoVrcfs3DJx6oehiUP+ZOUf7AVVaPjnYtYBTTvCEz3gHkXcltk3ZAx3l8YWTmDa/JWal8YdIW3wAGmdd9qE/iCwZw/PAbkxGbYVl4koIdh0NQVZa/ddvkC1Vm+6l//X6HK92zcXkYCbkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g45mgsy4pAedlnStswzneaQZCospxe+t6PPDLQ/icr8=;
 b=R9CmEofitndpVSnR8o47DDyke4L5E4yuV9DmB71nnfvOHjD/6GFxgIOqibooumRR3425X+xoM9ZGfbHkkWfqC9n7eSyfPke4F7TM5VM3Ywn6zbOIpmRQIb3UB39vif3oTXoRy1JxSpEHRdt1NW7DhK5/c2/2pCnYz4RrXYpEQirfgB9+4oV3diB3Vm42kC/Z3fLWHS2cQJKTylhdTs9uvUbyg1AjTwp3IUt5y9HPM4Pl8D/rpzKplKZpMxWwt6nW1V2OC8/UozgWJ2D4DaKnnxFzRjdMDE8Vb92GYp2AmO/yOHFjsAAsKlowpYRnK3NoSCYTUw4qHNQEbjpvy8MKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g45mgsy4pAedlnStswzneaQZCospxe+t6PPDLQ/icr8=;
 b=EHXZnsZSwBI9OM5vlhgPZFAWndg/02W/qzE2tnY4rZlsmk++dWahmIa1Qxq925XMy5aucKFCBq9obfJDnMYlBFfZIuyXM9isSQCiLbGu/ZUoRj/GbZqk9QgtLlW+LSh8u1MKpep++FX+iKzBmGjPJn17rodG0m24W+aFkIcGuks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 18:09:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:09:44 +0000
Message-ID: <1395bee1-95a7-4d14-a5e8-0e1dc71fadac@amd.com>
Date: Tue, 15 Oct 2024 13:09:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
 <20241015035233.GA28522@ranerica-svr.sc.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241015035233.GA28522@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f23e480-91af-418a-2dcd-08dced448c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGUvcytNZmRRY2F5ZXlzRU5Xb001czRYbWVPdVdjdEtqTEViU3Q2dUd2Y1c0?=
 =?utf-8?B?dndNeVZpd3FISzcwbCtzOUFJSWxyWUJIRXFNcjdCTm1rVUxUS2E0UVBiWUh2?=
 =?utf-8?B?Ti93YXl1TGNzaXJoVzBWT1IveTJhQnQ0MmJ0WTR2OFFzb1dRUUE2alBxeFFl?=
 =?utf-8?B?Wng3ZVZNb2pCaXRjRnhSMnFVdTFsVVdhWk52c2IvZFBxL2twc200MHEzRUdT?=
 =?utf-8?B?eHIxeHM2OW91TG9zeXNrZEE5QXhDZVRKMGFERmRHelh6Ti9LbEFPRlRiK3JG?=
 =?utf-8?B?Nk1LeUczMHdlSU8rMjJacGE1TnpkUlN1d3hobVduYnFUclAzemtxSHhwNE00?=
 =?utf-8?B?djk4Rm5XVVZlNUJ3UUhSMFBwWThTNkF2RldTdXJMd1FJQWJzNWdzb3dsZGRM?=
 =?utf-8?B?bkRmUTZLUnloa2JxemV4OHoxNGNLTlE2WW5kRUZSSzgrazNsZVFIUGpTbVpw?=
 =?utf-8?B?Wi9NZEZsVnpBUExpNEhMaHIvTEtWWFpVbDNuYkJQMnE5Mm00QmtoWUJLOWVF?=
 =?utf-8?B?Rjl4SC82dXdId0p1QkV3Qm04WmcrUGNIaGlnb1lTUGt6SGJwVUR6RmhDbWhs?=
 =?utf-8?B?MEhwQjZ0MlhLdmZTVmYzTzBYN2pDYmUxMklhanlaZkVWd1BMM1VOVDUvdW5o?=
 =?utf-8?B?dExEZzlrY0VuaVprUjdZQ2J4UmVGa3NCQTBnSEtpNUxmZGJyY0lTb3N3Ny9o?=
 =?utf-8?B?TEJEQVFrNHlFaHhDUUZLS3ZlK2xPWXBQT3RFOHRmTWVGQ1BJcCtNbXBkVkda?=
 =?utf-8?B?dGEzejlyUWx3QllWMnE2QXVCNDlNSS9NRmkyRFpNYlp2ZDRjR2hVVlRjZEtG?=
 =?utf-8?B?TlRxTFE3VWI1U25aOTQ3b1dPOTdmMzhaMDZIU1Z6MVN1aVE2RlVBV3k5Qkl3?=
 =?utf-8?B?bUgvVHhpN1BkaWVuSWdMTDdJbGcweTQyMXkyMTBCWDdMUkx4M3NhV0MrcTdL?=
 =?utf-8?B?RDdKaDZtTDI1Y1hoMXBMRmxpTnhwYTZIdkdGWS9pbFV1U0YyV1FXYitCWGlW?=
 =?utf-8?B?ZGRzQlk5cjhuMElmZVVYQ1BBS1RLcVdCNXlsMTU3K2szUHNHRXFYcjVGQXhm?=
 =?utf-8?B?UXE4WTVjNHJQZVJvdGhOK0Q3K01zdVhHdC9WTEFQMTZ6UU02SFdScFM5R0ow?=
 =?utf-8?B?dUFQSWNxL1h2QTA0SDAvSEMzeW5HNjRLMHdydlNvMkJWSmkraE54RW05Uy9I?=
 =?utf-8?B?Yk1MaEZXMmNJd2U3a09nbkNLWmx1cmRzb0swNGF5QUZLeDFJdjJVRjBkc2Fo?=
 =?utf-8?B?TGZyMWZ2R1hVYnArNGJVbS92RE5KQVp6QkpiMzlVSDd2SEtoOEx0UmZCS3Jn?=
 =?utf-8?B?TTFmWFZObk1zdTJBM2xabUN3UUZnbytiNlgxbXlzZm9iMFlhamtueTFQRXh2?=
 =?utf-8?B?N1pydUY4TXg3ZllHRE9ZYmlPcTRFdkZSTDNNTXEwK2MwY2FLTnBBU3lQTGIy?=
 =?utf-8?B?Ymk5U2RwSVhrb3VMb3lHV2hOVmViNklBS1kwMUlIcHNQRzY0SUI3cDRTb3VM?=
 =?utf-8?B?a0hkeUkrdUc3NVJ5QXY1WFVSVUZjcGdUeng4T3BiZFd3UE5WM24wR3c1WlFB?=
 =?utf-8?B?MGV5Y1I1RUNXM1BXeVArcHYrWTVnOHcyRkdjVmxJZy9OSThWdVZtcU1FTW5j?=
 =?utf-8?B?bHkwczFHK2dnQWowelkxMUdyNGpvRXcwdjBRa3pXR2ZFcEd4NTFsNjRub2M4?=
 =?utf-8?B?SUZNYm1mbEsrbUNsdVFYSkV2cDZjZ0poRSs1bnFkK0RtdkpBaUkrb2xBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aSs2cUU1Z2tQUmxBdjhWVmh6cEpPc0ZJM1ZpSUp3dDR2QWNnclRpcnRMckZs?=
 =?utf-8?B?djl6cHlCWnZ5K0h5OHZidXZsSXdGVGhTTnk2NFN0Q3Z0VmdWc24yRVA5N3RZ?=
 =?utf-8?B?UDR6Z3o5ZFFIckRVQUd5emhhRWtJcVFQenF3UnZXTXhuQzYwWTIvajE3TG5B?=
 =?utf-8?B?UVRVd1QrK3lOT3ZKa0R1S1BDUS8zYWp5MnMvMDUyMVJGQW1qTytMREM5bXh6?=
 =?utf-8?B?ejJNR2RJYUJyY0ZtS1I4Sm82YlRiSHk1cU4yd0tpU2pYSzlSUHdDYXJpRUZk?=
 =?utf-8?B?OGNML1MrN2JBV1BIbEZIbkFtT1FHNzhqQWEweWhTbjIrRDhqelZEek4vUmZJ?=
 =?utf-8?B?SU5LT28xQnM0d3FkQkYwdmxYN29YZzg2Q3FrYXFSa3ZGREV5TDVTQS8zMmdD?=
 =?utf-8?B?WEZkZ0tSaGRTZmdFamlYMmE1RGZSd1VuMUEvQ1dmNzc2K2V1a0FOQkZ2SnRO?=
 =?utf-8?B?WEFYZzFWRm9CQmxKcFdwaTkxYk1EWXJDcDdoMWUza01nN1hZTHFuMi9oTlA0?=
 =?utf-8?B?b0o3bEVWNW5tcnBRcDdkRm1SOTVKczNtdVRNc0ZFajRLSmVyTjNtRWJtZyt2?=
 =?utf-8?B?Q3FVWlV1enJLNFR3SVVydmpidjlUTW9lZ0ozTGJSK1NBL3lrMGVkdXpSVDJ1?=
 =?utf-8?B?ZEo3bXBFYUplRStIZTRvMUFIcFB5UnUvbEhjeTc2VUZXOG56Nmd6a3VYTkVB?=
 =?utf-8?B?WW52VGFDczdXeGhFdWw5SXFpcGh6SDhHY3huUVpOTGNSd2NFZ213M3hSVGQr?=
 =?utf-8?B?eUd3OS82b0pPQ096dHFVWm8rTzlIQ1ZVWm1WbTRUcStUVG5DRzZnVU4yVE5q?=
 =?utf-8?B?bnZNMngxVmFOL3JjaW1oMGY0TWRUcys5R283cjVKTHRRZTRDOVh1cFYvcUtY?=
 =?utf-8?B?Z1Q2Sm40ZTV0Rkw1aWJ4TmFZZ3NSQVBCclJKcE56cVZNQTV1dWQya01qNUt5?=
 =?utf-8?B?eVlwK2RORk9ablZjcHFsWGFnMGh2VGJ3c09WMkd1MzlUYmZUWFBEOWo3NXJL?=
 =?utf-8?B?NVRUQWp4RGQ2RXdDMzJ3Znhydm9VL082TE5meFpqN3NUeCtUNm8zTy9ndExu?=
 =?utf-8?B?QTcvVUV6Y0I0dGVhaWRwR2VKYmE3aWQ4dXc4RFdBaXpuQlk4THUwRUgxZHNk?=
 =?utf-8?B?eGRFT3o3MmRuTnAzM2lKL1NzbWtuaWFVSjNYRWZpZW9CYWR5dkRTdDVYVVNY?=
 =?utf-8?B?OVIwQVBIYVBwZFh6cGN6KzBNeE16cTBqWW5MaWFHTTdxbzhxT0ZvYlNxcjUv?=
 =?utf-8?B?SWxWRlNhcVNsV0Y0bXZ1dGNZdEplTThuaXhGSWc0WVlBcDVHM2c1MjNVVkJh?=
 =?utf-8?B?NGRsVVdQWnRPK3NHZmpKbXVzTTlFYzRqanAzeFhQUFRSelVRaWNSUERFV2NT?=
 =?utf-8?B?MFdPVlZTdXUrd1RQYlpFVDU3SjQrSUIwVXlTVVIzTlVxS2tTZzBocEpHVjRU?=
 =?utf-8?B?VUsvQnRPY0pCVThrZjRIMmxNRHBVeWdITFhyYWdqcEFDRlI1clBTLzFNK2hK?=
 =?utf-8?B?QmlMcjdUODd0NU15M0ViTnJRdlduZ2RkTXpjUW5KOXBLa3VVS1BTV2RRMnBQ?=
 =?utf-8?B?cFBneXpYRTNYRjIxREt6WWhnd1lRVTNpTXh2Ky9rSk5iZjcwYmJlOHJXVzFX?=
 =?utf-8?B?ZzhzRDlDS1FPMGYwZVprMlFRcldYM2xTU2ZjMWRVcHAzU0NOa3JtNkhMcmVK?=
 =?utf-8?B?QmRkdTJheHRkN29lTElNTHhUQlJyYi82a1JEZzhMcjBzcXA2cnNnbzNsSDNG?=
 =?utf-8?B?eFhjZ0NGVWpKWTFudWxlYURocmNOVVhDbHN2Ym5yQlB4bXdCbloxblVkcjVX?=
 =?utf-8?B?RHVaTjMrOUV3dXEzaGp1Q2FHRktkbHFqRUlnU3lHWnE5ZzF5c1ZiT1dSMk42?=
 =?utf-8?B?cHBkMUpHMm5PeVBTTEFrWW1SY1ErMHVQTU9OaFVIRXZJaTYveVl2Q0ZHSGlP?=
 =?utf-8?B?eXJzU29RMkFJMFJ5L0oyaEM4aXcwaFdtWkE5YW9FV2pwcWhQR3lyQWtjTkw2?=
 =?utf-8?B?SmJDMTBjalRUeVF3S3RaTXZwQUhaSW5majB0c3NGNnNiNUVVR09jdm80ZVVM?=
 =?utf-8?B?a1FEdnppNU5kM2RVdjVHTGpDaVBEanNmZ28vQ2RtVmh1L0pPZHZMRzN2OEFX?=
 =?utf-8?Q?GLL8uPAGp5xzgIPbtUgmVMWjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f23e480-91af-418a-2dcd-08dced448c29
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:09:44.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcAL+EKbl2w0H7JC1T4BwpgDpIKGNgiu1S0u6PL4nuAJG/CVH1N68H6RQPViZDP2ywJkLeFRHLOf8LNZWue8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285

On 10/14/2024 22:52, Ricardo Neri wrote:
> On Thu, Oct 10, 2024 at 02:36:57PM -0500, Mario Limonciello wrote:
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
>> provide behavioral classification and a dynamically updated ranking table
>> for the scheduler to use when choosing cores for tasks.
>>
>> There are two CPU core types defined: `Classic Core` and `Dense Core`.
>> "Classic" cores are the standard performance cores, while "Dense" cores
>> are optimized for area and efficiency.
>>
>> Heterogeneous compute refers to CPU implementations that are comprised
>> of more than one architectural class, each with two capabilities. This
>> means each CPU reports two separate capabilities: "perf" and "eff".
>>
>> Each capability lists all core ranking numbers between 0 and 255, where
>> a higher number represents a higher capability.
>>
>> Heterogeneous systems can also extend to more than two architectural
>> classes.
>>
>> The purpose of the scheduling feedback mechanism is to provide information
>> to the operating system scheduler in real time, allowing the scheduler to
>> direct threads to the optimal core during task scheduling.
>>
>> All core ranking data are provided by the BIOS via a shared memory ranking
>> table, which the driver reads and uses to update core capabilities to the
>> scheduler. When the hardware updates the table, it generates a platform
>> interrupt to notify the OS to read the new ranking table.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> I tried to find the HFI details on the documents in this "bug" but I could
> not find them. What document in specific could I look at?
> 
> Thanks and BR,
> Ricardo

Hi Ricardo,

It is spread out across multiple places.  This is part of the reason for 
patch 1 in the series outlines details of how it works.

The reason for that "collect all" Bugzilla for documentation is because 
the URLs for AMD documentation have undergone changes in the past and it 
makes it difficult to put stable URLs in commit messages.  So teams that 
want to reference documentation put it on a dump all bug for a stable 
URL to reference.

On that link you will find the APM, which will have some documentation 
specifically for the CPUID leafs used for topology identification and 
clearing history.

Read patch 1 and let me know if it covers what specifically you're 
looking for.  If it's still missing some info let me know what you would 
like added.

Also; I do want to note something; this is the first series to lay some 
foundation for static information and not everything in patch 1 is 
implemented in this first series.  There will be further follow-ups later.

