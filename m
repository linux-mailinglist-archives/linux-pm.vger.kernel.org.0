Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98238E3DE
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhEXKWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 06:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhEXKWQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 06:22:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD6C061574;
        Mon, 24 May 2021 03:20:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j6so37244815lfr.11;
        Mon, 24 May 2021 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+yxfVj7jKw45QrlrhnP2dyoysNu/SHiHa0fZjF/qcQ0=;
        b=TEuKP8ZT44wcv2P28T7veECGsfNWN5/tjRGeEbBLT9ckwElAo2/G7M3YS9/I5AfcX0
         cQCItZCZyHhWSMqPRUyFfm8o3StpIsWSKCAxVUfzQvdDVs0Ss6xQB6JuSIIuBkR0QHEP
         J2hadytj6P1ujmmzrzxjJ06aGPk8/svT/F1KDFjrim78oH/jpmwBQ+z3VSP6f3x6tl4L
         145LaqeDDrG8QIj0CHX+ppwjCUqM24O5oipjgzRrZiWSKIawOX3klSrNc+fl6w2xGkNP
         vNZgNmdNod2Hij0o//7QA/KxfBLQ4ob6cU3PZFumy+JGMaIuMn7VPmlgARnn1iu867Nv
         88Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+yxfVj7jKw45QrlrhnP2dyoysNu/SHiHa0fZjF/qcQ0=;
        b=pRBH/3Uaeo00/1KcV1pyXd+UMmZPkGvp7gQvhulAB5ugY9T+V0Mcr1b8cA9Wnij7PG
         iF4ackqyCtS0PZzHanAby7SCTUwTvJcA6e0wHnqVbVNGtDpKhk6y8LO4Kv2Q64TSVKtW
         pK33XKtoVKMBpGPyWTtjzD1JTAR7tDucwowy3Jce7SoGss9NFNKiLMbcq14cP3Ppp8oG
         JdOff4VMmqmBzBHew7Pt/6qM8Yf+omWfiBSyPokLwAb+0RZk04TBuMaoZXjupjyDUEI2
         FTt/nTVkgVqQIvJkwPrj/QVLMqLzWJwF0sTybXHlLXMCAnnSpRUnqya4bhUMducBGLg/
         hY5A==
X-Gm-Message-State: AOAM532mhHNZwOeftPt7X4IShvErq+Hew2C8F83BVpwJcflwMiEGagPr
        4+RJ7wcE+3iwmG5OVnNzwQvpZ5pyWTY=
X-Google-Smtp-Source: ABdhPJyple+XJHadP4SOsxTYxSH8E8EyGwgFHnwIzBn43eRvrU5XxLQIOX++TAMI6HQeat+eU1BY7Q==
X-Received: by 2002:ac2:50c2:: with SMTP id h2mr9709116lfm.499.1621851645960;
        Mon, 24 May 2021 03:20:45 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.googlemail.com with ESMTPSA id q6sm1391573lfn.11.2021.05.24.03.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 03:20:45 -0700 (PDT)
Subject: Re: [PATCH v2 02/14] regulator: core: Detach coupled regulator before
 coupling count is dropped
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210523231335.8238-1-digetx@gmail.com>
 <20210523231335.8238-3-digetx@gmail.com>
Message-ID: <b5329801-ef0b-0c8d-aced-75c44f076f29@gmail.com>
Date:   Mon, 24 May 2021 13:20:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210523231335.8238-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.05.2021 02:13, Dmitry Osipenko пишет:
> Detach coupled regulator before dropping coupling count in order to allow
> detaching callback to balance voltage of regulators. This is needed by
> NVIDIA Tegra regulator couplers in order to bring back voltage to a value
> that is safe for reboot once regulators are decoupled.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/regulator/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index aae978c0c148..83571f83af04 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5084,6 +5084,13 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
>  
>  	n_coupled = c_desc->n_coupled;
>  
> +	if (coupler && coupler->detach_regulator) {
> +		err = coupler->detach_regulator(coupler, rdev);
> +		if (err)
> +			rdev_err(rdev, "failed to detach from coupler: %pe\n",
> +				 ERR_PTR(err));
> +	}
> +
>  	for (i = 1; i < n_coupled; i++) {
>  		c_rdev = c_desc->coupled_rdevs[i];
>  
> @@ -5111,13 +5118,6 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
>  		c_desc->n_resolved--;
>  	}
>  
> -	if (coupler && coupler->detach_regulator) {
> -		err = coupler->detach_regulator(coupler, rdev);
> -		if (err)
> -			rdev_err(rdev, "failed to detach from coupler: %pe\n",
> -				 ERR_PTR(err));
> -	}
> -
>  	kfree(rdev->coupling_desc.coupled_rdevs);
>  	rdev->coupling_desc.coupled_rdevs = NULL;
>  }
> 

I now realized that this is a bit too fragile approach. I'll drop this
patch in v3, there are better options of how to manage balancing on
detaching and this is not critical feature for now anyways.
