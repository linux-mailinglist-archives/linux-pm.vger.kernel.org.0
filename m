Return-Path: <linux-pm+bounces-19588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684429F9A9D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 20:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CF8167D21
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85632206BB;
	Fri, 20 Dec 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItoCk1AG"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009AA220694
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723564; cv=none; b=GraIlMsaXq8VliTmTb01Dnp8xXN9vOiRk6SFeTa6MGbqOo/NTcbxd+YTvSYOowbEv9ZDHEJnp5JmUAM1wUF4UF+2EvVgXH/1b4WktfUIrmym3gJ1Ra0NiIVMOCji8o1nGirNkxS7m/bvOudRbCUjA7DXvfy/05YPX+Ppp9np5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723564; c=relaxed/simple;
	bh=WaTkqQd0gCJx5+ld/Hgl+wnVFSH38qph2AHIt3Pou80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+ZyLx2j8S3n7Mfa8I5J+yfQ0zGz+JfDIzVv6vA+wswH5aIT4YlAHuRIkJ3ZdCQ/2Xwfk9C/ScSg2pQyTJGSCBM9kqok7uzBkIoqL0QUXLpSgDsea8TLHZRarHWIJTzsJ5pesIafJYj9Ld1/IC/vdgcrQf7lS0Bb/JuXmDYldAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItoCk1AG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734723562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvMoGPZXA/JCbWJzTQp5VTX9HgW6KoGFQy+Y1R5Z8oU=;
	b=ItoCk1AGLe/lcF8XgTUCKhJRa9gdw6BkfA3a7A2D5SBc94KiOv0zlFCYJIUxxv/RWXPBHl
	cRWODgEJuLsMiGYXKyHz7dju1VwwrYvfc3jEYoyT5UREAM5D7ZYlTeVrf9DsBOyndZ4xhv
	yLDo/xnF4oa3r19QbyTdDI+8Uo4+HkQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-bFXcnrVsO7-1aah3u7sAZA-1; Fri, 20 Dec 2024 14:39:20 -0500
X-MC-Unique: bFXcnrVsO7-1aah3u7sAZA-1
X-Mimecast-MFC-AGG-ID: bFXcnrVsO7-1aah3u7sAZA
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso2914484276.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 11:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734723560; x=1735328360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvMoGPZXA/JCbWJzTQp5VTX9HgW6KoGFQy+Y1R5Z8oU=;
        b=lcO0a0PbEcT3CqW7/xJOKBldGr9uMXaap3BT9PDFw9JBq1mSKQA+YyBMvm9pS+h4cJ
         p3s+UNPRSvPBOc+s/PsNfY8ZSz0d5Ul1Ub8EewNoPCntAlvQ2RgPBZfMFAchTvmkxR9g
         rJ8Jr0wf+APYG1gh7t2MOYKmUH2erPq2X8RzQ3FMXOI4c9kB6niRqd61QTXs3EfG7g6m
         6W4uWzbNGmFILzE/eULdsvguRO3/HQOgz8B5QGtyX1pnoXQoAtyv1laLySZoHy7uompk
         1amqpaRFNchH1ouHWEMpb7knBUmoQDrxHpezTzGCFiu+CZGuTvNqWV+YQUttvEeqXQsv
         A/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUfrQXZqvxoTP5fPijz1FiGOC9w5oILnISwSrULUfIuyX9GCYXGoUhK0FsZQfijW1lyqNM3NFGCRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88XaLIsfjs4OGMi2uyStXGSqWlBtR6gZuNDuBN2YQ+2z3xw9a
	dCDtL4nguVeSfJEElg5xTKVKxbnN4hEMpY8pZ5jZQhJnI5djrSWbyBWVIKIOkBj/rbomMDJu6zu
	82oSVrKDfLTu22rQq+IswFXfTmsoYI1mCyYLWKw8wzES6naV5H1Yz9uiT
