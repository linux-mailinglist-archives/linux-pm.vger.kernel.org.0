Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AAC1EE2B0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgFDKmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jun 2020 06:42:20 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39957 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgFDKmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2020 06:42:20 -0400
Received: by mail-oi1-f170.google.com with SMTP id t25so4641890oij.7;
        Thu, 04 Jun 2020 03:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtLNfsN/A/N2E3wGVViMKTHPXKwZLxoBNdSqzHaE8IA=;
        b=TJgUvPw4HOhKa1RKyZx1yhqfeWlnJRqajjAbpdn8XEdkZ3L7yMKindhHxkfljFWGln
         RDOjrSBcaKqdIKhBADlWaKzeKoR4P2ALaUrsc7+AzlwyRAQ5TlmL/MLNnjbcv/fkdQdZ
         MZnlYmqUVrcesFft/AWRCnUKe+pVHTcXIpsLbP94vUNQ3yJH59gS9qhbtdaH73nOGoC3
         E2jSWblAocsZsjqk+PGBGrS6qUhQRyB+aM+nV8fcq2ds3K2d14TsrdoT0gKidz9/p5Ab
         K+3bl0JubX9WriK00QfqvqVIcsn0xk6qlmijCtmc+a/72QRpOJrkNlL18niPwHZUbvHO
         J61g==
X-Gm-Message-State: AOAM533I17OgN6WcOr0Ri9PWnsDl6ZGlC5fPimJCoS4NjyONFg5UlnRO
        mEXfYu06dTZprE+GyftecJpdCb+YtbTFJbkHUhE=
X-Google-Smtp-Source: ABdhPJy8rc2CM0Ibwow4BpUi881bLGZBqvgaLDrHV1YRcB5ipoLExPWRN9L10+GYyAKPX9xvchTgof73i4AGf3hzDdY=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr2754792oie.103.1591267339260;
 Thu, 04 Jun 2020 03:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7> <CAJZ5v0iR3H+PFnJiroNmZcj-a4bCkvT6xB-nd2ntMvakWFOvAg@mail.gmail.com>
 <39d37e1b-7959-9a8f-6876-f2ed4c1dbc37@huawei.com> <20200604044140.xlv7h62jfowo3rxe@vireshk-i7>
In-Reply-To: <20200604044140.xlv7h62jfowo3rxe@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Jun 2020 12:42:06 +0200
Message-ID: <CAJZ5v0jj5OS4oB7MYBqKeYejy_3Vz_2oy0hn-Xm=D7XAszM_vg@mail.gmail.com>
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 4, 2020 at 6:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 04-06-20, 09:32, Xiongfeng Wang wrote:
> > On 2020/6/3 21:39, Rafael J. Wysocki wrote:
> > > The frequency value obtained by kicking the CPU out of idle
> > > artificially is bogus, though.  You may as well return a random number
> > > instead.
> >
> > Yes, it may return a randowm number as well.
> >
> > >
> > > The frequency of a CPU in an idle state is in fact unknown in the case
> > > at hand, so returning 0 looks like the cleanest option to me.
> >
> > I am not sure about how the user will use 'cpuinfo_cur_freq' in sysfs. If I
> > return 0 when the CPU is idle, when I run a light load on the CPU, I will get a
> > zero value for 'cpuinfo_cur_freq' when the CPU is idle. When the CPU is not
> > idle, I will get a non-zero value. The user may feel odd about
> > 'cpuinfo_cur_frreq' switching between a zero value and a non-zero value. They
> > may hope it can return the frequency when the CPU execute instructions, namely
> > in C0 state. I am not so sure about the user will look at 'cpuinfo_cur_freq'.
>
> This is what I was worried about as well. The interface to sysfs needs
> to be robust. Returning frequency on some readings and 0 on others
> doesn't look right to me as well. This will break scripts (I am not
> sure if some scripts are there to look for these values) with the
> randomness of values returned by it.

The only thing the scripts need to do is to skip zeros (or anything
less than the minimum hw frequency for that matter) coming from that
attribute.

> On reading values locally from the CPU, I thought about the case where
> userspace can prevent a CPU going into idle just by reading its
> frequency from sysfs (and so waste power), but the same can be done by
> userspace to run arbitrary load on the CPUs.
>
> Can we do some sort of caching of the last frequency the CPU was
> running at before going into idle ? Then we can just check if cpu is
> idle and so return cached value.

That is an option, but it looks like in this case the cpuinfo_cur_freq
attribute should not be present at all, as per the documentation.

Cheers!
