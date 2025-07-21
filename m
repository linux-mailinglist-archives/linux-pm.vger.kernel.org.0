Return-Path: <linux-pm+bounces-31157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60831B0BACE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390E41888B77
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2511F2B88;
	Mon, 21 Jul 2025 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="w+3Uys8y"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023120.outbound.protection.outlook.com [52.101.127.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD61DED4C;
	Mon, 21 Jul 2025 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064940; cv=fail; b=gAvIQsA75icsGSKwcN460IIgjanvpGCjNvUtd9W62kMTrlp/0MfA3kuWcXiKB3cYQPybGwrKUFS50rqxSRZWwDd+eRJaZoQNI4B9NumpEUuHjLwVfR+LpM/gzk8wU4b9CVpCD3AwSvSbHlIrSJt8bNZiBSw3eFqovHuT+8+hZJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064940; c=relaxed/simple;
	bh=xtYJf7wmzxw3ZmhxICjyBqI16B+F8goPL+jR8BlBkUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OPlYxNNqAMVLJNWXrYj5i3oIOwPBA7DIaaG/wLwWkFo7QI+rxlZLv1i5ekck6/dHepQBE8liVXtjyoL2qN/WdAEk/a7FFAFxBvw1INn58PNPhbv1YeBA/wEV1/Xy1XfYqZUcktddLp+yKeSgv3Ud8/Qp6Iu/yvezUeEqqhRBn9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=w+3Uys8y; arc=fail smtp.client-ip=52.101.127.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5SntxlISoxO/LRZXzl87qFhIv7+rYSUmNlWL+jNTgvk9joDCHPiREeaMYxm/Cdr3jO5SYjhU9MZxkhTeN60R73ujXes1KPl46sQGHlpQMz8QqI2N5G2ChUjes6bSpnhlzfobDbxidV5/oB+wW73QK7cZGaYo3xMlzbV1Cu/sFRd9GwrGulWus8Khv60OABY5FX9XdrIwBCRhdoPymSXD/KVgXx26SBuE/yMAchhga2BLd9r/rF2y7oSsu4T7d9t6k2+zw7eMiq+SpGo4i5OwsvXlwSZMp3s1dx3M4fhc6KBZNHSyL+PpdumfLjwt2tF9D63R4I8oZ3RmmODaSkKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAJyx77CKLYQMGiuuhdXTIRd4m68mm9yrxIwXwMoxDE=;
 b=KywFm5ABbPdmjfLMYESJqtAjxqDq2kHoeagRC7D5yE8siZnvvlFZeqho7vV8zTG4yPfW2yuO9VGMIaDyOXwQk2EcgE2xjJGxEe4ENZtzik6Y123CWzHe9wirBNKpKnZSEsJrgVAeWw8dESxU7J5ygrcJaPmRlX8voxvJFhy0lRE3nh0/XACpsmKSTmldhSjSjCnkFCFh77ixx98k89omTDbpT13MwH6EYg/P4kPxDbfaZ1i/cQOXHJ6bbCJfwy4OD/hojTJP6mO8z/wguofanpOO+kvCkke0Dlhwz7el40KeM16itoBlahbf3AT20XXkLuo80jAiZDrp35KQ0ws1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAJyx77CKLYQMGiuuhdXTIRd4m68mm9yrxIwXwMoxDE=;
 b=w+3Uys8yr+8UU2npUgRrhdQprqQ6wHRjsoKUMIpNtbpEmhKWIp/swCEVci9AXaTAnMO8up6T6vssm77Pb4nJK+8sVcaWtZI6hbZ4aQb/mu60yxab70ZbD8JkK0uPHOkGB7KBntsUpz74pqhtg+P9+Q0ljdAvGX4FGzQrauJysYzkCRfcrAvO120s2ysqU+boXzmhthclakvYm2BGq1eCF1xu1p5iGSRiNfrBOkZsgJoBr0aYTynVQZ8laoIpI6jzGOzPs6oCTDApF/3xRibYohR1+0RibaBfsi5DoWdc8Zasu6qyB27anpEzJWzXOAHy48Rzl4sXyTgi5o/oPym7yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SG2PR03MB6802.apcprd03.prod.outlook.com (2603:1096:4:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 02:28:53 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 02:28:53 +0000
Message-ID: <478a2784-fa1b-4a4c-a4c3-8e938e379d9c@amlogic.com>
Date: Mon, 21 Jul 2025 10:28:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: thermal: amlogic: Add compatible string
 for C3
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Liming Xue <liming.xue@amlogic.com>
References: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
 <20250718-c3-thermal-v1-1-674f9a991690@amlogic.com>
 <20250720234142.GA3079305-robh@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250720234142.GA3079305-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SG2PR03MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: cea811d6-89b7-453b-0173-08ddc7fe55bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjJoR2k4VlE3N3RtTEdwSG5QRkhrQ1BtL1l6c2VRVFV0aFlOYStId3pXNEZh?=
 =?utf-8?B?Vk42d2szdzg3dUhadTUxSDh0YWppNXV1djdRZXViaVJTKzhkUElPYk8wSU9X?=
 =?utf-8?B?bWJReTUvczRSU1pUL01MQXdyL3BRSlU5ai9TTFBIdVVCaVJKbGNXdVU5ZHoy?=
 =?utf-8?B?N25ZUWFlK1lDOTM1RzB6YmFSM3pFREhRa0hpVkkyVWV3cm8xYWduM05kTnVM?=
 =?utf-8?B?L29zd0ZlNGpHNUlpblJLclZQZTh0TUNDdDJGK0ROU0FPY0dPMXpoZVpoMWpI?=
 =?utf-8?B?Z25YaHEwVER6bWlxTUtNV3BraWdxZ3NTL3JxWmJkcWtILzBpa083bDJLT2VY?=
 =?utf-8?B?QlZwNm1mbm9EM0lZQVZuZkVET0tYTEh0M1VMTHBQTjZwUkwvNUV3bjg5ZERi?=
 =?utf-8?B?QXZJNy9MeFd0OG9HOG1iUEpiT2dyTExMeWZkVFdHRlM1V2hrNnlUWXJJWlg0?=
 =?utf-8?B?ekJLQnNnT2x2TWx6K0FiaHdVQUMyU0xtUmU0MVUzbHNodHNLSTIwLzJNMWU5?=
 =?utf-8?B?V09rcE5NWCtYTUEwems0TlNvZkU5dXpEQTNIV0pHUXg1TXFzam9McU1ubnVD?=
 =?utf-8?B?V0RkaXZqWElmWGEyeGx1cXFmVkpDY3JNYXBNREVheUFVVzZnRGhkdHhreGJH?=
 =?utf-8?B?VVZzVVNNd1IwZHJlb0ZkMnU1a2dOVTdmeFAyY2ErTlNkYit3ekdscm1JTG1N?=
 =?utf-8?B?dURLY0cwMmpsU2d1TUMwYjBWcWs5a1J3bVdib0RJZmUxT0FSYmZVNDA1emUr?=
 =?utf-8?B?b2ZuS0l5VU1McHpMNVo4ZmdpanBuNFZYbGcrVzZkWXZkMXM5R1RNVWR1bGRV?=
 =?utf-8?B?WG1ubjFLdW5kMW1pa3o0Z2k5aHRpMncxalBwTWQyQ3JQcTBBMG9OUUhBUkRz?=
 =?utf-8?B?RUpRVmw3QTdFMURkZUEyN3cxMlhCTmtzT2VnVXpSTW15K3A3N1JDSEJnbTUx?=
 =?utf-8?B?czlmRzBkbWlvVUdKelFKOEpuZ1hoNVJxc3EvV3haYTVvN042TVVDS1BkSVJv?=
 =?utf-8?B?SEZ4ZzhveHNXVmU1K3hXbmJ6QjhRVVh3UlFoMXJDTVgxSUxNSHkyazlab0JO?=
 =?utf-8?B?dlVBSE5xWDB2dFlzaHRSOTF6amJQMlR0dFJpZ1V3a3BHYm5QajhaT0RINVRm?=
 =?utf-8?B?Z1UrMEZiOTI2L2REcHVCY2JYTjVUNm9sb0VNS2ZKZFU0bE54ZExFYlpFZi9M?=
 =?utf-8?B?RDBaek4rTEhwQWIxaVozc0NyQ2JxTy8xWjBYd3ZHYmFJREhyTE92QXd0bWhQ?=
 =?utf-8?B?bDkvOXlUYVE3NWFJWjFjcys4ZEhXMHZISjZwOC92VTcwaHNiUzhlYVFVVlNX?=
 =?utf-8?B?UkI4ZVhrWmdaS2VIR1hIR0RNUDJuSjk3bHpXZFFIL2JkQ1N5RUxycHVobzc0?=
 =?utf-8?B?YVFmM3h0ZHczVGEyV0ZYeWtOdC9MdFNldElMR0lHa1MxeCtreEREWXMvUVNk?=
 =?utf-8?B?YTU4eDNDQ0hHemxOZ3JQZTArcVZobndZWDgyUU1IT293UU82ODFtMnd4Q3Jh?=
 =?utf-8?B?Z3dBR1Vyall0anl1KzhjdGduK1ZYL0tIQlE1RnhhWEVNUWFEZHEzbUhUdmdr?=
 =?utf-8?B?UWZ5b2hSa1BDZkNIT3piVTQ4YkswbmRJbTZZWjJiUWY2QXgrbzFYOGJ6YXdF?=
 =?utf-8?B?TGpZUUxqdFU5bGFHYTZSQW82TWRUZ0NsNWpyeUdPWmF5bmJ6RTlqSkVoV3BT?=
 =?utf-8?B?SWNMaWFEYmtmclRQRFhJdk00REhsWlZyU2NBRkhBY2tnbUVONmh1Mmo0Z1dO?=
 =?utf-8?B?ZkxJNElrWllzazZPVHNWMEEvVVJ6dDl4NDdtdjdzUFc2MzdBNzNGdmgzcHBG?=
 =?utf-8?B?TTFUaWRteTU3dHhIWDZhVHlIWjlkRUpJKy9pdEdZbzJZM3FBUUFqNmlYRGxt?=
 =?utf-8?B?NlIvcXYrNFk4ODRtSzdJdC9TZFRqWTNiOVFBUWRiQ3Brc1A1YXU1V1NpRHl6?=
 =?utf-8?Q?wmQ2g1mrzIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmYweVkrd09QS1JzTVRKWFBEMWg4cWJlb3JXYzN2MmIrcE0rQkNUY1B5ZVA5?=
 =?utf-8?B?RDgxQ1JULzRNenFqeDVqcU95Z2pWTmoyU3JLclMwb1VWaU8wZzZ4VDlJUHFv?=
 =?utf-8?B?ZEtpVkJGMnFoZGM2WmVQbElIbGlnRDczdUEzTzc0a1pSTXBmY2pxTGIzazBm?=
 =?utf-8?B?K0tVRFJoRENwTnRZcHk2b01xcjZzTEZ0OTgwTCtxeHphdzNaYkY4b3VEUjBl?=
 =?utf-8?B?UTNnc1ozUkdvTmpReVd0dHVhVk01Z1hXTStLT1FuZEdaSnVCOG01a2VKd1Bh?=
 =?utf-8?B?UHRwS01ETWZ5OFdhSFV6c1BLRW1PeUhFenZnQ0FWYmphZnB0K3l4dzI5N2VK?=
 =?utf-8?B?bzFPeXphNGNSVDI2U20xTUl2Yy82eHVMWVRZWHdOTVN1bE5KUm1mMHdidEgw?=
 =?utf-8?B?YWpVaHZnanV6K2pMMml3Zmh3M1hua2tITmd4U1RqbFJ0QS9PUGRLalJDTzRt?=
 =?utf-8?B?VUVJZUlwaVFvMEo3TkxZOWRhQzQ4VWhGdlk2THljbGVoM09SM2F6djl4YlZm?=
 =?utf-8?B?ekJOc1JaSXo5NWwxSStpbEdJdm8zaTdWSy9mTFRVNzROM1l2UWZpOU9ZSUNZ?=
 =?utf-8?B?NGJZSkxnWVdRSEZ3WFBCdzF0YytrcVdYazdtaWEyY1pvSzhUZXBZTEoyRmlE?=
 =?utf-8?B?K25SSkdSTTdnMFllQTlSV1F1TUxKMkx6RTg0dzhiTlR0MHlrV0ZEZHpia0pn?=
 =?utf-8?B?Wko3UTNVN1VIR1E0YTBxb2IzYkFLRy9QODVmOVpMOUhFb0txaTBHZDhreVpz?=
 =?utf-8?B?UEQvQWgvN2daUnczVk5nOHlFeEhISlVjSjJ1TFN0a1Fxbms3Ump4R3ExRHRn?=
 =?utf-8?B?M0tlYkNkR01jY3dGamVhUEZ4UGZxMlJISFlRYTJrcTNxT09ER2VqcFJRV01T?=
 =?utf-8?B?dnNzTVVHVWlkSExxOU4vQThrekZmWm94UDFtbXpuZUljOHMyYzZpbURiR3RT?=
 =?utf-8?B?dzI0b1VuVjVNRU4xR1hLbVBxbURvY3pYdCtoTWpndHBVbzh4NUsyNGErME82?=
 =?utf-8?B?VEdlMVNBeFJoemlubGdBSVNZOUI4OElRVWUxV2l2bXZxS0FBYWw1N2xVeUpM?=
 =?utf-8?B?VEhPTUVuOXBkRlBlM1hXSzhMcFU1L1lyMFRYd0U1SUw4NEEwbVZTNEdaUWhw?=
 =?utf-8?B?OVI0Y1duZEJHRVpWTFdRVkwxVmJFUzc0bGhKRFY3clQ4QjYzWTFidHkvZ3JN?=
 =?utf-8?B?V3QxTlMxU2tBVEZubUgrSjRwYWpuSzBQL3pLa0RlS1BOdTZjOEF6L1cwcGhs?=
 =?utf-8?B?ZHFoOGlDR3p0cEhGN1ptR3kwT3FKQmsyUFdyUFc4eUxMZk1CTXlaWHRrTHlR?=
 =?utf-8?B?d0JVZUNkNW1tcTFWRTNzZW1KS0ZFRW1Hd0w3WEhlRnhKbS8vNUVnK2JGS1Z3?=
 =?utf-8?B?R0ZJcUhMVklyNWJmaGhtZHlqb3cyS0I5SkJWa0tOVUhHdTJQS1ozeGxYYmFv?=
 =?utf-8?B?OFhXa1JSaGIyVWlvOHhudGlqSTlFZUNNN1lZZ3RPR0FKYWNJSUpweURIR0hk?=
 =?utf-8?B?dERKb3djZlBGOWpLVFhvRk5lajRyc2JiUytYWjBQRndIc2ZJcTBnOEQxT2RZ?=
 =?utf-8?B?bEc3cEJPZ3FaMXlrL0FuZlExcDlxc1hSUlptK2xoSkdXUVhBTUIxaG1JWkJB?=
 =?utf-8?B?VC9mZmNhajNBbG1vSmtvaFFxcG5PTERnSnMyV2pHc2lQUUI5bi9POVhCSTA1?=
 =?utf-8?B?Si9PdVg0cVNwbi93aFkvdUdRK0kzaURtV21QZWlGRUhwZTdvWWVVUDN5LzNL?=
 =?utf-8?B?TG43YW41ZUQxS1FvRnBVcEt2eTVjMkRpVHBpV3NXd3p5SjZJYWRtSXdBdDd0?=
 =?utf-8?B?M0tMU2lvczZoRHdkOURZLzBINElxd0UyalhWOWE0YVdaNFZycjFnZUpLMk1u?=
 =?utf-8?B?ZW52YUUvd0Fyd0YwY3lyZmhhY0FNOGNyVzBXbmRMRGkxOHVkUG1lcWtiY1Fk?=
 =?utf-8?B?WkZyRzQ1SER3TWdWV2lxNmlWOGpwdER2L1hiOFdZUTdiUkJIRVhoK29vZTZr?=
 =?utf-8?B?UDFPSUM4UjdGWmlKUEgzQzhIRGcxL0dIaDNXUmcyZGJBQW9OSzA1MVczclhD?=
 =?utf-8?B?amhRb1BxV3pSWEllOU4zZW1kZjlXRGtrRVlvL2FxYmlBVEgvVlVuVkVEaXFL?=
 =?utf-8?B?aWdRcG05QmxKakJNdUt4dGpLb3pvNkJwVXphcHdYczYweXJOcndFSE40UFFD?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea811d6-89b7-453b-0173-08ddc7fe55bb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 02:28:53.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JN2wTbyYQY1riPLk3/BfKKBsnKefvyybmszvxIb7wOkInLcIZAiDLf7Ae0Z3SfdfYQU/drl3yVJG/btG9mT4RCTCQoc3zq+Gv8ewHIHJRig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6802

Hi Rob,
    Thanks for your reply.

On 2025/7/21 07:41, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Jul 18, 2025 at 02:37:41PM +0800, Xianwei Zhao wrote:
>> Add the compatible properties for Amlogic C3 SoC family.
>> C3 family supports only one thermal node - CPU thermal
>> sensor.
>>
>> Signed-off-by: Liming Xue <liming.xue@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> index 70b273271754..095b92aa5ace 100644
>> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> @@ -22,6 +22,7 @@ properties:
>>                 - amlogic,g12a-ddr-thermal
>>             - const: amlogic,g12a-thermal
>>         - const: amlogic,a1-cpu-thermal
>> +      - const: amlogic,c3-cpu-thermal
> 
> Combine with the a1 entry using 'enum'.
> 

Will do.

>>
>>     reg:
>>       maxItems: 1
>>
>> --
>> 2.37.1
>>

