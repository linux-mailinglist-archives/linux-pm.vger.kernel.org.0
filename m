Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7029356AE1
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 13:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351771AbhDGLPX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 07:15:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37700 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbhDGLPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 07:15:23 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU69R-00081T-2I
        for linux-pm@vger.kernel.org; Wed, 07 Apr 2021 11:15:13 +0000
Received: by mail-wr1-f71.google.com with SMTP id v8so5308587wrv.7
        for <linux-pm@vger.kernel.org>; Wed, 07 Apr 2021 04:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HouJQzuf2a1RcT0yofIoKLAiQ7qd5aclheZGD67RW3Q=;
        b=p6phQLlXxbrALm88hDeaPqITUc47+dty2qGw3XK7W5PER+jhI8PoQA/YHi/1rdDuNF
         R6T4ZxW+t8GDnIAdAUIjbn4eIGr1AJsgy+nNnTGHOrsyr8V7w32woZzgKgesrnef+OKe
         lmYo4kbcaZFS30lV5ENPUUgeToDqZYnW79RJdQLFha6MlcAQf4HzPLu27fk05SgOqgu9
         WLf5f7PGsTLomFBl66M+9o8x9lgElxGDMAWcO0z/hpL/TdvWcWAsUkJv0CvXw+H54ncq
         9hbhhGRx/+tBhTgc/pknPIGk49qSl4otE39OPhVGkM0Jy15N5tWeylD7DLNVnjGiTgDa
         BWZA==
X-Gm-Message-State: AOAM530++0mAXKMrsY4gJonK3pq1sJ1a+3JUOoJuzKJx+6ze9aXGEUC/
        BWCMRhhvOgaOrjhfaIm6Ckyj4bvzaUFLkvktfnAVo5DfwsBRsxrW+vJlLOsM5HkB6+EINYCK1m6
        PF18rtH/7ws+ga+P0i3V5ZHm+n5eBWJctf9Ok
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr2579316wmk.135.1617794112789;
        Wed, 07 Apr 2021 04:15:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO6lh76dqAK/8ySaxATJaX1KSJP2CwlW9U/9Lc9KH0/ThKDYRhCZamwGMwGpbLu9yd7DIm7w==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr2579295wmk.135.1617794112628;
        Wed, 07 Apr 2021 04:15:12 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id i127sm8297328wma.6.2021.04.07.04.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 04:15:12 -0700 (PDT)
Subject: Re: [PATCH -next] power: supply: s3c_adc_battery: fix possible
 use-after-free in s3c_adc_bat_remove()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     sre@kernel.org
References: <20210407091903.3268399-1-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <59bbbad2-a82b-e08d-5225-267fee168ed1@canonical.com>
Date:   Wed, 7 Apr 2021 13:15:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407091903.3268399-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/04/2021 11:19, Yang Yingliang wrote:
> This driver's remove path calls cancel_delayed_work(). However, that
> function does not wait until the work function finishes. This means
> that the callback function may still be running after the driver's
> remove function has finished, which would result in a use-after-free.
> 
> Fix by calling cancel_delayed_work_sync(), which ensures that
> the work is properly cancelled, no longer running, and unable
> to re-schedule itself.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/power/supply/s3c_adc_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
