Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103866A3E56
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 10:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjB0JaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 04:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjB0JaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 04:30:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D228A61
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 01:29:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso5540781pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 01:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=orrUFQepqPS8GeN9rfXGjnnQp/FMyS0GGVp2Umis7mI=;
        b=ylnXtXLbC4YroRtValaCEdd6gZwQ3YJY+oB2gPMozZn7oPwb955TfjYBE9zURSS8Cq
         qq/8Tv+vuqPVyJ/MlPTqoS3jjViiuM5zUIY0VOEEbmoWdKRXoenn6pECdvijZTPcy0/F
         IvIzq+exhHeIO8Uml202DAWV7VSb1Ovd0rktQkCjnRA6uhDMjAd8sffqTTme/CZNzkBg
         jIx20wURc6GaBTEoSiUu81pa0lH0Tm9ZnLoi/MCdSwxZRlhcHYlwEi/lI8E6I3ckS2yG
         5kYqrrx39kzBKEgpYFtjFdV5A5bjUdKQlQposmCedhX9B43tPkB2rzBS2mqRXF0mc0zr
         UBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orrUFQepqPS8GeN9rfXGjnnQp/FMyS0GGVp2Umis7mI=;
        b=U/2oii48McJckcDjCuvVZB9u4d8GEl2CdVCLiKv0U2qY/HloecewALCfyP0+GETk5h
         pPu24isx7+0lU9gePMVh+BOCLGAE8bHDW2I08bxchj43KO98kfaMd5A6Dht3q+yfjfMm
         8EeNMKdYoIoKKjoPmsluRnT2NlUQ+VFN6ilnZl+8Un1uWjH/TjRzSzd0KZrBdRksi8oR
         9wbFI+cWaeZQ8ZWA+RYtsh5c+1tYZxLe4ogG6m683uo8zA14MBC/ieUkRjfSSepctwMX
         6XX4kvN8w07wn7s4MH4jRCFvBoALMxJbM/EGwvIxW2EYILEiovArlTOIbBSYeOP++Bqg
         xrZg==
X-Gm-Message-State: AO0yUKVT/OBaE8cDy3R82rlH0yO2bW1a3HThxB+ycqXxoyxGl2FqZy7O
        fbPNlo8Z3L03n0U70sqROe0xrg==
X-Google-Smtp-Source: AK7set/zj4mcmcU9rSQGoc5y7aZGnjUK6AnhP3Dl9Qd3GmqCjAR0w1nC3wYbit6WJwoVrxA+3yFMNw==
X-Received: by 2002:a17:902:d488:b0:199:2932:615e with SMTP id c8-20020a170902d48800b001992932615emr29016356plg.18.1677490196173;
        Mon, 27 Feb 2023 01:29:56 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b0019cb8ffd592sm4118341pld.163.2023.02.27.01.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:29:55 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:59:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
Message-ID: <20230227092953.ekh72r5h6xcqgusn@vireshk-i7>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
 <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
 <20230224021713.stpcykx2tjkjwyti@vireshk-i7>
 <Y/hyf+/EqEeTu436@niej-dt-7B47>
 <20230227042349.3p2ijo6s6yyqc267@vireshk-i7>
 <CABymUCNBkr_65JHNVfbUGjxs6rhnj=eUyZ+5j6VtiDwqzLYtcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABymUCNBkr_65JHNVfbUGjxs6rhnj=eUyZ+5j6VtiDwqzLYtcA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-02-23, 17:21, Jun Nie wrote:
> Sorry for not expressing it accurately. I should say devfreq devices
> pointers, just
> devfreq_virt_devs vs genpd_virt_devs. Then you know why I add devfreq-devs
> dts nodes below.

Won't something like dev_pm_opp_set_clkname() would be enough here too ? We
already do this kind of work for clks and regulators.

Having power domain specific information within CPU nodes isn't a requirement of
the OPP core, but the general requirement of genpd core instead.

-- 
viresh
