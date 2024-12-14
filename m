Return-Path: <linux-pm+bounces-19237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794F9F1F8B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9275818859AA
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B85819342F;
	Sat, 14 Dec 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyMdSbEi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F6191F6F
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734188831; cv=none; b=RbyZ5WRrZb3/CpbPwtUB1Nb7Xf8tQGefMSWKhH/wTPDlJdnRcuuBQbfLVAIzaPWDjpIgJ+k7SNGEnixi+Aw6Z46cZgdlJnHynxtTU+bvUYMm0RkXxFielkdamBuWqvnngFHtiWzyYdTaunHfmSIfQN7hBdFme8B2tnv3/ZF1kbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734188831; c=relaxed/simple;
	bh=eR+qjQP6KWkz/NJnDcik6zTdH2/VYAHWAYxs3rMv2tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUkwvQOlZdGK4oKMW8p2qY3rgvPvs2mY0xfDyTXGjvUDBYjsBvyH76DJk4Lpc0FseuSN6HoYiSzNyD2DKXCFSym+VIGJ5fnd1LDQO0dt8bArzBmFXwJi9NpWV7B5HzMmrP6rLhzR4bTw9ha+rrtallFaEst9GlttDajrDPn81S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fyMdSbEi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434f80457a4so23036715e9.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 07:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734188827; x=1734793627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIBE+0UlquIsYZozCVFzFEGCR2rC4mOAVUzl7lyv2tM=;
        b=fyMdSbEiSjOnYQDbIiRCbTfyNHzTeuRtvz5WyB/bRAnB6S54C77moU1JPr3VFs8aLP
         QkKp+xK7NkpZFvTn5bdZqzdf1KXLsL+Xh1x7HNRwp6+x1OE2umWlZ9jjrqACC3l7AaJV
         gf06+85pSTn+gsG/kb0ElCx2OhowVSIzwivB0qUpIZXQMNMh0ttu3RUyirC4EyjaqeHY
         ey48RIhe46CkuIRhFuK8luAG/unj00mIqnAmn/k5d6pqXmh67kG+sKR36cfF91tBskfK
         YDLSboTXeoBpSb7DxVjj8ck9y+K8UNWKxCCfPKyK74eHzB8W1UkzlKKSqt5GJDxGlPkb
         r6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734188827; x=1734793627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIBE+0UlquIsYZozCVFzFEGCR2rC4mOAVUzl7lyv2tM=;
        b=XcoB8WDxaF279mvinWy6AoKYXf0FKXsUzH6wPO2oRtmhXgcrAaXROS6kDi+TjKrocN
         t2D7Ff0bZtWf7cmF5F+NQlCGZIs4o0A9U9MYpLdCGqIaewz0Li39YJGLraA2MjfQc104
         VTDTUikVXOd7yZYamWJiZ/qFjN12IA20B5TwdT6Bjg6O9pzCHOFB6QmDm/kLpfFo6uXw
         SM4tngZT3BQ6SsjEB6kwQ2cbew0ZIoY9sK+odxm0otX4fJl1s518S/lnlaMAIeEzgcnC
         LG6DsFyME5h+QV0Oam+J637lKjZxeD2d1DuWv5T5rRQ/bx+CiiqWKOe2zylvG7/NOx++
         aLag==
X-Forwarded-Encrypted: i=1; AJvYcCXF14JzUk69SJB8i2qNAqmSovfllxlUrRwoIIVsfAn0J+slFaMjYjFxLgP4BsA+obtI38tY/S8vug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFlsZAdlw6+KDdHrVpanUngbgJddGzayReysebk1jRjhTVCLA
	0U1Mtk3PTJmlMch4W9HiYx8bnEJuCl9o0fhIWtWo4iaEowd+bN87NZ0MA2Yark4=
X-Gm-Gg: ASbGncunyqQwQlRYZtQHl7krP5kRJhmJH62Us8kYuoQ4ZIC5PuJdJWI+QQP6yarIZFP
	s6cxk7MXeG5sZrxSd1cbTCxrHx8LeQoQLlguicSd37uhVCp7inUW7axTzhvO7l8FJ5Kz/xJ3t4p
	lA4KCvH+syyryC2FfHXPvIeTT1hU3lCExZ3qHD2ZAKa2+PWPOgxjnR/sWTSeU9tOrLdsWRSWDlM
	mV2tlmp1+6hq6nV+TRGTYNHwRN9ulinfMq/dNh25EqcdAUlZgC7r7JrflFfwBAQW4V6gkjJU5U=
X-Google-Smtp-Source: AGHT+IH3w9h+hSebDY0xAQlkYrvUNMYisspX4JRmHSfXW+xfKoY4Y0Tv3CP1sogfkYnfltfymAmF/A==
X-Received: by 2002:a05:6000:186c:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-388c3a92606mr4783755f8f.28.1734188827425;
        Sat, 14 Dec 2024 07:07:07 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-388c801a7c8sm2854023f8f.49.2024.12.14.07.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 07:07:06 -0800 (PST)
Message-ID: <488ea6c2-0832-4409-902b-2b6b193daf8c@linaro.org>
Date: Sat, 14 Dec 2024 15:07:06 +0000
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
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241104152312.3813601-3-jberring@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the patch,

On 04/11/2024 15:23, Jennifer Berringer wrote:
> This function allows nvmem consumers to write values of different sizes
> (1-4 bytes) to an nvmem cell without knowing the exact size, akin to a
> write counterpart to nvmem_cell_read_variable_le_32(). It discards the
> higher order bytes of the passed u32 value based on CPU endianness as
> necessary before writing to a cell smaller than 4 bytes.
> 
> Signed-off-by: Jennifer Berringer <jberring@redhat.com>
> ---
>   drivers/nvmem/core.c           | 24 ++++++++++++++++++++++++
>   include/linux/nvmem-consumer.h |  6 ++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 4a5a6efe4bab..4c26a5e8c361 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1815,6 +1815,30 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
>   
>   EXPORT_SYMBOL_GPL(nvmem_cell_write);
>   
> +/**
> + * nvmem_cell_write_variable_u32() - Write up to 32-bits of data as a host-endian number

> + *
> + * @cell: nvmem cell to be written.
> + * @val: Value to be written which may be truncated.
> + *
> + * Return: length of bytes written or negative on failure.
> + */
> +int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val)

This new API is confusing, as writing to cell should in the same order 
of the data. Doing any data manipulation within the api is confusing to 
users.

If the intention is to know the size of cell before writing, then best 
way to address this is to provide the cell size visibility to the consumer.

--srini

> +{
> +	struct nvmem_cell_entry *entry = cell->entry;
> +	u8 *buf = (u8 *) &val;
> +
> +	if (!entry || entry->bytes > sizeof(u32))
> +		return -EINVAL;
> +

> +#ifdef __BIG_ENDIAN
> +	buf += sizeof(u32) - entry->bytes;
> +#endif
> +
> +	return __nvmem_cell_entry_write(entry, buf, entry->bytes);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_cell_write_variable_u32);
> +
>   static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
>   				  void *val, size_t count)
>   {
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 34c0e58dfa26..955366a07867 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -56,6 +56,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
>   void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
>   void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
>   int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
> +int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val);
>   int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
>   int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
>   int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
> @@ -128,6 +129,11 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int nvmem_cell_read_u8(struct device *dev,
>   				     const char *cell_id, u8 *val)
>   {

