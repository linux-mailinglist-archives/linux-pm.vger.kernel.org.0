Return-Path: <linux-pm+bounces-38676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C37FC884BE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 07:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00C8E355BA0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984131691E;
	Wed, 26 Nov 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Cr8/Hp6c"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB02313E31;
	Wed, 26 Nov 2025 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139283; cv=fail; b=b808A7HxIpPJ9RFcUXdLleSylfxlvx2xd+88pB9RNLO8f+xLrgliuXi9393PaGy5djy0mOb9ZkE74bjHMa2bHcuht3KoGNz+z7t+TAmarqEdWrAMNooqX0iB5ZYyVWe0cJnlEIqpObEzvrzMSfVvu8G28n5fa/jbMkdxPTWyEtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139283; c=relaxed/simple;
	bh=q88JB2uR876E1r7mKMWTvmBHENdhBctlTP35ATrxdvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHvdl69xBXQ8JoYTct/aFOwrSB3SkkH+6OzNgxV2dzKzelBIt0nd/LqL0CBoIriO7tGAPrEghFa300jjcVeWou2fqPxD8SKIVtrWSmt00dZs44VVjKvDUQ5JQz80jYOID+T5k7nR56oF7l1Mrj5aRDzHHHpaX36lSCWiBarxELg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Cr8/Hp6c; arc=fail smtp.client-ip=52.103.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INkzRD++urYilw4pDDe2hKR8ohtQyuukesFqTUvDE3Ig8ZBBlH5be54A1dKM+1y0B7eYqg/5hXETX9DatmTK1B6RVie1Srh9EP7js6Q/df9DWfB1u3fdpJa+u2b7+4gjE4BKWrdQWkn+m0sf3c/sIa+/2OmAddVUCI+22lPGe28oWcDJBd7zSPQIaynem9+yvfoKVBOE98qDdX7BufQZiz2jMKyb+xO0QGeYZC1Y2+twYIlUgYiVM41G8Nez006rMOugBINohGGIVWFADPwYTE0SoHbuI7sIvA9uCNDV/QFKg2VEnICuyo/4igL0klzmPRDqD3kSs+4p3Py+isjNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LdIB0EadAtuOqupvGi2DWv7JWVfmXNNX5qWkwsvqLQ=;
 b=qHouWCrMxSeuTzO6Im+uZqZxqA3np5GKZZuJ+y6mWqH+yx1yTiIlGkFM11qL8LGQjp8ubImylZ4Wy+2yX9YC7eUDV05GMALHi9wwc1dkvyBQEaemRmB/QfWqs2LJWffaTTRBO7Tfy5y8lCWf1pAma3q01oiCK4tFIkCb6k8yrto7zKNIz7IjYGUR7dYFYE97JyFGgb8bQLTnYHYMzcA6Q2Awruepf/6BikPHq/QWzdLpfFfilGCDksGIQ8L306ASB9G/I9dad3TJPabcMNVjFeVpMNJj3TOkMQtLZjvhjOz53dyXr0yz1f8NIOakSh8hac1CeJ8o8gKw3JmNC6QZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LdIB0EadAtuOqupvGi2DWv7JWVfmXNNX5qWkwsvqLQ=;
 b=Cr8/Hp6cl6jZfZDR1XdI/SqJa0xNfUR0WDxDr5jr/DHP6EjLZeVpf2fwdhzpv2j5BNtjdSHtlXt4RK78rsB7nFpve5DMENd4PqSSFaBz2o23CoJVSlZ7yayT6H/Q9NqEqS0rFtQJEvv5mDCaYcoblyBIY9Y7NokO0pvYiJjHv9+pWBt11awuUnHjcXELEG8irsVAQUjhgQXtCtnfYv3V2ufzarGHE499kVaqz3UO5VJ6vmMCAgfuYZlT+D7aKdEZVuKeOZU+8hEhFNYiksAokjMSC6whSaAbpfLsIMctFQ+YwSNaXEBsnFNwC+MB2qcv6mGzies+jCk64qpUaiaszw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SJ0PR19MB4809.namprd19.prod.outlook.com (2603:10b6:a03:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 06:41:17 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%5]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 06:41:17 +0000
