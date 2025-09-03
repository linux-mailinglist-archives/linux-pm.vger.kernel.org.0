Return-Path: <linux-pm+bounces-33694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE77BB418E3
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 10:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB251BA45B1
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B12F0C51;
	Wed,  3 Sep 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="iylZ97Qy"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010019.outbound.protection.outlook.com [52.103.33.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F82EFDB5;
	Wed,  3 Sep 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888872; cv=fail; b=pk5vpVwpSpNJh85r6IHynKac5gx+kbaiwwq8UYYj854/m1rWDoGyx+ygYmEHe+OMqnVHbkRLWKI8bkP+wmMrTPxGcCDp8gqC/+SQGL1vrbjTTsmBb7Ru5asjDfiRVNPWOJE8GfITe/DB+lck62JVczmlzgSu5/Y+kyildcbVA/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888872; c=relaxed/simple;
	bh=n1Y1sPCUFpnOeP+PEKDpaGL8q+TzgT7J9PBsFgASNIw=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OhuqXPuREL9Cg8YqD5JQDHcI4lNsOTg8EzjyKKVhWF/T1C/r5eF7BbnRhYzwSQnAPYk4ypsG2C2QnYfAbTv+pY3XOxFc4UwT3vSR3r1ZXAazvyeE+5v1dn44JEq0QpFpN/0numDLCH+vZDv+P7fN0lfMJbDz6wVNl76SKWP16JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=iylZ97Qy; arc=fail smtp.client-ip=52.103.33.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psxE2lsnx4DtlJQZsA317YevQIIAatVht5puNERBs4yXRnTB/A8qdxFLs7PNKcGH+4lztYlh2vOx980nDZ5q3D+YkgfWP0ZnXX1zVCFzsXBXkcONQk581ljJasaB2Fb7ra1kDBB+AIkAtv3TRRgeXVM3LPXcOQmDgNC3YApw6GxZF7DS37ZKxk3I7eKCX0byc/8lNPKFDamriphKJbifFTuZx5xNcF+9Gfh8CghcMTR3g63kp7xgvsrON4oMsOAp2iQx5XIXNNSfEzgBSYd467q++Ym2up66J6IHkdSnLTs+fTuEjwDH+4CBL7wrTF2SrMXcm2pOrwFDBWRiSbGGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHwPSVMBjGEXR1SKPAtuWsazj7c+2dO8K78V9W0fwO8=;
 b=TUWl9g8wZ96LE+dle09MVhG2efOKafrw+fXNHnQ2hKkZuz5/4Op+UvpVrGzlCgCGKqcpo99vdBVO9mB5/Qwl7Ve/InyctQ8Q1orxANIXevXKem0p7kQDRFKweQqDfhfRMg3vMKXV3bibo9IVttjE9C0ncKLZGbHIGMJsXpgoqxmnrQNqZh9HdnykdKMlpJOcYqiR9zX7k54xXJ7JI/bmSCLLABOb9yGJrujgriREv0biDYzN0//3DlvQqeFyQj2K6ObkiGLzvuRwlIqDI/VUuJkuGFkbL2OR/QvX/A9/RKMsxCEhUsaHUloeW/Ug8FBcpmC9C3I4PY3sLkI8qU0ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHwPSVMBjGEXR1SKPAtuWsazj7c+2dO8K78V9W0fwO8=;
 b=iylZ97QyvzcGrIVCWttyYlTPHQR6liGR9r8I06ftEFfGZOxTz7dF+mZGowXAOlHgBQ1z0ppa96C/Oqto9yMcQLmYcw/h4tPoGKwVFnBuCYn+xehewdECdfEVjIesgxIP55bpG4qqSl6yc2Y0fpkyklRV8/a65F7Qu/8VLautTNxBFgDmAmO3cEjqDlE6EcgTIByYW6xBvT3JvOgPUFapMyGD1CFTJ8TaSE+pUZHgzhUvDgxc9oEwboONqBrECwiIOnGFgQa+pZsFueBbFF1SPOezSg7EsFJ6AfjY0KbuxrvE1P2NTMBwBwEqzEDlGCwbKiItgxFDxtzxq3UJ+YftgQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by PR3P189MB1035.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 08:41:07 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:41:07 +0000
Message-ID:
 <AM7P189MB100958EDD985483DB1F32EC5E301A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Wed, 3 Sep 2025 10:41:05 +0200
User-Agent: Mozilla Thunderbird
To: devnull+fenglin.wu.oss.qualcomm.com@kernel.org
Cc: andersson@kernel.org, bryan.odonoghue@linaro.org, conor+dt@kernel.org,
 david.collins@oss.qualcomm.com, devicetree@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, fenglin.wu@oss.qualcomm.com,
 gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
 kernel@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 konradybcio@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, me@kuruczgy.com, robh@kernel.org, sre@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com
References: <20250826-qcom_battmgr_update-v3-8-74ea410ef146@oss.qualcomm.com>
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: x1e80100-crd: Add charge limit
 nvmem
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20250826-qcom_battmgr_update-v3-8-74ea410ef146@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0065.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::8) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <343ef088-9147-4b3e-9f44-32dabd4e0ae0@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|PR3P189MB1035:EE_
X-MS-Office365-Filtering-Correlation-Id: f48c21ef-945c-4164-a23f-08ddeac59f56
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|19110799012|8060799015|5072599009|461199028|6090799003|23021999003|15080799012|52005399003|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWptR3N4R1hHQVhMeWw5QUw4Y1hNTDhta2tsWk83Mno1V04yUE9uK216QTNj?=
 =?utf-8?B?Wmw3aDVkUC9GcE45bzRJaFZuVWJicjMxVStVY3B2YXp2eDV1QjdsRHBtSk5k?=
 =?utf-8?B?K2R0ZXd6QWJuMFF2clA0aGdqSUtVUmFPejRxVmd3Rk92YnIyYkpqM1hYNlVm?=
 =?utf-8?B?dWZLbytlYjN0OVlaMWlFbUVISktqU1FVWURPb3pYSlJweHNhSmlQbEVUY3Rn?=
 =?utf-8?B?aXNNNmIyalZDYWNhdTZCais4dFFWYVQ5WWJiaHoydmxZYk1UYzE2bTZvR1ow?=
 =?utf-8?B?SXZMc3hWUDJ1UUQ1NHVTa3BhMTJ1bXBydzRSVUFZRUdzb0R2UlRmT1FRaVE0?=
 =?utf-8?B?SkFyNlgxbGw2UzI2SzRKUnA2bHJBVXNIK3NmUXUwTUxrVGdOWWZGRjRuWldo?=
 =?utf-8?B?ak9DT2JUZDB3bkJRSmREbUdNY2o1Mkw3L0YyanRjOERFZFFUczZXV1hGSG5h?=
 =?utf-8?B?UzdXYlp0Z09YdytuZ3RDZkYrcko2c2xveWF6WnRqS0RlbjZSb2NBdzRhMnRF?=
 =?utf-8?B?Nm9Dbm5mT3VEdWc1RVkyd0xqd2VWdlNpQlo4UDZkeHRFTWNXWU5UeElDTGN4?=
 =?utf-8?B?bFNxeW9UTUtvR1NKM2pjRjVlZEkvczlpMFIxa3dURzBTNHpES2ozejltU3d5?=
 =?utf-8?B?dElDb3ArblVYanJOajgrd3JWbHVTZUR3VnNrcjZvNWVWd0FJdjV4a3UvNEJU?=
 =?utf-8?B?OFRyOS9uZEdzdkFDN3ZVNUpTc0prZ3RHQWZISjQwVmhINGVkdnJrZEp6a2lF?=
 =?utf-8?B?NlpBeHpIajRJdHd5MklveFBsQ1ZMVnlDeENGNUluZzIvVzZ5d0x0aFdNTHp5?=
 =?utf-8?B?eE1pMC9ydExJSjFzSm9zYmtSS2gyVmQ5ZTl2Tk1zNkp2cmkrQ1RvTGY4cXBC?=
 =?utf-8?B?Ym9uUjZKZmgyVTFwN09QVWNaTEFJWElHc0huQ0VyTzN0NWIvV0xTelBuWXJT?=
 =?utf-8?B?NGpWa3JmRVR2dFdLTHdqTEpTWlNNVHRHZWoxTzVUUDB5OVFiYndHa3Z4bkpO?=
 =?utf-8?B?SXB4bWlUdG52emZtalgrZ1I3bk5ML29zSlRNcW5kb3AvV294cVIrQ2dNTGRh?=
 =?utf-8?B?TkwySDJrcXpTOWpBTEhmd3h2azdvYTY1MzFCbnl2RlpnUDZOUC9VUkd2VG8r?=
 =?utf-8?B?VlM3bkQ3ZzV0aUM2bmZ5bjRlcTN4bTlWUzBuSVRzR0d0NFUvb25VU0FoVTYy?=
 =?utf-8?B?WGwzcmdyTzVDWTYyekpLN3dhZFpDMklQa1NTM2VKN0twN0dDTno2Wlg2VHVN?=
 =?utf-8?B?NFlCUnBKYjNXN3ZjYTlPQTVQbkViZHN0WHBCbmxUWnZQK2ptdFAwYW5TYkFQ?=
 =?utf-8?B?eFBaVm5NcE9FQXZyZTVXa2grd3NTSi9hSTV1N0NFODZSVHBpanIvcXFaQmUx?=
 =?utf-8?B?NHFQc29ad05Zd050NlA1L3pyYytVVEZrNFF4ejNXYTNoV2oyK05jb2FlUHQw?=
 =?utf-8?B?K00yRVFGUFN4bitmSGVmdENNQ0UxeTRlZ0lTZi9ma1UzemZqdEFXMU9pclBR?=
 =?utf-8?B?Y0pQdkhNRFoxOWFteW5vY1pDM1R2NGRGNnBUMnZBSXlEVGlPZU5iRVhMdlFK?=
 =?utf-8?B?Wk5YK3BLWk0ram9hUW5FUVhTZDJzWXJObHlHd1NVWWpLR25CdUc4T2szR2R6?=
 =?utf-8?Q?VfX4gG8QNxtOvixUeU11tyV8Z0NRuZEhIOlINg5tZnQE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjkxaXo4eEE4d0lINmJkenlodWI0MDRKa056bXdqMW9XUW5hRHY5VDVuVkU4?=
 =?utf-8?B?bkVPQnZlWE5JSG5YNGNweVRmZ09qcmpqcHpYSVU2UE1vKzF0QnhZTDJITHZB?=
 =?utf-8?B?THN6RWlGay9JWTl6TXdpVHZMdG1XNm5mVE9oWkNmRmY4OTlkY1V4SllxVEZR?=
 =?utf-8?B?YmdEOGZJbTVuN0JqQ0Yzd2ZaVjBOTkQ2RFovZ1F1bk1qYlFTbEVWLzlyYklh?=
 =?utf-8?B?bExsOHRWejFia1hQRStUUTRpSTB3OTNXQkpBV1A4VmJidHdVZlBucFdFbVd6?=
 =?utf-8?B?QWFVTXA4eEVzRXFZUHdtMjFUbG83VmU5TFY5OFJJbThpR3E2VGgrdHpaY3V0?=
 =?utf-8?B?TDkzb0ZPb0szeVU0ODhqSFkxYTZsYU43VXJEaHFxTDBHUlVBcjNVaWZ0SVE4?=
 =?utf-8?B?MkZiY3JQLzRqbDcwUU14cFJuMTNlRzcvcUNyWHhKVEZRYW9kdm00Q2xsMWFT?=
 =?utf-8?B?dHhJK0NlejFwNjNEaDJ6RXIzOHFQTy9HTjBsKzFGTEJ2MFlGUDhRenRnOVo2?=
 =?utf-8?B?R0k0eUQvV0k2VXBlcGhSd1k5SVBuekJnY2gvS21LMlkyVzZIZnpkUTV6bm9x?=
 =?utf-8?B?YTQzY2J3RHNyWThLVnhwZU5BbSs3QlV3RzIvVmthd0NxTGoydng4QkR6eGNp?=
 =?utf-8?B?M01lSjBYZGhDVmZMeDRjbjB5cUwyWE44ZnRuL3FuK1B5TDVpT1JjV2NzVnZR?=
 =?utf-8?B?K3pTN3VZTFBTUnZ6ZHZGTU9JQ3BrUXFkRW9ENFFXS3FWd3YzOFFBZ3A4b1hq?=
 =?utf-8?B?SXZTeWV0ZHhUSlYzNm9ocHRaWjJ2U1pPK0pVSSswZXdrSmJwRzRLWDJOSUpX?=
 =?utf-8?B?aEF0TTR6UmtGbGc2M1RuUVJ3SlZDaHlYSmNSRHBySldpRlpuZW82T1FFUXEx?=
 =?utf-8?B?OVpqUmJhbXY3dWVSQnU4SWxtQTY5andZZU5jYzI2aEhtRFlGZlhSNnAwUWRq?=
 =?utf-8?B?d1RTSGZCRjNvSUtBR3pKYVplZmJiZ2QzbDVOOGlKVW5yN3VKMmdhK0YyblFu?=
 =?utf-8?B?aEsyTmU0WmZGemx2NmR4L3ZGRGZWUVRKaHU4cEgxZFBrclJCRG85K2gzVDNO?=
 =?utf-8?B?ZmJRSnZzd25uS1hvNG50eS9ieTNkQVRCcnNDQ2NRLzBSUWZPK3NKR3MyWmxV?=
 =?utf-8?B?M09Uby9nMEdjbEN1VlNQSkQxQ3hVc3pMbG1WMElnd2RkVis2SHdDV2lsM00y?=
 =?utf-8?B?THEvZGpzS0NCTHQ1VElkVUc3cE42alMwNnR5V1Z6RjkzTFlJTTNNSHUzMTJU?=
 =?utf-8?B?aEI3V3dOclIwWTNPRkxIN0JOUGFHTHgwVENhZHNaRUg0OWdTazJmK0RnOTdG?=
 =?utf-8?B?eGJWSkVZWnVFSGF4UFlqeVFHdEo4b3JVblRVeGRsb1k0dXNVS0pLMGEvZFZT?=
 =?utf-8?B?YU9IRE94YzRXMFRLRnhsbW1Za3lRbzFPdG8zK0M4TkpUOVY5bVoyUGVFbVlk?=
 =?utf-8?B?eVNoODVPYXM2bXo4NFVpczFkeDF4ckpwMEV4NEtRSzR3YkxBajJ0MHVJSVg5?=
 =?utf-8?B?eHVDWDkvYXMxQlZ4NThPdFZrK1czVWtmZVlpYktJdm0xV1lDOWF4U3FjZ2p1?=
 =?utf-8?B?WUx0ajZYTTdYQXI1RWxlQ3dteGFHNVpsaFptOTlzU2dVVnhFcE5mUkoyRlZs?=
 =?utf-8?B?cHhSUysxYnVCUDd5eWFUSE1TTW0zUjJ6a3IzSkVYdm1pRFB0WGljZ2ZLSjBI?=
 =?utf-8?B?QmNQajh3NkM4TXRWM1l2cElQTWtEWjJweUtxK3hPQk9IRXRyVnJDSzNiTC8w?=
 =?utf-8?Q?PePV8kUKtEq/S6CUdhhzQHCqqUanDNRy+IiPw4/?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f48c21ef-945c-4164-a23f-08ddeac59f56
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:41:07.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1035

