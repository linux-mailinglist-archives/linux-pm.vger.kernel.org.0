Return-Path: <linux-pm+bounces-6130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DC89E6D0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 02:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D24D1C20D74
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 00:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634B19F;
	Wed, 10 Apr 2024 00:27:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1EF7F
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708824; cv=none; b=tOBHhlkqJfvpEl55Ce7+idWvY1wizqODl1TrOJFTzXyeC/F2GPGv0GjarJpQmuBY8u73O/U3ao+14yi9ZAuDqfuWH8dRuuBM0ihI5zoK4ymymNEwci1ToaQE0nUhBQiA9rAclcgTCUlq205ankPOzO0m01zqQsuMb9iVUMlazeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708824; c=relaxed/simple;
	bh=nXCHJtb/B9jOjgLZ3uXhoeeeRjUYJ5ew3VETxBo6nm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4nOyRK7hAasDEf5ieLXxRLYEHqHe9h+o/GJHOWjWky/DuRo3VVZ1/IJY2jMjjEEM4Jy095BHnuRIHFAX+i2yPHzVFCEhVes2ToErz7lx6pC3r1g+UFxJunS05XrMyXxF3dYq5nJWRotkHa6AAB69KrkSVJ3xTJwUqeIuRKAoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea2f95ec67so156936a34.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2024 17:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708822; x=1713313622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrjEz5aSZJDueEik9MiaYk9FAwd2hpm0XwdN1LS7A2k=;
        b=rWBuaAttB1ipdXwnzZrhvL1jb5NxKawiYt9B1Erm79opD+UZeYGHFqLomp0Iez56WQ
         f/87r9A8Xg5rh0l39YH4oeO/eq6TF1105UdvJc2sRiXcnig9eDvpGn8yQlcAgyiae72f
         AVBu8tVe+hal6CJfP30K0ytxR6NSqdyq2CRuqqFt6SXcmik+sRzvUzDfva1fc3TIpJ3g
         j4C9+CYnCpV5PSOtBDWGZFZDiucGhD539OS9vsE306dOQXVJx5bros8tJ2ooN4cIYLEu
         MMSc+fr0yivdrZkD2QCC9oUYkM44/ot+a7bc+Z37jKYvHIBIM3dC1M2XetOmpHROx1vC
         Uujg==
X-Gm-Message-State: AOJu0YwkP/Xojik2W2WN4yfEbHLpW72ieZ/9K6UUrF71Gg2lXQNFenD3
	2gDCsR6L5OqAD8j348bkZ0mjr7yfe0EVNsRZFk3JCcm5kG7RE4TnNTsosGSiwUVbRabyGcIHUNd
	GY34pWS5upRbwSXpKx2IrLs+vFOpVskse
X-Google-Smtp-Source: AGHT+IGhF9iLuzXzCzUkMy3aeFr4BEIzKKpfO5ZOemwM0+8jyRmJ+8qk38ZYULgrWKvZTRZ/I3xr/XJ3BU/qJIFU80E=
X-Received: by 2002:a05:687c:20a:b0:22e:b2b4:f009 with SMTP id
 ax10-20020a05687c020a00b0022eb2b4f009mr1102152oac.39.1712708822120; Tue, 09
 Apr 2024 17:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409003120.338589-1-lenb@kernel.org> <001001da8a94$33d941c0$9b8bc540$@telus.net>
In-Reply-To: <001001da8a94$33d941c0$9b8bc540$@telus.net>
From: Len Brown <lenb@kernel.org>
Date: Tue, 9 Apr 2024 20:26:51 -0400
Message-ID: <CAJvTdK=r=tt=1nZCrd0NGL9Wmg-nQ+urL-A-P8BbUP=EKxspxA@mail.gmail.com>
Subject: Re: turbostat 2024.04.08 queued for upstream
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Doug,

Yes, git-send-email bailed out due to an smtp problem before it
finished, and I didn't notice it until people told me this morning...

There have been a couple of patch revisions, including what you
pointed out, since I pushed, and so today I re-pushed.
Note that the new will conflict with the old, and so you need to force
the new pull, say onto a different branch.
I'm waiting for one minor tweak, and then I'll likely label and push
upstream tomorrow.

cheers,
-Len

