Return-Path: <linux-pm+bounces-41645-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPfrFtV9emld7AEAu9opvQ
	(envelope-from <linux-pm+bounces-41645-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:21:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2515A9126
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2411A300C0F5
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 21:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767E33B6F9;
	Wed, 28 Jan 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jut5z4IV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CC33ADBC
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635275; cv=none; b=IF0joZooUnAMjBOy6ZpMBp3bFxJ4Q6dfrQKHdpmm7Fblm7vDggaY0/DYSzqTpZve/eX3qVaAZxzqm92sIWnrIzs/MvG/eZqPJaVbR+/nKBMhTbUxwwQUge4qxDTwkaN0RGxZr3+2BW4nooeIJnyyXzu47nIqeYvU8BgQ9MBL0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635275; c=relaxed/simple;
	bh=GuyOLiuieqnJ8OZOOP0mOWOn+BPOJFFZggCExb2Y4Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/MQYQZXL/DllowQqoETP7yMHUGbByXKzhV8NxFqRDjk5XE2z0QP+B/I3oEYxCNoD5mhmWB5F62gVJvdfxT0x2dcDvoNdfegXedKbbn4OBLhl4/HPqubKXBNLdr1/CxlxlxOzprrge22whcCxQmrkRxdX08LLp1INjv31wPPai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jut5z4IV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46BCC16AAE
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769635274;
	bh=GuyOLiuieqnJ8OZOOP0mOWOn+BPOJFFZggCExb2Y4Io=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jut5z4IVgcDS5wTpu3tCZ2jLgG7iC1JSDPnbvPNL6JAVL3x9G5GTZ6K6OYTp4myw1
	 ZiO4+F8fyYzv6y0RK3TptxnxvRhkceHBCr3YxLwewQHYntetwQ/D9KQ+InoBDyXoE1
	 f4r+ToEXSROB+Lornkwh1tGcgeteo7cyq4PoOiyfdm9ca/jgnVH5KthA2+AmtG7y5a
	 faaFjtnjLJwFAbghuUv5vsYCDy8Iz+TZoeGU8mQY2O09iqINhgSI2PD42i8G7DRZQ2
	 ymEg2R7TkbWcsxFnmjIUsMeg1V3mG2oQT+j/StcFhFK1yYuj3ZoIOI1sUuUYeqB2mV
	 QMJWpuK0M5Dng==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-66307e10d1dso48563eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 13:21:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKpBuCKiLmKurH/+KtSupDpiNLnjQwlJiY2stY1HbdcToeyr7/HdaFB8XjHZH70o4vPFo500/Xkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfzHErtmHIka/CE5f4oLmtkhTkApepF2e158sOUI8+138RliI
	zUn1j81o1/TfPD5mgGRx6/SFFYjkx7rEUUbEyf32NbBpQAi8UJ0sLfwMaVS6ijzC/YnJJi9cjGw
	2QunfNQ9YKKtxROOX2MOIqf+NA8DwFpw=
X-Received: by 2002:a05:6820:1a05:b0:662:f8bd:fc8 with SMTP id
 006d021491bc7-662f8bd133emr2685429eaf.47.1769635273994; Wed, 28 Jan 2026
 13:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128031521.389765-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20260128031521.389765-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 22:21:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g8xM62_882WP8__x_RjCN_yeLUg=itXVTXsL=0T_mUsw@mail.gmail.com>
X-Gm-Features: AZwV_QiDSDhPjX8hwRA5-dSg0mICm7I4-2NPdFHLQ5Gsb-MjQZ378PyyWF7zdQM
Message-ID: <CAJZ5v0g8xM62_882WP8__x_RjCN_yeLUg=itXVTXsL=0T_mUsw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable asym capacity only when cpu
 smt is not possible
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rafael@kernel.org, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, 
	viresh.kumar@linaro.org, ricardo.neri-calderon@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41645-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F2515A9126
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 4:15=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
> According to the description in the intel_pstate.rst documentation,
> Capacity-Aware Scheduling and Energy-Aware Scheduling are only
> supported on a hybrid processor without SMT. Previously, the system
> used sched_smt_active() for judgment, which is not a strict condition
> because users can switch it on or off via /sys at any time.
>
> This could lead to incorrect driver settings in certain scenarios.
>  For example, on a CPU that supports SMT, a user can disable SMT
> via the nosmt parameter to enable asym capacity, and then re-enable
> SMT via /sys. In such cases, some settings in the driver would no
> longer be correct.
>
> To address this issue, replace sched_smt_active() with cpu_smt_possible()=
,
> and only enable asym capacity when cpu smt is not possible.
>
> Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity =
on hybrid systems")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/cpufreq/intel_pstate.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index ec4abe374573..8105c41861a3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1142,8 +1142,11 @@ static void hybrid_refresh_cpu_capacity_scaling(vo=
id)
>
>  static void hybrid_init_cpu_capacity_scaling(bool refresh)
>  {
> -       /* Bail out if enabling capacity-aware scheduling is prohibited. =
*/
> -       if (no_cas)
> +       /*
> +        * Bail out if capacity-aware scheduling is prohibited, or if SMT=
 is
> +        * possible, as the capacity of SMT threads cannot be determined =
reliably.
> +        */
> +       if (no_cas || cpu_smt_possible())
>                 return;
>
>         /*
> @@ -1156,12 +1159,8 @@ static void hybrid_init_cpu_capacity_scaling(bool =
refresh)
>                 return;
>         }
>
> -       /*
> -        * On hybrid systems, use asym capacity instead of ITMT, but beca=
use
> -        * the capacity of SMT threads is not deterministic even approxim=
ately,
> -        * do not do that when SMT is in use.
> -        */
> -       if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_ca=
pacity_scale()) {

Why don't you replace sched_smt_active() here with cpu_smt_possible()?

There's no point calling arch_enable_hybrid_capacity_scale() if the
latter is true.

> +       /* On hybrid systems, use asym capacity instead of ITMT */
> +       if (hwp_is_hybrid && arch_enable_hybrid_capacity_scale()) {
>                 hybrid_refresh_cpu_capacity_scaling();
>                 /*
>                  * Disabling ITMT causes sched domains to be rebuilt to d=
isable asym
> --

