Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31F19E7C6
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDDVkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 17:40:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46480 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDVkv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 17:40:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so10565496ljg.13;
        Sat, 04 Apr 2020 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JMPqtLiyle3hnA0yz5/rma3PZC3NUiCA2HOMNpCxoFQ=;
        b=rrBwp7SCLJer6Iw0pYwVspuK7bro/VSRwtB8zM5qgwbyvzzKRUJbGV9N+budcgTwNr
         OFekZzJDxmBdIeE12U2VWCwh8ZvfcjZKiVdzeZiupLBiWUdUoTYqpIKF4NpjpWU61cao
         yrP8Do5Vpmo+F+1qYoNqpTkyv+fpVpFBcSmyYx+uRukNgR5WMwPWxEKmdhCZ0mnwwce6
         P7Gze7I7oyv9PDPGkPDVuORJxgcZWhRGaq47fMbN9Ug2Uoitw9AASDjXlKlBVLho/6tt
         mM3mgQTp+eRNIwUPzVYibKJl5dq5kVFwovcwwxGno0wowr338SuMm8ZkdR0J2LSX0ZBD
         wLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JMPqtLiyle3hnA0yz5/rma3PZC3NUiCA2HOMNpCxoFQ=;
        b=Qexh1hh3RneyWfBuLcl95l6eeI0K6oa4mUuzr1N1P4j26rU4fv+VN2EIBXB2Ti1jXp
         Y4zSLZSqdz9VoaUTZSm1YCo9xNDTmCmq3toT3BvWPJWuH8xn6QeKOJA402h/no1HHDDp
         mJ5ft6vz/lmNE9MU9KMpcyjz+o9qQWQoAQvSiZKRcDrsJE0apuHQ4o4MJc9oD552Kp2P
         Y0vWuZ1Muod+2scvVZLVVDgdnZHIYE9EhoiT8wuo40LVNHN1q0kvHdlF09fa4gnv4SUo
         BsttPy3Bht5kOzJUp0CC9QrKu2fy5rtEoi6rXtw3ohM5FqoZPTd8aLf8xdaiuBFFQCKi
         pXoQ==
X-Gm-Message-State: AGi0PubDgto/YJEQciNW/Qs4dkL55wqWBSerwelvEEf9nU9p2MEDZD+M
        hz8Aq4X5Z/GCuPb/XcUdVj4=
X-Google-Smtp-Source: APiQypIfdQmzxGJNdWVHAB8GwLoAsSFoHOImV2N3Dvsfbby+B0RiPRPlfuolT2+enPk6TRO8Q0P9xQ==
X-Received: by 2002:a2e:b4d1:: with SMTP id r17mr8227053ljm.117.1586036447002;
        Sat, 04 Apr 2020 14:40:47 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id a6sm8730966lfl.5.2020.04.04.14.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 14:40:46 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: Delete an error message in
 tegra_devfreq_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <ba67e238-43a7-6c53-363e-7a2c12f09949@web.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <27bdd09b-0b8d-a6ef-2ffd-53421277fcca@gmail.com>
Date:   Sun, 5 Apr 2020 00:40:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ba67e238-43a7-6c53-363e-7a2c12f09949@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.04.2020 21:45, Markus Elfring пишет:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 4 Apr 2020 20:34:02 +0200
> 
> The function “platform_get_irq” can log an error already.
> Thus omit a redundant message for the exception handling in the
> calling function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 28b2c7ca416e..93e6f4b25b04 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -807,10 +807,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
> 
>  	err = platform_get_irq(pdev, 0);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +	if (err < 0)
>  		return err;
> -	}
> +
>  	tegra->irq = err;
> 
>  	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
> --
> 2.26.0
> 

Thanks,

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
