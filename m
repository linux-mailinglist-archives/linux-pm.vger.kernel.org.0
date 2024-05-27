Return-Path: <linux-pm+bounces-8181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE578D0538
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD071284A56
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545317A922;
	Mon, 27 May 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jDBU2UcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765516D9CD;
	Mon, 27 May 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820884; cv=fail; b=lp1FgQx+WtNpRTL7PNS1KajaJ6z5IlibXG+2rUZi4cD6EkEAMii3VjifOMSC0XMxExQqcfnELAi23ZuayYr1xC3sbZMVjq03JN2aVhlrf2+Rwsg/5D5huqEU0r+/RFIIeuT3m2E4TavilqUvkHim3Tzmn4YPorZP/Te11fzffiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820884; c=relaxed/simple;
	bh=7DyX2i10i0IBg1RNBduHmj5Pl2DlsrsJLKF6uF8Qrbs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MKYCMZDCe0yMKSGdPwpxSBhg86vT+XOND6o/f2jDkW+++lD8oh0JSzyYxscDr65hBIHgc04yiUIgl85Gma5+DCmHd+KV3D0+mkO8gGGDgFBZhqvg9o5Zi+9IwE6rT6XDXZw1g3LOnUmsvumDhS0Cggokim6apABrWRj7mtxQjjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jDBU2UcY; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8PkG0dCj3129qdzcguFtP97DM5xuQkReod9lNa8uqqa6TEbkyyVnToVe9WRtyaNNX+KugbcrDXXvpFryCpXfrO1OixDZawl/1c8bFonFjkIn6EEgr7Q+nz34OvaKcc18ZQVNougHzFWzH5g67BtYlwvFOOV0mDxFPcNxWkqhm1brUj1qK4l/3FbTGUoMWLX5vXnhQ4Mm62DOAq/hnAm8lQS2PmJ2L33C0DLskZUhLvHdl+oD173h4Lkh7WSvCXxcQDabt4oEs/0hmGWJN33A9Mr2HEbqfQ2V7cF+PrVvYZNPoo0Y24cHLaQUsVKGATX/ywV3N3z/ktiDSgzy1GpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1ZR4e06RefIWA+n8sSnXXJTcXgFAt1CnObsWwc/Zqw=;
 b=RGljhfHUmOr41Zwc+v/ARjPsZ8MuVMp1KsVI8ZjKk/EpSaSQT1J2IvzQWHyCRQm2bqOzd4KpNCetyhws0muR7HIS2SVpOb1aiYNkBJTZLlN+1W7cj92fckI4LaisVVq5+SQQKc6OLTssxNswD8KjczABBE3B8BvtVPDLVPAt/PaDO76LWDgdZQ/UMAgZKNnquQnwh24LmetVVESfJthjhyEzEkJoUR7dN3b5URQ4wzmnLIQrxo6DW1851VQ0YIFryFBzm/zTZ64/dYh3vRk58j9QG+8iE7WsfD3s8AUbAjIsNS8dcGnMVI3rSNLsosws7v7ON7nFqmTQHDusf2xC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1ZR4e06RefIWA+n8sSnXXJTcXgFAt1CnObsWwc/Zqw=;
 b=jDBU2UcYX+YFwNIdmSvHzA/DSULgCHD+WRDOlo41jTOG10QcdbxErlWUe5m937tBfLHUUkLwq3y99G18WrgSce5G/TC6SxVRVlPCUFfCzeVk7lOLc+a0+BSKebtpQo19dWJfCPDOlGhf7FiBKj47niglQQ3DtWuj5VsIMEEM4+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 14:41:12 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 14:41:11 +0000
Message-ID: <380be0b5-ad35-2dd5-8bbb-093399053ec9@amd.com>
Date: Mon, 27 May 2024 22:40:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, sandipan.das@amd.com, kai.huang@intel.com,
 ray.huang@amd.com, rafael@kernel.org, Perry.Yuan@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com, mario.limonciello@amd.com
References: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
 <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
 <20240523223501.k2bcmvmfbvbxiuf6@desk>
