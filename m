Return-Path: <linux-pm+bounces-10087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99D919DAF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 05:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B31F21B4A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB51804E;
	Thu, 27 Jun 2024 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jrn2lapp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4058C8F6;
	Thu, 27 Jun 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457373; cv=none; b=VRaWV8NH7RHnZTu3CVux1R/cQVy08N9fX3NqfDWLkdT8R8UeS9Biwz1roEiJDqT9qlUyZWXE/Eab9ydMklArMy/IW/DORLpbsJsMKnD9aiQ/xLswbYdN9h7F4qzlatg00y2fsxFVHoUhpAy33oZbQM//SONJ7Tbt4RPBHPAlLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457373; c=relaxed/simple;
	bh=EhjeL739fXGfFhIzTvZXdH4uFeIjF4K3Lk5/9pGIf1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd4oMbfp6m9kBeqpDcbxQtUAldPpgkKZ1GosCoVGfuvtIF/+YEsFmMeE8q+orUinkEF4+GloI8R6Ouk5i1vkdK6TYGRXo6djtFEQKSF859pqqFeSiVXd5KYNh/LxPFuV+cuMMaWjRyNsrjM9pqZD7c7Ar4lmYC9+HibWzok2qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jrn2lapp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 721B240E01D6;
	Thu, 27 Jun 2024 03:02:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CSK0S82tyIFv; Thu, 27 Jun 2024 03:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719457364; bh=MmExb+MUVFN1kqaecveoMawY6XC3Ia4gBAbZorGaHw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrn2lappB4DcGvaoHfXgxjpa2XgDckhGv7L2/YCK1ajydDKHwAJWfL6NwXFvonWBA
	 eha9CThBndf5js0lVkJCXUVuI4elW0tfs3zV8f2v6L/MkRVPNbsPBoSRbnsG81q9Xl
	 6TnUl707jxMg3uwA88u3e8B50VjwVMP6ad/vGkCi6zmwe7mCTcUGuKdbPl4oTkPo/e
	 DQYHuhiN79jkryCGp0s3dpH5FK1QUd+g82UoXAWqxNxrgPlS6pFWybLfJvDai/Nb0o
	 UIM0skORDzBucuiMRRXpksRlj6P1HKisCR4ORJvV9tkfwCFMJYfv8A7V5P2fNLMHmZ
	 oujworeL3MxDbeqjewbZdJ0hM+eCbzWGgSqBWUE0S44ko34t6MCzYcrDCnk2Zbklgi
	 Kf5Zs70vpHFaz6VPgYUbHcDUoeRw4cUiwC36QHhabhyl51arvhEuS4k42+6ygAVj+f
	 3GryeHMNnvwGk8ni7QJizsy2YBXG2gQ7bqL38faQ70Jyuet3br0O847ABwT4tyNcak
	 +xKYDDq/98mPUyV9Jq2aNhTUtA7zAQb2Z30XK7QQMsa2KC8Rmx4wfHaO4hzElAHCwa
	 k1Gm6Dsl+nLuVcsa4a8TlWjJPuDNy8lLHeL4fSuINjAGNjT3RRBXJgnAEmnX21bAV9
	 aXx65nf1hvkS1h/NKuvAx3zs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5499E40E0187;
	Thu, 27 Jun 2024 03:02:29 +0000 (UTC)
Date: Thu, 27 Jun 2024 05:02:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to
 lookup perf values
Message-ID: <20240627030227.GBZnzWQ5H4MZt3wWNz@fat_crate.local>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-3-mario.limonciello@amd.com>
 <20240626171809.GSZnxNUd4tcRT4IB_k@fat_crate.local>
 <f5251cea-32f2-426d-b3c8-73ce4c562fac@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5251cea-32f2-426d-b3c8-73ce4c562fac@amd.com>

On Wed, Jun 26, 2024 at 01:19:56PM -0500, Mario Limonciello wrote:
> I was thinking we would take this patch through superm1/linux-next or
> linux-pm/linux-next as there is other amd-pstate stuff for the next merge
> window, but if you'd rather go through x86 then we can wait until after the
> merge window on this series.

I can also ACK this once it is ready and you can take it through whichever
tree you prefer.  

I don't think we'll have merge conflicts there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

