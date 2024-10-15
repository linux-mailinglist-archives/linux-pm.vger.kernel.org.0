Return-Path: <linux-pm+bounces-15676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE099F3D3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 19:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289961F236AF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E81F9EDF;
	Tue, 15 Oct 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9ysL/1I"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC61F9EBA
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012592; cv=none; b=Qz9lSTJm/XssIMZ/6GaTSUrb5adbu9PW5iiOLUBEWd1kWV1btJDDCcbQJkNuh9N+PSNNyfj/yMbZZjWHaoNF5ujdazPA9RMXaSKgkfb+WatXMoTb37psrs+X5oack/05EjadVoS8qB+1+/J/5bvFG5cQsvlPexY7trJnLxq1+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012592; c=relaxed/simple;
	bh=aqe7ZBAXHSE2gzwDaIJiDGMt8akPLQVMlvbhK5NT45Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUGMhVPavMjaGhMBJ7Cmdx3DfvmyAbJO0gBjZboBAghOXzGaQzWABuG5T/ygAhb+oB/AlKVh9ptjRw4PDzzY2DPXCbmKDLrGw+zw28a8ahV8q3OtVPxfyWl3VR1AmuCpDvDI+a3XLXs21+SCqs5vTDdng4iBm1a6Xy/yMDPcBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k9ysL/1I; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 10:16:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729012583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yw0BRkFp5Fq3zNmseLDS7BgS3nwlhhSku9PTDEcx65A=;
	b=k9ysL/1Ifn3FGFggblukp1Eo7eWxiC94YkkDmiW+eIx7Z2qkCTpZr/39b66tE5EmHP5Ud8
	yFPqwzKytZHX1ljq9MJbqNSmsUPocgUQ/PzredAkviNPxEBWqICQTKvMEcgPLoqVBC0nfM
	OOvIGjkIz7nkQq+w6IjgWj+mICM0Oe8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH v5 4/5] KVM: selftests: Add test for PSCI SYSTEM_OFF2
Message-ID: <Zw6jXEWwdW3S5Y6c@linux.dev>
References: <20240926184546.833516-1-dwmw2@infradead.org>
 <20240926184546.833516-5-dwmw2@infradead.org>
 <ZvwWM7rQd075o6nb@linux.dev>
 <408b137dbf60ff4d189cbd98b7cf8cd833579f61.camel@infradead.org>
 <Zw6Svts5hqpIoKwN@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw6Svts5hqpIoKwN@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 15, 2024 at 09:05:18AM -0700, Oliver Upton wrote:
> On Sat, Oct 12, 2024 at 10:28:10AM +0100, David Woodhouse wrote:
> > On Tue, 2024-10-01 at 08:33 -0700, Oliver Upton wrote:
> > > On Thu, Sep 26, 2024 at 07:37:59PM +0100, David Woodhouse wrote:
> > > > +       vm = setup_vm(guest_test_system_off2, &source, &target);
> > > > +       vcpu_get_reg(target, KVM_REG_ARM_PSCI_VERSION, &psci_version);
> > > > +       TEST_ASSERT(psci_version >= PSCI_VERSION(0, 2),
> > > > +                   "Unexpected PSCI version %lu.%lu",
> > > > +                   PSCI_VERSION_MAJOR(psci_version),
> > > > +                   PSCI_VERSION_MINOR(psci_version));
> > > > +
> > > > +       if (psci_version < PSCI_VERSION(1,3))
> > > > +               goto skip;
> > > 
> > > I'm not following this. Is there a particular reason why we'd want to
> > > skip for v1.2 and fail the test for anything less than that?
> > 
> > These tests unconditionally set KVM_ARM_VCPU_PSCI_0_2 in setup_vm().
> > Which is probably OK assuming support for that that predates
> > KVM_CAP_ARM_SYSTEM_SUSPEND (which is already a TEST_REQUIRE() right at
> > the start).
> > 
> > So the world is very broken if KVM actually starts a VM but the version
> > isn't at least 0.2, and it seemed like it warranted an actual failure.
> 
> If we're looking at this from a testing lens then KVM coming up with any
> PSCI version other than KVM_ARM_PSCI_LATEST (i.e. v1.3) is a bug. So
> maybe we can tighten that assertion because...
> 
> > > Just do TEST_REQUIRE(psci_version >= PSCI_VERSION(1, 3)), it makes the
> > > requirements obvious in the case someone runs new selftests on an old
> > > kernel.
> > 
> > I don't think we want to put that in main() and skip the other checks
> > that would run on earlier kernels.
> 
> Running KVM selftests on older kernels in a meaningful way isn't
> something we support. At all. An example of this is commit
> 8a53e1302133 ("KVM: selftests: Require KVM_CAP_USER_MEMORY2 for
> tests that create memslots"), which skips ~everything for kernels older
> than 6.8.
> 
> > (Even if we had easy access to
> > psci_version without actually running a test and starting a VM).
> > 
> > I could put it into host_test_system_off2() which runs last (and
> > comment the invocations in main() to say that they're in increasing
> > order of PSCI version) to accommodate such). But then it seems that I'd
> > be the target of this comment in ksft_exit_skip()...
> > 
> >         /*
> >          * FIXME: several tests misuse ksft_exit_skip so produce
> >          * something sensible if some tests have already been run
> >          * or a plan has been printed.  Those tests should use
> >          * ksft_test_result_skip or ksft_exit_fail_msg instead.
> >          */
> > 
> > I suspect the real answer here is that the individual tests here be
> > calling ksft_test_result_pass(), and the system_off2 one should call
> > ksft_test_result_skip() if it skips?
> 
> modulo a few one-offs, KVM selftests doesn't use the kselftest harness
> so it isn't subject to this comment. Since there's no test plan, we can
> skip at any time.
> 
> > I'll add an explicit comment about the 0.2 check though, saying that it
> > should never happen so we might as well have the ASSERT for it.
> 
> After looking at this again, I think we should do one of the following:
> 
>  - TEST_REQUIRE() that the PSCI version is at least v1.3, making the
>    dependency clear on older kernels.
> 
>  - TEST_REQUIRE() for v1.3, which would provide better test coverage on
>    upstream.

Sorry, I meant TEST_ASSERT() here.

> -- 
> Thanks,
> Oliver
> 

