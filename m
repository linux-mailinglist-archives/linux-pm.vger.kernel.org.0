Return-Path: <linux-pm+bounces-16681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D999B5511
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C41F21BDE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9C209F53;
	Tue, 29 Oct 2024 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flO+2pkl"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F85205E0B
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237478; cv=none; b=LoKSA9bFz5EbzlH1WseBfjIQhjdCvY+yrJI1pnJl5YNnfY2uNxQcREywYL+oAGSb35QrCLcFVDwM3F5AQsUBLjIIHWne4/fo2QUSZ/+zWvb4BOjhHardoYii/8n4UorwziZUr7hs1KNMF7rnII6O3YWADQxekSLTsSTNnQvl6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237478; c=relaxed/simple;
	bh=dWKCH0266812E97d8By6HsbFBUUDCHP1lAzLfB67rL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBwUKRuOuqRLWIlfY4oHO2fjGnU3RT4oqumIAh9V/X9AdaC5iFQN4w4DtxSn9T75k84M6yBfqRF1tissch7G//Zsx6pVS76L/DhO6ZO6bAkOzVhNw1JI8fcvtsM6PSpExCDZXvL4Fx+r+1W1HwvqkNL+9zRMKwX/f6BkfzipnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flO+2pkl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730237475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKy0gKvcdEIREMIU1JdiEca9T4X0cP8U/0k2cemcl9U=;
	b=flO+2pkl64wbVXzWqBRI2RAuOCiIE5XigAht82Lm9ViZc8m2JkyMT31dGFdHUeB0vyHGKN
	5wApjr8BuyM1AYu5IVyC7J+OhoJBkq6nq0w1PE9MOXatVkAsqZUA5bsEtzPDJuVvV8FiBM
	eiQ0PsFVgbGn9zqWujyUf+YLgdX+1wM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-zd-cBbLIPAaGKjpJ9_SNcg-1; Tue, 29 Oct 2024 17:31:12 -0400
X-MC-Unique: zd-cBbLIPAaGKjpJ9_SNcg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbed928402so74668996d6.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 14:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237471; x=1730842271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKy0gKvcdEIREMIU1JdiEca9T4X0cP8U/0k2cemcl9U=;
        b=blsq0U4hYpI9aFGm/HKo490cn/niGQspdwLgWSVk1rBBGkn1/le9IBqPUX6bbSHOfx
         MlZxkRL4doGPxOPlxIKNhVXj3ngkGbJYrF1PqCuacpQjYanaZiy9Zv+dCq0/76zk/tyI
         9ouPImJKNxQevldDneQ0sob/e8vUbEHbwG+tOEg3W/J2CxOc/TkLZ3LfV1340JeL2zzV
         VdRnafy/hvgFN+2X45otG0Og6+77hzrhh4CL3tgLuYmQugQ6C32p7P806D/J84ktn49y
         h6CHXQItvfJ5AtUXoPnbcJt+eCg5BaqLtN9L1wS77fjWcy45okBXsNP5GnuN46nNl1bL
         jcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6N477O5LkeSyWW0QCGqnzmp7H6Nm334obXMP9HC6vmrf0Lm2xLi24lj82hXUsn0LjNEkzDs6kVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+Ug/30OaA+npQwfCEO91SrtJxMGbHhlzMd0y/HQ7a/xZd+Cu
	WO6t9yNN6i12mu70+TNU2rs2VUGV1ltjmm95hB8TTDij5Km77gXSD/aRxygGts5qMbAL7Qx5Xol
	a9pNFzIKEIlgGeaSrm8+olHf31cSuasTVJNV4ZCtuwIaqyAo3iOqjA88k
X-Received: by 2002:a05:6214:4408:b0:6cc:1dd9:290 with SMTP id 6a1803df08f44-6d18584d51fmr189819256d6.40.1730237470830;
        Tue, 29 Oct 2024 14:31:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD25QFOFNhZxtwFvSXB0+Ij3LfJUM2osTiEjgGy+Dv3Dl65P3YytSqu6WA3w6Prbl+SgD/dw==
X-Received: by 2002:a05:6214:4408:b0:6cc:1dd9:290 with SMTP id 6a1803df08f44-6d18584d51fmr189819056d6.40.1730237470472;
        Tue, 29 Oct 2024 14:31:10 -0700 (PDT)
Received: from ?IPV6:2603:9001:3d00:5353::14c1? (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798b75f0sm46001146d6.35.2024.10.29.14.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 14:31:09 -0700 (PDT)
Message-ID: <b22ce4a7-8480-4d4a-b2c3-0d70c3e05c00@redhat.com>
Date: Tue, 29 Oct 2024 17:31:08 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvmem: core: improve range check for
 nvmem_cell_write()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241024154050.3245228-1-jberring@redhat.com>
 <20241024154050.3245228-2-jberring@redhat.com>
 <5b6901d9-f404-43b9-87eb-577124efa3f3@linaro.org>
Content-Language: en-US
From: Jennifer Berringer <jberring@redhat.com>
In-Reply-To: <5b6901d9-f404-43b9-87eb-577124efa3f3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/24 13:55, Srinivas Kandagatla wrote:
> if (!nvmem || nvmem->read_only || len != cell->bytes)
>     return -EINVAL;
> 
> Does this work?
> 
> --srini

I decided against this because it seems potentially useful to allow len to be less than cell->bytes when bit_offset is nonzero. I assumed that was the purpose of the original "cell->bit_offset == 0".

For example, if a cell entry has the following field values
    { .bit_offset = 4, .nbits = 8, .bytes = 2, ...}
then it would make sense to call nvmem_cell_write() with len=1 in order to write 8 bits. To allow that, I used "len > cell->bytes" instead of "!=" later in this function:

>> @@ -1780,9 +1779,13 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
>>           return -EINVAL;
>>         if (cell->bit_offset || cell->nbits) {
>> +        if (len > cell->bytes)
>> +            return -EINVAL;
>>           buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
>>           if (IS_ERR(buf))
>>               return PTR_ERR(buf);
>> +    } else if (len != cell->bytes) {
>> +        return -EINVAL;
>>       }

If you disagree with my reasoning then yes, your suggestion works and I can use that instead of what I wrote. None of the current in-tree callers of this function rely on that possibility I described.

Thank you for the feedback.

-Jennifer


