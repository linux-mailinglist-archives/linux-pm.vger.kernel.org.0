Return-Path: <linux-pm+bounces-38372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C3C79398
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6EEC34A60F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61821331237;
	Fri, 21 Nov 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsOBzWMD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81634346782;
	Fri, 21 Nov 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731001; cv=none; b=LepDUJaEoUCOKFiBbJlSpgxDfD1Bq5sBKlZUcvHwGgk9f4EXn9ExuD44NEdGKCR300nV9lde6Q8PcwrJSLaEh6Ua+ieytV6xI7Lv0dqz2G32YjyVaNFxNO9rkDCCQ85l289zzoZT1R3ipL5wvMIm0jUDxcpvwiq5Z2OwzYGQW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731001; c=relaxed/simple;
	bh=eme6ZS8FJJxzqwbZg8ZaCh+HrZE7enpHSIvrum+fCgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NYRRMxNAJRlLxjlEG1v1+KLPOt72cgnfA43IiAzCvTyTPW2bmosJbHFI/FBW/DcsNr6clBlBRJg8Uh2GgElJn7dqS3kAqmn0mSuuL0LKrODbkvJ+cW75ofEA8G2ihb7Bzi5Maq/XmUF6N7DUF05In5hqDy0E3S7BxXHG12Rlle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsOBzWMD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763731000; x=1795267000;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eme6ZS8FJJxzqwbZg8ZaCh+HrZE7enpHSIvrum+fCgs=;
  b=fsOBzWMDdk86h4+2B0DHEl5l9YXu5Mpz3ZK3wMNc63pmzWOmgEMDF6n9
   Ga0yIfG1zra4bAK/nnVQGU1e1f2y4GCP2rfOV/aQth1jbnPpqbfTXrN9L
   acjxAiFEyx7o9cKkLZysaoAEwlOmDsRLkn2VxvbaE88m0G6a/7Nm+p27A
   jmJRwY+om9hdug7BlAvaIZRgFdVjQSiGE8Sk2r4/Ud2RWLCbr92XmxtxP
   BCsvdDt54wXytptHQvettq4TxZ7eb9HgpPAZzPRv4rq7XAbUa1iAiDV6e
   r6dMBw4cc/QXWD+3nosiRUE8X1A6PeXD772qgAC/fIYuEFfD2DFWmLus2
   Q==;
X-CSE-ConnectionGUID: bXY12OuAQ1mziCRLruDwZQ==
X-CSE-MsgGUID: Vghp6rU+SgyxQR0sQ5UpVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65715171"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="65715171"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 05:16:39 -0800
X-CSE-ConnectionGUID: BYD38/rGScCo6JrhPcAgwA==
X-CSE-MsgGUID: TeF7mPGHQ7+l5Q7FZNI3vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="191803187"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 05:16:38 -0800
Received: from [10.245.245.66] (abityuts-desk.ger.corp.intel.com [10.245.245.66])
	by linux.intel.com (Postfix) with ESMTP id 6FED820A8406;
	Fri, 21 Nov 2025 05:16:35 -0800 (PST)
Message-ID: <efe52356123168be06811abd08a99f65d6980baa.camel@linux.intel.com>
Subject: Re: [PATCH] cpuidle: warn and fixup on sanity check instead of
 rejecting the driver
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Val Packett <val@packett.cool>, "Rafael J. Wysocki" <rafael@kernel.org>,
  Daniel Lezcano <daniel.lezcano@linaro.org>, Christian Loehle
 <christian.loehle@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 21 Nov 2025 15:16:34 +0200
In-Reply-To: <20251121010756.6687-1-val@packett.cool>
References: <20251121010756.6687-1-val@packett.cool>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-20 at 22:06 -0300, Val Packett wrote:
> On Device Tree platforms, the latency and target residency values come
> directly from device trees, which are numerous and weren't all written
> with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
> trips this check: exit latency 680000 > residency 600000.
>=20
> Instead of harshly rejecting the entire cpuidle driver with a mysterious
> error message, print a warning and set the target residency value to be
> equal to the exit latency.
>=20
> Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and targ=
et residency")
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/cpuidle/driver.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 1c295a93d582..06aeb59c1017 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -199,8 +199,11 @@ static int __cpuidle_driver_init(struct cpuidle_driv=
er *drv)
>  		 * exceed its target residency which is assumed in cpuidle in
>  		 * multiple places.
>  		 */
> -		if (s->exit_latency_ns > s->target_residency_ns)
> -			return -EINVAL;
> +		if (s->exit_latency_ns > s->target_residency_ns) {
> +			pr_warn("cpuidle: state %d: exit latency %lld > residency %lld (fixin=
g)\n",
> +				i, s->exit_latency_ns, s->target_residency_ns);
> +			s->target_residency_ns =3D s->exit_latency_ns;
> +		}
>  	}

Ideally, in a perfect world, driver.c should verify input data and
reject bad input, rather than correct bad input.

So ideally, if there is an idle driver between DT and driver.c (like
intel_idle.c in case of Intel), that would be its job to correct DT
data.

But I'm not familiar with DT platforms, so I don't know if there is a
driver/piece of SW between DT parsing and driver.c that could handle
this correction at an earlier stage.

The reason I think this patch is not ideal is because it changes the
input data at the core framework level, and in theory the change may be
surprising to users. In general, sometimes rejecting bluntly is better
than correcting in a possibly unexpected way.

Artem.

