Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174097D129
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 00:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfGaWb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 18:31:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42675 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfGaWb1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 18:31:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so71912738otn.9
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSadfWcJlLBywRMIXV9mcKywOnO5UwqEGEWSQilvyk4=;
        b=LW/2QAVfnNW3GEBvxs9wNawPIAoMZk/0kwFSaO1XaizvoejDoLgbxsgsUgY/uGL0dZ
         yhxvSHeR5lsR+wFWpl/2fj8xc6VbU7TQrZloxL27dMYuF4TDl6mJtaP5h4ZfgvaGVHBK
         lfnAEQCAxd3LAyWlAgRYCL03Urv2hulKQP7B8BD45BjA+IsG6tM9pBZdB8sRDgDimvMm
         ge8q0uG4NeM10+6to5axXDi4dnvwesT52peVFmh6Nl95hktoj+XmTwPTujTWmRKUdjIc
         2vQE6FJRQoHGe3et+ANR8Lft0SqgQ3GbPTMr6gtNTnVo6ppgvF8+lwff4SsTTLZDuevb
         MLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSadfWcJlLBywRMIXV9mcKywOnO5UwqEGEWSQilvyk4=;
        b=jRuvu/Kg/3eXmuMgd75S9OBCiGUwkSggSAz3VOxqLodfmGX8qRjWutubj/0+AAaSr6
         lUCsdHLzV32q7/GAoUvh2IrMj28H+EZCIlfhvRFjHaViCH/FFpjStqHxQSOXm03rvmZb
         nBtUQ/Khu7zk8ZiyGiSmfk8SlKga9jaYsTC/FrhMd4slghXf/miCfC4I9BpqikWyWceG
         m0GYPyXtvCLSJGytpN1pCH48Ps+y6cCDi0Z6PXW/blr3tSH1e9Fh8dRIpa1XY/yc4TMe
         M6TZuYZ0cdYll0SQVZ2okxU9lAbVg5lQr9QSxOc+GacJku05QcrANNHsIX4Dmc8AX/xg
         JsIg==
X-Gm-Message-State: APjAAAXxtnkMuyDlmLj/ZGU2E6iEnpb7fM/mlu7p0LVQDeZfjteLPtoR
        h7LGULe24WDDy3ck5EdypyYgEnwVaGQEnvhss/w=
X-Google-Smtp-Source: APXvYqyY4M0ZbQ9S2sovoW2815xr3pNT9xRL/dTcExgSxr/7uBuTQP/vrOsNAKkgiamDk10BFoz3IdaIfk7gSZmsTaE=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr9029675oth.159.1564612287120;
 Wed, 31 Jul 2019 15:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <5d420f45.1c69fb81.35877.3d86@mx.google.com>
 <32598586.Mjd66ZhNnG@kreacher>
In-Reply-To: <32598586.Mjd66ZhNnG@kreacher>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 15:31:16 -0700
Message-ID: <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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

On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > Quoting Tri Vo (2019-07-31 14:55:14)
> > > +/**
> > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > + * @ws: Wakeup source to be added in sysfs.
> > > + */
> > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > +{
> > > +       struct device *dev;
> > > +       int id;
> > > +
> > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
>
> So can anyone remind me why the IDA thing is needed here at all?

IDA is used to generate the directory name ("ws%d", ID) that is unique
among wakeup_sources. That is what ends up in
/sys/class/wakeup/ws<ID>/* path.
>
> > > +       if (id < 0)
> > > +               return id;
> > > +       ws->id = id;
> > > +
> > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > +                                       wakeup_source_groups, "ws%d",
> >
> > I thought the name was going to still be 'wakeupN'?
>
> So can't we prefix the wakeup source name with something like "wakeup:" or similar here?

"ws%d" here is the name in the sysfs path rather than the name of the
wakeup source. Wakeup source name is not altered in this patch.
