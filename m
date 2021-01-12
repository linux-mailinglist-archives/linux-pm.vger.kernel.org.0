Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FABA2F3929
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 19:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406328AbhALSrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 13:47:23 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44539 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbhALSrX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 13:47:23 -0500
Received: by mail-oi1-f172.google.com with SMTP id d189so3370105oig.11;
        Tue, 12 Jan 2021 10:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+ifN+sqBDpCrlxc/hn6HlXvZ73CmQIsUHsPLlYApeA=;
        b=hympt0zEUO6XXYGYA1QO20XYTfLKp3IIG9jDNrjYaOdXbECa6+8icnT/Ak/FuDL7Pi
         xnD192o3DXL7clAfLCk27GJqo4wNMfNOdYiM/W3BqezxRxYjR1ODZUEB17ji2LSod9JO
         vf+1vUFnzPsRs8ZNtsyg+VsXnFz0fgdvOG6y2/3BkUActzA0zU3ChXsToPfK17rG/uOh
         SEBApT54DllJrFDIQz36tMdolnKsaA3D/186ZAasxAWl6tlfiX0pom9C0mzVt6kSVFuG
         BpMHnQywQJjE+WAEGfmLLhEepoUq7VTObBUm3QT0mSI92uaTxZvYAg6gIPm3G0EwVO1j
         D0kA==
X-Gm-Message-State: AOAM531Ie+ZLhMRToRZbLZZxtplPsls7X69SkVVJzVtYNo8qSfMQk//Z
        IZvg/SVx0AW1Ajf52r/C4fAnIvig5uDQOihlr4A=
X-Google-Smtp-Source: ABdhPJyC+CqJ3HEKIxtefCSBZPbzSKD5dv6f6MBUcsMV+0nfQPHTZYB7m681IsIb8gBShnjIYxj16qOFoiCMM9XTIjE=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr354358oie.157.1610477202317;
 Tue, 12 Jan 2021 10:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20210112052127.4557-1-yu.c.chen@intel.com> <CAJZ5v0i5jdp6YcpvVuLyxGePRAsFPUPL6=iQC7PEFSzjNRUJLw@mail.gmail.com>
 <20210112150340.GA17152@chenyu-office.sh.intel.com>
In-Reply-To: <20210112150340.GA17152@chenyu-office.sh.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 19:46:31 +0100
Message-ID: <CAJZ5v0igG=kyL7zFrvCLcMAE7uLzaB-MC8fZBxBX17WNTpR5Cg@mail.gmail.com>
Subject: Re: [PATCH][v3] cpufreq: intel_pstate: Get percpu max freq via HWP
 MSR register if available
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 12, 2021 at 4:00 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Tue, Jan 12, 2021 at 02:52:50PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 12, 2021 at 6:19 AM Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > Currently when turbo is disabled(either by BIOS or by the user), the
> > > intel_pstate driver reads the max non-turbo frequency from the package-wide
> > > MSR_PLATFORM_INFO(0xce) register. However on asymmetric platforms it is
> > > possible in theory that small and big core with HWP enabled might have
> > > different max non-turbo cpu frequency, because the MSR_HWP_CAPABILITIES
> > > is percpu scope according to Intel Software Developer Manual.
> > >
> > > The turbo max freq is already percpu basis in current code, thus make
> > > similar change to the max non-turbo frequency as well.
> > >
> > > Reported-by: Wendy Wang <wendy.wang@intel.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > > v2: Per Srinivas' suggestion, avoid duplicated assignment of max_pstate.
> > > v3: Per Rafael's suggestion, do not add new argument in intel_pstate_get_hwp_max()
> > >     to avoid redundant local vars.
> > >     Per Srinivas' suggestion, refined the commit log to reflect the 'non-turbo'
> > >     max frequency.
> >
> > Looks good now, thanks!
> >
> > Is it needed in -stable and if so, which -stable series should it go into?
> >
> Yes, I think so, it should be
> Cc: stable@vger.kernel.org # 4.18+
> as the HWP reading turbo frequency was firstly introduced in v4.18-rc2 and it
> was easier to be applied.
> BTW, this patch is on top of your previous patch set on intel_pstate clean up:
> https://patchwork.kernel.org/project/linux-pm/list/?series=410797

OK, applied (with a few minor edits in the subject and changelog) as
5.12 material along with those patches , thanks!
