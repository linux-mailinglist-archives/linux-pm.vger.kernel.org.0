Return-Path: <linux-pm+bounces-10726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BF9293FC
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD651F22853
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EE137903;
	Sat,  6 Jul 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgY7G3jm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200512F5B1;
	Sat,  6 Jul 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274819; cv=none; b=MH2fElY2JKeUKVPz5NbA4ri41kwc2ycy5kvJQnspHlGr7CZ07QFCIgeKX6ySLE1mjJweun3njPuA+PJVmn+RtIv+K9Yhc7Ic4ti4vGzlUxWn0vdTe9Cth7dwl9Su77CPG7CulQqRTrEJvWKFYZ0pFMIe0rMAwKGKb8Lv9q0N74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274819; c=relaxed/simple;
	bh=FJYWZgERK6AfPlLkLPSaJP2zKhwTtNKHakJxE7nKzkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/0POvenHfAIahKyTHbTJkMm4SQMMEq/kxByBlt0pJofF4rWV1Z0f2K+sRPhXsfIncNj2K/SbMHULER1k4SgtewFCe+2iA17ApGVn92piOhIQkTW7G1WFyYXCJsuJa5ql6lxOvAoSNoYabY7E0580B8V6qKCdUIyuomJh709d0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgY7G3jm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c2d89af8so247313766b.2;
        Sat, 06 Jul 2024 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720274816; x=1720879616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4lGVJnjwiIgh/4bKQak60cgJ03UTxinvLEVUXyN/F0=;
        b=hgY7G3jmYjroVeIj/nN9trJ4UeA36GFNVpGMzYnqbFcewfWzjiNHqXDYYt7lt2Sj+F
         08HE1A9kq5wjz6MMilngh/VrWHJZ2kcfeC9Q1lPQPM1WULCebrBYsPiHNGsT/iTjTB2L
         dCiWNV3CpDTM2BOHFbMnG0F8sM2pTXa2apKqF9ZeBTKs4vs7cxdMQW/yya4SBP45v6he
         BN1YB149456hjsZxDBo1ape69rsPlgRevf4HTmauNv8vnkjWzPWLjbe2gsnXBDKcE0vy
         K2BYJnVnTNejS6YC5fgQv9GW8/+yoYoszSJ1VmqEYGSNE2dQApGBEINNM3msjpSW5FtH
         qMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720274816; x=1720879616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4lGVJnjwiIgh/4bKQak60cgJ03UTxinvLEVUXyN/F0=;
        b=Ox40Zcdysr7293kpKXrd7OTyOnp1nTC5fCM9M5jdKHxUybVW21y+a6RRImFmyoCOjt
         6YEIX/OWAT6KGhSJNQwTnqLv5zaL0sG4z9d/K0GjB+pppcUWwA8elrx/2MCilbtN+mid
         n5fXTm2os440Fy6pab1DEq9W3coBI/3+RlqAcUK7HmGzsVs+pfAeUZCZkEmz1LpLUhKl
         QQtTr0GS/RjYiUrTN2SDBOHIobqHs6JsfPxpRL/5jrZMMej9hI3hNDHVKgWCG+aQ4Lv+
         mY8gFTiKIfJtJItWU3YfNkOFmCseLrARyzNuBGO8sgjML42o2JVEPQf88T5/DmRpjTjp
         Uufg==
X-Forwarded-Encrypted: i=1; AJvYcCUO3FiuLpiNxNQpRO22AFBlaLHiBksWRHiCpxesaMBwpPkU1BdZqMvL/ByWGdltNuMJf1LU3iHHfkuaqJyuuNvo32V0HwnBpxTJnqzVMYQB5D4QCCIge0T/Hnv7JB95xZNyvSdbPSE4u/9E0vPqU320x5h7PKoH0fR54359dLv99x6MXSx6CM5KFiMrziLH3RdqB4YIeVsYg/O9nDg2Bwe+qw==
X-Gm-Message-State: AOJu0Yx1u+18tzEDYURs+sRmxXOz04/Spc+Sm2sMgIDQdruPs5/cVzoz
	JOr+10n3BPZ9MhVdUGbWxpuZ1gAyd5RhHUiydlZtHw7P12nYo8I8
X-Google-Smtp-Source: AGHT+IHrupOKilPkKjgsniBzZ76M0pNSKz1zD6YUiQRTviCVntMFiiCFl5J31jzwgec/M3YvxvJYmw==
X-Received: by 2002:a17:906:fc08:b0:a77:d6c7:df5c with SMTP id a640c23a62f3a-a77d6c7e065mr266697566b.17.1720274816092;
        Sat, 06 Jul 2024 07:06:56 -0700 (PDT)
Received: from [192.168.1.13] (bzc167.neoplus.adsl.tpnet.pl. [83.30.48.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e6e700f4sm42056466b.60.2024.07.06.07.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 07:06:53 -0700 (PDT)
Message-ID: <7e918762-1175-4ad1-b595-3d1992b6c4f7@gmail.com>
Date: Sat, 6 Jul 2024 16:06:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: interconnect: qcom: Add Qualcomm
 MSM8976 NoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240704200327.8583-1-a39.skl@gmail.com>
 <20240704200327.8583-2-a39.skl@gmail.com>
 <03e96fa4-b916-4121-a9bd-bfcd40fb10b3@linaro.org>
Content-Language: en-US
From: Adam Skladowski <a39.skl@gmail.com>
In-Reply-To: <03e96fa4-b916-4121-a9bd-bfcd40fb10b3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/5/24 08:55, Krzysztof Kozlowski wrote:
> On 04/07/2024 22:02, Adam Skladowski wrote:
>> Add bindings for Qualcomm MSM8976 Network-On-Chip interconnect devices.
>>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>> ---
>>  .../bindings/interconnect/qcom,msm8976.yaml   | 63 ++++++++++++
>>  .../dt-bindings/interconnect/qcom,msm8976.h   | 97 +++++++++++++++++++
>>  2 files changed, 160 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
>>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h
>>
> This is not a valid path. Please correct it, otherwise tools cannot
> validate it.

Somehow got this weird idea out of qcom,msm8953.yaml

seems its wrong over there too.

Should proper line be like? :
  See also:: include/dt-bindings/interconnect/qcom,msm8976.h

>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,msm8976-bimc
>> +      - qcom,msm8976-pcnoc
>> +      - qcom,msm8976-snoc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#interconnect-cells':
>> +    const: 2
>> +
> I don't know what and why happened here. I asked for different order of
> properties and properties are gone. Provide detailed changelog.

For disappearing props it turns out clocks which i had defined for it
aren't required so these were wiped from yaml+driver.

>> +patternProperties:
>> +  '^interconnect-[a-z0-9\-]+$':
>> +    type: object
>> +    $ref: qcom,rpm-common.yaml#
>> +    unevaluatedProperties: false
>> +    description:
>> +      The interconnect providers do not have a separate QoS register space,
>> +      but share parent's space.
>> +
>> +    properties:
>> +      compatible:
>> +        const: qcom,msm8976-snoc-mm
>> +
>> +    required:
>> +      - compatible
>> +      - '#interconnect-cells'
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#interconnect-cells'
>> +
>
> So no schema? Sorry, this is very confusing.
>
> I am not going to review the rest. You implemented some odd changes, not
> what was asked. At least not entirely. With no changelog explaining
> this, you basically expect me to do review from scratch like there was
> no previous review.
>
> That's not how it works.
>
> Best regards,
> Krzysztof
>
As both yamls will not differ much from qcom,msm8939.yaml 
i moved compatibles in it for v3.

Would be great to discuss it before resending on #linux-msm


