Return-Path: <linux-pm+bounces-32800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876BFB2F581
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 12:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9704316EBB5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9C2DC331;
	Thu, 21 Aug 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFxjXaCX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94C38DF9;
	Thu, 21 Aug 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772689; cv=none; b=JcawnnfyDz/ZfejORzVIQp/W+9wI09if1quYbpE0jlQUvUVTu9fnPitAJs3Nsw5IlZiqNV6wALRHc8db4jS8njslOtH9KFt36V0ar8a5nsel+MOA4hZc+tAitJb15OzbMGEfJrccP/Bz8tbqf53p1P7AiQZISEa75WOmaDPARaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772689; c=relaxed/simple;
	bh=G9mJnjqmrtvpPM0zJWEXYJ8JaOtAlFKXs3kwxTdD7S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+YOiuUcRJ4WTWbi2KBJ516cduVftOY35h8dqqunNy8AaZ+XlAbb0BqJBronk2QsNkXaU4+v32rxY3mOzJG0IPbsllK6uritjkLA+Fnj1NFsSpJUzNN5I14SLIMjX1vAiT0jYVAnbcUnvywGQR9cLsD2Kve0tpqDpEOIXDYQYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFxjXaCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8993C113CF;
	Thu, 21 Aug 2025 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755772688;
	bh=G9mJnjqmrtvpPM0zJWEXYJ8JaOtAlFKXs3kwxTdD7S4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FFxjXaCXPuykXr+BPJETgYLs2UNKUF1LRG5OYKD6uQWHhWw+lcxuVFcXjfDOSNFET
	 9yECXxLXWsrIsRRnwaeGy4SWpNhLcVuQEQ895mO78tAtsyHBGg6OiYzG9dsKv0Bqpt
	 Fjdega+uNLbj7s8szAlj6NtSY3WtM2eEZvrY8q2SOD9e0SDRjWs1zL4OJvPvT6lt7Z
	 xK+9hYDv0Eo9zQ2bhbedy8tckq+NArEYWLjkopdsAonFp/2MmcVIv+ynMoSr6gsjGq
	 R7sBW3T/8QeAfAsKKCDZdBjNDp5Wz7fRV0NfxADu1q+dl12z/8yRmhfHUWmZ1XWgUP
	 jflBVmzj2iidw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-435de7aebb7so572424b6e.2;
        Thu, 21 Aug 2025 03:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpaLycMl/eheG4hQNV2rq/g6EbH0wpOeKXthDIYY3eTrQYhIOSUyHXjBils9ZOfKFq79kQnFXKO3wGZ+o=@vger.kernel.org, AJvYcCXgJmlmUtIRm8lr1EtlFWM13Mo5UJQ28ifvunfDURyVk6dYxskqtPiKKZ05tU3m8JMQ/BhTdxPLyMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUu9qR59LY38QIwF1nlCy9woyX5Xe/hPrQPZPCWAhOlUi8wE/6
	QF0qkT5RpaUIm/mKbREl2ZWBRZBtEifNB96qE6g0wbiXJcSanCPFI73AI4vKJobJldF9Wfb1M5M
	rS0XTGcJ0A436cYpueXYd639W3Lcz4A8=
X-Google-Smtp-Source: AGHT+IEckl+WlyJY3nspWaWPPtapd2m0T16J777lmKFZjrclTqeAeL6u50agJ/OwYkAYDpiC4GPsO8M3+3/XW5jjevQ=
X-Received: by 2002:a05:6808:2393:b0:434:ca4:aa0e with SMTP id
 5614622812f47-4377d6b1ecemr819758b6e.1.1755772688005; Thu, 21 Aug 2025
 03:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com> <20250721124104.806120-2-quic_zhonhan@quicinc.com>
