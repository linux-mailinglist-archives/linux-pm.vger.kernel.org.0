Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2763B1D7AF9
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgEROUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 10:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 10:20:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5A4C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:20:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so10686573wmd.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I3wpDNTrLLNpYvNuwfe9mDkYuFPCzmBd/bjVhSv3cqE=;
        b=EB2HD5lIZhLD6gFsZLWLlr3sJcDQpbkHYY3PzBcYTf2bqiZv29BmNzKdQvZH894Eu1
         L0eNX45R/BM77yi3zxOkN1E3u04ny4NM25aya4pQmFZYihgmTsaFOhBQsi0rqdPdDooU
         nTs/wd0JzBmnSApdZe1cIeHp+E4po7lqS19hUdzp/at0PGQVCPOQTDQYHr9eDLg1iHvf
         tMdlvnxSSY+SpWwZDrz8BYh3tUOOfIDVX3tfGMbZdqa1FEBsF0kVKVV72m0yT5MjIat4
         CqkyYRC+z0ewUXl8f+b9MKYJ+nk1E9liPteNmVJWb2Hph6+QvVR/5iZ5LpY4V1LsBrsp
         jp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I3wpDNTrLLNpYvNuwfe9mDkYuFPCzmBd/bjVhSv3cqE=;
        b=H1HZE67YgAtT2/bvwxMxeM4aeS3EXztpayu0PpaPQmrLy4N3SWS5CEXTSOgd4lBIPH
         kZoktKF48zP6m/d4ALyYzo4Kd70nDSfd0A+L/l+z0q0hOrMkOHnZp0JBLimfc1kl5E04
         4nxvIKvv7ariWY/2EdGPx3u2xzejwnzHV1zmJwjA+O4AeU4AFLOiPFnG1kbGo9L0Xdh3
         UTHtWegvT83+I6OgZeS3WRn4ykKt4RjANNFpzxCrE3VWa06kETSChqkQf0wKl/iF20SV
         74ptJHJnxV9QuwkoTdjLCINGK64Ghl72kiAItXbwsG9Zu/2ZCBcNDuOp/Y8vEzAVhVjI
         wbjw==
X-Gm-Message-State: AOAM530/66iWcdgg5vuExmupGiYW+hi3A8FGV37YkOkIy4c4h4P7sVB8
        brkKAMfdtEoOiG2DYIQsGmWR3Q==
X-Google-Smtp-Source: ABdhPJyKqSH1HCCblC7SzxKJ/qkkrqlL15bKhvlO1g9+bhpm8BbYUwBOj90VDXAzM7pvse+nRrhBfA==
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr19528635wmk.3.1589811639037;
        Mon, 18 May 2020 07:20:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id x1sm16260401wrt.86.2020.05.18.07.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:20:38 -0700 (PDT)
Subject: Re: [RFC v2 PATCH 1/6] cpuidle: sysfs: Fix the overlap for showing
 available governors
To:     Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
 <1588235987-12300-2-git-send-email-guohanjun@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3161e9ec-1bdc-bb51-ec6f-b3c7e2f6e907@linaro.org>
Date:   Mon, 18 May 2020 16:20:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588235987-12300-2-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/04/2020 10:39, Hanjun Guo wrote:
> When showing the available governors, it's "%s " in scnprintf(),
> not "%s", so if the governor name has 15 characters, it will
> overlap with the later one, fix it by adding one more for the
> size.
> 
> While we are at it, fix the minor coding sytle as well.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/cpuidle/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index d3ef1d7..3485210 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -35,10 +35,10 @@ static ssize_t show_available_governors(struct device *dev,
>  
>  	mutex_lock(&cpuidle_lock);
>  	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
> -		if (i >= (ssize_t) ((PAGE_SIZE/sizeof(char)) -
> +		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char)) -

Is is possible to have a sizeof(char) != 1 ?

>  				    CPUIDLE_NAME_LEN - 2))
>  			goto out;
> -		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN, "%s ", tmp->name);
> +		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tmp->name);
>  	}
>  
>  out:
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
