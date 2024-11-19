Return-Path: <linux-pm+bounces-17746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00859D2213
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 10:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEAF283D45
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710419B5B4;
	Tue, 19 Nov 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHPZQUsU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35819753F
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007048; cv=none; b=WUlEPadHSYCb0Zf7KOS4C2gJbA1KMKLfHSJOzF/z1ILFba4RJvLmVyT6wq68zkTE8RdWUHEAGodQNIF5gwfqzlgpgQwG7QN3DhQtA3cIKLuj7q0ZtGyNtO0YXh2yfiSnLWoW1b4/8b8+xDEoOf4zuhCWokcjNNPGJJ97xGJHsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007048; c=relaxed/simple;
	bh=ih3CM0VJxysa8on172fSn13/PSUuqKrq8v8n7OGnsXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rgjk0c2WFP9QLVxqYvHzWlzKkQd4nn0neBo7ZPTaNE8HGIcp1NP+gJqIWjnYwHQ8bQdpKpbYXsCfw16qWE6oPwGoVTcGLPaORGmnaNkrBsPjBLn4Y15cfoeDrXCcatVQofNmUbNxBKiWVIinWfhOgmmMjgophh+CGTsfGT6fThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHPZQUsU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382498034b8so185969f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 01:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732007045; x=1732611845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh010SnoznBCeczeI8AJ+/0t/WolrW5PYCoRX9KHTMg=;
        b=oHPZQUsUjtA+Ng7wRKvD7JkwHR8fcOFK7kbrwAhbaIFcStsvfV9GMnuXGmeduZz8aA
         3vt/k0A/moxM+zMXi68UW2hQ0v6OlxzDdeIEBJtBEMvS+o7SrK8a0Eten3OFCWg9sROI
         65wMWYxBDxOjS3g8D4EO4i5F3nT/MpUZlpvrCtJknGPhddtac7mRWgVZp6QFLUneF1BW
         TzXX0zuSV6+8MTjbNGi9Kj2OtddVivuHcUuXt4ofAo7Sq8Fa9zp0YCnMjtGxWtztjZi1
         lEP2WXlYlDYeImGl4qRukJJ6IaEwXRXJEecXoVL8EWXRb6aimdo24wCv2SLGf+umuScr
         8bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732007045; x=1732611845;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zh010SnoznBCeczeI8AJ+/0t/WolrW5PYCoRX9KHTMg=;
        b=q6uy73SLR97gTxFIG59bWZ3vq9wToBpFJbzNRTydLBZI+fmCiLtvmNO2Z+HU0YJqWq
         gDXKOFjvHbsOO+f8I8Z12GEZv7lC7SIhi1GqyefVranJSvD3dGP099nznAGsbH0xKrhH
         4GV1Pu6vPoH83Zz9IoRK3hc1KNgskrM8nxG4SH4Zz8kzZGRFeS/ZpPpVUcd+L5xjGknk
         Sg75AjlRxRkX3ibNKq6+QvH6GRvbug/8BaPNjXHuIg4ccTHPtWjb95Fm5i7I7LVVNwT9
         y8oQws9JYWFtm2Re75qOOIk1fKEiGRPI6/aqyI4I4B/ddi0P/2LHxDe0WkwDDJd5L/AN
         xVQA==
X-Forwarded-Encrypted: i=1; AJvYcCUJNOjB9if7eoosPTnVXEcrcWTUvKsVQi92vGee2SNoYrhiPWNUPuvvmYOwCj7ypJfgXSTqzlM+7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ9aEBFp4s6xf6RcpVe9ywyjs5v33jMF/ksUsqlFWXE9BZYc9t
	XXj4c01unQBiFVzS9ogeEC5sphcbDgBkRrXiETtiSNY6Z9OZBQ6WCbzkDNjMEiw=
X-Google-Smtp-Source: AGHT+IFnr6aWVT60Vxgz7ZWR0e+FHOKeR78DpEUA5iD8xkySPFogpqX9p9pdsotyV+HzwctSOL3h4w==
X-Received: by 2002:a05:6000:1446:b0:382:4e85:1ee0 with SMTP id ffacd0b85a97d-3824e8520a6mr430905f8f.5.1732007045317;
        Tue, 19 Nov 2024 01:04:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38242eef982sm7147979f8f.8.2024.11.19.01.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 01:04:04 -0800 (PST)
Message-ID: <a45a6b73-3d46-4293-ae55-8b901087680b@linaro.org>
Date: Tue, 19 Nov 2024 10:04:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
 konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
 quic_amelende@quicinc.com, quic_kamalw@quicinc.com, amitk@kernel.org
Cc: lee@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, lars@metafoo.de, quic_skakitap@quicinc.com,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-4-quic_jprakash@quicinc.com>
 <d0511a78-8eca-4342-949b-9dea293e064f@linaro.org>
 <aab228cf-d209-48a8-8daf-99df75f8b460@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <aab228cf-d209-48a8-8daf-99df75f8b460@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 15:06, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 10/31/2024 4:33 PM, Krzysztof Kozlowski wrote:
>> On 30/10/2024 19:58, Jishnu Prakash wrote:
>>> +
>>> +static int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
>>> +			  u16 offset, u8 *data, int len)
>>> +{
>>> +	return regmap_bulk_read(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
>>> +}
>>> +
>>> +static int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
>>> +			   u16 offset, u8 *data, int len)
>>> +{
>>> +	return regmap_bulk_write(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
>>> +}
>>> +
>>> +/*
>>> + * Worst case delay from PBS in readying handshake bit
>>> + * can be up to 15ms, when PBS is busy running other
>>> + * simultaneous transactions, while in the best case, it is
>>> + * already ready at this point. Assigning polling delay and
>>> + * retry count accordingly.
>>> + */
>>> +
>>> +#define ADC5_GEN3_HS_DELAY_MIN_US		100
>>> +#define ADC5_GEN3_HS_DELAY_MAX_US		110
>>> +#define ADC5_GEN3_HS_RETRY_COUNT		150
>>> +
>>> +static int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
>>> +				  unsigned int sdam_index)
>>> +{
>>> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
>>> +	int ret, count;
>>> +	u8 status = 0;
>>> +
>>> +	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
>>> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, 1);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (status == ADC5_GEN3_HS_READY) {
>>> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
>>> +					     &conv_req, 1);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			if (!conv_req)
>>> +				return 0;
>>> +		}
>>> +
>>> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US, ADC5_GEN3_HS_DELAY_MAX_US);
>>> +	}
>>> +
>>> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n", sdam_index, status);
>>> +	return -ETIMEDOUT;
>>> +}
>>> +
>>> +static void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
>>> +{
>>> +	/* Update calibration select and decimation ratio select */
>>> +	*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
>>> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
>>> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
>>> +}
>>> +
>>> +static int adc5_gen3_status_clear(struct adc5_device_data *adc,
>>> +				  int sdam_index, u16 offset, u8 *val, int len)
>>> +{
>>
>> Wait, what? Why are you defining functions in header causing multiple
>> copies of them? And even if: why this is not inline? But regardless:
>> this is a strong NAK from me.
> 
> This was meant to hold macros and some helper functions used in both main and auxiliary driver files.
> I see what you mean - I'll move the function definitions into a new .c file and mark them inline.

This is a very odd coding style. Look around other header files: do you
see such patterns? No, because it leads to potential issues I mentioned
above..

Best regards,
Krzysztof


