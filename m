Return-Path: <linux-pm+bounces-34169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFDAB497DE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F022E175AFE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0F3126D2;
	Mon,  8 Sep 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3i5G/Rd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFE1C54A9;
	Mon,  8 Sep 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355065; cv=none; b=h88dFFS4I5LqRue1mS6tE6z/C4rpYjGmck+Kl9E4FBGKfAXRoj4XSJtpzmKcZTLUGFvuBEYLGAjgVqFsQw/Pk0N38X0HgwhZ4uMJnf17YkJfsMJnWiy1CJJrha6Fz2OQFyrF6pbErgbGbGxt9nhLdC6sz6H5HfDuU/u2bliDcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355065; c=relaxed/simple;
	bh=nWEoipxkixJ0ZSVMZ+anwIJJHAzKU1PzGvRYeOz7A2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/Ofdr6woolssg84Bdyo/AJppxiUjl8f2xBaYnv0OYg2I8clXMFYvIOvkCZwUPWCicPdP9RIN4a/B3Gg1yI0CCiNgs1/Iajf4uuif9rcbnoJPP5DMPR5uL6SGwzk8Z7RD8Gw3zHeOVUbO3MG6DguX52R+u+K1QMYe5ECtex0/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3i5G/Rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511CAC4CEF1;
	Mon,  8 Sep 2025 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355065;
	bh=nWEoipxkixJ0ZSVMZ+anwIJJHAzKU1PzGvRYeOz7A2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X3i5G/RdiRbl3rghKx+J0/9l2UnexHNmFMJRtXZscG788Y2jXQhf1Xm5Zg7rGzLIl
	 Dzlv7nTvZU65UGkzzTh4kDwwDhcqX5CEYhhX+LuaC6mIXkf6j+6X8QsrWXfZ3UbpHO
	 xZWkGL/NawzrT8mwIKFX+txwO6tbxyPakQI6nRXYyp+NTEv6fIHi6zmwOr0BWLEcL9
	 xj3X5fIhpLxgHoQQSO0zPD2sebB8ZbNZItYoVOhKs3eAc5ZA3lbZ25fPKcWBNqXEqR
	 kniw3/J4KwHS1RUgpDMjv4Fzz5UHEC1qMDsSaHIpLGK0HTxoOTmYiEcL1OYdWCzn0A
	 tTXkZIOVcOL5g==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74381e2079fso4594270a34.0;
        Mon, 08 Sep 2025 11:11:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdvMe+xUrhH5+B1FTxYZxyKg4I/Vg/KyXYBN7BrbLrQOIa3RN+hOh8yHXdj8mAufwwrDBArmVwkM3P9MU=@vger.kernel.org, AJvYcCUjvnutNnJWYCSVStsxIpZR1gHZ80XZOpzg9aN/6pKVPvK07TK141Ri3QYaLX/kS4DIOtqF0SiLJgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5K6DNwMoGtFUiosiMDTtXA4kYfpo+6GPhdqPbYmfCg6semlpM
	SP+NBQFXwwzh9RAk/K6M8/PRN0PT6Mm6Lrb5SiDff61+RMSBX6FK9838TjVTrURTgqr3p8ocA7C
	k+D423T4cnGQY/jCHA+6yzr5WylakJnA=
X-Google-Smtp-Source: AGHT+IFiitgeeTBPNSpDbw8jvhQbN7AECqqWQ/TSfG9Sb7DVX2C86yumV8yMSi+B9DEOTCFkcV/2MDxK8YGpH7kCZoA=
X-Received: by 2002:a05:6830:6f85:b0:745:a336:7260 with SMTP id
 46e09a7af769-74c66210137mr6054718a34.0.1757355064598; Mon, 08 Sep 2025
 11:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5028967.GXAFRqVoOG@rafael.j.wysocki> <3026597.e9J7NaK4W3@rafael.j.wysocki>
 <a6104009-d0ad-4d76-9079-0e81e74cd32a@kylinos.cn>
