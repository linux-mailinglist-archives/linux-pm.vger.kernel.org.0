Return-Path: <linux-pm+bounces-11192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D1193355B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 04:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7760B21BA0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048E469D;
	Wed, 17 Jul 2024 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SS/xll2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2092.outbound.protection.outlook.com [40.92.102.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF064524F;
	Wed, 17 Jul 2024 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182507; cv=fail; b=s2ZTZ1dFxfxMOpQS3z7A8ylyEjZ5pnABbngi4OtdWMUAvkw3979bM3PbGQK7Rk+nnVz6VUR8c3X5wtCZdlMBAqTsMJdF2LlXqxm5sKe2tHn4Rf9h7Nob3b/zhFW6tAkI0PAzKF5oxd+vY05nPBm32l40xJof1Kl9KpfD+nr4MjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182507; c=relaxed/simple;
	bh=YxdnAkXkBfQ0HEFsuszMXi9a9oJXNpC0QehxPDGHVzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qnNY0mS9Exa9+8vJuhYAMVM6ZAjSiSo8Ny5rJ+r07i1oAIxPAOITF+BBYH7L++CPv1ciBNrUB/X4s6MlzsSw2l5Brgd4VtJje5wBMrEwvLiUsUViJcAGRQ4azXrNihnfJZAiJAnJz42whnSMQKy2549yOYbwzLgQyL6sn8Hy9l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SS/xll2r; arc=fail smtp.client-ip=40.92.102.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib1Z3ug0vb5iGmvjouTr2elJorZ9cLxIqvb0n2DQN6sNwt0xihdFLYo3upOyr8yUYqt1r2g2VQRPG747SHLCmND129tkP5omCPyUnOfe79HSUCj/eXQvLi1NKFb8Mn1waV8fP1vmNUtCxzauFPqmB1V5h9w9dV9Kkkd6xETqHn8AxGicwmw62GAJZnl815xBXfrCMEkmUMghtYVRCJDxES2Gu/bMHl6QoiOVIhvqC3Uf904tEjke6hneJ34N3rq/U8GliZ/xFqBemNl3784yvNxJlMRLdi/OSl6ojnGc2jJ3EJkqbuCEG3d0+qV4caYyY4JRgi1HXbZQcrQD1BzfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rii14YrJLaJ+M9FvTgB3lwmilGEKwFezas2Z+xgjn3c=;
 b=Etqi2ctBwNcD/hGqFKl2n3h/BAbiZquv4uL9GBMYx99zEzZzUUDPS2zKE9FFpBaFosdS31K4HWEsPKG77vMDJXhkOnjQtDU4P3+hudSSYY9xH6pB3zZxOouYm1NzhGcwnnGysPXXBC9/h6/4tmN3EiIyHhEXmferrovRiGVnJsZDAprOoBeP2hS9GrPiEZ4/baG+QUTxqIHvfeiQDCTX/erBvq2g/5sWut/cvcbqHeCcREzuxWt1MDISv0ym78Uxu6o9defDwIcOpRDInp34fcwehPDg6U9+Q8B9UKSpOnMayeyRHaQeNFFT9YnmERNSSKwJaxEbUmVk7krNKLKp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rii14YrJLaJ+M9FvTgB3lwmilGEKwFezas2Z+xgjn3c=;
 b=SS/xll2rdpQtCHSYEDUlMRjsFYPtEbJYEa0jrECxIC8jFtf8LXYrjfU62QGnlrOFQfWHv1xrMQuGgxaPKaaXzScjWSd87WWaJCoIWTXQek6kmrfg4gL7BJrUNu3MTGLwXicJaSM5rRym2JzVXrqSIDv9CpUjYcd4Qoar00Bp8r7WIIIzXc9msNkQ0/Q4fkOmu9hJ8dyMRnk+iWjvfkupSUqFWLFRHBnaph4MgYSmk8BCtbajXgb5m7rdUN4fKw/fgv6hXxch/4xUI6bMvPgRMOwR6ZgCPDpFhkHBsHP3qXAvUUDMF407qkDJTNx1qsZ9zY4kLffEc8o2SwwR46v5Iw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1588.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 02:14:58 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 02:14:58 +0000
Message-ID:
 <MA0P287MB2822A2F07F21FC5445EF8946FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 17 Jul 2024 10:14:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
To: Inochi Amaoto <inochiama@outlook.com>, Conor Dooley <conor@kernel.org>,
 Haylen Chu <heylenay@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240716-cloning-canopy-a6799dc7f3b9@spud>
 <MA0P287MB28228BA5CC8B6F61A4C237E9FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953D97AE6DAD99C386CB7DFBBA32@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953D97AE6DAD99C386CB7DFBBA32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [GYOp0cl81B2eN/SCzWhkmlf4tuF4+QYn]
X-ClientProxiedBy: TYAPR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <88d54304-23a5-451c-971c-59d3720a0a1a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1588:EE_
X-MS-Office365-Filtering-Correlation-Id: d2644d8c-7a33-44d8-7a61-08dca606406f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|4302099013|1602099012|440099028;
X-Microsoft-Antispam-Message-Info:
	klGHeewaT5fU1FFvsF49INoLX/AIbtq1NyXksSkrA2s69kcGP+zdv2u8Sa80zGzoc28LQQx1O1XGmto0l8BC7lWTdXJDDcLUg4SZGet7/8YYIUN3y+9RAdyPVEoLoKWHBQiK1khxkTz8FBExlkVJNuiYcl4U6Vx8Ye6QF5Dj3LAkwSs0k8D/Sb8f03s1BsH21n0EtgIOwYx5XJIKlirqYSHB6e4+APS88Y9qNz42ccXMZX0cQMVOT5j8cIVMuqgESGfilmwQO86p1BgR8YUsN0sVgd4lbvsG/E8rTHpQiDoRyYrN7wRCj2pqSScG0+lbtmoPdgLXaaBQ9C7Vo5wRA0pBxirx4Oy1FlRPBeH2M1PBKMmtLZeULTFgZ7wKBtxnzgYjzcB1DYYXM1zv/Pm03VaLDa/D8+rGu/21WIr1YBBdhkJeRc0Y1wNJDHW0IlRbZ7YkReB5BqWbRxaovz1PWN56JSh9EvDQJnZfzmb0k6Ccwa5wGka4D2V0Up3rjTXNaOfcjXRYEroI9avS9cD5Gpz5Ul5ACocH99yhyi6SulBi3Ew4h2D3h5LGCwsyt6G+a66bJMeaNMOeFBIDVmZkdIesYYCVEiRdaOkgXlqG/Ne2BOeTJL/YORxx/vC3JteM/ZlvS5zKREN50oJkCHrPgdKGU62vyTzXG9O9q4837Edt9gBTb1ZeqyxZFypprV5JLWtsxHweM80puUlOLlRiMjpr8eCsJlydPytcuq8Ogcpp5TBEKzXDTplq3KJT9Hro
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW14a1FIeE9NQzhzOTRIa1BVQk5GRXBtZHlML04xTHFqcGJRSWdWZi93R2Jv?=
 =?utf-8?B?ZmdVdDE0WHVTaG9zOU5vT1MxdEk4VWJ3bUp5RkQxTGxWRVhLclBjUkxucFE3?=
 =?utf-8?B?N3piRDd6aVhJOXNZcllMR2Nud2hPbitpVXBldUNsaHQ3Q01Lbnh4U3kxYk1Z?=
 =?utf-8?B?WkVBYUsvaFNGUjRiNlM0U3VxaUVNNktoVFg2U0dYelFvSklWYUQ4MUIwekpW?=
 =?utf-8?B?VjFDeVVSczlQWHpVc0dqMTZDQTZRb2IzZjRURmF1Z0VFYkFRdjNMVFdRZmds?=
 =?utf-8?B?VGtoZ2tZQjhVNE5YSFZuaDJnWXB2Vm9jdTRiR2YwTTVNNmZyMGRUZXVCT0lh?=
 =?utf-8?B?SmJpdVJoWGxlM2F0U3pXSElpMlpxdXQwb2Q3MVppdEhTVjQzdkNTd25RbmdV?=
 =?utf-8?B?SUFrallXU2ZyTUFUM2REeDN1Zy9mcGU1cXV6Q0xTd3BvRnV2MEVrQk9lSnZQ?=
 =?utf-8?B?ZDFpS2JXMG1PNDRZQjFhU3RQZm52aWNrTkp4YUt0eXQ2WkFtZUgvYzF1d0ZR?=
 =?utf-8?B?cE5lQnlZTm5IbUZBNjRoUjV3OS9YRmNDV3B6U291OVB2WHFlTTlTY3I1NlBs?=
 =?utf-8?B?ZVV3Y05GSVZwTFY5T1BWdDZ0TnhYb2hlYlFLSUZCdHRpVkdQS21pN3dUd2R1?=
 =?utf-8?B?Um95Z0JIVHZrYkpBTnN3c3NDNWord2lUakE5bVMycSsycGpGVXYyZWM4bUFl?=
 =?utf-8?B?d3BQUWR1OFI4dnFVUDlqWTFvWnhvbWV0dGRvK3pTUGE5ZnhkdjB3QTMwOEZM?=
 =?utf-8?B?R0NwQU1tZG02QlhMdm1icHBORDVyOU9lRE0rZkV2UVRPempyUUoyL3VWM0Vi?=
 =?utf-8?B?bEdOSlRvVE5CUmNhbEFmMVRTWHVHMndZZkVralZlOHBxMFJFb3VlM0J6ZTU4?=
 =?utf-8?B?RXVLWXNqRVJwbmVjRjFzQ2RDS2ZaMkkxQVBTNFlDaEhMVk01TWlyenFRYjN6?=
 =?utf-8?B?dFZOelpkTjY3WTR4aDFPRUNxN3BVQWpVTzBIRExXV0NUZ2hrcWhpSGdwejNm?=
 =?utf-8?B?endxdFNUOEVhcUw4azhDUzBrNjNSVnRiclQ4SnRvM1ZVQUhZN01OcEduVnZ5?=
 =?utf-8?B?YUdNK1d6RHNqSjgrT3d2QTAyck9qVXI4NXVRVjZPdHdCYTl3SGlzaWJvY3Jx?=
 =?utf-8?B?WmRxS0xiS0g1aGZPbEhHNWtySERyQkpEYXlSdVAxODlKUGo5VjNFdTZsSTRq?=
 =?utf-8?B?QTJNTVk3VjlzYlBsL3JaalRzN0tGMnYzVzVxb25QVi9MdWZsSE9OMXdiWjJL?=
 =?utf-8?B?ODZnUFhNcThKeW1PT05ES3VIbmVUOElEZXFPRTl1cTRiNVhMNmZSZzd3VkZY?=
 =?utf-8?B?eVoyNThXNTlBazduNFBmWlRuMFM1L2hVUFJWeU8yYUxSbFduRUtZWTkwcjZB?=
 =?utf-8?B?akw5TTNvZ1YxdmVIUmxPTzVTSGdHUlk1STQ1MUxlcHp6Rlh4aWE5RW1odEQz?=
 =?utf-8?B?cnFsOCs1UGhCbTlzV0t3d3gwTG9tWEhtQnVpUmFYWS9xT3FtM2dGMGlGeXhx?=
 =?utf-8?B?ZEFYWnJUUGZpNEpHOTc5bkM4K2JaN2p2NWpITmdEemt5YitDZ0RDQzJxS1V1?=
 =?utf-8?B?eC90NFg3R3FzR0kwN0hYa09oZEtSUmNiWnBHSzNpdUZpUjdqTVRrVHJzZFpT?=
 =?utf-8?B?UHFoY212b2V0dFRsUFN4R3U2UVY1RDhVdEJEUmplOU9EYVhBbzRWaDVoQyti?=
 =?utf-8?Q?SuSIg4R//xDagspVj8Yj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2644d8c-7a33-44d8-7a61-08dca606406f
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 02:14:57.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1588


On 2024/7/17 9:27, Inochi Amaoto wrote:
> On Wed, Jul 17, 2024 at 08:05:10AM GMT, Chen Wang wrote:
>> On 2024/7/16 23:48, Conor Dooley wrote:
>>> On Tue, Jul 16, 2024 at 08:43:19PM +0800, Chen Wang wrote:
>>>> On 2024/7/16 17:42, Haylen Chu wrote:
>>>>> Add devicetree binding documentation for thermal sensors integrated in
>>>>> Sophgo CV180X SoCs.
>>>>>
>>>>> Signed-off-by: Haylen Chu <heylenay@outlook.com>
>>>>> ---
>>>>>     .../thermal/sophgo,cv1800-thermal.yaml        | 55 +++++++++++++++++++
>>>> I see sometimes you call it cv1800, and in patch 3, the file name is
>>>> cv180x_thermal.c, and for dts changes, you changed cv18xx.dtsi. Please unify
>>>> it.
>>>>
>>>> I think sg200x is new name for cv181x serias, so if you want to cover
>>>> cv180x/sg200x, is cv18xx better?
>>>>
>>>>>     1 file changed, 55 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..58bd4432cd10
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
>>>>> @@ -0,0 +1,55 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Sophgo CV1800 on-SoC Thermal Sensor
>>>>> +
>>>>> +maintainers:
>>>>> +  - Haylen Chu <heylenay@outlook.com>
>>>>> +
>>>>> +description: Sophgo CV1800 on-SoC thermal sensor
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - sophgo,cv1800-thermal
>>>> cv18xx-thermal ?
>>> Please, no wildcards in compatibles :/
>> Sorry for my confusion.
>>
>> Haylen, so you want a compatible that matches an actual SoC and use it
>> everywhere?
>>
> This should depend. If this peripheral is SoC specific, it is OK
> for using SoC specific compatible. Otherwise, it should be series
> specific.
>
> For thermal sensors, I suggest using series-based compatible name
> as this peripheral is the same across the whole series IIRC.

What's the  "series-based compatible name" do you mean? Can you give an 
example?

And allow me clarify, what I said "a compatible that matches an actual 
SoC and use it everywhere" means to define "sophgo,cv1800-thermal" just 
as Haylen did and use it for all cv18xx SoC chips.

Anyway, as Conor suggested, we'd better not use wildcards (char 'x') in 
compatibles.

Thanks,

Chen

>> Or we can add ones for each SoC and have a fallback to cv1800.
> SoC specific compatible means most of the SoC have different part
> for this peripheral. For safety, it may not use the fallback
> generic compatible.
>
> Regards,
> Inochi

