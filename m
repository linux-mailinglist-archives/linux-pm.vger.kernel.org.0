Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C262225B0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGPOdu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 10:33:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38109 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 10:33:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id t18so4352360otq.5;
        Thu, 16 Jul 2020 07:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmiaqtUzH0VdOjrke+C8yL3r2k6iKKJuwoCUU+1s/YM=;
        b=SHIe9Dd6mgPOaSINMbSdShOD62DSNOIwFizaP1GeWhG38LW5q9FdxjfM7mNuridxvi
         HhcMcF21M/cDgc4/+4PVoPUQGjSRgwcQ9+FSKUq/pcZ8bNOn8c79R2TTox27NAtKbM6N
         3Mo0MLyRl0Mbx1v/bvXsEArx5ivWzujQZL1LdboQvXLH7dNJ0PEiNO6D29nV9QvwS9Nu
         WzFyMCZcLR4aZ3c1hpf+LNr3QFEFpXhnp5srnZh6hxJxJcfTsGscyP8taeab/MM+6rzN
         Hb1//32CAzE+Yg/hp0RxN6F1W7sOPMoyQjQRa4lE4U8nB9MOR4ATlepZZR+qEpvSXKKy
         M/Bw==
X-Gm-Message-State: AOAM5318n0h1G7CcJJ1IG/7b9H9RsMIgm+dqmTZ+TDxzuHsunnJU5RqB
        bNchN9SU0EkOt54wcLNKGStz2w6CcZCccWKszlU=
X-Google-Smtp-Source: ABdhPJzDoG5KJMpnyJXdOop97cHDWsuuF2FHfUwLGI7w8f7tBi7EwMgj3Cmu/EikpfyS7sA/w7x1c6v2smOAQcunlfg=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr4735960oth.262.1594910028178;
 Thu, 16 Jul 2020 07:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <3955470.QvD6XneCf3@kreacher> <87r1tdiqpu.fsf@riseup.net>
 <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com>
 <87imeoihqs.fsf@riseup.net> <44797cd1312843e5998070aec236b1cd80c48d14.camel@linux.intel.com>
In-Reply-To: <44797cd1312843e5998070aec236b1cd80c48d14.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jul 2020 16:33:34 +0200
Message-ID: <CAJZ5v0hm-evY87JkG=Aru2Z_gFwcjB7XD+pJgM4iMSQJkrmtrw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Francisco Jerez <currojerez@riseup.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 16, 2020 at 3:14 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2020-07-15 at 14:35 -0700, Francisco Jerez wrote:
> > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >
> > > On Wed, Jul 15, 2020 at 2:09 AM Francisco Jerez <
> > > currojerez@riseup.net> wrote:
> > > > "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
>
> [...]
>
> > > > > I don't think that's accurate.  I've looked at hundreds of
> > > > > traces
> > while
> > my series [1] was in control of HWP_REQ_MAX and I've never seen an
> > excursion above the maximum HWP_REQ_MAX control specified by it
> > within a
> > given P-state domain, even while that maximum specified was well into
> > the turbo range.  So, yeah, I agree that HWP_REQ_MAX is nothing like
> > a
> > hard limit, particularly when multiple threads are running on the
> > same
> > clock domain, but the processor will still make its best effort to
> > limit
> > the clock frequency to the maximum of the requested maximums, even if
> > it
> > happens to be within the turbo range.  That doesn't make it useless.
> > The exact same thing can be said about controlling HWP_REQ_MIN as
> > you're
> > doing now in this revision of your patch, BTW.
> >
> > If you don't believe me here is the turbostat sample with maximum
> > Bzy_MHz I get on the computer I'm sitting on right now while
> > compiling a
> > kernel on CPU0 if I set HWP_REQ_MAX to 0x1c (within the turbo range):
> >
> > > Core    CPU     Avg_MHz
> > > Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
> > > -       -       757     27.03   2800    0x0000000000000000      7.1
> > > 3    4.90
> > > 0       0       2794    99.77   2800    0x0000000080001c04      7.1
> > > 3    4.90
> > > 0       2       83      2.98    2800    0x0000000080001c04
> > > 1       1       73      2.60    2800    0x0000000080001c04
> > > 1       3       78      2.79    2800    0x0000000080001c04
> >
> > With the default HWP_REQUEST:
> >
> > > Core    CPU     Avg_MHz
> > > Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
> > > -       -       814     27.00   3015    0x0000000000000000      8.4
> > > 9    6.18
> > > 0       0       2968    98.24   3021    0x0000000080001f04      8.4
> > > 9    6.18
> > > 0       2       84      2.81    2982    0x0000000080001f04
> > > 1       1       99      3.34    2961    0x0000000080001f04
> > > 1       3       105     3.60    2921    0x0000000080001f04
>
> Correct. In HWP mode this is possible to lower limit in turbo region
> conditionally. In legacy mode you can't with turbo activation ratio.
>
> But what we don't want set max and min perf and use like desired to run
> at a P-state overriding HWP or limit the range where HWP can't do any
> meaningful selection.

That's a good point too IMO.