From: Xiaojian Du <xiaojidu@amd.com>
In-Reply-To: <20240523223501.k2bcmvmfbvbxiuf6@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd332db-576a-48dc-7fa8-08dc7e5b0d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDRjY2pDWnV4SFV3YjJaeElsQ3prZmtXWFFNVEYvNmg0Y2E1L3dpNmRMaU1C?=
 =?utf-8?B?eHhCY1RNMGVzTkwrR1cvbGQyVEYrY3kzR25Sam1tR25BNVdLbjdKV21aQzBN?=
 =?utf-8?B?SmNRcUVJdnNrNjcvbGtVeGtNcGU4NDVJRys5YVprNTZMSDE4dDVQZW9vUE1R?=
 =?utf-8?B?VzNVV01yelg3NC9YRys5WVE0M0dweTFpRkVFdGlmQVhZcjhpdHNsUWZqT29h?=
 =?utf-8?B?LzE4elVXTnQ1MW92VkJjTmxiYlhWOStISWVpYXBaWFIvM3RqVHdjbGdLdDFI?=
 =?utf-8?B?bmxvM0pyRTVmTWJnTm1yUVd1bjArUjdhZDlQaTFNb2tpNEZCYzB1cFFkUkFJ?=
 =?utf-8?B?K2p5Y0QxUnhFSFRhL0NrSnZMUGc3YXlZU3orSWMyMVhNWndYS0paOExZekJw?=
 =?utf-8?B?aDJNVGhzb0ExV0t5UDU5YlhuWDgra0ZqS25GSitvNG1uK2drMjg5ZmlmcEdD?=
 =?utf-8?B?RVVqL3FTeDk5TmtCQ3kyeGwwR29YeTV2NXpIMmVubmRrN2dZQnQ0eFUzOGV1?=
 =?utf-8?B?Tk85K05TV1R1d1JSbExaOWNNbUNTaTVQVWlXcFBIM1E1MHRxRUJsYnRIWnc4?=
 =?utf-8?B?YUtrRHo1Qm0veU5BM0g1cU56U1g4cTBCTDVnVHdDOEJ1WUk0bWozbUdBdXd0?=
 =?utf-8?B?Y0VaQ3RMQkUyN0dUL2xTUXFLbS92VFdidWY5Vkl3eWdQOUJ4a3hXUlo4MXVz?=
 =?utf-8?B?U1owK001dWFpL0g3OFRXa1RFalNuYkd6c3pqMklDNnFrcWFnTmhObDVobFMr?=
 =?utf-8?B?Y1BEMld5TWVvalYrSHVUWThpa2NxcEhTSStYa0plMW1QUUJ1dzRMZ2piTDFw?=
 =?utf-8?B?K3lVU2VmOHhIWFBRNFNIdFBxOFQzbVFoTHE3Tnp5bnlNa21rQVNWNmZPUFJI?=
 =?utf-8?B?RzhjaFB2ekVkUlNTZEgvWUY2bS82SmpRTlJpaWFzU3JtMVJhTWRjRDhHS2tB?=
 =?utf-8?B?TDhsQUxTVUJsZG1GTG90Y0plSCtkaDZwdURQbXVBY1NvT3RFZE1GejFla2dy?=
 =?utf-8?B?cGg5N3liNTgrWC9sZ2UrZWRQUlUzdzUyeFYrRjRWcHFBQkdoa00vQTl6Yldp?=
 =?utf-8?B?cmhMckFNRFZuN2pmbG45Ym1GSEpuRDFKL2k3RkU4U1RKckUrdkcrK0czZnYz?=
 =?utf-8?B?VkRlelZEWThWdzVnUWthdTdoazd5eHZUeFNYbzlmd0o2QlFwa0xLR0JMZk9D?=
 =?utf-8?B?V1lWY2owTmU4U04xZ0I3YW5KdUtnaDd5UDh3b0FQbXRrd3Q1THZOTHo2OFRQ?=
 =?utf-8?B?YWVKS25qZE1DNEg4VFZPOFNFem1WS2xBb2VQbGxhRmhUMC9XWkFsdGdxUk1G?=
 =?utf-8?B?Y0ZYcGVRbHFHRzlzZmplTHc2aU85eHVjN3RmdVQyMmJNSVZNQWpKaDNsYXdt?=
 =?utf-8?B?djFwZWk4N3FuY3M2OW1vQUl5MGVzK1NJWEllT21HR2RlZFBuZE5aL0N6QWpt?=
 =?utf-8?B?WEk0emRKd2M3ZldQb3pCQ241L2UvVkw0VUF1aG05RG4yVVFvbGVuaGY1a0kz?=
 =?utf-8?B?VHlWUWJDVGh3dXFHMzRRbFVUSVJ2Tk9aTEJqZFZlbjhPRGtsYXM1a0NOZ1Jj?=
 =?utf-8?B?N09ndDFBSXpOUjI5SzVhWktpRkY5Ky94b08zdjVCajVqTG9hR0FDN0lqOHFa?=
 =?utf-8?B?RHcyOU53STBzM3NtT0xIdThyaHU1VFJHamFHR2l5anltcDFUbGM5Y29sZEpx?=
 =?utf-8?B?b0RwYkUydHJVWVNScUtYYjMvYXhETlJwdVZxNFBHSEJUaFAyTEUrMU9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExMaDNuVXV3WGtUS245MjRjTDJiMUdOVmlSZHcybzRPYmpHWHlMRUg3Wnl0?=
 =?utf-8?B?bUlLMXFXTHJPNU9McGNVNGhUZ2xUc0F4QW5TUzNkclpWTktlRDE2UU9IKzN0?=
 =?utf-8?B?cGpBazFpamdVYk5jdlQzL09DZC9YRG52RWVlK01IWXpQR3g1cGdWQWs1QTlu?=
 =?utf-8?B?S2pjWFVaSmJ1aDhrTEF6Vm5yMW5XNVJjMk1hRWQzdENrYWNwOHZybG95djN0?=
 =?utf-8?B?MUZLdlpxRGJtMktNaFpTeVlxVEZxWXl0ZTA0cG5nYythWXJSWldWNlZ0bWM1?=
 =?utf-8?B?WXB6azU1SWxSZjZBcFlzMUNFSmdUZU1HbDA1aDdzbk1vKzZacmY0Vjh5NGNM?=
 =?utf-8?B?VnFjdFB5V0dUaGlKSWs2OE9pOEwxOHVOM0ZZOWRiL3ZBM2JDdWF4WnJSaE96?=
 =?utf-8?B?a2pIVWJmYzRGSnd2SG1SZC9GaGZtSXlDUlVxemUrSEQ0Tmd0dU9icjd3VElu?=
 =?utf-8?B?NXN2clh5VHNPUVRZci9FYzhRNkFYTGhxRFJGbjJCVkcxTVVmb2lXeStLMzFU?=
 =?utf-8?B?S21jZjk1dW9GeEFyalJVOGZiMTg2VFkrUktUYmVsMGptWVFLMnZ4UVdHdE92?=
 =?utf-8?B?c0VkVzNMbnFreE1GRzM2bGNSVE5SeHBLUjFOSm5idDdCZTBzU0lRRmxBZFBM?=
 =?utf-8?B?dVN2UitPMUpBelRLVnM1UUppWTZPS2tuS1NaZzdZTVJ0dzM0RGsxazk5eUNG?=
 =?utf-8?B?MUQwb0RXZTdkMjN0QjhJZjJiY0tTVlI0VFJuYldMSDdzeU1BNC9tZlpaVjRv?=
 =?utf-8?B?V2d4ZTNTMnpUVGlLMlZuV3VYYXZTV1BkcWtxbkFVLy9jeW1lZU5MWkIxRmlM?=
 =?utf-8?B?S1BYbUdPQzhXdERWVGpDSlVKTzg3V1BUQmFxTStxZytpZ1BvU2hwSG5ucXN0?=
 =?utf-8?B?cnVybkZjSy92ejRUL2c0WWt4clJzM3FVK0ViRzh1Q0J1amxReWh5ZzZIWkMz?=
 =?utf-8?B?aEN2Mm9acWI3UkxMZmI3d05xaFdmVDF0K25nZFhXVTJFVUhiRkNXN0xVUFhU?=
 =?utf-8?B?cGVucUJPcGlqRHZCRVZUYU5KMDc2V1NsRHhjWFFRZ0Z2YU1MdXgrOFZXYU5E?=
 =?utf-8?B?Z0JiSGQrcTZKVnNpZkNKb2hKb0UvNlJwbitjMVBzWXBnYUJEc3FzdUhkNncw?=
 =?utf-8?B?MFJzNEpWY0lnSXAraUg4TnZvRkl6aXQ5SzN1dnpjTU1UODVqOUkycWQyYnY2?=
 =?utf-8?B?Ymw4YkF5ZVNaRzdNaXllNVpud3c0NEs4eFR0VHU3SVJwNGlZMURkOFlZOGFa?=
 =?utf-8?B?OHFzOVR4V2RlcE9GbWJzTmoyM0VKdk9nQVJxTlR3NWV5TnZWaTI0TEovNzlT?=
 =?utf-8?B?eWN2YUtvK09qV2xkeEZOcGJJV1l6Z09YZHB4M2RxNkRwQnpjTnhuR21MSjVB?=
 =?utf-8?B?bUNqSThWSW5NYU5MU2UxVTE4QnMwS01DWXJDbEhQV0t3a0V0ZlNsS0JaYXFk?=
 =?utf-8?B?bUdzTWUxeUN3d3RwbGhkSHptbFdBYVJhMXpMU21WaGx1WWtESEQwTktEd0RH?=
 =?utf-8?B?QjBkUXZIWXp5Q1BXSWwxMWRhUmFML0NPVm1rK2FuY2w3YmFoMUpkd3htMUlT?=
 =?utf-8?B?bVdteDBiYjZkTjUzYXYyMmZmd0dCTThDemxTZlRUWitjMVJ1TlVRWXIzNTU5?=
 =?utf-8?B?NjRMWjhRajk0QWNRVzd1UWlvOFRsNWpBVVdMUnVjRStLVWJmVFRQbXR2K3F2?=
 =?utf-8?B?dithZjZhZWFSOWswRS8vU3ErMzhRVFdpOElEYVlKek1xTHFBZjBpdm9sTmpO?=
 =?utf-8?B?OC9VMHBFekNXb2dGQXRhaEQ1SHhaZmMrMUJVRFFjQ3ppTjcvRFcrUGZZYzV3?=
 =?utf-8?B?WDNzN2o0TWRXeE84cmVhQUJWR0gyRmxUZGNKQXFHZk85OWhNZEZkcDd1TFJ6?=
 =?utf-8?B?SFZnalJGNWxVQlVHcnBmTXc2WXhKaE5rN3AvMlUxQ3dJNUdXSyszUEQ0Zncx?=
 =?utf-8?B?c2ZoNFpEZDlVRUdZUDUvR01UNnY2SlBrZGYxc2gwUFl4Vkl6NDVzTmpsRjFV?=
 =?utf-8?B?TVJ3V1QycDBGc05wWWVrdnNDYkZJbjdxbGkrMjY3c2xvTTJBK3hHWVJRa0ds?=
 =?utf-8?B?Q0JhRDVDY000bDNWcWJzcHdVR2VpM1RjVVhXVlcrYnAyM1JycEFRL3hkZFFX?=
 =?utf-8?Q?wR0BUWQopEM+cdkCJz7YfgK0z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd332db-576a-48dc-7fa8-08dc7e5b0d9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 14:41:11.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2KxKx+2KhDhriaQzaYYNm74NR+TPYhYd72eI5Si5Aq6Hir64ph/tzIekq+/p1lgPlWZ1zqZeIrrsjqQ1lz7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

