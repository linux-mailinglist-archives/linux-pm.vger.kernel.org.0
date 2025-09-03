Return-Path: <linux-pm+bounces-33691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92478B4174D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 09:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E96D1A84772
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88562E0923;
	Wed,  3 Sep 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M1wxKDTE"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013023.outbound.protection.outlook.com [40.107.44.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914412C234F;
	Wed,  3 Sep 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886049; cv=fail; b=k7K8X07I7gxHUuqGWBo7N7WIQ4AgKbezYlrVMczzhOJ8z3HFTY9XKL2OTS/aHdvWLarp19j445JQgTb+wYbe+tWjOrjKGegRzBu6unUx+XD2umvWMTe1w0MVJ3U5uAyOCMeYIphwYTJGbw3W1a/ZJZRopLCD/h5uhLdQCBtB1H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886049; c=relaxed/simple;
	bh=vOQLhIx06ev6FgP+S/JGmm+u3+vxz5DRG+uJPfsMNI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CIAXtBeIzhqB9DWFJTJEkqWFs4/EGBmHMIYJpfZ8hF8BZqJxubEige3bpASgbc4juyuLrwOHzAhxGYpGatuxJ3R0PVMFIBSuDb9bss3eBfv8NnWyxHI5PaECMbTx5uwmyTLn9piWE6fdixlVrnncXv197NB2JA9T8Rt9O8MBKaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M1wxKDTE; arc=fail smtp.client-ip=40.107.44.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdgnUV4rfhIkstSCyXOB21euOFAFeYoRDfTOnDVKT0RQHzo9kMTjZiBCCTrPWDGZrwHzQQKKDTfOd7RCS0nCJRzs93zybBPG8cVcYBrx6VWRCzh7leaKB55bR2Q9Elpet9xMrw/cl92D1vLX2XI56heGLDD7xy4tT836K6aGbiaaJGaVYCiajOxfa9FZT62n78C/7ihvZsIPUPREvMmCDLQ0HxYqy/nqDhbYlbgPx8nxzPFyQCrbHKtn4n00u7hOKnSlxNLHNHBUQmyvNpmasLk2GFrNT74yXAm3yoV8DVcJ+zn5YUAflS70ZyMSz2NJLaXdvuyfva0yx1baLBUCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjFUw408meCPcz5AVL/ZkW5k2OWck7KwCmeK1Y9yugg=;
 b=HLDy/6DFj6OhQ7pFPIb6tdpslpnfLbWn7VDKUYXdii5OHE2QxE+o6O9/cOkGvTQkYXRsll2TpX9w+u8o3mjN/VgZF5Psyq8yQE8+3GszkFoTZrCkDCj8p0e36RLuW3mk2W0c6V82jK50pWLOu2ABE3z9ucM8ypKXkeVAnwaPsY5cJWyFYsgxGkyWz40lK1giBeKLgh091b1sIH9DX3ktOeMXpb6YaOusdysEe9c03may2FMqjoZV8FvymlwI6uQMvZ3xuBp/u00437Xw1N5ZFiV13Vzf7oZudhos0EGxom5O2WTknYkOa5Wq9yFLjRdZi3hUHTnCTlP64zMhpfhUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjFUw408meCPcz5AVL/ZkW5k2OWck7KwCmeK1Y9yugg=;
 b=M1wxKDTEoIJbqp+kQ789tSrNaxlz9c9Uqmv0dTcnAUkVp/4l1XBzrTKY/IOcC4QTo1ULME98dvJUOI5Vq5ytKLBEcfh1nwgL7Wn0pfcG3qCp8csZLNLti2PSEbDMCOB+bO1WzV71DJQgQv7gMc/q17VBATk+5reTF8FiWe77A7njdjvU6d2pOv+U6VDz4wMXbDdFhP5INqNL6jEhpUetegW72gE24oR72wyxlOUK/ltU5Vx5CIh5VXVIbMooV4X6r/QxtK3ebI+iMZ9/WwmJXH/AdQ6N/32C21ZfurdhJL6VQbwX3YD1pR9cgiNNqglgV6UdRGoSaCYnII9E1ulS/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB7108.apcprd06.prod.outlook.com (2603:1096:990:9d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Wed, 3 Sep 2025 07:54:04 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:54:04 +0000
Message-ID: <4c7249a4-d4fb-402a-b958-e862b6eb04fc@vivo.com>
Date: Wed, 3 Sep 2025 15:54:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: powernow: Remove redundant 'ret' variable in
 powernow_decode_bios()
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903072936.4067-1-rongqianfeng@vivo.com>
 <20250903073702.g755d3xtjlkkdbfs@vireshk-i7>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250903073702.g755d3xtjlkkdbfs@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3101d0cf-aecd-463a-cc7b-08ddeabf0d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHYwci8wZmxOMk9oMWd2OVM0Z3VzL3c2QVVVeUZOY05Db043RWtYdzV2VHdw?=
 =?utf-8?B?a3AyQmVLdG9wNHY2Y1YvdTdrWW1ra1gxUXVaTkh3L2wvaGRhcExrRU1LbU96?=
 =?utf-8?B?UGlNVDRWZTFwTS9HcGdGYVNzbmJUQUYrSmF3M0RBc2RGTDk5dHo2a0RaVjI4?=
 =?utf-8?B?SG9XZ0hkZkNZR2dZaEhYenNRd2JvQ2crYUozMm5DcFI5RXlKOTJOazRzNWZI?=
 =?utf-8?B?UnM0MFp4WTdleVdvQTl0Wmt1eUVkTUlsOFJES2diSlpLcE14QTViSnBzNWJ6?=
 =?utf-8?B?cWxZM0poT1RFOFZDUlhINy9FdEt0eTRFc2NjZUJBV1g4SkJEbFJvN212WTVX?=
 =?utf-8?B?TDA0THg0b3pWY1d1eTl6QlhqOVRuYjF1a0pLODdjaU9IZEpkQjBRZWk3dHNi?=
 =?utf-8?B?eDFvMnNhN3hBTThEOThrNG9UV296RXArMnZsYUtYOXYyc0Y5Q0p3bkhKN1Vj?=
 =?utf-8?B?aG5PL3J0M3gwOU9OK2tjajR3TFFIL1hZN1FMZTRUY3Q1U2tqdC9tWDlFd0g4?=
 =?utf-8?B?VnFqTXZrZ1NvQjc1RHZnOVhIUE92YmYrUmQ2ZllUaFRvNkE5TWlUSEJ6S0RR?=
 =?utf-8?B?Q0JKSnJQQWdqOXVzS1B4RWV6dmxHVFVZb1pIdjI0SkhRb1ZTSHpZN0ZFNlZY?=
 =?utf-8?B?ODZ6SEo4bllqUVNyQ015anhFLzByeXpEeFh0MmViS0hhQ08xUzR5Vkk4Qi8w?=
 =?utf-8?B?MXZjMlFRUGhrYlExRzNRSmlvanh0Ky9sWVg2S29uNkcyb1dIWUFONkRCUUw3?=
 =?utf-8?B?SlR6N21rQjA1Njd1Wm40eDJjeWlKQW4xbTRwN1JhYXBXWDRWUDJ0TWVQUGxK?=
 =?utf-8?B?alZ3K3pWUjRDaXF1UXdZZ00zdVZCKzVXUmhpYzJOejRta2dPWElBcWRWM2cz?=
 =?utf-8?B?bnU5VHJiUjFzQlF6YlMxZmpCUGZoRW5LTHdkNWdySStpMkp2NHplQXMrUDM1?=
 =?utf-8?B?K0hvOHJyTWg2STBvRXh2cEk5NUJ2WjEzc3YxUXcyL2xkenk5M2VKbGpjanpY?=
 =?utf-8?B?RVZubC9BLzA5NkkyTFNkc3B4SmEzYW05aDl6K3R4UG94MVpqN0ZuN0sweFRx?=
 =?utf-8?B?MkQ3eXNRdEtmbFVRM0Uzckl6L1ozOXJDbVVUTjRxWkdMSTJJbEw1UFF0VHZK?=
 =?utf-8?B?WDdSd0p6TGt2UVArT1dpV3lXTGszUTh1RUNtU0E2WklWSXo1WDlBMUVYZHBV?=
 =?utf-8?B?N2duWk83NFJTUkdwNy9hN0JGazhDeG9aRXhCRTBsWFZod0R5QVZxKzZjMXdx?=
 =?utf-8?B?ejg3VDFmT2w0bC82QUZGTTREdHBuMVhSbis0VDYwSlRoeHNMOVdFbzdXQXRq?=
 =?utf-8?B?VXJuQkEyOVArWjc3eHRpRTRPcGYwOUdBNU4vK3FJS3lEaGFUYWM2UGN3a1hO?=
 =?utf-8?B?NVZYcnVSMnFDODlJRjBPOTU5QnJNTVB6R0pSM0FCWi9oT2hHbXpEV1VsVlhy?=
 =?utf-8?B?NkxNaVcrblN2SHhRdk1hSUc5dTZjcnpXMHBtZVg0WTlwT3h6L2lueVZSbkk0?=
 =?utf-8?B?ZXNSTDh3NHlrdGx2V2JzakJkK0FTZit1VHBHTXhjRHpBQVM1djJyZTkyNE5N?=
 =?utf-8?B?Z1Y1YXN6b2dQWms4NmZHSWlNSGUzcXhoMnhOb3I4UUJPdVczNENiNHBHRXR0?=
 =?utf-8?B?OHZxZ1UzeG1lbDNRR0drV3huNzBZVDJRQmNwY2x2dGdpT0lFMVJBMDRDeHV2?=
 =?utf-8?B?SGxnSU5KTE9HY2ZWUUE5bkl6c3VtV3pOTlFuZ0RhaXYvalJaWEVnblB4eWQx?=
 =?utf-8?B?ajhRakRKYmdlWkF5R25WN1NGTWxQV3dXSlIveUdMOE0ySjkyRmY1anlKd2tq?=
 =?utf-8?B?ejMrcUhZbFdicW9RMXdwTXdOS2c3NDFxQVlPbnBkZmhvZk9zZkwrdyszVkRU?=
 =?utf-8?B?RlU1Slo3NGsxY1M5NW1nWUk5VzdHWkZkM3UwR2JXcE55dDFiNHQ5Vm5scTJt?=
 =?utf-8?Q?YRBa/uQ6Ni4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUhLdHF5dmJDQVFzZmwraXJ6RXRPNnJXM0luN21icWZrOTU2VmNaMFhsMDJO?=
 =?utf-8?B?M1M1d1J6eEVhc1FoQ3R0YkRvSVdOc3RKVGI4SEoxOEJrNTZjSXhtQkNVQWJh?=
 =?utf-8?B?ZnFMUVRobU9yVm5KNzFNK1VsclU1eUpwZ0Jsa1FRUGJpUTBsVGFPRFMvVDFF?=
 =?utf-8?B?K0ovNW5uY29jQW1aZnNjc21vYlZPR0tzNTg1REV5V2YwRjBmNHBJTzJWMFhR?=
 =?utf-8?B?cjFEazJGbjJHa3lxbVZ1RUdPWTdxZy9DK3k1TENHSkRRaW5pczM4cUlkalpw?=
 =?utf-8?B?Y3FLQkEzUTZBbk9vdXhaL0NIdXlJYVc1bUtscHhBejFBa0V0SEV0UHErMHFS?=
 =?utf-8?B?ZkhOd0lQaVFnUktxQUV0dysrYlFNbHpDd1daZ21va0hVaEdPYWZtV0RMUmg0?=
 =?utf-8?B?OUVzR2h4Y09sQkplelNoam5sRVYrZXBXSTNGODVXY0JPd2RUYzBORklPUHVa?=
 =?utf-8?B?dkExakdjK3VhdXZscXV1VlhTV21CRXhOVGwxOEtQRi9hVmVqb24wUUJGV0JI?=
 =?utf-8?B?YkI0Y0IvTFdqL05pcUgzMHRhY2JrbDloK1NrUUdYb0ROWDZZS1M3NVQ4MjFI?=
 =?utf-8?B?ck4ydDU5dnR2Y1ljYXRHU24xbHg2Z3pyVVZaV0FJdW9iamdJNnlkRnpjdW90?=
 =?utf-8?B?L04vNTZFMFRPVEs3RUlKOGJXTUllOFcyckVuSWhJYXgwMGhUTjZvWS93QU5U?=
 =?utf-8?B?MGxTYndmclU1d0tBa0tDUFJibU0zUXJNS1duWTcvVXp1QlU3NzZSSUJUZmFh?=
 =?utf-8?B?WnpRQzRGdElXR01pN2JuN2syd09zSDFzZFBJckRWUEJSaExrSm10eHFwV2Z3?=
 =?utf-8?B?a3JnQVl5bVVoeFZhUkFsbE5lWG40TklQQ1g4V2ZydjNrU0VObDRPTUpTbVJM?=
 =?utf-8?B?YVJvMjhRMjJqTFhuYXZjTSt0QTVkRm1jdVIvN3pPcEhIZVFMUGRCQUJ3QnE3?=
 =?utf-8?B?SUp5OFY3M2JFcGlzSTJYNE5ZcUkrazNIQk5zaVFCOHZneG9zNWt3UDVVQkJE?=
 =?utf-8?B?MDQ1dUdqeTFwQ1ZJYW91LzZwNzF3Zll0VzhZZTVoYUFsVGI3SWVwRHdiVTNR?=
 =?utf-8?B?R1Zka2k4NElkZ2p3U2oyZzNPRmxXMW1WWlZnbjA3VitlWFVtSFM1NTljMitT?=
 =?utf-8?B?WmtaOGk1VFhJdklxTWFWckRUbGU0MFQxbzVjdWh0RDFESmJUL05WZHNaV3Vu?=
 =?utf-8?B?YVAxZkJDVWdmUVNEMUlDMitOVG1kc0ROeWs0aUZ6RWhyMlJKcEpsTHFWbnFN?=
 =?utf-8?B?WlZ0U1h6MGF1NGRzaHNCZ1c5SEg4UzRKazNOb3lRTTg0aXRBc25kV3NhYmtw?=
 =?utf-8?B?Nmpod2RCYUJuNW1tRkxpNlJzcDhhYWRIMURDd3FwYXp5RDgyQU9CejB4NVJn?=
 =?utf-8?B?V2pXemNDV3JjVjUwWlVyS2JacEdSa2pSWVczZTZNUEkxTGU1VnFUMDN4bndp?=
 =?utf-8?B?ZVF2N1c1UUFYQXJRUnA5Y3oyWk0xQmNWUm8ybFAzTmd6dk9NSVVKcnoyVnR3?=
 =?utf-8?B?dzVoajJtNHVKbHlLRzNsemRsdzVxTFM0VCtBbXZldUxXMUFaQ3hyUXdHYkJa?=
 =?utf-8?B?WXlkYks1L2xXanRZTEQwSWU0eDBxMzE4dXpMMmxQYjd2K0lHM3hNRyttbzVN?=
 =?utf-8?B?YXdublplOCtJY0hWUkdybVJoOVFLaEhCQzQ1MThOZzQ0R2Zxbk9WV3FoT2FF?=
 =?utf-8?B?Yk5ISDZRU2xwUUxWeHRSNWVnVFpQSVN3bmpHM3dXc01CaGUwNlp1NzRROWxN?=
 =?utf-8?B?dHFJRXZZa3VET2tPQW9GbWpFcEkrS2xJN0pjY3lpY2dJMmEzSmhGd0l2eEcx?=
 =?utf-8?B?ZW03STRpSzhKZDh0ZFQyclBXN1VZT0RSN3A0MHpGV1Z5b2crNER4c3F5UHV0?=
 =?utf-8?B?dklNM3kxRmpCbkpaeGVBQ29qY3BNc00wNWpFU2VIMDd6YW9qejNGeTg1d1p6?=
 =?utf-8?B?TU5sQkYwcDVBNHpQV3JHdG9IN1VVRWIxZEx0YitXWE1Oak5IRkMzSlhnOHdl?=
 =?utf-8?B?Mk5vWjc1aE1FUXhUb0tZaVlKK3Y4SWhBemZCcUsrWW9hTGxwaXRvRjhVa0ls?=
 =?utf-8?B?L1Q1T3licmlvTnFpa2tvc05tVU5xdUJLZnl0S3lpV0dFNk5XQjBVbDBPSEx3?=
 =?utf-8?Q?X7Pyi8HD9Wo3cb38NRRSwuLuy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3101d0cf-aecd-463a-cc7b-08ddeabf0d30
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:54:03.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEoAjIAF85KAANPUsJt+oOKajol9+mZ89ctMUywcht/A095x5siFJq85cF4+RX15FQ4z+RL3lQjOI+LyxQLXSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7108


在 2025/9/3 15:37, Viresh Kumar 写道:
> This should have been marked as V4 with details of what changed.
> Sending it separately is fine (though wasn't really required), but you
> still need to maintain the versions.


Thank you for your reminder and for letting me learn about this rule.

>
> On 03-09-25, 15:29, Qianfeng Rong wrote:
>> Remove the unnecessary 'ret' variable from the powernow_decode_bios()
>> function. It is only used once to store the return value of get_ranges(p)
>> before immediately returning it. Simplify the code by directly returning
>> the result of get_ranges(p) instead.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/cpufreq/powernow-k7.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I see you have already added the Acked tag to this patch-do I still
need to send a V4 version with a detailed description of changes in
each version?

Best regards,
Qianfeng


