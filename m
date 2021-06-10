Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B33A2BA0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFJMc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 08:32:58 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37514 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhFJMcx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 08:32:53 -0400
Received: by mail-oi1-f175.google.com with SMTP id h9so1930911oih.4;
        Thu, 10 Jun 2021 05:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuzNL7tfDK7e4h6RLyE9IdnW6BdejixhbQSLxfkQyeY=;
        b=MOXKVL/gm7ShmNXGXhm69v7zjS/T3B0BFfCaLfJLWOPrAFskxDACWivteA5mj4yVEx
         7Wub/sIkUoUBtQbdM2qUWHQZ8gRp3WtXagTyFHz4fhPGxCy31DTqjdL9hMBTpMkHf2ce
         67NtFcxQynsqLoHXweZLdGpPIaC68te2oTP6w0+0WTNG4azzz9rDsLzen0i4HcDcOvuZ
         E51n1DuZHgH9NmyZREfp7JWLmvrqNgasIzvp/31JUrJKoKAkG/3qUZXRXLKC4SvOK9z2
         t7BaVevhy2DDl/uLIhcgBaemzZ6kqyWQ6KXXIZv4DaBSf2mRJPJhnBd7TRdM6/tC4VjS
         w/hA==
X-Gm-Message-State: AOAM5336ccHWaX6CGMf4Wvb3IxDgNGZWonvf4yeLKwjFrGaEeHZpDGQ6
        +CK9fcOmpGKLJfXKevWxqPmM8ouiCUFRSmO4qi/6VMQy
X-Google-Smtp-Source: ABdhPJwwCBUE8fN+1yyMTDGiGyvEZbldVa9b+ODFBClXQ+w2/+StudMLj/LRVSI+DNBCJIwLKCZz3ybN6Ur8WtSp1Pk=
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr210416oiw.69.1623328240475;
 Thu, 10 Jun 2021 05:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <28308fc0d38f252baf90e6ffb31fd2f8660be273.1623311808.git.viresh.kumar@linaro.org>
 <CAJZ5v0i+GvobLS=cM9kc9Cj4BhLcEmTzRoBsRvDqQjLO-o7yGA@mail.gmail.com> <20210610113359.gb2cu3miwuo44d5b@vireshk-i7>
In-Reply-To: <20210610113359.gb2cu3miwuo44d5b@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jun 2021 14:30:29 +0200
Message-ID: <CAJZ5v0iQCGfCj7cVVeSOe1eDSeP9xv6hwubmGDkiY+ix8_eAow@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cppc: Mark frequency invariance broken
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 10, 2021 at 1:34 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 10-06-21, 13:19, Rafael J. Wysocki wrote:
> > On Thu, Jun 10, 2021 at 9:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > There are few races in the frequency invariance support for CPPC driver,
> > > namely the driver doesn't stop the kthread_work and irq_work on policy
> > > exit during suspend/resume or CPU hotplug.
> > >
> > > A proper fix won't be possible for the 5.13-rc, as it requires a lot of
> > > changes. Instead of reverting the patch, mark this feature BROKEN for
> > > now.
> > >
> > > Fixes: 4c38f2df71c8 ("cpufreq: CPPC: Add support for frequency invariance")
> > > Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Well, why don't we revert 4c38f2df71c8 instead?
> >
> > Is there any particular reason for retaining it?
>
> I was just trying to reduce the diff size here, since this feature
> (which broke) was controlled by a CONFIG option, it looked like a nice
> way of doing it.
>
> It was already reviewed and a diff over it should be easier to review.
>
> I can do a full revert if that's what you want.

I would prefer a full revert TBH.

Making a new feature depend on BROKEN feels like it shouldn't have
been added at this point in the first place.
