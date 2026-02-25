Return-Path: <linux-pm+bounces-43211-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPbvFtv9nmlAYgQAu9opvQ
	(envelope-from <linux-pm+bounces-43211-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 14:49:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04EE1985BF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 14:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59874314999A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140CF3B8D62;
	Wed, 25 Feb 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrHVDWFm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B723A1D0F
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027091; cv=none; b=CGGsUUsHgEqdvoDt2l8PsUNzqqHBoxl/NLN0+5MuwQ5kQ3RZ6DijlZtyOP6XUSqSV6RAnZ43ftVv9Yzy5sbpULXfKp8T6P0BSdw/7wS3imkYo5s7Ip8IradisUXPBIhsyot8Yb7R4Iwq7NLpD5luaV0g5sRg0bHTP36gilJeYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027091; c=relaxed/simple;
	bh=6v6wuvvkaOMZPxFsbsFhYzmCxDxNP46HRitUFytWHIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9lsKHEa8MOL4BlUYlB7GZZozSAzDwmMdFPsrP0tDYtivXG30DaNfwfJBFuXIjC7RVzXaf/xJZNl7beeUx+v/dRWo8BwnbDwjTG016owLyQx5anMfc7ikBCuvvFsjD3hBSiDQlYGn+jNev7sWXLWVZtxW5hSbdzYDR/rWCjfKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrHVDWFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8D5C4AF0C
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027090;
	bh=6v6wuvvkaOMZPxFsbsFhYzmCxDxNP46HRitUFytWHIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UrHVDWFmnEGA1FYKTqw4QN3SrEBdnzI+38Hc5aMYvSaGQQfLu4bkNHe5ozCMbRxXq
	 2VbPHy/t8mO1YyBS6uoj9uC3XFjtfoeGWYdUeydnnOqeJofx1IYfKqVEE6zpDua/9g
	 USqfnTXkly+gd156Gd8G9mWRAHXqlMvM8wFHCcwGLngViTnVw5Ao7urPO5cfaUcWbg
	 efkXe7i3GmqGAOgR6jqdy4VMtwU7TtTUF/GV4MxtrCRYrKWNh8+Co8G4yi4qz0I306
	 usgW+PNro2lCh8x7eHSw9b7NkgH1FR/0581Pf89D/HqDkiP+HBEo7YVxp+zsl8gSp3
	 2i2k+axRFSRhQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662f2fa7e67so2518644eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 05:44:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/EYdvQ3vrGgtv34uf4sWBzVfirN/N02mAFvGfiKRTBubwGIWL05bOmdqpa+qUEVB/MIYldCqHpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoW7JyOAZl5qwoIa5uAHTkgnv0+TIVv8jjkZPnecjmTXq242vm
	AM1TcFPOTn5msPP+xh4+SeN+dDHzQJwXjJNxqFjUPSAQE1JurQ/DK9sHbxTISkFuB58MydbnUMq
	+2UQzAtXWce3ar/Oybj9ciQc/sVW/Xr8=
X-Received: by 2002:a05:6820:6af0:b0:679:e524:84cc with SMTP id
 006d021491bc7-679e524854bmr1860758eaf.8.1772027089710; Wed, 25 Feb 2026
 05:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225001752.890164-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20260225001752.890164-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 14:44:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j11H-V4KOf4dMT_YnBa4CAVwka2EMqZh95dJ+E+pT=Bw@mail.gmail.com>
X-Gm-Features: AaiRm51--WW4ttqoEdgd-a_LCEFZ_xrXlR684bnDdW7wNh6sHV1QOznvloR-Pmw
Message-ID: <CAJZ5v0j11H-V4KOf4dMT_YnBa4CAVwka2EMqZh95dJ+E+pT=Bw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix crash during turbo disable
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43211-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: B04EE1985BF
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:17=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When the system is booted with kernel command line argument "nosmt" or
> "maxcpus" to limit the number of CPUs, disabling turbo via:
> echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> results in a crash:
> PF: supervisor read access in kernel mode
> PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> ...
> RIP: 0010:store_no_turbo+0x100/0x1f0
>  ...
>
> This occurs because for_each_possible_cpu() returns CPUs even if they are
> not online. For those CPUs, all_cpu_data[] will be NULL. Since
> commit 973207ae3d7c ("cpufreq: intel_pstate: Rearrange max frequency
> updates handling code"), all_cpu_data[] is dereferenced even for CPUs
> which are not online, causing the NULL pointer dereference.
>
> To fix that pass CPU number to intel_pstate_update_max_freq() and use
> all_cpu_data[] for those CPUs for which there is a valid cpufreq policy.
>
> Fixes: 973207ae3d7c ("cpufreq: intel_pstate: Rearrange max frequency upda=
tes handling code")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221068
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: <stable@vger.kernel.org> # 6.16+
> ---
>  drivers/cpufreq/intel_pstate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index a48af3540c74..3ecfa921f9b9 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1476,13 +1476,13 @@ static void __intel_pstate_update_max_freq(struct=
 cpufreq_policy *policy,
>         refresh_frequency_limits(policy);
>  }
>
> -static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
> +static bool intel_pstate_update_max_freq(int cpu)
>  {
> -       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpudata->cpu);
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
>         if (!policy)
>                 return false;
>
> -       __intel_pstate_update_max_freq(policy, cpudata);
> +       __intel_pstate_update_max_freq(policy, all_cpu_data[cpu]);
>
>         return true;
>  }
> @@ -1501,7 +1501,7 @@ static void intel_pstate_update_limits_for_all(void=
)
>         int cpu;
>
>         for_each_possible_cpu(cpu)
> -               intel_pstate_update_max_freq(all_cpu_data[cpu]);
> +               intel_pstate_update_max_freq(cpu);
>
>         mutex_lock(&hybrid_capacity_lock);
>
> @@ -1908,7 +1908,7 @@ static void intel_pstate_notify_work(struct work_st=
ruct *work)
>         struct cpudata *cpudata =3D
>                 container_of(to_delayed_work(work), struct cpudata, hwp_n=
otify_work);
>
> -       if (intel_pstate_update_max_freq(cpudata)) {
> +       if (intel_pstate_update_max_freq(cpudata->cpu)) {
>                 /*
>                  * The driver will not be unregistered while this functio=
n is
>                  * running, so update the capacity without acquiring the =
driver
> --

Applied as 7.0-rc material, thanks!

