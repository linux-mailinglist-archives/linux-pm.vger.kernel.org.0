Return-Path: <linux-pm+bounces-21406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE4CA29500
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A090C16143B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D21891A8;
	Wed,  5 Feb 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd9Y8UKH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258181662EF
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770011; cv=none; b=CCPTBGON35XtU0DjSwlZIoCqJJBw7VZLMeGUxUND6sPigRtxUXL4UAOVOOD2YfOKJx/eMOvshqMjmkfYgeTH3MNuyE0HsS2LMvbUVQ2FMFtbbJo9SFWCqOxi/LU/tyvtd+zJOiX/fcbb7xcwvwz9j8uaOyOn5ViBYExwDuhqjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770011; c=relaxed/simple;
	bh=ubf0aD29A5i8aEfsHz0jbIlZMONo9cSK4zFQq2uweeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp1olmpQC/lltwzyuTUEWNJ1uvayYV+0t7zoHZu+rPyWBBnckdoGYVxdAI/gUM1V+O2M4Um8mDPd7Y7u7yi2/y++h4Mn4g1aaIRsyQxlF14b11xWUWaK+LgAn1IoeyqPOi0DaXEMGK1Rt1j+bcAwJQ0zMt5VatX16evqWjr0nZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd9Y8UKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18C3C4CEDD
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738770010;
	bh=ubf0aD29A5i8aEfsHz0jbIlZMONo9cSK4zFQq2uweeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jd9Y8UKHR5+dOgqiz/T/m0KNlBVul9WWnChdJRcGoW618AvHb6Tl1KidAjodW7t2a
	 ea/KAxlMIejb6aN9wjgX21BWIDXqDI1xVIOUyRSIbMWM7twXEQIKbnIMp7xwUPLuF/
	 3wAeWHQezKt+hkDjnGgdD+5jqNqchKbLpLdLQ0cmpTgHru4gwzgyfQoC4Urz2+v8sN
	 BvjWgCFCPrvZSSQDsueXYkuhhzHPIDpKO9WKqSHw9KGHaozc5tYVtvRiT9HbITkH25
	 AT75w0gpb4XASkk3SS839SWhRK+pfsaf5M0DK6LM/wpEgbalButOyFrM6dxHdndO40
	 hoQnnd9/IuLXA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb6b16f1a0so2129259b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Feb 2025 07:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1YngZp6GRkgXVqMlvyN8JgfJqtXP/5ACqDo6n+EV9se0IClN1fn11V7WAPyi+cKhHd49XC2niBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/oenpKUhCjPqikA1bDmJE/FjPtf52ZwqpCGxlzGKp4v4XtS0
	gHrkKFF5zuNvvGLTBEGK7Vh+LUAmDoqc/15SbId2oRlux4fid4psgwdqvI2l43Fqm/5A4yE0ty0
	CE60jlErcmYESTeahbRmwgo9fz5U=
X-Google-Smtp-Source: AGHT+IGuJtyjjtR9iDP1ikwbS7I0Ucn1LX8k9dZ6os1whak+QPUtTqmOPKOdhsWXSGLIHufErfTgQ6WP5lZhSWM2SAk=
X-Received: by 2002:a05:6808:3c44:b0:3e7:5b06:ff61 with SMTP id
 5614622812f47-3f37c155724mr2327362b6e.21.1738770009930; Wed, 05 Feb 2025
 07:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
In-Reply-To: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Feb 2025 16:39:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j4rqfSzBp8DroJsGYYDW=5k_qo1p=id7Sbe0_7bKK_qA@mail.gmail.com>
X-Gm-Features: AWEUYZl_rmBXy87X2iO10r7sTpp-ZVnLvbBdz7Kqa2fu0nplPOxtViUu2-oeav8
Message-ID: <CAJZ5v0j4rqfSzBp8DroJsGYYDW=5k_qo1p=id7Sbe0_7bKK_qA@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] SRF: Fix offline CPU preventing pc6 entry
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Artem Bityutskiy <dedekind1@gmail.com>, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:21=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> Code for determining the mwait hint for the deepest C-state by
> inspecting CPUID leaf 0x5 in mwait_play_dead() assumes that, if the
> number of sub-states for a given major C-state is nonzero, those
> sub-states are always represented by consecutive numbers starting from
> 0. This assumption is not based on the documented platform behavior and
> in fact it is not met on recent Intel platforms.
>
> Changes since v9:
>   * Patch 3/4: remove the '__cpuidle' instrumentation tag from
>     intel_idle_enter_dead() to address this objtool warning: call to
>     cpuidle_get_cpu_driver() leaves .noinstr.text section.
>   * Patch 1/4: rename 'hint' to 'eax_hint' in the !CONFIG_SMP for
>     consistency.
>
> Tested on AMD Milan platform and on a couple of Intel platforms.
>
> Artem Bityutskiy (4):
>   x86/smp: Allow calling mwait_play_dead with an arbitrary hint
>   ACPI: processor_idle: Add FFH state handling
>   intel_idle: Provide the default enter_dead() handler
>   x86/smp: Eliminate mwait_play_dead_cpuid_hint()
>
>  arch/x86/include/asm/smp.h    |  3 +++
>  arch/x86/kernel/acpi/cstate.c | 10 ++++++++
>  arch/x86/kernel/smpboot.c     | 44 ++++-------------------------------
>  drivers/acpi/processor_idle.c |  2 ++
>  drivers/idle/intel_idle.c     | 14 +++++++++++
>  include/acpi/processor.h      |  5 ++++
>  6 files changed, 39 insertions(+), 39 deletions(-)
>
> --

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all patches in the series.

Thanks!

