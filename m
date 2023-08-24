Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CB787C2B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 01:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjHXXzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 19:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjHXXz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 19:55:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B0C1BEB
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 16:55:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fee8af9cb9so3262875e9.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692921320; x=1693526120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX05eZujr6ummHB+Pea1XhhUnFK9IwJ2yu2gDI+SJm8=;
        b=Srov+QkHs2cin5P6Gpvk7cggs0Ybz3fiaRiPt64mD1944AwgjzvLWr9R+RbKF1X0WS
         hEEiUJ2p5asZ4V7sE4SBJTexwQ/icccNH1W0vDZ3l/Ig3lnr7p2lpaC8JsGc3W4geG/J
         NHO48kKYL6Dx6PQMX+39Zx2xLYN23ZbQMeL34+IZyJfLL9R8mZfCAHra4PuwdLkvrOA2
         sX6gyiUXVDfBgNsb+tOf2o4twHRdW8x33VpwoeUPVufC4UUkOFyluK1SPCAjxRhWkyI7
         yiGS2zEF82ZzW0LuJ52QkpLINrIGC+F3LOKUHcu8YLyi/dAwX7xRZ5M40AE4dHBNcWNP
         ZtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692921320; x=1693526120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX05eZujr6ummHB+Pea1XhhUnFK9IwJ2yu2gDI+SJm8=;
        b=TuDgn/iOmcy+8CMH7VAlso+0zHPJACLC336UJmD81LROcJ1CoMhPMYPe79o2T8EVss
         k5LFp0xBaNfIBQArrEOYZCK3hlRCVJRT8UkiZ6j7pWVrzl2b1f+N4WFXbRx5R8Ri2I7Z
         TvKMHGWgzPJ1+/+BhnGl/AQgzWkFp6Ry5TqCm830ymf1zwbfX1q5VG5fKnZ3cGAqHBVJ
         JX1jETRmPcqdyna4PFtvr8GzKYQeyfeVoW1p2QcuRDLT4921aBqlyR1/p50/pYrRun15
         tJsRQ8MoC0lERiWtxb+yWE/lFBGS0qvU0CB7kwyFI2LCY5ywcpHqbKVmw2q2BaiFjnO+
         0KhA==
X-Gm-Message-State: AOJu0YyLrfSf4xeMcVcCifLbYukiH02jTAgN6vrtXxtyFnkaI1dcASb9
        9bk4NJFcZZOKuh+8y4BHW4ojxH+FZ1dadpudA/Tj7g==
X-Google-Smtp-Source: AGHT+IEKKRFgT1AIiAj5V+jfJ7uzLR7N1dqf90rEAhqEImaOMkv1VEhYmGPXuHbG9KGpD9mr23TjMP+VF0zdHPfDmTE=
X-Received: by 2002:a5d:6949:0:b0:314:1e47:8bc2 with SMTP id
 r9-20020a5d6949000000b003141e478bc2mr12723342wrw.0.1692921319624; Thu, 24 Aug
 2023 16:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com> <20230731174613.4133167-3-davidai@google.com>
 <80f47262-9354-472f-8122-5ae262c0a46d@quicinc.com> <CABN1KCKUt3GN=LqF9AK3Dc+4x98Asj-wpW4UNYsfjRz4Di8N5Q@mail.gmail.com>
 <29bae535-6292-400e-813d-063498adbfce@quicinc.com>
In-Reply-To: <29bae535-6292-400e-813d-063498adbfce@quicinc.com>
From:   David Dai <davidai@google.com>
Date:   Thu, 24 Aug 2023 16:55:08 -0700
Message-ID: <CABN1KCKShVq5mQQFr7GcQ7WgzpcctsTm8jRdWnCP3Dap_yhiHQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 6, 2023 at 8:22=E2=80=AFPM Pavan Kondeti <quic_pkondeti@quicinc=
.com> wrote:
>
> On Fri, Aug 04, 2023 at 04:46:11PM -0700, David Dai wrote:
> > Hi Pavan,
> >
> > Thanks for reviewing!
> >
> > On Wed, Aug 2, 2023 at 9:18=E2=80=AFPM Pavan Kondeti <quic_pkondeti@qui=
cinc.com> wrote:
> > >
> > > On Mon, Jul 31, 2023 at 10:46:09AM -0700, David Dai wrote:
> > > > Introduce a virtualized cpufreq driver for guest kernels to improve
> > > > performance and power of workloads within VMs.
> > > >
> > > > This driver does two main things:
> > > >
> > > > 1. Sends the frequency of vCPUs as a hint to the host. The host use=
s the
> > > > hint to schedule the vCPU threads and decide physical CPU frequency=
.
> > > >
> > > > 2. If a VM does not support a virtualized FIE(like AMUs), it querie=
s the
> > > > host CPU frequency by reading a MMIO region of a virtual cpufreq de=
vice
> > > > to update the guest's frequency scaling factor periodically. This e=
nables
> > > > accurate Per-Entity Load Tracking for tasks running in the guest.
> > > >
> > > > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: David Dai <davidai@google.com>
> > >
> > > [...]
> > >
> > > > +static void virt_scale_freq_tick(void)
> > > > +{
> > > > +     struct cpufreq_policy *policy =3D cpufreq_cpu_get(smp_process=
or_id());
> > > > +     struct virt_cpufreq_drv_data *data =3D policy->driver_data;
> > > > +     u32 max_freq =3D (u32)policy->cpuinfo.max_freq;
> > > > +     u64 cur_freq;
> > > > +     u64 scale;
> > > > +
> > > > +     cpufreq_cpu_put(policy);
> > > > +
> > > > +     cur_freq =3D (u64)data->ops->get_freq(policy);
> > > > +     cur_freq <<=3D SCHED_CAPACITY_SHIFT;
> > > > +     scale =3D div_u64(cur_freq, max_freq);
> > > > +
> > > > +     this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > > > +}
> > > > +
> > >
> > > We expect the host to provide the frequency in kHz, can you please ad=
d a
> > > comment about it. It is not very obvious when you look at the
> > > REG_CUR_FREQ_OFFSET register name.
> >
> > I=E2=80=99ll include a KHZ in the offset names.
> >
>

