Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F134427C50
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhJIRUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 13:20:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49552
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhJIRUg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 13:20:36 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 889793FFEF
        for <linux-pm@vger.kernel.org>; Sat,  9 Oct 2021 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633799912;
        bh=6vTs51Lr8vLHY4n076CsFn/gLEdhdBV/K1u6U6+j1dg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=qU7kRu1ooq4DiwA76+/cW2PhNcRR9JSQH2Pyh1nz9vUVYJQHnPri3eqLhDqVztGh0
         SqIYN1OTjQ/BLOTfr0CQ/sq+NFQonvitWDBcYa975ksICmfdLVBaT1nku9PLe43xNG
         YmRUUDXVkSMbVWovpR+wf331cdjHT79W1mvWaWezubEBiCFAWcBMUQRPYop6GGsWNd
         ova3UFfrL+ayOz/SfX4tdoNvQbU/U67UskWzQAanPe9mQyDgeOP5aYQczEVksAcxE0
         vhWs2eNrZvhKxFsl8jpw7p/kbwv4/wwfWvv2JYY758Jx/M3LCeH9g3apYHCY7B4iGm
         IbMxmkC7CBceQ==
Received: by mail-ed1-f70.google.com with SMTP id f4-20020a50e084000000b003db585bc274so6344968edl.17
        for <linux-pm@vger.kernel.org>; Sat, 09 Oct 2021 10:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vTs51Lr8vLHY4n076CsFn/gLEdhdBV/K1u6U6+j1dg=;
        b=rTQZF+rQU9ZxGuzaQVHlBL44tsR2/SMuaJ5sn2W9jkvquo5cDfxM9YCBuM6l8VF0tx
         AhmL5GsjuTOVsZkcnC+WdEpuwqgYjRaMmdDd1Y6OUFdGUeYDKUIJPwxXkt65qoFbFm53
         OjA35+vdp82T3rOUy8tSoojfAUyBjZf726NF1xcnghbB9gazgheqK24Qn8P1RzEfX5Y/
         RiVc1b3F2+RS+Hrn6Hz+uQT5+xOnQ3AwqaQI/3Ql+abIfqVsElHe3n8IsC3UEqrtrBKy
         5UUA6Xmwgl0cx6bFLuCrl64PXVSoTWNOujFEG2L7y5mVcSBxCyKXKRL9bG+FeKnghVOx
         8ayg==
X-Gm-Message-State: AOAM533TVha44L9/aWSFE2PSs0JY6K5UfBlvdCLGj/tdj3ntXoBNhmqY
        n2Oo/d/tFkKnXhFNcw8ZojO91YNX2W5Ar7Cg58wnleUmFXkNDOQG2HxGTbrCKHi5c9IId2qQio6
        T86HJDyVdVXHiGwHYvDWaR8OyZOXYEprgkMEt
X-Received: by 2002:a17:906:2ccf:: with SMTP id r15mr12596559ejr.182.1633799911928;
        Sat, 09 Oct 2021 10:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTFK3yvDCh4cP+YD8IAgX0mwfVS3GVAk+kiNZrMFqKNDBoZ+Nedcqb9ctSXXgWuVyyuZbFrw==
X-Received: by 2002:a17:906:2ccf:: with SMTP id r15mr12596540ejr.182.1633799911789;
        Sat, 09 Oct 2021 10:18:31 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y19sm321830edd.39.2021.10.09.10.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 10:18:31 -0700 (PDT)
Subject: Re: [PATCH] power: supply: max17040: fix null-ptr-deref in
 max17040_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     sre@kernel.org, iskren.chernev@gmail.com
References: <20211008063150.822066-1-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <394b0984-50a6-af80-195b-033bf9624dea@canonical.com>
Date:   Sat, 9 Oct 2021 19:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008063150.822066-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/10/2021 08:31, Yang Yingliang wrote:
> Add check the return value of devm_regmap_init_i2c(), otherwise
> later access may cause null-ptr-deref as follows:
> 
> KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
> RIP: 0010:regmap_read+0x33/0x170
> Call Trace:
>   max17040_probe+0x61b/0xff0 [max17040_battery]
>  ? write_comp_data+0x2a/0x90
>  ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
>  ? tracer_hardirqs_on+0x33/0x520
>  ? __sanitizer_cov_trace_pc+0x1d/0x50
>  ? _raw_spin_unlock_irqrestore+0x4b/0x60
>  ? trace_hardirqs_on+0x63/0x2d0
>  ? write_comp_data+0x2a/0x90
>  ? __sanitizer_cov_trace_pc+0x1d/0x50
>  ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
>  i2c_device_probe+0xa31/0xbe0
> 
> Fixes: 6455a8a84bdf ("power: supply: max17040: Use regmap i2c")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/power/supply/max17040_battery.c | 2 ++
>  1 file changed, 2 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
