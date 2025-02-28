Return-Path: <linux-pm+bounces-23142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A783AA49039
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330181892CF7
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF81A840D;
	Fri, 28 Feb 2025 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZgECTZpG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2043.outbound.protection.outlook.com [40.92.23.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E21A4F0A;
	Fri, 28 Feb 2025 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716222; cv=fail; b=KZCDQt9EuPZztbSK5i+h0LGdcvrhmzUMmt9/BiGxBj7iey7YWeRrnmNywad2iP9O2l7hZqPUv719McKkCbtcxS7Kyju26ErMZ3mpAVJtQWPzOWoHYTpwXzHoolVHEoNqCYVV/qwaSI373wVGZhMRwFln1v0SW+vjBzw6bqAw2ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716222; c=relaxed/simple;
	bh=ezvY9/6b44+/jx0wNIz1MzCsNmMfuzceoGEOyqpX1ZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifrLC4Q4ZAYlqiZCQo2bOZunZj5f91QphUPPCCCH1WofJxswTvCBppkW3ZQPisq0n6UVHF2/AYKNMSFofdcm28FwTuvnR3o7guE8pTxDzWR47VJLtkgcFm12BMP7IHEtptffi7pZ4DNLuCAmhGBwzH9/w0ktjiD6g9tuhPiU8vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZgECTZpG; arc=fail smtp.client-ip=40.92.23.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZGFEkwCmamyPf8vrqwA4SHY7nY0RZz17oRZXtnedeaOCi2l/JdM93R1yUSDPmB0mltYsCD930nJ4e4i4jM6zOd9P6kuswl/ILd8sku+mkAO3PanZMN5SxrnU459BZRVjUiQAYjav0baeql3l7FjzLb63h3Zl5BtX5JV3SDLiBmgd6K8/cGLpooMXYfsqJqoxmvxMwr/KLc3M7a2PJ4Ud76tfs8EoaKwQ1u1+nCePaa5CA+2+UXzH00iV+BWBmRtkSsbCQdevcXqDZneIoaWq7XHBR7tW7J1wri80RV53NXXfIS0V1nUk//qHyNBuJTAzRUn2qats8r36yt7lIQfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnSuhQceKRMFe/jOY9lYFf3xMBTt7R45wikzYsrpJ3c=;
 b=aiwGKlZf491+1s3eVFmtwAqRGArpmCRgZ3gGm37qkqsnwH85mSsxUR79cGtWv4hIrxKSxT2ono8UZtCfgEpJMYKzIsZ02QD96kX/u+8qL/+iuDJYof7oyLZcG/rGgFKhkI2efsCqeHnnLIV/d8Sq2rG2FDK1h/X8kfnKlNDhGX/7OfdPbdlVmEQD5bQDD7TBjVbdebv6y1udv0Tpz5iZbyp3GRICk8fJ7JT7fYjbODJnkPX3/iY5B5tKKP6u0mvWeGscgG1unzNqAi55V/6Ip4B87IyClci8H46p9EIJrzOgMYiiFIRpxARPPn7MtVlY1BGBphBNgjgak1Ve5QwKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnSuhQceKRMFe/jOY9lYFf3xMBTt7R45wikzYsrpJ3c=;
 b=ZgECTZpG3FwUBUpTcE9KikoEC8NmAcTrrRzLailCll6Wzq3Ve9/oPnAsPGSm2B5idXH+XjK06bWUMvcHjWuFKWWlC1wxDUt3jqALp5Md3gxEsea5RBnTuzilYn2D2SF4LKwxhbxlwe8Bhdo/BJQAmATWd7NaOeSXv2DFzbw4ssXH6goG1XQ4F/U+X888U/Y2x/HFQtmHck62lu1b0Dv8NZjDzjKG3BgLwOglTwuwWtOqrFf1hM3aL/q7r+5ZXL5dT8+s4TbZrZi9pohYaFQ3WGA0m9Wft6ZXG5ybf5RJNtFC8GDDGjZnVayOjHgpNkrjti0ORQV8iYeYDAWeBTMQcw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by IA1PR19MB6204.namprd19.prod.outlook.com (2603:10b6:208:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 04:16:58 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 04:16:58 +0000
Message-ID:
 <DS7PR19MB88835E5F6B906B0E9136CCF59DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 28 Feb 2025 08:16:42 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] thermal: qcom: tsens: add support for tsens v1
 without RPM
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, quic_srichara@quicinc.com
References: <20250227110423.8418-1-george.moussalem@outlook.com>
 <DS7PR19MB888322C58FC555299256E8D99DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <eafirt5dg4vmafmu2wph47zrrzyqrz65z5ypqrl7fhr77qckfi@dgqwkkhnz4ge>
 <DS7PR19MB888363A4FF954A6275E81B4B9DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <xv3c2ube7the3gat7ustws4ok6t26c33fyywqi6x3utx52qtzb@owyidrxeprcp>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <xv3c2ube7the3gat7ustws4ok6t26c33fyywqi6x3utx52qtzb@owyidrxeprcp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0087.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::9) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <638fcb3a-a23e-4bf1-82af-d967a9185158@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|IA1PR19MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af8c7bf-a5d6-4ff7-428d-08dd57aebdcb
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrPgu9FUvYZ88hunKvKD6srS0NlyBrObPrUIkROkmIViZF+jvwGElyQC/eCD2RPQ7NBok/MdS5+3hcGYEXViFLzxILfUbunt6IxoESQ02OaUGFp1BijAC7pSQsNAYPFh4OBsvRKGoykugI7BdayviXdM1Ssyfw/UiARGH04r63Z5feYWS7LWreTlMZaPv214bUY2UoMBCDLRHo00LZCl9tnl6Yj1BtgAtjI2EWIt/Nw80jhG4Lq2AOfjxSb0+53Olih2kqLDem50egxI18Gwn0T+7LLlNzZYolux5HPIpvmIWJMNAeJgPX4qe2/iXxvpC4GHptzCn243ZgiXagOvQs9SWyWeIW/AhkKN3Khfgu3G078FkGIqzeGVtESIsinhUUSYO/yA3Uv563ei8KN2XAcIczSWxnTcL6RlDgatQdhWjfkKsKLqeSM2s9npy6zdB6Lnh/kJuBrlFL1zhKqagrldGXcYo6oA3d3AViioN+iJoaSZsFPYmyVqVxAvYb7hWRvykabLcST6oW0dIF5/XD/S28g65f8MlDX/PbHyyyFpTGB3FctQD/qwN9RB0hz/k1mWLDRRcC6f24lArB+yhbfYJiX7kiJNpfyVYCHYhSYz0pPmENew+XGk9XgD7rmiGhqcTc283dbH296+GU9Swi/4sw2ZXY8pmeMihK23joTMcgwa2hwO5c4aDXL/6w188MTj1jZVaaHFPi/lyTW+jaLGJipAPVGCsd/NhlNjbttykfkhuOeE8mteYQNmxn4uaYw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|6090799003|7092599003|5072599009|461199028|15080799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFo2YU5BcnlJM2l6b1NWS1J2M0d4SFVDbXYzUy91cDJ2cXhaSVBmaVlwSVJo?=
 =?utf-8?B?QXlwbjZmRWxnK2hrL2wrL0g2RzdVUExDTlJWY09IWG1vRXk2eXRjSkY0Szha?=
 =?utf-8?B?SXhIMVdzUGhVb1Y3NUkwMWNRRlRXclFBclQyU2FQNVF0bGczQzhMcG1NZVpq?=
 =?utf-8?B?Yi91eGxwRmVYb1ZxVnpYanFXQjBhUmJQYW0vL1ZVWUh0WlB6bndvakFLZW4y?=
 =?utf-8?B?enBLQVNGR1J2Y1l5d3NTRis5eStvM3QwV25LV0EvSHFES29vKzdLUEF5SjN2?=
 =?utf-8?B?T0U0bDQ5eU53ZVM5b3R4a1VGV01CM2pWa3dWbTY0V2xBUXhoVm5iWE1uTER3?=
 =?utf-8?B?SmRUcmFNZitqS3kyN002TkRIYTluUTh0d2VGNGxqdTdXT3FWZlk4OUw0RFlJ?=
 =?utf-8?B?V0FsYm4yd0J3Y2IrNkFrZlA0NTRYeThlc2hSVU9RWnViYlAySnZQMExOK1lP?=
 =?utf-8?B?OGVnYjdKdHpta1BheVFYR1R1MG96YmVRUGpndUdsdWx1VXdidjBvSndvcVpr?=
 =?utf-8?B?bHNwYnVLa0RaUTdyUVpiV09HMFFvYnBCR3BLR0JqdzlYYjNoWks3b3I2akhK?=
 =?utf-8?B?cDhhc2JRUTNoTmdCWWo0NVRiNGVMNG9CU2FoMlR4YUszYUN3REM3UEl0TTFJ?=
 =?utf-8?B?RWxoT1JwRWJybkJjWU9rL0Q2dnFNcVd0cGhZcFdOelh1WHNrWWVmUk9YYjlN?=
 =?utf-8?B?VXhCWHpIcDduL0JNdG95YTEvRWdUNjE1cjQxNlhLWmIvTEhMbGd4cEZmT0RI?=
 =?utf-8?B?K0RaR2VDeUo5UnBIN0t3UC9JUEwxcU1NSlBHUFMwbmI5Yjc5TjRPcXBFMW9n?=
 =?utf-8?B?Z3MxOXh1THlrRGk4NVE3b3N0bXZ5a0oxZ0pLOGlKM2RSQjZkTUFSOFFjWHFp?=
 =?utf-8?B?d0g0ayt3YjBuWFdHcUtRSkFpczdUODNLU3RIN29BTTZEQ0xISTkzdnFOeWly?=
 =?utf-8?B?aXJFL3RRMVViSlJlbWw5RjVhZWg1U3hiN0dMUlZWdjNyZmNEaXY1VzIxOWlp?=
 =?utf-8?B?bGQ2d0xBemVQSjE1aStzQ3RiNXNGb1N2T0FwWkFhS0NhbnlEVEtqeEJSaWtQ?=
 =?utf-8?B?MWgvN3JmVitGc3czWFNLemF1Q1hXL3VQcUR2YlFKajVyRTVWeXRRblNDdzFR?=
 =?utf-8?B?L09oSWY5b0lxMFFNY1pHeWtxcUtTbEhaMjc3SGNOblAxcVR0am1JZ1ZhQjlh?=
 =?utf-8?B?cjBqSm1tYzJ0a0FhNHVQOWpmdUFRd3A4VGtTeXJBNWRadUsvRHV1azI4WnpI?=
 =?utf-8?B?NExLeENVQUc4Uml1ZTNYSEdEZklyTXZaeEErSll1UGFMdkhuSHg0OWQ4QUtK?=
 =?utf-8?B?SzJyV2pBdkpKdmkxZWsvRWRSNjJYQko4TEZrUTRpdU5XV2N0RWVxN29paVhh?=
 =?utf-8?B?VmltWGJjTkJ3NURTd3NPUXdKbVBobURvV1J6VGpNS1hBaXRYUkl3MjdIRFk1?=
 =?utf-8?B?cXFTTjZRNHByT0lPbWRZUXhRMU9sc1JMVU1sUWFXMkpPTXEwQmE0TEVVMFpk?=
 =?utf-8?B?Snc0K0ZPOG1nL0lSTm45YmJKcnhoOENhYTFBKzgyZ1VNMnNLUGQxUVhhc1BB?=
 =?utf-8?B?YVU5QT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDVralNRMzNyT3JidHBWU3RBVjM2SmNiNzVSSkp6U2dibGREOGtwZ3B5amRM?=
 =?utf-8?B?cDVuVWx3QjVxclU2OTVoVEFNdFVMaG1zdWFIWkdzZmtIQkpiUm9rbkN4TFAx?=
 =?utf-8?B?MEZwNWdGd2sybEwvdWRCUmNSajAxSFhRN2w0d243Mk9IcDZ4ZXY0UExQNjNB?=
 =?utf-8?B?eVF2ekdkQjR6UCt5V3Q2amZHekpCcnJPVE5xM0Fic1VzTk94dXVvSlhTdVhU?=
 =?utf-8?B?ZTF4VVFHRU5GUHpIR2k2d3B3RStQc1J0ck9VcnFoTDcyRklzZ2xONHFRaUVL?=
 =?utf-8?B?dlZjWFRWVGcyeTdNdnRZTU14MkhJeHVhUkxEcXM2dmFlN2QvUUVaSmlCQ1pZ?=
 =?utf-8?B?U0VyUi9DYkhyQWRIdVA4S1YxajNuenZKYlBsOWFCbnJlWFBBOUhna0ZLS3RI?=
 =?utf-8?B?T3FpR28rd1dkSFRpYkNtaSswRmwyNENpSEJCeWpYTVZWMmZXUStvSnFtWkgy?=
 =?utf-8?B?YlVtMGdFTExvSDMySSs5Z0NYWHhuVEFZZ0p3Skp2UHcvazdDS2RwNmRDc3Fx?=
 =?utf-8?B?YktKTjljWUMxd1M3Q25ROFRlQXd3UTJ6U0JKNmhSSWQ2cXJkSWJyRGhscmZp?=
 =?utf-8?B?NlhYVHByMG9JOFdJTU5wZHFWaUFZdys2TXZ2N0tMN2FUV3k5TDVGdU9PK3Nn?=
 =?utf-8?B?VjQ0c1NmdWovbjNYUzBYeXg4WGNTc0YvZWlhUUxTWDMxNS9KQkUzMUFmWnFU?=
 =?utf-8?B?d3dtNkRKS3IwdWpLRXpuNm5PR3hnT3I3dHduWW1CS0RBYjYrMzNEWkUzOWRY?=
 =?utf-8?B?VXFmTWgrV0xRRnp6dUVsbm52NlVjODVJRUhjL0ZETlhSQ04xaFVqc0dIYmRj?=
 =?utf-8?B?K2VxekFmWHppTjJuVGdBTlJ5K3NzSFJwS3pzMWtnN2FYNTQyUmYvZ2duQkJS?=
 =?utf-8?B?c2QzQmlJdVlXK292YUZreU5KbEN1VnQyNlZHdFl3ZzFEanRjTU1XSWxCUUJs?=
 =?utf-8?B?aHk2MFFWbC8wdXFnZFNrOVdCYmhNVGd3RmZpWXRsS2EyYStJNDZUazEzMVFr?=
 =?utf-8?B?Z3VMOEhBNWN3aTlmeDlTc0FLLyszNEI1Z0FNdVdlbFNraHJmcjlLTVV5emRV?=
 =?utf-8?B?VDVPVzJIZGdNSHZIcUc2VnZiUVR1cjZPZXdUN0pYbkVZNjBlUGNoTHdxNE10?=
 =?utf-8?B?dkpiK1pSZkxHY2JYT0xJNmpjV3ZIcWhPOGtCQXJpazgrMVNIUVNjM1ZWNDBC?=
 =?utf-8?B?bmExdzNsZ2Y0YVZ4WkZENXpIc3ZYY290V0N3VG85ZjllTmJsZGRrS01MV3BL?=
 =?utf-8?B?dVV4QXhVRjZ4UnE0bXp1bXNmR2JLUnB6WXhRMDBNcXUzcEtQTk1raXNZakRr?=
 =?utf-8?B?eFhtRG1SRUtrWStQYTFoSlZXM2plQStaZGx2YjJ5ZGc2djFLb05Ya2tRWjdO?=
 =?utf-8?B?SDVrQ2dicTYyN2QzL3ZkZ3pxdlRLeU53eFE3MzE2ZHdVd3NaZWxJR0dxVC9F?=
 =?utf-8?B?cGNEK0hzb2xxdWpBQmxKWkcweW1UN0RhbVduQTBKcGl4aTVzWDc4TVkveVVh?=
 =?utf-8?B?RkMrUnRlZWdVSlcwTUt1N0RiMVkxZHhmdGhyemhSbFVRTTJ5WUo4RkRscTdq?=
 =?utf-8?B?a3N1eXdYdkFNSzhtdmxGSkdlOXpNVFZzOEhsWTVZQXEyY1VHaEZmMWhhUGdO?=
 =?utf-8?B?L2tmNmlURmpzQUE0WGw2Vlp0T28yQ3pLRVJEajVSNzRVc1h6cjBMSCtRSzUz?=
 =?utf-8?Q?oJIEsgS8tlaIM3D24haZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af8c7bf-a5d6-4ff7-428d-08dd57aebdcb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 04:16:58.5205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6204



