Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD404434C27
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTNev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 09:34:51 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:41774 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTNev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 09:34:51 -0400
Received: by mail-wm1-f52.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so10331701wmd.0;
        Wed, 20 Oct 2021 06:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrb5cmSM9pAeOUv7OLv3lf3TqRyW680tvYdtVjs/dwc=;
        b=4ItNZKlcjNWaMc6cvAZ7zIzhhraNQ3uba21sfJy53+oa9wSRAwPSKFB5cqkrNUfZxH
         f0Spfk004He0qtFCvMsXE1CvsVxZ8z7iB/VbjqwldrLU8rAg2miVfwPK6udqxRl4Obys
         uh7LthkA0+3kxdjWhzqFXY7gdlvcdW+sHDJN9KMXWg5/XSeLNhAygVrFM52rwJ0WQmmr
         +bB9wtSxDoIVy6HkWJe4zAI9R2X2tOyOYHo8gFvBF3ZHcGZEOT9HlfsrBu+hDtv39ay0
         MeBNKGHjC9AAvbM5VbYwV9F55DMhZmqE0AXUmJWnLvL39fRgsdVWFKvCeNO/sjxNFled
         7+BA==
X-Gm-Message-State: AOAM531iTpLYmJGWFezRpWTkTUF45v8C2wjuGQkAkO6v2ONMz2qpYuUH
        +nMKa15/yRjlPGyKco4sANzdgw62lBK4D0YJSUqbBs12epU=
X-Google-Smtp-Source: ABdhPJx4OezOx/SpW6qvC+aTeaSi/Wj2W3Pu9ZAVbVmhubqQhfEFmpv6TPaBtkplENFfupWQaSTzAf4hw+bqWQIndvk=
X-Received: by 2002:a7b:c149:: with SMTP id z9mr13928439wmi.180.1634736755597;
 Wed, 20 Oct 2021 06:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210926090605.3556134-1-ray.huang@amd.com> <20210926090605.3556134-5-ray.huang@amd.com>
 <CAJZ5v0g58vrHNcOEoWUCKmTxraSTuCzVLffzEAgz7TPa8+TNyw@mail.gmail.com> <CY4PR1201MB0246A7ECA4E8143CC6E4933DECBE9@CY4PR1201MB0246.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0246A7ECA4E8143CC6E4933DECBE9@CY4PR1201MB0246.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Oct 2021 15:32:23 +0200
Message-ID: <CAJZ5v0gaBzSCg_SvH1AEJfXf8xSdAy2wN0Wu-ot-k8hv7OVOyQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
To:     "Huang, Ray" <Ray.Huang@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 20, 2021 at 1:13 PM Huang, Ray <Ray.Huang@amd.com> wrote:
>
> [AMD Official Use Only]
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Wednesday, October 20, 2021 1:00 AM
> > To: Huang, Ray <Ray.Huang@amd.com>
> > Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Viresh Kumar
> > <viresh.kumar@linaro.org>; Shuah Khan <skhan@linuxfoundation.org>;
> > Borislav Petkov <bp@suse.de>; Peter Zijlstra <peterz@infradead.org>; Ingo
> > Molnar <mingo@kernel.org>; Linux PM <linux-pm@vger.kernel.org>;
> > Sharma, Deepak <Deepak.Sharma@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> > Du, Xiaojian <Xiaojian.Du@amd.com>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; the arch/x86 maintainers <x86@kernel.org>
> > Subject: Re: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
> >
> > On Sun, Sep 26, 2021 at 11:06 AM Huang Rui <ray.huang@amd.com> wrote:
> > >
> > > From: Jinzhou Su <Jinzhou.Su@amd.com>
> > >
> > > Add a new function to enable CPPC feature. This function will write
> > > Continuous Performance Control package EnableRegister field on the
> > > processor.
> >
> > And what is going to take place after this write?
> >
> > Also, it would be good to mention that the user of this function will be added
> > subsequently.
>
> After the enable flag is set, the processor hardware can accept the performance goals such as desired perf that programed by kernel and control the processor frequency according to the performance value.

Is this the CPPC EnableRegister register described in Section 8.4.7.1
of ACPI 6.4?  If so, it would be good to provide this information in
the changelog either.

> I will mention this in the comment in V3.
>
> >
> > > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  drivers/acpi/cppc_acpi.c | 48
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  include/acpi/cppc_acpi.h |  5 +++++
> > >  2 files changed, 53 insertions(+)
> > >
> > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c index
> > > 2efe2ba97d96..b285960c35e7 100644
> > > --- a/drivers/acpi/cppc_acpi.c
> > > +++ b/drivers/acpi/cppc_acpi.c
> > > @@ -1220,6 +1220,54 @@ int cppc_get_perf_ctrs(int cpunum, struct
> > > cppc_perf_fb_ctrs *perf_fb_ctrs)  }
> > > EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> > >
> > > +/**
> > > + * cppc_set_enable - Set to enable CPPC on the processor by writing
> > > +the
> > > + * Continuous Performance Control package EnableRegister feild.
> > > + * @cpu: CPU for which to enable CPPC register.
> > > + * @enable: 0 - disable, 1 - enable CPPC feature on the processor.
> > > + *
> > > + * Return: 0 for success, -ERRNO or -EIO otherwise.
> > > + */
> > > +int cppc_set_enable(int cpu, u32 enable) {
> > > +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > > +       struct cpc_register_resource *enable_reg;
> > > +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > > +       struct cppc_pcc_data *pcc_ss_data = NULL;
> > > +       int ret = -1;
> > > +
> > > +       /* check the input value*/
> > > +       if (cpu < 0 || cpu > num_possible_cpus() - 1 || enable > 1)
> >
> > Why not use cpu_possible()?  And why enable > 1 is a problem?
> >
>
> Yes, you're right, cpu_possible() is better here.
> Will remove "enable > 1", and yes, we should support "disable" as well.
>
>
> > > +               return -ENODEV;
> >
> > -EINVAL
> >
>
> Updated.
>
> > > +
> > > +       if (!cpc_desc) {
> >
> > if this is checked, the cpu_possible() check above is redundant.
>
> Hmm, if acpi_cppc_processor_probe got failed, some one outside acpi driver would like to call this helper.
> Is that possible we get a null cpc descriptor here? Or anything I missed.

if cpu_possible(cpu) is false, then cpc_desc for cpu will be NULL.  If
you check the latter, there's no need to check the former.  Of course,
cpc_desc may be NULL for other reasons, but you're checking it anyway.

> >
> > > +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       enable_reg = &cpc_desc->cpc_regs[ENABLE];
> > > +
> > > +       if (CPC_IN_PCC(enable_reg)) {
> > > +
> > > +               if (pcc_ss_id < 0)
> > > +                       return -EIO;
> > > +
> > > +               ret = cpc_write(cpu, enable_reg, enable);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               pcc_ss_data = pcc_data[pcc_ss_id];
> > > +
> > > +               down_write(&pcc_ss_data->pcc_lock);
> > > +               /* after writing CPC, transfer the ownership of PCC to platfrom */
> > > +               ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > > +               up_write(&pcc_ss_data->pcc_lock);
> > > +       }
> >
> > Does it really need to do nothing if the register is not in PCC?  If so, then why?
> >
>
> Hmm, do you mean we should take care the cases for enabling behavior if register in other spaces such as SYSTEM_MEMORY or FIXED_HARDWARE on different kinds of SBIOS implementation?

This is a generic interface and it should cover all of the valid use
cases, so yes.
