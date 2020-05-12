Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC271CFFD8
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgELUv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgELUv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 16:51:27 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE3C061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 13:51:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f4so9278380iov.11
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p+BMFZWdD3PwNvd8PN0fWEsuEjzT0rH3K1Az8SxOj5Q=;
        b=RoECtTDyc2doVXJ49Gfgob0XQB0ehmOjd60t0zREhpEuhg26zUAQKP7C38su2LZUcV
         jNAU3oaiTLuwB5JUtIzSRflJd/WVp6+bg8/ygTUhFxGos/k8bS/DBJfHMy9ypzel+h0q
         F8t7o86A34FBKggCf8+ro9CJenzIyHarlw1fM/945zr4vCYfk44qy71PF8G3hhKIQUDI
         qyndDIQztH5MXlEH7W+QnRtSmTLLscKc09Noow5r4KHZyZNxhJ2wB/fk6SWKCRadoojZ
         +PaWCKCT7sNPiIiNOVxf4QZj2RJNBN102PUPyf13Jg0xALOrwgw5qnn1p6QrN+EQdzoa
         Ux0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p+BMFZWdD3PwNvd8PN0fWEsuEjzT0rH3K1Az8SxOj5Q=;
        b=qP75+jjmfpWhy1l5q7jIHIDWqjTejozDZwdE3MY+vrjjMvZFXAltL+W66XPyIq0bbe
         z1uwqoFn6lq36aGz6GrHujRo2k0wKOqi6JHY97m6xT63443t9hRGH/QGwBD16CEaBOwc
         QUDuiegM6qmUOilHv8afoyNYJiDdKuar0w/pITYmrEGCChVW2tUEPUKqae5fqWn15Daz
         TqXD8HNhIKzAH0/FTHB5CiviiyAsxxTkyzq6r4KegxzW1LaOrSISYBvDXHe2Z9yAguPd
         0FEWVzcjirmU07eoMjrDI5LzCXQ18IOoKLtLrfuWkstii9P/YhBUJrLcnxd/SfYZqJoP
         +kPg==
X-Gm-Message-State: AGi0PubxAKHl3WiCMKfvylCQY92YFyKsGfj4T5jSICbPwyG9SuGnonag
        RUQDxlqY+Uke/TgYV5M9LzAsfdHrduJWQcSz3Nk=
X-Google-Smtp-Source: APiQypLaStK8eLH1LlqpfbBEyXblJ78bzDirJjcecqi+FbQhKOcgg664cg1vjkxI9qq1qLWIafgej3OAAhVVusJWQcM=
X-Received: by 2002:a02:85ec:: with SMTP id d99mr9159118jai.144.1589316686091;
 Tue, 12 May 2020 13:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7>
In-Reply-To: <20200511052530.iazkduojnba3abil@vireshk-i7>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 12 May 2020 22:51:15 +0200
Message-ID: <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh, Marek and Mark

On Mon, 11 May 2020 at 07:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-05-20, 21:56, Cl=C3=A9ment P=C3=A9ron wrote:
> > Dear OPP Maintainers,
> >
> > I'm working on adding DVFS support using the generic OPP framework to P=
anfrost.
> > I'm using the dev_pm_opp_set_regulators() to let OPP framework get and
> > manage the regulator.
> > https://github.com/clementperon/linux/commit/be310c37b82010e293b7f129cc=
dcb711a2abb2ce
> >
> > However it seems that this function only get the regulator but never en=
able it.
> > This result that the regulator is disabled later by the
> > regulator_late_cleanup().
> >
> > In a previous version I let the Panfrost driver to get and enable the
> > regulator in addition to OPP but this create a conflict in debugFS
> > because the regulator is "get" two times.
> >
> > Quick discussion with Mark Brown point that we should try to avoid
> > getting two times a regulator as it can create "confusion in your code
> > with two different parts of the device controlling the same supply
> > independently."
> >
> > Is my understanding correct? If yes,
> > Should we not add a call to regulator_enable() in the
> > dev_pm_opp_set_regulators() ?
> >
> > My WIP branch :
> > https://github.com/clementperon/linux/commits/panfrost_devfreq
>
> https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.c=
om/
>
> We tried that sometime back and faced issues with it.

Regarding GPU it uses also the OPP framework and the regulator is not
always-on so it seems quick logic the use_count should be increased
for this regulator.

Does declaring the regulator as 'regulator-boot-on' could fix the issue?

Regards,
Clement


>
> --
> viresh
