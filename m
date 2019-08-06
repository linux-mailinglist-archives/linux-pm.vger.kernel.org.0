Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65FF838FD
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 20:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfHFSv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 14:51:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38913 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHFSv5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 14:51:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so89103433otq.6
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGCcLtK25GuveYiFjhwocqTOqxw5HIZH0JbQl66UTl8=;
        b=q5a6Wu2JffaVHSnXg3X5NgLo7sEfrMh4H/pE7ZTJenizHNyZziPaDY+sKY4OALTbdm
         wWeUsPsuiAD7aiR2FOdge5bw9vBJkZpbZK/ApWIjWB3eOGut9lYi7v626S/DWLkuG+Fr
         HsqzZuekniCMpYkDgy/V6P9lbnq9eSJXNuVH7/+d+SlnrhpWcjGn3c8gqHa1e6jPm2He
         44FW/xjQAlIzFwFgX6j548WyXfkKSDNpble5Vw2lfIJHPA2Lb5ZWUjBDWaxgMWCRMb6J
         H2FW8SGNPvor8jaYMjskiuEJCJSfaC57nPSIZVEgYfTfpuFwxmHWH3nSpAXN/go/VPiE
         D0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGCcLtK25GuveYiFjhwocqTOqxw5HIZH0JbQl66UTl8=;
        b=Q0WPHZDWTBzKYfbxCY1V+Vyc8ikKc1yEzCm6JE3vIbRZYAyQ8tKVy1Nob52sZq1U3d
         nU7U8gWndhgce4CG+3so4efC91GvSzc/BgV3GCmYzmdx/MWb25nRrb2gflDTnMtlIt9K
         bSlyyexoHddgNFDE4hsEaffx6DuMZLuEU4QyyW9QV63wKbMUd8ICln1xOjTzAPCPcsBf
         pUs7mIGx8OYJMnLpIqWifrVUxzuIhOw5LRqxwTJguAbF305rgDnwz+njQpqmgn6B0td6
         0VAZ0fQIJ7PrtUrqx1NZTZ+f11f59e/shV5SJ/Mek5AYCq5+4KFPdPwMW936ygeyNwKO
         0QWQ==
X-Gm-Message-State: APjAAAUUjiISHB9AiQuZtq+wIjFMJXxBonsgW/+O5cbuWdPbCo8jpcH5
        nvJD3gtcIjuyPgEWFzxcnUc2vJXGMQsIcNP3pmRqNg==
X-Google-Smtp-Source: APXvYqwcmVP6EF7nHglBfXmejG+UyrqAm46scDpHmg5aEHLa6bLfwM+0QBmdRY1EL3pmwrUfpCyo9HYDXxOrdkSyK5s=
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr4622173otq.197.1565117516786;
 Tue, 06 Aug 2019 11:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-4-trong@android.com>
 <5d48bbc2.1c69fb81.62114.5473@mx.google.com>
In-Reply-To: <5d48bbc2.1c69fb81.62114.5473@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 6 Aug 2019 11:51:45 -0700
Message-ID: <CANA+-vBFY_mVfhhK=5BL5m_yyQ5+GTE9bv32fk-qsfnAmfE4nA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] PM / wakeup: Show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Mon, Aug 5, 2019 at 4:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Tri Vo (2019-08-05 10:58:48)
> > diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> > new file mode 100644
> > index 000000000000..3a4f55028e27
> > --- /dev/null
> > +++ b/drivers/base/power/wakeup_stats.c
> > @@ -0,0 +1,161 @@
> [...]
> > +/**
> > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > + * @ws: Wakeup source to be added in sysfs.
> > + */
> > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > +{
> > +       struct device *dev;
> > +
> > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > +                                       wakeup_source_groups, "wakeup%d",
> > +                                       ws->id);
> > +       if (IS_ERR(dev))
> > +               return PTR_ERR(dev);
> > +       ws->dev = dev;
> > +       pm_runtime_no_callbacks(ws->dev);
>
> Does this only avoid adding runtime PM attributes?
>
> I thought we would call device_set_pm_not_required() on the device here.
> Probably requiring a bit of copy/paste from device_create_with_groups()
> so that it can be set before the device is registered. Or another
> version of device_create_with_groups() that does everything besides call
> device_add().

Comments on pm_runtime_no_callbacks() say,
  "Set the power.no_callbacks flag, which tells the PM core that this
   device is power-managed through its parent and has no runtime PM
   callbacks of its own.  The runtime sysfs attributes will be removed."

Sound like it's appropriate to apply this function to the wakeup source.
