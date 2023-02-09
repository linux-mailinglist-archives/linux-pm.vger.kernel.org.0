Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FED691155
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 20:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBIT2f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 9 Feb 2023 14:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBIT2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 14:28:34 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C041110D2
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 11:28:33 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id sa10so9534993ejc.9
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 11:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FwE0bW1KYkVJ4AdtVx1Sfp6m9D6mmlF7/xjADI9XUY=;
        b=4fvqvpG5LqylHp4en6lN7S9XeRxtzn4gBZPg8mHBRj8ykV6IZZNSzbKwQ7Dpop3lO5
         IVD5GOP9WAK+wZJouSkQg/tP89TKDhT+ETnvjEwNBpI3wOZ/dgocXnfHPe9bz70o0QrW
         00Olm9g1EYK6XO7zZUcvTnZdvn4ddnfwTqrI/hWtIm4+ufaJFPp71fLfwJ0rQafjd3gT
         llyt/MTmNEq3l/uOfvVVtBiCiix7hPiU9ftXTLBTBq9RT6Ba8RrBXT5FUWXEBkuH3uJM
         ZkBKMGuC9wRsdw6ORk8wSbxIgV37VDIuEZqhv3W1LNAOeVoPQwT/cGZcdYHobTqO5a6k
         ZNXA==
X-Gm-Message-State: AO0yUKX4oYmp9mDfR4aGjqzqc2OulokDUJd3sbrUpfcskcLTvBkcEyCu
        Vy5O+k1HZ+xHp9GM6JaPVzAocVGwZaEtHituQSc=
X-Google-Smtp-Source: AK7set8Nglx1QBBK5LQToM1bm5Lp4AujtPpWifUVYVF38m9Dy5nMNfKJVrl3YLQ60Qhdcm/vc6rBAgWdiNk+l8fzqDw=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2940791ejb.274.1675970912427; Thu, 09
 Feb 2023 11:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20230208092654.551466-1-u.kleine-koenig@pengutronix.de> <20230208094451.wib7on57imsujbaj@vireshk-i7>
In-Reply-To: <20230208094451.wib7on57imsujbaj@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 20:28:21 +0100
Message-ID: <CAJZ5v0g=1fwpiBU2LBm+hU-xm2s+hjxXKb6UgABwzzD2uFPtJA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: davinci: Fix clk use after free
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 8, 2023 at 10:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-23, 10:26, Uwe Kleine-König wrote:
> > The remove function first frees the clks and only then calls
> > cpufreq_unregister_driver(). If one of the cpufreq callbacks is called
> > just before cpufreq_unregister_driver() is run, the freed clks might be
> > used.
> >
> > Fixes: 6601b8030de3 ("davinci: add generic CPUFreq driver for DaVinci")
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/cpufreq/davinci-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
> > index 2d23015e2abd..ebb3a8102681 100644
> > --- a/drivers/cpufreq/davinci-cpufreq.c
> > +++ b/drivers/cpufreq/davinci-cpufreq.c
> > @@ -133,13 +133,13 @@ static int __init davinci_cpufreq_probe(struct platform_device *pdev)
> >
> >  static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
> >  {
> > +     cpufreq_unregister_driver(&davinci_driver);
> > +
> >       clk_put(cpufreq.armclk);
> >
> >       if (cpufreq.asyncclk)
> >               clk_put(cpufreq.asyncclk);
> >
> > -     cpufreq_unregister_driver(&davinci_driver);
> > -
> >       return 0;
> >  }
>
> Rafael, please take this directly as the dependency patch will go via your tree
> too (the one that makes cpufreq_unregister_driver() return void).
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
