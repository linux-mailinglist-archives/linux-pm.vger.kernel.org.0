Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16E17490E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbfGYIZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 04:25:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39253 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389189AbfGYIZs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 04:25:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so44750777otq.6;
        Thu, 25 Jul 2019 01:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEFxbvSwQELuCN6dR9dFdhakTWqxzMlr3rxTqwGbm6o=;
        b=DGcK5yBHyB5MXpbbFuPoZYYdd2KLOUG5614dyk6juMyNSvQk95PhOhbU6MTCkQTchF
         sOpjRX35hU9UV9EXMiSmKLDcyT+XM5aZ4rZdanpDJRTvO/iT0TxRIyzou1uU9s1us8/v
         QC61/Ji2CTA51YSM2AIntI1uVi5XKdWuHU68f87FPwcrqXG2E0FNkJ9w7PVWLGayvYfp
         P+lzM8uHn1nTKYch+Fpy1LZGqbc+gsD427uogSc/JQmharQhQXDwnOV4GuUN7RbCr1/3
         7bvoGdQIAM38KuhigdAnqDiYotFiWDyN9R4fuJ6sH0J/C+JV+fDf6leakO/YSSsJoCQ5
         fMfw==
X-Gm-Message-State: APjAAAWUfO45n2UQc8AXBvMUU0qYi/GmiK5WasK1EOR9iMJ0zFPEHSZK
        U4+eMzRe4JRvalPgdDYHlhawKO/CH6U5HVrc2bQ=
X-Google-Smtp-Source: APXvYqxFuUXFOHKSuVmZdKmRMHyCGsMooavV8fPtkOogtMS7Y650bWFzP/XYiMN71qHBEWXeoP/13eH5WVLXm176QeQ=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr65775246otq.262.1564043147812;
 Thu, 25 Jul 2019 01:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190614080523.13464-1-rajneesh.bhardwaj@linux.intel.com>
 <2359736.lHFMKXy7DL@kreacher> <23df19ca-1ec5-ce9b-9862-29d33008e581@linux.intel.com>
In-Reply-To: <23df19ca-1ec5-ce9b-9862-29d33008e581@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jul 2019 10:25:36 +0200
Message-ID: <CAJZ5v0jticmMH_txuYgDzXU9K1FYfHLB7PFmBAuvz9DEvz5=5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] powercap/rapl: Add Ice Lake NNPI support to RAPL driver
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 25, 2019 at 10:03 AM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Hi Rafael
>
> On 28-Jun-19 3:32 AM, Rafael J. Wysocki wrote:
> > On Friday, June 14, 2019 10:05:23 AM CEST Rajneesh Bhardwaj wrote:
> >> Enables support for ICL-NNPI, which is a neural network processor for deep
> >> learning inference. From RAPL point of view it is same as Ice Lake Mobile
> >> processor.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: linux-pm@vger.kernel.org
> >> Link: https://lkml.org/lkml/2019/6/5/1034
> >> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> >> ---
> >>   drivers/powercap/intel_rapl.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> >> index 4347f15165f8..431c8c8bdf07 100644
> >> --- a/drivers/powercap/intel_rapl.c
> >> +++ b/drivers/powercap/intel_rapl.c
> >> @@ -1157,6 +1157,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
> >>      INTEL_CPU_FAM6(KABYLAKE_DESKTOP,        rapl_defaults_core),
> >>      INTEL_CPU_FAM6(CANNONLAKE_MOBILE,       rapl_defaults_core),
> >>      INTEL_CPU_FAM6(ICELAKE_MOBILE,          rapl_defaults_core),
> >> +    INTEL_CPU_FAM6(ICELAKE_NNPI,            rapl_defaults_core),
> >>
> >>      INTEL_CPU_FAM6(ATOM_SILVERMONT,         rapl_defaults_byt),
> >>      INTEL_CPU_FAM6(ATOM_AIRMONT,            rapl_defaults_cht),
> >>
> > It is in my queue, but I get build errors when I try to apply it.
> >
> > I guess the definition of ICELAKE_NNPI is not there in the Linus' tree yet.
>
> The dependent patch is now available in mainline, so can you please
> apply this one?
>
> https://github.com/torvalds/linux/blob/bed38c3e2dca01b358a62b5e73b46e875742fd75/arch/x86/include/asm/intel-family.h#L59

It's already been applied along with the Rui's series.