Thanks Pawan.

On 2024/5/24 6:35, Pawan Gupta wrote:
> On Thu, May 23, 2024 at 02:16:59PM +0800, Xiaojian Du wrote:
>> From: Perry Yuan <perry.yuan@amd.com>
>>
>> Some AMD Zen 4 processors support a new feature FAST CPPC which
>> allows for a faster CPPC loop due to internal architectual
>> enhancements. The goal of this faster loop is higher performance
>> at the same power consumption.
>>
>> Reference:
>> See the page 99 of PPR for AMD Family 19h Model 61h rev.B1, docID 56713
>>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
>> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
>> ---
>>   arch/x86/include/asm/cpufeatures.h | 1 +
>>   arch/x86/kernel/cpu/scattered.c    | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 3c7434329661..6c128d463a14 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -470,6 +470,7 @@
>>   #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
>>   #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
>>   #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
>> +#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
>>   
>>   /*
>>    * BUG word(s)
>> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
>> index af5aa2c754c2..9c273c231f56 100644
>> --- a/arch/x86/kernel/cpu/scattered.c
>> +++ b/arch/x86/kernel/cpu/scattered.c
>> @@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>>   	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>>   	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>>   	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
>> +	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX,  15, 0x80000007, 0 },
> This list is sorted by the leaf level, so position of this entry should be
> higher:
>
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index af5aa2c754c2..09e0e40dce6c 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>   	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
>   	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>   	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> +	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX, 15, 0x80000007, 0 },
>   	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
>   	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
>   	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
>
>>   	{ 0, 0, 0, 0, 0 }
>>   };
>>   
>> -- 
>> 2.34.1

Changed this position and sent V4 patch for review.

Thanks,

Xiaojian