X-Gm-Gg: ASbGnctyr0xzYySPFA4VKZZgB9BQvSoUBiLCPAGnZdq17A9MwCZlZ8x7ksapJNa6yxU
	YcYsF79za4iC9Df+UAq9Ngcr40VZ29Vb6ZnFO536+kZ8BMdpXxnNZ0u/Rngw7pKBqEr5Me5kKwu
	f7nCVZQCVMcKIaQzNJ4Z1IhPlSyusu/OMVMLtmsxBOlsyrrD1LJSObmEr6RGodp8+M1bc8CA7Px
	+95dyVfCoOs7vGrm9Cx3emPKvJgelzFaXw4OhhF0P8p3hHH4QvwKXZrjFKhCBJPYPkUxjIajrz7
	T8JXNa+JqUAmg2T0PDtk+jp/jy5i5hlRqaBZX5LK1JGuxxP1SeN6DpwVvlOVLw==
X-Received: by 2002:a25:1e85:0:b0:e39:7347:6d76 with SMTP id 3f1490d57ef6-e538c256b59mr2918256276.19.1734723560233;
        Fri, 20 Dec 2024 11:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL5XtiuXrohZaf8df4Lv1IXHirXfqxMzPVe9I/pESLg1R0ZgUBtt3WSyl6Q3KDh7GtORHhcw==
X-Received: by 2002:a25:1e85:0:b0:e39:7347:6d76 with SMTP id 3f1490d57ef6-e538c256b59mr2918243276.19.1734723559943;
        Fri, 20 Dec 2024 11:39:19 -0800 (PST)
Received: from ?IPV6:2603:9001:3d00:5353::14c1? (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf46c9fsm959308276.40.2024.12.20.11.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 11:39:19 -0800 (PST)
Message-ID: <1ace6102-2e88-499a-a5fd-71951863b987@redhat.com>
Date: Fri, 20 Dec 2024 14:39:18 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvmem: core: add nvmem_cell_write_variable_u32()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241104152312.3813601-1-jberring@redhat.com>
 <20241104152312.3813601-3-jberring@redhat.com>
 <488ea6c2-0832-4409-902b-2b6b193daf8c@linaro.org>
Content-Language: en-US
From: Jennifer Berringer <jberring@redhat.com>
In-Reply-To: <488ea6c2-0832-4409-902b-2b6b193daf8c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the feedback and for accepting my first patch.

On 12/14/24 10:07, Srinivas Kandagatla wrote:
>> + * nvmem_cell_write_variable_u32() - Write up to 32-bits of data as a host-endian number
> 
>> + *
>> + * @cell: nvmem cell to be written.
>> + * @val: Value to be written which may be truncated.
>> + *
>> + * Return: length of bytes written or negative on failure.
>> + */
>> +int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val)
> 
> This new API is confusing, as writing to cell should in the same order of the data. Doing any data manipulation within the api is confusing to users.
> 
> If the intention is to know the size of cell before writing, then best way to address this is to provide the cell size visibility to the consumer.
> 
> --srini

My intention was to mirror the existing functions in this file, hoping that would make it less confusing rather than more. nvmem_cell_read_variable_le_u32() already similarly has consumers accessing the contents of a cell without knowing its size, silently filling any bytes not read with zero. The function I add doesn't change the order of the bytes. The existing read_variable_le functions (in contrast) byte swap from little-endian to the CPU's endianness and indicate this in the function name. Otherwise, I believe the function I add here is what would be expected from a write equivalent. Its return value also gives the caller the actual cell size upon success.

The only manipulation done to the data here is truncating to ignore the highest-order bytes. This behavior should match the below example unless the size is 3 bytes, which my patch should handle but the below example can't.

if (entry->bytes == sizeof(u32)) {
    return __nvmem_cell_entry_write(entry, &val, sizeof(u32));
} else if (entry->bytes == sizeof(u16)) {
    u16 val_16 = (u16) val;
    return __nvmem_cell_entry_write(entry, &val_16, sizeof(u16));
} else if (entry->bytes == sizeof(u8)) {
    u8 val_8 = (u8) val;
    return __nvmem_cell_entry_write(entry, &val_8, sizeof(u8));
} else {
    return -EINVAL;
}

Still, if you prefer, I can send new patches that add a function to get the cell size and put any truncation behavior needed by nvmem-reboot-mode into that source file instead.


