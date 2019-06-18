Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284BD49DB2
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 11:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfFRJqF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 05:46:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45826 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfFRJqE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 05:46:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so12391016lje.12
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFNO/LKvYXvmFansFhyqwV2emff3osiWobNFjm+LOZY=;
        b=KoP3nBVtEN46bstqiMPFdsUTbbPqY93iN7frcTYWr8sCkKcBebn35gCjj5jqcvfKhd
         fAuG3oSUIsxzueLCci8XKFWf5vyJEcjs8vc/tenn/7tedfBJnIjkrUS2emDtyh1XcVKN
         oJDo3aSm0I9kNs8kSqe8S7BpxGPY/S1XIGyrpqJwXiVoAjJ21EkDkul6gD/j+g2k7chV
         1q8IYd1jAabrLTjzTFW+sNKXtfxKxoVVe4Tv2xbq9ilJGzSX2Xwu1c6FkoVxQK/B9d7O
         5xswsVa1q7duPRYnUKJhxEn70tEaolrLmQiQYoN4UFh8A5Cuug+J++VyRPd/hcvZEWkl
         4ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFNO/LKvYXvmFansFhyqwV2emff3osiWobNFjm+LOZY=;
        b=pEyVcQgEHORsNMFYChP2pkw9LBl2fje7WAskOHlZxt174ChTwLC4BQJJjndoFXPyGL
         HilYZmDCWCnVqkmmXwi6PBoO5gwT+KyoUTjkaBNmqnyQC5cwLNOlRy1kykpO9Ltdl8xz
         2JMEDHLbjDcrXn8sa2v86vZV7NQxy67ZVVlcjU7n/u/8CrUojE0knvKZ/f8TwISP43XH
         dYXZ2SkFKwnuYiKihabFQCcPWRKCXPVpIi3LQGj9sHneC+4iyGKdRZhuIXAbyAuh/oWK
         Wja2MAQZx3G0ZK6FWLLTvv30YOLsnfaEVD5jlWGZ/Iu/2iAK9MAYEWX8pOwvPx/0PYQN
         dmpw==
X-Gm-Message-State: APjAAAWmWeVeDVT/APWGfZp7o/SV3rxbr5roOJIp1IYc47zNH9kjVw5+
        HTis+KPUvDth/s8CPOSNKFleFVifreANQlgzNHmWNw==
X-Google-Smtp-Source: APXvYqwLdmo7/UQzJICTwX7MmW1II8rP/12ROJHu2fbSKBjfNIwSirb55B1kWr5B7bMLEWjTiNO044PrL3t15XUYJ7U=
X-Received: by 2002:a2e:1290:: with SMTP id 16mr43089752ljs.88.1560851163194;
 Tue, 18 Jun 2019 02:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
 <c8030f30-0899-070b-df3c-3839ec7e1909@arm.com> <20190618093453.GN3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190618093453.GN3436@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Jun 2019 11:45:52 +0200
Message-ID: <CAKfTPtAcV-CS_6hibJa0N6U925KASw1Eg7OSDcBt-Hw_frQkXw@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: remove unused sd param from arch_scale_cpu_capacity()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 18 Jun 2019 at 11:34, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 17, 2019 at 06:07:29PM +0100, Valentin Schneider wrote:
> > Hi,
> >
> > On 17/06/2019 16:00, Vincent Guittot wrote:
> > > struct sched_domain *sd parameter is not used anymore in
> > > arch_scale_cpu_capacity() so we can remove it.
> > >
> >
> > I think it can't hurt to give a bit of background. The *sd parameter used
> > to be there for smt_gain, which got snipped out by:
> >
> >   765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")
> >
> > I'd appreciate having that commit mentioned in the log.
> >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > Other than that, the changes look fine to me.
> >
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> The commit log now reads:
>
> ---
> The 'struct sched_domain *sd' argument to arch_scale_cpu_capacity() is
> unused since commit:
>
>   765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")
>
> remove it.
> ---

Thanks
