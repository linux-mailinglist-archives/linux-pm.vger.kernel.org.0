Return-Path: <linux-pm+bounces-43147-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGpFN+W4nWnERQQAu9opvQ
	(envelope-from <linux-pm+bounces-43147-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 15:42:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A101888A3
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D15E305F57B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7639E6E1;
	Tue, 24 Feb 2026 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjSoVIOH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398839A80E
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944080; cv=none; b=EAlVXQc3G0yVP2sNO3Wvr0+n7yyHyDw1CKrZdHWdV0aylfHmN35lGGDonCQYIUb8TbqedHmlxth93J9U1F/7nJcsow//lljMsQsHh0G2PEKnhlu+n9hZsWwmvzMEoR+pI4Cgg8jlvg1kJFvQlv0POXZMzXyVPG31tnRiCYuSAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944080; c=relaxed/simple;
	bh=n8EToAI8E7T4O+hNkQ3ed4B8NORI3an2YSgUc2/q5g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Km7HRdJ4TBdHf05K954fFFF6yKyQ8fsEgbbPf27HpwKQsnqyt1OqFVUazQ3WUC+IUHvMaAvWhZVvvt8iGBUptNMCaxlSUtDcth7wuWy+tIoXifsh19QCldI3CpOxUNKItmBFVLJmZ6O4oCxmiIY8K+CUXZ2KOFfyPagrRSBD8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjSoVIOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF17CC4AF09
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771944079;
	bh=n8EToAI8E7T4O+hNkQ3ed4B8NORI3an2YSgUc2/q5g8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UjSoVIOHi7jlGCgqBHDTR4k00flaOjVuf7vcZNw9SE+y4PMBFaG7ffYapxFSs304B
	 CQvrzrs/NzVUIcHnR2Chf/wc+UwFDdLgnul0hZrmJciu+XpAJ3tzsRV83U8crR1osh
	 c27v2x4ONHZsti78btST1B5sBLDapqfLtDi5dg+xbgl2f5dAfWNT3mtN/3XVmu1NSs
	 9jQwjYewLpuocMegyRuXcSnh20B78KhB/iCUcPrGfgt1LOOp5HAdbKCw+K9yvBkoFj
	 GQGKkM0759c+deF7/XHk+rmilUg34VM4W88hKoZAPT920kmfqUhTMQdfbZ9oTq/Jdz
	 tb1ULfQ9HjZog==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-66f3e7d9eccso3092167eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:41:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbqGPu5WcYm+qVCK0OIcQhmooxeTwGNVApWEILO69K4owxfcH6hmZxpDBu8j+s4IuWyoVQ0vRj6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7cukKVaZfDodwRpK38HA4potHdAq0nRED0NmPQjQ9d7NiWtr
	V+EqUKsEFyEj8zmVY0A7oahaI5OWPvdv8HxoOdKwZdkap8dAbROW6VXlB3ZWPFPuHKMwfGtdZzy
	GaBuoH0ELHuypTQtDh+F9JFlOnyFV1w4=
X-Received: by 2002:a05:6820:4e81:b0:679:e5ec:ce8d with SMTP id
 006d021491bc7-679e5ecd0fbmr92207eaf.72.1771944078933; Tue, 24 Feb 2026
 06:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224122106.228116-1-darcari@redhat.com>
In-Reply-To: <20260224122106.228116-1-darcari@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Feb 2026 15:41:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ieyomN0M8Dn-QH9M6ZMjG-N-Bq4EJLDffBt8LPCRXOiw@mail.gmail.com>
X-Gm-Features: AaiRm51VOu0l_6rnkSDXx4HyMiyOytzHAo7g_KhRYgPfG7aWrTXX2wlhFM5cOJk
Message-ID: <CAJZ5v0ieyomN0M8Dn-QH9M6ZMjG-N-Bq4EJLDffBt8LPCRXOiw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix NULL pointer dereference in update_cpu_qos_request()
To: David Arcari <darcari@redhat.com>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, zhangzihuan@kylinos.cn, jhladky@redhat.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43147-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: F1A101888A3
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 1:21=E2=80=AFPM David Arcari <darcari@redhat.com> w=
rote:
>
> The update_cpu_qos_request() function attempts to initialize the 'freq'
> variable by dereferencing 'cpudata' before verifying if the 'policy'
> is valid.
>
> This issue occurs on systems booted with the "nosmt" parameter, where
> all_cpu_data[cpu] is NULL for the SMT sibling threads. As a result,
> any call to update_qos_requests() will result in a NULL pointer
> dereference as the code will attempt to access pstate.turbo_freq using
> the NULL cpudata pointer.
>
> Fix this by deferring the 'freq' assignment until after the policy and
> driver_data have been validated.
>
> Fixes: ae1bdd23b99f ("cpufreq: intel_pstate: Adjust frequency percentage =
computations")
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Closes: https://lore.kernel.org/all/CAE4VaGDfiPvz3AzrwrwM4kWB3SCkMci25nPO=
8W1JmTBd=3DxHzZg@mail.gmail.com/
> Signed-off-by: David Arcari <darcari@redhat.com>

Applied as 7.0-rc material, thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index a48af3540c74..bdc37080d319 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1647,8 +1647,8 @@ static ssize_t store_no_turbo(struct kobject *a, st=
ruct kobj_attribute *b,
>  static void update_cpu_qos_request(int cpu, enum freq_qos_req_type type)
>  {
>         struct cpudata *cpudata =3D all_cpu_data[cpu];
> -       unsigned int freq =3D cpudata->pstate.turbo_freq;
>         struct freq_qos_request *req;
> +       unsigned int freq;
>
>         struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
>         if (!policy)
> @@ -1661,6 +1661,8 @@ static void update_cpu_qos_request(int cpu, enum fr=
eq_qos_req_type type)
>         if (hwp_active)
>                 intel_pstate_get_hwp_cap(cpudata);
>
> +       freq =3D cpudata->pstate.turbo_freq;
> +
>         if (type =3D=3D FREQ_QOS_MIN) {
>                 freq =3D DIV_ROUND_UP(freq * global.min_perf_pct, 100);
>         } else {
> --
> 2.52.0
>

