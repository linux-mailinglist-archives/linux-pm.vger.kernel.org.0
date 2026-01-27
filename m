Return-Path: <linux-pm+bounces-41567-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOJgA5LteGkCuAEAu9opvQ
	(envelope-from <linux-pm+bounces-41567-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:53:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639D98003
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E1DE30613DA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DBD36165A;
	Tue, 27 Jan 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDHoZ7wz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05035EDC9
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531089; cv=none; b=B82QrvNLZmmCV6knINd6W7cbjWaY3374Nq/NsQIwzx7mLybOCzyt1RU/6x8NqBJjenPkFVVTlJ0ozRV0N7ibHTv0JlPTX+dZkSRikIOJaEniMmTGCWpoIgLi+qZu5IJgszKv0D5B1Nz1ft3hwe7GzYl26uHqTv2bjmO2uf1mcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531089; c=relaxed/simple;
	bh=Mm7PNHjxKBBGvZCLiHpXhTyu74qmhr7ObXdQIYvFD28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMXCOW15qPdlfjJZxPf6ABwGnawgmXhnK/BghQyypndO1NcoZ31v1V/xDNeOcPVfIiZeRqBjZjS7AtTeZcS5cackGrmUgMJeWFgAQsFx4LD19wFJHmROBNhCBAqHnI+a9i2w+bAf9+V/hNpWHB2+p61xAXKhgfLb0fu96qPHZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDHoZ7wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33288C2BC86
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769531089;
	bh=Mm7PNHjxKBBGvZCLiHpXhTyu74qmhr7ObXdQIYvFD28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eDHoZ7wzov52VSRHiF8O0B+f4RfcehlRQcp9dNXea78RFjUTpz7fFO/LcDiBTKY+2
	 YfLeL1ggHEYl+VgCSw8hwbpIDQ7m6vNgzXTPDw3hYHBVE95xBC4pZxLpeA+Sqni9XW
	 r2iNwPsVohBqTnU9wNPLdX3TvVZixG2jJHDFSO9ZkcqEcFeEh/21J6Z6fRzlkHCbDQ
	 W1IZStBzWGLECfsnXQ0IXHvDHajllPv43WklQ3HT9zWaWDs8gly/6SUcxNW3MQVUJ+
	 78VyG6Vlbtk4kYTNswBjQVbhpDfM3fDFhCh77DKNF0IG0OYmq4nS1eosWIUFv1bcmI
	 4B6bnjUQia6iA==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45effa36208so184413b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 08:24:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQlyumvlNC6G2QaroCtB5Memu/fJgRnS1Q05a0HEek9XVLC3L3F/GnhiY3kTqxENsVERoJUTk9LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxF68iGXznge0WuXNWyGlAnzJKS5ApczDXGktAYKLK9J1Bqgt6
	9f095WdmarewysSG9cotr384GanDFTH6F/6PAtEkufcv6nzeoWqO81BDcAzKGHbamLwEowsB+GW
	/RVKDpM01/znHYFYlJ27rvBtiNg2lXO8=
X-Received: by 2002:a05:6808:1904:b0:450:ccef:c01f with SMTP id
 5614622812f47-45efc65eef8mr1065605b6e.34.1769531087995; Tue, 27 Jan 2026
 08:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120145623.2959636-1-sumitg@nvidia.com> <20260120145623.2959636-2-sumitg@nvidia.com>
In-Reply-To: <20260120145623.2959636-2-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:24:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ipgGt7tetY6p0CW0jyOh9TVeWxgXpFzveTa2CaGB8ZpA@mail.gmail.com>
X-Gm-Features: AZwV_Qg_oEiNndB5ZDCW_5HqO2fNprSPJkksUv7HA7IrMkSsJk1zm9cMtY4Gyck
Message-ID: <CAJZ5v0ipgGt7tetY6p0CW0jyOh9TVeWxgXpFzveTa2CaGB8ZpA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] cpufreq: CPPC: Add generic helpers for sysfs show/store
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, ionela.voinescu@arm.com, lenb@kernel.org, 
	robert.moore@intel.com, corbet@lwn.net, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	nhartman@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41567-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3639D98003
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 3:57=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> Add generic helper functions for u64 sysfs attributes that follow the
> common pattern of calling CPPC get/set APIs:
> - cppc_cpufreq_sysfs_show_u64(): reads value and handles -EOPNOTSUPP
> - cppc_cpufreq_sysfs_store_u64(): parses input and calls set function
>
> Add CPPC_CPUFREQ_ATTR_RW_U64() macro to generate show/store functions
> using these helpers, reducing boilerplate for simple attributes.
>
> Convert auto_act_window and energy_performance_preference_val to use
> the new macro.
>
> No functional changes.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 69 ++++++++++++----------------------
>  1 file changed, 25 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 36e8a75a37f1..c95dcd7719c3 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -863,73 +863,54 @@ static ssize_t store_auto_select(struct cpufreq_pol=
icy *policy,
>         return count;
>  }
>
> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char =
*buf)
> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
> +                                          int (*get_func)(int, u64 *),
> +                                          char *buf)
>  {
>         u64 val;
> -       int ret;
> -
> -       ret =3D cppc_get_auto_act_window(policy->cpu, &val);
> +       int ret =3D get_func((int)cpu, &val);
>
> -       /* show "<unsupported>" when this register is not supported by cp=
c */
>         if (ret =3D=3D -EOPNOTSUPP)
>                 return sysfs_emit(buf, "<unsupported>\n");
> -
>         if (ret)
>                 return ret;
>
>         return sysfs_emit(buf, "%llu\n", val);
>  }
>
> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> -                                    const char *buf, size_t count)
> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
> +                                           int (*set_func)(int, u64),
> +                                           const char *buf, size_t count=
)
>  {
> -       u64 usec;
> +       u64 val;
>         int ret;
>
> -       ret =3D kstrtou64(buf, 0, &usec);
> +       ret =3D kstrtou64(buf, 0, &val);
>         if (ret)
>                 return ret;
>
> -       ret =3D cppc_set_auto_act_window(policy->cpu, usec);
> -       if (ret)
> -               return ret;
> +       ret =3D set_func((int)cpu, val);
>
> -       return count;
> +       return ret ? ret : count;
>  }
>
> -static ssize_t show_energy_performance_preference_val(struct cpufreq_pol=
icy *policy, char *buf)
> -{
> -       u64 val;
> -       int ret;
> -
> -       ret =3D cppc_get_epp_perf(policy->cpu, &val);
> -
> -       /* show "<unsupported>" when this register is not supported by cp=
c */
> -       if (ret =3D=3D -EOPNOTSUPP)
> -               return sysfs_emit(buf, "<unsupported>\n");
> -
> -       if (ret)
> -               return ret;
> -
> -       return sysfs_emit(buf, "%llu\n", val);
> +#define CPPC_CPUFREQ_ATTR_RW_U64(_name, _get_func, _set_func)          \
> +static ssize_t show_##_name(struct cpufreq_policy *policy, char *buf)  \
> +{                                                                      \
> +       return cppc_cpufreq_sysfs_show_u64(policy->cpu, _get_func, buf);\
> +}                                                                      \
> +static ssize_t store_##_name(struct cpufreq_policy *policy,            \
> +                            const char *buf, size_t count)             \
> +{                                                                      \
> +       return cppc_cpufreq_sysfs_store_u64(policy->cpu, _set_func,     \
> +                                           buf, count);                \
>  }
>
> -static ssize_t store_energy_performance_preference_val(struct cpufreq_po=
licy *policy,
> -                                                      const char *buf, s=
ize_t count)
> -{
> -       u64 val;
> -       int ret;
> +CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
> +                        cppc_set_auto_act_window)
>
> -       ret =3D kstrtou64(buf, 0, &val);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D cppc_set_epp(policy->cpu, val);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> +CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
> +                        cppc_get_epp_perf, cppc_set_epp)
>
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
> --

It looks like this patch could be applied independently of the other
patches in the series.

Do you want me to do so?

