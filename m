Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2C55CF93
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiF0GKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 02:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiF0GKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 02:10:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2B2AC7
        for <linux-pm@vger.kernel.org>; Sun, 26 Jun 2022 23:10:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31772f8495fso75198007b3.4
        for <linux-pm@vger.kernel.org>; Sun, 26 Jun 2022 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQ2Dxw++HMgq5p0HrLnSeRJ1jL6rntZ5qxteXg2OOsA=;
        b=dEXd5WiksWqmXl/lRgw6xnYEf+8PEjb/4WQELkZ+8x4O0EOqM46NGu2wOyxUcoZwTp
         kMy9svj4bMOzy+k82MOkAdS711RlUQsOICMVXAywlxGejFp9bZYowCrPo985KccGLuaZ
         uzhth84DcNFUmZGfM4mHR1dE7Ny7hrRMfCHfxNkovDgdMN450oACHRqmAUZcHrPv5k/k
         h0b2jOTDJDDolz+lw76m41iPBWQMLbOoYhN0vIa3/59h3GfM0TJUU4dOYdAsFzC3uLTr
         SzAftX4tc8mWiroIozGlCGJGN+/GuDr47DggWDzrc77JcAW0Bz/fuWZJs9vIUbvAgV7l
         bT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQ2Dxw++HMgq5p0HrLnSeRJ1jL6rntZ5qxteXg2OOsA=;
        b=4sQH942qOdHNPeA1fidaYQ9fZ2SsD694Nfir5ezXbPv6A3jfsH3YLjaOMpcwtEHK9+
         rbgEG+utkMcd0snwBE48RveQXRoqqhbzfYOomryDL9jUyQmdHRt7rKTFPVPhZCixnsWi
         LHTbhMJ7r9Atm7cNg1YFiEh45tA/i3MfFf35afhSZQDTnmSFSmkJnair3mGsDxZGXt2Q
         2wkNDm0uy+o9NBKKFgqWpsJrsGLrQ+xkAdFMY+0Ie1nGHNsau4ktknYy32QVAWYySfG8
         ofqtRItwDB8pBwNyejHsv1XCY2WOgbRUmKN5YtG/TZMvLg3FMUzEQJFbNOZlblmb/t13
         Gi0A==
X-Gm-Message-State: AJIora8yTObJWOOTdcn7rmqne4Qe9ZMSannq2td8aYKC1jPkajpVOr03
        pvGLaPW41PW8s1v/iIWHvxs07kaz8DzLy+rVGH8cug==
X-Google-Smtp-Source: AGRyM1tK81CS6l2XKH4wTftCJ5Z++dgb3CkETrOs5O/x2IoZczs8oVAR3bA8IsRKR8b1H5ReTXenoM9z/ZWinIx+Vf8=
X-Received: by 2002:a0d:ca16:0:b0:31b:7adf:d91 with SMTP id
 m22-20020a0dca16000000b0031b7adf0d91mr11086107ywd.455.1656310237874; Sun, 26
 Jun 2022 23:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
 <CACRpkdaXJh_Qc-DuD7SFsZPM9GBMUgnoufcFKsy3BPUYFHMHWQ@mail.gmail.com>
 <CAGETcx-io_5tVbRBfuB-qOwm4tV0A5FR82Q21Z1dJcLbAOkd=A@mail.gmail.com> <CACRpkdb1-F1CP0AAbS5FHoDRFdX-bS2m0NOfQm9nVcery+cW4Q@mail.gmail.com>
In-Reply-To: <CACRpkdb1-F1CP0AAbS5FHoDRFdX-bS2m0NOfQm9nVcery+cW4Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 26 Jun 2022 23:10:01 -0700
Message-ID: <CAGETcx85JYX2ktGvEWTUn60-BQ40-5w0SwKjHtSePDAt=DA7kw@mail.gmail.com>
Subject: Re: Default async probing for DT based systems
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 25, 2022 at 11:09 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jun 17, 2022 at 8:01 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Fri, Jun 17, 2022 at 1:21 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Thu, Jun 16, 2022 at 5:25 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > > Since fw_devlink=on is the default behavior and fw_devlink understands
> > > > approximately 24 DT bindings,
> > >
> > > How can I see which these are, in the kernel tree?
> >
> > device/of/property.c has an array of these binding handling functions
> > in of_supplier_bindings[].
> >
> > Most of the functions there are created using DEFINE_SIMPLE_PROP() or
> > DEFINE_SUFFIX_PROP() that's also in the same file.
>
> Thanks!
>
> We already have some device links in pin control, it's an opt-in for
> drivers, used e.g in drivers/pinctrl/stm32/pinctrl-stm32.c
> where you see
> pctl->pctl_desc.link_consumers = true;
> how does that
> play with this? Double device links at different levels?

Depends on what device you use for the supplier.

If it's the true device that probes and registers with the pinctrl
framework, then there won't be any double device links. It'll actually
be helpful because fw_devlink uses these attempts initiated by the
driver to confirm the dependencies it inferred from DT -- so when it
infers a cycle, it'll keep the links that drivers have attempted and
"ignore" the rest of the links in the cycle when it comes to probe
ordering.

If you use the devices the pinctrl framework creates on the gpio-bus
as the supplier for the device link, then yes, it'll be additional
device links. I'm not sure how useful they are on top of the ones
fw_devlink creates with the true device. If you don't need to do any
special suspend sequence for each of the individual gpio-devices, then
I'd recommend just creating one with the true device as the supplier.

-Saravana

>
> I had a patch to just enforce device links on all pinctrl resources,
> but it seemed over the top:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=consumer-link-enforce&id=73441cf773ed91bff0e7f66614d391b2514188bf
>
> Yours,
> Linus Walleij
