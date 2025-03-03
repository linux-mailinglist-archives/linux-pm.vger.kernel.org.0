Return-Path: <linux-pm+bounces-23446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD0FA4EC75
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D463BC473
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532DE27E1D4;
	Tue,  4 Mar 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L8hCthpU"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61627C86B
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113116; cv=pass; b=V948EO5laI7XbXMJF/pUYAMjTeSy6yr1sfxzxuYiXo7fRhcXRLl0+k+v8jc9JwGC1YCNr1J0amqeB7212D/nmwBK/9lvTH7zqvnc7sEXPRA7MVYf/bgzQOa8kzOzil+STsUcNtATMl1I5IhWhYqJvTxn7LsVD7geZzJgykETCrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113116; c=relaxed/simple;
	bh=jsCzTFVQjhyi34lEMooZFC2t/E5oWZlU/nOh9xu/6Hk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq75WOj19ZfJT4A9UziUNhk/yy/6AJF8mdOV5xBbHvAc7cRa0LVC8Ti51/csjauGFhXqLNS9JjBOhlLmDdbkKtn2082bVbbaw9A8mPRT7svXfq0fDP4fbXIyfyZaViAfm4iU0c1IMlWfVeGHzIkWGptoORowHUcAHjgG33UcAs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L8hCthpU; arc=none smtp.client-ip=198.47.23.235; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id BE6C940D2F73
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 21:31:52 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=ti-com-17Q1 header.b=L8hCthpU
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gQX1jHLzG2B4
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 19:01:08 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9D65D42777; Tue,  4 Mar 2025 19:00:43 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L8hCthpU
X-Envelope-From: <linux-kernel+bounces-541322-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L8hCthpU
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id A8E8F4329D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:59:21 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 11CEF2DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:59:20 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260753B275A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4641F1531;
	Mon,  3 Mar 2025 09:58:21 +0000 (UTC)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A91D79A3;
	Mon,  3 Mar 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995897; cv=none; b=Hp3IcXHovlfp6Srl2wER/POicwrP5ezhiPT9S5iz6/wFeZIpYr42KJhAmNP8iCEQKzveEmfd8Rl/ku6llCGKaWVPbrMCEOVwyKJ03AA/1FmKtJ3mROosHvCnufpbNr7d12YvDEYqKw19rVrF4+oi0O6/Thnp7VHUUMh2/Ca57Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995897; c=relaxed/simple;
	bh=jsCzTFVQjhyi34lEMooZFC2t/E5oWZlU/nOh9xu/6Hk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXISjFBLVxFdSXSmuo2elTxxeICiAOLfOD8QQ+7jckqr9FKrm0HMXH8z79Us6gDUM7epih/uHxgU+Oyg/Mjd/2H9uKkbBbBRo2w6BpJJbVfachpxMikc8IEY96JfMx39fn0Xp5eU2Zu5ynfQm1RvyILCgUBRCMz9FkFmwveWFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L8hCthpU; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5239wBmQ3297422
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 03:58:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740995891;
	bh=FeggH+PeB9tjcVLtMliId21gkOc5JjsNarxCUZO3rdE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=L8hCthpUxu1WCYVdXRZCrM6wIuSqUaWtgXiyNuTVpqPCeGIYgc+Ki+pql2Cw1Yek1
	 mS2qw/PX4RaoHu4YN0vR0Ldu5gIz2Du8VNaDqPRPv0ACR5smAXby2tPCsxPfUDrLbA
	 BqcvI1mzMrFdKpi5avz+DS8RD2crszeCgBXNBUw4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5239wBv0029201
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 03:58:11 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 03:58:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 03:58:11 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5239wA2k035790;
	Mon, 3 Mar 2025 03:58:10 -0600
Date: Mon, 3 Mar 2025 15:28:09 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, <vigneshr@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khilman@baylibre.com>
Subject: Re: [PATCH RFC] pmdomain: core: add support for writeble power
 domain state