On Tue, Apr 9, 2024 at 11:40=E2=80=AFAM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> Hi Len,
>
> Thank you for the new version of turbostat.
> There seems to be 5 patches missing from the set of 26.
> I also checked on patchworks:
>
> https://patchwork.kernel.org/project/linux-pm/list/?series=3D842622
>
>
> On 2024.04.08 17:31 Len wrote:
>
> > Please let me know if you see any problems in this update.
> >
> > thanks!
> > -len
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbo=
stat-2024.04.08
>
> I cloned it and all 26 patches are there.
> I would just compile turbostat there and use that one, but it doesn't com=
pile.
> (see below).
>
> >
> > Turbostat version 2024.04.08
> >
> >Use of the CPU MSR driver is now optional.
> > Perf is now preferred for many counters.
> >
> > Non-root users can now execute turbostat, though with limited function.
> >
> > Add counters for some new GFX hardware.
> >
> > ----------------------------------------------------------------
> > Chen Yu (1):
> >      tools/power turbostat: Do not print negative LPI residency
> >
> > Doug Smythies (1):
> >      tools/power turbostat: Fix added raw MSR output
> >
> > Justin Ernst (1):
> >      tools/power/turbostat: Fix uncore frequency file string
>
> Missing.
>
> > Len Brown (4):
> >      tools/power turbostat: Expand probe_intel_uncore_frequency()
> >      tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latenc=
y read
> >      tools/power turbostat: enhance -D (debug counter dump) output
> >      tools/power turbostat: v2024.04.08
>
> Missing (just tools/power turbostat: v2024.04.08 is missing)
>
> This chunk of the patch:
>
>  @@ -3371,7 +3374,7 @@ int get_rapl_counters(int cpu, int domain, struct =
core_data *c, struct pkg_data
>         struct rapl_counter_info_t *rci =3D &rapl_counter_info_perdomain[=
domain];
>
>         if (debug)
> -               fprintf(stderr, "get_rapl_counters: cpu%d domain%d\n", cp=
u, domain);
> +               fprintf(stderr, "%s: cpu%d domain%d\n" __func__, cpu, dom=
ain);
>
>         assert(rapl_counter_info_perdomain);
>
> Should be this (note the missing comma added):
>
> +               fprintf(stderr, "%s: cpu%d domain%d\n", __func__, cpu, do=
main);
>
> With that change turbostat version 2024.04.08 compiles.
>
> > Patryk Wlazlyn (11):
> >      tools/power turbostat: Print ucode revision only if valid
> >      tools/power turbostat: Read base_hz and bclk from CPUID.16H if ava=
ilable
> >      tools/power turbostat: Add --no-msr option
> >      tools/power turbostat: Add --no-perf option
> >      tools/power turbostat: Add reading aperf and mperf via perf API
> >      tools/power turbostat: detect and disable unavailable BICs at runt=
ime
> >      tools/power turbostat: add early exits for permission checks
> >      tools/power turbostat: Clear added counters when in no-msr mode
> >      tools/power turbostat: Add proper re-initialization for perf file =
descriptors
> >      tools/power turbostat: read RAPL counters via perf
> >      tools/power turbostat: Add selftests
> >
> > Peng Liu (1):
> >      tools/power turbostat: Fix Bzy_MHz documentation typo
> >
> > Wyes Karny (1):
> >      tools/power turbostat: Increase the limit for fd opened
> >
> > Zhang Rui (6):
> >      tools/power/turbostat: Enable MSR_CORE_C1_RES support for ICX
> >      tools/power/turbostat: Cache graphics sysfs path
> >      tools/power/turbostat: Unify graphics sysfs snapshots
> >      tools/power/turbostat: Introduce BIC_SAM_mc6/BIC_SAMMHz/BIC_SAMACT=
MHz
>
> Missing
>
> >      tools/power/turbostat: Add support for new i915 sysfs knobs
>
> Missing
>
> >      tools/power/turbostat: Add support for Xe sysfs knobs
>
> Missing
>
> >
> > MAINTAINERS                                     |    1 +
> > tools/power/x86/turbostat/turbostat.8           |    6 +-
> > tools/power/x86/turbostat/turbostat.c           | 2197 ++++++++++++++++=
++-----
> > tools/testing/selftests/turbostat/defcolumns.py |   60 +
> > 4 files changed, 1805 insertions(+), 459 deletions(-)
> > create mode 100755 tools/testing/selftests/turbostat/defcolumns.py
>
>


--=20
Len Brown, Intel

