Return-Path: <linux-pm+bounces-17423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4F9C5B7D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A9E2821B9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC081FF7A8;
	Tue, 12 Nov 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AbWQ2GNH"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C11FEFA8;
	Tue, 12 Nov 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424093; cv=none; b=G426d2u7A3NSPKrkmWMY6oaDby94g+He5JAEjRiM086THC6HQL0ZPbtpQ+zXHmv4X6SvL8OUU6s8EWNkh/xgTW0jVHrX2Wmg82F9Rpux2p/6scdeYHJCg+A6m2SOMJ/21hKALvTjbg3563ZdxQfYzj/i6s3BCZwaPZG5IxiAhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424093; c=relaxed/simple;
	bh=kXQhvmQsueX/ilC41eH9VswpHmLD/C0pasLQPg4II78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udx2yVXMEXResNTCgz5DcDNUpXH2rFIinLGjeIFQfaoZBhXMtfbdW8l4zXl7zKu05isg7DGLwp+YhYIQPkBkRO/qGrXWDMY1oonKJ5VS3zI+Z3ybCmegEP9dM8yzSQBvGuQSEHQG9onyhCzZHQFp3j9mLULmEPyUw2Z8rzdOxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AbWQ2GNH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PC9b/kuGQ7yUVGXsABcIAej2mijinN977pUvbbhOfWc=; b=AbWQ2GNHgA7BAP2nWOjp8vhDYw
	zWNZYLGgvlqhhIbPXSsOLIqKtaSoN+MUeq8u+sZWA490nzHLQ2O02nmh8FdZcIHBanaYbXblsXbMW
	rPsomqJ0+yXh6nV1b0+sy79qKekZ+gQ+bSQvi66SlfV+l5EDtAzS4FCM9WjYlcVqwJtPzJQkVs3of
	Ue2eGe0zJ98Ed8Rl23rZB/7YJ2FkFdzPEuqzOBcuMVAwvMj0UaMQdeJmHFssElN1nUw16I11ZtxT3
	EagJHm85ldIooygKgJUnlbr6RROX3lpCq1rvo5VWaPpcTm4m0XRQBeHLp/zoWDN4V1e5vOiRBw0+G
	7hE4gevw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAsUz-0000000EY42-3amn;
	Tue, 12 Nov 2024 15:08:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 574BB300478; Tue, 12 Nov 2024 16:08:09 +0100 (CET)
Date: Tue, 12 Nov 2024 16:08:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: artem.bityutskiy@linux.intel.com,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241112150809.GK6497@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
 <CAJZ5v0iSP4Gh2FwKdkOw20N4hzwQ94+WmnT+3EY94QG3gORWzA@mail.gmail.com>
 <20241112134959.GG6497@noisy.programming.kicks-ass.net>
 <CAJZ5v0iYYYpg7MDf8_UmoUuzyiPMoPdjgSJmdBXGYCxVc4icWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iYYYpg7MDf8_UmoUuzyiPMoPdjgSJmdBXGYCxVc4icWw@mail.gmail.com>

On Tue, Nov 12, 2024 at 03:56:22PM +0100, Rafael J. Wysocki wrote:

> > So given we don't have any such code, why can't we simply fix the cstate
> > parsing we have in mwait_play_dead() and call it a day?
> 
> I'll leave this one to Artem, but there is at least one reason to
> avoid doing that I know about: There is no guarantee that whatever has
> been found was actually validated.

It's a bit daft to explicitly advertise a state in CPUID that's not
validated. I realize that MSFT will likely only ever use the ACPI table,
but at the same time, the CPUID bits and ACPI tables both come from the
same BIOS image, no?

.... and we've never seen the BIOS be self contradictory before ... /me
runs

