Return-Path: <linux-pm+bounces-1093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D20811306
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668561C20E38
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010E2D04F;
	Wed, 13 Dec 2023 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZBgwDOY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D3286B6;
	Wed, 13 Dec 2023 13:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D310CC433C7;
	Wed, 13 Dec 2023 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702474570;
	bh=FKo7DMS2ILBjt3i1R1vfFoKi54X0jPj1QGIZxzVw/k4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GZBgwDOY8aC9JG2n44f5T6Xpy/9P4Q5M5cHnhogqs4y2CS4DvUQGX808eF7fk4ALP
	 GYbqznrszsg1NpEWaQMHd7EYaOKMxLBT7eqZZ3VQn9u+GcJVRe7J7lVyfi750iRj3i
	 Qwf0+EBL8vC4qihwH89IRRH/sX++6ahIFlX82UDe45PuYsTJNmHKEn/D9wsbunhRU9
	 cQoxht6wNut+PD92exEr2w8Yks45e5VlzWOdpS2TvMIEAMAVbEUyDe3nngwobTE5ZE
	 lJX/yi2Xby2mfnwekyiyiKmCaJiVeE2p1iazSM8I0YbWmvFS1drZKWo50b2DRMislR
	 kuIUqGobfSZPA==
Message-ID: <aefdf09b-3836-4f2c-ab12-7757448b9da2@kernel.org>
Date: Wed, 13 Dec 2023 15:36:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add SM6115 interconnect
 provider driver
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
 <20231125-topic-6115icc-v3-2-bd8907b8cfd7@linaro.org>
 <CAL_Jsq+FNYS-Ue1NQgDW_0D_NgONfsJj4Q-nzFWHHXpm0Ka=_Q@mail.gmail.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <CAL_Jsq+FNYS-Ue1NQgDW_0D_NgONfsJj4Q-nzFWHHXpm0Ka=_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.12.23 19:55, Rob Herring wrote:
> On Wed, Nov 29, 2023 at 8:41 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Add a driver for managing NoC providers on SM6115.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/Kconfig  |    9 +
>>   drivers/interconnect/qcom/Makefile |    2 +
>>   drivers/interconnect/qcom/sm6115.c | 1427 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1438 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> index 4d15ce2dab16..697f96c49f6f 100644
>> --- a/drivers/interconnect/qcom/Kconfig
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -191,6 +191,15 @@ config INTERCONNECT_QCOM_SDX75
>>            This is a driver for the Qualcomm Network-on-Chip on sdx75-based
>>            platforms.
>>
>> +config INTERCONNECT_QCOM_SM6115
>> +       tristate "Qualcomm SM6115 interconnect driver"
>> +       depends on INTERCONNECT_QCOM
>> +       depends on QCOM_SMD_RPM
>> +       select INTERCONNECT_QCOM_SMD_RPM
>> +       help
>> +         This is a driver for the Qualcomm Network-on-Chip on sm6115-based
>> +         platforms.
>> +
>>   config INTERCONNECT_QCOM_SM6350
>>          tristate "Qualcomm SM6350 interconnect driver"
>>          depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> index 3a8a6ef67543..704846165022 100644
>> --- a/drivers/interconnect/qcom/Makefile
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -24,6 +24,7 @@ qnoc-sdm845-objs                      := sdm845.o
>>   qnoc-sdx55-objs                                := sdx55.o
>>   qnoc-sdx65-objs                                := sdx65.o
>>   qnoc-sdx75-objs                                := sdx75.o
>> +qnoc-sm6115-objs                       := sm6115.o
>>   qnoc-sm6350-objs                       := sm6350.o
>>   qnoc-sm8150-objs                       := sm8150.o
>>   qnoc-sm8250-objs                       := sm8250.o
>> @@ -55,6 +56,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) += qnoc-sdx65.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SDX75) += qnoc-sdx75.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM_SM6115) += qnoc-sm6115.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) += qnoc-sm6350.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
>> diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qcom/sm6115.c
>> new file mode 100644
>> index 000000000000..c49a83c87739
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sm6115.c
>> @@ -0,0 +1,1427 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2023, Linaro Limited
>> + */
>> +
>> +#include <dt-bindings/interconnect/qcom,sm6115.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> 
> You probably don't need this header and the implicit includes it makes
> are dropped now in linux-next. Please check what you actually need and
> make them explicit.
> 
>> +#include <linux/of_platform.h>
> 
> Also probably not needed. Please double check.
> 
> Rob

Yes, these are not needed. But we will need to include mod_devicetable.h
for struct of_device_id. Now i notice also that other headers like clk.h
io.h and slab.h are not really needed here as well.

Konrad, could you please submit a follow-up patch to fix this?

Thanks,
Georgi



