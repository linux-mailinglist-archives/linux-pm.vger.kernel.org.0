Return-Path: <linux-pm+bounces-33752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F006B428C0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F73C3B919D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A56368092;
	Wed,  3 Sep 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5WdzNSb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748B368089;
	Wed,  3 Sep 2025 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924538; cv=none; b=gFXm0laE1LQj82TpA6vnt3YN9SdsMBN438QjAUvk4fGAHejlkR9zYk4eS27PDUEUTfNGFUHCRwaGVzJmugYy/bEZXXe8FwvT0baGXZ/ZjPj97rE2Cv1AH7LeBhluu5Lw8P52FgsSdiWt6pPM/EPVtumq8LFYhxUqS66nvwywADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924538; c=relaxed/simple;
	bh=IjPPP+c6tWyLw6wQQKtlKQ3iXM7IyODWQ7haY+XqloY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Her39NRRieTUBGfBomLVFHe5pYZwy5htyduYNsaj9P4PwjiYagaSF2UM+y0rRzmE6bITOTcsaAaiI5mAun3uF/IOFIpjO0rNf555pm4FDsjpcqln5LiLnxmobE6WhbH/05q4Vsabq8r336LLuvXLOuSeWhqKdCxY8BcVcmUA5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5WdzNSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C37C4CEF1;
	Wed,  3 Sep 2025 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756924537;
	bh=IjPPP+c6tWyLw6wQQKtlKQ3iXM7IyODWQ7haY+XqloY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n5WdzNSbHmmq7r5KO5WzrhQtOX4SKxXEiDyToULyQ/idA87ldhACFIRjunPs8P9Tu
	 2i8adrGV7aGhK/CleFVZbP7qPgW96qMviLZBaYHDo2gwOwD7xzGH6+5d13s4fSeCQc
	 Q97QnyiggxNIZ/5y6CzW5+FM2eQ3oyzXWkudWmaSmYaU2sXi88wvQrTgvxsXuiAncS
	 J/f4C8SGnnKmHZ51PzODl71/5v9Sm5mvboU4RHYwZQZ2dpytqE1hNDwuaG4itZfoxc
	 IdfsiVh4AVV5hXtPJ3VDb68HexXyFyPBGst5sS8OkiJ6tH1ivECmuhO2jTsOHNMS0L
	 j9/HakQxfZReQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61e4f5f46cfso80018eaf.0;
        Wed, 03 Sep 2025 11:35:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzkvhaqApp5sPRax/EyPwOGT4Hrpnzsu6ESNhsUmLBS3RmdbAumJDGYFw1QLQ387GD2gTaWVLT9to=@vger.kernel.org, AJvYcCWBreSZYckkw1/0nIdTH3uDOWI9Dahxsd/o3TJh7C6O3Fm5FA9ZaehQ2BBeoBNfjUV9cbYyZP6EO+rvgbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtS2QS5faHcchY7vyHEbCia98UR75w5/Gd7clS/xkeEz9ZLXX
	InYk4SMnrAAahzF6FYPE/Ma4KdCGiPbtQepuB0LuAzEsVjIeTNMVoln4lHJQWN7M/ozerfBomxa
	kA5v7X5X2CdIvCmi2DTHJwYofpCbYVGA=
X-Google-Smtp-Source: AGHT+IHcVyuPueHYutqfiO2a11D7xs+rkydQE1nQYBQhq3NtxHJnOTF/VqrCirG3hX67b+AveDMKHFO/KrEnzLGNees=
X-Received: by 2002:a05:6820:1c83:b0:61d:b236:a864 with SMTP id
 006d021491bc7-61e336f524fmr8229208eaf.3.1756924536872; Wed, 03 Sep 2025
 11:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0ik7fRKwH3CnXysvBJkkdJbWP-6iL=zBF0o92rR+nHTKg@mail.gmail.com>
 <4f340f1e-1cbf-4b50-ae23-a0e50170146c@intel.com> <CAJZ5v0hQEecBFfZkefbipXPV6HVupz67q5RYR=heC=ZUpOY+bQ@mail.gmail.com>
 <c65c1b18-be70-493f-ab1f-07af55902772@intel.com>
In-Reply-To: <c65c1b18-be70-493f-ab1f-07af55902772@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 20:35:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jqUkBHarZkViyy1j-UUL3fgF7cp7AeU+X2Nyj1BCfBcg@mail.gmail.com>
X-Gm-Features: Ac12FXxpQI-jp1kKgxBfIC5TqYnqhSzY-gRax2CKo1TF1r7DqfzLIOhPZuui6qA
Message-ID: <CAJZ5v0jqUkBHarZkViyy1j-UUL3fgF7cp7AeU+X2Nyj1BCfBcg@mail.gmail.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Loehle <christian.loehle@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:00=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> I munged the changelog up a bit:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/=
?h=3Dtestme&id=3D13f107f882bb5
>
> I hope that looks better to everyone.

It does to me, thanks!

> I also went looking at this assuming that it was x86-specific. I'd
> appreciate a quick head nod from Thomas or Peter on this before I push
> it anywhere, though.

Sure.

Thank you!

