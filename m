Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51EC68E74B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 06:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjBHFF1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 00:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHFF0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 00:05:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1D27495
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 21:05:26 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q9so11919624pgq.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 21:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ya5gJFL+sholpFu2gVvhEQXkb61wVgNoGrsK8xi1Z7M=;
        b=YjTsp9kdEz13Y1GNS0O5pGEyWSuzSogMDi4e7ZZ7iv+IZANa948+CJPU+/06uYdiuI
         Gghb9yPK7hJNXzFNQ8ZfboZrNIcDAIhcUwDk3RZYsxZsLFbj9LctlgfufzZINBRdA8Xb
         SFapInnCj+0ungZBt7qV71G0MxFzBnw4U6krmO22nfdS7qe1F9BjFw3E5IXM7Aiyb3a1
         VW0Nd6hy1INXQ8Sx3iNmy7sGVZ2LxS8Oq4s+Dudnzi6YcZIab79I78dHNFYysALOEQ/j
         1sVe9PHlgzBQz1mAJURvaLQ5wJRIrFz6NP/d/9Q+cHPwjZVTkdIhguBLPi3UtOJy/ul1
         CukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ya5gJFL+sholpFu2gVvhEQXkb61wVgNoGrsK8xi1Z7M=;
        b=6bvpy1Zc34+207p5dCeob/WsVpdtuPdOicjLKnSQgffN8GfLO1jOAVDllUE1QdyOyy
         AS6kov+RlL1RVGFHVlXRITl9aTWfojDEguBXo9Gh3oRyvsXyyaIKlTRLSs+ipVCcLO1D
         fWVtLuX+rI2ncHhdV3NHVSuEOpvUW5OdpJRj3z+15TRA1xjVxtk2TqqEaDaXvS45ID3p
         zLEgjSleaTtecWn1hEThB5RKGYnWFO1I2GAcQwz6/eUUowDP8bSmXbzyxIx5sDVleOh1
         BsIE2rP9UWZ91cQr2PRjzedz5qfRMu+K4t2p+Mu3sNONAwiKd4IBxu3BgUVFDuMubS45
         a6DA==
X-Gm-Message-State: AO0yUKVL5K98RRPizTKSZ9jxpinNXTnox+02JsmXZYULbAQPTconrg35
        5fEi7JGOWyVn5WcesyIpdYMaGg==
X-Google-Smtp-Source: AK7set9UuA7k0BjdlRO0q39ZKPIN4H6BAK2nzgdoKHGELVuwsO4MfgZ2/oEHq4b2N3zB9KZnbyJYyQ==
X-Received: by 2002:a62:1a89:0:b0:594:26a7:cbd2 with SMTP id a131-20020a621a89000000b0059426a7cbd2mr875118pfa.8.1675832725646;
        Tue, 07 Feb 2023 21:05:25 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id x14-20020aa793ae000000b005a6cb51f240sm2867924pff.109.2023.02.07.21.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 21:05:25 -0800 (PST)
Date:   Wed, 8 Feb 2023 10:35:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] cpufreq: Make cpufreq_unregister_driver() return void
Message-ID: <20230208050523.p6437bes6cmpd33k@vireshk-i7>
References: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-02-23, 20:59, Uwe Kleine-König wrote:
> All but a few drivers ignore the return value of
> cpufreq_unregister_driver(). Those few that don't only call it after
> cpufreq_register_driver() succeeded, in which case the call doesn't
> fail.
> 
> Make the function return no value and add a WARN_ON for the case that
> the function is called in an invalid situation (i.e. without a previous
> successful call to cpufreq_register_driver()).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 +----
>  drivers/cpufreq/cpufreq.c             | 8 +++-----
>  drivers/cpufreq/davinci-cpufreq.c     | 4 +++-
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 4 +++-
>  drivers/cpufreq/omap-cpufreq.c        | 4 +++-
>  drivers/cpufreq/qcom-cpufreq-hw.c     | 4 +++-
>  include/linux/cpufreq.h               | 2 +-
>  7 files changed, 17 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
