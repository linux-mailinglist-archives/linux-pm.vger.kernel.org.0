Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140F34BF4C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFSRHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 13:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfFSRHy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jun 2019 13:07:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCC52084E;
        Wed, 19 Jun 2019 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560964072;
        bh=ZZakWFV3wpQ3D41JL/BfSJA1Zh1XLt3/4zsXV7Va1Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BO2NJ4gV8/ZsImJxX7Kk/YMxssdJZkjdLTLCVGdqLXU4vhIj/NJAO/8y4Eivd5AqX
         YLZB76XuHz/XXqNCjp3q+0pdlwmm02Pxb05DPimNT+IgAhAqibfVh676U2FVshVfmP
         gb4eKSQRJFqL34YdwjihtWah3/tBogVaYlzLUpC4=
Date:   Wed, 19 Jun 2019 19:07:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
Message-ID: <20190619170750.GB10107@kroah.com>
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com>
 <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> > It is conceivable to have a "wakeup_sources" directory under
> > /sys/power/ and sysfs nodes for all wakeup sources in there.
> 
> One of the "issues" with this is, now if you have say 100 wake up
> sources, with 10 entries each, then we're talking about a 1000 sysfs
> files. Each one has to be opened, and read individually. This adds
> overhead and it is more convenient to read from a single file. The
> problem is this single file is not ABI. So the question I guess is,
> how do we solve this in both an ABI friendly way while keeping the
> overhead low.

How much overhead?  Have you measured it, reading from virtual files is
fast :)

And how often does this happen?  Does it _need_ to happen?

Parsing files is also hard, and not for sysfs files, you can't have it
both ways.

So try it this way, and if there really is a performance issue, we can
then talk about it...

thanks,

greg k-h