In-Reply-To: <20250721124104.806120-2-quic_zhonhan@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Aug 2025 12:37:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0heLbA5Bfa2NqAGeOn_=N2+CMEQ8HWRgp25Ob0bGYDLZQ@mail.gmail.com>
X-Gm-Features: Ac12FXyHfNWxX3vClRTcxiceZdF3Lavemo2zfOmhvSrDjeKdUaRSRd2ATAsaIdY
Message-ID: <CAJZ5v0heLbA5Bfa2NqAGeOn_=N2+CMEQ8HWRgp25Ob0bGYDLZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PM: QoS: Add support for CPU affinity latency PM QoS
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, tony.luck@intel.com, 
	reinette.chatre@intel.com, Dave.Martin@arm.com, james.morse@arm.com, 
	ulf.hansson@linaro.org, amit.kucheria@linaro.org, christian.loehle@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:41=E2=80=AFPM Zhongqiu Han <quic_zhonhan@quicinc.=
com> wrote:
>
> Currently, the PM QoS framework supports global CPU latency QoS and
> per-device CPU latency QoS requests. An example of using global CPU
> latency QoS is a commit 2777e73fc154 ("scsi: ufs: core: Add CPU latency
> QoS support for UFS driver") that improved random io performance by 15%
> for ufs on specific device platform.
>
> However, this prevents all CPUs in the system from entering C states.
> Typically, some threads or drivers know which specific CPUs they are
> interested in. For example, drivers with IRQ affinity only want interrupt=
s
> to wake up and be handled on specific CPUs. Similarly, kernel thread boun=
d
> to specific CPUs through affinity only care about the latency of those
> particular CPUs.
>
> This patch introduces support for partial CPUs PM QoS using a CPU affinit=
y
> mask, allowing flexible and more precise latency QoS settings for specifi=
c
> CPUs. This can help save power, especially on heterogeneous platforms wit=
h
> big and little cores, as well as some power-conscious embedded systems fo=
r
> example:
>
>                         driver A       rt kthread B      module C
>   CPU IDs (mask):         0-3              2-5              6-7
>   target latency(us):     20               30               100
>                           |                |                |
>                           v                v                v
>                           +---------------------------------+
>                           |        PM  QoS  Framework       |
>                           +---------------------------------+
>                           |                |                |
>                           v                v                v
>   CPU IDs (mask):        0-3            2-3,4-5            6-7
>   runtime latency(us):   20             20, 30             100
>
> Implement this support based on per-device CPU latency PM QoS.

I have a few concerns regarding this patch.

The first one is the naming.

You want to be able to set wakeup latency QoS limits for multiple CPUs
at the same time.  Fair enough, but what does it have to do with
affinity of any sort?

Why don't you call the functions cpu_latency_qos_add_multiple() and so on?

> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  include/linux/pm_qos.h |  40 +++++++++++
>  kernel/power/qos.c     | 160 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 200 insertions(+)
>
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 4a69d4af3ff8..2dbad825f8bd 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -131,6 +131,15 @@ enum pm_qos_req_action {
>         PM_QOS_REMOVE_REQ       /* Remove an existing request */
>  };
>
> +/* cpu affinity pm latency qos request handle */
> +struct cpu_affinity_qos_req {
> +       struct list_head list;

Is the list really an adequate data structure here?

The number of CPUs in the mask is known at the request addition time
and it fails completely if the request cannot be added for one CPU
IIUC, so why don't you use an array of requests instead?

> +       union {
> +               struct dev_pm_qos_request req;
> +               void *req_ptr;
> +       };

Why do you need the union here?

Checking if the request is active only requires inspecting one CPU
involved in it AFAICS.

> +};
> +
>  static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *r=
eq)
>  {
>         return req->dev !=3D NULL;
> @@ -208,6 +217,13 @@ static inline s32 dev_pm_qos_raw_resume_latency(stru=
ct device *dev)
>                 PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
>                 pm_qos_read_value(&dev->power.qos->resume_latency);
>  }
> +
> +int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
> +                                 const cpumask_t *affinity_mask, s32 lat=
ency_value);
> +int cpu_affinity_latency_qos_remove(struct cpu_affinity_qos_req *pm_req)=
;
> +int cpu_affinity_latency_qos_release(struct cpu_affinity_qos_req *pm_req=
);

Why is a separate release function needed?

Also, why don't you think that a separate function for updating an
existing request would be useful?

