Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD63F55DF0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFZBsJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfFZBsJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 21:48:09 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDC5C204EC;
        Wed, 26 Jun 2019 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561513688;
        bh=lhOKRprT7HVe0Z8Cz+OabL8qmzBmCh0WUg8YKiJg6kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BL8S8BzsOC1JOHpaxjj/CTatmCr1mGi07Q7JwyCKDT+4+v22IeNWUhCXfpmspHgxG
         cUK/l3MuLXJTLFZSH+DOHSUmj+O8ZYqciueHRuR7ZoT3lqpr5xlAA+jyBRjKq7h60F
         V9Ii3OEqVpE7rxOOnaIqsvmncQprx25jWE1XQuvA=
Date:   Wed, 26 Jun 2019 09:46:33 +0800
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
Message-ID: <20190626014633.GA22610@kroah.com>
References: <20190626005449.225796-1-trong@android.com>
 <20190626011221.GB22454@kroah.com>
 <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 25, 2019 at 06:33:08PM -0700, Tri Vo wrote:
> On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > +static ssize_t wakeup_source_count_show(struct wakeup_source *ws,
> > > +                                     struct wakeup_source_attribute *attr,
> > > +                                     char *buf)
> > > +{
> > > +     unsigned long flags;
> > > +     unsigned long var;
> > > +
> > > +     spin_lock_irqsave(&ws->lock, flags);
> > > +     if (strcmp(attr->attr.name, "active_count") == 0)
> > > +             var = ws->active_count;
> > > +     else if (strcmp(attr->attr.name, "event_count") == 0)
> > > +             var = ws->event_count;
> > > +     else if (strcmp(attr->attr.name, "wakeup_count") == 0)
> > > +             var = ws->wakeup_count;
> > > +     else
> > > +             var = ws->expire_count;
> > > +     spin_unlock_irqrestore(&ws->lock, flags);
> > > +
> > > +     return sprintf(buf, "%lu\n", var);
> > > +}
> >
> > Why is this lock always needed to be grabbed?  You are just reading a
> > value, who cares if it changes inbetween reading it and returning the
> > buffer string as it can change at that point in time anyway?
> 
> Right, we don't care if the value changes in between us reading and
> printing it. However, IIUC not grabbing this lock results in a data
> race, which is undefined behavior.

A data race where?  Writing to the value?  How can that happen?  All you
are doing is incrementing this variable elsewhere, what is the worst
that can happen?

thanks,

greg k-h
