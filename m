Return-Path: <linux-pm+bounces-12955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A29607C0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A479B219D2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06A19E7E5;
	Tue, 27 Aug 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp5f5H5N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDD176AC7;
	Tue, 27 Aug 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755519; cv=none; b=p/cJzNI7wlhMmsRDFKh4MFsD0Yb0tRHDWV8Ud2TqC8UJx8Ih/NJ49czKKgD8jskIHXRndTT6Knypy8P7onOXSrmOmEm1NXOQDSc+sBKUOq2vEUI4UDDEi16XDuFWZNJ+IlcNAu7KDpOVf20QMJmvQ4kf2JJm/eCU/Fc2RktQshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755519; c=relaxed/simple;
	bh=Q970sNHoTRg2QJusl8JkgL6SI098FZHOU84TccyQ3A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcaLGEDe7HOiSamDjL5D+5pRSgjyDmkvkT1IGhlTBGgD8wryXXH+icez7wp1Kbm0T7gjweZ+7QY6ViCnbAAOOx8/NiJxgDVcMGWhSS/Laf93PlFmcWpDyJ5yt3FDDCIsbDTLHJ0hU0awvENoCHe1JDlOsYaY8XvLF038xo5EKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp5f5H5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A4C4FF0A;
	Tue, 27 Aug 2024 10:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724755519;
	bh=Q970sNHoTRg2QJusl8JkgL6SI098FZHOU84TccyQ3A0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hp5f5H5N6RqxinGujQ27yTs1ZW0rnHvhsowsiXs/FRzecTRtaUIj7uoSvZ1Ms7Zc1
	 Cujk7QTUkXnFMkWd+lwlyrHPSnp0l8EG3+tRZCx33Y9rWpIrynzcVlTcfhxRGMwk1G
	 H9yl981kfVw8mvPFZy2ulLxruGKPzvVfeP3rzEU3t5mGesm+otEbqVssCS7YGB9At8
	 fMLQ93GtQ2zLAaTdTS15FxmHsWY7mKwQciwbA3ekqS5+ATmWwdwDeFHzrucC3owsxx
	 h6yLctLOwGeqYYIabEGmnT/WEB2fyOd0TYBGibey3CsBzK4joTi5BavosgUZQJbMFv
	 8mfF50Oq0nu6g==
Message-ID: <36e775f9-b17f-4979-91a8-227931f6c4ea@kernel.org>
Date: Tue, 27 Aug 2024 12:45:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: Add SM7325 device tree
To: Danila Tikhonov <danila@jiaxyga.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rafael@kernel.org,
 viresh.kumar@linaro.org, kees@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, ulf.hansson@linaro.org, andre.przywara@arm.com,
 quic_rjendra@quicinc.com, davidwronek@gmail.com, neil.armstrong@linaro.org,
 heiko.stuebner@cherry.de, rafal@milecki.pl, macromorgan@hotmail.com,
 linus.walleij@linaro.org, lpieralisi@kernel.org,
 dmitry.baryshkov@linaro.org, fekz115@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-9-danila@jiaxyga.com>
 <90a95443-65c5-44e8-8737-26145cda1e35@gmail.com>
 <16b934a2-790a-4ac4-8ff5-40371bba17fc@jiaxyga.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <16b934a2-790a-4ac4-8ff5-40371bba17fc@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.08.2024 12:53 AM, Danila Tikhonov wrote:
> On 8/20/24 03:48, Konrad Dybcio wrote:
>> On 8.08.2024 8:40 PM, Danila Tikhonov wrote:
>>> From: Eugene Lepshy <fekz115@gmail.com>
>>>
>>> The Snapdragon 778G (SM7325) / 778G+ (SM7325-AE) / 782G (SM7325-AF)
>>> is software-wise very similar to the Snapdragon 7c+ Gen 3 (SC7280).
>>>
>>> It uses the Kryo670.
>>>
>>> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
>>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm7325.dtsi | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm7325.dtsi b/arch/arm64/boot/dts/qcom/sm7325.dtsi
>>> new file mode 100644
>>> index 000000000000..5b4574484412
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm7325.dtsi
>>> @@ -0,0 +1,17 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2024, Eugene Lepshy <fekz115@gmail.com>
>>> + * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
>>> + */
>>> +
>>> +#include "sc7280.dtsi"
>>> +
>>> +/* SM7325 uses Kryo 670 */
>>> +&CPU0 { compatible = "qcom,kryo670"; };
>>> +&CPU1 { compatible = "qcom,kryo670"; };
>>> +&CPU2 { compatible = "qcom,kryo670"; };
>>> +&CPU3 { compatible = "qcom,kryo670"; };
>>> +&CPU4 { compatible = "qcom,kryo670"; };
>>> +&CPU5 { compatible = "qcom,kryo670"; };
>>> +&CPU6 { compatible = "qcom,kryo670"; };
>>> +&CPU7 { compatible = "qcom,kryo670"; };
>> This is a meaningless marketing name. As you mentioned in your
>> reply, cpu0-3 and cpu4-7 are wholly different (maybe cpu7 even
>> has a different MIDR part num?), we should do something about it :/
>>
>> Please post the output of `dmesg | grep "Booted secondary processor"`
>>
>> Konrad
> Sure:
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
> [    0.020670] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
> [    0.036781] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
> [    0.052717] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
> [    0.070194] CPU4: Booted secondary processor 0x0000000400 [0x411fd411]
> [    0.089236] CPU5: Booted secondary processor 0x0000000500 [0x411fd411]
> [    0.109298] CPU6: Booted secondary processor 0x0000000600 [0x411fd411]
> [    0.126140] CPU7: Booted secondary processor 0x0000000700 [0x411fd411]

0x41 is Arm Ltd

0xd41 is CA78, 0xd05 is CA55

Konrad

