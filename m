Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0135DF7A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfGCIO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 04:14:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:58290 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfGCIO4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 04:14:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 01:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="164265866"
Received: from zhongyan-mobl.ccr.corp.intel.com ([10.249.170.124])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2019 01:14:53 -0700
Message-ID: <1562141690.3256.7.camel@intel.com>
Subject: Re: [PATCH 06/13] intel_rapl: abstract register access operations
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Date:   Wed, 03 Jul 2019 16:14:50 +0800
In-Reply-To: <CAJZ5v0junxx01o8fn-UsoGuuEr18zCqPZ5hWMAD6c=Z-1JNvVA@mail.gmail.com>
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
         <1561701029-3415-7-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0junxx01o8fn-UsoGuuEr18zCqPZ5hWMAD6c=Z-1JNvVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 二, 2019-07-02 at 23:56 +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > MSR and MMIO RAPL interfaces have different ways to access the
> > registers,
> > thus in order to abstract the register access operations, two
> > callbacks,
> > .read_raw()/.write_raw() are introduced, and they should be
> > implemented by
> > MSR RAPL and MMIO RAPL interface driver respectly.
> However, this patch implements them for the MSR I/F only.
> 
Right, will add this in the changelog.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/powercap/intel_rapl.c | 111 ++++++++++++++++++++++------
> > --------------
> >  include/linux/intel_rapl.h    |   9 ++++
> >  2 files changed, 67 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c
> > index 70990ff..7dc9965 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -92,13 +92,6 @@ static struct rapl_priv rapl_msr_priv = {
> >  /* per domain data, some are optional */
> >  #define NR_RAW_PRIMITIVES (NR_RAPL_PRIMITIVES - 2)
> > 
> > -struct msrl_action {
> > -       u32 msr_no;
> > -       u64 clear_mask;
> > -       u64 set_mask;
> > -       int err;
> > -};
> > -
> >  #define        DOMAIN_STATE_INACTIVE           BIT(0)
> >  #define        DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
> >  #define DOMAIN_STATE_BIOS_LOCKED        BIT(2)
> > @@ -691,16 +684,16 @@ static int rapl_read_data_raw(struct
> > rapl_domain *rd,
> >                         enum rapl_primitives prim,
> >                         bool xlate, u64 *data)
> >  {
> > -       u64 value, final;
> > -       u32 msr;
> > +       u64 value;
> >         struct rapl_primitive_info *rp = &rpi[prim];
> > +       struct reg_action ra;
> >         int cpu;
> > 
> >         if (!rp->name || rp->flag & RAPL_PRIMITIVE_DUMMY)
> >                 return -EINVAL;
> > 
> > -       msr = rd->regs[rp->id];
> > -       if (!msr)
> > +       ra.reg = rd->regs[rp->id];
> > +       if (!ra.reg)
> >                 return -EINVAL;
> > 
> >         cpu = rd->rp->lead_cpu;
> > @@ -716,47 +709,23 @@ static int rapl_read_data_raw(struct
> > rapl_domain *rd,
> >                 return 0;
> >         }
> > 
> > -       if (rdmsrl_safe_on_cpu(cpu, msr, &value)) {
> > -               pr_debug("failed to read msr 0x%x on cpu %d\n",
> > msr, cpu);
> > +       ra.mask = rp->mask;
> > +
> > +       if (rd->rp->priv->read_raw(cpu, &ra)) {
> > +               pr_debug("failed to read reg 0x%x on cpu %d\n",
> > ra.reg, cpu);
> >                 return -EIO;
> >         }
> > 
> > -       final = value & rp->mask;
> > -       final = final >> rp->shift;
> > +       value = ra.value >> rp->shift;
> > +
> >         if (xlate)
> > -               *data = rapl_unit_xlate(rd, rp->unit, final, 0);
> > +               *data = rapl_unit_xlate(rd, rp->unit, value, 0);
> >         else
> > -               *data = final;
> > +               *data = value;
> > 
> >         return 0;
> >  }
> > 
> > -
> > -static int msrl_update_safe(u32 msr_no, u64 clear_mask, u64
> > set_mask)
> > -{
> > -       int err;
> > -       u64 val;
> > -
> > -       err = rdmsrl_safe(msr_no, &val);
> > -       if (err)
> > -               goto out;
> > -
> > -       val &= ~clear_mask;
> > -       val |= set_mask;
> > -
> > -       err = wrmsrl_safe(msr_no, val);
> > -
> > -out:
> > -       return err;
> > -}
> > -
> > -static void msrl_update_func(void *info)
> > -{
> > -       struct msrl_action *ma = info;
> > -
> > -       ma->err = msrl_update_safe(ma->msr_no, ma->clear_mask, ma-
> > >set_mask);
> > -}
> > -
> >  /* Similar use of primitive info in the read counterpart */
> >  static int rapl_write_data_raw(struct rapl_domain *rd,
> >                         enum rapl_primitives prim,
> > @@ -765,7 +734,7 @@ static int rapl_write_data_raw(struct
> > rapl_domain *rd,
> >         struct rapl_primitive_info *rp = &rpi[prim];
> >         int cpu;
> >         u64 bits;
> > -       struct msrl_action ma;
> > +       struct reg_action ra;
> >         int ret;
> > 
> >         cpu = rd->rp->lead_cpu;
> > @@ -773,17 +742,13 @@ static int rapl_write_data_raw(struct
> > rapl_domain *rd,
> >         bits <<= rp->shift;
> >         bits &= rp->mask;
> > 
> > -       memset(&ma, 0, sizeof(ma));
> > +       memset(&ra, 0, sizeof(ra));
> > 
> > -       ma.msr_no = rd->regs[rp->id];
> > -       ma.clear_mask = rp->mask;
> > -       ma.set_mask = bits;
> > +       ra.reg = rd->regs[rp->id];
> > +       ra.mask = rp->mask;
> > +       ra.value = bits;
> > 
> > -       ret = smp_call_function_single(cpu, msrl_update_func, &ma,
> > 1);
> > -       if (ret)
> > -               WARN_ON_ONCE(ret);
> > -       else
> > -               ret = ma.err;
> > +       ret = rd->rp->priv->write_raw(cpu, &ra);
> > 
> >         return ret;
> >  }
> > @@ -1506,6 +1471,44 @@ static struct notifier_block
> > rapl_pm_notifier = {
> >         .notifier_call = rapl_pm_callback,
> >  };
> > 
> > +static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
> > +{
> > +       if (rdmsrl_safe_on_cpu(cpu, ra->reg, &ra->value)) {
> > +               pr_debug("failed to read msr 0x%x on cpu %d\n", ra-
> > >reg, cpu);
> > +               return -EIO;
> > +       }
> > +       ra->value &= ra->mask;
> > +       return 0;
> > +}
> > +
> > +static void rapl_msr_update_func(void *info)
> > +{
> > +       struct reg_action *ra = info;
> > +       u64 val;
> > +
> > +       ra->err = rdmsrl_safe(ra->reg, &val);
> > +       if (ra->err)
> > +               return;
> > +
> > +       val &= ~ra->mask;
> > +       val |= ra->value;
> > +
> > +       ra->err = wrmsrl_safe(ra->reg, val);
> > +}
> > +
> > +
> > +static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
> > +{
> > +       int ret;
> > +
> > +       ret = smp_call_function_single(cpu, rapl_msr_update_func,
> > ra, 1);
> > +       if (ret)
> > +               WARN_ON_ONCE(ret);
> > +       else
> > +               ret = ra->err;
> > +       return ret;
> I would prefer the above to be written as:
> 
> ret = smp_call_function_single(cpu, rapl_msr_update_func, ra, 1);
> if (WARN_ON_ONCE(ret))
>         return ret;
> 
> return ra->err;

okay, will update it in next version.

thanks,
rui
