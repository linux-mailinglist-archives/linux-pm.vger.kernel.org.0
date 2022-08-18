Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF83599136
	for <lists+linux-pm@lfdr.de>; Fri, 19 Aug 2022 01:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiHRXbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Aug 2022 19:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiHRXbD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2022 19:31:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC0DDA87
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 16:31:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gk3so5937305ejb.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Rzm+KtIn754eMjCxQ82CIRKVVENOEzFQwaupdFFD6rg=;
        b=XlDDcYz7LkA3r9vk4JO6QqADVToOD+VhNaUP+9CpFskuaiTzzxtBqRPuyWO+AI8iu3
         OK3BAJujEr552Csc777cr9/3osRvBPGE++t6VCyDNk9XHRlWxwEk81fUpLrjFovfYNQD
         u62b13bTPH+lPwlL0RxEEx4zcZpHNydQjhhUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Rzm+KtIn754eMjCxQ82CIRKVVENOEzFQwaupdFFD6rg=;
        b=Ap6k8qvFl8QttH9yp4xRB+kN2F6aMsdsJkjotf3Bxk7n42sZcZyhLDzJfO3ZgrwVvA
         S8ZZc5uV2XTmV93fSGGsdqqfyKykGJNgJQHIy/3VfKKT+92d4bQoC2n0Rn/F8epz3ThA
         BMzurUyKhuSa2kqwPSoH4x4pxCaFEyMTwhPjGxvulAUQD/z/ifv8XWO+asFqij93mj+6
         pYr4ru19ByET4/3faacRivn56WmKFleFGdhoppwz8gExFfOY/D+0wPZGjptp8Pkg75Av
         SpzmLT44auzsR91+RJq0bSTsdgmdM9WsPvVnKJ5h4qWFF+u2F9L1qDwG5Txg9hweT+ti
         d67A==
X-Gm-Message-State: ACgBeo1vLt4agH4RYkHsccimQhiEs7mqt6CY0jH/dQ+JxQQRbrztAeMY
        9yGO1UoM1zk6wGovKc2lJ8OSTYiHbbwPZf09
X-Google-Smtp-Source: AA6agR6BTll44EnIW7FI+qM21J2W8N8A8F4/LRQneFyUmNxMvRCpIkKxiZ7c81BZfj2fl5daTABkNg==
X-Received: by 2002:a17:906:fd8d:b0:73a:7424:6c0d with SMTP id xa13-20020a170906fd8d00b0073a74246c0dmr3198701ejb.425.1660865461082;
        Thu, 18 Aug 2022 16:31:01 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906368800b006ff0b457cdasm1463438ejc.53.2022.08.18.16.31.00
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 16:31:00 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id n7so3363807wrv.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 16:31:00 -0700 (PDT)
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id
 1-20020a056000154100b00222cf6518d7mr2611729wry.659.1660865460285; Thu, 18 Aug
 2022 16:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220727185012.3255200-1-saravanak@google.com>
 <Yvonn9C/AFcRUefV@atomide.com> <CM6REZS9Z8AC.2KCR9N3EFLNQR@otso>
 <CAGETcx_6oh=GVLP7-1gN_4DW7UHJ1MZQ6T1U2hupc_ZYDnXcNA@mail.gmail.com> <CM7HN6H9EAN4.2008QGJVIO14X@otso>
In-Reply-To: <CM7HN6H9EAN4.2008QGJVIO14X@otso>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Aug 2022 16:30:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYVwaXZxqUKAuM5c7NiVjFz5C6m6gAHSJ7rBXBF94_Tg@mail.gmail.com>
Message-ID: <CAD=FV=XYVwaXZxqUKAuM5c7NiVjFz5C6m6gAHSJ7rBXBF94_Tg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Bring back driver_deferred_probe_check_state() for now
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel-team@android.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Aug 16, 2022 at 6:31 AM Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Hi Saravana,
>
> On Tue Aug 16, 2022 at 1:36 AM CEST, Saravana Kannan wrote:
> > On Mon, Aug 15, 2022 at 9:57 AM Luca Weiss <luca.weiss@fairphone.com> wrote:
> > >
> > > On Mon Aug 15, 2022 at 1:01 PM CEST, Tony Lindgren wrote:
> > > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > > More fixes/changes are needed before driver_deferred_probe_check_state()
> > > > > can be deleted. So, bring it back for now.
> > > > >
> > > > > Greg,
> > > > >
> > > > > Can we get this into 5.19? If not, it might not be worth picking up this
> > > > > series. I could just do the other/more fixes in time for 5.20.
> > > >
> > > > Yes please pick this as fixes for v6.0-rc series, it fixes booting for
> > > > me. I've replied with fixes tags for the two patches that were causing
> > > > regressions for me.
> > > >
> > >
> > > Hi,
> > >
> > > for me Patch 1+3 fix display probe on Qualcomm SM6350 (although display
> > > for this SoC isn't upstream yet, there are lots of other SoCs with very
> > > similar setup).
> > >
> > > Probe for DPU silently fails, with CONFIG_DEBUG_DRIVER=y we get this:
> > >
> > > msm-mdss ae00000.mdss: __genpd_dev_pm_attach() failed to find PM domain: -2
> > >
> > > While I'm not familiar with the specifics of fw_devlink, the dtsi has
> > > power-domains = <&dispcc MDSS_GDSC> for this node but it doesn't pick
> > > that up for some reason.
> > >
> > > We can also see that a bit later dispcc finally probes.
> >
> > Luca,
> >
> > Can you test with this series instead and see if it fixes this issue?
> > https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
> >
>
> Unfortunately it doesn't seem to work with the 9 patches

I also tried with the 9 patches, plus an extra fix that Saravana
provided. They didn't fix my use case either. Do we want to land the
reverts as a stopgap so that people aren't broken?

For reference, the device tree for the device I'm testing on is
`arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts`. The device
that's not probing is the bridge chip, AKA 2-002d. Presumably
something about the bridge chip cycles is confusing things since the
remote endpoint that sn65dsi86 needs is actually a child of sn65dsi86
(the panel).

-Doug
