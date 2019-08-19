Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5291D45
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHSGmS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 02:42:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35003 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSGmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 02:42:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so522622oii.2;
        Sun, 18 Aug 2019 23:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGGC7NEXv/ChbV0jH1bLS9qMN2wa08rd7HLLbiuuAZQ=;
        b=A8Ry0cGG1zCDUs3o6NnhGZXtdaO5ynkUVtJGfpIPCK/Yltx08CdWS1j6WR0P8YNpu0
         Z7q9bf5wmeYUTIr1vUdF3nmX1yEamd9H1QWQArOWYZ8nmDqgEc3UHL47/QS40Wr+xMTR
         Jcxbd34xP/51wbX1/fRPEpr4UXAWcjkaYfHF3cIBjXUOPxCaHUoZmeV7dIXj5wYommNV
         VjS3OxJ6HPEEnATz5JyQ76szf77K5pkat8182c9dkeCYCAGQeu7hJoI1Fgp4Yn/Xy1uu
         yeTmtiYG75FfIyVBGnuXive/cIFnmgWcuQKKPMI+kBjR0q9GJkmzKDFQhzM8oyWbRX6t
         VTAA==
X-Gm-Message-State: APjAAAXVyki+tGRpHbufj6hJUUSpFbqc8RzjbMQaePYScIBIboTMoyU4
        a714bW+FdPtv+VO/NZkdWnmHcRpagK7ld7YtHgI=
X-Google-Smtp-Source: APXvYqxTwO1z/fGYAPAEdobjRwaXFK8JnqPCmHGEm8QG0KqlYrHasZ/zJs62AmDKAc+NwnbVBB+XGBz/2C+qrdx9SD4=
X-Received: by 2002:aca:cfcb:: with SMTP id f194mr7508302oig.103.1566196937213;
 Sun, 18 Aug 2019 23:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563862014.git.viresh.kumar@linaro.org> <524de8ace0596e68a24b57b3b4043c707db32ca7.1563862014.git.viresh.kumar@linaro.org>
 <20190809023445.xn3mlv5qxjgz6bpp@vireshk-i7> <CAJZ5v0gQ2RCZGo03=7DoUAxw86wSEaXdnJ2KtknU3uUtXCqmvQ@mail.gmail.com>
 <20190819022614.oy5qdozde2afibwu@vireshk-i7>
In-Reply-To: <20190819022614.oy5qdozde2afibwu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Aug 2019 08:42:01 +0200
Message-ID: <CAJZ5v0gupf6amEMG2NJfPr8rzT1o5ef1u+1NW5E_zgOMqd-qsg@mail.gmail.com>
Subject: Re: [PATCH V2 04/10] cpufreq: powerpc_cbe: Switch to QoS requests
 instead of cpufreq notifier
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 19, 2019 at 4:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-08-19, 11:01, Rafael J. Wysocki wrote:
> > On Fri, Aug 9, 2019 at 4:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 23-07-19, 11:44, Viresh Kumar wrote:
> > > > The cpufreq core now takes the min/max frequency constraints via QoS
> > > > requests and the CPUFREQ_ADJUST notifier shall get removed later on.
> > > >
> > > > Switch over to using the QoS request for maximum frequency constraint
> > > > for ppc_cbe_cpufreq driver.
> > > >
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > ---
> > > >  drivers/cpufreq/ppc_cbe_cpufreq.c     | 19 +++++-
> > > >  drivers/cpufreq/ppc_cbe_cpufreq.h     |  8 +++
> > > >  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 96 +++++++++++++++++----------
> > > >  3 files changed, 86 insertions(+), 37 deletions(-)
> > >
> > > -------------------------8<-------------------------
> >
> > If you do it this way, Patchwork will not pick up the patch.
> >
> > Please send afresh with "[Update]" or bumped up version number in the
> > subject (or both).
>
> Okay, will take care of this in future. Was away on holidays and so
> the late reply. Thanks.

OK, thanks!

The series is on hold, though, because the acpi-cpufreq patch turned
out to be problematic and I didn't have the time to have a deeper look
at the problem last week.
