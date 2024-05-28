Return-Path: <linux-pm+bounces-8308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E374C8D2573
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 22:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95363287901
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC60178CE8;
	Tue, 28 May 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubQpDH4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD0178395;
	Tue, 28 May 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926741; cv=none; b=OyVrTg4UldRDRGEKj9iSkEzFZkjsrWVwBkUQRHt6eZnJGMYJDv4c300wXl7D7jgDP8drFaTFv/G1+BsbBB+EQg5cRmkm089kiPGYk1lx73SSXJ0XHwlJ1BNOkSCCXlX7h2iitEnrzT2h1Zo0MUYnK4+BMeqejG2QMndKRX0v4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926741; c=relaxed/simple;
	bh=K427WA9x1O0/8ZynfZWw6aTk3ce73m8Q0shpDlKZ7jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry8cJkxCQOhc2ntghayAWZ26I85LScF6+ZLc8PKKklm/Au8DNC1ePGGv9GZShYaEMbArUghBCgFo2oV5t33fB+Xumi3YsoaSZVqUrZsknvr3PJFnrvTn5EPrSnoPCoKKEdp+XX2AHiokF5cGFFQqG1n3TifCuJdUc1qS+RBAQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubQpDH4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF32C3277B;
	Tue, 28 May 2024 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926740;
	bh=K427WA9x1O0/8ZynfZWw6aTk3ce73m8Q0shpDlKZ7jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ubQpDH4eT1mxROtWMAC0av/QM9bjC3USsFEIkAxL1YqWU8twE0zth+mGAtlUrT1Ud
	 fMbXvNsplD5DqB1c+5OQGYoQ4TS2y34FLVwr2ANvB/cab17exke+YaLFPGJEHiJq50
	 X0NZcT6EOFIKtOUQZBTOYV+9sxUVPZLFX4KOkWqaAhJ4myCMLHCaPVuxPBuDb+BxQ2
	 dYmzpp/wUvKOtVnPJsPEdABogyYB3zCw5QE9QBN8PDTeGjUKyr1sh93qmMPzjJ3q8g
	 oSz5gO9QxggvIvHUsvykgrlIWjB84tkVoZg3Loe64cmfFYlVlZXRN6sitY7pKmkDDj
	 GlYfi5avYxkxQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b97f09cde3so209434eaf.0;
        Tue, 28 May 2024 13:05:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBvunMPb4XXgd8r+NwZPXFzuD5QJsQFDq0f3BvfCdrEJmNoY+no+LwH70Vny+/1LPvKoskKBPWebAfiGj880tKK3UqrULB7lA8e722RQhKxtY1W0loeBwvck3mm1mDgifzHXG21p4=
X-Gm-Message-State: AOJu0YwDPWQYHBE1XPv+QHqtWOAy59viDayDo7/DpMpG/fmf9VHrGq1B
	u1q1MI7JLbJiG0G3RAAF+lmONbBlgKLkCyeO7DKx42bgypWwsfNeNLzfF04ye4+A1b+l8V1w4XF
	MyafyMkXSfMI3zcplMoz5VOxlw7c=
X-Google-Smtp-Source: AGHT+IE39lzzrMCMFgqaGSM1YNGwA5bF3tH7fIP6yHvy4U78ji+WxRUmhTJ+bMVXK2lJvNwP+naGVUgREY+JqvZp5N4=
X-Received: by 2002:a4a:e6d8:0:b0:5b2:7aa7:7b29 with SMTP id
 006d021491bc7-5b96195f885mr13928240eaf.1.1716926739910; Tue, 28 May 2024
 13:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527051128.110091-1-Dhananjay.Ugwekar@amd.com> <929aec0d-690b-4277-90b0-d0b4adb437d3@amd.com>
In-Reply-To: <929aec0d-690b-4277-90b0-d0b4adb437d3@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 22:05:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hz+RzrtD=JUvf_W7g0vSHTmtfiTcJC23fvVvb_N9AiHg@mail.gmail.com>
Message-ID: <CAJZ5v0hz+RzrtD=JUvf_W7g0vSHTmtfiTcJC23fvVvb_N9AiHg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Fix the inconsistency in max
 frequency units
To: Mario Limonciello <mario.limonciello@amd.com>, 
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: rafael@kernel.org, ray.huang@amd.com, viresh.kumar@linaro.org, 
	gautham.shenoy@amd.com, ananth.narayan@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry.Yuan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 4:40=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/27/2024 00:11, Dhananjay Ugwekar wrote:
> > The nominal frequency in cpudata is maintained in MHz whereas all other
> > frequencies are in KHz. This means we have to convert nominal frequency
> > value to KHz before we do any interaction with other frequency values.
> >
> > In amd_pstate_set_boost(), this conversion from MHz to KHz is missed,
> > fix that.
> >
> > Tested on a AMD Zen4 EPYC server
> >
> > Before:
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
> > 2151
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
> > 400000
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
> > 2151
> > 409422
> >
> > After:
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
> > 2151000
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
> > 400000
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
> > 2151000
> > 1799527
> >
>
> Cc: stable@vger.kernel.org
>
> > Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State =
driver to support future processors")
> > Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>
> Acked-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.10-rc material, thanks!

> > ---
> >   drivers/cpufreq/amd-pstate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 1b7e82a0ad2e..cde3b91b4422 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -669,7 +669,7 @@ static int amd_pstate_set_boost(struct cpufreq_poli=
cy *policy, int state)
> >       if (state)
> >               policy->cpuinfo.max_freq =3D cpudata->max_freq;
> >       else
> > -             policy->cpuinfo.max_freq =3D cpudata->nominal_freq;
> > +             policy->cpuinfo.max_freq =3D cpudata->nominal_freq * 1000=
;
> >
> >       policy->max =3D policy->cpuinfo.max_freq;
> >
>

