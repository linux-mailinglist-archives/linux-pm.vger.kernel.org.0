Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE04AA83C
	for <lists+linux-pm@lfdr.de>; Sat,  5 Feb 2022 12:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiBELBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Feb 2022 06:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbiBELBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Feb 2022 06:01:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A0C061346
        for <linux-pm@vger.kernel.org>; Sat,  5 Feb 2022 03:01:36 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id u130so7344816pfc.2
        for <linux-pm@vger.kernel.org>; Sat, 05 Feb 2022 03:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xRwgaQM0BsAY0ok2IVhGnoibEzVc6i5moeNN+qYt1Qo=;
        b=McvOl/QR4TD+7NbRhTJMkNd0PPWLAX4sfsDIdpv+OSJhkAAh4CbLNJZRxl2k+ZVJqI
         hk/ZPlq68Mjc8QBTG7SM6pjz8y1uuFGZ7GyF2FRPcUay2f+XffzH/TStBIYHnhnOrRL/
         wx2BRNotHjpOBaSYJDFTnjq3a0fALAJgpjEoUSztMhmL+b8Q0Cx5qa55Rxma2sMj6IB6
         +IsSGXrCng6XJHKL/lHaxAnXoosG0Lpz5sbUdgcPrVFTvSEUwoav1Y2x0X4RFBhSw5Zw
         VBv2Giew0gvKZIrE5bUk92k6yEKqpUZOB0ta054FeZg/15nQuS5HWuA/FkR6VFvGvRE3
         EB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRwgaQM0BsAY0ok2IVhGnoibEzVc6i5moeNN+qYt1Qo=;
        b=XYsxEsWb8lsqvJb2ssswZ1djZfVwQ0Xold+Q6rZdA+t27fgXQDpQvo5SBppWD00WG/
         V6F/c+QXTtw7a4UnQ03yjEqtLh5u8xCzOyJuPj20njgd7jzAM0+BXL3TzVX7is90Ktpc
         ToiPL29GKgKypBT0Qb/5YQhxcd+lJK+XMGZ7FS8Gvd/RKHn02kXzAK6cTkNSh+5SOav7
         yPRIbH5B1wvWcaN6y38SX9SnLTebIU45p75Dh1A1NNQ5zY8D7Vrr3P6ko2rREk1nj96U
         7juANNj30xpPqVgGCVoy9mE5VvaHHrTVU0dN9EHusTQRL/lLy9c7cmH4ga+e1lcZhJos
         JtNQ==
X-Gm-Message-State: AOAM53134/GxNKNZ/LnXadLgfjZj0Dth7Vq+1mGfhCZzXCA33uP1sRvF
        72dQbRMyl0FtriuQuhthH7t2SpmNhu4=
X-Google-Smtp-Source: ABdhPJxSU/2MvPnug0W2ytqBNg3uI4pOSjdOtbVv6RKN0B4vgFR77sVbsdS1SlHVw05L4krhaiv2xw==
X-Received: by 2002:a62:d143:: with SMTP id t3mr7350761pfl.52.1644058895456;
        Sat, 05 Feb 2022 03:01:35 -0800 (PST)