Hi Fenglin,

> Add nvmem cells for getting charge control thresholds if they have
> been set previously.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> index c9f0d505267081af66b0973fe6c1e33832a2c86b..8c3d30dd936ef9b12867971f5f237dd12484072d 100644
> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> @@ -82,6 +82,8 @@ pmic-glink {
>  				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
>  				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
>  
> +		nvmem-cells = <&charge_limit_en>, <&charge_limit_end>, <&charge_limit_delta>;
> +		nvmem-cell-names = "charge_limit_en", "charge_limit_end", "charge_limit_delta";
>  		/* Left-side rear port */
>  		connector@0 {
>  			compatible = "usb-c-connector";
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> index c02fd4d15c9649c222caaafa5ed2c777a10fb4f5..abf7afe5127d7b8b572513234e00009ce837837d 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> @@ -239,6 +239,26 @@ reboot_reason: reboot-reason@48 {
>  			};
>  		};
>  
> +		pmk8550_sdam_15: nvram@7e00 {
> +			compatible = "qcom,spmi-sdam";
> +			reg = <0x7e00>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x7e00 0x100>;
> +
> +			charge_limit_en: charge-limit-en@73 {
> +				reg = <0x73 0x1>;
> +			};
> +
> +			charge_limit_end: charge-limit-end@75 {
> +				reg = <0x75 0x1>;
> +			};
> +
> +			charge_limit_delta: charge-limit-delta@75 {

I think this is supposed to be @76 given the reg property below and the 
other ones above.

> +				reg = <0x76 0x1>;
> +			};
> +		};
> +
>  		pmk8550_gpios: gpio@8800 {
>  			compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
>  			reg = <0xb800>;
> 
> -- 
> 2.34.1

Kind regards,
Maud

