Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68557533
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 02:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfF0AER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 20:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF0AEQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jun 2019 20:04:16 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276C820815;
        Thu, 27 Jun 2019 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561593855;
        bh=Bt+LbiO4eQLo4bJM3VadGjoo2T9a8a0o1bzVcKWRMuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VzyzHxb7jptUrCqs9F7o8V75HSXapfrjCLgkMKDWUGrVq57XGIiKbpkNItkDvwrjY
         aTb2u6QVihtcKKDFmAICkxiWbwv6Apl8u5RbWQ6JNPOgR/axmdSOU/2FmAh2g9c2zt
         n7cr0tuD6dFWMdKHsSXc8CBGBlH1vXb2uGgIQ1vY=
Date:   Thu, 27 Jun 2019 08:04:12 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190627000412.GA527@kroah.com>
References: <20190626005449.225796-1-trong@android.com>
 <20190626011221.GB22454@kroah.com>
 <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
 <CANA+-vD+qBqENZrk_7KZzedbzGPMzHniHTE4sY93gnkzzBif6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANA+-vD+qBqENZrk_7KZzedbzGPMzHniHTE4sY93gnkzzBif6A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 26, 2019 at 03:48:58PM -0700, Tri Vo wrote:
> On Tue, Jun 25, 2019 at 6:33 PM Tri Vo <trong@android.com> wrote:
> >
> > On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 25, 2019 at 05:54:49PM -0700, Tri Vo wrote:
> > > > Embedding a struct kobject into struct wakeup_source changes lifetime
> > > > requirements on the latter. To that end, change deallocation of struct
> > > > wakeup_source using kfree to kobject_put().
> > >
> > > Ick, are you sure you need a new kobject here?  Why wouldn't a named
> > > attribute group work instead?  That should keep this patch much smaller
> > > and simpler.
> >
> > Yeah, named attribute groups might be a much cleaner way to do this.
> > Let me investigate.
> 
> Say, we read /sys/power/wakeup_sources/foo/active_count.

What is "foo" here?  You didn't include Documentation of the sysfs
files so it was pretty impossible to say what exactly your heirachy was
going to be in order to determine this :)

> This
> attribute's show function needs to find wakeup_source struct of "foo".
> I'm not sure how to do that without embedding a kobject inside of
> wakeup_source.

Again, without knowing what "foo" is, I can't really answer this.
Surely "foo" is not a flat namespace of all 'struct device' in the
kernel, right?

thanks,

greg k-h
