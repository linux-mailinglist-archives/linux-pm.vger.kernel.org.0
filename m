Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955CD3D1322
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhGUPUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbhGUPUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 11:20:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61568C061575;
        Wed, 21 Jul 2021 09:00:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t3so3646240ljc.3;
        Wed, 21 Jul 2021 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xYvzpqdQzYRHWBJ/mOAt8jgjkEXxH5jvUmBRluaMTeo=;
        b=lXckPDsZgcHvjpdUKcuhK2pmpmsaWXYwY9YcDq6Eg+1Tme3O5Mqf6SQgSJwrsVqLlS
         428Bl/VAltWfnTm9x54MpjIE+5dnumogxdkxK7mQDbuIXvxRSdgwSoaT0KCDSL74WCvy
         2ZcT+hmCs6CJ2HlpT9zcGPK72ZlY/z5wTRkF1Dow3aoIvam1fsP1fjVHGb6jE/MIO/6i
         zDO8fVB7WD+kz2kZDqsWeV4YT/Qb4C17Z1myDFFRTS7rW0bymf5ZTXBWGawyvCXXtnkN
         DUrhUNtaZdakBT7x+neAv0XC5j52zGbKs9XSznSFPmNYZ+F/Vu+T6CAEfCyDoit5HvG6
         FqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xYvzpqdQzYRHWBJ/mOAt8jgjkEXxH5jvUmBRluaMTeo=;
        b=YJVWXg2saiqXqWSg5J57ejNG6uA9HX8y7oOfz5Wyh1hICuaccMViJO2uFPB7QuUK3S
         SfFJxwkVK3ux+gCufjrnHy+S5hQS//6yo5ATxIH64z8KO2bgHvsEK+K4x97xxmhLvLcw
         h1MQpeLOQKkRePywco6dMAGwaTOcFKQLtXBRCKE1cWUDYa385hX/o6gSiXjIFk4k048f
         upji46qQNdD08tPj3bHgscP7NhnOUuDt+Dq2V1Q+z6YvalQJvEt6R36R7x0fZoa4aEHa
         4nfR4xO8Z3IpeCbIvFncJ8MGuscY4R2tAPnfehs6vnI9a5SZTysiBapkdEUcr4gcvC01
         Clpw==
X-Gm-Message-State: AOAM532/8k41L5gmxDFp22Zd5N6qikqXeslWgpc3R9M0GQLepz+AOxfY
        L5K9Obe4BVcsptqYuyHJNF6J6551M3U=
X-Google-Smtp-Source: ABdhPJxFFjYPHqYYPD6njAkLd+IqK/MWpNBrhsLLDRj6fDNzdYh4XT3heHScRJpvLEthwifWUxetHg==
X-Received: by 2002:a2e:8742:: with SMTP id q2mr17188338ljj.216.1626883246224;
        Wed, 21 Jul 2021 09:00:46 -0700 (PDT)
Received: from [192.168.2.145] (46-138-100-70.dynamic.spd-mgts.ru. [46.138.100.70])
        by smtp.googlemail.com with ESMTPSA id t17sm1949519ljk.102.2021.07.21.09.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 09:00:45 -0700 (PDT)
Subject: Re: [PATCH v7 24/37] soc/tegra: fuse: Enable fuse clock on suspend
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20210701232728.23591-1-digetx@gmail.com>
 <20210701232728.23591-25-digetx@gmail.com>
Message-ID: <c4549652-ab18-7b69-c684-b25ecab223bf@gmail.com>
Date:   Wed, 21 Jul 2021 19:00:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701232728.23591-25-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2021 02:27, Dmitry Osipenko пишет:
> +static int __maybe_unused tegra_fuse_resume(struct device *dev)
> +{
> +	int err;
> +
> +	/*
> +	 * Critical for RAM re-repair operation, which must occur on resume
> +	 * from LP1 system suspend and as part of CCPLEX cluster switching.
> +	 */
> +	if (fuse->soc->clk_suspend_on) {
> +		err = pm_runtime_force_resume(dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra_fuse_suspend(struct device *dev)
> +{
> +	int err;
> +
> +	if (fuse->soc->clk_suspend_on) {
> +		err = pm_runtime_force_suspend(dev);
> +		if (err)
> +			return err;
> +	}

I just noticed that something gone wrong with this patch, the condition
should have been inverted. I'll fix it in the next version.

I may also try to factor out these fuse and some other patches which
could become a 5.15 material.
