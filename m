Return-Path: <linux-pm+bounces-5243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259088706E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 17:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649E71C22B0C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D35820D;
	Fri, 22 Mar 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjH3h6++"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358850249;
	Fri, 22 Mar 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123788; cv=none; b=Ngu6CS34U3zq25AcxL0akZF7B7OVzxwsVhakly+3HPnM33qqNUDfzn0VCZXeMEa+LK9HzKL2fOnWLDDGub0eOTop1wzk8XLcL9K6tKpveWamli1YPdAwvUPv8nHF4QMAwKE2lIi/Pd+iwV61Yrksk2vg8w+93xTpyEhisH6G5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123788; c=relaxed/simple;
	bh=eBEi9JwTppdgmecpZZ200V7KVmEAjugaGpeipBL5o4M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkAWDgNMRnj8blAfCMW+TySOeAVDO3oR4/nd9PJVmPjD0dLnoX4HIm1x58x1wmBXK/jopK2H7Oz44SXHSfAyTtcA05T6xPwVm4F7yEOSW1tGGI5GIy3aOUBvmidBunkan3H0ogaJFudhOkaBlTqnmwbL0nS8yKEA2pZeJ7u0hK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjH3h6++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5D0C433F1;
	Fri, 22 Mar 2024 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123787;
	bh=eBEi9JwTppdgmecpZZ200V7KVmEAjugaGpeipBL5o4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hjH3h6++gxfz+IoEiWx2bRzn/B4Py3NoN02u5y62+gS6S6caU7uDYNQ+3KzK6UE1I
	 gkhrqqFzInMW3GGrDPw5rSL8zGO7qMMubTkdUCQdSbbelf+YSbE/SJLAIK4jlP1CVc
	 NfQ1vyDvQP4QIHNesbbkHs/or2RP/J9Oz2r37POqz/mdne4YV/ktpcGstw3+WeCLHG
	 2p1r9x/5Whoc1UahA/NzvHAOTyfdJtUrFo/8JXSxIDEzazJMpPeVw/x/rlnayB08aP
	 Yho+3ngwUPbk+RoguWaxrJ/T/s8BQACOEbemk6tgGUt2L1M7SHpJarpyrdDu9j4pWo
	 zbZpxVwXQ397A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rnhSi-00EYOu-Mx;
	Fri, 22 Mar 2024 16:09:44 +0000
Date: Fri, 22 Mar 2024 16:09:43 +0000
Message-ID: <86frwiz1rs.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	Paolo Bonzini
 <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose
 <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin
 Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark
 Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Mostafa Saleh <smostafa@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] Add PSCI v1.3 SYSTEM_OFF2 support for hibernation
In-Reply-To: <248ec30e7b5c8a42d184f029c1cc9b664656b356.camel@infradead.org>
References: <20240319130957.1050637-1-dwmw2@infradead.org>
	<Zfmu3wnFbIGQZD-j@linux.dev>
	<9e7a6e0f9c290a4b84c5bcc8cf3d4aba3cae2be5.camel@infradead.org>
	<Zfnpj2FShq05QZpf@linux.dev>
	<248ec30e7b5c8a42d184f029c1cc9b664656b356.camel@infradead.org>
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
X-SA-Exim-Rcpt-To: dwmw2@infradead.org, oliver.upton@linux.dev, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, lpieralisi@kernel.org, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, smostafa@google.com, jean-philippe@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-pm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 22 Mar 2024 10:17:58 +0000,
David Woodhouse <dwmw2@infradead.org> wrote:
> 
> [1  <text/plain; UTF-8 (quoted-printable)>]
> On Tue, 2024-03-19 at 12:41 -0700, Oliver Upton wrote:
> > On Tue, Mar 19, 2024 at 05:14:42PM +0000, David Woodhouse wrote:
> > > On Tue, 2024-03-19 at 08:27 -0700, Oliver Upton wrote:
> > > > If we're going down the route of having this PSCI call live in KVM, it
> > > > really deserves a test. I think you can just pile on the existing
> > > > psci_test selftest.
> > > 
> > > Added to
> > > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/psci-hibernate
> > > for next time.
> > > 
> > > From 8c72a78e6179bc8970edc66a85ab6bee26f581fb Mon Sep 17 00:00:00 2001
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > Date: Tue, 19 Mar 2024 17:07:46 +0000
> > > Subject: [PATCH 4/8] KVM: selftests: Add test for PSCI SYSTEM_OFF2
> > > 
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > Looks good, thanks!
> 
> Thanks.
> 
> Marc, I think I've also addressed your feedback? Is there anything else
> to do other than wait for the spec to be published?

Other than the couple of minor nits I mentioned in replies to the
individual patches, this looks good to me.

> Shall I post a v4 with PSCI v1.3 as default and the self-test? Would
> you apply that into a branch ready for merging when the spec is ready,
> or should I just wait and repost it all then?

I think this can wait for the final spec. I assume that you are
directly tracking this anyway, so we don't need to poll for the spec
update.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

