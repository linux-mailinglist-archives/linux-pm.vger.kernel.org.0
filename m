Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C3110339
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 18:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfLCRQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 12:16:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40194 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLCRQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 12:16:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so4642108wrn.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2kGOYlyefG/izQLdNSUWcwNaTHuNdC1HIARqidaNj9A=;
        b=boyfZ+PKhHVqhkFL8qNRre0PYLPtdfZD3ljOxOD2BfzPbKg8IpytJpbRbI1Fgb1V5v
         gCeD31m2pdxjueZ0l5W2nYSxl9bwklNFa5TRzxX0IQsPbhBjkCl0pMa/WtZcfwv/Mtet
         y9DOsPYcgMGD+iSp7t4f6mW/84zF4ZFx0xhO0PophHN2JOgqPXaoIR5Hv4mMbZ8iRLoq
         dr6lYpPxiZY7GQZPevS4C+Mj/7ufu/NaL6XjaAmXuUdrmj1isYIStJUNlbhsjv7a70IS
         NEIVGGG1SG2zeg+yYko1tBfEgjMkmXHkRgMtsmbXtMqyAblEXXV9KOLI3H3kc7fQNA3W
         46DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2kGOYlyefG/izQLdNSUWcwNaTHuNdC1HIARqidaNj9A=;
        b=Me3cCR96bOVkFypQD/mPmlwljac+rNo2x6dq/9fyVa6EALoyAEv8KYMGe5gWDd+TAY
         d/oHOBXBJshBLhsB77xSxWvlPhV0/3OXnv9Df0hhE9XLXf9goMT2mgCVopmJmb2G7Eoa
         N0asxps6IBJWHfF1xd/1/gKNx4JyOpNvafmXvSgZhArVlr2b7TVMHHC2+34CAj8nHKU1
         DzFOnDy8casH8j8FNk9F3o7OU6xX++lAffbFwJh5aNJh1A95hl1DKysoLHVTUgrcUcFp
         zW9xbjPZ49aQAEl86aPS9wFl1tVX8/n4eUucbK13RlJPplOLWpPdcv/cRjMcYsjGiAi+
         g7fw==
X-Gm-Message-State: APjAAAUYXkwSMSB3+fC2zdTE4EIEgxvW3Oj803ROEzIM/mMjuyKYd3w3
        wdcT2U2Qremub2mUxWM5yGjNng==
X-Google-Smtp-Source: APXvYqw0hg8/hIsuGrZ/40lS0EC14YbpGALBrjzt4B9YHmVsjnSPT5pJaAzvICEI1DmQeMsvMrGJCA==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr6812625wrx.26.1575393357375;
        Tue, 03 Dec 2019 09:15:57 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b5a4:1c65:b54:363a? ([2a01:e34:ed2f:f020:b5a4:1c65:b54:363a])
        by smtp.googlemail.com with ESMTPSA id b17sm4274624wrp.49.2019.12.03.09.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 09:15:56 -0800 (PST)
Subject: Re: [PATCH v2] thermal: Fix deadlock in thermal
 thermal_zone_device_check
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112203154.101534-1-wvw@google.com>
 <20191112204223.115589-1-wvw@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <57162b7c-cf34-2b55-a17c-40d96a0ab105@linaro.org>
