Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2375CAB
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 03:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfGZB5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 21:57:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38372 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGZB5F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 21:57:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so39149083oie.5
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0ptnVs6ufwHdUe2bXDnes7rPX5LPCdAZDTAzLOU0mg=;
        b=cp2ZutT6OZJivqpOFZ5qv8yYQljKChM6RQaGffj7XyAYlw5jqK5uHaRUMjLhG/TqBp
         ZsEqS9W32J1vvPOEWcWJlrz+vmTiGM3btTV2LemgpW12edItyRa2BpTC2IIdDNZCxjCx
         hTM3qv+H7nfMnq9y3L4APNfSITDXwvPvCdLjjchQ/ZIXA/zkEq8vKgXT4SAOKEjA8jqj
         gJ6jPffwDMF+PlrXCQES1f5RsfjI0d0l95oxBvscRIvdmTv8u9Xr0pTbcc9FqRDc1s9A
         VcAZksUMHExU196JOxNPyIZ3hTzmJGZN+20te/DUq6tCQchAYgHeMV9o0zzzPP1QG2pP
         Km3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0ptnVs6ufwHdUe2bXDnes7rPX5LPCdAZDTAzLOU0mg=;
        b=Sa8KwCXSMw49ODfzeaGhtnLPAxxDCniAd5luqOo9TFoglZc2ljuJ91GetY9XkdxMD/
         yxgBZLcY3BQKiTlcdtw2/8f19qTudvtyGwn9hxhb8k0cGF5XK8nx1KKBuVPskkVr3X/O
         QX/uKWRUoQBQufDDlsyKqh9i0VxIlfS65vYlSeJTq6pqOK7UsQo1ZILxNi16qZlheADO
         +pfQdk4y6TcccbNWb/PxtDkT+LYfEMkcLA06BVx8YP6TJ57FvHqaDVXQJcyDgMcILtGo
         FEMCr5SU09pqNcOhp+bmZkozmCJzYxIv4H9JVKNW5yq3hDebw9ltW175zZHPvmXNQflf
         Ip0w==
X-Gm-Message-State: APjAAAUNdRM3ulW3KfuEYIXxJm/iYTZ3rNjPoSWzZsLQOW5NQNkr1X4D
        TV5IWgyl7r8dCaCJL9P2dTqX+Ry/Grldd0m+oMFTsQ==
X-Google-Smtp-Source: APXvYqyDyd5ROlTv8OSC4BboxrM2M+E2lZlC4AR+6tYCydL7ELU5Y56k4Cyf9dH/zfTQv7O4F36NVazwT6wvBETh2+E=
X-Received: by 2002:aca:d8c2:: with SMTP id p185mr46769844oig.30.1564106224182;
 Thu, 25 Jul 2019 18:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com> <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
 <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com> <20190725052229.znf6asnvl44rjqxg@vireshk-i7>
In-Reply-To: <20190725052229.znf6asnvl44rjqxg@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jul 2019 18:56:28 -0700
Message-ID: <CAGETcx8VCFW6_XoFxRHkGj7gdHZvTOM4i6ee_EZVK0F7SvQG5g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 24, 2019 at 10:22 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-07-19, 20:40, Saravana Kannan wrote:
> > On Wed, Jul 24, 2019 at 7:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 23-07-19, 18:42, Saravana Kannan wrote:
> > > > The devfreq passive governor scales the frequency of a "child" device based
> > > > on the current frequency of a "parent" device (not parent/child in the
> > > > sense of device hierarchy). As of today, the passive governor requires one
> > > > of the following to work correctly:
> > > > 1. The parent and child device have the same number of frequencies
> > > > 2. The child device driver passes a mapping function to translate from
> > > >    parent frequency to child frequency.
> > >
> > > > v3 -> v4:
> > > > - Fixed documentation comments
> > > > - Fixed order of functions in .h file
> > > > - Renamed the new xlate API
> > > > - Caused _set_required_opps() to fail if all required opps tables aren't
> > > >   linked.
> > >
> > > We are already in the middle of a discussion for your previous version
> > > and I haven't said yet that I am happy with what you suggested just 2
> > > days back. Why send another version so soon ?
> >
> > I wanted you to see how I addressed your comments.
>
> Sure, but that is just half the comments.
>
> > It didn't look like
> > you were going to make more comments on the code.
>
> I posted some queries and you posted your opinions on them. Now
> shouldn't I get a chance to reply again to see if I agree with your
> replies or if we can settle to something else ? I only got one day in
> between where I was busy with other stuff and so couldn't come back to
> it. Please wait a little longer specially when the comments aren't
> minor in nature.

Sorry if it came off as trying to rush you. That wasn't the intention.
Just some misunderstanding on my part.

> Anyway, lets get over it now. Lets continue our discussion on V3 and
> then we can have a V5 :)
>
> Have a good day Saravana.

Sounds good. You too Viresh! :)

-Saravana
