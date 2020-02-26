Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE34F16F416
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 01:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgBZAKv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 25 Feb 2020 19:10:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35579 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBZAKv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 19:10:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so1336130otd.2;
        Tue, 25 Feb 2020 16:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CNziFfrmWhbjTTcbCNHSKad5NAJHz5/qi6i9152J5Fw=;
        b=E5o1GriPPWq1oxiOzsk3gxRNiv7P9iUZIeeTIp88ZT3ojghJYLhPef1WJiKJDAbbC5
         e4g+WogCi2MDQo/8Qp1sYDrtBi/vU3I5Rki338XhWJTAgbsche5Y/pcwuHP1phjAlb0r
         VobBGYIBb0khUPFUc43aZs/m6dwJWEgTC57C0WjZWK8C5Ypx4IM0xxq2A0sFZytSB45I
         2JhRsEFSdsdsRcFze/ApGD44C39Aa+tRw25bhKEzAjKy1BBh7dyfAXcyUyNUhQaGjDRm
         TxoAwTR9W+jbh5JImeV1ry6BJ+exg+ctGEOZy2r/rsgQSfYMuU+f4KXnvt6S1QLws0Eq
         d59w==
X-Gm-Message-State: APjAAAUkQU+YUrGbjXWAKDJS3fSAYunsxpb26/epNATmDdgeOkQvtnbS
        CZSTq+BMpmS3vsX6EMNDY2yRFeRUJu6RarpaCyU=
X-Google-Smtp-Source: APXvYqzE8QeT1pVs1t+cjoDwnhRfObMOEixeQC7HrEUB+jxrwhoSmRaOPqThinOpS5dpvEVROBthaigAvIN6rf/uYNQ=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr917931otn.262.1582675849939;
 Tue, 25 Feb 2020 16:10:49 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0iSEV9S=zTa9++vUCO6GTfBE2sxNY+b4mMMt4Y6RCRvjA@mail.gmail.com>
 <62491094-D13B-4EED-8190-4AA4EB77036B@lca.pw> <CAJZ5v0jXZOd0yfnwcP1NrfrXnALx=5E1nmK8DHk8bJ0SLUYzAQ@mail.gmail.com>
 <1582570959.7365.116.camel@lca.pw>
In-Reply-To: <1582570959.7365.116.camel@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Feb 2020 01:10:39 +0100
Message-ID: <CAJZ5v0jDjK63R4kbBb_aU7ZBXbCG_vfOW33aVBRbYV7hEOWYqA@mail.gmail.com>
Subject: Re: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
To:     Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Marco Elver <elver@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 24, 2020 at 8:02 PM Qian Cai <cai@lca.pw> wrote:
>
> On Mon, 2020-02-24 at 10:54 +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 24, 2020 at 2:01 AM Qian Cai <cai@lca.pw> wrote:
> > >
> > >
> > >
> > > > On Feb 23, 2020, at 7:12 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > It may be a bug under certain conditions, but you don't mention what
> > > > conditions they are.  Reporting it as a general bug is not accurate at
> > > > the very least.
> > >
> > > Could we rule out load tearing, store tearing and reload of global_req in cpuidle_governor_latency() for all compilers and architectures which could introduce logic bugs?
> > >
> > >         int global_req = cpu_latency_qos_limit();
> > >
> > >         if (device_req > global_req)
> > >                 device_req = global_req;
> > >
> > > If under register pressure, the compiler might get ride of the tmp variable, i.e.,
> > >
> > > If (device_req > cpu_latency_qos_limit())
> > > —-> race with the writer.
> > >          device_req = cpu_latency_qos_limit();
> >
> > Yes, there is a race here with or without the WRITE_ONCE()/READ_ONCE()
> > annotations (note that these annotations don't prevent CPUs from
> > reordering things, so device_req may be set before global_req
> > regardless).
> >
> > However, worst-case it may cause an old value to be used and that can
> > happen anyway if the entire cpuidle_governor_latency_req() runs
> > between the curr_value update and pm_qos_set_value() in
> > pm_qos_update_target(), for example.
> >
> > IOW, there is no guarantee that the new value will be used immediately
> > after updating a QoS request anyway.
> >
> > I agree with adding the annotations (I was considering posting a patch
> > doing that myself), but just as a matter of making the intention
> > clear.
>
> OK, how about this updated texts?
>
> [PATCH -next] power/qos: annotate a data race in pm_qos_*_value
>
> cpu_latency_constraints.target_value could be accessed concurrently via,
>
> cpu_latency_qos_apply
>   pm_qos_update_target
>     pm_qos_set_value
>
> cpuidle_governor_latency_req
>   cpu_latency_qos_limit
>     pm_qos_read_value
>
> The read is outside pm_qos_lock critical section which results in a data race.
> However, the worst case is that an old value to be used and that can happen
> anyway, so annotate this data race using a pair of READ|WRITE_ONCE().

I would rather say something like this:

The target_value field in struct pm_qos_constraints is used for
lockless access to the effective constraint value of a given QoS list,
so the readers of it cannot expect it to always reflect the most
recent effective constraint value.  However, they can and do expect it
to be equal to a valid effective constraint value computed at a
certain time in the past (event though it may not be the most recent
one), so add READ|WRITE_ONCE() annotations around the target_value
accesses to prevent the compiler from possibly causing that
expectation to be unmet by generating code in an exceptionally
convoluted way.
