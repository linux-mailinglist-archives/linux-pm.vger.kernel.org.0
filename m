Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2145B5F85
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiILRuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 13:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiILRuC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 13:50:02 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2518B26;
        Mon, 12 Sep 2022 10:49:59 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id j10so3976369qtv.4;
        Mon, 12 Sep 2022 10:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BUFxYbdRP3pfE5T89ET/KTl7QiTnnNALUuDIWRUP/cI=;
        b=NC2p5x5CKCF7tlDk54cnfuy/U6FQ7XAMBoU7rxRfpqDUYZZHmTUQWkq3E34yBIhPNx
         tgcMp7iMZKv6ESnL2Gk+tAMu15Eadw7R6ypjm5vxhddMCRT49c9qxPpzeyWcNGAjMG4s
         Vm8UQZz0wAvdF0b+AtH1gEqtjeZHWlGvWuc+0zaoRuwOJs6CFIHRxfQaAvQxV6L4+hwj
         SxPdSbHDkxcGxerMVzOm46uZKENZvRs44YfoAitEYyQaon+rfxR5Ts1//yTv+9PXdNdL
         a8G1ZiRWNkaRf5zUYtGEmt/dS77kbrJaLG8V8OsZWGGgbx5Icu/jMp1ZdBoHXlUEa5MR
         bt7Q==
X-Gm-Message-State: ACgBeo009vELMZehUAW5ThRypEAuLXUkQnHFpFNYL4NtEhL4/8hRR4cD
        bkehV2S+iygD1bszW5wl5XCbz6L/xQwEirjN
X-Google-Smtp-Source: AA6agR7eBxkabfG1co7lj82R3nnN8vRrbrkAdcSVT0s2hgxSvlGCu1ybdwDC1T/GKr4SlTaZfZG3og==
X-Received: by 2002:ac8:4e87:0:b0:343:6249:1810 with SMTP id 7-20020ac84e87000000b0034362491810mr24246410qtp.117.1663004998017;
        Mon, 12 Sep 2022 10:49:58 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id g21-20020ac84695000000b0035ba5db657esm6500245qto.76.2022.09.12.10.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 10:49:57 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3378303138bso110345777b3.9;
        Mon, 12 Sep 2022 10:49:57 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr22512692ywc.316.1663004997158; Mon, 12
 Sep 2022 10:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus> <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus>
In-Reply-To: <20220909154254.xy4jvj6ybpuynghc@bogus>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Sep 2022 18:49:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
Message-ID: <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Peng Fan <peng.fan@nxp.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sudeep,

On Fri, Sep 9, 2022 at 4:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > > >
> > > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > > it or is there some platform/driver that is really relying on it?
> > > >
> > >
> > > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > > Not sure if it is still used or not.
> >
> > Okay! Maybe Nico remembers more, as he authored the patch...
> >
>
> May be, or even check with Renesas team who tested his patch.

I'm not aware of Renesas platforms using SCMI...

> > Normally it's best decided on a platform basis, whether it really
> > makes sense to use the GENPD_FLAG_PM_CLK. As the scmi power domain is
> > a cross platform power domain, it worries me that we lose some needed
> > flexibility, which is likely to make it more difficult to use it for
> > some platforms. Also note, the main point behind GENPD_FLAG_PM_CLK,
> > was just to consolidate code.
> >
>
> I agree and share similar concern.
>
> > That said, I decided to do some research, by looking at the DTS files
> > in the kernel. So far, there is only Juno and the imx8 based
> > platform(s) that are using the scmi power domain.

Juno and imx8 are not Renesas...

> >
>
> Yes but there are few without any DTS upstream that I know.
>
> > >
> > > > >
> > > > > we use scmi power domain, but not use scmi clk, but with upper commit, the clk is prepared
> > > > > when pm_clk_acquire.
> > > > >
> > >
> > > Is this based on latest SCMI clocks that support atomic or older one
> > > which doesn't. If latter, I see pm_clk_acquire doesn't actually call
> > > prepare as if clk_is_enabled_when_prepared(clk) = true. Do you see have
> > > issue ?
> >
> > It doesn't really matter if we would be using an atomic clock or not.
> >
>
> No what I meant is pm_clk_acquire doesn't call prepare as clk_is_enabled_when_prepared
> is true for scmi clocks(non atomic).
>
> > The problem is that when using GENPD_FLAG_PM_CLK, during runtime
> > resume (genpd_runtime_resume) we end up calling pm_clk_resume(), but
> > prior invoking the consumer driver's ->runtime_resume() callback. In
> > other words, the clock(s) will already be prepared and enabled when
> > the driver's ->runtime_resume() callback gets invoked. That certainly
> > isn't going to work for all cases.
> >
>
> Any specific reasons ? Sorry I am missing to understand why that would
> be an issue ?
>
>
> [...]
>
> > In my opinion we should really try to move away from using
> > GENPD_FLAG_PM_CLK for the scmi power domain. I can prepare a patch, if
> > you think it makes sense?
> >
>
> As along as Renesas is fine with that, it should be OK, but doesn't removing
> that flag means we can drop {attach,detach}_dev callbacks too as they are just
> adding clocks and without the flag it is useless. Sounds like we must revert
> the patch completely IIUC.

Hence no objection from me ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
