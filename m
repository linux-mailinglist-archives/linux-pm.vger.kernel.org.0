Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD59394CF0
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhE2PaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2PaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 11:30:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E2C061574
        for <linux-pm@vger.kernel.org>; Sat, 29 May 2021 08:28:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y7so3417952ljd.7
        for <linux-pm@vger.kernel.org>; Sat, 29 May 2021 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zGI8TzqOwd0/m1J4hmK/S85ZbcoWKqyfdbWW8NDDeEQ=;
        b=lJe6JRPT2rJSRreBUI2jG7HUj1xh+jHMMj8BduEKgBr21Uzi7HYeRD9HReRLlBOcK5
         l8LfDXKasP6g/E12iYgYhAvbOMrEel4ULLvbXHXG4/yqvu16e4bBymgiFaqglmeQ7Z7M
         TkK21bE4673NqIkj4Y5OppnxCMcatf+gJnTriiIpE2x54iZkZJ5s/fW5cq2TQBZrmz6+
         3iS9DJFJj9jjhUC+C6Gv04kK17lxwkqMyzvLsLKC17orWtXUvsXL9OSI8D+B21aeThiR
         TGezmhE89QnTp12XlDsDF/3BKiuD1v8MY3cbeW8Tyx/0eu8c5nKjumyaqQelui7jiVNj
         m6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zGI8TzqOwd0/m1J4hmK/S85ZbcoWKqyfdbWW8NDDeEQ=;
        b=l9McDJE+bVy1GvnOHY+3kzkzZSIIfnB5qWFh2IQTY47fLFxupfaetk9MBGJhX71t8o
         Mcj/7kJob0fOGv8VA1zgzxOWKm5HbF0Lv3a6qAvy6EgW6IrcH4K6YRq1nXuxQQZ1gYfj
         5l6tETd5qYv3qDcIF+rSAoPEy3gQrJnYXk/ITnn4vpxu9dZN9QyZNfp5p6YiSn5gnWBg
         o4Yg7RKkdvoi6AlpZahePADF/P07Kz/3ciIv96cHZE70V/0yJg95U8xXuJVSGjNL4dAM
         xgRHrpRIHfIbQ0gEjQC+LcSS8pXjTQy7a7jCxBiMUFhWfQ+3mXEidknED434PlmzlTt/
         E8gw==
X-Gm-Message-State: AOAM531foX4wKU+mCHRGdF9nBFlPw/MqgZuNu6tFwW0tagm1BJabh3y/
        bfdZ2d/ZADzg5Bz1EKB9vt4=
X-Google-Smtp-Source: ABdhPJwo3LmNZazv/r82apIT8JJhNNpaI8FbjpgImwK4kvLp2llaJWrVtwMa0mD1dWMtelYP9t2+mA==
X-Received: by 2002:a2e:160f:: with SMTP id w15mr10313175ljd.357.1622302112209;
        Sat, 29 May 2021 08:28:32 -0700 (PDT)
Received: from [192.168.2.145] (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.googlemail.com with ESMTPSA id o5sm855058ljj.103.2021.05.29.08.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 08:28:31 -0700 (PDT)
Subject: Re: [PATCH] power: supply: smb347-charger: Drop unused include
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20210529001902.468060-1-linus.walleij@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7ee3cac3-490d-74b2-00c0-8db5e4ad246a@gmail.com>
Date:   Sat, 29 May 2021 18:28:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210529001902.468060-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

29.05.2021 03:19, Linus Walleij пишет:
> This driver is including the legacy GPIO header <linux/gpio.h>
> but not using any symbols from it. Delete the include.
> 
> Cc: David Heidelberg <david@ixit.cz>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/power/supply/smb347-charger.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
> index 3376f42d46c3..df240420f2de 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -10,7 +10,6 @@
>  
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> 

Good catch, GPIO usage was gone with the removal of legacy platform data
from the driver, which Sebastian did not so long time ago.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