Date:   Tue, 3 Dec 2019 18:15:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191112204223.115589-1-wvw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/11/2019 21:42, Wei Wang wrote:
> commit [2] changed cancel_delayed_work to cancel_delayed_work_sync to
> avoid a use-after-free issue. However, cancel_delayed_work_sync could be
> called insides the WQ causing deadlock [1].
> 
> [1]
> [54109.642398] c0   1162 kworker/u17:1   D    0 11030      2 0x00000000
> [54109.642437] c0   1162 Workqueue: thermal_passive_wq thermal_zone_device_check
> [54109.642447] c0   1162 Call trace:
> [54109.642456] c0   1162  __switch_to+0x138/0x158
> [54109.642467] c0   1162  __schedule+0xba4/0x1434
> [54109.642480] c0   1162  schedule_timeout+0xa0/0xb28
> [54109.642492] c0   1162  wait_for_common+0x138/0x2e8
> [54109.642511] c0   1162  flush_work+0x348/0x40c
> [54109.642522] c0   1162  __cancel_work_timer+0x180/0x218
> [54109.642544] c0   1162  handle_thermal_trip+0x2c4/0x5a4
> [54109.642553] c0   1162  thermal_zone_device_update+0x1b4/0x25c
> [54109.642563] c0   1162  thermal_zone_device_check+0x18/0x24
> [54109.642574] c0   1162  process_one_work+0x3cc/0x69c
> [54109.642583] c0   1162  worker_thread+0x49c/0x7c0
> [54109.642593] c0   1162  kthread+0x17c/0x1b0
> [54109.642602] c0   1162  ret_from_fork+0x10/0x18
> [54109.643051] c0   1162 kworker/u17:2   D    0 16245      2 0x00000000
> [54109.643067] c0   1162 Workqueue: thermal_passive_wq thermal_zone_device_check
> [54109.643077] c0   1162 Call trace:
> [54109.643085] c0   1162  __switch_to+0x138/0x158
> [54109.643095] c0   1162  __schedule+0xba4/0x1434
> [54109.643104] c0   1162  schedule_timeout+0xa0/0xb28
> [54109.643114] c0   1162  wait_for_common+0x138/0x2e8
> [54109.643122] c0   1162  flush_work+0x348/0x40c
> [54109.643131] c0   1162  __cancel_work_timer+0x180/0x218
> [54109.643141] c0   1162  handle_thermal_trip+0x2c4/0x5a4
> [54109.643150] c0   1162  thermal_zone_device_update+0x1b4/0x25c
> [54109.643159] c0   1162  thermal_zone_device_check+0x18/0x24
> [54109.643167] c0   1162  process_one_work+0x3cc/0x69c
> [54109.643177] c0   1162  worker_thread+0x49c/0x7c0
> [54109.643186] c0   1162  kthread+0x17c/0x1b0
> [54109.643195] c0   1162  ret_from_fork+0x10/0x18
> [54109.644500] c0   1162 cat             D    0  7766      1 0x00000001
> [54109.644515] c0   1162 Call trace:
> [54109.644524] c0   1162  __switch_to+0x138/0x158
> [54109.644536] c0   1162  __schedule+0xba4/0x1434
> [54109.644546] c0   1162  schedule_preempt_disabled+0x80/0xb0
> [54109.644555] c0   1162  __mutex_lock+0x3a8/0x7f0
> [54109.644563] c0   1162  __mutex_lock_slowpath+0x14/0x20
> [54109.644575] c0   1162  thermal_zone_get_temp+0x84/0x360
> [54109.644586] c0   1162  temp_show+0x30/0x78
> [54109.644609] c0   1162  dev_attr_show+0x5c/0xf0
> [54109.644628] c0   1162  sysfs_kf_seq_show+0xcc/0x1a4
> [54109.644636] c0   1162  kernfs_seq_show+0x48/0x88
> [54109.644656] c0   1162  seq_read+0x1f4/0x73c
> [54109.644664] c0   1162  kernfs_fop_read+0x84/0x318
> [54109.644683] c0   1162  __vfs_read+0x50/0x1bc
> [54109.644692] c0   1162  vfs_read+0xa4/0x140
> [54109.644701] c0   1162  SyS_read+0xbc/0x144
> [54109.644708] c0   1162  el0_svc_naked+0x34/0x38
> [54109.845800] c0   1162 D 720.000s 1->7766->7766 cat [panic]
> 
> Fixes commit 1851799e1d29 ("thermal: Fix use-after-free when
> unregistering thermal zone device") [2]

It does not fix the problem actually. It is preferable to revert the
commit 1851799e1d29.

The cancel delayed work sync takes the mutex while a cat
/sys/class/thermal/thermal_zone0/temp happens which takes the mutex also
and at the same moment a thermal_zone_device_update() call is done in
the workqueue context. This one blocks because cancel_delayed_work_sync
is owning the lock which in turn waits for the work to end.

IMO, that deserves a deeper investigation with the mutex. Probably the
fix would be to refcount the thermal zone device and see if we can get
rid of the mutex in some places. If the refcounting is used, the
function thermal_zone_device_unregister() will be called with the
guarantee nobody will use it and the mutex can be removed.

> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  drivers/thermal/thermal_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d4481cc8958f..c28271817e43 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -304,7 +304,7 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>  				 &tz->poll_queue,
>  				 msecs_to_jiffies(delay));
>  	else
> -		cancel_delayed_work_sync(&tz->poll_queue);
> +		cancel_delayed_work(&tz->poll_queue);
>  }
>  
>  static void monitor_thermal_zone(struct thermal_zone_device *tz)
> @@ -1414,7 +1414,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  
>  	mutex_unlock(&thermal_list_lock);
>  
> -	thermal_zone_device_set_polling(tz, 0);
> +	cancel_delayed_work_sync(&tz->poll_queue);
>  
>  	thermal_set_governor(tz, NULL);
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

