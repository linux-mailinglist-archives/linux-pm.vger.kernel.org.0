Return-Path: <linux-pm+bounces-10723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82A929392
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589C91F2125E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C448D1E4B2;
	Sat,  6 Jul 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEbGzdph"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F54C62
	for <linux-pm@vger.kernel.org>; Sat,  6 Jul 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720269109; cv=none; b=Fl86pj1rvrXjMYYbXrxXwoFTksqF1WHXhTvfL7ss4QAEDyA7j+QBghThChPF64BAGq5Ewv5i7SL9+rAJDdc1yVPK/VRb6szhMTbeqxU08F04d8sM0+Ze95o/w6jxocr5EVwR3fm1l4lpk+gdNxoakzqTPQtSrXMAs0l/e6gB+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720269109; c=relaxed/simple;
	bh=AZeVgGjUhu0VLE0MdVJfGODsbNpLCLUc7QabVgczy4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSpglHxyl5OKFo8PZq5Qtgujwar0FpnzkXbZUtj9L1vQUD/D4ZYBwp/qT7f9arIVvmVLc6ovtzihFXdexXSK+V4ZW8nk0fapDgbuLaR+m36c4lNvlslm76l1qP0x1YbhcMC6De6qkv74lqNTk8wMFi/57PR7oxFYRZS0SKJijCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEbGzdph; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso3255736a12.0
        for <linux-pm@vger.kernel.org>; Sat, 06 Jul 2024 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720269106; x=1720873906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WxO9tUoRJ8g2YphFGWhNO5NnoblLdOv7a0AOZSNvnaY=;
        b=jEbGzdphwYMn99g5rD4CYqpGE1FgTnTeRZTL83RvKQSYiUaetjPXK6CK6gD34Eq+9n
         qmS7FjaGpVhJegb10zHMr3afEHO29YgW3TnA9ClNuT6X+vvn0YmTNNJJEJsgCy1ygsLU
         An86qfpKidBEMuYWnaZUiBuun4TbIg8NZBMHj2lLMMxhdbSrJ2QdHPv9Q5dVNquHeBKj
         BZPgz8c6pmlR6J9sJZyw245ARhVvMiAg7oHlQouf/L9FnLa8gjBSQA8vhUFiHw5gsdhm
         j83AztYMT/4Q6FFdVA+JR9g/XjEDNPl963RyNysM+PV6F0C8mg6PeIAIU0sriETu9/h5
         7g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720269106; x=1720873906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxO9tUoRJ8g2YphFGWhNO5NnoblLdOv7a0AOZSNvnaY=;
        b=LpU1ffFByUkzSH6p8ahbLjLTSrHACjg3ZbDxDy7yqd8y+AuOldkp09Ns5jdnUJuPo+
         pUijGgNl/GEgOuzutqZHrxLw3HqDkue+Fw7XE0WBZx/ST8/EJWWtOBWRQwq+/aLMxE5W
         i0S0Fo+D6jR2fdPGNxPK2/phoScOoSJkj9b0/r2BHiRl95FL0FfUXFn1Jo0isOVwg/J0
         R4k/ggqgAcpNYksDbjqPm6JJp8n+zPGab9K9Ng5Ch+H2CDyPr9YOT5Gy70wOHaN1SKrL
         +cHJ8Q6SW4N4MlWPM+WknPB0RoJsmGFjzpNgZRPeDymqFZ5c3psQDM6lmmjb7lIv083W
         bUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGx8UA/nAtLUrp79jpqPWZEx7K5ajnfNmv5JFsqxCpCJ7XYjsyNuOn+9HcoiVJSlMfqy9SiSdy4JJtzAXaZz+zyBnbJ0QvvA0=
X-Gm-Message-State: AOJu0YxcrJlxFo6s96iCKg/XYlxOqJI4Lc4ncCxYFFCcW0fr7P75aplh
	DpwIb+osjF4oH1QkYWhnz5Uflzl7wBERSNXkkdfbhyLdz+pxMN9erc2D9r5HROA=
X-Google-Smtp-Source: AGHT+IFI1cK6dkv274ZfwByVzNk3B8KSxmGMCLvDGsiBoU/kAEVX4B/R+FpPnlJdrcjBGgmV37lYoA==
X-Received: by 2002:a05:6402:5108:b0:57d:692:92d9 with SMTP id 4fb4d7f45d1cf-58e59265f08mr5744423a12.4.1720269105563;
        Sat, 06 Jul 2024 05:31:45 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58f63380f3csm2126686a12.58.2024.07.06.05.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 05:31:45 -0700 (PDT)
Message-ID: <c15fc1de-c930-44b6-a9f9-d17e4da002fe@linaro.org>
Date: Sat, 6 Jul 2024 14:31:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: Fix DT backwards compatibility for
 QoS
To: Bjorn Andersson <andersson@kernel.org>,
 Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240704125515.22194-1-quic_okukatla@quicinc.com>
 <jhfya4mjnckrmogtmusyvwjv4mlyycgqj3apt2kaj5umxprhtv@rfew7c5w3zf5>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <jhfya4mjnckrmogtmusyvwjv4mlyycgqj3apt2kaj5umxprhtv@rfew7c5w3zf5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4.07.2024 7:44 PM, Bjorn Andersson wrote:
> On Thu, Jul 04, 2024 at 06:25:15PM GMT, Odelu Kukatla wrote:
>> Add qos_clks_required flag to skip QoS configuration if clocks property
>> is not populated in devicetree for providers which require clocks to be
>> enabled for accessing registers. This is to keep the QoS configuration
>> backwards compatible with devices that have older DTB.
>>
> 
> Please read "Describe your changes" [1], and make your commit message
> start with the problem description - establish to the reader why this
> change is needed, then follow that with a technical description of the
> solution (likely in a separate paragraph).
> 
> [1] https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> 
>> Reported-by: Bjorn Andersson <andersson@kernel.org>
>> Closes: https://lore.kernel.org/all/ciji6nlxn752ina4tmh6kwvek52nxpnguomqek6plwvwgvoqef@yrtexkpmn5br/
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/icc-rpmh.c | 2 +-
>>  drivers/interconnect/qcom/icc-rpmh.h | 1 +
>>  drivers/interconnect/qcom/sc7280.c   | 2 ++
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> index 93047defd5e2..f49a8e0cb03c 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -311,7 +311,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>>  		}
>>  
>>  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
>> -		if (qp->num_clks < 0) {
>> +		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
> 
> For this new case, I think the dev_info() below makes total sense. I.e.
> this looks good to me.
> 
> 
> However, the num_clks < 0 case would represent finding a devicetree node
> with clocks specified, but failing to get these clocks. I believe that
> this would include EPROBE_DEFER.
> 
> I don't think it's correct to print a informational message and continue
> without QoS. I think we should fail here.

Since setting QoS settings is optional, I'd say we should simply skip trying
to do so. Unless setting them on some buses (i.e. ones without failing clocks)
and not on the rest would cause issues. But then, these settings should be
bus-local, so perhaps it would still be fine?

Konrad

