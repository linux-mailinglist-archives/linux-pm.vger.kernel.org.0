Return-Path: <linux-pm+bounces-1521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5814281B71F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 14:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C991F218AA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E66740B2;
	Thu, 21 Dec 2023 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3cV7m/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB273460
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc843af59fso8737841fa.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703164627; x=1703769427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7EsZHydyX/G1UAFKvlY5coPjnLhbrVHw3RZygCuhY4w=;
        b=w3cV7m/W9XpDm3Uv3Hy0VSN5m+wtlTmwjRibtbZkWQmJ72ohhddNcgycim2B1hvzSN
         2lehhLXkPxpT98wVZFVxP+aAhsrWtqINlWCBMAIUjH+1CuyfMI4eilsYucgHGckGAPCZ
         xEFAHDEzlNfhNpjyQKGGiyS9F8Xa3m1BqN25k7efxLA8X8LI7Df73KlkkNY6jcqzYgET
         2xxV++6F8y6OucwqXiSwdSVyh4bEp66VYcmwnog2qFUY9OrPlFbOD8y83An0b2Uz2qE9
         N9TLUZ1B3rug8ZORIox0x8ricQziplW3RXce1j977onqayb6QtI478uv4wQOswloqOWG
         DXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703164627; x=1703769427;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EsZHydyX/G1UAFKvlY5coPjnLhbrVHw3RZygCuhY4w=;
        b=hrD2ELokubuR/pLSaqTHnbWKHWozvWlhakl3oiqz1wfJQnNhhpIYb7zNBhRd/xwAyz
         GNEK5v9taYL0Ddfovp0Fb0LWnLBIEhJ9pkbVMDrZ5GKFRBbsOFFOdDM7aXwh1roQdMyF
         YQcGU0taxuO6VJylnw+q90YWrul+5V/Ud1aJ2YnObArpxSsGqfHvFFRY4F3AXniW55LK
         qyjoba7sYSvVadr05V4uDfOekabm4j+fjRYb6b7njj110DWo5O3Ky/W1YQjtQOfeQdLT
         vqoGoMBjcSPpihKv5KY6rWm+5huq+xJoqJ2y6GgJui+QDkXhVvbCwuR7ABa/SQNzo/PJ
         UanA==
X-Gm-Message-State: AOJu0Yzs11HfcAeaw6kPjb5Yo2+fdrHr+NGJyJxCO7tuVQaRnbnRVExp
	7s359WOlEzYWQUXIAKu2NWZyrQ==
X-Google-Smtp-Source: AGHT+IHMmdnGL4BRxvswtWn+Cfvji4nWdpFnCjEmLsdvir2mOKdTfB3UYJzCK6JvSkVgS2y6euENCw==
X-Received: by 2002:a05:6512:6c1:b0:50e:168f:38eb with SMTP id u1-20020a05651206c100b0050e168f38ebmr7408830lff.109.1703164626653;
        Thu, 21 Dec 2023 05:17:06 -0800 (PST)
Received: from [192.168.199.125] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id fi1-20020a1709073ac100b00a26a96163d9sm475943ejc.43.2023.12.21.05.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 05:17:06 -0800 (PST)
Message-ID: <9f227687-5760-4169-a86d-008f393de949@linaro.org>
Date: Thu, 21 Dec 2023 14:17:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX
 handler
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold
 <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
 <20231220-sa8295p-gpu-v1-2-d8cdf2257f97@quicinc.com>
 <8d206362-7d80-46dc-8474-871fc53abc20@linaro.org>
 <CAA8EJpoEqKv_rWB8468WJzxqPA5w7u_zmGJJ0oKWAyaB9-f0eQ@mail.gmail.com>
 <35845077-7839-41bf-9eca-82f8b0be29ec@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <35845077-7839-41bf-9eca-82f8b0be29ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.12.2023 14:16, Konrad Dybcio wrote:
> On 21.12.2023 14:04, Dmitry Baryshkov wrote:
>> On Thu, 21 Dec 2023 at 15:01, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>> On 21.12.2023 04:50, Bjorn Andersson wrote:
>>>> The GX GDSC is modelled to aid the GMU in powering down the GPU in the
>>>> event that the GPU crashes, so that it can be restarted again. But in
>>>> the event that the power-domain is supplied through a dedicated
>>>> regulator (in contrast to being a subdomin of another power-domain),
>>>> something needs to turn that regulator on, both to make sure things are
>>>> powered and to match the operation in gdsc_disable().
>>>>
>>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>>> ---
>>>>  drivers/clk/qcom/gdsc.c | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>>> index 5358e28122ab..d1139c895503 100644
>>>> --- a/drivers/clk/qcom/gdsc.c
>>>> +++ b/drivers/clk/qcom/gdsc.c
>>>> @@ -557,7 +557,13 @@ void gdsc_unregister(struct gdsc_desc *desc)
>>>>   */
>>>>  int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
>>> I suppose the name is confusing now..
>>>
>>> But at the same time I can't come up with anything that's less than
>>> like 6 words..
>>
>> gdsc_gx_enable() ;-)
> except not really only gx and not really enable :(
> 
> gdsc_shared_enable would probably be closer to our current
> nomenclature..
but then VOTABLE also taps into the concept of "shared" :/

Konrad

