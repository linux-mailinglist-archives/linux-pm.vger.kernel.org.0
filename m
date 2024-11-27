Return-Path: <linux-pm+bounces-18144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BF9DA630
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 11:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BC8163AC1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31E1D5169;
	Wed, 27 Nov 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHLylw9L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03A1D4615;
	Wed, 27 Nov 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704834; cv=none; b=N34BY5HYkI6rcqcUgs+x+HjicXdYYJZqBlgfVRMFzGwy3DFqeonZXnGOSMIFh++mONXj0Uw3ovFh18o7xXbWL/T03PjSgrGNWxpab6S7pxmRgslH5bKY0ODam9iosEFGwquXf6c4vHSy85iWIU+JpBFn6x7db0MWfqrluH/tr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704834; c=relaxed/simple;
	bh=6XoEF5skrr2YRZh0MLj7vFVwPVlrkVX9jwGWw17Wm00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C87t2lOdkKZMEppwbO2epz8aaeavh+hggwCCxojnv+GbJRrbl/wynf2Is3vghoTXc5TkwnKut1f1J0KJ0/tHAuEytAZ3kVcRHgXFGKA9gAVoIvjr0TV7CT4jkiZAmxfbf7oRfS0jgSzUW8ISCuTC0n4CGCBIrmHCM7KFo+eyZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHLylw9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE14C4CED9;
	Wed, 27 Nov 2024 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732704834;
	bh=6XoEF5skrr2YRZh0MLj7vFVwPVlrkVX9jwGWw17Wm00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cHLylw9LQ/8bCzEd6Br88Jm0Hv7nwpA113HRIt/mySY1i4tdZxHOmIlwMh5MYpaAN
	 DZcVtbhD57vF5UcOEV9o+HTl/9hql6RUyXtS+5nT1J96Xlin847e8HQVBNjnmDtPQf
	 xUPy/P9haLxGBf5hcb+1QdxYMNApzgcPLQ1ItDtSqPZzYobRrcLIBxWUjlumo/rLIo
	 Vv4C7kV55ckWw4bFqWXhW4YLu/ZAyswuBAqU9IgThPJs8AGU024nVBJXKatvuu/5z2
	 WbT7MMvMceiapv5W/vFSbFzPnBI6ELyVQwbTR2T7mo/p/1vNwlQKbdo9yy7JWuIS1Y
	 yuXpnwrBBvPig==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-296bf028170so2491851fac.3;
        Wed, 27 Nov 2024 02:53:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC1/5hbaNo1htoHSpHKyfDpHtWZoC+CVYjStxveMR6wljdNih1uFFm5rJHYB81QyV10uVGAOJeZrc=@vger.kernel.org, AJvYcCWMLU/6tQQxH6OCh9FFxcNfq74q5InlAeh/X/WoJsQBBOCmK3abdE8BumEL9hTiTuBxxjIjVkoYU+t8tSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgsLgVBD/78Th8RnMfCRBumClWnObEa4KSz9lap/8QlAaVcw1
	QCEamN/kV3Efu1D0wQZys8w6Q+1s4H/u43Fa1Pq2ycL0PVdcTVseHAn7zjAVynyGV67kRZ/57GK
	dU+tHtP3PE7aTAGqoEu1ZkxRjJaI=
X-Google-Smtp-Source: AGHT+IER75SAOZUHH5jMgPekx7s/nl0d2NiLpDAXLFD49Hq7D2LZdweUm8zIcuOpHYIh3SSebTpmW0OFlPr+jp9C5lo=
X-Received: by 2002:a05:6870:1cf:b0:27d:10f5:347 with SMTP id
 586e51a60fabf-29dc40098fdmr1834428fac.15.1732704833749; Wed, 27 Nov 2024
 02:53:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
 <20241126201539.477448-2-patryk.wlazlyn@linux.intel.com> <Z0a0JNRPuRYaVrcI@BLRRASHENOY1.amd.com>
 <9a918226-4f93-4ee5-8673-20d82802f126@linux.intel.com>
In-Reply-To: <9a918226-4f93-4ee5-8673-20d82802f126@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Nov 2024 11:53:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0io8+zHwE82Z2z-GiTKwT63aHhbzDUhmZYHF3VwzbNaFw@mail.gmail.com>
Message-ID: <CAJZ5v0io8+zHwE82Z2z-GiTKwT63aHhbzDUhmZYHF3VwzbNaFw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, peterz@infradead.org, 
	dave.hansen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 9:33=E2=80=AFAM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> > Hello Patryk,
> >
> > Apologies for what may appear as bikeshedding, after this patch, the
> > cpuidle code still won't call any mwait based play dead loop since the
> > support for enter_dead for FFh based idle states in acpi_idle and
> > intel_idle only gets added in Patches 2 and 3.
> >
> > Does it make sense to split this Patch 1 into 2 patches : 1/4 and 4/4
> >
> > 1/4 just introduces the mwait_play_dead_with_hint() helper which will
> > be used by patches 2 and 3.
> >
> > 4/4 get rids of the of logic to find the deepest state from
> > mwait_play_dead() and modifies native_play_dead() to call
> > cpuidle_play_dead() followed by hlt_play_dead() thus removing any
> > reference to mwait_play_dead(). Optionally you can even rename
> > mwait_play_dead_with_hints() to mwait_play_dead().
> >
> > That way the changelog that you have for this patch can be used in 4/4
> > since with the addition of play_dead support for FFh states in both
> > acpi_idle and intel_idle via patches 2 and 3, the logic to find the
> > deepest ffh state in mwait_play_dead() is no longer required.
> >
> > Thoughts ?
>
> Yeah, makes sense. I just wanted to simplify, but at some point crossed m=
y mind
> that submitting it like you suggested may be better.

Not just it may be better, but this is the only way to do it or people
who apply the first patch without the other two patches will likely
have problems (and that may easily happen during bisection, for
example).

Things should always work between consecutive patches in a patch series.

> I am going to split that if I don't see any objections.

Yes, please!

