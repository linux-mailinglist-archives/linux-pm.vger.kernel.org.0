Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE868C517
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBFRsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 12:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBFRs3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 12:48:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E454B47E
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 09:48:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so7986412wms.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/anldemhvQCHTvqMsif8/2pVa3TK1Qaat7JGnYbNwHg=;
        b=KGtc+9RDssfQr/bOxehnt98SONg3PD3der/UXC9mxNeuyx5RBf7/0AgWZPn3kAemC0
         ZBIWk32xs4d3i97Q6GAL93N/snGtRaAFxjXycjFcc/D5Al/G3jmU6WJIk4cKj0QBAiSY
         6Au+V0CiLYDzw+pUx5n/hoty4UJrIt9F29lb1J2872SJ2CX2SjcbGQr9+nedEo+ugspc
         fUg3o+2as+LP6KIF60FZQum2rMwrHWuu53t0zYi+nrm8X1y4/ygJ70068cmggPxJLi5R
         mO14gEnLi2Cbi/yNZOdIBoOojiJQ8vW3aVWSVOe6n3Zx1OVXbjfXUiVI97JiksLg+RwD
         719Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/anldemhvQCHTvqMsif8/2pVa3TK1Qaat7JGnYbNwHg=;
        b=0Xfzr0CjlcMCOgApMX/erm5Qi63P2K6ymL2DaToeu9VkrYiCHnYPvTpvEXRJUoiWKg
         29pzF+6inXRN8KBLgjtUkMecun+MDiFDHdYUSxd7+sOhlevMPhiKwEd5YUfYmaucJOhk
         sxDNusqP+47ao84hRMSxzHBt8Xj6H5kZE50O8xxMOGKysu/4GXYRGIzqIaosRmN3CHLF
         hBh+SzO7aatnDqXJNeDwWl8T0e8bTUhfhSa3Dnzh9hLFGil3ZYfPMfGVZJBzICYWJasI
         wt6M7XQ9gjKoYu4Iuv7xhFEqBAIs2anescz4wNxREW4aQUZ2ClwsHnq9OOVA38PUlwmT
         fCyg==
X-Gm-Message-State: AO0yUKXzbqXhsPGnXoQUxwA1tIS4kX4B5fuyxvIMQMkWB+96MHRgy4Me
        OHMLseOrZ3mvS8mor3gPfjVhDw==
X-Google-Smtp-Source: AK7set9NVlbSs8cbsuA0DAwWSV+t5bZrjpDkk/dKeQJd+N1s5ukrMqlxWUX1MN3nCdW8vPK9YDDIuA==
X-Received: by 2002:a05:600c:4d09:b0:3df:e549:bd27 with SMTP id u9-20020a05600c4d0900b003dfe549bd27mr582303wmp.6.1675705706167;
        Mon, 06 Feb 2023 09:48:26 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003db0ee277b2sm16826223wmb.5.2023.02.06.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:48:25 -0800 (PST)
Date:   Mon, 6 Feb 2023 19:48:23 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y+E9Z+/+eCpPK6DE@linaro.org>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org>
 <Y+E3T6bozU1K2sFb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+E3T6bozU1K2sFb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


CC'ed Saravana

On 23-02-06 17:22:23, Matthias Kaehlcke wrote:
> On Mon, Feb 06, 2023 at 06:31:21PM +0200, Abel Vesa wrote:
> > On 23-02-02 18:24:15, Matthias Kaehlcke wrote:
> > > Hi Abel,
> > > 
> > > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > > > Currently, there are cases when a domain needs to remain enabled until
> > > > the consumer driver probes. Sometimes such consumer drivers may be built
> > > > as modules. Since the genpd_power_off_unused is called too early for
> > > > such consumer driver modules to get a chance to probe, the domain, since
> > > > it is unused, will get disabled. On the other hand, the best time for
> > > > an unused domain to be disabled is on the provider's sync_state
> > > > callback. So, if the provider has registered a sync_state callback,
> > > > assume the unused domains for that provider will be disabled on its
> > > > sync_state callback. Also provide a generic sync_state callback which
> > > > disables all the domains unused for the provider that registers it.
> > > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > > 
> > > > This approach has been applied for unused clocks as well.
> > > > With this patch merged in, all the providers that have sync_state
> > > > callback registered will leave the domains enabled unless the provider's
> > > > sync_state callback explicitly disables them. So those providers will
> > > > need to add the disabling part to their sync_state callback. On the
> > > > other hand, the platforms that have cases where domains need to remain
> > > > enabled (even if unused) until the consumer driver probes, will be able,
> > > > with this patch in, to run without the pd_ignore_unused kernel argument,
> > > > which seems to be the case for most Qualcomm platforms, at this moment.
> > > 
> > > I recently encountered a related issue on a Qualcomm platform with a
> > > v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> > > highest corner until sync_state"). The issue involves a DT node with a
> > > rpmhpd, the DT node is enabled, however the corresponding device driver
> > > is not enabled in the kernel. In such a scenario the sync_state callback
> > > is never called, because the genpd consumer never probes. As a result
> > > the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> > > system suspend, which results in a substantially higher power consumption
> > > in S3.
> > 
> > If I get this correctly, one of the providers is missing (doesn't matter
> > the reason), in which case, your kernel needs that driver, period. There
> > is no reason why you would expect the consumer to work without the
> > provider. Or, you could just remove the property in the devicetree node,
> > the property that makes the consumer wait for that provider. Anyway, you
> > should never end up with a consumer provider relationship in devicetree
> > without providing the provider driver.
> 
> I would agree if it was actually a provider that's missing, however it's a
> 'missing' consumer that prevents the sync_state() call.

Oh, my bad.

Still, why would you keep the consumer node enabled in devicetree if you don't
intend to allow its driver to ever probe?

> 
> > > I wonder if genpd (and some other frameworks) needs something like
> > > regulator_init_complete(), which turns off unused regulators 30s after
> > > system boot. That's conceptually similar to the current
> > > genpd_power_off_unused(), but would provide time for modules being loaded.
> > 
> > NACK, timeouts are just another hack in this case, specially when we
> > have a pretty reliable mechanism like sync_state.
> 
> It does not work properly unless all consumers are probed successfully. It
> makes sense to wait some time for the consumers to probe, but not eternally,
> it's perfectly valid that a driver for a (potential) consumer is not enabled.

Usually, if you have a consumer devicetree node that you consider it
should not probe, you should consider disabling that node in your board
dts, specially if you don't intend to provide its driver.

Again, timeouts are bad all-around. What happens if rootfs doesn't get
mounted in time? Will 30 seconds be enough for every scenario? What
happens if I want to load the driver (module) for a consumer a day after boot?

IMHO, I think even the regulator_init_complete should be switched to some sync
state approach.
