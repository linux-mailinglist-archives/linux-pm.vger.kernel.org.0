Return-Path: <linux-pm+bounces-11059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A663292FFDF
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 19:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108B4B2255B
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C15176AC4;
	Fri, 12 Jul 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWyz6iGL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41677176AA1
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805835; cv=none; b=Wrfl8jy28qZ69xYcO3u9r7WPUBAQBkYmX/lFLTYjjWN4pUSdYrKhiXdFK2bvabjfBmG2R/9P0K5i4dBJww/NZ8xBbIrq9QzqWWqoa42aODJXsEq5aw37pRF7v+Ly38TWExB0vLnnro5CGYwI+XuykAD1Lzn6o9G7Iew2iAblGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805835; c=relaxed/simple;
	bh=cMVBcb3+PuJ6p9sLI9kDQNdmjy4RrnCDMwKNx1ooWJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRUfKhDT2lwa/sn/70tMNO3evnjrjtKfeT6dAt59WoX0l8F5Wj+i2i3JKPVa4ZxlgmnL6MrXs9vIV1b9bVbMRjdE+BC6EcxovTDoDq+3i026/4UMRc3cGIqeK2zs31noU1J9sjzinEev2SbvKc3ue2JbHUVBo2fIKLENUO38DhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWyz6iGL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77e5929033so318511566b.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720805831; x=1721410631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cMVBcb3+PuJ6p9sLI9kDQNdmjy4RrnCDMwKNx1ooWJQ=;
        b=oWyz6iGLDTuB6ZTPcLXE+jrWKZxtoODtFNJyCcF6JC0097YWEr8LRrW2i7z9KWI1ej
         W4dXPP0PsDeSuCC8n1h+3VPBYjU05JnYwQUy+JmqGLPnSahsCNfRyMeza7yt+Dvs+3z/
         5ZRSkT3We2CaBWutSr7TPGasq/s8XL7Rah0MUBlQtXdeVDE9mmTvVPSK5m/N2YSWxrFP
         Y1t7WuuvrZwXJQXOLtA1RmSqRqzHEB/ZyaFt4HUvDNPT96+ZNr3ZjoLj2xfgOMxvwhTO
         5YDbD2E4cMLHL5BF2ExdGpDg3nDLzb3pKiAI9WiH+jirr9Ezgm/6WWaAZ9PCz9uQLtEB
         oNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720805831; x=1721410631;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMVBcb3+PuJ6p9sLI9kDQNdmjy4RrnCDMwKNx1ooWJQ=;
        b=EdiFYFr1YS8XejutIW/h5s9wX5ehT/snQLbTVXrKUrC8PThkPGhc1j3uDmKXvwOlv4
         FqVl/rPPIizRZ2Ol+JBRnWqy7s5gw3ZrSNW+y+zuNP3iDMOniTsSQHywqSu+AbaFIkn/
         JzWjbqmEoxJcsFM04HGHD5kgXf7UN8U0bGGCQs0xo5tyJ+5NLXB2gmTMqZj0eody5zjU
         DpradDSHRelhDmc6JsIWaXCSvDnsz1Jv7yFfXvecIQnATqvtq/xCEhgsZfZNnvBMAvY1
         RCfLz9+aBZrhPC2divHSIUOZSgvE8PlzshcqndkrOdsNb1albpHp2dUt1D3exFxteSvT
         sSPg==
X-Forwarded-Encrypted: i=1; AJvYcCVD71EiqurhUv8CLYcsvqz3y716pj4aktWoqtHU8Gulwf4oq58hKFnKlXAd2kG5pSyYL/SFZPTgWGON+r7Prbiavw3Mbyaov0w=
X-Gm-Message-State: AOJu0YyYZKTxaBZDjViewuqtchEhKI4T92CViC2BdScMNvhebNPX3nrW
	Z+MmeBblv9KzXyeaG5JR5L9NOPnv+92y/jFJMej/HZN9T0HQ9IZijt5gUKf+/ZA=
X-Google-Smtp-Source: AGHT+IEfeXDIhCuqN36CSi8OOwJ0E5Pxn3p4/TIJGAsYWwdtbecnDEpO9dxJ8D+oP/FHGwlUP0W8xg==
X-Received: by 2002:a17:906:97c3:b0:a77:c2ac:947e with SMTP id a640c23a62f3a-a780b881d20mr848111866b.55.1720805830411;
        Fri, 12 Jul 2024 10:37:10 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e37ffsm361340566b.76.2024.07.12.10.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:37:09 -0700 (PDT)
Message-ID: <13bd853c-ab27-4454-8ca3-1d27ad520e3b@linaro.org>
Date: Fri, 12 Jul 2024 19:37:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: thermal: qcom: Add MBG thermal monitor
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Kamal Wadhwa <quic_kamalw@quicinc.com>, Taniya Das
 <quic_tdas@quicinc.com>, Jishnu Prakash <quic_jprakash@quicinc.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
 <20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com>
 <7a834db9-4b46-4737-a6c4-52bd38610fca@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <7a834db9-4b46-4737-a6c4-52bd38610fca@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.07.2024 7:25 PM, Krzysztof Kozlowski wrote:
> On 12/07/2024 14:43, Satya Priya Kakitapalli wrote:
>> Add bindings support for the MBG Temp alarm peripheral found on
>> pm8775 pmics.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---

Please also describe what MBG stands for and how it differs from the
currently supported temp alarm that's been in use for the past 10 years
on various PMICs

Konrad

