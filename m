Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0D145F4E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 00:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAVXo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 18:44:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34334 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 18:44:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so1235160oig.1;
        Wed, 22 Jan 2020 15:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ed4zI+jSgC6xCI/xfGInzht5Wa+I4nWsmMe8EzbF7SM=;
        b=k7Cz+Reuhb23OzsDeP6AIYB/1Evlr7BNJ6rOHvLbBtDnbX+ViPuKtxTVvYUglFqKgT
         tvjv5SuNoGsl219i+MkjmpFgVPki4KDdxzR8Hr92tYs83osC6w+2gZMsmrkIrPdmaPNe
         iz5NjvdUQKJ19XrYhn/73JMRgv97l1gbSHDtGFMGKdkoUMLqr/qGpyz02ndVedcF6HUP
         y+OWR7I++jzGOm4hnXZY3Qlz6KRtvKj3aMbJ3Qnmfzdpa1GYpZZ7DNodSObDdl4smOlc
         yzBkFUzNYKxmvmRTrJACGE1Q4fbKcQQyhRdtYJxM1xdQNOcvbqLlq2UNdadiggByYhq9
         6j5A==
X-Gm-Message-State: APjAAAVJlusopU/hGeETwinswUFw7m/HopkDfIioEtsFPLzHYEW8JDyC
        Z501aX5j/emVuzoPCUkHNOn62sQZCVVnKTzwXJkWMF6p
X-Google-Smtp-Source: APXvYqxNgvuZUQA8M1G4TAe27SPJKfXoGK9QcwiGPOzUhAUt/2pusrEPBix6/ucvjY4XDCZhrMOrfhSnJXIkob8iGaI=
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr8823910oic.57.1579736697527;
 Wed, 22 Jan 2020 15:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20200121082758.8808-1-benjamin.gaignard@st.com> <4c2b0c6f-c0d7-5866-44cf-e32d84c4261a@infradead.org>
In-Reply-To: <4c2b0c6f-c0d7-5866-44cf-e32d84c4261a@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 00:44:46 +0100
Message-ID: <CAJZ5v0hPNx9iOm+nWcYfs+qPyuFj63xp2ieAWRMKb9AOnrming@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: fix kernel doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 21, 2020 at 4:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/21/20 12:27 AM, Benjamin Gaignard wrote:
> > Fix cpuidle_find_deepest_state() kernel documentation to avoid warnings when compiling with W=1.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

The patch has been queued up as 5.6 material under modified subject
("cpuidle: fix cpuidle_find_deepest_state() kerneldoc warnings"),
thanks!

> > ---
> > CC: rdunlap@infradead.org
> > version 2:
> > - fix the comment done by Randy
> >  drivers/cpuidle/cpuidle.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 33d19c8eb027..19c6dee88921 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -121,6 +121,9 @@ void cpuidle_use_deepest_state(u64 latency_limit_ns)
> >   * cpuidle_find_deepest_state - Find the deepest available idle state.
> >   * @drv: cpuidle driver for the given CPU.
> >   * @dev: cpuidle device for the given CPU.
> > + * @latency_limit_ns: Idle state exit latency limit
> > + *
> > + * Return: the index of the deepest available idle state.
> >   */
> >  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                              struct cpuidle_device *dev,
> >
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
