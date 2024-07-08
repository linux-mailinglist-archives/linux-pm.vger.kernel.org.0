Return-Path: <linux-pm+bounces-10741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47438929C4D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5871C214DA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F22179A3;
	Mon,  8 Jul 2024 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="lSAjGkQu"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AE13ACC;
	Mon,  8 Jul 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420394; cv=fail; b=S7q69WIkKfjqvhl9AmQkOseMxAjPwynyVtTQRwBckjDd4mwMOAScX8kSKo8mFhbVBkewKNrNbsFYVPKPtnqMpFYcZlSN9T2Bs0TJOdr6ycaKp3RfNgXHPKgBO//8cPZ72VttOhdSYcDX8BMfEkj9fjqs4BSAQx5AtfY8YToXBBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420394; c=relaxed/simple;
	bh=mqFOfGKsqgxzpW1xgPo2aZ9/Xm3LZUmWCTT9dficmdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SiclTG+HeMfQpmFlydTd9Lln8SRk0vOkVbhr6xmOCMLOs0MhF3l8FwH7IJxEShBIh7ivZKouCG2DuWwAIXW0FSv0zGXMVPOsEyjQVTT2lFG7qQ8Ynkdcu0OYE/tO8qrswv/gFLhwIBx9TLwQgfjAdi15zYfeXclbsAw4PJN6no4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=lSAjGkQu; arc=fail smtp.client-ip=40.107.117.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej/RcClHDUOt653oD2J4JtPNhEtlrnp9MQZWkTYmtDdv0arl7c066VQkIbPsJot9KZDQVc1tjUdUOG7BcxTT9OvrH34qWs4pCQWRoeFafth04wFwTUojv3hA+XyynJZpvu1efKMe5eEOPnXnMs+wasZTImfxJfo92SdDTuN2u6RnGQAqLg/LxwU1IvCJb0dgPhyW7gJqFMyzNJ4IX6Y7yZDDQ2wiPjH5BXb8bzOn7vjE7/+KyTBDx0Wgt2m5t9RaAqq80YGuu3SBEFnmc6wlJ2x/sNfQ9v+gio59uYC2nUSj2HeYRqInvIqL5/JFjuFJaNFbBx9/ljyplJ4v9YSL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLbMBh9VRryxIC8fLOZ5tLWaumzOHHCH3QrOy4NOSLA=;
 b=iBE78XybXC4Ilap5NQoWPGu/vuGW/VeTcWbfZHTdO+vauCCaoq7+iqiGtxpJ60xVd1gw0Og6+aelzovmgnyfqi9y+/arxSdN30UdBBI/TsEDPMvSLJpc4NXJKQKSpCngsxfh/bTNNY/kVlMVNgzHMhS1dQsxg0jvHbgZS796CD++uLZ8qVPnPlp3V4gdQ4UqlsIHT3VVpoA0gKf1ecBdTJq3klS3DslkM6oJPWy3Lnd6rjHoBOOk3bL3zvZbwlb9s/yzVHNYFnLggTvIRAmXiGYBKOmfwunRJDvMHQ1ipgFmkxnkdXYrgK0zqrDqrYCljc6kUMuVqV44caue2t+K1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLbMBh9VRryxIC8fLOZ5tLWaumzOHHCH3QrOy4NOSLA=;
 b=lSAjGkQu6hOdorL+0s+yKQcjgkuypwIJoFEKQLjp8WrD/sTB4byv6pjJ3BxXZ0fzhy1k73awgPrJTgvQpJ3tdpfToj3/Y69L+l/SL/ISzxp6Hak6JvbuauNjiRLW477qyqTc/a5iFi2QhBT5Y7vosEANrAdRjkay3yp0V6AvxA4TZ5MplwPBWk3u6eiocyWixmNY0CDb4aYcofEehud8N2gdh9C7eXOhYYx+8jqwqTUwijeAQkMuzkMppTBUZ+z8Q87nlL6XThMWkhDBKAxxBtWDMbnORGp6Fzqo14EdBgBUsdRec13cR/svC6dOLjMu+dCNun2MGvjVtbYeCypSHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB7199.apcprd03.prod.outlook.com (2603:1096:820:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 06:33:09 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:33:09 +0000
Message-ID: <91e42fbc-712e-44b4-8200-23aaf1fade43@amlogic.com>
Date: Mon, 8 Jul 2024 14:32:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power sequence for Amloigc
 WCN chips
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
 <a4d08999-55ea-4674-bb0f-6d618b7bdea7@kernel.org>
 <9c550278-2205-4663-917c-c303c65726ad@amlogic.com>
 <726a0561-b3fc-46bb-a834-3ed8b0e993e1@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <726a0561-b3fc-46bb-a834-3ed8b0e993e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b0a5b1-a0e3-4551-a99d-08dc9f17d546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?My84bjg4YTMxelZEWDgyUFJ5dEQrOUNFanNzSksxbUptem9yMHBLWkxFbmlm?=
 =?utf-8?B?SkQza0FlTEpRSEs5UUYzRGpBL2pYSHR1RUI4c3VoYUFPS2VYOWdOTXdmTkxE?=
 =?utf-8?B?SmlCLzIwVThMaFVETzVicWNsVHhSd3dBcHR5YnRYbkxUNlJwdkZMZTJNRUNa?=
 =?utf-8?B?S3dpZ1ZsVmQ5L2JxQ1k1aDNWYjZVcGs4K3JBVXA5MUREOWVlT3JtQk5kMlVP?=
 =?utf-8?B?NGZYQ21XZXV1bk5LWmVCb1hJUmFGU2hrSDE0blExWFBWdUFyMzVtVFQzOTlv?=
 =?utf-8?B?MTgrZTM4WkEyTTJFUGFrS2gzMUZ2QUFkc1gxYi9tVDdnKytNbUZpZVhRS3Fr?=
 =?utf-8?B?QkhPWEdyKzUxRUZYam1HNW9pNzcydjU3allDZks0SXVpV1l5R3pWQUh1ZXFV?=
 =?utf-8?B?d0J2NDlzU2JaWWlSV0E3RWVpSnZJOUNJNWwzcVB5Y0hqWUxhNDdLazcxYWxa?=
 =?utf-8?B?RU1QRHczZ3lLNHJneUF1MVZMcDJleWpJZmh5dTQ5RHFQUmU3QmJBeHgzNmZT?=
 =?utf-8?B?TTVPb2pwU1NMV2EwVFhmSlptRTJvRGUyNTJhRlZqYXhPckNUNHlnRjhRTzg4?=
 =?utf-8?B?WW51cE93anBHWXBxYkJUdmdkUzJHektQaXVZRGRpOHU0SzZRT0xwOU03T3hQ?=
 =?utf-8?B?eUFCV3luQ0Y1b3E1Tm45UGRaZW9KVTlOd0ZNNXdYQU5xOW9JQnZKcFBTYnI2?=
 =?utf-8?B?YW1Ba1d4cE1YNlJveFpjWDFoV0xsbnd4cWFTVHJqRldteENUWUQ0NHZWS1d3?=
 =?utf-8?B?eTRwQ1gxOFEveWhvSEgzL2Q1bkk0aGtsaWxra0RrRU9nUitlVUpmT0hxRjZx?=
 =?utf-8?B?UHViblEvYXoveUhsUDh6dnVwMndMRFBKQk5xb2hPTnR4Y0RWTnRTNEdzcDQ4?=
 =?utf-8?B?NEw0Ri9WRnJnd1plWkxob0lOajVIbG5uZUlKZWhIbjRiUXV3K1FKUGtqRitT?=
 =?utf-8?B?dWVIaXdHVlFjOHZmaFdjZWdncDg0eEg5dFRWd21QWFNPM3AzeE0yUGFIQ3cr?=
 =?utf-8?B?clBDcFhINWlxZy90VldaaEJzbXkvNnVraFZKSW5JVko3N3BvNjFwNUJEYk9I?=
 =?utf-8?B?MTVQcDVxeXhPbG50ZmhBbElUeVlKckJyS21pb0JvMFdTeFcwaFd5alRLbWdn?=
 =?utf-8?B?cUdUd1AybkFMaDVxUDB3YWtDaXdjdUYwS0IwR0NyQTkzdEErYi9KbFIwK2xt?=
 =?utf-8?B?N0VkZ3NkYXdtUVlaRXFFWFNqaElsZ0dPV0ZVcFpFUkNUenNtMkQrWDZndytY?=
 =?utf-8?B?U3E4a2QwdlBrdUV4aW9TNGRzcC8vRlFzeUU4MExnM2U1MVZvVUxmMThwa3Zt?=
 =?utf-8?B?NGlPS2NKSDQxOWlkWVlIUExQbGN1aEt3UnFUWksycFNST3FNOEpyVTJaeDBj?=
 =?utf-8?B?VmFlT1NEajJxQkk1M0Jma1d4cXJRVFMrM1craVpzckU1VXpiRXM5OFhMVjF1?=
 =?utf-8?B?TlA0a3lHdUF5YVVrWFVJNmx6TXFFbDdkdkIyZUVCSnE4UG43K3IwcWxhNS8r?=
 =?utf-8?B?SFlZWHc5ZmZ6RGZEbUpHZjJqL3N5amtJSkp0SlJrLzhneS9ncUJ3MWdsZE9t?=
 =?utf-8?B?RHI5Q1VXT0xzaUVQREN5bWFReS9CN3UxT2owa3Z1eUZ1U1hNSzhZak1SaWU5?=
 =?utf-8?B?dGxQNDJwVjNQUW5UeFJOdTRnd0RTaEIvWmtJeVRqUmg3Zlhzb0ozcTRkUlVl?=
 =?utf-8?B?UmtQaHhUYlg5Z00zUUl6d3pTY29pRGZwWEgwSWljTTBwR2piVDYwNVA1alNy?=
 =?utf-8?B?dFVrdnllR2piQWlzbWVxRkdzS0FRRU1zNjFkQkFnQnFmcmdKK3BOV1E3bWxT?=
 =?utf-8?B?SlVQejIySUdmSHhmTlJXZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkJGREFoWkhFWk0wVEtkTUM3VVRuamZzNElDOU92NWlaUmNKNjRMRURWaWFP?=
 =?utf-8?B?SmdvakxoMFJnK05aYTlFZmJzN0NyMVZCU0lIZTRSeXBnQTZpb2N3ZDFKNEJV?=
 =?utf-8?B?aEhzOTVkRjBVZVAzMCt0cnp3TGJnMFNwSnhXYlovbXc2djVwdG9hcmt5K2dk?=
 =?utf-8?B?QjZOUDR1ZDh5NDZ5U3VZdkZHU0haOHpaZG1XS1BTd05QeHhWQis3NEFyR1pw?=
 =?utf-8?B?SVVRZzBYUTczc3FFQ0I4NlNaQi9WdG9NUXdOUkhWY2w1blZPaTZEVk5vd2ln?=
 =?utf-8?B?NHEvRFc2bzhWUW1uZ0x1MmxDYlNpZ00rRVBhUFBWWC9vZmVkM2RUNGtzNkhH?=
 =?utf-8?B?c0dSdXJvaHhkU3Z0MUxYZFR0alI1VDVRNXpwbzVOMWE3YVljUWgyVlNsOVFS?=
 =?utf-8?B?dXUwS3d3bnA4OElpTzhCalE1aWU4RkhmZENSdkNmSDN1YThWams2TlRNV3V4?=
 =?utf-8?B?d1RvVVB4dGp2N3U5QVBVYnhjQTg4UTFGeThaY2crZ1ZpaDBYWW80MFR1WUE3?=
 =?utf-8?B?Vk56NVByRERDR1h4d3l1WnRnbFIrVll3eHVvcEN6UjRva1BtRlRKYTVYWW9w?=
 =?utf-8?B?RFlZOXBvS1N1cTJyLzdJbUJDTDRUOFdZY1l2YldveVFpTjNOQ1ZPeFVQMTVX?=
 =?utf-8?B?TXJCYkEyQzg3NWo5Zk42TWtIcGF5Q29IemFDNDgwZVpYSGU0YUtJQzZjUTFy?=
 =?utf-8?B?dThIbWgxSVowT0QvV0k1eVFiNW1FbWE0eEcwdG50MUU4WmRuN0NxZnNCMEVr?=
 =?utf-8?B?VmU2Ykd2MUNyZ0VJMkJZNmE0Um1zeFh6b0dYdkZudCs5ajIrSEpZT3pTQUJs?=
 =?utf-8?B?bS8wN2llbGFUUVdIb0UwSTFGNlV0YjRGaFU3amM5SWl5R2hRWnQycnVnbW1v?=
 =?utf-8?B?c0l3dVZRd3FjN2o1eU1vcm9nM1NLVndMVHE2NjFQS1JVZWZZS2k0RFZsVGpo?=
 =?utf-8?B?MWxPcHc4Um80MW5mTmdLN0xtRU1na3ZKZFNoRWdMNzBzemNHbDdaR2FFRHFv?=
 =?utf-8?B?cXNUY1o1QTVnaElSMmp3a1JvcXozc2dja0MrcktqeXhndDNSb3NwWkRzcURt?=
 =?utf-8?B?cG5NYS9tMUtnSDVUYS9GOXNFZDZpQVZuZy9uN3pOUExEZEVEd052bjhFazd1?=
 =?utf-8?B?VlpFaXpDS2dIcGZkbW52Z2cxU2dMeXROZ3N5RHkzNmpydmQ1Y1ZZL3IweVlj?=
 =?utf-8?B?OGhsVlJKZlB4N1RxVnlXVFBhV3JZK2N6QXpYMWtqTWp3eEdIZVovSTA4MThl?=
 =?utf-8?B?bDRYdDVKbEdkL2pwVjRjWFI5NC9JMERLOVRBVjFteUc0R1dsaHdoMjBWTVND?=
 =?utf-8?B?WlM0MEZxVDVsZkhqNlR4Q1BNVndMdzJMREVsb0FDaWVxMFdlR1lMRlpLaUU4?=
 =?utf-8?B?clNqeklSMnp4K1Byc2JzM0VnZ0pVbmdmNzl2MUlqb3VEVHRpR2wxMCtYU2c5?=
 =?utf-8?B?TnpPbUppNUpwbys2YmhGeDdGZXduRFRxbTVNNms3UDdVSTY4ZytTbXZRaktF?=
 =?utf-8?B?UTF0RjJKU3lOaDZUa3Nrc3cxZFVFVEhHM1dTRU5ZS3R5Q3JUOFF0OElwOHlo?=
 =?utf-8?B?T3ZvWDgzN1RXa3BiekUwamIwWWo2VmR4cUk1RXVrUkVoWWU4eUYxb0hrWmdE?=
 =?utf-8?B?ZC9wTTFka2l3UTUvYk5QblB3d01sU2FtVEVRb1JVak02MGU5V0wvazNacXl0?=
 =?utf-8?B?bFExb2h1NTN2NDF2OU5oRS9BK2p1VS9iVTRqcklySElXVkFuSlVCaUhtaHVB?=
 =?utf-8?B?eVQ0OS9yd1NEcE5SS2N6SVZHbWtiUnBEK2E4Y0pHNXl5K25zbE5QcWZGakpD?=
 =?utf-8?B?WUtJL1pvaUxQc25pd1A5aTkyUHQ4NThjSVdadGVxenlVQjhMYlJCaFlVMGp2?=
 =?utf-8?B?S3VxU0FJTGJsOHdwY3BXM2praHBXOTJmclZkU1JyclVXOFN6c2k1Z2tSeWNu?=
 =?utf-8?B?elh0MEFpVVFYWllMSi9BUjF2a2tIcjBsdnV1MTJycW1wWHhQazVSaVFHRlFo?=
 =?utf-8?B?aUw3b2I0aUh6MVJFMm9WNGZyZVVoRklvc1Vvek0vV1o0RXRneWN3bkp1N3NK?=
 =?utf-8?B?ZlU0bmYrd2p1ZFNTaElPdTZtdGk5eFhsVE1uMTd0UFNvSnJ0TmFmbS9hanZj?=
 =?utf-8?Q?mQHmpwbXAzQfLVbdSKy3LlMss?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b0a5b1-a0e3-4551-a99d-08dc9f17d546
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:33:09.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QyB0zmbFopIkPWWeWUIcPk6rmAv58AxsiHaWrqSz2QAlBD3OPb5KqXhLr3HDVeK9AgVzP1IrgTWTagheQ2uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7199


在 2024/7/8 14:11, Krzysztof Kozlowski 写道:
> [ EXTERNAL EMAIL ]
>
> On 08/07/2024 08:04, Yang Li wrote:
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - amlogic,chip-enable-gpios
>>>> +  - amlogic,bt-enable-gpios
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>> +    wcn_pwrseq {
>>> No underscores in node names, generic node names.
>>>
>>> There is no device as "pwrseq". I also do not get what "wcn" means here.
>> Yes, I understand.
>>
>> Can I change "wcn_pwrseq" to "pmu", and do I need to change the binding
> What is pmu for your device? What is this device in the first place you
> are documenting? Where is the datasheet?

^_^ Well, You are right, the "pmu" wasn't really fit in here.

I'd like to explain the current usage first, and could you please give 
me a suggestion?

This module(pwrseq) used to power on Bluetooth & Wi-Fi combo chip, both 
Bluetooth and

Wi-Fi driver need to control "chip-en-gpios" pins, so we introduced the 
power sequence module.

What should we call it in this case?

>> file name to "amlogic,w155s2-pmu"
> Yes, compatible should also match proper device.
>
>
> Best regards,
> Krzysztof
>

