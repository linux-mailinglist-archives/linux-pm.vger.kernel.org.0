Return-Path: <linux-pm+bounces-40948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AECD285D6
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3B70309EE24
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E430BB96;
	Thu, 15 Jan 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVfQk6Ih"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95F267B05
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508188; cv=none; b=kpfdvx+4ROm0jiWlX/O7QdS+3phs85IOjdINITZUEqCY47QRQ5s+aP0yXP3xShuMZgLcu90ouwX/tPfuidQW5I2kigvX42l4H7Rc9R+kgxcw+wL7wZZtdfzg92HBNNqqBvVpywpWo3sWg1is2cHU6nB01hW6CKsv9vz+9ms7LAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508188; c=relaxed/simple;
	bh=8MdZSIbCcHdL2bbYvYTZIBnNJjEHWNYaOGC+UA5b/x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/+Hr+gbYnOXWWFAh9uuLzmBZU/TQM/FALtoWtNVtpdiryLBNLGHYjjlCPONLyUYQFuEJsZT8psnGQRzozhusvU15wvGYEQ/A+62i1v6o4S97GWaYjEUXJKCHeFYcrl0oPbKIbCs79N7RdP+D7Khf8+HTywhBBPqAP0w5ZRJh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVfQk6Ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE0CC19423
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768508188;
	bh=8MdZSIbCcHdL2bbYvYTZIBnNJjEHWNYaOGC+UA5b/x8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mVfQk6Ih4FmTsuMXrjq1SzCskZWPFovDnCiLekgDFuM0s371IZKfPrgflFzoBET/B
	 KwtgGprBThslZNBv+rCa2wsexeUmWmhOWme6cooOmPLCjt7OIHmD67OZagiqZLnrAU
	 mhFIWFoMRfE2/LeB/eO/eyqhqExezmqcyZtedAGn6V1PPN5PTlRdePXziKJr2xBlIr
	 TyUeryZpXIURIddZDu7oLdDniTXjJ+yCUa8gMkmjgeNqUtMqhLP8zGmfqsg4B+7PmE
	 bhvZvHnt3DkN4HWKd9jXZs4SvVE1xx4tDHtBcf1Y8G3LLPFdxmfYDMWLNOsjTkRsKg
	 JpVIdg20WSixQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3fe3cc80bc3so840739fac.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:16:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaDqIEJgqMtc6kE/gQRLh3yIgx9n2SVGLqWgYQHl1W5twjCt76LV60H6syYz6530XcVPA5gcKzYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ibb2WLr57HM0TIgXwenNJZY99byz5AFC6regBz4pS2Dpar2/
	ZBKqvU7gQ6AEtbL0IUEOwOctf8Kc4OpUIH1ZV9xUgnkJckWXDShEopt3HJE/d+oeo9jYSRFFLTd
	Oaz5XfEPKRMjwBNl3Nc8C4apqjzXRCTg=
X-Received: by 2002:a05:6820:4deb:b0:660:ffd3:32b with SMTP id
 006d021491bc7-661179e036fmr413987eaf.44.1768508187179; Thu, 15 Jan 2026
 12:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6088605.ChMirdbgyp@daniel-desktop3>
In-Reply-To: <6088605.ChMirdbgyp@daniel-desktop3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:16:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jA6DiP=FoiWo2fs3sU7Do3ykgURoV+dzKE68NL9T5YFQ@mail.gmail.com>
X-Gm-Features: AZwV_QgGRSVBwp4uM0dPHamlPTvc8etDfdZwr36b02cJ3PlK8kbfSfmLtbovNmI
Message-ID: <CAJZ5v0jA6DiP=FoiWo2fs3sU7Do3ykgURoV+dzKE68NL9T5YFQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add PL4 support for Ice Lake
To: Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:01=E2=80=AFAM Daniel Tang
<danielzgtg.opensource@gmail.com> wrote:
>
> Microsoft Surface Pro 7 firmware throttles the processor upon
> boot/resume. Userspace needs to be able to restore the correct value.
>
> Link: https://github.com/linux-surface/linux-surface/issues/706
> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index 9a7e150b3536..a2bc0a9c1e10 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -162,6 +162,7 @@ static int rapl_msr_write_raw(int cpu, struct reg_act=
ion *ra)
>
>  /* List of verified CPUs. */
>  static const struct x86_cpu_id pl4_support_ids[] =3D {
> +       X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
>         X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
>         X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
>         X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
> --

Applied 6.20 material, thanks!