Hi Pavan,

Apologies for the slow responses, I was out on vacation for the week
prior to last week.

> Sure, that would help. Also, can you limit the scale to
> SCHED_CAPACITY_SCALE? It may be possible that host may be running at a
> higher frequency than max_freq advertised on this guest.

Good catch, will include a check to limit freq_scale to SCHED_CAPACITY_SCAL=
E.

>
> > >
> > > > +
> > > > +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy=
 *policy,
> > > > +             unsigned int target_freq)
> > > > +{
> > > > +     virt_cpufreq_set_perf(policy);
> > > > +     return target_freq;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_target_index(struct cpufreq_policy *policy=
,
> > > > +             unsigned int index)
> > > > +{
> > > > +     return virt_cpufreq_set_perf(policy);
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > > > +{
> > > > +     struct virt_cpufreq_drv_data *drv_data =3D cpufreq_get_driver=
_data();
> > > > +     struct cpufreq_frequency_table *table;
> > > > +     struct device *cpu_dev;
> > > > +     int ret;
> > > > +
> > > > +     cpu_dev =3D get_cpu_device(policy->cpu);
> > > > +     if (!cpu_dev)
> > > > +             return -ENODEV;
> > > > +
> > > > +     ret =3D dev_pm_opp_of_add_table(cpu_dev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D dev_pm_opp_get_opp_count(cpu_dev);
> > > > +     if (ret <=3D 0) {
> > > > +             dev_err(cpu_dev, "OPP table can't be empty\n");
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &table);
> > > > +     if (ret) {
> > > > +             dev_err(cpu_dev, "failed to init cpufreq table: %d\n"=
, ret);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     policy->freq_table =3D table;
> > > > +     policy->dvfs_possible_from_any_cpu =3D false;
> > > > +     policy->fast_switch_possible =3D true;
> > > > +     policy->driver_data =3D drv_data;
> > > > +
> > > > +     /*
> > > > +      * Only takes effect if another FIE source such as AMUs
> > > > +      * have not been registered.
> > > > +      */
> > > > +     topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> > > > +
> > > > +     return 0;
> > > > +
> > > > +}
> > > > +
> > >
> > > Do we need to register as FIE source even with the below commit? By
> > > registering as a source, we are not supplying any accurate metric. We
> > > still fallback on the same source that cpufreq implements it.
> >
> > The arch_set_freq_scale() done at cpufreq driver=E2=80=99s frequency up=
dates
> > at cpufreq_freq_transition_end() and cpufreq_driver_fast_switch() only
> > represent the guest=E2=80=99s frequency request. However, this does not
> > accurately represent the physical CPU=E2=80=99s frequency that the vCPU=
 is
> > running on. E.g. There may be other processes sharing the same
> > physical CPU that results in a much higher CPU frequency than what=E2=
=80=99s
> > requested by the vCPU.
> >
>
> understood that policy->cur may not reflect the actual frequency. Is this
> something needs to be advertised to cpufreq core so that it query the
> underlying cpufreq driver and use it for frequency scale updates. This
> also gives userspace to read the actual frequency when read from sysfs.
>

Adding a ->get() callback in the driver to advertise to the cpufreq
core does not actually update the freq_scale if fast_switch is
enabled. Since fast_switch is required for performance reasons, I
don=E2=80=99t see value in adding ->get().

> In fact, cpufreq_driver_fast_switch() comment says that
> cpufreq_driver::fast_switch() should return the *actual* frequency and
> the same is used to update frequency scale updates. I understand that it
> depends on other things like if host defer the frequency switch, the
> value read from REG_CUR_FREQ_OFFSET may reflect the old value..
>
> May be a comment in code would help.
>

Sounds good, I'll include a comment.

Thanks,
David

> Thanks,
> Pavan
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
