Return-Path: <linux-pm+bounces-16673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDB9B5169
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 18:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507281F225A2
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA61DBB0D;
	Tue, 29 Oct 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjjdG8tR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07722F56
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224512; cv=none; b=CdjsP2MH240uk5ctU/b6pR/a8VZzgV/lFscPvxjtF0f1+rXhQbJFnBjL21aJsmkpOYvUqB1Nbd2a0gb6vFtF3xQzE09E2JP4qMKVgJMsCvzZP6XXqjtJYyl9wls6pke+RheGVU4JgpDb1tDXFTNAbfKmHMki2l7LqePOevzsHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224512; c=relaxed/simple;
	bh=VSWGZSUcSFnuKTzYgLTwfHmuEOuLHE4xyPzQO8WicQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY9j+8nSluirZLdE9Mt4qy+Tu8lGg65J5JPWqYYVRRimnhmk5g5mEbjOMOZnRO347K0blBCw8CKfdDbqBWX/ttVKvhHvOn4qhWlWoNzTrslwBoU3ayI+4kipQtNJ9FRAHurX9Q000iwzNUUi6snmQkilkW7S0XnOvKkeH1qrs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GjjdG8tR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so54716165e9.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730224509; x=1730829309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syY3KL5SeZY1hRttAA5c/+5fNVYy4MiLxIa3MGJj9mY=;
        b=GjjdG8tRtbgyNhhDJ+2KA6dZMEGc1uPsUWEOBn5t7NdAoHyv03uzfIxjFpY6c69adL
         DgJJqObby8o6CCOU3UVGC8xXsoOajCn7nLnVSewqjW7+3wKEJL91GQKE0S4EWo4K3vvj
         7EfvpUJHGJt47tS0bO+nKIDsdPig21LHGXXkOY/94Zavqps2UWi+582KlfAGiZgxgUKT
         RZYQdygkXYaiykGVktvQT7/Y0LltcednEUDwRnkfWUIzBFWQz7RoxVRj3nVdUioAIzzZ
         kS4tCeAQKXKgVxPm0QayvABD5NlLk+1fMuHTsLStZjB0ggqySE8wlOtb5+ql0UU0SKkd
         lQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224509; x=1730829309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syY3KL5SeZY1hRttAA5c/+5fNVYy4MiLxIa3MGJj9mY=;
        b=ivleXoGXpZ44f89EV7zKP2ASxUXnn9n9QRUEwjNOVTWFkX79aWRA/Fs/2WPIsl7dy3
         0sOzrCviQefLOw2pDATRi00XLNBJEFlSmJbpOdzkFRtwMKc5TKZTFWmm5Nhm+It4I6kQ
         igNJuGqh5Bo9ji5UOkSDt9U2yvi3wYNjSPwqJx8CyJ/p4GdPmtUfKothnuR2MRbCL74H
         AYJdPc2jiBfwv2w7pjrycyhRpOMgRQABD1DUgxq6OdiJ+JQjrTQST8FzZagP9BKXXufZ
         12YTybWu/0VCVGkFPbB1OFwBpZxkRy4nifFhZhMUAEcIqZduBQVihcz7hJ5CiRK2d0sB
         YEDw==
X-Forwarded-Encrypted: i=1; AJvYcCWDvit+lB/pcBBax/TEYuGUoireUykm4a+I0JFi6dur/R1D4c6mMlRBBGbVQI+s3wJPFge8R/XGDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGfY7SjpXQXi60TNCn1M947o+UZGoOueuKbmnNH4qFn6HCfAo
	suNpPO8muqysFvF/uZLZeoxt0Qa8hlKTMk0zxvxMSLgiyyJPYksSLRW5Yi4jKgw=
X-Google-Smtp-Source: AGHT+IEZk+QyCRvc6WRIKXo+VKkW+anwm8XFOQUUjmjXJ3+897RWGZb/b2pPOUh9lgDd5zJlACuWDw==
X-Received: by 2002:a05:600c:1c29:b0:431:588a:4498 with SMTP id 5b1f17b1804b1-431bb985df9mr5741215e9.14.1730224509029;
        Tue, 29 Oct 2024 10:55:09 -0700 (PDT)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43193594ff3sm150414625e9.12.2024.10.29.10.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 10:55:08 -0700 (PDT)
Message-ID: <5b6901d9-f404-43b9-87eb-577124efa3f3@linaro.org>
Date: Tue, 29 Oct 2024 17:55:07 +0000
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
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241024154050.3245228-2-jberring@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/10/2024 16:40, Jennifer Berringer wrote:
> When __nvmem_cell_entry_write() is called for an nvmem cell that does
> not need bit shifting, it requires that the len parameter exactly
> matches the nvmem cell size. However, when the nvmem cell has a nonzero
> bit_offset, it was skipping this check.
> 
thanks for spotting this, we should filter this out correctly.

> Accepting values of len larger than the cell size results in
> nvmem_cell_prepare_write_buffer() trying to write past the end of a heap
> buffer that it allocates. This patch adds a check to avoid that problem
> and instead return -EINVAL when len is too large.
> 
> Rather than unconditionally checking that len exactly matches the nvmem
> cell size, allowing len to be smaller when bit shifts are involved may
> be helpful because some devices have nvmem cells that are less than 8
> bits but span two bytes, although no current devices or drivers that do
> this seem to rely on nvmem_cell_write(). This possibility can be handled
> by nvmem_cell_prepare_write_buffer() because it allocates an
> appropriately-sized heap buffer and avoids reading past the end of buf.
> 
> Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")
> 
> Signed-off-by: Jennifer Berringer <jberring@redhat.com>
> ---
>   drivers/nvmem/core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 33ffa2aa4c11..74bf4d35a7a7 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1767,8 +1767,7 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
>   	struct nvmem_device *nvmem = cell->nvmem;
>   	int rc;
>   
> -	if (!nvmem || nvmem->read_only ||
> -	    (cell->bit_offset == 0 && len != cell->bytes))
> +	if (!nvmem || nvmem->read_only)


if (!nvmem || nvmem->read_only || len != cell->bytes)
	return -EINVAL;

Does this work?

--srini
>   		return -EINVAL;
>   
>   	/*
> @@ -1780,9 +1779,13 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
>   		return -EINVAL;
>   
>   	if (cell->bit_offset || cell->nbits) {
> +		if (len > cell->bytes)
> +			return -EINVAL;
>   		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
>   		if (IS_ERR(buf))
>   			return PTR_ERR(buf);
> +	} else if (len != cell->bytes) {
> +		return -EINVAL;
>   	}
>   
>   	rc = nvmem_reg_write(nvmem, cell->offset, buf, cell->bytes);

