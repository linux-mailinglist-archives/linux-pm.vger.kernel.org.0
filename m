Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A06A3E2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 10:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfGPIbC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 04:31:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40371 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbfGPIbC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 04:31:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so14900102oie.7;
        Tue, 16 Jul 2019 01:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dabMYehwAIOMgEox85e65RbhyQ/W0kLnSfW8PvyFA3o=;
        b=eHf8/UFhq1zrW/GQXHa1Yi1GYxobGWDocrxbrhw9YnX1BSvRF2h5Kb8zoJEkaNnJkD
         WU1awxn1Neb8h9hHV6KKAh2TyC+tPzwFmtS5T5yAUlFiRr4CzM7imiNurbD/hbQ6x4aR
         4aYjgnqCypx7JdVc7wTGj8Ud8kqyE/kG3g8q2neAfX1U+ea18wrB0K6uVi3V/8/YqAGx
         2YeOwC19RE/TUfOIQ8hmxd/dgyX26SXtc0NgUiS1kr5zU8S9WVF+oKQkf8BdiuOxGzTm
         OSsP9tWKOfx/VfswKOZbkOO5XGvSKt37GQpFkP8MMHfALLl0hNB8cfV8YSEX925IQZLQ
         iQlQ==
X-Gm-Message-State: APjAAAX1unlcL5zr6WSf0o+lXSaJLE1B28uq1zakBjjRwzKsRzphSahi
        /fhs7DwVjQPEj+8ilVxbTo42u+s0xldUhoc2zTo=
X-Google-Smtp-Source: APXvYqyuzj1SaChLyQaD7xBMjz+TklVFyF4Zmw85XHl+XoWQwfWrnpe0CXQlWQlqx4KzBi2CrYtJcPKqoCYEVRjUbKU=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr15794912oib.57.1563265861459;
 Tue, 16 Jul 2019 01:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190715203651.GA7513@kroah.com> <20190715214348.81865-1-trong@android.com>
 <CAJZ5v0gEzZkbeLFtW5yadwxBryvL3vWcUoQTkUy3VkxiTV+UrA@mail.gmail.com> <20190716021102.GA8310@kroah.com>
In-Reply-To: <20190716021102.GA8310@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Jul 2019 10:30:48 +0200
Message-ID: <CAJZ5v0hxKeK-eDEs1rGP0ZYbbCHa0q5=ZPMVCemYVHGL48Q=pg@mail.gmail.com>
Subject: Re: [PATCH v4] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>, sspatil@google.com,
        kaleshsingh@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 4:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 11:48:27PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 15, 2019 at 11:44 PM Tri Vo <trong@android.com> wrote:
> > >
> > > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > > blocking wakeup sources over device's boot cycle. This information can
> > > then be used (1) for power-specific bug reporting and (2) towards
> > > attributing battery consumption to specific processes over a period of
> > > time.
> > >
> > > However, debugfs doesn't have stable ABI. For this reason, create a
> > > 'struct device' to expose wakeup sources statistics in sysfs under
> > > /sys/class/wakeup/<name>/.
> > >
> > > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > > source statistics in sysfs.
> >
> > I'm not sure if this is really needed, but I'll let Greg decide.
>
> You are right.  Having zillions of config options is a pain, who is
> going to turn this off?
>
> But we can always remove the option before 5.4-rc1, so I'll take this
> as-is for now :)
>
> > Apart from this
> >
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> thanks for the review!  I'll wait for 5.3-rc1 to come out before adding
> this to my tree.

So it occurred to me that maybe it's better if I apply it?  After all,
this is PM material. :-)

It is fine by me either way, but then I'm not sure if you want to get
future bug reports related to this if any ...
