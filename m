Return-Path: <linux-pm+bounces-5061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F887EECF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 18:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791CB1C220FA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5155766;
	Mon, 18 Mar 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1gZduWK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0655E44;
	Mon, 18 Mar 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782987; cv=none; b=N/m1B0GQPgXd7k9w7e/Ae3GW0ypTGOb0hrcZZPMkH8OeUY/M6vwLv4xS4vuUMbaiuZjAfqQ9332g6+CbVoPaoYMxbHRUkKQZ68vkMvEVRSpDZiUNJCcuZdyjZSgKp2fv486elLs5xlI5PaEbCnVn8VADjAu0GKjI4Uwwvb4UJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782987; c=relaxed/simple;
	bh=jal3puy6u47/+391s6XpWyiWuhu3q01nkmau37uIYME=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzdhR3S+Q/PG1im1aulwCSu7TLj9gEH597lg5dQA5LShKaA9ycimpuDvNpHeGKYAJduoljxL4wqNRHeotIe5jU1ESnIcdumpdOmswI2BsOPSK0Ex/iSkCL3YhRpV+auvorqMsezLouqvu5X37hmJ9rnbaFWh74NNh7p5XPTw0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1gZduWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD220C433C7;
	Mon, 18 Mar 2024 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710782985;
	bh=jal3puy6u47/+391s6XpWyiWuhu3q01nkmau37uIYME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p1gZduWKJ+OsB7PpUBOfl31508AK96L5FBrCL0H/XXWtGumxroNXK4fUdOw8kC0q1
	 uju6AV9Agrt6SO4hDDdE2eQhlPMpPEKV6WE6bPz7EJiwJGX6yOpHj0cRswTrJBH4K+
	 b/yvojgx6wA1rUUbAjMb7YxGPs0Y2XcmUJhY7sp6JfxGDXDGPjdfCoINlOPvIKOXG6
	 iAWaAg+VAqMonfhucZTfckXPo6z7JlMKc80Tx0ipNh4w9OQSy06rkFHSxh6qixCr06
	 1mHToYqVMkuQBjNYsXLUjmgBrw3PJtNjgxapyMFMTu2vdjMVtpeClk3d5Oq2X68HiT
	 +ZJH2U+5Vnncw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rmGnv-00DKyB-EO;
	Mon, 18 Mar 2024 17:29:43 +0000
Date: Mon, 18 Mar 2024 17:29:43 +0000
Message-ID: <86v85jzbw8.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Mostafa Saleh <smostafa@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: arm64: Add PSCI SYSTEM_OFF2 function for hibernation
In-Reply-To: <20240318164646.1010092-3-dwmw2@infradead.org>
References: <20240318164646.1010092-1-dwmw2@infradead.org>
	<20240318164646.1010092-3-dwmw2@infradead.org>
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
X-SA-Exim-Rcpt-To: dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, lpieralisi@kernel.org, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, dwmw@amazon.co.uk, smostafa@google.com, jean-philippe@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-pm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 18 Mar 2024 16:14:24 +0000,
David Woodhouse <dwmw2@infradead.org> wrote:
> 
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The PSCI v1.3 specification (alpha) adds support for a SYSTEM_OFF2 function
> which is analogous to ACPI S4 state. This will allow hosting environments
> to determine that a guest is hibernated rather than just powered off, and
> ensure that they preserve the virtual environment appropriately to allow
> the guest to resume safely (or bump the hardware_signature in the FACS to
> trigger a clean reboot instead).
> 
> The beta version will be changed to say that PSCI_FEATURES returns a bit
> mask of the supported hibernate types, which is implemented here.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  Documentation/virt/kvm/api.rst    | 11 +++++++++
>  arch/arm64/include/asm/kvm_host.h |  2 ++
>  arch/arm64/include/uapi/asm/kvm.h |  6 +++++
>  arch/arm64/kvm/arm.c              |  5 +++++
>  arch/arm64/kvm/psci.c             | 37 +++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h          |  1 +
>  6 files changed, 62 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 0b5a33ee71ee..ff061b6a2393 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6761,6 +6761,10 @@ the first `ndata` items (possibly zero) of the data array are valid.
>     the guest issued a SYSTEM_RESET2 call according to v1.1 of the PSCI
>     specification.
>  
> + - for arm64, data[0] is set to KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2
> +   if the guest issued a SYSTEM_OFF2 call according to v1.3 of the PSCI
> +   specification.
> +
>   - for RISC-V, data[0] is set to the value of the second argument of the
>     ``sbi_system_reset`` call.
>  
> @@ -6794,6 +6798,13 @@ either:
>   - Deny the guest request to suspend the VM. See ARM DEN0022D.b 5.19.2
>     "Caller responsibilities" for possible return values.
>  
> +Hibernation using the PSCI SYSTEM_OFF2 call is enabled with the
> +KVM_CAP_ARM_SYSTEM_OFF2 VM capability. If a guest invokes the PSCI
> +SYSTEM_OFF2 function, KVM will exit to userspace with the
> +KVM_SYSTEM_EVENT_SHUTDOWN event type and with data[0] set to
> +KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2. The only supported hibernate
> +type for the SYSTEM_OFF2 function is HIBERNATE_OFF (0x0).

Again, I really oppose this way of doing things. We already have an
infrastructure for selecting PSCI levels. You may not like it, but it
exists, and I'm not going entertain supporting yet another bike-shed
model. Adding an orthogonal cap for a feature that is specific to a
new PSCI version is just awful.

Please make PSCI 1.3 the only version of PSCI supporting suspend in a
non-optional way, and be done with it.

	M.

-- 
Without deviation from the norm, progress is not possible.

