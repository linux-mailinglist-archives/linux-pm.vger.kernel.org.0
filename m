Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2216516E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 22:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBSVPm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 16:15:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39060 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVPm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 16:15:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so1595329oty.6
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rn6lqpy2jbhI+4TQPpiGx1EVg5+LdG8VFa+KXdjd7b4=;
        b=G8eRdLuM89b1NNURLorTSBZTffrCPXsn6FetEjS1ZTtf9uC0kq+IPC23B1Mi7S3cJi
         3g1qYTuHmfiDr4xQ+7VzA/bA+RlQ++Xlw0cFCCZDW6MhUDveDUk3FDA3fvaTxp0dHldp
         j7tc3/dS+NoDHR5jJ4mCOjZcWlJHN0Lr33YecbqZBxdVkjomf6O6ChSa+nmASKMGa/FP
         nLoq5eF7PqH6Qo5rSdmoZM+9+USBwuOOF44DVR2MZz4ecMz2yUqcfkrtg3QB7cPFOOfH
         3BSVmZ7sF0M3/crcI6k3ua2uWoN2O9zIrHknueSV52p6q+PP7B+kDSUBamZMYq0Sq4fu
         3beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rn6lqpy2jbhI+4TQPpiGx1EVg5+LdG8VFa+KXdjd7b4=;
        b=qEEK4lsyN3Whlno8PXeMJ2U6AZDdeMz1CtmzaJQopioLsCIgBP9ZaKSg0/dfyNeoTa
         GfY7QFQzzjnzvP3mzJ83pTHuagmqCRDM2e1gCf59zETd9zEyUngXxx/j/qiUfD4B2DGJ
         mWWTYrXhOWcuW3AeoSSxbF7ZgL7pj9/ouT2gn4uWIVYQ33ZaSos66PYH+LtLCRg9GkbC
         /5Ifg27N6xcI9avzUF8IqDyYh8ceGlDVUlsg4Ujkvj/G0qhsMw5EHmIcS+qQZAF+5l/X
         Tgd1G7mZrSOLBtp9mrd1wPJTXZrWTwYrYXy9DLH16zhXKY7IWfnN+FYaqy/IDqwnOFKk
         uPig==
X-Gm-Message-State: APjAAAUfmGRWUAyYl0TjF3jena0JTODBS8ol1QamA9IS5scmYt6pc4N8
        wmiV8lJH5mu7756m/EfdJaILM5mcyfQPtDOUEGYkSA==
X-Google-Smtp-Source: APXvYqwlFRnbgU0X3saTQedLkbl14HONJoNTX45B07otBFNw/JuCsPnAdd0vy3Ql9apgEyoc/5dUXdiy/YZ3p1rvVa0=
X-Received: by 2002:a9d:634c:: with SMTP id y12mr7306829otk.12.1582146941111;
 Wed, 19 Feb 2020 13:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200218220748.54823-2-john.stultz@linaro.org> <20200219115942.GA4488@sirena.org.uk>
In-Reply-To: <20200219115942.GA4488@sirena.org.uk>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Feb 2020 13:15:29 -0800
Message-ID: <CALAqxLU3k-pqG0C92RCg6_fgeF7f5iGo8uos6ZcJpYGc3ZryfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] driver core: Make deferred_probe_timeout global so
 it can be shared
To:     Mark Brown <broonie@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 3:59 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 10:07:48PM +0000, John Stultz wrote:
> > This patch, suggested by Rob, allows deferred_probe_timeout to
> > be global so other substems can use it.
>
> > This also sets the default to 30 instead of -1 (no timeout) and
> > modifies the regulator code to make use of it instead of its
> > hard-coded 30 second interval.
>
> This is at least two patches, one adding the new feature and the other
> adding a user of that feature.

Yea, agreed. I combined it here just to get input at this point
without flooding folks with a ton of small patches.

> > @@ -5767,18 +5772,17 @@ static int __init regulator_init_complete(void)
> >               has_full_constraints = true;
> >
> >       /*
> > -      * We punt completion for an arbitrary amount of time since
> > +      * We punt completion for deferred_probe_timeout seconds since
> >        * systems like distros will load many drivers from userspace
> >        * so consumers might not always be ready yet, this is
> >        * particularly an issue with laptops where this might bounce
>
> While I don't see it doing any harm I'm not 100% convinced by this
> change - we're not really doing anything directly to do with deferred
> probe here, we're shutting off regulators that remain unused late in
> boot but even then they'll still be available for use.  It feels a bit
> unclear and the way you've adapted the code to always have a timeout
> even if the deferred probe timeout gets changed feels a bit off.  If
> nothing else this comment needs more of an update than you've done.

This was mostly spurred by Rob's suggestion, as it seemed both
subsystems were doing similar timeouts that may need to be customized
(likely around the same amount of time).  I agree it doesn't quite map
perfectly, but I imagine it would be useful to align those in some
way.

I'll likely take a swing first at getting the driver core bits to make
sense, and then I'll come and revisit this shared timeout issue.

thanks
-john
