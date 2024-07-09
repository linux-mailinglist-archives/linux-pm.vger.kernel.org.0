Return-Path: <linux-pm+bounces-10839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E59592B45D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04051F218C9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C31553B3;
	Tue,  9 Jul 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxmz/atC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA6152E03
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518586; cv=none; b=POVkg/ZxjarQqjQwPtwNde4fOaa4wDFvxNxGRSOgOY8JdjfyBMCvDYLHszZaTe9F3486loj4NH5zhivuBOtoOwPVyMsZd3wjTC3Sv9o65aYg5id/LsxOsMDyOJjEg/mCmqjnJHSqUo1nm5sDNXvajF9nAy8uhLfQAtWTvEXQnaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518586; c=relaxed/simple;
	bh=+chQesbQ8IjMDaLXVcqZFyhiyu7jYuAsU6LcpQ3w/nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa+vuJlzWIVP4/YlPoLvXBL1/7fOe2Yt+FPIBVDf2XuW0NlWoZ2vvMH0WamOzrN7D6uhpMPIpMnoO4i4LSiHOD5QststiN8CCGeW61NmoL0MTL0WIyVas7ag9VCEawJYxdEjDfcunadtHLYLxRczTjtZbGcieHoaO6XH1Hr9JpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxmz/atC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6cb130027aso287537866b.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720518583; x=1721123383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YnCSBbKU3ioIHg5WvkeZ7VAE/TUgPg1AYZbUSm93KBg=;
        b=vxmz/atC7O9+TTrc8cTTJm5er8juHC4km8btrEaERViRGFuTx76Yds70uW4c/h3d06
         lMEgGmrLDoslf3GZU2eKRnVVvlKPwvDJmYHBYTNAs/EjltF8JiPYZS3YnwqKZeA4LxUp
         EmqPGY7tn1kkzkGU9mB73JYkp6BsFNnpI6xaHhFfzt+rljZRXTly2yYVy4y+NfHwMvJa
         991Uq8stbDSKN5dyIYK15AOrPlNOskvxkdcO6o3YMLwLF3RSdfHwVhsW7HPHFtgMdAGw
         XwW+vHlAVP9vCxrR2jy+0aE3Hrb1rRNpnNF/TEw93quiK5TqRoNxDEioyxgO5gGfqeNt
         0z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518583; x=1721123383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnCSBbKU3ioIHg5WvkeZ7VAE/TUgPg1AYZbUSm93KBg=;
        b=ZvLqbp/CHFywQlmo6SfBtWi+QEHrwirgvqvwaGio45sO6aGHK1TEqWIK+LHPsdjnh7
         jvd16Fzfb9iqbnd2n5g+lW4fJddk+DYxUm6t1+mvOpbposCmyG9H0SvRWRbFnYzY8rlK
         9MD1DIA6hMs6LwpKg5WTFCFDZCnUwT8+AoGQQyaLEKBdx27cAklLZW8UPdNn8CVY8vW/
         JwuBOa4GnMEFOjqhC6PD/MHUSITcGqf0xib/Sg7oEmlU7K7cEcwDaKD9hVVh8O9wQYqI
         k9Td9JYuvkrKn5/kA9Y0+KdFdzO9echfgtXJiBx2c4nzvH5blCkDUNJpOJWgkfLVeDAO
         ZbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+QmYVZUbzNUaBJ3qmIt7ib+WAwXm6vrJMoUa+I7+ruigb7d/bQbuNCx0Z0pnY8ey7h364HPTDejxIXLEiYBDy8eL9o5UAu6U=
X-Gm-Message-State: AOJu0Yz1rMZ34n/uurZcbv9Pb1js1VIC54o91nZu/4ycEfo8y8aU7CNy
	mmvpdBD2vK17uxG7mPd4xskXrfV2pz9iAGs1sMR98BRVJs7gxauxgKH4vzu6jII=
X-Google-Smtp-Source: AGHT+IF3WOZNV5SxJx71Y5Vzqutl5kaWi2iKT/CrgRtHdwVifN3axQWMUdfNrRCiuQeWx0uDeOH0fA==
X-Received: by 2002:a05:6402:40d5:b0:57d:3df:f881 with SMTP id 4fb4d7f45d1cf-594bab80834mr1900788a12.3.1720518582870;
        Tue, 09 Jul 2024 02:49:42 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc701sm63664966b.34.2024.07.09.02.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 02:49:42 -0700 (PDT)
Message-ID: <94b2842b-6093-4c4d-a099-3e0a3198b753@linaro.org>
Date: Tue, 9 Jul 2024 11:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/10] MAINTAINERS: Include new Qualcomm CPR drivers
 in the file list
To: Krzysztof Kozlowski <krzk@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
 <20240708-topic-cpr3h-v15-1-5bc8b8936489@linaro.org>
 <cd1c3450-1905-4d71-bcdd-5f880d743820@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <cd1c3450-1905-4d71-bcdd-5f880d743820@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.07.2024 11:04 AM, Krzysztof Kozlowski wrote:
> On 08/07/2024 14:22, Konrad Dybcio wrote:
>> Expand the Qualcomm Core Power Reduction section to include the files
>> concerning CPR3+ support.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  MAINTAINERS | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dcb37b635f2c..f3e013a52c16 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18687,14 +18687,15 @@ F:	Documentation/accel/qaic/
>>  F:	drivers/accel/qaic/
>>  F:	include/uapi/drm/qaic_accel.h
>>  
>> -QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
>> +QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVERS
>>  M:	Bjorn Andersson <andersson@kernel.org>
>>  M:	Konrad Dybcio <konrad.dybcio@linaro.org>
>>  L:	linux-pm@vger.kernel.org
>>  L:	linux-arm-msm@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
>> -F:	drivers/pmdomain/qcom/cpr.c
>> +F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> 
> Maybe combine these two into:
> Documentation/devicetree/bindings/power/avs/qcom,cpr*

I think avs was proposed to be a subsystem/driver directory at some point
and (adaptive voltage source? something like that) and this is the only file
in that directory in bindings..

Should we continue with this "class" of devices, or should I move qcom,cpr.yaml
to soc?

Konrad

