Return-Path: <linux-pm+bounces-38424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A69C7EBFA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 02:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17B63A408A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB76726ED5D;
	Mon, 24 Nov 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HUM5423a"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838523314B;
	Mon, 24 Nov 2025 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763948314; cv=fail; b=HnfE7UudQoxxZmLSlizAjbO7qJP95Xi3sUQGi+TFcL2f6W9B5fJiNhLTcg3KETxAGQblahnUyB1mjI/ci5Krosz3oaPtoHCQmZn+QB/hOYLFfOl2cEp98xOBDWIQb5260UQR5cdT4HdL4MNVnoopeNLRyBxeU3wtMLFekD7kJeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763948314; c=relaxed/simple;
	bh=H0Gwt93qnNd6IkZfP5JZ0V2Iohq4CaLUdAediunkSns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSiyRLdHfLclDHvNn3HvbxCBz52Wy+yWTZ6oh5WbmJ5Lx9DKlN6rYmplIUSJHJU9BvDtGFFIMXvpuGzfW4j0ggnXhsC9YEx1yXDfpPu87ovC7w7MOKvxHfOK5XhjmkVvLxPCL33nJwb3nCuCmHOIJYWsdyafMUS3Kc0FXB1ZqRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HUM5423a; arc=fail smtp.client-ip=40.107.130.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDkTl1F/bqlFlgDAD3c4LY1ebq9GSIofuRnzg37DQ/4NesaRifA/i895XylyB9C5SXpYITijmez4WXaVM/tKXeBsPfq3Ban5MS5ERLOZE5YRLtkzMqSU5t0dlX32SxihPe9WR7eYGlF5m1qHCvcVpgPmOkvzYHDoCyTvjPsCr5L4G51ir9UA8raYqdDkRWwfW1grVvh4YP33TjM4IU6/KTMwbQS0BT6796qV/FHVrD6SanraeAQ06M9OkHhHwNYu+Z0UOahnXbTlDXCQu+cWXqZTuleMbyMNs0i21ydaiO2/gK/BnlStvcbEo8Gqb0OqTNw3k2/KkNrd3rBjt/4xXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmkdJ090Qm9XhXZpGW2ikZak+wYiahLNvvG3t8aPHtQ=;
 b=jZb115bqZAh1+amFlyYekRzflHGCnnqOjOIf+A3+S3KvBefoTSp/+hLLbgFHwUyb2eIFFQnvPTfny8XjkY3peFBSpl567r3/yGR3dcEfmpxYKf41Wtp8WdgTPFFJLZG9lig2te9jtuuIqgHOsbc8xWVgtEyCgSacmcMdili14QbJSUL24EYwqTew0/8ZK31eE/5Vkc3HLG9N+iI41Qlvsd2mkK7yJzzGSqUWeEin3Ga/gjQ+KtA2QG7PBeRj3i76HThFsrqG3Z3yqhq3GZa4MnubZKoS9y+O0Lr0gbzfIkp05E8SGs8hwuO+vg7tePC/4/yKMewGYt/hrHMM6EQYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmkdJ090Qm9XhXZpGW2ikZak+wYiahLNvvG3t8aPHtQ=;
 b=HUM5423a8eTwmjhUuK2l/Wa6YhXG9m4DAdzo0u+uDAopFZLHpYaW5kD8NwFoeWpMgV6YWn5J9j93Q6kgdYYAkgzr8IN6am77/F3DvCTEuxYkQ+MQQlEflIL5lMhIoblrW9Q8jQRbtckmoiFMI7L6YbzoFX3VcPXl9LoPNque7w2zkmeGsFh7CfdYfMQ5Dw0lpFfuT1OP7+HP5/hYm7MUNheFaLVQb71PswuwXE70eYjWnaQ8SEcVZH104DCNNG9qGh/jKSEJcDbk8rzyX7++PmZS7lHIBW1auBixja9VN/5prwqkzhZxU8iybqyznyGP7+4xks+XKpXnRt+08LFr7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 01:38:25 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 01:38:25 +0000
