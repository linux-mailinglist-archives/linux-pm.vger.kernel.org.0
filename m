Return-Path: <linux-pm+bounces-19850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9B9FE6AB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 14:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4673A1D31
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9AB1A4F2B;
	Mon, 30 Dec 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2BF9Ktc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368125949E
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735566651; cv=none; b=Lf778p8rRruBonf2v/7PH70/XHlPv5sERzo+ghEMXmUHiUdPC+/oGDPaXR+t5lInQPq4ah6fyPszqLeChdJuesCWTGU7RKtMmoLR0P39lQIdAEvmPZWr38zy8C7o+GNSUcLGNXsXqqERzzQy6hRHEJtvEesLO/Vl/VJmAncu3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735566651; c=relaxed/simple;
	bh=hPcCej5NImgwHLMd9mNIePKDyhxYRmL5vgfsaqv8nS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJC3Gwy8ArXxNbPnsuRX1L94UpvsXZoZKteOBKTUPGWEf/7JQPYV08RulxNl+hOuMeDFD6to7lla9LxqLTD2ssjHYktSf5Z495Oj8R1E5U0QwFL8hRBofvm306bQhxiTwNnAf5BRUkEnitdSz4NQTcGNgrvSIRGGnIESjsDqLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h2BF9Ktc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d6d5765so5458741f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735566648; x=1736171448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0GgbJQeEQwNmf1OCnZvm38GLD/5UUKVoZQYh2x2RyI=;
        b=h2BF9KtcT8hLUo4zNRqEQPld37TZtfgvhSybiWcV6xyGfB22WhSowolBWAh4874agV
         cxpd7SkFBLyfGGv9pl9UkniAJjEp4YI2f8jazOw7BHMKgjGUic4grG2e3/cUgyidczO3
         f3iCTUIA64V/4c5PcbnvfkQyr9g2RJ7Ypue4LKv9eLUYzw1953awPwmqAXBotuNyc1cc
         0uX+LGTcxZ9W8CgqzetDenme2vg52B3C9zz6YolpjZbSWjWULIgYfJqKuE8hs+h2p/2F
         or9TlPT46CLX0qtcuCN/Jcb3svXX9uGAwexBorD65CiDpyNZZ6Mk57D1RA3TvdB3ubhj
         eVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735566648; x=1736171448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0GgbJQeEQwNmf1OCnZvm38GLD/5UUKVoZQYh2x2RyI=;
        b=h3d12WykZ84lVYdzTZOFkGwA1yeAms2T2TxsN9Dt1JhaNK8Vg82xdsuGXu8ZWzQ9my
         tZI2Rb3Zgqpso2ckp7nHiPZtdK2rvSYy+BL9lSotA8UX97u+sMPBS8BQ46eQGx7xOagg
         MHc+lezRGjadglWCvJhES/wAga1ikbiv0ghS1Zn/SyM2AoPy3Tlw9PwNMn5fL3tohg+g
         Ufua9+INihcDKuQeZNW12qsJpEb1ujhH2ozWUuJ3jTC7J4kB/grUEb5a8JiPjbwCwHgj
         iDvIDhL2o5m31h3IZ8P5XtVfFgiGr4E1r3gJIS9MNm220X/7edJJNTPXuRVD1Tss6abJ
         M8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV72vXXoQFYiplG+Wt5QcUJ6jIu3Daog5ZG9WXfbvMPa+yNeH0gpyUCxmxKoOKOr7QVWhtynCkh1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ML6mV/x7d/pIeNzGMyRKZtXZwzqCyMoq2MuEWk4TO+kF535N
	M2420TyhYqts9RrJUJH2g49SapZx5b1nnYnt7VPBMJKJiUUZYlYxbG9WRR9XXuY=
X-Gm-Gg: ASbGncuIf8DQFrqh6L51BCbfx7rFSTQfewtloao0ReOVF22CC6ICl2ffW1LeDPvdAcB
	+X4YJUtXU9CGN6GNvdIQGzMIJB/ZCxXDIKuEui0FNA0w5AFx4l9OhbHf32HYkgCUg2eQ6V9iTsp
	HE1xQvpdhLR173CzbZIdKY6DCl9/pn9IDT265FkIKOc3LWrKklUzVddkuCssrYmVskjtX1m5Qzp
	hbKH3vOQsJWZMgd45CJHJRw7YGVS92Cx3UcLjNeuueIFFBqwXx+FwUb7tTeiUy6qrfEq/GFWDs=
