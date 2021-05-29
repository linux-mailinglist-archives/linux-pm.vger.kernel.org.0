Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5298394A0D
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 05:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhE2DRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 23:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2DRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 23:17:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6EC061574;
        Fri, 28 May 2021 20:15:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v14so3957116pgi.6;
        Fri, 28 May 2021 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jp5nKXTIBtXqgIz/1SOQD4aLhfftEztbDVVZdGOZUAw=;
        b=mc0hrr6GivTHWWrV1D5Uca0yz36xmMdqsIo4B8dxUH/ZljLdWyehRIKYUp/7YmhSon
         hBWQhUDn3d+FTTsR4H+R/+29zWiTlDRkRqgmuyyXolTyTflaupADzotCessAxjNQvDiT
         JX598UlpmEMYefy++qZPEQS7ZxkSn6+pyK9s1N6F4/Pf2Oq0xmRg7+ke9WcLWeJ5XHZD
         0UW87l+ysrAsSegKxHPgEKjtStQLnRY3XN7B46PIjScT90AoN3F042nrdgttxREaUnFY
         rkqdI3XWZio4alr8ScHihZENGxNQByGUPAZ4dtmLiHfCc8xtlkPRLBaz8ZEAEUKl/P0h
         EdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jp5nKXTIBtXqgIz/1SOQD4aLhfftEztbDVVZdGOZUAw=;
        b=ouennrqi95iEXTLmDGTSqDxIc6yIE1aBThy/Fme1c9wwSBoEjdviBFGBAdtFBQ94Bu
         65okCVJNnDA7FEq7ex4eBdVs1/5BcnKWvMrHqSZkWPaxkRBkgc94py0+A9Ny7y7dcXs+
         urId+YEhaNyD4kP5uHZ/BptUVUo7plzgZHsru8CqwFgQCbvnp+hLkVz3y/Nohkzv7FmL
         rzXQXOUbdfXtjxHm04D858YCsCAlEu4Qsiwo//M57hn29UJPUEyocHUgISuQShUWTXal
         AqH5ctH2gBph1onYd745viDOrq0YZGgCD2PGK27Q/vD4EfQaQJN1nC/1x+vaM2Ycf9yM
         Cs8Q==
X-Gm-Message-State: AOAM533Dx0oNXmBzIGxWm/nIOg87U+yox6VrU+dD3VfY7uA9j+B9rdQB
        3xsfDhp7WSFxQF+CTaZLWU8XBBIX8No=
X-Google-Smtp-Source: ABdhPJwWiRXcljUpa+9dWzGuAKoSRgDgp8du/q+kZJ/DYW6Rrh46TsBIkBmeiA16iEDj1sE+J4L7og==
X-Received: by 2002:a63:5a19:: with SMTP id o25mr11885214pgb.122.1622258128416;
        Fri, 28 May 2021 20:15:28 -0700 (PDT)
Received: from [172.30.1.14] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id k13sm5363988pfg.31.2021.05.28.20.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 20:15:27 -0700 (PDT)
Subject: Re: [PATCH -next] PM / devfreq: governor: use DEVICE_ATTR_RW macro
To:     YueHaibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210524021158.21236-1-yuehaibing@huawei.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <d607250d-e01f-367a-8739-a093fe0e88e7@gmail.com>
Date:   Sat, 29 May 2021 12:15:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524021158.21236-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 5. 24. 오전 11:11, YueHaibing wrote:
> Use DEVICE_ATTR_RW helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/devfreq/governor_userspace.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 0fd6c4851071..ab9db7adb3ad 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -31,8 +31,8 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>   	return 0;
>   }
>   
> -static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
> -			  const char *buf, size_t count)
> +static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
>   {
>   	struct devfreq *devfreq = to_devfreq(dev);
>   	struct userspace_data *data;
> @@ -52,8 +52,8 @@ static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
>   	return err;
>   }
>   
> -static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
> -			 char *buf)
> +static ssize_t set_freq_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
>   {
>   	struct devfreq *devfreq = to_devfreq(dev);
>   	struct userspace_data *data;
> @@ -70,7 +70,7 @@ static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
>   	return err;
>   }
>   
> -static DEVICE_ATTR(set_freq, 0644, show_freq, store_freq);
> +static DEVICE_ATTR_RW(set_freq);
>   static struct attribute *dev_entries[] = {
>   	&dev_attr_set_freq.attr,
>   	NULL,
> 

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
