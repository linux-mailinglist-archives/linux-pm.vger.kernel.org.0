Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6041797A03
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfHUMzw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 08:55:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45684 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbfHUMzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 08:55:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so1640546qki.12
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Im1BQWra9a4owWUT8RgHgoF9dvQvnpJmlT3+mhtCgoE=;
        b=UPB2yYVqL11rw/8JcJtyRckbAB8TMsSQlLsO1sZnlRr7OWWSVn1qGXk/BbnNfmMqZz
         OFr1YF2LwDFVCVLWkYmhv9C02+s0BNku0oQHq7D7gT/N0dSBTpqVdTwszY7oYB14y8Hd
         LKz0zoyRRWj3SYH36glpC8nEWpP0ou8LpeiwA5Dk0cCgEZcxw+4fEBmGc9ajJXN8MD9P
         lutwenSIH3zEQL9FY8bLqd4ERg07A3f9Pxo2YDnYyr/JDZHOcouRXePg0b+aLoMMJMJL
         ShLp1EQ02Spd+FfLglFjKyxCrHotYSoUGWs34ptu2viXpyFw+jYDzRJwjq2Jox2JV/FV
         6WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im1BQWra9a4owWUT8RgHgoF9dvQvnpJmlT3+mhtCgoE=;
        b=IJSiyrbXMAa5ms+0fSM2nUr3CoFc9Z3CWpJHEGWW5aMlr1iMBcAMN9zahr3DSof7yd
         7vsA5MThbktb8bQ0KTOXhnb+D8YVbjaQSvQ8PBj5ooXAqKt+jorCMx7U74NYjO7tIFkm
         B3bDPrup5CKh+GHH6aS51zkoUNlcHj1V8ZwtsEDauvsXGe6sGojg1n0n6b4fDQJGU2an
         pdMFcTeooIwbYhxoqeHYe7k7imH0kY7Cx+v6kfYvb+8jLyV8JnhMpaIVcK4KGz7MQ1hJ
         2pqULmcxyp0kr/gNaTIS2NZRwAPVpyEisaJg8bPzwxod0N43ePX4qXhtPJSAhuyx6nff
         QqVg==
X-Gm-Message-State: APjAAAXxvGykuPD+arxVmjJgC2Pvy8vuVnpV9wWPco9+ySr9MZdTOAGG
        +ziyv6a32qZ6FUYuaC+vxsgPQwsyyo2CBZbyzyDbqQ==
X-Google-Smtp-Source: APXvYqzlnkcVZMpbi72pz29jEwoz0BYHgizVfpVGTVzXfD3RUN9g+U+ZiRfawCCMm8eorQ6/RoNiy9kXez3qEaScSkw=
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr7693095qkj.127.1566392151546;
 Wed, 21 Aug 2019 05:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <534b5017c2210ba8d541c206dace204d6617b4c9.1564091601.git.amit.kucheria@linaro.org>
 <5d577d77.1c69fb81.b6b07.83e6@mx.google.com> <CAHLCerMpWTVquyM3fYQxz-ZhDvnY276hfnZvZOmjV--cgm53UQ@mail.gmail.com>
 <5d5ab1e0.1c69fb81.d71db.1ca3@mx.google.com>
In-Reply-To: <5d5ab1e0.1c69fb81.d71db.1ca3@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 21 Aug 2019 18:25:39 +0530
Message-ID: <CAP245DV=pVF1oK2eFvK=iRng=Qxg=oDLWmHXBWtJH=VMxmmAvQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] drivers: thermal: tsens: Add debugfs support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 19, 2019 at 7:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-08-19 00:58:23)
> > On Sat, Aug 17, 2019 at 9:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > +
> > > > +static void tsens_debug_init(struct platform_device *pdev)
> > > > +{
> > > > +       struct tsens_priv *priv = platform_get_drvdata(pdev);
> > > > +       struct dentry *root, *file;
> > > > +
> > > > +       root = debugfs_lookup("tsens", NULL);
> > >
> > > Does this get created many times? Why doesn't tsens have a pointer to
> > > the root saved away somewhere globally?
> > >
> >
> > I guess we could call the statement below to create the root dir and
> > save away the pointer. I was trying to avoid #ifdef CONFIG_DEBUG_FS in
> > init_common() and instead have all of it in a single function that
> > gets called once per instance of the tsens controller.
>
> Or call this code many times and try to create the tsens node if
> !tsens_root exists where the variable is some global.

So I didn't quite understand this statement. The change you're
requesting is that the 'root' variable below should be a global?

tsens_probe() will get called twice on platforms with two instances of
the controller. So I will need to check some place if the 'tsens' root
dir already exists in debugfs, no? That is what I'm doing below.

> >
> > > > +       if (!root)
> > > > +               priv->debug_root = debugfs_create_dir("tsens", NULL);
> > > > +       else
> > > > +               priv->debug_root = root;
> > > > +
