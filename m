Return-Path: <linux-pm+bounces-29985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395B0AF615D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F64A4625
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DE1FFC46;
	Wed,  2 Jul 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgE0oDx/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D492E49A1;
	Wed,  2 Jul 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481201; cv=none; b=BRkjGUzEWiYNQ/V3DrgtTiSi7/r7DKNRahYXHUfxl4ACAj13//1Unw9L7M3aNUgmVRZgJ3XeODM17oE4wUlVHHQ0Ps6kOoboAU7mQbOdU/TQjmU77rBLTaywNGGPaSfcdOBT9pK6h803DTait3+vsr8BQGB2JvC6ot1zbjy0atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481201; c=relaxed/simple;
	bh=AZX4rOaDzDq62apRDx1lLWeZhM/Z0FWgjhK2Pd+yBac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efZzdr1EWecL2kfa1/DUalDILP+QLW8K4rZoUudqlpOjdPFwLipZgEty2CnobVErR0gjCMV46Oi2TcdLiSchDFoT2yzJmk+AuqJJw+IwJqBPaErRmyJDyTH8PEeKmGqH5kBDQPGIp6O0bZX98YdCz9UcBo9PgFBLBMcotZl/Z7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgE0oDx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A10C4CEF2;
	Wed,  2 Jul 2025 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481201;
	bh=AZX4rOaDzDq62apRDx1lLWeZhM/Z0FWgjhK2Pd+yBac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VgE0oDx/GuPnfWBo4Fib8YKW138d0HEJUoT+N0lpdxAZm9tmmXVcIStrTCMtGp4AS
	 BYJXF90JGZbrOSXkmZj4LAGudGlzJJmpFqYoT+uJmbBLMq2svnR8EOGN+tPVAhZXgc
	 h8LCDjWuDn3NmNi0L66uopbvsa2xpWALeSzttHqOa6fHXBLebiKH3Gz1/w/uqHcENj
	 T1OqXchDq6sV2qL8CFnY2qvJmRo90HbP1oTyHJWroz1wF0ktfrxiCuDOE96GWs0+3Z
	 WCPXboWpi7fVZ1QDzlB2jDs57nLxv8Yid4NW3dgUyYCpDZoBy+Qk+RTqzbXPNpcOG+
	 lPvMqIQacMSsQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40a7322f081so1172830b6e.3;
        Wed, 02 Jul 2025 11:33:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+rG+4lIcRGyJOjpB7Hg+a9JkysmjVNg6VQQddm9TIojjqy1y+fvIOSCurm0nbVlqr/CRA3hwc7RxaiiFq@vger.kernel.org, AJvYcCWEPUMG4rtSaggcYhcJToQj+Z9QUP2QXiTI+KobQKYPcja1EI6mPCN1cqPC6ZnnmRpnYR9merrfY04=@vger.kernel.org, AJvYcCXdGISGa7bYYbttiDOGXZJVYkgjpktIDvU/5tIuahOwTkXuPKnmwG/lbelJx92VqqOL1JPcI+Z3Y9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYZLle5wfT3IuQLoaJWWjJoogG+ZE8WbBmCU0OiiWSG6LLbkC
	UIVz2SKZf76KU0F6cnk4Z0zpaOYdRnedZH2YVGlN1Wz+ImWRyaWcDY8xy2IRir4AEqa9Y4FuE6U
	ybaPeeHzk08BuniPVgjg32y8N+ORwZ4U=
X-Google-Smtp-Source: AGHT+IFpOfezcX0xxZb3iI/WWci7TV15gILr09AdZat7JaaqZKvWehMMV/hHEe5T6txTb6mOM+ZmdaFhbcT7OQNCXLA=
X-Received: by 2002:a05:6808:1811:b0:406:76e4:c4f with SMTP id
 5614622812f47-40bf1523e20mr227445b6e.18.1751481200577; Wed, 02 Jul 2025
 11:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a0f5b68d-e321-4ed3-a22c-24f80f4d906f@linuxfoundation.org> <20250523220238.455718-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250523220238.455718-1-sumanth.gavini@yahoo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:33:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j83tV765Sfd4qB+pYc8YyUuuafyEnAg95tQKMprcfCMw@mail.gmail.com>
X-Gm-Features: Ac12FXy13MjsFgPz0R3_QnmlQ4eVkvBhZKCj16xgvWW9BOuzJ2deYDBmTpZ44TY
Message-ID: <CAJZ5v0j83tV765Sfd4qB+pYc8YyUuuafyEnAg95tQKMprcfCMw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: ABI: Fix "diasble" to "disable"
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: skhan@linuxfoundation.org, rjw@rjwysocki.net, stern@rowland.harvard.edu, 
	arjan@linux.intel.com, linux@dominikbrodowski.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 12:02=E2=80=AFAM Sumanth Gavini
<sumanth.gavini@yahoo.com> wrote:
>
>  Fix misspelling reported by codespell
>
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> ---
> changes in v2:
> - No code changes
>   - Link to v1: https://lore.kernel.org/lkml/a0f5b68d-e321-4ed3-a22c-24f8=
0f4d906f@linuxfoundation.org/
> - Addressed review comments from Shuah Khan.
>   - get_maintainers.pl doesn't give you the complete list, So resending
>     the patchv2 with linux-pm, doccumentation list and PM maintainers
>
> ---
>  Documentation/ABI/testing/sysfs-devices-power | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentatio=
n/ABI/testing/sysfs-devices-power
> index 54195530e97a..d3da88b26a53 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -56,7 +56,7 @@ Date:         January 2009
>  Contact:       Rafael J. Wysocki <rjw@rjwysocki.net>
>  Description:
>                 The /sys/devices/.../async attribute allows the user spac=
e to
> -               enable or diasble the device's suspend and resume callbac=
ks to
> +               enable or disable the device's suspend and resume callbac=
ks to
>                 be executed asynchronously (ie. in separate threads, in p=
arallel
>                 with the main suspend/resume thread) during system-wide p=
ower
>                 transitions (eg. suspend to RAM, hibernation).
> --

Applied as 6.17 material, thanks!

