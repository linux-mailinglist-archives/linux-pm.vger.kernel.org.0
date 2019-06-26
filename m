Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD41A5744A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 00:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFZW0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 18:26:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43603 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfFZW0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 18:26:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so40891oif.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwzTuPrM5y/zYXjPFzke4laOtSF8hSFyaDatsrv6uos=;
        b=XQNDqrzbXYaPBBsJx63e5kskO3z/7Uwv/QEJ8JEt7xCZjGxh81eoh0HK597FB/HXkl
         j6btL1dKeedIUYIgtsOftSrRmAXmaZfKOpwDSiELWVtzazJhfu+Uo7qclfvQhhYuXNlR
         y9TPDFBs7ZlHWlusDpRjFJgGnd/YC6IKeNNPXp952G7yqVoxqNHgjaRrp/qFAAM77xvw
         zA2kpSYd4hR92yB2+1i77CvASSAFudf2iFenBnL/yuVmoSu5yyVBMveC3Xo/kWws5RqP
         ozPqwCLs4ZwHkNFd7Xouks3u9uNTw8qn3NBapKd/S1OJRLwV657bHPVneIohdvKFBN5D
         2KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwzTuPrM5y/zYXjPFzke4laOtSF8hSFyaDatsrv6uos=;
        b=ILoGjkHjLu8ACwQadaT1Io209LdrKRrE7V/bOlGYxfSQrbC8hobHmGsueneQU/Uzkj
         7e+OZzB8wBFhUGIL9wj+LdLjy2D5ko8mg8ql+PlTVymyJJPwDFE6m/qL+FvGW3gwHyzM
         10xN3haNMIWgq9QnFlGXD+rsVOzlYeOV7PPcfDO3xIsaeWBNGEXvW2htNUGh1imjtabb
         Y4rokYpEatFx6mZJZk59WwtZjTBXHxF55q2qGCgouV3mWMl9frmQhrJW/TaFdS3J8Zjx
         8JILQx/G3fyeVgous9tex6Nx623OJX43zrQHqSlfckGA6wMyX/oHE55by1/FCvfzoJuO
         y0kQ==
X-Gm-Message-State: APjAAAVNhOORPlX0r/mqampksb5BAs99gj1KaGUWbgFICE/AHG857/Va
        HRybWrTpQuQ3nRTzFoHK5lrno3iUUHtl4UxOMv9NjA==
X-Google-Smtp-Source: APXvYqwVbboprpve6aSs3UTcDULdV2BbqjcfOMsVOLoe2TEN5WQ/H3YulIEecdnhlgNAw9WuySv9NLl8DqyAqSpJv/I=
X-Received: by 2002:aca:50c6:: with SMTP id e189mr415988oib.63.1561588008912;
 Wed, 26 Jun 2019 15:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190626005449.225796-1-trong@android.com> <20190626011221.GB22454@kroah.com>
 <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com> <20190626014633.GA22610@kroah.com>
In-Reply-To: <20190626014633.GA22610@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 26 Jun 2019 15:26:38 -0700
Message-ID: <CANA+-vDOBrgUB5s2Y3stw4NhwMopwdVZq_WcgBSwNrWpNV=T9g@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 25, 2019 at 6:48 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 25, 2019 at 06:33:08PM -0700, Tri Vo wrote:
> > On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > +static ssize_t wakeup_source_count_show(struct wakeup_source *ws,
> > > > +                                     struct wakeup_source_attribute *attr,
> > > > +                                     char *buf)
> > > > +{
> > > > +     unsigned long flags;
> > > > +     unsigned long var;
> > > > +
> > > > +     spin_lock_irqsave(&ws->lock, flags);
> > > > +     if (strcmp(attr->attr.name, "active_count") == 0)
> > > > +             var = ws->active_count;
> > > > +     else if (strcmp(attr->attr.name, "event_count") == 0)
> > > > +             var = ws->event_count;
> > > > +     else if (strcmp(attr->attr.name, "wakeup_count") == 0)
> > > > +             var = ws->wakeup_count;
> > > > +     else
> > > > +             var = ws->expire_count;
> > > > +     spin_unlock_irqrestore(&ws->lock, flags);
> > > > +
> > > > +     return sprintf(buf, "%lu\n", var);
> > > > +}
> > >
> > > Why is this lock always needed to be grabbed?  You are just reading a
> > > value, who cares if it changes inbetween reading it and returning the
> > > buffer string as it can change at that point in time anyway?
> >
> > Right, we don't care if the value changes in between us reading and
> > printing it. However, IIUC not grabbing this lock results in a data
> > race, which is undefined behavior.
>
> A data race where?  Writing to the value?  How can that happen?  All you
> are doing is incrementing this variable elsewhere, what is the worst
> that can happen?

Ok, I'll remove the locks.