On 2/27/25 23:02, Dmitry Baryshkov wrote:
> On Thu, Feb 27, 2025 at 09:25:05PM +0400, George Moussalem wrote:
>> On 2/27/25 18:59, Dmitry Baryshkov wrote:
>>
>>> On Thu, Feb 27, 2025 at 02:56:41PM +0400, George Moussalem wrote:
>>>> Adding generic support for SoCs with tsens v1.0 IP with no RPM.
>>>> Due to lack of RPM, tsens has to be reset and enabled in the driver
>>>> init.
>>>>
>>>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>>> ---
>>>>  drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
>>>>  drivers/thermal/qcom/tsens.c    | 24 ++++++++++-------
>>>>  drivers/thermal/qcom/tsens.h    |  1 +
>>>>  3 files changed, 64 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>>>> index 1a7874676f68..877b27274fd2 100644
>>>> --- a/drivers/thermal/qcom/tsens-v1.c
>>>> +++ b/drivers/thermal/qcom/tsens-v1.c
>>>> @@ -79,6 +79,17 @@ static struct tsens_features tsens_v1_feat = {
>>>>  	.trip_max_temp	= 120000,
>>>>  };
>>>>  
>>>> +static struct tsens_features tsens_v1_no_rpm_feat = {
>>>> +	.ver_major	= VER_1_X_NO_RPM,
>>>> +	.crit_int	= 0,
>>>> +	.combo_int	= 0,
>>>> +	.adc		= 1,
>>>> +	.srot_split	= 1,
>>>> +	.max_sensors	= 11,
>>>> +	.trip_min_temp	= -40000,
>>>> +	.trip_max_temp	= 120000,
>>>> +};
>>>> +
>>>>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>>>>  	/* ----- SROT ------ */
>>>>  	/* VERSION */
>>>> @@ -150,6 +161,43 @@ static int __init init_8956(struct tsens_priv *priv) {
>>>>  	return init_common(priv);
>>>>  }
>>>>  
>>>> +static int __init init_tsens_v1_no_rpm(struct tsens_priv *priv)
>>>> +{
>>>> +	int i, ret;
>>>> +	u32 mask = 0;
>>>> +
>>>> +	ret = init_common(priv);
>>>> +	if (ret < 0) {
>>>> +		dev_err(priv->dev, "Init common failed %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
>>>> +	if (ret) {
>>>> +		dev_err(priv->dev, "Reset failed\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < priv->num_sensors; i++)
>>>> +		mask |= BIT(priv->sensor[i].hw_id);
>>>> +
>>>> +	ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
>>>> +	if (ret) {
>>>> +		dev_err(priv->dev, "Sensor Enable failed\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = regmap_field_write(priv->rf[TSENS_EN], 1);
>>>> +	if (ret) {
>>>> +		dev_err(priv->dev, "Enable failed\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static const struct tsens_ops ops_generic_v1 = {
>>>>  	.init		= init_common,
>>>>  	.calibrate	= calibrate_v1,
>>>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>>>> index 1f5d4de017d9..f860ea86d130 100644
>>>> --- a/drivers/thermal/qcom/tsens.c
>>>> +++ b/drivers/thermal/qcom/tsens.c
>>>> @@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
>>>>  	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
>>>>  		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
>>>>  		enable ? "en" : "dis");
>>>> -	if (tsens_version(priv) > VER_1_X)
>>>> +	if (tsens_version(priv) > VER_1_X_NO_RPM)
>>> I'd suggest to replace these checks with >= VER_2_X. This saves us from
>>> all the troubles if there is another 1.x 'modification' later on.
>> makes sense, will change to >= VER_2_X. Thanks for the feedback.
> THanks! It also makes sense to split this into two patches then: one
> which changes the condition all over the place and the other one which
> adds VER_1_X_NO_RPM.
Sounds good, will split into two. Will send v9 shortly..

Kind regards,
George
>>>>  		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
>>>>  	else
>>>>  		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);


