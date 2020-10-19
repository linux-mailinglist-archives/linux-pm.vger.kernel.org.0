Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB02920B5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 02:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgJSAih (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 20:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgJSAig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2020 20:38:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DFEC061755;
        Sun, 18 Oct 2020 17:38:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l2so11980790lfk.0;
        Sun, 18 Oct 2020 17:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TQrYulznA0V6ibdtBLEv3EfiQZ8dRPQp/p7Xj5s7oyA=;
        b=BMrWAdO+9yWgcd7X8QL69vA4NpbOy4y6KdaGS5cOhgnUlLixXKWKbWVoJrkoc+W+5E
         4ASwvFCqmN6jCYQRo8ZkVMfJtnxgqWfcPDqblbf4ehC49Nm0t1mS2qzWUqkWL9aSW8vo
         moaQaXNamm+3H785Y/SaUL5ODQVR5+VCTRZiBz8xIemejuaTAnTcutetQhZSZ8bAiH4n
         FtlLKEJDByOi84tzSlp8g09e9VtFPEkOCMCV2xK6u7Dp36F3/6Q6aYm570j6GO+esQ5M
         qBN1D49RUF2ZFFqUE7StU6Jyq4IAt+QBRy8sO0DD2iZwsjShTeqM6df14gtwdOe89Ps6
         /tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TQrYulznA0V6ibdtBLEv3EfiQZ8dRPQp/p7Xj5s7oyA=;
        b=AUuOPhoXN3wLp5b9Vfzdslf02KDFl9zyol+YtiVSelqWM2b4bvENGQTNSBvTXSx/9C
         6pe+b8edXKZHGCY6T6883TO3gg+SfQbNeXLjAdxII1jiXAbx8ppJUGUJN7TQFXc3JMPD
         yim82v5PobMI22QNDLvEnORQFomFaEzjNlC2jP/Y2DI25hOWpMNyTtQzzinK+vExu0/o
         ziUr4DJZuLtxNh5P4+1r91N9HOa2rkVyAJlZGCmybFEMUyl/d+nTRWyloBUXPV+L8iM5
         0LUNqD/mvVh4E8uKDvX8oWl9mmZ5qSH8nDTo/RkfQ0hjq68yV8eh7Gqy/5/EakQdlcoE
         mH4g==
X-Gm-Message-State: AOAM531C2RnOFEUeFI5a/psZU0aJKZSsxWNuqEzIebRmfv6fi2fmesOB
        /issnLtyNJ812TT9dJTCrVQ=
X-Google-Smtp-Source: ABdhPJxj2gmpkSkUKVRcZ8Wgq1il/bzg3RhRQqGnB48OPx/+xapxr6Ha4qfHs1mtFpoFgYpzP6J/8w==
X-Received: by 2002:a19:e04e:: with SMTP id g14mr4574670lfj.590.1603067911543;
        Sun, 18 Oct 2020 17:38:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id j18sm2987768lfh.283.2020.10.18.17.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 17:38:30 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20201007050703.20759-1-cw00.choi@samsung.com>
 <CGME20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767@epcas1p3.samsung.com>
 <20201007050703.20759-3-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <63ac80e9-7f31-8447-06ca-e7d830a4aed4@gmail.com>
Date:   Mon, 19 Oct 2020 03:38:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007050703.20759-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

...
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index deefffb3bbe4..67af3f31e17c 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -37,20 +37,6 @@ Description:
>  		The /sys/class/devfreq/.../target_freq shows the next governor
>  		predicted target frequency of the corresponding devfreq object.
>  
> -What:		/sys/class/devfreq/.../polling_interval
> -Date:		September 2011
> -Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
> -Description:
> -		The /sys/class/devfreq/.../polling_interval shows and sets
> -		the requested polling interval of the corresponding devfreq
> -		object. The values are represented in ms. If the value is
> -		less than 1 jiffy, it is considered to be 0, which means
> -		no polling. This value is meaningless if the governor is
> -		not polling; thus. If the governor is not using
> -		devfreq-provided central polling
> -		(/sys/class/devfreq/.../central_polling is 0), this value
> -		may be useless.
> -
>  What:		/sys/class/devfreq/.../trans_stat
>  Date:		October 2012
>  Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
> @@ -65,14 +51,6 @@ Description:
>  		as following:
>  			echo 0 > /sys/class/devfreq/.../trans_stat
>  
> -What:		/sys/class/devfreq/.../userspace/set_freq
> -Date:		September 2011
> -Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
> -Description:
> -		The /sys/class/devfreq/.../userspace/set_freq shows and
> -		sets the requested frequency for the devfreq object if
> -		userspace governor is in effect.
> -
>  What:		/sys/class/devfreq/.../available_frequencies
>  Date:		October 2012
>  Contact:	Nishanth Menon <nm@ti.com>
> @@ -109,6 +87,35 @@ Description:
>  		The max_freq overrides min_freq because max_freq may be
>  		used to throttle devices to avoid overheating.
>  
> +What:		/sys/class/devfreq/.../polling_interval
> +Date:		September 2011
> +Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> +		The /sys/class/devfreq/.../polling_interval shows and sets
> +		the requested polling interval of the corresponding devfreq
> +		object. The values are represented in ms. If the value is
> +		less than 1 jiffy, it is considered to be 0, which means
> +		no polling. This value is meaningless if the governor is
> +		not polling; thus. If the governor is not using
> +		devfreq-provided central polling
> +		(/sys/class/devfreq/.../central_polling is 0), this value
> +		may be useless.
> +
> +		A list of governors that support the node:
> +		- simple_ondmenad
> +		- tegra_actmon
> +
> +What:		/sys/class/devfreq/.../userspace/set_freq
> +Date:		September 2011
> +Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> +		The /sys/class/devfreq/.../userspace/set_freq shows and
> +		sets the requested frequency for the devfreq object if
> +		userspace governor is in effect.
> +
> +		A list of governors that support the node:
> +		- userspace
> +
>  What:		/sys/class/devfreq/.../timer
>  Date:		July 2020
>  Contact:	Chanwoo Choi <cw00.choi@samsung.com>
> @@ -120,3 +127,6 @@ Description:
>  		as following:
>  			echo deferrable > /sys/class/devfreq/.../timer
>  			echo delayed > /sys/class/devfreq/.../timer
> +
> +		A list of governors that support the node:
> +		- simple_ondemand

Hello, Chanwoo!

Could you please explain the reason of changing the doc? It looks like
you only added the lists of governors, but is it a really useful change?
Are you going to keep these lists up-to-date?
