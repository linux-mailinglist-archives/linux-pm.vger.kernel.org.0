Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07C17D1B9
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 01:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfGaXKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 19:10:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40849 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaXKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 19:10:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so14775627oth.7;
        Wed, 31 Jul 2019 16:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8l1uqGOVO/FuCTz/Db7pciz7jZIb+8ZYxFrfQmQPjZo=;
        b=dJzj/nPJEkpn+z1sYfGw1w+DsSe86+WBHXwVMdFJ2fiU5X1qhyT4SnZGtCiM5qyuvZ
         whnBZQFg7YTLKIW++b+u1ybm2M3YXlebx1//wP720Dn0VOQY2+yc9uIGuCcqvjqOiJDo
         rwtbo3F7+0NcGSdcMqKSkms+wsB13JShoLKj68teYKvEv1LVTMfaauqtJC0Ih/kPpUSH
         sI8e4p/dt65bUdxBYL9UCeQdj1aP7NBCd3DgQcS2qDephmcbCwH0gl07h9ID54L2I9Yh
         EE+WW7hvp+vNkf0pG2wFlfWx9fxCccMtvkIVFE6RuRj+8hcVLxdWT79HHkHoF4mZUVGA
         1lJQ==
X-Gm-Message-State: APjAAAVniAFce/UiAgg+zzg8OMJj6YspETv4RR/lFHbKrXq9OESh7AlL
        4aKzS2Fai8287Uf2/g/A5zqZju+k3lbR2QiM7K8=
X-Google-Smtp-Source: APXvYqx6yAMYqPQr/poKUiAMReBVpDduzbzTS2NkJNMqF48zA5VI//M+F2qpvLYX66Uu8WNqNf+61vhbEHDBc9sW45k=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr24345908otq.262.1564614649426;
 Wed, 31 Jul 2019 16:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
In-Reply-To: <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Aug 2019 01:10:38 +0200
Message-ID: <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
>
> On Wed, Jul 31, 2019 at 3:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, August 1, 2019 12:31:16 AM CEST Tri Vo wrote:
> > > On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > > > > Quoting Tri Vo (2019-07-31 14:55:14)
> > > > > > +/**
> > > > > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > > > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > > > > + * @ws: Wakeup source to be added in sysfs.
> > > > > > + */
> > > > > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > > > > +{
> > > > > > +       struct device *dev;
> > > > > > +       int id;
> > > > > > +
> > > > > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> > > >
> > > > So can anyone remind me why the IDA thing is needed here at all?
> > >
> > > IDA is used to generate the directory name ("ws%d", ID) that is unique
> > > among wakeup_sources. That is what ends up in
> > > /sys/class/wakeup/ws<ID>/* path.
> >
> > That's not my point (see below).
> >
> > > > > > +       if (id < 0)
> > > > > > +               return id;
> > > > > > +       ws->id = id;
> > > > > > +
> > > > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > > +                                       wakeup_source_groups, "ws%d",
> > > > >
> > > > > I thought the name was going to still be 'wakeupN'?
> > > >
> > > > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> > >
> > > "ws%d" here is the name in the sysfs path rather than the name of the
> > > wakeup source. Wakeup source name is not altered in this patch.
> > >
> >
> > So why wouldn't something like this suffice:
> >
> > dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> >                                 wakeup_source_groups, "wakeup:%s", ws->name);
> >
> > ?
>
> ws->name is inherited from the device name. IIUC device names are not
> guaranteed to be unique. So if different devices with the same name
> register wakeup sources, there is an error.

OK

So I guess the names are retained for backwards compatibility with
existing user space that may be using them?

That's kind of fair enough, but having two different identification
schemes for wakeup sources will end up confusing.
