Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD5244062
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMVOm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:14:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46411 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVOm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:14:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id t15so5243087edq.13
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2020 14:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVxgNi0nK3mJ0+XUo/h8F+w6XBdVGh++QkUBodsOsQU=;
        b=cMwjrl7wXpX6qOerJz7f9q7fUcc27WmFYbedoOnAXs0121Cwu24DFC8WDCj3ifNvqm
         y4M4JDbeWs5ac+FrG3GH3VXGa34ouEWGsXcFeo489TFkLEzJ9MjPBesnKOkKymbW1LNV
         cvWCV7lxKvBN04bzI9zsL5Grn4H2wVgQDzmgcF2XKl1U4qLlcHPkrKz4Yi50KvPN/RBe
         64U3hvvzn3NO5LB+jH/ViHY7u3YnVCqzpWSvZn48dyaUzZPtjWi4+ft8Ttzn7GfldJao
         0JGwt0EyPXeEd967OF5UppKWWvslJlFaTPB9MJ3ZnAlKj3RGxOa7R0aAJztxXmfFkRd4
         7OKw==
X-Gm-Message-State: AOAM533PYY+mUI+Fk2uho0+bUXyQuvNdQhE76S5n3q/qJTh61ysFWDqb
        jBnE4Byu3YeiotKjNWMXU/YkSadj48UVHN3iAWM=
X-Google-Smtp-Source: ABdhPJzjaAdjSSqZxKHC4vcrVEuEwYcQrFsqswci3H1OBTXWFZyXiagIDSUyZvhIDjOt5sdyU9yXRtFBPub4IbQyb3k=
X-Received: by 2002:a05:6402:1d25:: with SMTP id dh5mr6386701edb.266.1597353280325;
 Thu, 13 Aug 2020 14:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584766216.git.len.brown@intel.com>
 <abdcbdb265264f736df316622a695ad30019c05f.1584766216.git.len.brown@intel.com> <003101d6023f$70975750$51c605f0$@net>
In-Reply-To: <003101d6023f$70975750$51c605f0$@net>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Aug 2020 17:14:29 -0400
Message-ID: <CAJvTdKkZR-GT8gTGQqPeH+9kKkME7s4MULx1akAeAE389bNeDg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] tools/power turbostat: Print cpuidle information
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Antti Laakso <antti.laakso@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Doug,
I agree with you.

Looks like an oversight -- will fix.

thanks!
-Len

On Tue, Mar 24, 2020 at 8:50 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Len,
>
> On 2020.03.20 21:55 Len Brown wrote:
>
> > From: Len Brown <len.brown@intel.com>
> >
> > Print cpuidle driver and governor.
> >
> > Originally-by: Antti Laakso <antti.laakso@linux.intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---
> > tools/power/x86/turbostat/turbostat.c | 26 ++++++++++++++++++++++++++
> > 1 file changed, 26 insertions(+)
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > index 77f89371ec5f..05dbe23570d4 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
>
>
> ...
>
> >
> > static void
> > dump_sysfs_cstate_config(void)
> > {
> > @@ -3516,6 +3533,15 @@ dump_sysfs_cstate_config(void)
> >       if (!DO_BIC(BIC_sysfs))
> >               return;
>
> I do not understand why this information needs to be
> a function of the --show options and not solely a
> function of the --quiet option.
>
> My reasoning is that I almost always want all the information
> possible in the start spew of stuff, and if I don't I'll
> use --quiet option. However, I rarely show more than
> about 6 columns at a time resulting in intermittent inclusion
> of this information.
>
> >
> > +     if (access("/sys/devices/system/cpu/cpuidle", R_OK)) {
> > +             fprintf(outf, "cpuidle not loaded\n");
> > +             return;
> > +     }
> > +
> > +     dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_driver");
> > +     dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_governor");
> > +     dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_governor_ro");
> > +
> >       for (state = 0; state < 10; ++state) {
> >
> >               sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",
>
>


-- 
Len Brown, Intel Open Source Technology Center
