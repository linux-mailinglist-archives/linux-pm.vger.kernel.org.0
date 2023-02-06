Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C468C47C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 18:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBFRW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 12:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBFRW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 12:22:27 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4459D2
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 09:22:25 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id j12so1485042ila.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 09:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw/+BtW2ezyMBpb+PL+RAaJ796Lnvw8RBmFntpG4kQ0=;
        b=Jsch1u1P08aMlSvbUW0czvFTL5qQZ5sk+5ctcwOSfnRo276WKpFm1yptSbGImgkR7e
         hcI/+oSKB95NdrVTeVFmvmNAtcjz1cmgqhCBAXGH/PJFD2fuCIhGGvlsXyb4peVEn4HH
         z4/xzFn972iPTC2/6TBrpeaw7r9We6QSqe3f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw/+BtW2ezyMBpb+PL+RAaJ796Lnvw8RBmFntpG4kQ0=;
        b=2COhG1oYATr+FIVcJXJtTKv8onVkjOn2GzrTIAPEQgvBMKRRfNfoc7QwTw2HSy1Wg6
         Vm5rfOu9G4vCqYMk7Z/EuY5cKauqymb6GI8Mw7cGOoFlQXbiCM6A5FKxaWXLOaicS6Fs
         6Rterm08gJXvkU8QpQzm/T9mpOBzto9zhJeqIpIV67tqbt0Up8pRZMRUO1H3K6bcf2VO
         tlJzkzG0fuJ+9l9bGC+BUsCz2CubFIQEEh8dxU8a4Hj2kNOJw0CFtup3A5mbk1qmH3Ua
         jeA3a6VPrrRP5FT4k2GB3L/DkJRpAE71y3jMBbSSpt6YGSqz3FJg/c9Uz31xxxAa0E1F
         ONcQ==
X-Gm-Message-State: AO0yUKWZKvDRrtWiyZ6NrIfai5BAcAu7uipx+SVHujUUd2DmCn90lr8H
        pG1ICiXuT8CwXPkaGAAPs6EeEA==
X-Google-Smtp-Source: AK7set+9giy7MtVsRnVDSqMFV1NNAPeUBq+V7Zq6M2XdFeAjtjhTtSDqfoF4aJmoGQhN19DAYh3L5g==
X-Received: by 2002:a05:6e02:154f:b0:313:d914:e544 with SMTP id j15-20020a056e02154f00b00313d914e544mr485892ilu.23.1675704144937;
        Mon, 06 Feb 2023 09:22:24 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id i33-20020a056638382100b003a22298d014sm3778985jav.25.2023.02.06.09.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 09:22:24 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:22:23 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Abel Vesa <abel.vesa@linaro.org>
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
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y+E3T6bozU1K2sFb@google.com>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+ErWTyV8CnE3Hl+@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 06, 2023 at 06:31:21PM +0200, Abel Vesa wrote:
> On 23-02-02 18:24:15, Matthias Kaehlcke wrote:
> > Hi Abel,
> > 
> > On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
> > > Currently, there are cases when a domain needs to remain enabled until
> > > the consumer driver probes. Sometimes such consumer drivers may be built
> > > as modules. Since the genpd_power_off_unused is called too early for
> > > such consumer driver modules to get a chance to probe, the domain, since
> > > it is unused, will get disabled. On the other hand, the best time for
> > > an unused domain to be disabled is on the provider's sync_state
> > > callback. So, if the provider has registered a sync_state callback,
> > > assume the unused domains for that provider will be disabled on its
> > > sync_state callback. Also provide a generic sync_state callback which
> > > disables all the domains unused for the provider that registers it.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > > 
> > > This approach has been applied for unused clocks as well.
> > > With this patch merged in, all the providers that have sync_state
> > > callback registered will leave the domains enabled unless the provider's
> > > sync_state callback explicitly disables them. So those providers will
> > > need to add the disabling part to their sync_state callback. On the
> > > other hand, the platforms that have cases where domains need to remain
> > > enabled (even if unused) until the consumer driver probes, will be able,
> > > with this patch in, to run without the pd_ignore_unused kernel argument,
> > > which seems to be the case for most Qualcomm platforms, at this moment.
> > 
> > I recently encountered a related issue on a Qualcomm platform with a
> > v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> > highest corner until sync_state"). The issue involves a DT node with a
> > rpmhpd, the DT node is enabled, however the corresponding device driver
> > is not enabled in the kernel. In such a scenario the sync_state callback
> > is never called, because the genpd consumer never probes. As a result
> > the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> > system suspend, which results in a substantially higher power consumption
> > in S3.
> 
> If I get this correctly, one of the providers is missing (doesn't matter
> the reason), in which case, your kernel needs that driver, period. There
> is no reason why you would expect the consumer to work without the
> provider. Or, you could just remove the property in the devicetree node,
> the property that makes the consumer wait for that provider. Anyway, you
> should never end up with a consumer provider relationship in devicetree
> without providing the provider driver.

I would agree if it was actually a provider that's missing, however it's a
'missing' consumer that prevents the sync_state() call.

> > I wonder if genpd (and some other frameworks) needs something like
> > regulator_init_complete(), which turns off unused regulators 30s after
> > system boot. That's conceptually similar to the current
> > genpd_power_off_unused(), but would provide time for modules being loaded.
> 
> NACK, timeouts are just another hack in this case, specially when we
> have a pretty reliable mechanism like sync_state.

It does not work properly unless all consumers are probed successfully. It
makes sense to wait some time for the consumers to probe, but not eternally,
it's perfectly valid that a driver for a (potential) consumer is not enabled.