Message-ID: <d282811a-866d-4ca8-b9f6-fc1da3a7565e@oss.nxp.com>
Date: Mon, 24 Nov 2025 09:38:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: verisilicon: Avoid G2 bus error while decoding
 H.264 and HEVC
To: Frank Li <Frank.li@nxp.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, peng.fan@nxp.com,
 eagle.zhou@nxp.com, imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
 <20251121081911.1682-2-ming.qian@oss.nxp.com>
 <aSCOZCJ2rSw7LAvE@lizhi-Precision-Tower-5810>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <aSCOZCJ2rSw7LAvE@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb6830d-f948-4fe0-8b6f-08de2afa291b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzZRTDNFdzUvbHVua3UzYlc3V3h5dDhjcEZDbzN0di8zcU1oYkhuQUxNc1Iw?=
 =?utf-8?B?Wlk5dFRrb2pEWFQvOGpHVzloK0U0WC92Q3l4MkJXYk5taVU4cFMvSXFwbTBs?=
 =?utf-8?B?eXpiclJ5SVFpVXlEc3h3M0I1YStjaW9yTXJESk1ocVU2NFY4SGtRUWw5N0NH?=
 =?utf-8?B?SW1NakJyaG9helV2NFhiYjNYZ0g1aHdMV29hY2tGY1ErbEwyV2hqanRKbDll?=
 =?utf-8?B?SzVmcEcydDhMd3kyR2w0c21kbm5USi9CU2ZGSXl2VFg3UjViVEZhUXJtUC9k?=
 =?utf-8?B?SW5jekJTcVMyUlJ4RmlUSUdmNWc3bDY0U1BUQVJpbmo2ejR5WjNtK1hQZE4y?=
 =?utf-8?B?Q2hzTWIzQmU5MUNYcTJpb2Rwa2xxb1A5NnNXNmZxRTcvT2VidGZHb2I2V1RT?=
 =?utf-8?B?Y09pTzFjc2xKVXZJeFR0QUZSei80cCswZFlZVWh6OVFxZ05ZTnkxZ0F2dG1L?=
 =?utf-8?B?YjlHNXFXeTd1TEFTZGI1bjlseXUxa2NuQjdIZEZ1Rjhsa1BMalFYZEVYaEhW?=
 =?utf-8?B?VXNzaFNDeW5SWUJjZ3o0LzJLcmRnWmc2VzJkVDJScHlBTnNjL3lpQVZsRktK?=
 =?utf-8?B?ZFNJOHpvTkt2Mk5WbGlkNlMxbm8yQ2kxamQ4dGppU3p3Vy9YYy9NZ2FFMXht?=
 =?utf-8?B?bEN6QnpNenlRRlZuUnpMWWo5R2I0WUN6S1dQM1FEN085aGJjUEphOFJ1RUoy?=
 =?utf-8?B?ZmcxWnVjNFk1cW1RMGFtWWRZV1V2MlVLc3RqTGlCcVArKytiRzArMmp6Rzh0?=
 =?utf-8?B?N0dSUVp2eDc2VWNEUVlaRlFNSFE0MHY3ZUJlM1pRRG52TWxobEk0TmNXeU16?=
 =?utf-8?B?L2hNeFphWG9TaWhqODNRcnNEcXpnMjZUNjlsZE1lWlJSZ1VoWXVGREplUmxJ?=
 =?utf-8?B?dFJGalh2MFlieU5LY2VOQmpQeUIzTjgwTFFkeWxNZHQyQlRJdEF3ZktldzJm?=
 =?utf-8?B?SStwUTlRVzVka1RuRXdwYitwQXVqdnM4WUpyaXVhTDFsclVTUStFSXF6dUFP?=
 =?utf-8?B?YmxSelhlNjdVL0dEd0VKTXdWcE5VdDd1S2J6ZU9qNWkvam4zcWx6OUVPeGoz?=
 =?utf-8?B?TTdLWGhHa3QxR1ZPWU55ejlSaGNRU2R1RVNXaytSTytGbFJXVVZrRE5DREdU?=
 =?utf-8?B?R2RxZ1BVZmF2UHdsd2dWczdudHJybUtCMGJBSGY2TnEyWUcxMS9CYitnQ1pD?=
 =?utf-8?B?blRZMTVIK1YzYk1UZ2UvbXU0TjhlQUc0dXJRdThqNkJOei9lSmExNlBNNVYz?=
 =?utf-8?B?dXZ0YjJQQ25meEtaZ0RqY2ZHbEVNYnNQUWkwQnZjNHRaUGJIWnNGZWFyZURQ?=
 =?utf-8?B?UGJ2RGRxak5NUjdqc2R3Z2kzcGNycFhLRkJCdmVXM3FiOFdBd1NtSGZsMmJ6?=
 =?utf-8?B?bERQamZaUjdIL3krREJsb1BEQ0tNZThFd0lMRit3T0RWdFF0S0hHbDRlUm9a?=
 =?utf-8?B?N3VjK2FZNFFIVFpYd0tMMC8rWEhwa3ZtS2IzWTQyd0Z2UEFJeVBSRkYwRDFo?=
 =?utf-8?B?LytNTFo5UURMWHBqY1pUdk1VOHhseUU5MmI3Q1lDOWZZVWRXelZ3M0lSZTNv?=
 =?utf-8?B?Z2lVeTF5dzh5dkpIY2E5N0c0ZTc4amkwbkVtVjRkdVFVZno4aFpCbWNKQnV2?=
 =?utf-8?B?U3BoeFlQZlRaYkRnOHNrMXhMLzBDbjJnbzJUSFl5VlFMdE96RjBzdlpHMFFs?=
 =?utf-8?B?dUJzbkhnVWhxM1JSdE9UY3BaeWhBdmFRcWdaYUxkVHU5TWRsam1TdHMxelg3?=
 =?utf-8?B?SzhQRXZydnhpOURTeTczYTlZTDNWTml5anZQT3ZkZ0JoMnVzdlVHMWthVGJD?=
 =?utf-8?B?THlmS0phQitQcnlBNnhGWm51ZU1SYytkTTN2b01aZ0xkU2d5Vm9yQkZNSTVa?=
 =?utf-8?B?VXcxblJZR2prT2x2L2NTeWp5RFBXeVdqQUhuVkQ2ME0vVVdQUUpOR3BpaHIv?=
 =?utf-8?Q?AWPitUs17Idtz65ofwtaQ5TaBitkw9jl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RERTQU9MckRpM2ovcmdBQytnLzhaYUFRK1dHRGZMQ2xTVWhaVUV1bEFpbm9J?=
 =?utf-8?B?WiszR1VRcXhGaS9YazVHVmNDUm5xZzluL1dYNUZoMEVsOEtXMDNoZVdTRG9P?=
 =?utf-8?B?Y2d6eU02K21wbXBVd0pPOWFoUkNVb0JYS05iK0I1RUp6NkxJTExLOW40NVZW?=
 =?utf-8?B?WHdXTGFRUWtERjY2R0M4Rm85S1FpRUJhWUh5Z2pMcjFiVDVnL3NnYnBuemJn?=
 =?utf-8?B?NnBJMWNwc1pIZVhrRmpTaWZrS2ZMV255YW1iTFVNa3V5NzFHMU1qZzcvQ2hF?=
 =?utf-8?B?Q01MNGVqUmFVL2Y0aHY2cjhYSmJOVGcyNEVPeWVrYkU4NnVLdjlyRzJuOEp1?=
 =?utf-8?B?ZWFJM3lVT0RTWXNFT1pubHcvTi84RWxzY1NJem5UWVhHandrV1dxdElMbHFK?=
 =?utf-8?B?Z2xnRXY5eW1hL2NZTHhJZ0ZYb1NzbHVjN056NXlNdkxyb1FVM0Nuck9La0tj?=
 =?utf-8?B?SlI5VU9wTTQ2Mk1DUzNVWEVrS0hPaFVCOUNXY0dQT2pFa09ZdDBvUUZYQ3Bj?=
 =?utf-8?B?ZWp5c01HZ0YzWTh1L1JPSlB0Q3ZnOFNxQW1VVkxhNFNsUndTTVB2VlYrcUtF?=
 =?utf-8?B?SFJHM0pmVUxjWmxoTDRFL2J1MitzZE9rZm05NHpBY3duUTg2L2YxR3JuT1F6?=
 =?utf-8?B?eDhhR1dTcVlkaytidHhSTGo5b1BpU0NLa3E5ZHBsaGZHWWw2UFhTdmhLY3cr?=
 =?utf-8?B?UUdod3gxN2xCQ3VyQzVITGRIWEx4aHN1WEcyVytUSUdYTnVVMzMzN2lWdXBN?=
 =?utf-8?B?bDV2L0lXcTBOcy9tL0FkQ2J6SHBuODRYZFZLZm1IQjQ3VDY5L0NwRDY1NmxI?=
 =?utf-8?B?VVRmMVR5WncyL1gxbnoxcjRaeWVPNFBkSitmUXNueWdLTHRUYzlsY0RJdjBL?=
 =?utf-8?B?bEFuOE5kY2dGUUZUbzhXM2tqQXFOZ2dxZnJ0eHNOd1A4aXI2RHQrNkF2K1Nn?=
 =?utf-8?B?YVlWU0c5RnEwYjhScTN2N3g3ZndUNndrS2U2ZjVoQnJxN0QwbW1VVzVOTk9M?=
 =?utf-8?B?NzQyMWRodVZmTE51MkhKNCtTMHI3SWR4MXpCZ1RpYmxRd0lYUmlOczllVHNr?=
 =?utf-8?B?OHlCdlBjNngwcjdZQmluc0JLc2NUMUNGakx5WW83cHo1eTJleW1XVU5QSU5l?=
 =?utf-8?B?ZWhsR2pMQjEzR0pCVy82OVZIbzcraVpkOVJSZU9FaHJPQVd5dHN3UEZrZ2tQ?=
 =?utf-8?B?WkJQU3F1V054Vzcxb3J2R1ZHTTFJOFdmdjNLZXJHR1NQWVVSck9Wc0NUdlNp?=
 =?utf-8?B?c2FRQ0RJallMMjhhem9lL05QU2xqWStVcG1SVFdpcG9SZktCcnJRQnozM0xT?=
 =?utf-8?B?L0llVzBoNjRHNEkxNDhnZ090YlVaZTcvU2hNbUZONk1FNEgyNVpZYmphQ3Bl?=
 =?utf-8?B?NFFBSDAwNDFwNTRMam1VeUFFYVpqODcybEh3MDRSZzJzNE5rZ20reC92aXQx?=
 =?utf-8?B?QW5IMlZHdWl2MDkvZENwMWREREZNTDFtK0tMOHdaS0EvdmI5TS9kcmQrcVhJ?=
 =?utf-8?B?NFBVeXR4azFqTFBiRFd1a09Fc0pXdDVzWmxTbFhoZEFHcHV3b1B3MFJKem9z?=
 =?utf-8?B?dCtYenJHTExaQTdjYW0vUFUycWk5M0wyeWlSb0FvOXhOR0Nrb0RuQ1lwcFJW?=
 =?utf-8?B?OWd4Tm05VUQ2b2NydWxPQkZYNHhqQmtkQVNydEp0V2NTVDZyWi82WXZ5TlRz?=
 =?utf-8?B?cW04QWZmaHMwMktPUnB2SjlrclJ4UWFBVlIxaFlKUmFCYlE4WnVuRnZFTW13?=
 =?utf-8?B?RzU1eUhBUnJYbEZaNlIvOXZUTnNBdjZtb2lUaEdlSmlyOS9Ib1lBVHFsUkVC?=
 =?utf-8?B?Z2U4Rys1K2FsVHgrT3ZieGRqTkc2N2dpeDd1S1BZbE1QYzdLLzBWRnFWNzcv?=
 =?utf-8?B?cTN1UFoydUhuc0UvS0gvcDM5VlRyZzBiTDBZdXN1KzhsMldvektrdTRZQ3Fw?=
 =?utf-8?B?eDVqaXF5WS9aaGhLQmprQVMwV0xpQ2VhQ2VQMTJZWHpVZWI4VlZPdUdma2dt?=
 =?utf-8?B?Qm5rRzZJTDQ0bVFwL3NjWUU4MVB0MUc2UmY4YVVIbk5lZFlHdm9KWG5EUk1y?=
 =?utf-8?B?RnRTSUVHVDhoNXR6d0Jhc2R0bE5GdVkwZzh4ZitEWCtEQ2JiRWlOM1ZoMm1J?=
 =?utf-8?Q?oGZA0q4t+j+A/wodY1FE1Cv2q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb6830d-f948-4fe0-8b6f-08de2afa291b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 01:38:25.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBMXIwTWZUDQxwfQWRLl5oiaP9tH4csEoRz2ywpMxMq8KQX+6r1R6Ref6b+KdX04IBpeZku/xprswnHpTBsSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

