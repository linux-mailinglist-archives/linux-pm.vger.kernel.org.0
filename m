Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67381CFA94
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgELQ0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 12:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgELQ0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 12:26:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5EDC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 09:26:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y16so9060726wrs.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6HJT2kKPgjiAAOGtBVsRpj6IJ2zADNGtQgIXFAzK6EU=;
        b=M5XIGTx9K+Ro5VIvFc+qCSNhF3KkcELu6ClryP/Ful95DZGJV63YVAsk0s+IIS/cOC
         3lVxRk4Q7Q3VIi+ppabWHEC2pDtYTB5vwiaq/cOmEVMUiKLIfIiQKAcEBepfcf2R3HAN
         hhbSeWYPwx7kvhtlY8yZzaXYsjD9P7sn9PJVvHxvntpu1lkSaS/mPkXyXIngbNNoLQTG
         Pi1lscl6DlH2eIibNigMPai7KR1FjqABXAfrJtvwE2v5z7LoMjyce9E29ZgUUDoxPonr
         8iT+174llTvZNzyNIT4942C+9pPrjoLdJ6+fiNNLguJurlddAtnWEgQ8g3aDTfUqDm3m
         FEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6HJT2kKPgjiAAOGtBVsRpj6IJ2zADNGtQgIXFAzK6EU=;
        b=DaYSVOWNdvEY6RoYXGBG8yNVGMYKd1dKKbzPaTf1Ok6QyQ0i0FegRUHRgyxY+fCTVi
         a0rVRJg0RhyfM0uXyFdVoebiqHwlz62d+eHH/RCEAOVR+kStqnYjGaXf1UWzs98Y0qGn
         oqBUfMUqf1gGeNzN3HFlnDMRTIxNmnVERAx3R4dcvUyGCrnGhD/D1NUEn2dItXkwqP2S
         8qSwnS0xGj3MiFMstlbIkhoQVnlWe2atJkcN5qxUnCttBczaVf5HaqgPBQjVxuRBYXmn
         Pq7P0GCb2vFw/cnauj3T85ktpRD7gugUX/df0cXYrmKy4YhBHpwLngkqW2cwMplN6zzw
         ThQA==
X-Gm-Message-State: AGi0PuZt0AqamCA/2bL1aruKB+zV9uCFfcXq9/pv8UgXG8qLYixn0qpe
        FM8W6+9AjjD1M9X6P9EF1qigRw==
X-Google-Smtp-Source: APiQypL/x/G/880ourR80PnFei74Q8cyJAmJ9uQ2rDfHQWhpRYDP56v5DXwQRxGPeMC+/N+xoYPCtw==
X-Received: by 2002:adf:bc41:: with SMTP id a1mr27717873wrh.302.1589300794743;
        Tue, 12 May 2020 09:26:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s17sm31238957wmc.48.2020.05.12.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:26:33 -0700 (PDT)
Date:   Tue, 12 May 2020 17:26:30 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200512162630.GC101124@google.com>
References: <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com>
 <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
 <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com>
 <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 12 May 2020 at 17:30:36 (+0200), Rafael J. Wysocki wrote:
> On Tue, May 12, 2020 at 5:11 PM Quentin Perret <qperret@google.com> wrote:
> > The end goal with GKI is the following: Google will release a single
> > binary kernel image (signed, etc etc) that all devices using a given
> > Android version will be required to use. That image is however going to
> > be only for the core of the kernel (no drivers or anything of the sort).
> > Vendors and OEMs, on their end, will be responsible to build and ship
> > GKI-compatible modules for their respective devices. So, Android devices
> > will eventually ship with a Google-issued GKI, plus a bunch of
> > vendor-provided modules loaded during boot.
> 
> If that is the case, then I absolutely think that schedutil should be
> part of the GKI.
> 
> Moreover, that would have been my opinion even if it had been modular
> in the first place.

I definitely understand the feeling. Heck I contributed to schedutil, so
I'd love to see the entire world run it :-)

But my personal preference doesn't seem to matter in this world, sadly.
The truth is, we cannot afford to be arbitrary in our decisions in GKI.
Switching governors and such is a fully supported feature upstream, and
it has been for a long time. Taking that away from partners is not the
goal, nor the intention, of GKI. They will be able to choose whatever
governor they want, because there are no *objective* reasons to not let
them do that.

> > This is a significant shift from the current model where vendors
> > completely own the kernel, and are largely free to use the kernel config
> > they want. Today, those who don't use schedutil are free to turn the
> > config off, for example.
> 
> So why is this regarded as a good thing?

You mean using something else than schedutil? It is not seen as a good
thing at all, at least not by me. But we have the same problem as
upstream. We cannot remove the other governors or the governor API for a
simple reason: they have users :/

Thanks,
Quentin
