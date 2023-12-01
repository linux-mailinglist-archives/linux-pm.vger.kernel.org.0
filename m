Return-Path: <linux-pm+bounces-584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC8C800238
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 04:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53285B210A9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62E256A;
	Fri,  1 Dec 2023 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/qax+t2"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E110D7
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 19:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701402445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q5xYcnLhhl5wab+9SUNf2YG1+1AQAaLiKPAT2IR83M=;
	b=e/qax+t2P5YvcINFgcPlspj/rVKk3yt5bTDqqYwM4Jw8ozUxOHjEfPtyKWDqbZC1JBuCWv
	zZeRxDUPid4Em5hTOgYnkj5Ys6ISxi1ti7R4zMdY0hKnGe/zpPsos4H+K4QCDqMQIY8sIT
	G1sxsfAFm+DLvLaPacI+eLdV8jdzYYs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-mevGzaBvN_6ajGBYIbUEyA-1; Thu, 30 Nov 2023 22:47:23 -0500
X-MC-Unique: mevGzaBvN_6ajGBYIbUEyA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c1b986082dso133886a12.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 19:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701402442; x=1702007242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q5xYcnLhhl5wab+9SUNf2YG1+1AQAaLiKPAT2IR83M=;
        b=s43WTRzO9fVU0e3NnirTfZ44VSHMICl5jXehklScBcYvic37ALVV5eFiZF/P30cZs5
         D/hdViGh7Ksni/bSCGcxbbZzEP/OIR9+vJv4UxcgogjxJq9r/xwmVNuGU1fJpPyach02
         pxVjnBZBqXLtRQNRUzU5g7oMrZveox2F5AMKPCV5ZWfba2VX5u6yu/OuYeVjZqpQoqDK
         rXr89NODGJ+e591+c3taVtro7yDvuRGCZxRKfvT1BO0T23MPVUHYU6XK6fEgumBXKd7k
         5edMsdD5nG7JLXF8gpR3Gt5wquvWY/whqAo56tZrIaWrO1Wz0DNA3ugP9K5hHdTdX+yF
         jY5Q==
X-Gm-Message-State: AOJu0YycbDAoQob9P6PbQDKe9uvNjnuFdqzQBqDvP9qbpWDYnnio50+8
	7zu7IEg3KPWbD6b4ThXupX6QkMBiHipIWDsWSPa6XOnpDGVxoKaUWwx9z3mt6OXU/zgYy/KU2nS
	ZzVa2Z3boCIwgr+SRUGU=
X-Received: by 2002:a17:902:d2cb:b0:1cf:de3e:e4c9 with SMTP id n11-20020a170902d2cb00b001cfde3ee4c9mr23769907plc.29.1701402442617;
        Thu, 30 Nov 2023 19:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFc/FRI9UHJwfBJxYeFRAhPaME7NIPXUpzMmMZaQsrSUZaHXjj5IgT1PfH3h0ARxutVZDmxg==
X-Received: by 2002:a17:902:d2cb:b0:1cf:de3e:e4c9 with SMTP id n11-20020a170902d2cb00b001cfde3ee4c9mr23769867plc.29.1701402442296;
        Thu, 30 Nov 2023 19:47:22 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfc1a593f7sm2185691plf.217.2023.11.30.19.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:47:21 -0800 (PST)
Message-ID: <8c3ca6c7-fa5f-4f45-b36d-1c7d9d94c918@redhat.com>
Date: Fri, 1 Dec 2023 14:47:11 +1100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] drivers: base: Implement weak arch_unregister_cpu()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/23 00:44, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add arch_unregister_cpu() to allow the ACPI machinery to call
> unregister_cpu(). This is enough for arm64, riscv and loongarch, but
> needs to be overridden by x86 and ia64 who need to do more work.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> An open question remains from the RFC v2 posting: should we provide a
> __weak stub for !HOTPLUG_CPU as well, since in later patches ACPI may
> reference this if the compiler doesn't optimise as we expect?
> 
> Changes since v1:
>   * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
> Changes since RFC v2:
>   * Move earlier in the series
> ---
>   drivers/base/cpu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


