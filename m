Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F71047A
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 06:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfEAEWu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 00:22:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38536 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfEAEWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 00:22:50 -0400
Received: by mail-it1-f194.google.com with SMTP id q19so8382841itk.3;
        Tue, 30 Apr 2019 21:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLNLpr9McoqnZqM8qeAGoxcDpyWL0pd5yB3wHBmNQm0=;
        b=NmcLEQXlPhSFJDrg69XhaztQv9FwpJDoR3ICozL6BnfDa6JUamP72xKNEx/p3r2p1V
         Gp5r1ZL5TOKJsIELli3PI9U8zy01eMq4sLwrQbV3g0z9+xX/EebtoEH4fce6bBmnY0dr
         +3d0Az6GreLoBDM+9CK8lLRTxIepWhGuKvRcVgtfuJkeMd0oIvyXUPZgmcntHCTr9VJY
         XyS+lNGjz/DrxOCMiTo4b4XYfWYTOX9C7I7zr3srwgikzTicwM+azzDxKfhE4KFMd5YQ
         dcHc09zTm9WBcwywOLewvs2YuDOi3lwFFrfG5SOpQwesXt5uzRqTCQQJaTnsOz/0ngBD
         Bs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLNLpr9McoqnZqM8qeAGoxcDpyWL0pd5yB3wHBmNQm0=;
        b=lmyq/udZGBTQ8zlLOAZow9EJqO+7i6o16PnMwunyCSBbD7qtst2kF21Z1buCvRp2a2
         UipbqTQhvskaysfXNUT93kFTxoObCid8Cj56TW7U+es6wcNw/uECcLwOxuwkmpq571Sb
         oUh8OFdonD7XKWFNtPw0A2tZALRtD2VkheJMpGF6NKJfK+ZhwzlaYAuowfBZGxYC8r2E
         7Au4JNG6ndKJO1nVIgvvlp3j5HC1GK+W6CKZHI4j+tEPqMv79/74u9Bw7TrJwKL1aMvn
         ZU8kH/W28+ga4i1xm2ps64v7mHzWEAVXHVLtRADTZb4f9kundgaQLKNMHCGuFnQjNHWF
         3IyQ==
X-Gm-Message-State: APjAAAXiAoPoDw2RMbVVU2M2j6/1idKR9PXPBl67q/ZnUSIlaRgp0cya
        WvyoD8OSsq7jSA98HhFz0V2lAs94n3N0Ju8p/8Q=
X-Google-Smtp-Source: APXvYqxzb+WfoWfhy9nmR7qVPjfUguVHUWr1/2N/LZbAHqn+R00pTq8JbjmDBb1oH3gYFLQoydzOFrzrc++N9aTNUwE=
X-Received: by 2002:a05:660c:2c5:: with SMTP id j5mr6925933itd.154.1556684569670;
 Tue, 30 Apr 2019 21:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
 <20190501033434.18548-3-andrew.smirnov@gmail.com> <7002fe8e-7686-fe84-374f-766f99f8317d@infradead.org>
In-Reply-To: <7002fe8e-7686-fe84-374f-766f99f8317d@infradead.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 30 Apr 2019 21:22:38 -0700
Message-ID: <CAHQ1cqHnAS4kb76cTNfLX=YJsRT+dOJhwONGLCAdErh0KBTWyw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] power: supply: Add driver for Microchip UCS1002
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 8:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 4/30/19 8:34 PM, Andrey Smirnov wrote:
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index e901b9879e7e..c614c8a196f3 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
> >        Say Y here to enable support for fuel gauge with SC27XX
> >        PMIC chips.
> >
> > +config CHARGER_UCS1002
> > +        tristate "Microchip UCS1002 USB Port Power Controller"
>
> Please indent the tristate line with a tab instead of spaces.
>

OK, will do.

Thanks,
Andrey Smirnov