Hi Frank,

On 11/22/2025 12:08 AM, Frank Li wrote:
> On Fri, Nov 21, 2025 at 04:19:09PM +0800, ming.qian@oss.nxp.com wrote:
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
>> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
>> error and produce corrupted pictures, even led to system hang.
>>
>> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
>> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>>
>> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
>> Then this allows for successful multi-instance decoding of H.264 and HEVC.
>>
>> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro.h   |  1 +
>>   .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
>>   .../media/platform/verisilicon/imx8m_vpu_hw.c |  4 +++
>>   3 files changed, 31 insertions(+)
>>
> ...
>>   #include <linux/workqueue.h>
>> +#include <linux/iopoll.h>
>>   #include <media/v4l2-event.h>
>>   #include <media/v4l2-mem2mem.h>
>>   #include <media/videobuf2-core.h>
>> @@ -93,6 +94,9 @@ static void hantro_job_finish(struct hantro_dev *vpu,
>>
>>   	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
>>
>> +	if (vpu->variant->shared_resource)
>> +		atomic_cmpxchg(vpu->variant->shared_resource, 0, 1);
>> +
>>   	hantro_job_finish_no_pm(vpu, ctx, result);
>>   }
>>
>> @@ -166,12 +170,34 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
>>   			      msecs_to_jiffies(2000));
>>   }
>>
>> +static int hantro_wait_shared_resource(struct hantro_dev *vpu)
>> +{
>> +	u32 data;
>> +	int ret;
>> +
>> +	if (!vpu->variant->shared_resource)
>> +		return 0;
>> +
>> +	ret = read_poll_timeout(atomic_cmpxchg, data, data, 10, 300 * NSEC_PER_MSEC, false,
>> +				vpu->variant->shared_resource, 1, 0);
>> +	if (ret) {
>> +		dev_err(vpu->dev, "Failed to wait shared resource\n");
>> +		return -EINVAL;
>> +	}
> 
> why not use a mutex?
> 
> mutex() lock here, unlock at hantro_job_finish(), if second instance
> run to here, mutex() will block thread, until previous hantro_job_finish()
> finish.
> 
> Frank

G1 and G2 are two different devices. If I were to use a mutex, I would
need to define a global mutex. Therefore, to avoid using a global mutex,
I only define a static atomic variable.

If a static mutex is acceptable, I think I can change it to a mutex.

Regards,
Ming

>> +
>> +	return 0;
>> +}
>> +
>>   static void device_run(void *priv)
>>   {
>>   	struct hantro_ctx *ctx = priv;
>>   	struct vb2_v4l2_buffer *src, *dst;
>>   	int ret;
>>
>> +	ret = hantro_wait_shared_resource(ctx->dev);
>> +	if (ret < 0)
>> +		goto err_cancel_job;
>> +
>>   	src = hantro_get_src_buf(ctx);
>>   	dst = hantro_get_dst_buf(ctx);
> ...
> 
>>
>> --
>> 2.34.1
>>