> +bool cpu_affinity_latency_qos_active(struct cpu_affinity_qos_req *pm_req=
);
> +void wakeup_qos_affinity_idle_cpu(int cpu);
>  #else
>  static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device =
*dev,
>                                                           s32 mask)
> @@ -289,6 +305,30 @@ static inline s32 dev_pm_qos_raw_resume_latency(stru=
ct device *dev)
>  {
>         return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  }
> +
> +static inline int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_r=
eq *pm_req,
> +                                               const cpumask_t *affinity=
_mask,
> +                                               s32 latency_value)
> +{
> +       return 0;
> +}
> +
> +static inline int cpu_affinity_latency_qos_remove(
> +                  struct cpu_affinity_qos_req *pm_req)
> +{
> +       return 0;
> +}
> +static inline int cpu_affinity_latency_qos_release(
> +                  struct cpu_affinity_qos_req *pm_req)
> +{
> +       return 0;
> +}
> +static inline bool cpu_affinity_latency_qos_active(
> +                   struct cpu_affinity_qos_req *pm_req)
> +{
> +       return false;
> +}
> +static inline void wakeup_qos_affinity_idle_cpu(int cpu) {}
>  #endif
>
>  static inline int freq_qos_request_active(struct freq_qos_request *req)
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 4244b069442e..5e507ed8d077 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -335,6 +335,166 @@ void cpu_latency_qos_remove_request(struct pm_qos_r=
equest *req)
>  }
>  EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_request);
>
> +#ifdef CONFIG_PM
> +
> +/**
> + * wakeup_qos_affinity_idle_cpu - break one specific cpu out of idle.
> + * @cpu: the CPU to be woken up from idle.
> + */
> +void wakeup_qos_affinity_idle_cpu(int cpu)
> +{
> +       preempt_disable();
> +       if (cpu !=3D smp_processor_id() && cpu_online(cpu))
> +               wake_up_if_idle(cpu);
> +       preempt_enable();
> +}

This duplicates code from wake_up_all_idle_cpus() that duplication is
easily avoidable.

