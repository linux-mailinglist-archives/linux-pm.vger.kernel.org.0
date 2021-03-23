Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3543462DF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 16:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhCWPaD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 11:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhCWP3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 11:29:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26344C061574;
        Tue, 23 Mar 2021 08:29:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ha17so10256293pjb.2;
        Tue, 23 Mar 2021 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=skQJo7MFGgmnSo8ig8lPhB8pTWoCTUJAqnXBWPhSpAs=;
        b=HejT71TZaEVQ4rbqbfdkOB5W+UFXe5H3Amt+qHUjD7XjrgaoQqqPseJ0P7ctrORJJc
         jIOxitI06MZ+3YH92eNoH5A8uiUTkWnhay6T5I+QSOmUSgJKrzC5PwZt6Uv0I5hTXcAo
         OLz2cCyz8yYny/CeApBRmvT71t9w25mTU2o474DimCb1zvKIxdXybBYvBE8lK2+6yeKV
         uTv+UtivTU/j+JqNbBqd3XZ9ET37HQfjuehFvwm4HSdNUL1dIxP1mV1TS2vlSO7xC9LU
         SowjoieOhiKNqqYM8n6Q/dVGgfu9/NOB5ntntliaYnz4GcwWmkD02z+/WtY2Es/CeMsG
         x8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=skQJo7MFGgmnSo8ig8lPhB8pTWoCTUJAqnXBWPhSpAs=;
        b=HqQjXN3RQY/JEUDfErwi11+8d+Ww7LkqKI9X8eoyPCqBnUkESaJ/XIPnoBWuUfAo5i
         cf0CeIYlhT7Hn6NsPKfBN0c5N1KzEbPLb+ErR8RaxoRmDRZ/fEYi7am0rNpQzSUIUKKg
         hQTLd7HOMYbMJAQi7DfcEYNpJm2FhVw76aw7CK+GR1wvrgAUHF88U3JQinItvZ2gNCQC
         jWeNrZUw81uHLIRacZhaJHylZPCNkm8poL6Kgclus0DRXQta2CHhMeYj6yQ5KaV9V4mn
         nb6VOW2aweBJEZ1Mt9ckpGZJXwwj4+IADsJkrpy3+evWD1IZltaLEpziLeUdM/CM2Emg
         t0bA==
X-Gm-Message-State: AOAM532V4HUwcNhu5N9aTCkTkEYjN26FoC6BA48n/Oon9wkMigvGsNB1
        oKb+75SunCWPpdTVnjhl+sE=
X-Google-Smtp-Source: ABdhPJyyMTLjFAiP4MOHUNIC5r805KiTRnrKoJ7XHRzoiuG95vGWi4mCWVRa6B6pqhsVeDxAdcjFCw==
X-Received: by 2002:a17:90a:a789:: with SMTP id f9mr5205233pjq.192.1616513376588;
        Tue, 23 Mar 2021 08:29:36 -0700 (PDT)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id fs9sm2980913pjb.40.2021.03.23.08.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:29:36 -0700 (PDT)
Subject: Re: [PATCH] PM: devfreq: Couple of typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210318112025.22755-1-unixbhaskar@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <4879531c-ffee-6359-db23-820670f5fe8f@gmail.com>
Date:   Wed, 24 Mar 2021 00:29:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318112025.22755-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 18. 오후 8:20, Bhaskar Chowdhury wrote:
> 
> s/stoping/stopping/
> s/opeations/operations/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>   drivers/devfreq/devfreq-event.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 6765c03334bc..2f841d7d9d8d 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
>    * @edata	: the calculated data of devfreq-event device
>    *
>    * Note that this function get the calculated event data from devfreq-event dev
> - * after stoping the progress of whole sequence of devfreq-event dev.
> + * after stopping the progress of whole sequence of devfreq-event dev.
>    */
>   int devfreq_event_get_event(struct devfreq_event_dev *edev,
>   			    struct devfreq_event_data *edata)
> @@ -184,7 +184,7 @@ int devfreq_event_get_event(struct devfreq_event_dev *edev,
>   EXPORT_SYMBOL_GPL(devfreq_event_get_event);
> 
>   /**
> - * devfreq_event_reset_event() - Reset all opeations of devfreq-event dev.
> + * devfreq_event_reset_event() - Reset all operations of devfreq-event dev.
>    * @edev	: the devfreq-event device
>    *
>    * Note that this function stop all operations of devfreq-event dev and reset
> --
> 2.26.2
> 

Thanks for fixup. I think that you can squash this patch with
patch[1] as you sent.
[1] [PATCH] PM/devfreq: event: A typo fix

And please use the following patch title
-PM / devfreq: event: Fix typos


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
