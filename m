Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7571D0EC9
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgEMKCR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 06:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387474AbgEMKCQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 May 2020 06:02:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7271E206B8;
        Wed, 13 May 2020 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589364135;
        bh=4teFK8yAPQaudrvOkMtxHTK4dS9GB4B0H+iGbpSKcXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFr2qo1yZ16htVmXSelC+yVYkaYSuZGpz2WvaV0I1WIqo2vLRXY0NIN69zSxbgCsY
         m/OG5MeRhHsU6xUhe1+UCHt7S1Wtpt0bXwueF+Kc+j6iClm8Ab/jY6w/KXMeO4pXfT
         ABUKgSTqKWPwHMSSJ9d9NIJf1cXL3NFa109Vn960=
Date:   Wed, 13 May 2020 12:02:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Quentin Perret <qperret@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200513100213.GA868852@kroah.com>
References: <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com>
 <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com>
 <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
 <20200512162630.GC101124@google.com>
 <CAJZ5v0ges4=e2HkHpVk4E1yF1VsBm9H5noqMz-MxX9DK_kt6Xg@mail.gmail.com>
 <20200513094117.GB225140@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513094117.GB225140@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 10:41:17AM +0100, Quentin Perret wrote:
> Hi Rafael,
> 
> On Tuesday 12 May 2020 at 19:30:52 (+0200), Rafael J. Wysocki wrote:
> > I don't see any technical reason for making schedutil modular in the
> > context of GKI other than to make the GKI image smaller, but I don't
> > expect that to be significant enough.
> 
> The fact that we can make the image smaller, and we give vendors one
> less reason to not-want GKI _is_ desirable IMO.
> 
>   $ size vmlinux.*
>      text	   data	    bss	    dec	    hex	filename
>   19225963	9601976	 491084	29319023	1bf5f6f	vmlinux.after
>   19230599	9603236	 491084	29324919	1bf7677	vmlinux.before
> 
> ^ that's with the series applied. 'before' means sugov is =y, and
> 'after' is sugov =m. So modularizing saves just over 4K on text, and a
> bit of data too. Is it significant? Maybe not. But it's quite likely
> that those who don't use schedutil will find any unnecessary byte to be
> one too many.

It's not significant at all, just always build it in, no one will notice
it, it's just a page or two.  Serial port drivers are way bigger :)

thanks,

greg k-h