> +
> +/**
> + * cpu_affinity_latency_qos_add - Add new CPU affinity latency QoS reque=
st.
> + * @pm_req: Pointer to a preallocated handle.
> + * @affinity_mask: Mask to determine which CPUs need latency QoS.
> + * @latency_value: New requested constraint value.
> + *
> + * Use @latency_value to initialize the request handle pointed to by @pm=
_req,
> + * insert it as a new entry to the CPU latency QoS list and recompute th=
e
> + * effective QoS constraint for that list, @affinity_mask determine whic=
h CPUs
> + * need the latency QoS.
> + *
> + * Callers need to save the handle for later use in updates and removal =
of the
> + * QoS request represented by it.
> + *

It would be good to also say that callers are responsible for
synchronizing the calls to add and remove functions for the same
request.

> + * Returns 0 or a positive value on success, or a negative error code on=
 failure.
> + */
> +int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
> +                                 const cpumask_t *affinity_mask,
> +                                 s32 latency_value)
> +{
> +       int cpu;
> +       cpumask_t actual_mask;
> +       struct cpu_affinity_qos_req *cpu_pm_req;
> +       int ret =3D 0;
> +
> +       if (!pm_req) {
> +               pr_err("%s: invalid PM Qos request\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (cpu_affinity_latency_qos_active(pm_req)) {
> +               WARN(1, "%s called for already added request\n", __func__=
);
> +               return -EBUSY;
> +       }

The usual pattern for checks like this is

if (WARN(cpu_affinity_latency_qos_active(pm_req), message))
         return error;

And, which is not related to the above, if a function is defined in
the same file as its caller, I prefer it to be defined before its
caller.

> +
> +       INIT_LIST_HEAD(&pm_req->list);
> +
> +       if (!affinity_mask || cpumask_empty(affinity_mask) ||
> +           latency_value < 0) {
> +               pr_err("%s: invalid PM Qos request value\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       for_each_cpu(cpu, affinity_mask) {
> +               cpu_pm_req =3D kzalloc(sizeof(struct cpu_affinity_qos_req=
),
> +                                    GFP_KERNEL);
> +               if (!cpu_pm_req) {
> +                       ret =3D -ENOMEM;
> +                       goto out_err;
> +               }
> +               ret =3D dev_pm_qos_add_request(get_cpu_device(cpu),
> +                                            &cpu_pm_req->req,
> +                                            DEV_PM_QOS_RESUME_LATENCY,
> +                                            latency_value);
> +               if (ret < 0) {
> +                       pr_err("failed to add latency req for cpu%d", cpu=
);

Why do you want to print an error message here?  Is this anything that
the sysadmin should know about?  If not, then maybe dev_dbg() should
be sufficient?

> +                       kfree(cpu_pm_req);
> +                       goto out_err;
> +               } else if (ret > 0) {
> +                       wakeup_qos_affinity_idle_cpu(cpu);
> +               }
> +
> +               cpumask_set_cpu(cpu, &actual_mask);
> +               list_add(&cpu_pm_req->list, &pm_req->list);
> +       }
> +
> +       pr_info("PM Qos latency: %d added on cpus %*pb\n", latency_value,
> +               cpumask_pr_args(&actual_mask));

I'm not sure why the actual_mask variable is needed.  AFAICS, the
function fails anyway if the request cannot be added for any CPU in
the original mask.

> +       pm_req->req_ptr =3D pm_req;
> +       return ret;
> +
> +out_err:
> +       cpu_affinity_latency_qos_release(pm_req);
> +       pr_err("failed to add PM QoS latency req, removed all added reque=
sts\n");

A message about this has already been printed.  Why print another one?

> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_add);
> +
> +
> +/**
> + * cpu_affinity_latency_qos_remove - Remove an existing CPU affinity lat=
ency QoS.
> + * @pm_req: Handle to the QoS request to be removed.
> + *
> + * Remove the CPU latency QoS request represented by @pm_req from the CP=
U latency
> + * QoS list. This handle must have been previously initialized and added=
 via
> + * cpu_affinity_latency_qos_add().
> + */
> +int cpu_affinity_latency_qos_remove(struct cpu_affinity_qos_req *pm_req)
> +{
> +       if (!pm_req) {
> +               pr_err("%s: invalid PM Qos request value\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (!cpu_affinity_latency_qos_active(pm_req)) {
> +               WARN(1, "%s called for unknown object\n", __func__);
> +               return -EINVAL;
> +       }

Same pattern comment as above applies here.

> +
> +       return cpu_affinity_latency_qos_release(pm_req);
> +}
> +EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_remove);
> +
> +/**
> + * cpu_affinity_latency_qos_release - Release pm_reqs latency QoS resour=
ce.
> + * @pm_req: QoS request to be released.
> + *
> + * Release pm_reqs managed CPU affinity latency QoS resource.
> + *
> + * Returns a negative value indicates failure.
> + */
> +int cpu_affinity_latency_qos_release(struct cpu_affinity_qos_req *pm_req=
)
> +{
> +       int ret =3D 0;
> +       struct cpu_affinity_qos_req *cpu_pm_req, *next;
> +
> +       list_for_each_entry_safe(cpu_pm_req, next, &pm_req->list, list) {
> +               ret =3D dev_pm_qos_remove_request(&cpu_pm_req->req);
> +               if (ret < 0)
> +                       pr_err("failed to remove qos request for %s\n",
> +                              dev_name(cpu_pm_req->req.dev));
> +               list_del(&cpu_pm_req->list);
> +               kfree(cpu_pm_req);
> +               cpu_pm_req =3D NULL;
> +       }
> +
> +       memset(pm_req, 0, sizeof(*pm_req));
> +       return ret;
> +}
> +
> +/**
> + * cpu_affinity_latency_qos_active - Check if a CPU affinity latency QoS
> + * request is active.
> + * @pm_req: Handle to the QoS request.
> + *
> + * Return: 'true' if @pm_req has been added to the CPU latency QoS list,
> + * 'false' otherwise.
> + */
> +bool cpu_affinity_latency_qos_active(struct cpu_affinity_qos_req *pm_req=
)
> +{
> +       return pm_req->req_ptr =3D=3D pm_req;
> +}
> +EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_active);
> +
> +#endif /* CONFIG_PM */
> +
>  /* User space interface to the CPU latency QoS via misc device. */
>
>  static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
> --

I'll look at the rest of the series whey all of my comments on this
patch have been addressed.

Thanks!

