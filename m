Return-Path: <linux-pm+bounces-26815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1530FAAE33C
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EBF9A6A52
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF128A1EB;
	Wed,  7 May 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtjN36Vf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A84288C11;
	Wed,  7 May 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628499; cv=none; b=pU9/Ofja+dpg+ln9wNcnTTQjsu6SLD4fLKx1zsWW+LPrYlmVFB3K6iGqdP4ezJnJDg24zuUZ+axY0gLztBDO/z75DMdg5Gl7sWbIbbMLz3T/VMP+EyJXQplC+xHnJcthuLdVBzBf2un9qRPAXP6mNYSulh8h23u3Ha5dTd8iVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628499; c=relaxed/simple;
	bh=mEsR2cZO9AiWi61lNkQNjf5K/OnZM0tZW88eEGGvSxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmaCTXjIcE49ztSalOeCtujfrJD5VivrwDlYII+yTY/aJpJexP7KIVfGRL30Zf9+PVk4PdxcC9E5nl/iMbgeKGP50aBQxIKJPEUQZ7zUNP96C3A7CRkoR28Appy2CkNkc5BPQOBjM4I5XLRgyVmRKVxlmLvm5wFX6rD4s14pQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtjN36Vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394F5C4CEEE;
	Wed,  7 May 2025 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746628499;
	bh=mEsR2cZO9AiWi61lNkQNjf5K/OnZM0tZW88eEGGvSxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YtjN36VfqAbfeMZEmmEfU/s5YU2fvo/hY4N16PC4z5fK+4FBlx0md9+KgPJb3lw3x
	 J/cUaEjWo4tlyHHbWl/I8NBen98IIl2DKOP3UEw5Rgim6uwh6yUQZzfeKdJBEJt/FM
	 mwqwUt6r3qm1HD4ZcIjNhHWdWxTl3eYvMPLappEDwzh1xNarr9Puh3aWVZ7vxPDXb1
	 C6pzN/7E8FOXF+2s1CEF95LGcLAs2a/PdcQ9vq3mmICBOg5WjY3RF5tHFzNg1Iyn8k
	 MLZfdgx8nvRKZWTYztkXzgXGfL9dNaBDqLMtsYSFb/iHZyKSItt8Mw53tBKHNAKI/3
	 DnvNG0BFGdlrQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6063462098eso4072010eaf.0;
        Wed, 07 May 2025 07:34:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrHTuY2I5NvGFrOAklVAAxIvn7umZ93Gz0S0sd8Awqvvbyx2TkzSBHkW+aCh/QhxLYjwV2OeJKqV+iFr0=@vger.kernel.org, AJvYcCWoTVi6Lwxt+1RSOc6CWKiLo63sugujR2Q4rDrWxXQAwe/u8ZLWeZ3XnDSRJXy8njfhifPJxYaMxYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNRdIviM5iuRB+UNXR5OgUXs6l6DWIHpO3HgUbtpFHLIOYYfw
	S9JmoXHiB00dyNIs0fYaJ4bypE/E3IEoe0SxxJLIPdxMxqZbrDf14uSVqQrEPG769L+0uskiODN
	dAVxVxzFRqCoNCCZLMvSLLdvurFs=
X-Google-Smtp-Source: AGHT+IGOOsb4VvGGVXaFygBQ3XIl60Eg4mXneoZqPsC/O4PI6PMYI1WJg1Ouhpky3oGY0md68kP5VoCa64R2pwbVmBs=
X-Received: by 2002:a05:6870:1792:b0:2b8:fab0:33c with SMTP id
 586e51a60fabf-2db5bec5d5fmr1903378fac.23.1746628498533; Wed, 07 May 2025
 07:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
In-Reply-To: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 16:34:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jYfK_+CnT3jv+=jAp=r29nT2hQLb5zU48zpHZFzCRpNQ@mail.gmail.com>
X-Gm-Features: ATxdqUGaXmCPDrmlLX3mroKiNJdamJJO-49OSSgxhjKgMZyC649EKzHT6gUncDw
Message-ID: <CAJZ5v0jYfK_+CnT3jv+=jAp=r29nT2hQLb5zU48zpHZFzCRpNQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	sumitg@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxarm@huawei.com, mario.limonciello@amd.com, yumpusamongus@gmail.com, 
	srinivas.pandruvada@linux.intel.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, cenxinghai@h-partners.com, 
	yubowen8@huawei.com, hepeng68@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:19=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.co=
m> wrote:
>
> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> driver.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
> Hi Rafael,
>
> This patch is the 8th patch in [1]. After the discussion in [2], Sumit
> is OK with adding sysfs entries under cpufreq sysfs node, so I resend
> this patch. He will later send his updated patch after.
>
> Any comments appreciated!
>
> Lifeng
>
> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@hua=
wei.com/
> [2] https://lore.kernel.org/all/20250211103737.447704-1-sumitg@nvidia.com=
/

This is for Viresh and when all of the ACPI CPPC patches settle down.
I think that it would be better to get back to it after the 6.16 merge
window.

