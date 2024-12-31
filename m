Return-Path: <linux-pm+bounces-19866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A389FEE69
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C873A2AA0
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51881922ED;
	Tue, 31 Dec 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaxmvHHP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A61714AC;
	Tue, 31 Dec 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735637951; cv=none; b=aJRgIWV/XtuXJyeFOwyeakOooNnNtJA+mouilWdmK8vEdaSda4NCIqSGdEIspq9oX5q4GjCiG6ILjedzU7ENS6IEWtQX/CCS9Cx1SGInfUmMXf59HmQipEILFON7QqRXMHzk2X+wu83yUcoXKz44zlidUONyEoOWeQKZiGSc2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735637951; c=relaxed/simple;
	bh=N8k4M1AA2Bi9OFkGcAwxb/3vDmUw7L+tHPcTRToZx/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGtQRFwPKTt30r5uenf5OnP/3mNaGhzni1z81rtqHaGN8BGm/oRNpn+1bevBT064TBhCQkjL4S9q4Sdu1ZvsUJx9LrAS1hDIvdDqxNVGO9LqQ3mPZTrkMuIZ7WI1iuJFFZSDHyq7J9DctHA8hhfzOg1FLSpcCc8brEL8TS7zSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaxmvHHP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so862629766b.2;
        Tue, 31 Dec 2024 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735637947; x=1736242747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVx0iAxczoYNQmuh8tjxytzVFHWiAqHa6/iluToV3MA=;
        b=UaxmvHHPA0SgdpWRMnuo9IcZGfyTRHfi7S1zBGqdWXXo0ohCt4AB2YsGOFEmFpA7YU
         AmtNvVlR3xkm8eawOuOzdISilDg9uo4A1+g0IwxlLdUXgSUYYWOijiGetPB8B2LcEc7c
         DZmoToKLcVGo5FkWDLbzZf/4UCNfCkRXe1SGh6XKGDpDU2Z1zsb8DJOdEYqqXOZ3Gl83
         nSEFatI4y96Y5JhhfEzJyiNYoMIxiRmEwRMRVMgmLU72J3fEazx3guWfxIQlniTyC6qK
         aHkFGntkrinTkfDAarSjWv60Ms7b6K1COfPKnT2uPS8sCDsNmm2ZmsReYikwXbLG33r4
         J6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735637947; x=1736242747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVx0iAxczoYNQmuh8tjxytzVFHWiAqHa6/iluToV3MA=;
        b=desqo9/e0X/V3kRRTLLIhjOaQqeSbvNbC9v4t2cCz6TeKth6WxoZTqCxmdhT6ShjmD
         0CCNWBewVS0AtcLShPIenLr2YZqZWE7v9Um1E/JUrCJaWDnlx/CGwvjwmA3DHNMIamuQ
         3K++c99oC0Z71PKcqqs6tzfTfJfJ0uE76CRHAfEJkj5NegRQBWF7LK3FpJMMjL2RD1YE
         iGuOY9N4EbVGrgI27tTCtbpYhiMqMBisUx/Ds8Ofg+5S3NjGQwxEYvib/xF9HJUDKMpQ
         aqX+Vd7dE14xRlGQ3BP5DhHTPyVDRWc6uvWqQqO1RAU27CCB1N/czbOb4VjqqDnTgG4Y
         Cd5g==
X-Forwarded-Encrypted: i=1; AJvYcCU8GYS4SFZ5NKdtIXol7MNzijia0b1ZAeksyiaA2OkG/mni4u4y/xUt6u4PBKdT49aRmTC+CA4wHHY=@vger.kernel.org, AJvYcCUNUpCN6NuGPEl/CYLhzr3tkfCi4izS/REYdgn7gaLW0jma7pK86JG8zkuRzdlHo+c0zibjurPicPnznuQL@vger.kernel.org, AJvYcCUfUU3sOKz21Djubu4DY7dCmR0irJNjFNZJceS6Yy0i2O6bFQXy84jc7WNoaeTfriZLzHXyF6cf8fMRuXQPOw==@vger.kernel.org, AJvYcCUiOUxtbEhbAw/VBDCSfQaQrYHdpWBTqi7qyTOqFckTKJUpVRu59fYUxHhLoPHrbzeAbmc1LUhcPhHU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9iYOUb1yAEx2pr6agcawGCCaiawHe8yGZXo96yiILVJ2fQg7
	BAK6kT4fxZc71LT5w1230qMP1wlJKQQ2iKoNDPUJiQGZ6Sq8YgiQ
X-Gm-Gg: ASbGncsExlUaXVBYWaTlxoCn53IcyS9n+dKoD5dXm3AcLQgSwPoB3fABSr88mgIGxhZ
	KfOm/QZIwlZysBvnMw3EnBQpfsA4O4bc9bkkk4+aOvKuijFSHgsfPQarpPEH14N0gvUSQ+iQMSb
	VwBOzbigXYdURU4PumXSCmJXi9S58aOtDvHEm/e9bogULoHdN7+2e5dvtkZFoGVf0TJQLtnKjwO
	lmQGaXWJZGN0o+DetRGLh2FSUa8zu4J/9FHsK2tMyKYz5JNilJ6gikOntL/bUmRE/b6xenw/irx
	EiSaRvtOY7E5U4FKxFUYdKo=
X-Google-Smtp-Source: AGHT+IHGbNFRD+VBQZRBeNgOAkjlfuRj4Aqm80agk2I8s6fM/A6uCsM+IQL8Y9Wk5QEVzZaPQtaLGg==
X-Received: by 2002:a17:907:9715:b0:aac:619:e914 with SMTP id a640c23a62f3a-aac2ad88fcfmr3819378766b.16.1735637946926;
        Tue, 31 Dec 2024 01:39:06 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae4338sm1542679266b.86.2024.12.31.01.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 01:39:06 -0800 (PST)
Message-ID: <a0fc7b6c-e68d-42a7-aff4-a11c88495f67@gmail.com>
Date: Tue, 31 Dec 2024 10:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Conor Dooley <conor+dt@kernel.org>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, devicetree@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Simona Vetter <simona@ffwll.ch>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>,
 linux-pm@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, David Airlie <airlied@gmail.com>
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <20241231-gpu-acd-v3-4-3ba73660e9ca@quicinc.com>
 <173559754709.2660868.7488137827927170444.robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <173559754709.2660868.7488137827927170444.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.12.2024 11:25 PM, Rob Herring (Arm) wrote:
> 
> On Tue, 31 Dec 2024 02:41:05 +0530, Akhil P Oommen wrote:
>> Add a new schema which extends opp-v2 to support a new vendor specific
>> property required for Adreno GPUs found in Qualcomm's SoCs. The new
>> property called "qcom,opp-acd-level" carries a u32 value recommended
>> for each opp needs to be shared to GMU during runtime.
>>
>> Also, update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml.
>>
>> Cc: Rob Clark <robdclark@gmail.com>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 98 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml: ignoring, error parsing file
> Traceback (most recent call last):
>   File "/usr/bin/yamllint", line 33, in <module>
>     sys.exit(load_entry_point('yamllint==1.29.0', 'console_scripts', 'yamllint')())
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 228, in run
>     prob_level = show_problems(problems, file, args_format=args.format,

You need to shift the closing '}':

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
index b7874f43aaf6..46fbffaf0a61 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
@@ -93,5 +93,4 @@ examples:
             opp-peak-kBps = <2136719>;
             /* Intentionally left out qcom,opp-acd-level property here */
         };
-
-};
+    };


Konrad

