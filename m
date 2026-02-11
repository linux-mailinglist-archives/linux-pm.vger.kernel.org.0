Return-Path: <linux-pm+bounces-42522-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TemCJu/gjGmcugAAu9opvQ
	(envelope-from <linux-pm+bounces-42522-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:05:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6301274FF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCAA93014743
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF521346E4A;
	Wed, 11 Feb 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIXP+bDe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AB219EB
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840298; cv=none; b=KU2qjxpQS/tp/nXeJd7PKm0/PBbByRZZHn+dtAUIgqABPGL/6bwJ2CsgjrEuoIkYeuzO6VleMSEnd/BxgHznijtJDEWKYMKvLxOjbOun41RrKxFA0iOZld3aotxAmDTTFxSXBzJQjNvyVUAO8bGfEVCbXSRHtish+rA6s0Q78gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840298; c=relaxed/simple;
	bh=nFzRbaTR9l5r5zcmUkf9lUWzaaEX/YSC2hXBUTyNPpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4tv/4GgUBela2XszZhq4EfvHso4Vfb8VSg/9p3QJUfVlvqXutuzgN41jQhcVhKjkIVT27E4seFaeIEmcIENEGvssXGoPPAXPvBXe88Lxtr6uCww/iuR62BHK5jImchwZoykL5L2XwLpGIEtSoAn1AdaLVt5H+pNSzzagpE7lyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIXP+bDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7196EC19425
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770840298;
	bh=nFzRbaTR9l5r5zcmUkf9lUWzaaEX/YSC2hXBUTyNPpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sIXP+bDey2FiA1EIonX3s0z2+5u/XXqmjX1+pn8RBYo4fWHNE9GryfMW36jGf9ZXb
	 5GoXTNUGDcY/+KPWOAxaKXmb5zpP4Wo4qnJeCkCHE9hlpV3FmMHYUGXvJXWJcBw8S+
	 m1xkMCDr7/oZuhJycOmHY8QzffEnn5ExT/fpIGuzQJkPkcGoj7vHXQGZ/oTiipAOC+
	 tmtaOMX+poOthID5KRQvWnyjsfdKCYvWizUQV+RyNGvqRT3pj6SetIY+53yK4CrhXI
	 upJcmBRBGBJQLA7LopU3PBEHDOqrxkTBd65jn7nh+XfFQN17TaAjXiRyPtdHLQHaue
	 JpoKPkViEMlAA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45c715116dbso1466897b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 12:04:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIFd1tnvdGRIEn1uxUPWrW8UqVwvtRnTx/r1XnS8jftxxP4VNFp81su/zqHQJP/+oFX9+v2pyTcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Ae+r0Ld+2AQrpGcxqDhs7FHGkiGrKI6INIyKnthtX0/N/JoU
	iCXM144CNTZZ/YIaQOeMDWRik2q/8dBqsJ0U+2ppVBId9rKxM9Et6G2z+1t/mT+v207ChE1VLQY
	67yLW+AAuGl3BTnB7quZMjvJarKCB0ME=
X-Received: by 2002:a05:6808:6410:b0:45e:b6a4:fec1 with SMTP id
 5614622812f47-4637b89972bmr291694b6e.37.1770840297573; Wed, 11 Feb 2026
 12:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <62c8c3910e1becf49e96eddf892d7c37960c7c28.camel@linux.intel.com>
In-Reply-To: <62c8c3910e1becf49e96eddf892d7c37960c7c28.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Feb 2026 21:04:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gh_3y4+2qepC5Mqos+y+kBfGgeEKdmL5s6J4MBGcrQzw@mail.gmail.com>
X-Gm-Features: AZwV_QgBYLsL6cSCcgswuU9Eh8NFYbvyc6nVUdI5UFtrkvgKdaFM-ZuORQe4aP8
Message-ID: <CAJZ5v0gh_3y4+2qepC5Mqos+y+kBfGgeEKdmL5s6J4MBGcrQzw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix RAPL PMU access from non-lead CPUs
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42522-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B6301274FF
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 6:53=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2026-02-09 at 15:43 -0800, Kuppuswamy Sathyanarayanan wrote:
> > This series fixes issues with RAPL PMU event access when using CPUs
> > other than the package lead_cpu.
> >
> > The problem was discovered when turbostat reported zero power values
> > when run on a non-lead CPU in the package.
> >
> > Investigation revealed two issues:
> >
> > 1. The RAPL MSR driver incorrectly validated that the current CPU
> > must
> >    match the lead CPU of the package when reading from PMU context,
> > even
> >    though package-scoped MSRs are readable from any CPU in the
> > package.
> >
> > 2. The RAPL PMU cpumask only exposed one CPU per package (the
> > lead_cpu)
> >    for both MSR and TPMI interfaces, forcing tools to use that
> > specific
> >    CPU even though package-scoped registers are readable from any CPU
> >    in the package.
> >
> > The perf tool avoided issue #1 by checking the cpumask before opening
> > events, but turbostat does not perform this validation. The
> > restrictive
> > cpumask in issue #2 was unnecessary since both MSR and TPMI
> > interfaces
> > support reads from any CPU in the package for package-scoped
> > registers.
> >
> > These patches:
> > - Remove the incorrect CPU validation check in PMU context
> > - Expand the PMU cpumask to include all CPUs in each package for both
> >   MSR and TPMI RAPL interfaces
> > - Rename 'atomic' parameter to 'pmu_ctx' for clarity
> >
> > After these changes, tools can successfully read RAPL events from any
> > CPU in the package, matching the architectural capability of the
> > hardware for both MSR and TPMI based RAPL implementations.
> >
> > Testing (PTL & GNR platform):
> > - Verified turbostat --no-msr --show power works on all CPUs
> > - Verified perf stat -e power/energy-pkg/ works on all CPUs
> > - Confirmed /sys/bus/event_source/devices/power/cpumask shows all
> >   package CPUs instead of just lead_cpu
> > - Tested on both MSR-based (PTL) and TPMI-based (GNR) RAPL system
> >
> > Kuppuswamy Sathyanarayanan (2):
> >   powercap: intel_rapl: Remove incorrect CPU check in PMU context
> >   powercap: intel_rapl: Expose all package CPUs in PMU cpumask
> >
>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Both patches applied as 7.0-rc material, thanks!