Message-ID:
 <DS7PR19MB888336A2FF72E59289F7E4B29DDEA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 26 Nov 2025 10:41:07 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018 tsens
 standalone compatible
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
 <20250818-ipq5018-tsens-fix-v1-1-0f08cf09182d@outlook.com>
 <fe1efb30-9d23-4291-a21e-80a5ffb954b1@linaro.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <fe1efb30-9d23-4291-a21e-80a5ffb954b1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0001.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::6) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <a1516a75-47a7-441d-b960-b37009458f2e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SJ0PR19MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: 220884d1-642c-4c52-8cff-08de2cb6ccd9
X-MS-Exchange-SLBlob-MailProps:
	rYPt1fhvLTXldmhndCG1doo/61GR+z6VFYLBOTBtoH/B5l1IOYJ/dyKkU9fxuMbTNvHhvpTPJukgneIQHNVXL7dh00RBWOwyw1ZOayyhGsJb9vwzXfaUXV1iF/DJL+KfmZXYL3KE0qQd+Qcsvj3KAySSORWh/DvN8vKlJZjfzfLp2n8dRbzjKU81x1W8GlS1bC2sGUzKGj3mY2IjN1IA1M2/mEmiT48GrYevnUWJ7MraxdeyAQIsVZdB1CmWS9KV/WbqXL5HSCPU6D+ImvZuyQJbVHUh3rxucyX44vB40yBAgvkm2uhmAikMS7vaDLVYR7JRQYmewwjN87rSEnn7kyjpz0WXMPOpxbujEpy1lt/iqXd8cpytbQJ3kyeEF0O+uZFc0/CAP0p01VL4vH7xrp8KA4KOvCvvciwoHtpUp4D1lyTk9SsKoNcrx1Ldo38zb7R+FmjpaPMv8fn8Xuja9zG3rgXzGs/8g4ZdQeuTYVFmu83DjT+a9glo4YPQNl0lj8a1N/73VVASZHEXtAujfi+EdFkF+SpxoSI8TzHGe0VnC7OxO29IpcffWv2W9aR2cliYydFhXsY8N7LwL230PuFXTAjhDTamzrKv9Llmtl7pPVaUv0e+UQO+yYH3WRqrCjJ/11yJEQv+1WPnTO8R0WdTVhxOdxqdM9Ej55dfzoLelr5xDBsxAkZxQQrxSNsi+g3yUf5PuJQxpp34Qy+0Xg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|23021999003|19110799012|461199028|15080799012|5072599009|6090799003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU9jZThnYWlqZnVOaktQYUlRUU1QcnIyTks1MWlUaTkvWGFkcENsdTB0ejFt?=
 =?utf-8?B?VHBTWWx2Wkh3ajY3M1IyT3FValN2aUJIYVVCS3pEOWt3aE02NE4zTVRtY2VJ?=
 =?utf-8?B?ZzAzQkRENGM4WVpnRVoycnVoVVlJVUdBaE9NY3hrcUp0WkhSQkwxMVZPU1Yv?=
 =?utf-8?B?TGRBQnN0MUp6b05FUHhOeG41eG03TGp5akhIK3JLN2NNUUx2a0xvRkUzL0xU?=
 =?utf-8?B?RStZS1RyeHdEU05PeXRRWUk5b3FvZnlEdUt3a3lZTElZejJLOW5aUW5XZzJ3?=
 =?utf-8?B?a29Ka3B6bGhEWExlcmFkd3FFM3p1bGxuSkE0OThvRDdBNnNhaVJjekZxd3M5?=
 =?utf-8?B?Znk3K2hBMmFKSFJZclBMY1Y3eTR6UEdJTDRmUHBCVVZhWHo5K280bzdBenQ3?=
 =?utf-8?B?a3N6ak5ETWNhVnUxeFpwdUZLR2E0TjNnS29ld3lOMDRrRnZTc0RiNnBqRDhu?=
 =?utf-8?B?dGpuYkhhNHdWK25GamI5ZDZub1A1REcwalVPbEpwUGhvTGJmMytBK0FIdjVX?=
 =?utf-8?B?Q3c1eEovUEg4NkM4cjA4RXBaRW93U3o2a2VPMGpuNktRNHBrbUdmQWFJSHpU?=
 =?utf-8?B?VkFQaFRmaWZJV0ptdE9ORUxtSEpoSW8waXNsOU5SSjRLUVVRV3dwSDJPRTF1?=
 =?utf-8?B?dzBLZWVCc0lMUmZTb1pBMTA0N1Q5SWtWb1llU1VaSzIvNlVLR3VSSkphNGMx?=
 =?utf-8?B?M3RIWjBYZkRKM0tTSUhNcnQxV21LamxaVXNGR1NKbmI0MVFxMkxQRUltazVi?=
 =?utf-8?B?TnR1Q3prN2ZUZTVERVArU3ZHQ2w1REF1b2xqb1JpbXBuWTJNajFvelZtRjEw?=
 =?utf-8?B?SFRrVTZVODF0T0VweGwxd1FRSlJoUndHcFNqUTUrVTVlUGdwRk82UTcxNkhU?=
 =?utf-8?B?d291U3piMC9TTk1TK2k5SDlrQ0xTUVM3TUU2cDdmS3ZDUWNuaG14UzhNV1kv?=
 =?utf-8?B?cFY1S1dmSE5sMUQyVGFMY3VpNWxOdGp6TG1yNHFXZXlqQW9zS1J6TDR5Q25B?=
 =?utf-8?B?R1I5ajVPT2xuMm96MjlHd3VpcGJoeW93UlI0QTc3Snp0K1VYeDY4TFNYR0dC?=
 =?utf-8?B?M21GRlJ3amhqUk1KTWFDMEZiWjlDRFgySUxhNnlWVWphZzljL0VFaWFyL0w3?=
 =?utf-8?B?Z3FaYnR2Y1BLeWNxeXY3Q0dmWEJvY3B0cmRQekhPOVNEZFFCVHZaWWFDd1hY?=
 =?utf-8?B?SlNmV0dlT2RablJWVExnV0EwZGlDMDFUTlpTYWN1RnJYdGJlam5nbE1FK1hZ?=
 =?utf-8?B?eTVUeDFQNmVURnkrb3llaFl2b2REREE1MzRsZ0c3MTAwY0NXMzU5Tysxa2x0?=
 =?utf-8?B?THFFYkUydGFndXZXNVNXa3pqeGdYenVmQjdvUzU5bllFcGYwckdZN09qalB4?=
 =?utf-8?B?dngrOXp3b2J1aVZsSkZLeHg5Mk02UHpvYnVYdyt0cnFOMEhlUVA4alBCQnhx?=
 =?utf-8?B?TE1qVFhCeEhkQS9YaC84MGMyQ0wzT1lsbUNZL3NnWXZBSUoxU2V2Q3JQdk9t?=
 =?utf-8?B?b2xrUnpaWTc4VXdmdkhrZG1KOUFjUG5jVHlOWlVyUEhTQmZkbG1kdDI1dlpU?=
 =?utf-8?B?VythRnJxQURGcW5qVitUdzhpN1FtMzVNcUdJcG5ONUtOVGlMRDV3cXNaR2k5?=
 =?utf-8?B?eFJ4QW9lZWJmdTFQRkZlRmpMVnZlcVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djU3NzMvSkM2U09SQ0pLRHJDbmczS1lXTldQaEFGSlowVGo3ejhvMGFMNVFQ?=
 =?utf-8?B?Rzd1RGliUFVla3BGcHBSWkt1bm4xVHh0eGZNQnI3UEY5eU1UMlZwN1lONXl5?=
 =?utf-8?B?eEppUGp0WmlMQU9uVjlDS0FPaFIwZGYyWE9sdkpLZ2tIWTdGbk52ZUpqTXV5?=
 =?utf-8?B?YjlWeVh2VkFrank4YWU1cnJpbUVMelp3a3NuMmpLS2lvR3c5YkpkVjlsVFA3?=
 =?utf-8?B?a2hrL2dSNTMvZlh4ckptM2VNajhtSUowNm9lY0l6OTdVLzd1NG9lVU0xcmRl?=
 =?utf-8?B?bGVBUURzT05oSmdxZU9henhrSnQ3dkNxTWxiZlRqYTVzUnBxait5V2liNHNk?=
 =?utf-8?B?aHJtUVNBZ3hocDZyMjNOR3YwUU83WG5YODV0RWFmS3F1Q1hrSklqNjZkeTVL?=
 =?utf-8?B?STF6TG9VWVl1MzhFTFdIUllyYkYzei9EYWFlbzh1QjBpRHp4NTNNYU1iSWlG?=
 =?utf-8?B?dGxNakdjQTJsaENnMmxrMGFjeHV4TmRtMCs1Y2h3L1hZVXIwek4xTnBVOFds?=
 =?utf-8?B?ZjE1Vkl6cXY1aCsxQXJ5N3huSDFBRDBhUXdadTdZL04zQVl2Zmhnem56MXVV?=
 =?utf-8?B?S0NqaVd0OGt5R3pCSmZMU3JiMXc5REY0T0ZjUjM1cmtDbXMwL1Uvd1N3V2I0?=
 =?utf-8?B?a1VIemxBL2k5TDhOTVVpU3Y5akdRVDBDTU9CUXpDaFZldmVWTG9TUG5zUWZv?=
 =?utf-8?B?U1Z0dWNxZFRycnhPaFNLeE0vVUFuZzhzTHFtTDBaQk5sVnNtTzFUTDdKZk5W?=
 =?utf-8?B?UEFEUWdCUFdIbm1zWkYwS0lnOStESlpDcnIxS0g1NTJ0bjRvMmEvUGtDSlBM?=
 =?utf-8?B?TkNaUGJNYk4xVTdPZEhmTmRyQmVsd2tNYU1RQm9zNlBRK1ZkZlNxQmd3MXNj?=
 =?utf-8?B?TGcvVEJhTXRiZXV4UC92RE9SazZIcSsvY0NKaVN1RncvSHVwSlpzRmpsaVZs?=
 =?utf-8?B?OXZoSk1LRTdodnczRjIvS2E1UlNKaUFqSDVZaFBLRWlOR2hoZXh1Q3NGSXRB?=
 =?utf-8?B?ZFVyRTBOTkNqdUw1UVlWVG8vNndiUGVCRXMvUGxKV2xJVUZsOGJqUmhPMm0y?=
 =?utf-8?B?eEJKZVdlRndxY00rMHFRRWhKdVZXaTZSdjdENGQ3UmJXSVl3Z3hNTUFEMk1o?=
 =?utf-8?B?MDBzQ0NIRW1wU0VjYVM0endIVm55RHNuaU1kbkNKb2NKbmVCR2RQbW11NCtZ?=
 =?utf-8?B?clZFc0N2SjdIWFE1UGJtekM2K2FiTHhBbDNlLzkzUER2VDJITExBQk93TTJT?=
 =?utf-8?B?OFBXVmV3NThkdnlINUJnK3BhWlJZek1wdFVqeUJPdmJtNzhSTWpQNjdQUzRp?=
 =?utf-8?B?dHd1SGhJZXlSSXQzT3EyalVjSFB6WERCNWxHYzhhd2lST0tBUEF4a3F2bCs4?=
 =?utf-8?B?ZkZON1RQeWpEMnNVNGU3ZGJIdGYwQWIvSHNUTzk5bHdMd1hFSkhYMTEyZDRV?=
 =?utf-8?B?Z2U2aExpWDIrQjQ1M01PTFBsS1hlMVdPVmUvNHU0SGVET2cvRXlHb05yVXpz?=
 =?utf-8?B?OW13TVlJR0Y5WURvcmZwcEZDejQxQ25KOVFuekhpei9GZEtOWG81NjdTaVVM?=
 =?utf-8?B?bEZUTmd0bXdnLzB3c3I1ZW1EWm1yWEdLek0zeTRhdkQ4cm5RZFdZRVh5ZTln?=
 =?utf-8?B?MVA0d2tpNUs1a2lxejEwUmJFbTFQSFhvcWRlcnpHYnNzcXZady8rUWlacWxt?=
 =?utf-8?Q?yZnUYB4U6g0UIzeNixkc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220884d1-642c-4c52-8cff-08de2cb6ccd9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 06:41:17.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4809



On 11/25/25 13:58, Daniel Lezcano wrote:
> On 8/18/25 13:33, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> The tsens IP found in the IPQ5018 SoC should not use qcom,tsens-v1 as
>> fallback since it has no RPM and, as such, must deviate from the
>> standard v1 init routine as this version of tsens needs to be explicitly
>> reset and enabled in the driver.
>>
>> So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.
>>
>> Fixes: 77c6d28192ef ("dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible")
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
> 
> Applied patch 1/2

Thank you, Daniel.

Can this also be backported to 6.18 as it's currently broke?

> 
> Thanks
> 
>    -- Daniel
> 

Best regards,
George

