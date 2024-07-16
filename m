Return-Path: <linux-pm+bounces-11147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2793260B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 13:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F0C1F22BCB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD519A288;
	Tue, 16 Jul 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+jlVhqe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9C1993B8
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131131; cv=none; b=BgkIvneXU/KYtoySKcoLAA0az3H3xjcnCF6I0y1wv3a2ySWmSzB6kI2dTxNBWQYZ/dUUbiqqvu08YhK+oXCnRNyfts6C9Fdg8aUvHKmNCU+nquSbjsRNA7aR0/uDuuc0NBaAssyzddVsDyETRdHDaOA5w5PkR3tHCI5/q42glCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131131; c=relaxed/simple;
	bh=WMGVdhkswcGCPNl24Vc3UsTW32JuYclOdmU51VC/M+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkylxzoJAUfpios9G5LZ+/TIZ3jWxjO6Q9uuGn4EqucNAg/Yg18mnbMlv5ewPpa+Jt41KgFX0QCzRUUUplHYdk5BCx1YZf4Na5eDYe+srH7SbqUJAVugL1mM7yIrvOWcll/rQMNGWj2qOJHD6OmAmuJVcP3bahpGL1vy+ovClqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+jlVhqe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77bf336171so880726966b.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721131127; x=1721735927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W6o3+zcaQ0J4JlSyMMbb1JPfluO0g2AHR4AxHBCQt0o=;
        b=p+jlVhqerU5LGat3X3i2heoQ1wJnCc/1PROoXcRXl8GtoqdXJFdWOjFRo+UB4Vz3e1
         nRTRXSlsNvqrEEXBQ3Utn1Fei3ptBZaUUOx+sZzyWFmhV7DPoX2cBcVA5Y5pF/k2XF0u
         yEjragvdmcQush7Am/+CwPZXUZCfrUvTzc92Ujg43wZ+uauLmsuvNUQjQYJW6t/BrKuw
         vVNU15CsoWJ6uhrYz7p2lx7a04lflkLZEkVOADvlZ65JxMl0Bf6DhjPQ6/hemmz4r+8o
         Xx4a7G/cNFmiHNyIItTH4xgOxYIQfLXEjN2FTK6ttRx8h7rvwhKdPr2N+n8aQZ3nxST8
         LPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131127; x=1721735927;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6o3+zcaQ0J4JlSyMMbb1JPfluO0g2AHR4AxHBCQt0o=;
        b=eFPGkFMmb2Avph4x/rvzd21Cn9330wS3RZsroDHuttUCm+DPkQcede4PnV/H7rDQA1
         MpiRuo9PPW8znlI0pU/EDVolSSUjXcDT6xEMRHf1dBXDAywkGcLAb0E4PXJiZT1BZQOw
         ILmlW5j6HNr0SFP2BBAyMHKbkWS1ZiYZZC8EpQSNcAnxFsp76NBTD7r1L9MMu6QP9TOA
         h75s+rXUwU4EoHy+Tk5XjkV+R/dK5fF9HLO36/chkZDB/mMPFDFcVG4IsUAhrpNMxu9a
         lAyeHM2te7gsYf4lqLbyTfFIP1SLI7k3qdj7yAIey7bPFL8nJQHkXxbQQoy78M4oOAWh
         d/jg==
X-Forwarded-Encrypted: i=1; AJvYcCWS1J5EnHr2Asm6eMaNVXccRkxGVH5hLyZBA5IE/RSX3fDKzIYEH3BVhFNHYIjeQCprpaX6RsntWKYxbx1UaHvRZCvUXcxfYWs=
X-Gm-Message-State: AOJu0Ywh9oywnOk+AE6M6uxfeTxAHjk2GVBDKEO4IsQ195OefehWV3Ud
	3hVWg8qf1yYbWWoGUklsTQoy4uHLzoZRARNpYAMVXitgtWhPMjP8VQvt/EKV4tk=
X-Google-Smtp-Source: AGHT+IGOv2iJhRqmlirWNOvw+oT9/mS4RBfl4FgOfGJ0IZ2r6JHK8magsphr8VEyqBK4UxOymyNbXg==
X-Received: by 2002:a17:906:268e:b0:a72:62e0:6636 with SMTP id a640c23a62f3a-a79edc14910mr141319666b.24.1721131127350;
        Tue, 16 Jul 2024 04:58:47 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7f00sm304061666b.63.2024.07.16.04.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 04:58:46 -0700 (PDT)
Message-ID: <d1d7b58c-b605-4adc-b329-f74ea4567982@linaro.org>
Date: Tue, 16 Jul 2024 13:58:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/10] MAINTAINERS: Include new Qualcomm CPR drivers
 in the file list
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Robert Marko
 <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
 <20240708-topic-cpr3h-v15-1-5bc8b8936489@linaro.org>
 <cd1c3450-1905-4d71-bcdd-5f880d743820@kernel.org>
 <94b2842b-6093-4c4d-a099-3e0a3198b753@linaro.org>
 <d35f5c94-7a86-4eea-bb0a-3f2785a25465@kernel.org>
 <CAPDyKFqhmNqbZ9Xkg0tWHE5LavoNaGMyE3dKmAFtHdS5=x33NA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAPDyKFqhmNqbZ9Xkg0tWHE5LavoNaGMyE3dKmAFtHdS5=x33NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 1:34 PM, Ulf Hansson wrote:
> On Tue, 9 Jul 2024 at 16:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 09/07/2024 11:49, Konrad Dybcio wrote:
>>> On 9.07.2024 11:04 AM, Krzysztof Kozlowski wrote:
>>>> On 08/07/2024 14:22, Konrad Dybcio wrote:
>>>>> Expand the Qualcomm Core Power Reduction section to include the files
>>>>> concerning CPR3+ support.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>>  MAINTAINERS | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index dcb37b635f2c..f3e013a52c16 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -18687,14 +18687,15 @@ F:        Documentation/accel/qaic/
>>>>>  F: drivers/accel/qaic/
>>>>>  F: include/uapi/drm/qaic_accel.h
>>>>>
>>>>> -QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
>>>>> +QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVERS
>>>>>  M: Bjorn Andersson <andersson@kernel.org>
>>>>>  M: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>  L: linux-pm@vger.kernel.org
>>>>>  L: linux-arm-msm@vger.kernel.org
>>>>>  S: Maintained
>>>>>  F: Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
>>>>> -F: drivers/pmdomain/qcom/cpr.c
>>>>> +F: Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>>>>
>>>> Maybe combine these two into:
>>>> Documentation/devicetree/bindings/power/avs/qcom,cpr*
>>>
>>> I think avs was proposed to be a subsystem/driver directory at some point
>>> and (adaptive voltage source? something like that) and this is the only file
>>> in that directory in bindings..
>>>
>>> Should we continue with this "class" of devices, or should I move qcom,cpr.yaml
>>> to soc?
>>
>> Rather cpr3 should be moved to avs or some other power directory. "soc"
>> is fallback, junkyard for things without clear domain.
> 
> In my opinion, I would suggest dropping the
> "Documentation/devicetree/bindings/power/avs/" directory. We already
> have similar bindings sprinkled across various directories, see below.
> One less seems better to me.
> 
> Documentation/devicetree/bindings/arm/*
> Documentation/devicetree/bindings/firmware/*
> Documentation/devicetree/bindings/power/*
> Documentation/devicetree/bindings/soc/*

So, should it go to bindings/power? Or should we get a new
bindings/pmdomain dir?

Konrad

