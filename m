Return-Path: <linux-pm+bounces-17836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA799D42D9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 21:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1140B23E16
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B491A9B27;
	Wed, 20 Nov 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FACraslG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D5170A30;
	Wed, 20 Nov 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133311; cv=none; b=CBkzNajgwA0kz1LqM4wO/Zd7UV9lsonU8MFKuXt5NlNMqO5zAjLPswYhazdsT6WGyGfyByZOmvsDLzlb7DvhnA43Qf2GQe3WYr4nM5Di5/f8jIPE2mlP8CacPOKnqcJO7HyMbWvvbwVFCs8/HZRng8jWgaO79ezbKZej6XxSTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133311; c=relaxed/simple;
	bh=3adV8HrFmBBsK47jOerk6qZsRnE02LMSN6kjXvuoFuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZci0uSR+hDOG4ECGBzJxd0uXKQm5xmL+7LIOzC2a+IeWFQsAVHxN2HlaF4EhmQl+a6YF3gDAtIbmJSjfGcwtVPtGbR1ZpMwTndwUM8fm+JruHuxQ7K2HrdIzWdSuAHXZDPIveBiNIwMJpnc6vaN0dVYCGjXRwGekDqxlaf7SfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FACraslG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38214C4CED3;
	Wed, 20 Nov 2024 20:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732133311;
	bh=3adV8HrFmBBsK47jOerk6qZsRnE02LMSN6kjXvuoFuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FACraslGOjXUdwMaJUQB16BA8hZ0r8z0183dUJsT+JOJM+0cQeMDeGANxc77FugkO
	 Rl8BMUWasqQMcqo557+P7YXditc1Lj83oQKxmD5uYhsTVVdwni6g6JFpXmpAXNd53N
	 vi4wSTdL8JP290fX/kGysRp2mBfD+DH/vuHSzRo4RWTGARLnXMndnyTsP0PQP1/6z/
	 eV1ZbPbeT/aWUPDC64QP0+N55o0mX38FoEo9SeRAEBM0+7iGaACi89u1+8DfA/4T4e
	 SJcJn/RL8H91QuH3VLczRAzbsLt88X76Cax6PX0LHt4V/BxJLYFBGD8lNVz+ssxZ59
	 2BekPh+rDjqlw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-295cee3a962so145929fac.3;
        Wed, 20 Nov 2024 12:08:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBqClXtk+1oDfr5BEX2UAse8XpGRCQdqm+6cEp5+XPZeEM3DAqsd3vmlxb2htjP9fT30AWlt45MZ8Foak=@vger.kernel.org, AJvYcCW0Iv0CFG0zRbTParhrAfAGp+MyGpEMkynav1T4VmPqeLgsqv18M8uzdhLpuEoPp20RCoGOzSWM+I4=@vger.kernel.org, AJvYcCXfGairnPFZ3WJT3kcJkxzKup3lPIbraJMzivQ8cGlmU73QkMZSUwywLp2sCD+jXYoHjYRU1TCE@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZK9M7UXtbmaqoU+P3/L8tMh/tIG14b4PP/FScJ49uAltJM9o
	2db/bcz3grHharzl0O1cjrUuxdqilfcqWVk1qfTULu+v+L03vzVQis9i78o9bXyLdU48YREAUwn
	ZE4xDhiNcPzdEzap6dopmoZbTuQI=
X-Google-Smtp-Source: AGHT+IGL/hP6CMZbWdPeJLDTJuxVmxaSUuYlnUcSm8vnjsiunRJiK4BrsaJCTvtwAmiO8Z61GAdeM3rx/BCjsUbQDXA=
X-Received: by 2002:a05:6870:9123:b0:277:d9f6:26f6 with SMTP id
 586e51a60fabf-296d9bb710cmr4308325fac.12.1732133310505; Wed, 20 Nov 2024
 12:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4aa8842a3c3bfdb7fe9807710eef159cbf0e705.1731463305.git.len.brown@intel.com>
 <c5f9c185-11b1-4bc8-96be-a81895c2a096@intel.com>
In-Reply-To: <c5f9c185-11b1-4bc8-96be-a81895c2a096@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Nov 2024 21:08:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iCR5ZbNz=OF1MbJUJdhCRh2P8M_MTF7eszPe5uv9_R1w@mail.gmail.com>
Message-ID: <CAJZ5v0iCR5ZbNz=OF1MbJUJdhCRh2P8M_MTF7eszPe5uv9_R1w@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
To: Dave Hansen <dave.hansen@intel.com>
Cc: Len Brown <lenb@kernel.org>, peterz@infradead.org, tglx@linutronix.de, 
	x86@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:12=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 11/12/24 18:07, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> >
> > Under some conditions, MONITOR wakeups on Lunar Lake processors
> > can be lost, resulting in significant user-visible delays.
> >
> > Add LunarLake to X86_BUG_MONITOR so that wake_up_idle_cpu()
> > always sends an IPI, avoiding this potential delay.
>
> This kinda implies that X86_BUG_MONITOR only does one thing.  What about
> the two other places in the tree that check it.  Are those relevant?

They are relevant, but related.

The first one prevents mwait_idle() from becoming the default idle
function, which only matters if cpuidle is not used, but this is
consistent with the mwait_idle_with_hints() behavior.

The second one prevents KVM from using MWAIT in the guest which I
would think is a good idea in this case.

> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219364
> >
> > Cc: stable@vger.kernel.org # 6.11
> > Signed-off-by: Len Brown <len.brown@intel.com>
>
> This obviously conflicts with the VFM infrastructure, but shouldn't this
> also get backported to even older stable kernels?

As a matter of principle, it should go to all of the stable kernel
series still in use, but it obviously needs backporting and I'm not
really sure how attractive the old kernel series will be for LNL users
(quite likely not at all).

> I thought the "# 6.11" was to tell folks where it is *needed*, not where
> it actually applies.

My interpretation is slightly different: This is the oldest series one
wants the given patch to go to.

