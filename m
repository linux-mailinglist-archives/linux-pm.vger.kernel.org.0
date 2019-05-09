Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7918ECC
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEIRSc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 13:18:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44037 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIRSc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 13:18:32 -0400
Received: from 79.184.254.161.ipv4.supernova.orange.pl (79.184.254.161) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id dde0ba7bd4127124; Thu, 9 May 2019 19:18:29 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface
Date:   Thu, 09 May 2019 19:18:28 +0200
Message-ID: <1627338.1fd8ofggM8@kreacher>
In-Reply-To: <20190509102315.GA31824@splinter>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1762575.ER2xjzr9E1@aspire.rjw.lan> <20190509102315.GA31824@splinter>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, May 9, 2019 12:23:15 PM CEST Ido Schimmel wrote:
> On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> > +static struct attribute *intel_epb_attrs[] = {
> > +	&dev_attr_energy_perf_bias.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group intel_epb_attr_group = {
> > +	.name = power_group_name,
> > +	.attrs =  intel_epb_attrs
> > +};
> > +
> >  static int intel_epb_online(unsigned int cpu)
> >  {
> > +	struct device *cpu_dev = get_cpu_device(cpu);
> > +
> >  	intel_epb_restore();
> > +	if (!cpuhp_tasks_frozen)
> > +		sysfs_merge_group(&cpu_dev->kobj, &intel_epb_attr_group);
> > +
> >  	return 0;
> >  }
> >  
> >  static int intel_epb_offline(unsigned int cpu)
> >  {
> > -	return intel_epb_save();
> > +	struct device *cpu_dev = get_cpu_device(cpu);
> > +
> > +	if (!cpuhp_tasks_frozen)
> > +		sysfs_unmerge_group(&cpu_dev->kobj, &intel_epb_attr_group);
> > +
> > +	intel_epb_save();
> > +	return 0;
> >  }
> 
> Hi,
> 
> I just booted net-next and got the following NULL pointer dereference
> [1] during boot. I believe it is caused by this patch.

I think you're right, sorry about this.

> CONFIG_PM is disabled in my config which means 'power_group_name' is
> defined as NULL. When I enable CONFIG_PM the issue is not reproduced.

So does the patch below fix it for you?

---
 arch/x86/kernel/cpu/intel_epb.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

Index: linux-pm/arch/x86/kernel/cpu/intel_epb.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/intel_epb.c
+++ linux-pm/arch/x86/kernel/cpu/intel_epb.c
@@ -97,6 +97,7 @@ static void intel_epb_restore(void)
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
 }
 
+#ifdef CONFIG_PM
 static struct syscore_ops intel_epb_syscore_ops = {
 	.suspend = intel_epb_save,
 	.resume = intel_epb_restore,
@@ -193,6 +194,25 @@ static int intel_epb_offline(unsigned in
 	return 0;
 }
 
+static inline void register_intel_ebp_syscore_ops(void)
+{
+	register_syscore_ops(&intel_epb_syscore_ops);
+}
+#else /* !CONFIG_PM */
+static int intel_epb_online(unsigned int cpu)
+{
+	intel_epb_restore();
+	return 0;
+}
+
+static int intel_epb_offline(unsigned int cpu)
+{
+	return intel_epb_save();
+}
+
+static inline void register_intel_ebp_syscore_ops(void) {}
+#endif
+
 static __init int intel_epb_init(void)
 {
 	int ret;
@@ -206,7 +226,7 @@ static __init int intel_epb_init(void)
 	if (ret < 0)
 		goto err_out_online;
 
-	register_syscore_ops(&intel_epb_syscore_ops);
+	register_intel_ebp_syscore_ops();
 	return 0;
 
 err_out_online:



