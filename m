Return-Path: <linux-pm+bounces-16722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7CC9B6222
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CB91C21E19
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC751E5734;
	Wed, 30 Oct 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A45EYlJc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DEC1E5722
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288618; cv=none; b=PrVYoS6HnuhqYRb9sKAMjC5A1+FvKLLaBBXF0SQWsEidEqjFIdxL5hpskcH9T5QmFdI6R7+Ms/GuQLTVIpAYqfUjv4wuHdsRdkUerKNcJ8PENYWfvQlE3SUTUFNWjdq917huVCOlGt425cVj6NyoSCRcIjlatBB1Ez4d4u0GEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288618; c=relaxed/simple;
	bh=awtTvZ6vGGiqZV76rgTqJGMGn1AnY6x/PGmQuLA8i2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jldbuX5BEIoAiqUvQpIew0RsCHcEtWEI8fHhkAJ2m1H8GpEy8k/fBlk+HkXvoxyZXwoM0oBoeQAE+t0mBpg6pjx8zk+JLb6MfKGUhXi9kzTQLmae3FNu/fIgfYlSACpmbu7gO0QtUbxsC0+9/K3ayAlyDPnXpp8ij650HQH7RTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A45EYlJc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so4351237f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730288614; x=1730893414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=US0yqIHM+wRkkYQYKiUsTGgnwwJfvhEFr231dY8Uk74=;
        b=A45EYlJcZDrX8Telrln+ka5q9jPr/EAtr5/Vxql18ae4sdWhqeyphBetxyOOoE+NEI
         7yogELnSlzJLhejRhozWQGg7//2UMW1yWy41GAprw/aAE5VKkNRxobEv+CmGv4g6ttBQ
         v5Sa4h+rafnmsYyp/ZqUxYnsrUOPOH8ph6eginF3KXrQJ+1a3KCkNZ5iOjHjvuTT+ZNb
         Z3jeM1G9enrL1EYS7BAsY4Msv3WearrO3VszGLeo10d+FzNuLXBArbfeTp2O3FKW8i2C
         SAmbnD2w7eBzx0J9/0CV2Y+5XFyRTPAl6GyWHGGeQvAUvBq3OrNEwfkat5Xk7cIacLgG
         l/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288614; x=1730893414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=US0yqIHM+wRkkYQYKiUsTGgnwwJfvhEFr231dY8Uk74=;
        b=lSOEjmQsVMI6WN9FHMOJyMjfhtjcFcwj/llEtWPfqiHGpd/qrujJWIYc9RjTmYKiRX
         cTwfFitNrwmlOVm53hcYsPa1c8LNQUlqJLpaiuKOTBfYRfuyIFd8xIBMybexX+q8OGir
         pvcNnI9Iyiqx/0cGlpFiffaJSyaQVOM+Eo5DIVlrxscnTobzi05tj5mZV9apvHXhECiN
         UOTwBZXZ6sRgEQVicsZwfAwKW4o6zO5bGNNg1ZgjELThunBH0KmdRWtP2JzbdzanFL2H
         Mq+qSgzyoqjOxJqQQ4nHmazXaBSDFYvqF9vl8nKDrshIuOSEL+JiLgKpE85ZlUnkhXlh
         TePA==
X-Forwarded-Encrypted: i=1; AJvYcCUfEEMFOThE8vgnEP0x4svq+OgFKfEURIZWTBxSmL6aeX15Gz5gchp7LJ5VGr5bv81XrF1zjrKMmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMBXx4cHtwX6xRO8ZVRM58OF/5lSRNASf6jBb8tkz0yqHSylV
	5s58rHmhZQkpXwlnZjS2NvpilYMpkD9Wlvlu7WhSW0Vq+/ueC9NGfQH9LrpXwn8=
X-Google-Smtp-Source: AGHT+IGIhLE24+WH0MJH0WafO8vc5VrsGWBcKbyDZeZys1Kqo9nQUthgjWXQYsw3R2227quKB8H4Eg==
X-Received: by 2002:adf:ff86:0:b0:37d:4818:f8b1 with SMTP id ffacd0b85a97d-380611e493bmr10119383f8f.39.1730288614175;
        Wed, 30 Oct 2024 04:43:34 -0700 (PDT)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b70d50sm15216661f8f.76.2024.10.30.04.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:43:33 -0700 (PDT)
Message-ID: <a75f6b72-ea52-46a4-8790-13a4084d53b9@linaro.org>
Date: Wed, 30 Oct 2024 11:43:32 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvmem: core: improve range check for
 nvmem_cell_write()
To: Jennifer Berringer <jberring@redhat.com>,
 Sebastian Reichel <sre@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241024154050.3245228-1-jberring@redhat.com>
 <20241024154050.3245228-2-jberring@redhat.com>
 <5b6901d9-f404-43b9-87eb-577124efa3f3@linaro.org>
 <b22ce4a7-8480-4d4a-b2c3-0d70c3e05c00@redhat.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <b22ce4a7-8480-4d4a-b2c3-0d70c3e05c00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/10/2024 21:31, Jennifer Berringer wrote:
> On 10/29/24 13:55, Srinivas Kandagatla wrote:
>> if (!nvmem || nvmem->read_only || len != cell->bytes)
>>      return -EINVAL;
>>
>> Does this work?
>>
>> --srini
> 
> I decided against this because it seems potentially useful to allow len to be less than cell->bytes when bit_offset is nonzero. I assumed that was the purpose of the original "cell->bit_offset == 0".
> 
I don't think we support this case.

The reason why this check was initially added is,

If we have bit_offset as non zero or nbits set, cell->bytes is can be 
different to the actual space that is available in the cell, Ex: 2 bits 
with offset of 7 might end up taking 2 bytes. So the existing check is 
correct as it is and valid for cases where the bit_offset is 0.

In this particular case the right solution to the issue is to add more 
sanity checks in case bit_offset is non zero.


This change should help, can you pl  try it.

---------------------------->cut<-----------------------------
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 90c46f6e465d..e6d91a9a9dc5 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1780,6 +1780,9 @@ static int __nvmem_cell_entry_write(struct 
nvmem_cell_entry *cell, void *buf, si
                 return -EINVAL;

         if (cell->bit_offset || cell->nbits) {
+               if (BITS_TO_BYTES(cell->nbits) != len)
+                       return -EINVAL;
+
                 buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
                 if (IS_ERR(buf))
                         return PTR_ERR(buf);
---------------------------->cut<-----------------------------

thanks,
srini



> For example, if a cell entry has the following field values
>      { .bit_offset = 4, .nbits = 8, .bytes = 2, ...}
> then it would make sense to call nvmem_cell_write() with len=1 in order to write 8 bits. To allow that, I used "len > cell->bytes" instead of "!=" later in this function:
> 
>>> @@ -1780,9 +1779,13 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
>>>            return -EINVAL;
>>>          if (cell->bit_offset || cell->nbits) {
>>> +        if (len > cell->bytes)
>>> +            return -EINVAL;
>>>            buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
>>>            if (IS_ERR(buf))
>>>                return PTR_ERR(buf);
>>> +    } else if (len != cell->bytes) {
>>> +        return -EINVAL;
>>>        }
> 
> If you disagree with my reasoning then yes, your suggestion works and I can use that instead of what I wrote. None of the current in-tree callers of this function rely on that possibility I described.
> 
> Thank you for the feedback.
> 
> -Jennifer
> 

