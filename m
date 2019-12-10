Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AC11916A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 21:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLJUBv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 15:01:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40894 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJUBr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 15:01:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id c93so17079908edf.7
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 12:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/R0DvHO32Ps1xRQleCzKMKFqLHiFsSU0YTem1kX0McY=;
        b=R7H1U1qRykpKlz90guDfnfMLQu+EzMsrV2O6YkM4xhmZeMcLM57ApewNRgw7I3oxKI
         2aAD35/rc6ipU1JVj4R7fnWWDXdfU60Ru7OkIh/gvKcGZOMCsZoTifF7aVmY87MT6hgE
         dD5ngP3bxwvgxaUKGXlHDjhdzIOD2MYqyaZAQ0zNBWoe41+9R24H9mu0HoZ73/j1dZHO
         1e1NADmg1PX1InTdZK26A9BHbzzbv9g+wwZC320VhTgoMhgDSR7ws8a9GUG3L9eiWd/C
         XjXyLoPqpEfT9KeiRzpCp3r467r5KBUq+K4z3zpDpkHtZFXjE071oLAqXrPbaYl//h7O
         M3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/R0DvHO32Ps1xRQleCzKMKFqLHiFsSU0YTem1kX0McY=;
        b=Etozm8D11GE25lAhFhaN5FY/+mX6zRruLrDCx2iQnXF0MtkWf9GJtKBSYVApEufH1u
         GqbDK9CzZCEuZ6vxO1iR0bTt8mSyjZTlTS2mYjYE0p0DqJxJnnyo0ahMRqyu0tefCFOP
         Q1Vg/MU66wz80Bi1XogXt2DhB+OH2xNLoqVpwqPMnwudYTtA0rPpCjgBStpB7wajtvf2
         jJYLM1AyL7EfEq562Btx0MonAddBSEbHq+eM+pEtUMHEvfDtO3uqGBz/EjV2nPWLbxB3
         D4BrWRerKVXps38+sRjGxK3BSB3Q025eMIpnA6ZXEKS2xgcFVjYl8r8A1BNFGRRKuLJA
         lEsw==
X-Gm-Message-State: APjAAAU7m+/jbI5sfwbIcCJuoWB2sXQf+CzVuEOwnNixWxuwOp0rwQmv
        MyH1uB2FLLUMs8HEOQDrbGYB4DVMhrhaFel4ylxoBw==
X-Google-Smtp-Source: APXvYqw9iivvFvbh4l0R0xUIg3aOHjmVGVcBM1DAkbhY5OagPSNUaYsBKKSgVVT4xv09dpa7VBmQFMfoID9G8U35Vko=
X-Received: by 2002:a17:906:4881:: with SMTP id v1mr5729193ejq.329.1576008104565;
 Tue, 10 Dec 2019 12:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
In-Reply-To: <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
From:   Wei Wang <wvw@google.com>
Date:   Tue, 10 Dec 2019 12:01:32 -0800
Message-ID: <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 05/12/2019 08:19, Wei Wang wrote:
> > The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > numbers are subject to change due to device tree change. This usually
> > leads to tree traversal in userspace code.
> > The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> > cooling_device respectively.
>
> Instead of adding another ABI, I suggest we put the current one
> deprecated with a warning in the dmesg, update the documentation and
> change the name the next version.
>
>

IMHO, we should keep the existing path which is a common pattern for
sysfs interface. There are reasons we need couple thermal zone and
cooling device in one class, but might be worth considering split as
the latter might be used for other purposes e.g. battery current limit
for preventive vdrop prevention. By nature, thermal zone are sensors,
and cooling devices are usually components with potential high power
use.


> > Changes since v1 [1]:
> >  * Split cooling device registration into a seperate patch
> > Changes since v2 [2]:
> >  * Split improve error message in thermal zone registration
> >
> > [1]: v1: https://lore.kernel.org/patchwork/patch/1139450/
> > [2]: v2: https://lkml.org/lkml/2019/12/4/1291
> >
> > Wei Wang (3):
> >   thermal: prevent cooling device with no type to be registered
> >   thermal: improve error message in thermal zone registration
> >   thermal: create softlink by name for thermal_zone and cooling_device
> >
> >  drivers/thermal/thermal_core.c | 55 +++++++++++++++++++++++++++-------
> >  1 file changed, 44 insertions(+), 11 deletions(-)
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
