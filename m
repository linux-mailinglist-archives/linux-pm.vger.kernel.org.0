Return-Path: <linux-pm+bounces-11154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC19326C0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47B6284894
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE21119AA5F;
	Tue, 16 Jul 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZnmuryUQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2023.outbound.protection.outlook.com [40.92.102.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE413CABC;
	Tue, 16 Jul 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133815; cv=fail; b=FKtUbnH5XV0yBl9Aa7OxkzU8+SfIqzr2+DtNuvWE9Ujkl23zRFSFiCTIvfFDrDlUhXENvkdcfZ8eDcRzv7ZLDKWLfvxjsfnAntuhjmXZJp5g90qiRvmDuVkTOqlWZejHdsH1fgutn8pM4pHEt5hgu2QPS5ktDAJVeUJwUvlXeEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133815; c=relaxed/simple;
	bh=tI5y37zONZ7Q8N9D0oabj/i9anmsJjeMT+OuQV4ydjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L52PAjg9MA/TiuR8IK7W8ir0ZIqUOwjj+X/BTVw+ZvXiddXgo1EHmO5mItuA6lcguIDZgFFVtnpYrHtE4RDBoxvFzURusdJE1ueWTtdNIwoUpGktLvWKDDaMhUuPzmH0vD7Vu24EyIXcyNEUwiq0TBk1fV2+KZKgXTyCiE8NRHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZnmuryUQ; arc=fail smtp.client-ip=40.92.102.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d95KVbZ21nP/1BAP/X355Qcl6gKtyfrDKgs/K5ddVwGq+jpusJgQQoW5SBDsb8O8Ok2/xEaxC8gndZ9aLxC3MmFI2qlUqwZWU0Xmn7CFi/gD4sbqRKiIU+bijC02x3x6s3aeHKYXW80JdEoVZSQJqlLOPHqsGL8Ff2palEios3jHwk6vNkEM2Z6WR3iXjSYUhgHB0rPQCbH/qsJxbjPg52l35hIk7CG2yC47F+q2qDERbFNyA2SMdl8dlXm0RyJ03Ic5QJUpqy4NC+t8D9hKdrzp64BoqSM5Ds/3ANXE0ew7aeIyyUMEuFEYV/ja3WyLAoj3awIXXZCMeaBAoOQv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbhlDfFEx8e1YSxC8khG9L9VX53bldQc+rWGKxT5jvU=;
 b=hHDUjRecUATFzXFerHSvNxg+4QDnKDYcTHiP7ydy3x0W718J193vED/4zWeZcJ3b7Fzg8xZgC5ui+sU31PqPFp+Bdnlm/5qIAzxdkZQ1GsfXUQ1iei66bamAPbjvVRb7XSqEAYQGm3H3T6VlNyjqkRAcKtLvKufjcTJVBwVMqlyuBtveK37MtdmOMhaOdT3QJQpMkf3FNEoj1syxSKaVfdbVeQnaUbXNe44YL6nFQmIPauXIYnlA9qYMvtVtvkyCw39dOXJwZVL/uAjVtFFUqUh9xMKSw68fs1IQGG0GXj8aF+EbsnUAU1I6u2uWIozSEtPeWgs/n7WSgubstyPtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbhlDfFEx8e1YSxC8khG9L9VX53bldQc+rWGKxT5jvU=;
 b=ZnmuryUQLO5PMTasr2xFboHeR7zaAl6lf9CL3doJJxzebiGmMfZKgK08ei4r8bkd+2vv83dV5/JfW5mmKJswSjiUKSMTl8kQRk7BajWHumxWJMnEbDf+lMSTa37OFyqjE3bd25P32BK8bQM1iHG0T5yucAoYT49MBBrDixwCsdpN1Dx8MQjeZdJjvoIrZSSSJj5cTDq1jOOKzjLE3ghy9unzEbCtn0qdow7FfQdGsDA3a2V/GN7GWn9/TcYow1zPIAzlQZOe9mgizAyhKvjG97RgTt+YQ9XdcKnE2VJdpKavCNPSi0Jy0jAF/PzlLWxLVLkN9j13YME6pve8KK9xPQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1114.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 12:43:25 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 12:43:24 +0000
Message-ID:
 <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 16 Jul 2024 20:43:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
To: Haylen Chu <heylenay@outlook.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [yrwUKm1i9gePRn1xm9eSWU8kQ8dF5JaE]
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <d4673d3f-4e93-496d-9236-eb67a16550f8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1114:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf25f90-ffee-4db0-2216-08dca594e21a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|4302099013|3412199025|1602099012|440099028;
X-Microsoft-Antispam-Message-Info:
	Nr1ckIhHJhfHbUfF9tPFekcmDS2rvQw35isqypakcQXdKtlz6W7gTVO20bmrg6OvzATp/Ywc0n8cMRBLjnJLVzkPiZRk8E5Mzjvsyo+TcSheNF4707pfCydi0BsCSGg45RRmIom3JDqkJGpqsKgvXr7J7+0scCaCKnR8tG7kUzMGgPTPeq7hJ0O28t8HSPlDEIlhyaCa20JWvkJfSA0CAOiaOiayi3fJ6C2us9m1Mzb7TRjtC4zCMuVApj0NSq5c1BMPvgCn0gbO4EFF593xPhLOwU8Cy9l4Vq/J8CJhvfNtGPt5hF/JouSVd80J+WNyvTBhxve0WVDLVPEX4bOD59OLQ8yn/us/5Whfngl3plyTCVa2OEbWjE+ZLPRQA16+xqALlgIvbC/5P+VMa5cFcI4+UFp4EwdS1SJgC9sLNDPI2dSIjyVuc1nDkO8NQx5c0hZGCmb3kjcpM5Jyz4DYNnKOzleyXOKcfloSVuz8Fpde+78TTyd24ML+BTDVsLofx+dUSkBWfKcky4vdrHBhoMRHbhIerjdp1Nz9d+i8Zusm4KKiz6Xjovu6BECMH+BJnv45uQj1bZoj5Gho0H+eIFPcS4cN6d532XT/cwivzhpwGZLo4Dq8r1SZLW5Lxas5kJaklXm8q+QlffmuttzMGLfRTp+VV1FZOtJhvb/GA56N5cnn9RSWthronBmRUw1ITrLY+1/nrxqXIl2SYUy6Yih1lRYyRHgxJSA8o039XzeD8mchOU77OVfUEQdrdQy9dOFOffq4EHVa6a4+P55GSQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1N4dlc5ZEVjbzE2QXkxT0VDUGVhN2hnRTZaSW8xR1ZTQ0dUS1EwdGxrV216?=
 =?utf-8?B?L0xkVXhsWTRWM0xXUlVQdGVrdnVSS2d5WnlKZkpHTzliRkJLRlBiR0N4ZzQw?=
 =?utf-8?B?VndXV3lFZDQ1RDBwQ1VncWg2ZU1Nbm9yVHRlT3JLMW9tVis1V0RKdXY3ZUtT?=
 =?utf-8?B?Q2VLMWlQcmZlSisyWUlpNHg3eHRBazQvaGlZMVM0cTBGdUJyS1RCUXlXUjN3?=
 =?utf-8?B?aTdrc0JsTkVDdU9KM24zczE0V2IyZDlEczdXUkFVM3hTWVZZS1R4elBGL0Nt?=
 =?utf-8?B?OHVpNlRXWHFFMzdpMHFuRFpUNEVtWENJMGdZbmRFVE1ZSnhYbCtPT3B0Z0Yy?=
 =?utf-8?B?eHZ2N3RQUGRQRW1OZ3Zjbml2c1lVNDl3cENHUExtVnRJMmdRUk9YdkdmenE2?=
 =?utf-8?B?eTI4QmpVWmdUTUNndUJJNk5XRDYza1RwMFBSSXNLVEEwcEpDS3E3REsxalhK?=
 =?utf-8?B?Tk55Zi9TdzgrSlZqZUozN3NTOGdWMm1DbTJkZlVqMzhwN0JSZlhXSk9yZUUy?=
 =?utf-8?B?WmlWL3lKb0NBL2s3dnlUS0JqUnVwT1FVdnhFNkZmK0oxRTY2VWZzTDFpQUtE?=
 =?utf-8?B?cjl1R01KeG42ZHdieWpnM0pYRGJUeWVkVi9aZEpqc2h3eG5VNVNvRHltMmR6?=
 =?utf-8?B?SnFxa3d4UGd2ZlhwOFN6K1F2ZmNGV1ozZnBXd2RRSS9CVnJGbGpCaG1NVEVO?=
 =?utf-8?B?V09QRDhENUd3b1lVTEFHS3BDVSt2azRBWGU4cmkvbDNPWEpXaFBsWjR3L2Jr?=
 =?utf-8?B?QW5YOVhIVks0OGkzTy9JZHFSeXpJbXllU3dQOHhkY0ZWRUFpZkg1aktFaVZm?=
 =?utf-8?B?YklOcnZxN3VvbWJGYXVLZ3pmS2NxVVFqRzRyVkVBb1QvTUxscUVxd3JiNnY4?=
 =?utf-8?B?eU42UVFsbWxIMExPaWF6RUlqZEF1RlhFMnlwajdES2VvSUNwRmpRRzVxWFVP?=
 =?utf-8?B?MW03TFR5ZytmYVllSGJwM2tnMTZvMnFDUTR2R1ZKNHdTb3Z1aWoxWDFTYlN2?=
 =?utf-8?B?KzN4YmZybC9IV2JVdlE3TUt4L2c1RGorSTdFR2J5VkhPMXdsL2tVTVQ2WnR2?=
 =?utf-8?B?NnBuQndjZnZtRU9LbVBMMmpCc3Y3WU52K0FIQ1ozb0Y1M0xITWZUK0FqVmlB?=
 =?utf-8?B?WmtzaTVZV0NiTjVWUEJNaExEQ050aDMyWGRicFJITGtXTUxLY1Z0cldVMGhI?=
 =?utf-8?B?V3VEMHgyYUFJc3lyVjh1b28wK0VKenVpVlNlcTFjR2tFZWdhOFJCN1lYYVpS?=
 =?utf-8?B?RWlIV0QrMFE4L0ZtL2pzeXd2L0pEUitPSHN4WVp4YWdCWFJNWXBxL1B5SVBD?=
 =?utf-8?B?NHU4ZU9CeUZuYW5SbVVveW1samUxanNsTjFuaGgrNjhFL3pYczA5U09FRmEr?=
 =?utf-8?B?MHl6ZVdNSHlxS2ZjWEpsQjBWZmhjd2FHU3hHMzMxN0NNSUwrVmxzNS91bCtJ?=
 =?utf-8?B?aUVjd2d6MTlYVy9ZR01QZDFyMmpqeVFoWmlDL0twZU1hMllqcjlJRHBjWWxv?=
 =?utf-8?B?bG5EelM2OVZSM2lJa2R3UHdmcGhGSnhQcVJxQ2cwdjQ1c0RaVHVsc01aTGh5?=
 =?utf-8?B?YnFOYUZZU0Nvak54a1lKSHozZkpmTzVmYmloR25tcG5uYXE3WUw0MU9tb1dB?=
 =?utf-8?B?WHlrMnA5Q1ZZVjhyMzQzL0psRVA3dlduTHFOYVRRb0RnL2lxSC9hUFZqOGZX?=
 =?utf-8?Q?d7jWHs+CMvnu0t6Lfs4G?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf25f90-ffee-4db0-2216-08dca594e21a
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 12:43:24.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1114


On 2024/7/16 17:42, Haylen Chu wrote:
> Add devicetree binding documentation for thermal sensors integrated in
> Sophgo CV180X SoCs.
>
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>   .../thermal/sophgo,cv1800-thermal.yaml        | 55 +++++++++++++++++++

I see sometimes you call it cv1800, and in patch 3, the file name is 
cv180x_thermal.c, and for dts changes, you changed cv18xx.dtsi. Please 
unify it.

I think sg200x is new name for cv181x serias, so if you want to cover 
cv180x/sg200x, is cv18xx better?

>   1 file changed, 55 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> new file mode 100644
> index 000000000000..58bd4432cd10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800 on-SoC Thermal Sensor
> +
> +maintainers:
> +  - Haylen Chu <heylenay@outlook.com>
> +
> +description: Sophgo CV1800 on-SoC thermal sensor
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800-thermal
cv18xx-thermal ?
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: The thermal sensor clock
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  sample-rate-hz:
> +    minimum: 1
> +    maximum: 1908
> +    default: 1
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/clock/sophgo,cv1800.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        thermal-sensor@30e0000 {
> +            compatible = "sophgo,cv1800-thermal";
> +            reg = <0x30e0000 0x100>;
> +            clocks = <&clk CLK_TEMPSEN>;
> +            interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> +            #thermal-sensor-cells = <0>;
> +        };
> +...