Message-ID: <20250303095809.x2mmd52znicl7roy@lcpd911>
References: <20250221-pm-debug-v1-1-e5bd815f7ca4@ti.com>
 <CAPDyKFr+P9oi-ofXOkfoBHSCLaCAREW_efjJ6TctTeo_AVCzDA@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFr+P9oi-ofXOkfoBHSCLaCAREW_efjJ6TctTeo_AVCzDA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gQX1jHLzG2B4
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717814.00162@dUdE9vkF/9paUYvDR4cuZg
X-ITU-MailScanner-SpamCheck: not spam

Ulf,

On Feb 28, 2025 at 13:39:44 +0100, Ulf Hansson wrote:
> On Fri, 21 Feb 2025 at 14:48, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
> >
> > Add support for writeable power domain states from debugfs.
> >
> > Defining GENPD_ALLOW_WRITE_DEBUGFS will enable writeable pd_state
> > node in debugfs.
> >
> > Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> > ---
> > This has turn out to be really helpful when debugging SCMI protocol
> > for power domain management.
> >
> > Reference has been taken from clock framework which provides similar
> > CLOCK_ALLOW_WRITE_DEBUGFS, which helps to test clocks from debugfs.
> > ---
> >  drivers/pmdomain/core.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 9b2f28b34bb5..6aba0c672da0 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -1298,6 +1298,60 @@ late_initcall_sync(genpd_power_off_unused);
> >
> >  #ifdef CONFIG_PM_SLEEP
> >
> > +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> > +/*
> > + * This can be dangerous, therefore don't provide any real compile time
> > + * configuration option for this feature.
> > + * People who want to use this will need to modify the source code directly.
> > + */
> > +static int genpd_state_set(void *data, u64 val)
> > +{
> > +
> > +       struct generic_pm_domain *genpd = data;
> > +       int ret = 0;
> > +
> > +       ret = genpd_lock_interruptible(genpd);
> > +       if (ret)
> > +               return -ERESTARTSYS;
> > +
> > +       if (val == 1) {
> > +               genpd->power_on(genpd);
> > +               genpd->status = GENPD_STATE_ON;
> > +       } else if (val == 0) {
> > +               genpd->power_off(genpd);
> > +               genpd->status = GENPD_STATE_OFF;
> > +       }
> > +
> > +       genpd_unlock(genpd);
> > +       return 0;
> 
> This makes the behaviour in genpd inconsistent and I am worried about
> that, even if it's for debugging/development.
> 
> For example, what if there is a device hooked up to the genpd which
> requires its PM domain to stay on? And what about child domains?

Thanks for taking a look.

Agreed that there maybe some paths in genpd that this patch maybe
ignoring and thus could break something fundamental while debugging.

Perhaps we can split this patch up and remove the state_set part till we
figure out the right way of doing it without breaking genPD

BUT, as I said in my previous response I feel that if one is enabling
DEBUG config then anyway they are literally aware of the risk that they
are taking, by exposing raw PD on/off operations from user space.
Perhaps we can continue our debate on the reply I gave earlier on this
thread...

> 
> > +}
> > +
> > +#define pd_state_mode  0644
> > +
> > +static int genpd_state_get(void *data, u64 *val)
> > +{
> > +
> > +       struct generic_pm_domain *genpd = data;
> > +       int ret = 0;
> > +
> > +       ret = genpd_lock_interruptible(genpd);
> > +       if (ret)
> > +               return -ERESTARTSYS;
> > +
> > +       if (genpd->status == GENPD_STATE_OFF)
> > +               *val = 0;
> > +       else
> > +               *val = 1;
> > +
> > +       genpd_unlock(genpd);
> > +       return ret;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(pd_state_fops, genpd_state_get,
> > +                        genpd_state_set, "%llu\n");
> > +
> > +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> > +
> >  /**
> >   * genpd_sync_power_off - Synchronously power off a PM domain and its parents.
> >   * @genpd: PM domain to power off, if possible.
> > @@ -3639,6 +3693,11 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
> >         if (genpd->set_performance_state)
> >                 debugfs_create_file("perf_state", 0444,
> >                                     d, genpd, &perf_state_fops);
> > +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> > +       debugfs_create_file("pd_state", 0644, d, genpd,
> > +                           &pd_state_fops);
> > +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> > +
> >  }
> >
> >  static int __init genpd_debug_init(void)
> > @@ -3653,6 +3712,24 @@ static int __init genpd_debug_init(void)
> >         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> >                 genpd_debug_add(genpd);
> >
> > +#ifdef GENPD_ALLOW_WRITE_DEBUGFS
> > +       pr_warn("\n");
> > +       pr_warn("********************************************************************\n");
> > +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
> > +       pr_warn("**                                                                **\n");
> > +       pr_warn("**  WRITEABLE POWER DOMAIN STATE DEBUGFS SUPPORT HAS BEEN ENABLED **\n");
> > +       pr_warn("**  IN THIS KERNEL                                                **\n");
> > +       pr_warn("** This means that this kernel is built to expose pd operations   **\n");
> > +       pr_warn("** such as enabling, disabling, etc.                              **\n");
> > +       pr_warn("** to userspace, which may compromise security on your system.    **\n");
> > +       pr_warn("**                                                                **\n");
> > +       pr_warn("** If you see this message and you are not debugging the          **\n");
> > +       pr_warn("** kernel, report this immediately to your vendor!                **\n");
> > +       pr_warn("**                                                                **\n");
> > +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
> > +       pr_warn("********************************************************************\n");
> > +#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
> > +
> >         return 0;
> >  }
> >  late_initcall(genpd_debug_init);
> >
> > ---
> > base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
> > change-id: 20250221-pm-debug-0824da30890f
> >
> > Best regards,
> > --
> > Kamlesh Gurudasani <kamlesh@ti.com>
> >
> 
> When working with genpd and SCMI PM domains, a more robust way to
> debug things would be to implement a slim skeleton driver for a
> consumer device. In principle it just needs some basic runtime PM
> support and the corresponding device hooked up to the SCMI PM domain
> in DT. In this way, we can use the existing sysfs interface for

But this will just be a per-device limited solution right? It still
won't allow us a generic way of dealing with all possible scmi IDs  without
having to rebuild the system... Or maybe I am misunderstanding/ missing
something...

> runtime PM, to control and debug the behaviour of the genpd/SCMI PM
> domain.

If I were to come from a user's perspective, then they will want to be able
to get a full view of the system's power status at a glance. Today, I am
not aware of a way how we can do that from genpd. This makes debugging
what is _actually_ ON/OFF in the system a bit tricky..

Users may not even care much for example about the kernel drivers for
certain controllers but still want to ensure that those controller's registers are
accessible to them to use via something like devmem2.
Another application for the get_status part of this patch is for
studying the overall power draw of the system by judging which all IDs
are on/off at a glance.

Hence, if you feel that for now the state_get part of this patch makes
sense it will still help users query the status of all the pd id's in
the system.

Thinking of it... What if we modify the existing status_show() itself
with another column that shows current status similar to runtime status?
status_show today only does a print based off of genpd->status ... and
never really goes and queries the firmware again if by any chance some
other event or activity in the system may have turned ON the device.

For eg. if we have another remote processor request a resource
but genPD was unaware of this request so it just assumes that resource is still
off-0... That's just wrong IMO.

What I am proposing is can we have a get_state callback in genPD which
would be = something like power_ops->state_get in scmi pmdomains
today.
This will help the core pmdomains get an up-to-date view of the system
in the debugFS. Whether genPD decides to update it's internal
genpd->status based on the query is another issue.
But from what it looks like, we definitely have a requirement here to
make sure pm_genpd_summary shows a true-to life status of the power
domains. Not just rely on linux runtime pm or assume that linux is the
only real software who knows and does it all.

> 
> I have a bunch of local code/drivers for this already. Even for
> testing the SCMI perf domain with OPPs. I can share them with you, if
> you are interested?

Yes, please do share. We would love to see your ideas on this so we can
come up with a better solutions together.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


