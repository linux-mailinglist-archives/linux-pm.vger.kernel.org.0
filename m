Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B540C332989
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhCIPBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhCIPBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:01:41 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2047FC06174A;
        Tue,  9 Mar 2021 07:01:41 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o10so8942130pgg.4;
        Tue, 09 Mar 2021 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jAGZ5sEf9vaYX8UZALNAacoRO32XNt4raNXvQGYcoqw=;
        b=BAeVdF0ggY6MFhuY0il82N0QgZBqVJQxa02yXf0JLGGBOD4H9mFeosmfilW969zPWw
         q/a6PqK2QLmteL4lMmHPWujpMwnm8pU6y/2zdmnxbVYvKZ4P9k0BIrAGM1X3eAW+2q6H
         8pQoodsrOqwGFwE7sGITtJ4rBRwFlimJtyE+R/3QkzOJ6IyqaSfSFMPgzWTLBSxQvvBJ
         gJ15O1Rlz1VaJdjWYATB3HuhRSra1DAu/g15IfPXl4wGC1FW0o8kbTworcumjiDyXHvC
         C7tLz5+URY+xVNqYno0+7U+SgzWhOC5h6hQxz8YGIQGjhN/ybOQ9orSYdMC3PhLFwuR7
         6LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jAGZ5sEf9vaYX8UZALNAacoRO32XNt4raNXvQGYcoqw=;
        b=U1GSk/op2xFZlMvHHTluZAHktzhDk/TJnvYTKeVlKdk570cW7MC2Wl8FLbjCTa/Fp6
         4Kyi7XDCTVgfos0u20RgGFLhpExw1iFQqZtrHCYbs7V9PPwmw4Oyk9ZQIeaMVd1H/FK+
         5prE1f/TgzdeKGtqMZZLS8GRCxqE7AwawU/lxn9DkGFmLSdl3bCLLo26cJyOr/qI4oSu
         NtDdVtwNjpuXf6QfnN4aZW3HTJn+FM8E2CSuqXM4T9Tk3mwwULLcxFqbn864+aGasWWP
         7Ffuxnc0KkoM1s9HkL4rE96EDcDg9AknUInEXRsz6YS45MH8CuOQd40u+0IEBEHF+t+d
         TkLQ==
X-Gm-Message-State: AOAM533T7fkDqG0vFbW/XVm4XoSGfs8UoP+R54UFpMSKeyV1YbKC4Bdc
        SdzYi9BjnPVbD9dDjyhLQC4BUzHD2CkosQ==
X-Google-Smtp-Source: ABdhPJzziSkX26uMomwOJRocq0aYfXVr4paTilcHUy11X5fkxnfR76Lecxq526mnr7nLgsEWnRzYIg==
X-Received: by 2002:a65:458e:: with SMTP id o14mr10647697pgq.415.1615302100607;
        Tue, 09 Mar 2021 07:01:40 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id l6sm2227956pja.16.2021.03.09.07.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:01:39 -0800 (PST)
Subject: Re: [PATCH 01/11] doc: ABI: devfreq: remove invalid central_polling
 description
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-2-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <c8289e3a-8aca-7cbd-ffb6-de2a5a69f8ef@gmail.com>
Date:   Wed, 10 Mar 2021 00:01:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-2-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> no_central_polling has been removed since
> commit 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices
> which can idle")
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   Documentation/ABI/testing/sysfs-class-devfreq | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 386bc230a33d..5e6b74f30406 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -97,10 +97,7 @@ Description:
>   		object. The values are represented in ms. If the value is
>   		less than 1 jiffy, it is considered to be 0, which means
>   		no polling. This value is meaningless if the governor is
> -		not polling; thus. If the governor is not using
> -		devfreq-provided central polling
> -		(/sys/class/devfreq/.../central_polling is 0), this value
> -		may be useless.
> +		not polling.
>   
>   		A list of governors that support the node:
>   		- simple_ondmenad
> 

Looks good. But, you better to make one patch with patch1/2 by
squashing.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
