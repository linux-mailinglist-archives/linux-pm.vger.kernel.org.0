Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2B1D7B35
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgERO1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgERO1G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 10:27:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B6C05BD09
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:27:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so9508555wmb.4
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xoHOUrjWjrjJkUovXnSbWIcN9mxpui2eJo/05V96wtM=;
        b=Rz0PW+HyeBQPuhmuNTbrd0zjHmNwI9815ifDyJdW+TDOkZf6Bwg6Vt4q6MUXEpZcbC
         5DEdH56yaFs6ViinebzGi45g/NttR/ub8YjDdhR2UAG8cKvc+xv3gbHYJjj6WXWIQOsw
         vDJHYvOUXrFNCa41+ZcHGOekRFoM6bgHdC4+OpJtG/TVQPWn3LH2gxbYOc+9cJWjWN4v
         rz0gYn9ElxMyNOMaMY+sRsprmP5dVhZ7FswBapr5ePGJWLNfqBDT7WV+/9LxcYyga/PV
         B8PS1yQk5Y9wdBJULcTm0UNNis15ZGdwVl8qa+CC3rRpV/ronN2oZlKRHNY4LRx7zbe6
         w1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xoHOUrjWjrjJkUovXnSbWIcN9mxpui2eJo/05V96wtM=;
        b=sU68CrsELWDJMiAmn+53dUBdxwQe6M4IO90RzeTW8zLz8IWDbJnCvaJQ0J7F5hCeXZ
         8trXiIpr9a+7ppzMM8z5FhOP/pYNcADbTRrNuAH5yl15ehTS+XiTFy21vWbAQKJ+wPtK
         To6VITwBVKoVaMn2QSTMx3nG393m0YHjS6krl3vMpS8aZ4+UGGVO+VDK1DnFJVuPk0wv
         uF7FtA9uJh/5JYO0tam00m8sdpTpYG3H1SeHyMQBLSDn8Qo+m0DW9D6+KRnnnYMigBEn
         9LJ8uIAykiaq7RkNZVoH09u10GURZeWZxy6J/jpQvyxeuIZKxtIBrnbLBH6G6mZMM7GY
         C82w==
X-Gm-Message-State: AOAM532PaW7bRFwegt1ci5754XSnIBOXjJF6OWfVo4FBDcNCzmas9d5D
        hqhUxOXCO3xNj7I+3GehhQbF5A==
X-Google-Smtp-Source: ABdhPJw68cGHcXBbna/sB8V7o1fCiMhYef9NIVXW3K5++ohiLd5QFjMaOxuPlMS/S9t93Zi7hVFggA==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr20261681wmn.68.1589812023442;
        Mon, 18 May 2020 07:27:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id n17sm16464326wrr.42.2020.05.18.07.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:27:02 -0700 (PDT)
Subject: Re: [RFC v2 PATCH 6/6] Documentation: ABI: make current_governer_ro
 as a candidate for removal
To:     Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
 <1588235987-12300-7-git-send-email-guohanjun@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5f1793f8-f72c-aedb-65b6-b956e0377893@linaro.org>
Date:   Mon, 18 May 2020 16:27:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588235987-12300-7-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/04/2020 10:39, Hanjun Guo wrote:
> Since both current_governor and current_governor_ro co-exist under
> /sys/devices/te system/cpu/cpuidle/ file, and it's duplicate,
> make current_governer_ro as a candidate for removal.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  Documentation/ABI/obsolete/sysfs-cpuidle | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-cpuidle
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-cpuidle b/Documentation/ABI/obsolete/sysfs-cpuidle
> new file mode 100644
> index 00000000..f984b9c
> --- /dev/null
> +++ b/Documentation/ABI/obsolete/sysfs-cpuidle
> @@ -0,0 +1,9 @@
> +What:		/sys/devices/system/cpu/cpuidle/current_governor_ro
> +Date:		April, 2020
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +	current_governor_ro shows current using cpuidle governor, but read only.
> +	with the update that cpuidle governor can be changed at runtime in default,
> +	both current_governor and current_governor_ro co-exist under
> +	/sys/devices/te system/cpu/cpuidle/ file, it's duplicate so make
> +	current_governor_ro obselete.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
