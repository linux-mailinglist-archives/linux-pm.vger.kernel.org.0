Return-Path: <linux-pm+bounces-5064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1087EF73
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 19:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0522F281164
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51F55E47;
	Mon, 18 Mar 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFIXnKwl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFC52F62;
	Mon, 18 Mar 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785234; cv=none; b=CSFzHLAuAzn5Jh+Nh4ANE4WqBO+0NPxv/j364sbgce5d8TNQogSowbPKXY3UyBhvryGQjdF8m6gYi8ex6iwQvnIiSADwCktuc0jtws4MmvdwrW+BWaIrOt5Hym1pEsQb3IB2MZpSROXHxOQWGSe/MLG2CBtWpMzydIqjABUPVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785234; c=relaxed/simple;
	bh=uFTDIwgPe+HRP1kBbmqy1DdKe8I3YJWXH7EL3qi+Uac=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euCS5gxtyX9lcJbCVVuiNBUXZozLOAOSdVkWpZgWliqbGZS9mhQ2hveTU57jDqAIJGxGMTwABeFR5sF9pCIEppz1hJJlN0vCqkpWJkT+Qe5Prm7Y1aVcP13waBmCxR9kk9LI3cXILoLtDoKV5pEV6ZUMFMhOWx7tbuQzYp+JWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFIXnKwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39864C433F1;
	Mon, 18 Mar 2024 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710785234;
	bh=uFTDIwgPe+HRP1kBbmqy1DdKe8I3YJWXH7EL3qi+Uac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aFIXnKwlETENqQtQwVlftkKQrg2YFGR9DtlST0lBXmTOzWhVputjq/zoBTDs1uymk
	 FE1wNfyXdG5m1FDxOvMMqqgi1RmUsPXMnc56rOaNYAdzd3CKVyAWUGCrMJCE/hDC3E
	 dW0mza7sbdPb6RD/6XNCd+9zrfjB3GKHw/hV1Xe/qbrC8Qx16eTcPBAQ8Q1T6rz7cB
	 b68G3sLcWvwCvrzrmqkmmOJaAIj4bEBYxslQ1YmQeHGLDPKQAjndEAsb/h18bVU+tF
	 MJgvVrBKToFBT5qAxVK979GIyphgqBjl8LNksPfPEPniG5d/opr1e7izJm5bhhreDA
	 Z+NntFzp88CCA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rmHOB-00DLe3-Nq;
	Mon, 18 Mar 2024 18:07:11 +0000
Date: Mon, 18 Mar 2024 18:07:11 +0000
Message-ID: <86r0g7za5s.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	Paolo Bonzini
 <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton
 <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K
 Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown
 <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Mostafa Saleh
 <smostafa@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: arm64: Add PSCI SYSTEM_OFF2 function for hibernation
In-Reply-To: <6a2107864d45bd6ac403c218d68bf97025eca971.camel@infradead.org>
References: <20240318164646.1010092-1-dwmw2@infradead.org>
	<20240318164646.1010092-3-dwmw2@infradead.org>
	<86v85jzbw8.wl-maz@kernel.org>
	<6a2107864d45bd6ac403c218d68bf97025eca971.camel@infradead.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, lpieralisi@kernel.org, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, smostafa@google.com, jean-philippe@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-pm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 18 Mar 2024 17:54:06 +0000,
David Woodhouse <dwmw2@infradead.org> wrote:
> 
> [1  <text/plain; UTF-8 (quoted-printable)>]
> On Mon, 2024-03-18 at 17:29 +0000, Marc Zyngier wrote:
> > 
> > Again, I really oppose this way of doing things. We already have an
> > infrastructure for selecting PSCI levels. You may not like it, but it
> > exists, and I'm not going entertain supporting yet another bike-shed
> > model. Adding an orthogonal cap for a feature that is specific to a
> > new PSCI version is just awful.
> 
> Huh? This isn't a "new bike-shed model". This is a straight copy of
> what we *already* have for SYSTEM_RESET2.

There is no KVM capability for SYSTEM_RESET2. It is directly
advertised to the guest when PSCI 1.1 is supported.

> If I were bike-shedding, I wouldn't do separate caps for them; I'd have
> done it as a *bitmask* of the optional PSCI calls that should be
> enabled.
>
> The *mandatory* ones should obviously come from the PSCI version alone,
> but I can't see how that makes sense for the optional ones...

The guest is in a position to probe for what is supported or not with
the PSCI_FEATURES call.  Why would you add anything else?

> 
> > Please make PSCI 1.3 the only version of PSCI supporting suspend in a
> > non-optional way, and be done with it.
> 
> SYSTEM_OFF2 is an *optional* feature in PSCI v1.3. As are
> CLEAR_INV_MEMREGION and CLEAR_INV_MEMREGION_ATTRIBUTES.
> 
> Are you suggesting that enabling v1.3 should automatically enable *all*
> of the optional features that were defined in that version (and
> previous versions) of the spec?

No. We have everything we need to incrementally *add* features. So you
can perfectly implement PSCI 1.3 with only SYSTEM_OFF2, and only later
on add the rest, if ever.

	M.

-- 
Without deviation from the norm, progress is not possible.

