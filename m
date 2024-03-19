Return-Path: <linux-pm+bounces-5122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA589880089
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 16:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187FC1C21F96
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D815F657B8;
	Tue, 19 Mar 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KcekTvEt"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BF651B4;
	Tue, 19 Mar 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862059; cv=none; b=h1eXTuGUz9tetBy2bolEnbFAyaD0kH/kWEOPNsvCKPucJHzEJ6BxKA7Ta9AtEv9Vgv5CrbJHNwkz03h71fDT+6k/VGMlgIOhpY7jO9xkw/P2iWJLdpmJOtn0YREezpEsGGs+kcneBPnoYplvEZZVUwxxPbd3JIN3Ui8FwLB8UoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862059; c=relaxed/simple;
	bh=n5W6hY689G6fb/okE511uWTa1J8EvWhtvc736cSxTMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsvTB3cvR9P4LNm1eHc0vWQGGLWUNm5U//oHDpSz3Maa5YQUKjj6AOHiBRL0tt9fUOdJa/aRd+mnzhG9fUfudY+b3I3jBQMJIGRaFbCwCRSEORqZWwgLkRskrZ0/vyz7Q0Yfaa8NBHKC7Phn2nGiHV9a+1VJmbvMIvyW4qZ975w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KcekTvEt; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Mar 2024 08:27:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710862055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qa04ZO95bEt6l7q9Fxc06bsvgy78kYNrNvf8c5ShOPs=;
	b=KcekTvEt/t5Xe2qQEK6B2kzY2AtN522FVRzSdysknuqahexV4/+FizlLCfyW2sqsyMQssS
	C7SxBUH1qDZ+BNsY2+Ac+AiN4DenSxwve3/MD0IOmMXvIT436tVvGNeCeBwsQoy64Pu4Dw
	aBSi1dV7iJFz/+LOtQ1fqYbUqF3ryQU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Mostafa Saleh <smostafa@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] Add PSCI v1.3 SYSTEM_OFF2 support for
 hibernation
Message-ID: <Zfmu3wnFbIGQZD-j@linux.dev>
References: <20240319130957.1050637-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319130957.1050637-1-dwmw2@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 19, 2024 at 12:59:01PM +0000, David Woodhouse wrote:
> David Woodhouse (5):
>       firmware/psci: Add definitions for PSCI v1.3 specification (ALPHA)
>       KVM: arm64: Add support for PSCI v1.2 and v1.3
>       KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function for hibernation
>       KVM: arm64: nvhe: Pass through PSCI v1.3 SYSTEM_OFF2 call
>       arm64: Use SYSTEM_OFF2 PSCI call to power off for hibernate

If we're going down the route of having this PSCI call live in KVM, it
really deserves a test. I think you can just pile on the existing
psci_test selftest.

-- 
Thanks,
Oliver

