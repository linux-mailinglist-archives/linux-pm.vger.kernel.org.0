Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8200C34B95C
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 21:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhC0Utu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhC0UtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Mar 2021 16:49:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F01C0613B1;
        Sat, 27 Mar 2021 13:49:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hq27so13532162ejc.9;
        Sat, 27 Mar 2021 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ca/mJxgN+y3HY02L3N2zVv8EIwzepuDLJrNb7DBKXdQ=;
        b=sNQ/MojAXCDCUFg+Op33/fD2W4ydps+HmcW5ufeokzTzjjhOlsRFhJvTEO4IL10z2t
         n7LQ4wh7yhtKo+SYaHrNiqqDCI+BO7US+cmT/65nvCf1ZAs99v6e6s+H87zeoMfFv8Uk
         yk5ge6zj8gWhL4brREnA84kMc+9DxLjlH/OesIyPYppapQjDfqP4S9VQWBDAqvSWmqth
         HmSrs882uI5jEgCjEdcZ1CIsQ41B9bW8e6NMUlwat4aCDgnFKE60YRZ5bOsuFoXbsbOG
         BYBImWGqoZgGfMkWGyZnep8yrYMytONUm/hgHY44g0yI7mMVrmG3DOIUk4SlXgjsGXsc
         zPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ca/mJxgN+y3HY02L3N2zVv8EIwzepuDLJrNb7DBKXdQ=;
        b=SD2hoX4ZPwJ3GY3jWsTMH2m0oHgwqYm3I3igiYFoTSWiKAa4R1p5YTpFqgAL+ZoURf
         Gc06CyYyOWt1H7kMyDU59fZo4Owyx3gUjijPDNXTyN06SuxfCfVFONhbDPCXdBGyw4n9
         mlQt8PUtxdwNrT+6kMfd3PwfSfRXKetHRr9hn5o+LRQzzjWs98vEha2HQQ8qo7bLXZL6
         GrKGsHzGLHif0uBxtzmikCNqAV+inef5LZQbRJPwdVNs8TTGJ2PI13Ti8wE3fPAgNsil
         LWCPxpieK7CeGSy0r/KRRX2rvDlvXGPsAJBNGrPIn7Tgeuc7rdpAPUmgiMj0A3IrUv5d
         Z7YA==
X-Gm-Message-State: AOAM531RILX3iURP7JE0Nj9sS/IctK0exhaCHnKImXwfMSk5oJREcIFh
        SBLPD6R4XdbvmCru/UWnhBEfxU4XoBb5OA==
X-Google-Smtp-Source: ABdhPJwxLiZTvzB8C0cpzmaiGoRjkbGkWojOde3fJRBRsSRTwKy4k11j94/T6blBYueDjSjKNHuKBw==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr22245325ejb.39.1616878158388;
        Sat, 27 Mar 2021 13:49:18 -0700 (PDT)
Received: from [10.19.0.7] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id mp12sm5541729ejc.1.2021.03.27.13.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 13:49:18 -0700 (PDT)
Subject: Re: [PATCH 0/2] power: supply: Add battery and AC drivers for Surface
 devices
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <350a17bd-f6a3-e97d-beee-d4e42650b8ff@gmail.com>
Date:   Sat, 27 Mar 2021 21:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210309000530.2165752-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/9/21 1:05 AM, Maximilian Luz wrote:
> This series provides battery and AC drivers for Microsoft Surface
> devices, where this information is provided via an embedded controller
> (the Surface System Aggregator Module, SSAM) instead of the usual ACPI
> interface.
> 
> Specifically, 7th generation Surface devices, i.e. Surface Pro 7,
> Surface Book 3, Surface Laptop 3, as well as the Surface Laptop Go use
> this new interface.
> 
> Note: This series depends on the
> 
>      platform/surface: Add Surface Aggregator device registry
> 
> series. More specifically patch
> 
>      platform/surface: Set up Surface Aggregator device registry
> 
> The full series has been merged into the for-next branch of the
> platform-drivers-x86 tree [1]. The commit in question can be found at
> [2].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=fc622b3d36e6d91330fb21506b9ad1e3206a4dde
> 
> Maximilian Luz (2):
>    power: supply: Add battery driver for Surface Aggregator Module
>    power: supply: Add AC driver for Surface Aggregator Module
> 
>   MAINTAINERS                            |   8 +
>   drivers/power/supply/Kconfig           |  32 +
>   drivers/power/supply/Makefile          |   2 +
>   drivers/power/supply/surface_battery.c | 901 +++++++++++++++++++++++++
>   drivers/power/supply/surface_charger.c | 296 ++++++++
>   5 files changed, 1239 insertions(+)
>   create mode 100644 drivers/power/supply/surface_battery.c
>   create mode 100644 drivers/power/supply/surface_charger.c
> 

Hi, is there any status update on this?

Regards,
Max
