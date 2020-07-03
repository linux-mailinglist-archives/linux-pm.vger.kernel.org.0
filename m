Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE062138E3
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGCKqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCKqf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 06:46:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BEC08C5C1;
        Fri,  3 Jul 2020 03:46:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so32809696ljp.6;
        Fri, 03 Jul 2020 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZoL+j4Y+Z4WvYVFNGyL695fk3xg4Z6QZO/cWXb2X98s=;
        b=Hv4+tKt2vemcSn1fWh46/PWtOJvinoHGrUakKW5/d0dZep1DX0iFI+84HcYvtSife2
         0H0ut/5ViUhbrsQiH3Mb4HUjVbbUh0/ZhciON0hFmOEhR9GjFKLJZshW22HOfmGoFxfW
         MiTLrWisu/BdnFf3Ld75vyR0wT4atm194bIui1ltI1dskBs2hYA6t5ESAj+R+4Cf5uki
         KTJW6F8pr2gNb3KMSV5H/LBc7BqsbkAXk6vBJ2is1uviAvIK+HX/loWAIdKfp26t/hXs
         8zc5g0tYA5Eyd8k59m/2ybZCU6Vk0Kpm/n3qxpLycOhl6ncG2nU5NNyG9/W+vxDX0aa8
         b+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZoL+j4Y+Z4WvYVFNGyL695fk3xg4Z6QZO/cWXb2X98s=;
        b=o0F2F4yWPxYJuSIrAMXh105zGsuwNuA4bblzl7TF97E/OIO+PHukLeh8p3c4KRt2lx
         Vf7FQOVmGMySNIxbzsE1yzfTHOfj67FwZh/ArhAtl43jGhgqmzzVlqmk0SiKGQER17kh
         grPY4S00JfllO2BgaMg5UGrToutdklo0lEjVFV3qaM65up3dC43pKz7QNMEM2JsI5PrJ
         NNXb0NVee1v50j/GMJLvm/34FDbYlO1bfdvZx0SmFzY05q/UC/J0Rd2Rtz6QL4Jce+j2
         VKCHaF4NMR8hS4rhp7imlXX5sPVzZHxh1ricV+LW+gqxUs36C/2pjGbAQnuNnOKle/3F
         ABLw==
X-Gm-Message-State: AOAM530NyCQLHXMTfo7iiNlskn+WIlzvsTddCEBNT8wm3ez6VpLwTjDh
        DNH6q/MEPTzGUg1HCk7e2sc=
X-Google-Smtp-Source: ABdhPJxdtDhJ2zfGPUqdkG2FiChIxtnxwVhEYypRyXNFa+PrUnLKzsCkYfuFycSt3kRoLc47KYo86g==
X-Received: by 2002:a2e:9d0b:: with SMTP id t11mr18612477lji.122.1593773193951;
        Fri, 03 Jul 2020 03:46:33 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id l12sm3812618ljj.43.2020.07.03.03.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 03:46:31 -0700 (PDT)
Subject: Re: [PATCH 2/2] PM / devfreq: Add governor flags to clarify the
 features
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20200703100810.12304-1-cw00.choi@samsung.com>
 <CGME20200703095657epcas1p187b7f90a4a33da7791a83a78760f3a91@epcas1p1.samsung.com>
 <20200703100810.12304-3-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6027cf29-ea6f-0a27-3e39-a80c24b80bb8@gmail.com>
Date:   Fri, 3 Jul 2020 13:46:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200703100810.12304-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.07.2020 13:08, Chanwoo Choi пишет:
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index e94a27804c20..620ecd250d7c 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -765,10 +765,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  
>  static struct devfreq_governor tegra_devfreq_governor = {
>  	.name = "tegra_actmon",
> +	.flag = DEVFREQ_GOV_FLAG_ATTR_COMMON
> +		| DEVFREQ_GOV_FLAG_ATTR_POLLING_INTERVAL,

Hello, Chanwoo!

There is a typo here, it should be ".attr = ".

> +	.flag = DEVFREQ_GOV_FLAG_FLAG_IMMUTABLE,
> +		| DEVFREQ_GOV_FLAG_FLAG_IRQ_DRIVEN,

There is a typo here too FLAG_FLAG ^

>  	.get_target_freq = tegra_governor_get_target,
>  	.event_handler = tegra_governor_event_handler,
> -	.immutable = true,
> -	.interrupt_driven = true,
>  };
>  