X-Google-Smtp-Source: AGHT+IFFqVjbcuzTKQPv1Y06rLlo6YoiZfu8K1VXOVTlvBxID7Qngai1LA9FaeVmmA/ODJMc3gEm/w==
X-Received: by 2002:a05:6000:481d:b0:388:da2a:e48 with SMTP id ffacd0b85a97d-38a221fb99bmr24382665f8f.23.1735566648402;
        Mon, 30 Dec 2024 05:50:48 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4366128a44fsm354768585e9.43.2024.12.30.05.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 05:50:48 -0800 (PST)
Message-ID: <5bfc6886-b9ac-4bd4-b651-f0c7f90a59f4@linaro.org>
Date: Mon, 30 Dec 2024 13:50:47 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvmem: core: add nvmem_cell_write_variable_u32()
To: Jennifer Berringer <jberring@redhat.com>,
 Sebastian Reichel <sre@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241104152312.3813601-1-jberring@redhat.com>
 <20241104152312.3813601-3-jberring@redhat.com>
 <488ea6c2-0832-4409-902b-2b6b193daf8c@linaro.org>
 <1ace6102-2e88-499a-a5fd-71951863b987@redhat.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1ace6102-2e88-499a-a5fd-71951863b987@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/12/2024 19:39, Jennifer Berringer wrote:
> Thanks for the feedback and for accepting my first patch.
> 
> On 12/14/24 10:07, Srinivas Kandagatla wrote:
>>> + * nvmem_cell_write_variable_u32() - Write up to 32-bits of data as a host-endian number
>>
>>> + *
>>> + * @cell: nvmem cell to be written.
>>> + * @val: Value to be written which may be truncated.
>>> + *
>>> + * Return: length of bytes written or negative on failure.
>>> + */
>>> +int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val)
>>
>> This new API is confusing, as writing to cell should in the same order of the data. Doing any data manipulation within the api is confusing to users.
>>
>> If the intention is to know the size of cell before writing, then best way to address this is to provide the cell size visibility to the consumer.
>>
>> --srini
> 
> My intention was to mirror the existing functions in this file, hoping that would make it less confusing rather than more. nvmem_cell_read_variable_le_u32() already similarly has consumers accessing the contents of a cell without knowing its size, silently filling any bytes not read with zero. The function I add doesn't change the order of the bytes. The existing read_variable_le functions (in contrast) byte swap from little-endian to the CPU's endianness and indicate this in the function name. Otherwise, I believe the function I add here is what would be expected from a write equivalent. Its return value also gives the caller the actual cell size upon success.
> 

Writes happen in the order of data that is provided, and read in the 
same order that is stored in NVMEM.  Reading from nvmem storage can be 
translated into whatever order that consumer wants which is what the 
read helpers are doing. On the other hand writes should be written in 
the same order as its received.

Note that the order in which EEPROM stores data might not be the same 
order as CPU.

Adding Endianess in writing to a common code is a problem. If you are 
certain that the NVMEM needs particular order(le/be) then either convert 
(cpu_to_le/cpu_to_be) the data before it hits write call.



> The only manipulation done to the data here is truncating to ignore the highest-order bytes. This behavior should match the below example unless the size is 3 bytes, which my patch should handle but the below example can't.
> 
> if (entry->bytes == sizeof(u32)) {
>      return __nvmem_cell_entry_write(entry, &val, sizeof(u32));
> } else if (entry->bytes == sizeof(u16)) {
>      u16 val_16 = (u16) val;
>      return __nvmem_cell_entry_write(entry, &val_16, sizeof(u16));
> } else if (entry->bytes == sizeof(u8)) {
>      u8 val_8 = (u8) val;
>      return __nvmem_cell_entry_write(entry, &val_8, sizeof(u8));
> } else {
>      return -EINVAL;
> }
> 
> Still, if you prefer, I can send new patches that add a function to get the cell size and put any truncation behavior needed by nvmem-reboot-mode into that source file instead.

there are two things, one is the variable size u32, other is changing 
the endainess. Am happy with the former one as long as the consumer is 
taking care of order.

But the later one is No, as explained.

--srini
> 