>
>  .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>  2 files changed, 163 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documen=
tation/ABI/testing/sysfs-devices-system-cpu
> index 206079d3bd5b..37065e1b8ebc 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -268,6 +268,60 @@ Description:       Discover CPUs in the same CPU fre=
quency coordination domain
>                 This file is only present if the acpi-cpufreq or the cppc=
-cpufreq
>                 drivers are in use.
>
> +What:          /sys/devices/system/cpu/cpuX/cpufreq/auto_select
> +Date:          May 2025
> +Contact:       linux-pm@vger.kernel.org
> +Description:   Autonomous selection enable
> +
> +               Read/write interface to control autonomous selection enab=
le
> +                       Read returns autonomous selection status:
> +                               0: autonomous selection is disabled
> +                               1: autonomous selection is enabled
> +
> +                       Write 'y' or '1' or 'on' to enable autonomous sel=
ection.
> +                       Write 'n' or '0' or 'off' to disable autonomous s=
election.
> +
> +               This file is only present if the cppc-cpufreq driver is i=
n use.
> +
> +What:          /sys/devices/system/cpu/cpuX/cpufreq/auto_act_window
> +Date:          May 2025
> +Contact:       linux-pm@vger.kernel.org
> +Description:   Autonomous activity window
> +
> +               This file indicates a moving utilization sensitivity wind=
ow to
> +               the platform's autonomous selection policy.
> +
> +               Read/write an integer represents autonomous activity wind=
ow (in
> +               microseconds) from/to this file. The max value to write i=
s
> +               1270000000 but the max significand is 127. This means tha=
t if 128
> +               is written to this file, 127 will be stored. If the value=
 is
> +               greater than 130, only the first two digits will be saved=
 as
> +               significand.
> +
> +               Writing a zero value to this file enable the platform to
> +               determine an appropriate Activity Window depending on the=
 workload.
> +
> +               Writing to this file only has meaning when Autonomous Sel=
ection is
> +               enabled.
> +
> +               This file is only present if the cppc-cpufreq driver is i=
n use.
> +
> +What:          /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_p=
reference_val
> +Date:          May 2025
> +Contact:       linux-pm@vger.kernel.org
> +Description:   Energy performance preference
> +
> +               Read/write an 8-bit integer from/to this file. This file
> +               represents a range of values from 0 (performance preferen=
ce) to
> +               0xFF (energy efficiency preference) that influences the r=
ate of
> +               performance increase/decrease and the result of the hardw=
are's
> +               energy efficiency and performance optimization policies.
> +
> +               Writing to this file only has meaning when Autonomous Sel=
ection is
> +               enabled.
> +
> +               This file is only present if the cppc-cpufreq driver is i=
n use.
> +
>
>  What:          /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{=
0,1}
>  Date:          August 2008
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index b3d74f9adcf0..3c3d00cec298 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -808,10 +808,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq=
_policy *policy, char *buf)
>
>         return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>  }
> +
> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf=
)
> +{
> +       bool val;
> +       int ret;
> +
> +       ret =3D cppc_get_auto_sel(policy->cpu, &val);
> +
> +       /* show "<unsupported>" when this register is not supported by cp=
c */
> +       if (ret =3D=3D -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%d\n", val);
> +}
> +
> +static ssize_t store_auto_select(struct cpufreq_policy *policy,
> +                                const char *buf, size_t count)
> +{
> +       bool val;
> +       int ret;
> +
> +       ret =3D kstrtobool(buf, &val);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D cppc_set_auto_sel(policy->cpu, val);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char =
*buf)
> +{
> +       u64 val;
> +       int ret;
> +
> +       ret =3D cppc_get_auto_act_window(policy->cpu, &val);
> +
> +       /* show "<unsupported>" when this register is not supported by cp=
c */
> +       if (ret =3D=3D -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%llu\n", val);
> +}
> +
> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> +                                    const char *buf, size_t count)
> +{
> +       u64 usec;
> +       int ret;
> +
> +       ret =3D kstrtou64(buf, 0, &usec);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D cppc_set_auto_act_window(policy->cpu, usec);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t show_energy_performance_preference_val(struct cpufreq_pol=
icy *policy, char *buf)
> +{
> +       u64 val;
> +       int ret;
> +
> +       ret =3D cppc_get_epp_perf(policy->cpu, &val);
> +
> +       /* show "<unsupported>" when this register is not supported by cp=
c */
> +       if (ret =3D=3D -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%llu\n", val);
> +}
> +
> +static ssize_t store_energy_performance_preference_val(struct cpufreq_po=
licy *policy,
> +                                                      const char *buf, s=
ize_t count)
> +{
> +       u64 val;
> +       int ret;
> +
> +       ret =3D kstrtou64(buf, 0, &val);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D cppc_set_epp(policy->cpu, val);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
>  cpufreq_freq_attr_ro(freqdomain_cpus);
> +cpufreq_freq_attr_rw(auto_select);
> +cpufreq_freq_attr_rw(auto_act_window);
> +cpufreq_freq_attr_rw(energy_performance_preference_val);
>
>  static struct freq_attr *cppc_cpufreq_attr[] =3D {
>         &freqdomain_cpus,
> +       &auto_select,
> +       &auto_act_window,
> +       &energy_performance_preference_val,
>         NULL,
>  };
>
> --
> 2.33.0
>
>

