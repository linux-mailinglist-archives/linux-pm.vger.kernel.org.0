Return-Path: <linux-pm+bounces-9706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0F911031
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 20:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C7EB2D832
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF11B3738;
	Thu, 20 Jun 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHCvVsuc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914B1B0115;
	Thu, 20 Jun 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905995; cv=none; b=nKf89cBdUlsN83cpbaA1LpbOik1JOJkAE1feD1N8a0wNWIW+Kmp1xT4jqp5SNzYQcHQxgCgBFJQZ1Ztqjwb7dEvjuCTppaDDMXMB25cM8rgHXvtXDeI7iLe9eKHmVBbIfjRyCsqwoSL3GeqedPO+5RxFEYWwF6p8rDNqB8d/d3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905995; c=relaxed/simple;
	bh=nVG7CVpLhAJO3U2nmGpfdbLsgF0BfMyDx1IhqJCBzJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpJ8FaJkHngjpmJVPh2kcTAClzCmKhC+zqLZUB9rsveseDd2/GiNr+/p3hH1rLouaI83DUq33rTzP7T6PmIJUBFKe7aD++N6tmCESfOXuYLM7O7b7dPlWzMsbbii2LIz+Avu5w7BGxLZ7fyTczp1CTR9Bi7uIqlcMiMhHu9NXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHCvVsuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C569C2BD10;
	Thu, 20 Jun 2024 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718905994;
	bh=nVG7CVpLhAJO3U2nmGpfdbLsgF0BfMyDx1IhqJCBzJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cHCvVsuckNDuV+P2qAL99lS1BzEE39qOp8rnJwRNVHyjqe1RctfwmXSRThCUq+f1N
	 o/5uNmt5YXBj/Rbz69Bbgx/SMnGm4GzCS8zYGdxlAMbS0oppObtl5HsQqDzimrIJjf
	 FNATuBPTRC0dpnswt5U8b1LwYuydgBlU1b+krBi3VwYHz9aonmaUUsSfae1xMOZDES
	 OWAlE6wU0xnzceKsM80biktmbw0nAXF9nKpHO9BD94x8WqjVzaDx/iT/BAvftGdHay
	 NfPRYpsK5VC4uKz0IOTvDGBM+/L99ZUCkn2OIbL5ky14ch2nb/jabH8Eekg6/HUtCy
	 Czh03Ta1xofkw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25075f3f472so71283fac.2;
        Thu, 20 Jun 2024 10:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL6WkjhDUgv4JMSsKgF0wGFWsCtrLXugWGqjtzJNwMGUElcPKwqQJbCT1W63hvg3ROXZwphK5TRsyPI8MpdD4FZZDwrozFqdwtCCFyN1WHd0WEh7nVo09AOf6J+7hRx3i6igmxL4U=
X-Gm-Message-State: AOJu0YwsflepiP0ec93sDg7cBXSPIBzR1BGVyziNvqCgKeLSL6UsKd11
	Yxm9WkYrmoHEnMIa9HYXKktYoucpU6DhKqwZrEac7sfKs3PWTQzvqpqXqbIq6eyeIPEP4UGZBvo
	RHbAGwVCIOS32azTP5wtgdL6XICc=
X-Google-Smtp-Source: AGHT+IHkJ6Wnwd2XfY78wAp+KV5TjKEz07L4rQL4orBKwMGWGqhR2kxJXq7Ldwfmq+2AYOl1JB8tljyfTRhj4wj0+4s=
X-Received: by 2002:a05:6870:e0cd:b0:254:d417:351f with SMTP id
 586e51a60fabf-25c948e316emr5988362fac.1.1718905993735; Thu, 20 Jun 2024
 10:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619081520.259971-1-perry.yuan@amd.com> <39014142-2232-4d8c-a51d-1c10a2278ad6@amd.com>
In-Reply-To: <39014142-2232-4d8c-a51d-1c10a2278ad6@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Jun 2024 19:53:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gCVoGtoOnXGy7YVBSgahLrLQ-OJoMhYDk1B3jGtNAmnQ@mail.gmail.com>
Message-ID: <CAJZ5v0gCVoGtoOnXGy7YVBSgahLrLQ-OJoMhYDk1B3jGtNAmnQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: update to sysfs_emit for safer buffer handling
To: Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, 
	Borislav.Petkov@amd.com, gautham.shenoy@amd.com, Alexander.Deucher@amd.com, 
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:00=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 6/19/2024 03:15, Perry Yuan wrote:
> > Replaced sprintf and scnprintf with sysfs_emit and sysfs_emit_at in the
> > cpufreq driver. This ensures safer buffer handling and consistency with
> > sysfs interfaces. Updated show_scaling_available_governors and related
> > functions for compliance with the new API.
> >
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.11 material with some edits in the changelog, thanks!

