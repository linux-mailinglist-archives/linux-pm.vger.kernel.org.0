Return-Path: <linux-pm+bounces-11832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4719B945E06
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790E61C20BE6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038751E3CA1;
	Fri,  2 Aug 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvCfs1ki"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F6A31;
	Fri,  2 Aug 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602642; cv=none; b=eQ0QWl/UdW1G6dgSkE3gPEHXz+qnc0AhOJ3Lw/pUKmv9sWj49UshOGfiW5LOyQn3Hfb9V07Wyj1vj+xESut1rdUpWHhLtJbEBDxzDAZrsZDMdmJAcA5sN/CNX4DrhGXwRu6eIaitEeXR5cBVd3fhk50sE6cRPpgtSx16xkOI5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602642; c=relaxed/simple;
	bh=mT5OyCqE+ifUSqdxUgq7WqY1sXV0ylJ9Y8tNhLWK7GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHKoBULn82308qxkcuubzwhTRRKDNzqfX86efIYG3lyCtA1YHM9d//xUoQq1uHrkEfGuOQVHNTWui0QP65scXCEwY97bal+zW1d+oTtZicDpjRx/5mPltT3PyGVAVepYkg4CrRN4y6e6uy5gWKAJ0myvurxYohAugUnNJcQNVlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvCfs1ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6015BC4AF0A;
	Fri,  2 Aug 2024 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722602642;
	bh=mT5OyCqE+ifUSqdxUgq7WqY1sXV0ylJ9Y8tNhLWK7GE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CvCfs1kieg1v87ZnpQ7D3AiOXwkB/dGWmbzjQS5mE7FAwczBU1XmyvOsLlw8JLGdM
	 p8gdqA386M4DkFj3B3Nm54NNK1sDzM3QZ82zqmR4iAebbryqsV0aZL4O+M8FIz92Z/
	 sFEJn3TnHsJqVTPJxjBSj/b03ui9Nr28EI2ZSEom2DbL9FxvVazyfdnWuzUETXP1oi
	 YUBup0Qx6pMU2FkIKGFRh9does3tMQHFSnyyvyiWJICJyRM8YVOvh2FV+KqJLMrlCo
	 93whJW5+Eo+GxsQeYDhSNfOqb1+y6wHdoc6ub5uMSrf5D63f1jT/haM2VUbT2zztE2
	 eMsbfRlRWCNpg==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db199ec527so671303b6e.0;
        Fri, 02 Aug 2024 05:44:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWXstzxxTky0e65JQqlGd31GedV/kOX3QYOy6c4hNcB63NTkY3Xxw/uzHnwyhc5rUohqjPXmGAGFpc5L+IQzaNcuSVSfJvMgsW9Ie6TS7AWZXALCnXQLX6UTLWQ/wtSKnwqhMWeuA=
X-Gm-Message-State: AOJu0YzC4dQ2fZ1F4gFv9ZA31kaXR6MZrF6prdF78gMSjJTTK8bGAVZ+
	RVh7v7IMmLdVTpP4+ZsM61WxA1CvAN9m/gLTnnTr7DrqKPFG3/Vf2TtE9WtCZffaabA3pkCrjY6
	26VQuqhXM67P7edhQmFg8Tir2R68=
X-Google-Smtp-Source: AGHT+IEKCLCByGf5JzolRKQqiv5jfoW83RzmeCSzCXLVU3NyxigIXnyCwwS6wcD6huINVSyldmDWPTfzJal9naV5Oqw=
X-Received: by 2002:a05:6870:2054:b0:268:2075:a41d with SMTP id
 586e51a60fabf-26891e9f1aamr2224700fac.6.1722602641727; Fri, 02 Aug 2024
 05:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zqu6zjVMoiXwROBI@capivara> <c15a8a105308262856ee14bab558d34df8bdf92a.camel@linux.intel.com>
In-Reply-To: <c15a8a105308262856ee14bab558d34df8bdf92a.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 14:43:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ibMvRE7OrLQO9CJh__hL7rbO-03KT7EAsAEoQxVdX4eA@mail.gmail.com>
Message-ID: <CAJZ5v0ibMvRE7OrLQO9CJh__hL7rbO-03KT7EAsAEoQxVdX4eA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP for
 Emerald Rapids
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Pedro Henrique Kopper <pedro.kopper@canonical.com>
Cc: rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:42=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2024-08-01 at 13:41 -0300, Pedro Henrique Kopper wrote:
> > On Intel Emerald Rapids machines, we ship the Energy Performance
> > Preference
> > (EPP) default for balance_performance as 128. However, during an
> > internal
> > investigation together with Intel, we have determined that 32 is a
> > more
> > suitable value. This leads to significant improvements in both
> > performance
> > and energy:
> >
> > POV-Ray: 32% faster | 12% less energy
> > OpenSSL: 12% faster | energy within 1%
> > Build Linux Kernel: 29% faster | 18% less energy
> >
> > Therefore, we should move the default EPP for balance_performance to
> > 32.
> > This is in line with what has already been done for Sapphire Rapids.
> >
> > Signed-off-by: Pedro Henrique Kopper <pedro.kopper@canonical.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 6.11-rc material.

If I'm able to send a pull request next week, I'll push this for -rc3.
Otherwise, it'll be -rc4.

> > ---
> >  drivers/cpufreq/intel_pstate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 392a8000b238..c0278d023cfc 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -3405,6 +3405,7 @@ static const struct x86_cpu_id
> > intel_epp_default[] =3D {
> >        */
> >       X86_MATCH_VFM(INTEL_ALDERLAKE_L,
> > HWP_SET_DEF_BALANCE_PERF_EPP(102)),
> >       X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,
> > HWP_SET_DEF_BALANCE_PERF_EPP(32)),
> > +     X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,
> > HWP_SET_DEF_BALANCE_PERF_EPP(32)),
> >       X86_MATCH_VFM(INTEL_METEORLAKE_L,
> > HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
> >                     179, 64, 16)),
> >       X86_MATCH_VFM(INTEL_ARROWLAKE,
> > HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
>
>

