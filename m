Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5931D0AAD
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgEMISs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgEMISs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 04:18:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EACBC061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 01:18:48 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q10so15103672ile.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YgS+7827Vem+gwoksbSkQ3Xaq617WJzBTAiSLJBCvNs=;
        b=IMfwQ2rm0nr4DrkBJ21PLRJ75xrdR+kQ0k4uE4TJTF7+N9q7wvZGQ1b6nrbkZmMVxE
         SW8h3NJm5rEkPuxvIhne9HJYyd//1Q31Y/HZh9Pms/5uc7cPpdzmHGRWOSxYn2lVMfKf
         yhk1Yqumv0W/x0Eygc7tjlVCUL7SjJVHNJ8bkrpo3Sz6rtNdn46hlYEDWxJKOeQiH3Pb
         YUeeB0GczIx/N4hmCBNrh3Mys6kTVgjqQCeGmcLpBLQMFeEKF3InnKN4sleyLR9oqcOR
         ST7LTVHZaphoWo6pKqKQ/egKjLymVaGsMx6T+FnSIjKS7MRcHL2hCPLm2yvVcS+yzMe0
         4iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YgS+7827Vem+gwoksbSkQ3Xaq617WJzBTAiSLJBCvNs=;
        b=gkWOodRhhqmmAXj1ieDNHNVrJaQJo4GNRJBY7BbqMB3xnY9RZymMhn8A7Do/l2xkCQ
         tqsxigdnPTeRavps/C0WfdJkALlYjtROa6ra36Qp685j7GlYgYwxb5ybCYthBmvXU6/T
         tK1pIlF4MSoOFtTHOATZdHZ9Kiuln0v03Po9re1nb0079D+T99AVdwdIAAPNqV/SL/bf
         aD+luFleNFXkY++exejIQCZhmomaGAqH+6GvTkx4iXU/TQxbV+52/zPZML9LJDsW9UYZ
         UjoI0i9zcsIlXj2Fk/qbJhs91Qh+ux66b7sTnIgFFJ7u5766KmZ5a1nXF+yEK8pjo7ly
         LCyg==
X-Gm-Message-State: AGi0PuZrDXJUwEPVRkBe3zRsMYLFcmenmAQTo8+Mhw8pnMdgV5n49ZEc
        m0OIdywcSVf5ExEgI6/UQnLDHwY0Xq1u8H1J8+M=
X-Google-Smtp-Source: APiQypKM45AV0I71DoCl17hcggfw0x8BBv1lUM2DpvubX3ZG3GK8sywYhF5H1H91HNEQghpaqqMyhppZmVfZz4xhVm0=
X-Received: by 2002:a92:d8ca:: with SMTP id l10mr25306932ilo.118.1589357927305;
 Wed, 13 May 2020 01:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7> <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
 <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
In-Reply-To: <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 13 May 2020 10:18:35 +0200
Message-ID: <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, 13 May 2020 at 07:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-05-20, 22:51, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Viresh, Marek and Mark
> >
> > On Mon, 11 May 2020 at 07:25, Viresh Kumar <viresh.kumar@linaro.org> wr=
ote:
> > >
> > > On 09-05-20, 21:56, Cl=C3=A9ment P=C3=A9ron wrote:
> > > > Dear OPP Maintainers,
> > > >
> > > > I'm working on adding DVFS support using the generic OPP framework =
to Panfrost.
> > > > I'm using the dev_pm_opp_set_regulators() to let OPP framework get =
and
> > > > manage the regulator.
> > > > https://github.com/clementperon/linux/commit/be310c37b82010e293b7f1=
29ccdcb711a2abb2ce
> > > >
> > > > However it seems that this function only get the regulator but neve=
r enable it.
> > > > This result that the regulator is disabled later by the
> > > > regulator_late_cleanup().
> > > >
> > > > In a previous version I let the Panfrost driver to get and enable t=
he
> > > > regulator in addition to OPP but this create a conflict in debugFS
> > > > because the regulator is "get" two times.
> > > >
> > > > Quick discussion with Mark Brown point that we should try to avoid
> > > > getting two times a regulator as it can create "confusion in your c=
ode
> > > > with two different parts of the device controlling the same supply
> > > > independently."
> > > >
> > > > Is my understanding correct? If yes,
> > > > Should we not add a call to regulator_enable() in the
> > > > dev_pm_opp_set_regulators() ?
> > > >
> > > > My WIP branch :
> > > > https://github.com/clementperon/linux/commits/panfrost_devfreq
> > >
> > > https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsu=
ng.com/
> > >
> > > We tried that sometime back and faced issues with it.
> >
> > Regarding GPU it uses also the OPP framework and the regulator is not
> > always-on so it seems quick logic the use_count should be increased
> > for this regulator.
> >
> > Does declaring the regulator as 'regulator-boot-on' could fix the issue=
?
>
> The bootloader would still be required to power it on first and it
> would be wastage of power as GPU isn't getting used then..

Sorry,  my message was not clear, I was trying to see if there is a
way to fix exynos issue other than removing the regulator_enable().
I'm wondering if calling regulator_enable() on an reg which is
'regulator-boot-on' declared will trigger this issue.

>
> What about doing runtime_pm_get/put() from the driver which should
> enable/disable all power related stuff for the device ?

Not sure what you meant there but the regulator isn't get by the
driver itself, so the driver runtime_pm will call devfreq/opp to
properly set the regulator voltage.

I'm really not an expert on this but for what I understand I think
that removing the regulator_enable in the OPP framework to fix some
side-effects is not the proper fix.
I wonder if we can get where the voltage is changed and why? Maybe
there is a proper fix like setting the required OPP voltage before
enabling the regulator or declaring the regulator as
'regulator-boot-on'.

Regards,
Clement


>
> --
> viresh