> > ---
> >   drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++-------------------
> >   1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e1a4730f4f8c..e76d8e2b4c87 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -608,7 +608,7 @@ EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_u=
s);
> >   static ssize_t show_boost(struct kobject *kobj,
> >                         struct kobj_attribute *attr, char *buf)
> >   {
> > -     return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
> > +     return sysfs_emit(buf, "%d\n", cpufreq_driver->boost_enabled);
> >   }
> >
> >   static ssize_t store_boost(struct kobject *kobj, struct kobj_attribut=
e *attr,
> > @@ -738,7 +738,7 @@ static struct cpufreq_governor *cpufreq_parse_gover=
nor(char *str_governor)
> >   static ssize_t show_##file_name                             \
> >   (struct cpufreq_policy *policy, char *buf)          \
> >   {                                                   \
> > -     return sprintf(buf, "%u\n", policy->object);    \
> > +     return sysfs_emit(buf, "%u\n", policy->object); \
> >   }
> >
> >   show_one(cpuinfo_min_freq, cpuinfo.min_freq);
> > @@ -759,11 +759,11 @@ static ssize_t show_scaling_cur_freq(struct cpufr=
eq_policy *policy, char *buf)
> >
> >       freq =3D arch_freq_get_on_cpu(policy->cpu);
> >       if (freq)
> > -             ret =3D sprintf(buf, "%u\n", freq);
> > +             ret =3D sysfs_emit(buf, "%u\n", freq);
> >       else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> > -             ret =3D sprintf(buf, "%u\n", cpufreq_driver->get(policy->=
cpu));
> > +             ret =3D sysfs_emit(buf, "%u\n", cpufreq_driver->get(polic=
y->cpu));
> >       else
> > -             ret =3D sprintf(buf, "%u\n", policy->cur);
> > +             ret =3D sysfs_emit(buf, "%u\n", policy->cur);
> >       return ret;
> >   }
> >
> > @@ -797,9 +797,9 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq=
_policy *policy,
> >       unsigned int cur_freq =3D __cpufreq_get(policy);
> >
> >       if (cur_freq)
> > -             return sprintf(buf, "%u\n", cur_freq);
> > +             return sysfs_emit(buf, "%u\n", cur_freq);
> >
> > -     return sprintf(buf, "<unknown>\n");
> > +     return sysfs_emit(buf, "<unknown>\n");
> >   }
> >
> >   /*
> > @@ -808,12 +808,11 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufr=
eq_policy *policy,
> >   static ssize_t show_scaling_governor(struct cpufreq_policy *policy, c=
har *buf)
> >   {
> >       if (policy->policy =3D=3D CPUFREQ_POLICY_POWERSAVE)
> > -             return sprintf(buf, "powersave\n");
> > +             return sysfs_emit(buf, "powersave\n");
> >       else if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> > -             return sprintf(buf, "performance\n");
> > +             return sysfs_emit(buf, "performance\n");
> >       else if (policy->governor)
> > -             return scnprintf(buf, CPUFREQ_NAME_PLEN, "%s\n",
> > -                             policy->governor->name);
> > +             return sysfs_emit(buf, "%s\n", policy->governor->name);
> >       return -EINVAL;
> >   }
> >
> > @@ -872,7 +871,7 @@ static ssize_t show_scaling_available_governors(str=
uct cpufreq_policy *policy,
> >       struct cpufreq_governor *t;
> >
> >       if (!has_target()) {
> > -             i +=3D sprintf(buf, "performance powersave");
> > +             i +=3D sysfs_emit(buf, "performance powersave");
> >               goto out;
> >       }
> >
> > @@ -881,11 +880,11 @@ static ssize_t show_scaling_available_governors(s=
truct cpufreq_policy *policy,
> >               if (i >=3D (ssize_t) ((PAGE_SIZE / sizeof(char))
> >                   - (CPUFREQ_NAME_LEN + 2)))
> >                       break;
> > -             i +=3D scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->na=
me);
> > +             i +=3D sysfs_emit_at(buf, i, "%s ", t->name);
> >       }
> >       mutex_unlock(&cpufreq_governor_mutex);
> >   out:
> > -     i +=3D sprintf(&buf[i], "\n");
> > +     i +=3D sysfs_emit_at(buf, i, "\n");
> >       return i;
> >   }
> >
> > @@ -895,7 +894,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mas=
k, char *buf)
> >       unsigned int cpu;
> >
> >       for_each_cpu(cpu, mask) {
> > -             i +=3D scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u ", cpu=
);
> > +             i +=3D sysfs_emit_at(buf, i, "%u ", cpu);
> >               if (i >=3D (PAGE_SIZE - 5))
> >                       break;
> >       }
> > @@ -903,7 +902,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mas=
k, char *buf)
> >       /* Remove the extra space at the end */
> >       i--;
> >
> > -     i +=3D sprintf(&buf[i], "\n");
> > +     i +=3D sysfs_emit_at(buf, i, "\n");
> >       return i;
> >   }
> >   EXPORT_SYMBOL_GPL(cpufreq_show_cpus);
> > @@ -946,7 +945,7 @@ static ssize_t store_scaling_setspeed(struct cpufre=
q_policy *policy,
> >   static ssize_t show_scaling_setspeed(struct cpufreq_policy *policy, c=
har *buf)
> >   {
> >       if (!policy->governor || !policy->governor->show_setspeed)
> > -             return sprintf(buf, "<unsupported>\n");
> > +             return sysfs_emit(buf, "<unsupported>\n");
> >
> >       return policy->governor->show_setspeed(policy, buf);
> >   }
> > @@ -960,8 +959,8 @@ static ssize_t show_bios_limit(struct cpufreq_polic=
y *policy, char *buf)
> >       int ret;
> >       ret =3D cpufreq_driver->bios_limit(policy->cpu, &limit);
> >       if (!ret)
> > -             return sprintf(buf, "%u\n", limit);
> > -     return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
> > +             return sysfs_emit(buf, "%u\n", limit);
> > +     return sysfs_emit(buf, "%u\n", policy->cpuinfo.max_freq);
> >   }
> >
> >   cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
>
>