In-Reply-To: <a6104009-d0ad-4d76-9079-0e81e74cd32a@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Sep 2025 20:10:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i+GBpv_mGnYMbNjr2d1pvXJ_NqYCp8+pgOTNpCTuue8A@mail.gmail.com>
X-Gm-Features: Ac12FXy6ccO5a6Pn9WiTjVO6ify4uZa0VEWYJUc61SrErznfdiLdlYggytFVXC0
Message-ID: <CAJZ5v0i+GBpv_mGnYMbNjr2d1pvXJ_NqYCp8+pgOTNpCTuue8A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cpufreq: intel_pstate: Rearrange freq QoS updates
 using __free()
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:53=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.cn=
> wrote:
>
>
> =E5=9C=A8 2025/9/5 21:52, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Move the code from the for_each_possible_cpu() loop in update_qos_reque=
st()
> > to a separate function and use __free() for cpufreq policy reference
> > counting in it to avoid having to call cpufreq_cpu_put() repeatedly (or
> > using goto).
> >
> > While at it, rename update_qos_request() to update_qos_requests()
> > because it updates multiple requests in one go.
> >
> > No intentional functional impact.
> >
> > Link: https://lore.kernel.org/linux-pm/CAJZ5v0gN1T5woSF0tO=3DTbAh+2-sWz=
xFjWyDbB7wG2TFCOU01iQ@mail.gmail.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/cpufreq/intel_pstate.c |   65 ++++++++++++++++++++-----------=
----------
> >   1 file changed, 32 insertions(+), 33 deletions(-)
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1693,43 +1693,42 @@ unlock_driver:
> >       return count;
> >   }
> >
> > -static void update_qos_request(enum freq_qos_req_type type)
> > +static void update_cpu_qos_request(int cpunum, enum freq_qos_req_type =
type)
> >   {
> > +     struct cpudata *cpu =3D all_cpu_data[cpunum];
>
>
> Maybe the parameter could be named int cpu instead of cpunum, and the
> struct cpudata * variable could be renamed to cpudata =E2=80=94 this migh=
t read
> a bit cleaner and help reduce potential confusion.

Yeah, you are right that it could be done this way.

I kind of wanted the new code to be possibly similar to the new one,
but since this is a new function anyway, I guess this doesn't matter.
I'll change the naming when applying the patch.

> I also noticed that in this driver some places use one naming style and
> others use another, so it might be worth unifying the style here.

Well, I'm not sure about this.

I guess it may be confusing sometimes, but then I'm not sure if that
justifies the code churn that would result from changing it.

> Other than that, looks good to me.
>
> >       struct freq_qos_request *req;
> > -     struct cpufreq_policy *policy;
> > -     int i;
> > +     unsigned int freq, perf_pct;
> >
> > -     for_each_possible_cpu(i) {
> > -             struct cpudata *cpu =3D all_cpu_data[i];
> > -             unsigned int freq, perf_pct;
> > -
> > -             policy =3D cpufreq_cpu_get(i);
> > -             if (!policy)
> > -                     continue;
> > -
> > -             req =3D policy->driver_data;
> > -             if (!req) {
> > -                     cpufreq_cpu_put(policy);
> > -                     continue;
> > -             }
> > -
> > -             if (hwp_active)
> > -                     intel_pstate_get_hwp_cap(cpu);
> > -
> > -             if (type =3D=3D FREQ_QOS_MIN) {
> > -                     perf_pct =3D global.min_perf_pct;
> > -             } else {
> > -                     req++;
> > -                     perf_pct =3D global.max_perf_pct;
> > -             }
> > +     struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpunum);
> > +     if (!policy)
> > +             return;
> > +
> > +     req =3D policy->driver_data;
> > +     if (!req)
> > +             return;
> > +
> > +     if (hwp_active)
> > +             intel_pstate_get_hwp_cap(cpu);
> > +
> > +     if (type =3D=3D FREQ_QOS_MIN) {
> > +             perf_pct =3D global.min_perf_pct;
> > +     } else {
> > +             req++;
> > +             perf_pct =3D global.max_perf_pct;
> > +     }
> >
> > -             freq =3D DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, =
100);
> > +     freq =3D DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
> >
> > -             if (freq_qos_update_request(req, freq) < 0)
> > -                     pr_warn("Failed to update freq constraint: CPU%d\=
n", i);
> > +     if (freq_qos_update_request(req, freq) < 0)
> > +             pr_warn("Failed to update freq constraint: CPU%d\n", cpun=
um);
> > +}
> >
> > -             cpufreq_cpu_put(policy);
> > -     }
> > +static void update_qos_requests(enum freq_qos_req_type type)
> > +{
> > +     int i;
> > +
> > +     for_each_possible_cpu(i)
> > +             update_cpu_qos_request(i, type);
> >   }
> >
> >   static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attr=
ibute *b,
> > @@ -1758,7 +1757,7 @@ static ssize_t store_max_perf_pct(struct
> >       if (intel_pstate_driver =3D=3D &intel_pstate)
> >               intel_pstate_update_policies();
> >       else
> > -             update_qos_request(FREQ_QOS_MAX);
> > +             update_qos_requests(FREQ_QOS_MAX);
> >
> >       mutex_unlock(&intel_pstate_driver_lock);
> >
> > @@ -1792,7 +1791,7 @@ static ssize_t store_min_perf_pct(struct
> >       if (intel_pstate_driver =3D=3D &intel_pstate)
> >               intel_pstate_update_policies();
> >       else
> > -             update_qos_request(FREQ_QOS_MIN);
> > +             update_qos_requests(FREQ_QOS_MIN);
> >
> >       mutex_unlock(&intel_pstate_driver_lock);
> >
> >
> >
> >
> Reviewed-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

Thanks!