Received: from pek-khao-d2 (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id v9sm5914920pfu.60.2022.02.05.03.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 03:01:34 -0800 (PST)
Date:   Sat, 5 Feb 2022 19:01:30 +0800
From:   Kevin Hao <haokexin@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: governor: Use kobject release() method to
 free dbs_data
Message-ID: <Yf5ZCq1uPXp9BvPZ@pek-khao-d2>
References: <20220123124508.463305-1-haokexin@gmail.com>
 <20220123124508.463305-3-haokexin@gmail.com>
 <CAJZ5v0hPCxNgm4s7OBdM5Zb73onJqSfTVZ+AeNQCTZA5EP+TGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+yikCI5VhbB7F/vK"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hPCxNgm4s7OBdM5Zb73onJqSfTVZ+AeNQCTZA5EP+TGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--+yikCI5VhbB7F/vK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2022 at 07:19:32PM +0100, Rafael J. Wysocki wrote:
> On Sun, Jan 23, 2022 at 1:49 PM Kevin Hao <haokexin@gmail.com> wrote:
> >
> > The struct dbs_data embeds a struct gov_attr_set and
> > the struct gov_attr_set embeds a kobject. Since every kobject must have
> > a release() method and we can't use kfree() to free it directly,
> > so introduce cpufreq_dbs_data_release() to release the dbs_data via
> > the kobject::release() method. This fixes the calltrace like below:
> >   ODEBUG: free active (active state 0) object type: timer_list hint: de=
layed_work_timer_fn+0x0/0x34
> >   WARNING: CPU: 12 PID: 810 at lib/debugobjects.c:505 debug_print_objec=
t+0xb8/0x100
> >   Modules linked in:
> >   CPU: 12 PID: 810 Comm: sh Not tainted 5.16.0-next-20220120-yocto-stan=
dard+ #536
> >   Hardware name: Marvell OcteonTX CN96XX board (DT)
> >   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >   pc : debug_print_object+0xb8/0x100
> >   lr : debug_print_object+0xb8/0x100
> >   sp : ffff80001dfcf9a0
> >   x29: ffff80001dfcf9a0 x28: 0000000000000001 x27: ffff0001464f0000
> >   x26: 0000000000000000 x25: ffff8000090e3f00 x24: ffff80000af60210
> >   x23: ffff8000094dfb78 x22: ffff8000090e3f00 x21: ffff0001080b7118
> >   x20: ffff80000aeb2430 x19: ffff800009e8f5e0 x18: 0000000000000000
> >   x17: 0000000000000002 x16: 00004d62e58be040 x15: 013590470523aff8
> >   x14: ffff8000090e1828 x13: 0000000001359047 x12: 00000000f5257d14
> >   x11: 0000000000040591 x10: 0000000066c1ffea x9 : ffff8000080d15e0
> >   x8 : ffff80000a1765a8 x7 : 0000000000000000 x6 : 0000000000000001
> >   x5 : ffff800009e8c000 x4 : ffff800009e8c760 x3 : 0000000000000000
> >   x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001474ed040
> >   Call trace:
> >    debug_print_object+0xb8/0x100
> >    __debug_check_no_obj_freed+0x1d0/0x25c
> >    debug_check_no_obj_freed+0x24/0xa0
> >    kfree+0x11c/0x440
> >    cpufreq_dbs_governor_exit+0xa8/0xac
> >    cpufreq_exit_governor+0x44/0x90
> >    cpufreq_set_policy+0x29c/0x570
> >    store_scaling_governor+0x110/0x154
> >    store+0xb0/0xe0
> >    sysfs_kf_write+0x58/0x84
> >    kernfs_fop_write_iter+0x12c/0x1c0
> >    new_sync_write+0xf0/0x18c
> >    vfs_write+0x1cc/0x220
> >    ksys_write+0x74/0x100
> >    __arm64_sys_write+0x28/0x3c
> >    invoke_syscall.constprop.0+0x58/0xf0
> >    do_el0_svc+0x70/0x170
> >    el0_svc+0x54/0x190
> >    el0t_64_sync_handler+0xa4/0x130
> >    el0t_64_sync+0x1a0/0x1a4
> >   irq event stamp: 189006
> >   hardirqs last  enabled at (189005): [<ffff8000080849d0>] finish_task_=
switch.isra.0+0xe0/0x2c0
> >   hardirqs last disabled at (189006): [<ffff8000090667a4>] el1_dbg+0x24=
/0xa0
> >   softirqs last  enabled at (188966): [<ffff8000080106d0>] __do_softirq=
+0x4b0/0x6a0
> >   softirqs last disabled at (188957): [<ffff80000804a618>] __irq_exit_r=
cu+0x108/0x1a4
> >
> > Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks=
 for governor tunables")
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 20 +++++++++++++-------
> >  drivers/cpufreq/cpufreq_governor.h |  1 +
> >  2 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index 63f7c219062b..55c80319d268 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -388,6 +388,15 @@ static void free_policy_dbs_info(struct policy_dbs=
_info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > +static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +{
> > +       struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> > +       struct dbs_governor *gov =3D dbs_data->gov;
> > +
> > +       gov->exit(dbs_data);
> > +       kfree(dbs_data);
> > +}
> > +
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> >         struct dbs_governor *gov =3D dbs_governor_of(policy);
> > @@ -425,6 +434,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >                 goto free_policy_dbs_info;
> >         }
> >
> > +       dbs_data->gov =3D gov;
> >         gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
> >
> >         ret =3D gov->init(dbs_data);
> > @@ -447,6 +457,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > +       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > @@ -488,13 +499,8 @@ void cpufreq_dbs_governor_exit(struct cpufreq_poli=
cy *policy)
> >
> >         policy->governor_data =3D NULL;
> >
> > -       if (!count) {
> > -               if (!have_governor_per_policy())
> > -                       gov->gdbs_data =3D NULL;
> > -
> > -               gov->exit(dbs_data);
>=20
> Good catch, but it is unclear to me why gov->exit() cannot be called from=
 here.

The kobject_put(&attr_set->kobj) is invoked before this.
  cpufreq_dbs_governor_exit()
    gov_attr_set_put()
      kobject_put(&attr_set->kobj)

When the CONFIG_DEBUG_KOBJECT_RELEASE is not enabled, the invocation of kob=
ject_put() would
cause the dbs_data to be released immediately. So we have to move the gov->=
exit(dbs_data) before
the release of dbs_data.

Thanks,
Kevin

>=20
> > -               kfree(dbs_data);
> > -       }
> > +       if (!count && !have_governor_per_policy())
> > +               gov->gdbs_data =3D NULL;
> >
> >         free_policy_dbs_info(policy_dbs, gov);
> >
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index bab8e6140377..a6de26318abb 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -37,6 +37,7 @@ enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
> >  /* Governor demand based switching data (per-policy or global). */
> >  struct dbs_data {
> >         struct gov_attr_set attr_set;
> > +       struct dbs_governor *gov;
> >         void *tuners;
> >         unsigned int ignore_nice_load;
> >         unsigned int sampling_rate;
> > --
> > 2.31.1
> >

--+yikCI5VhbB7F/vK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmH+WQkACgkQk1jtMN6u
sXGu9Qf/QR5En646i1/VDjhuX9z1d1eGIi0gBBZl7DGJxAb9FFngbBP7R25/UVi+
pbimn9bA5OnKYteF7ZNMHnrwqcexEp53HTGXAEXcOBcHq6H1YFSE1c8gmNAU3W0Q
SkHajGD6TmnBmVUQdGZne5FS6xu80ZX7KfEeSrRN578PF94O9wOladOBtC5aC4/O
dkftI5VrIinYe2OvyyA4scMbcI8EOing1q9YAehjG5LpzkgPx5fQ93MTtV5BNEz8
ByU5ghe34uhz8A//DWXVOZ0pGcm4pmwWNzsBYHww+HDXD9NfPpZ0ftauI5Z9JbX8
p6GHdq7N5KYzAh8YivizVJrdG0hsXg==
=RlWS
-----END PGP SIGNATURE-----

--+yikCI5VhbB7F/vK--
