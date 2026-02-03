Return-Path: <linux-pm+bounces-42003-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAfUNdRlgmlOTgMAu9opvQ
	(envelope-from <linux-pm+bounces-42003-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 22:17:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B861DEC59
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 22:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22CB83023348
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76266280CC9;
	Tue,  3 Feb 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoHQ/ip9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539932EB10
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153424; cv=none; b=AmJkeg6frXqLgkrtxr7V6uiRhdYZNU+dBJkditDBp4UOHTf8HgImlG0K2EsY2LYwZfZCPRQJPPBu4nFafrwmuLbFSiLRWGxoLwNNp+S4egbQZZK7aqb1/NHM00Iwi55c2bbq0QgIya4ts0YbNcVKrm+W7By+lG9ZTdX59trMpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153424; c=relaxed/simple;
	bh=zQwu28MTKGRw5cBd43SlpsWuwZRHAW9XP7TnOh50gss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeixFFxTFS93AzdJS6umJNNxVHLttMTh1yA6SRE5jv2fR++dNZYhinSVcXf6+hI8VczA+YEAvoBGSPk0h/zpSGoxaHpdEV0klq8uPX8AG7wvTdC7kh1XQU59U4MCekZWMXnakL5ZniAMyzHnxj2L6zu/7EOmoLbPBw5O8U9doXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoHQ/ip9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE0CC2BCAF
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 21:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770153424;
	bh=zQwu28MTKGRw5cBd43SlpsWuwZRHAW9XP7TnOh50gss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GoHQ/ip9hCrU4RmIIu7bOM8uUTJrqRQrA5LyoJdqUxMY2ytc6faLbYFIYPf1suCrQ
	 tIQYPi4knsZvkkdw7LmAZpvv2sHvmxvvaFJwVabM8mhPEvOO65PRq8NQBbZuojgmvf
	 vLyxnZgXFTXV9hbfPyx6SItZTZEqoo+bFrFLyMJ0qh17WMXeO3U5JhtirusRqkONNJ
	 tz8bRU5fl33rdGl3CR2dlfxbesWOghkZXzSs5sXTD29n80Fn6zS16gWKqcX08FjPn2
	 s3MD4t4/GcHm7CoBOEWnTGqKmVVAvLXNhsPg1oGSHluywxWeV3Kj3GgtQgzQuEQOjQ
	 rvVWQ+ounwwTQ==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45f126d4794so3751975b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 13:17:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSbjeEoUDqTBY23uFAxG4aKsGKr10M9DFfHmcfMeA1Q9BX+rrpHih8O+SU5dJh0FS+rzKVFgcCbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzNsbXhK0G9WUM4luOmJxhl8I2Gyb6JB36j7+nvfwLye1yuKRM
	2N0rm+iagbLBpl839xw4nCdswBlNHJecw8VVUlH54Ja83fKMx8dWD67F2rNRwZCEe0tfFiJM+Uw
	1pUUTdtDszjF9DJTE1CFNGLF7EqE7aCg=
X-Received: by 2002:a05:6808:2227:b0:45a:135c:4caf with SMTP id
 5614622812f47-462d5aa2119mr449134b6e.56.1770153422903; Tue, 03 Feb 2026
 13:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128031521.389765-1-tianyaxiong@kylinos.cn> <20260203024852.301066-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20260203024852.301066-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 22:16:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_Qz8xFeYc_j4Y0z=RB_iR8-QZC4S01eyomKDf6FGrJw@mail.gmail.com>
X-Gm-Features: AZwV_QhCXg3lsbFeCHYeQpOqFKSTmAOy4Un-r7yC0TmWKDymb5biQwpa3VDlJJc
Message-ID: <CAJZ5v0j_Qz8xFeYc_j4Y0z=RB_iR8-QZC4S01eyomKDf6FGrJw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Enable asym capacity only when
 cpu smt is not possible
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rafael@kernel.org, ricardo.neri-calderon@linux.intel.com, 
	srinivas.pandruvada@linux.intel.com, viresh.kumar@linaro.org, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42003-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 3B861DEC59
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:49=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.cn=
> wrote:
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
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index ec4abe374573..1625ec2d0d06 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1161,7 +1161,7 @@ static void hybrid_init_cpu_capacity_scaling(bool r=
efresh)
>          * the capacity of SMT threads is not deterministic even approxim=
ately,
>          * do not do that when SMT is in use.
>          */
> -       if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_ca=
pacity_scale()) {
> +       if (hwp_is_hybrid && !cpu_smt_possible() && arch_enable_hybrid_ca=
pacity_scale()) {
>                 hybrid_refresh_cpu_capacity_scaling();
>                 /*
>                  * Disabling ITMT causes sched domains to be rebuilt to d=
isable asym
> --

Applied as 6.20/7.0 material, thanks!

