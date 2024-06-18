Return-Path: <linux-pm+bounces-9512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676890DE5D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E644D1C22587
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B5179650;
	Tue, 18 Jun 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C4En8v93"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C317921D;
	Tue, 18 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745856; cv=none; b=UUtGSaaen3GD7uAORO3hKqn2o5rejhSzSrtDJOmRton03vqzp5lhJCm0dkYcl7sAAgCX4lkmBIOryPq1wc2frjanHgv5+BH6Tb0ZC7PD9jzVustjTuySjGQ6kaJYE1EvpQDNdsd1lDwZtheMy8QHK5UOSW8B3SUkz98Ynt/jqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745856; c=relaxed/simple;
	bh=zRp8GT7dApOGS7Mj7srFB70Ouo4Bx2E/TwJp+XjUYho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fitxXKsbscIA8MW0mKrfcehx1RAxNQC73WVxDGd7j+ZOQAaL2nsPvYhZgr+ekXnEgby5LMfDOCvZBldEjjYUNBtJRMr2jb8D64KV9/XdtfZ3BBNnaquOvh4uOlK/XfqUG/vzrucWwf7pBrywIs5K7X47R3wSiKhcMRetBxtFfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C4En8v93; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A1B9640E019D;
	Tue, 18 Jun 2024 21:24:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PNCbB4GznpeK; Tue, 18 Jun 2024 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718745848; bh=sf6K36Lt1gtQVJchX/ShO2rWdTozL4aN3Eb5buVtYp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4En8v93JUYh+W8ijY5Dp4USs7PjsHpMMa1+s/pgHzVpJwNMRp3Key9QUF6E4TSav
	 lTWfyNIp3NjaE7W+kd0oQJbGKkZJ+zf9gqekm8jjw/FEtArLi03ZnYIKon2x9RPZID
	 E/sb2arJT0Y3ooGp64P9ddX2kVpMgKXT8E4oXpHliYKnQ7zWCxka5bz1IG2NFsJ+kG
	 gWP3/Vx7UoJOzjYRWJwvX9nv2ognyfpLp+P1cJ+j2hH3WgcexMCciOShRQXm0+dqYp
	 SIYIejc8pVsawdt6Uvbsa19jCSw+1nsBJeQLmp2zuxWv61HUpptdS8aNfjVHLN1QaN
	 JGCpVUTSVFQA6/EO08sd2mgqao/IQgZj4OuVFXieOoEne72r/iZaF3tped6Sv1AsNH
	 TIr90bzaRLq2KDuI4P9sl4y6AmqhhQ9Q7FJyDvmy1QQo463oXgGxa0jpt32U+rwfI/
	 5qjDGL88S7/CrBFRola8Hi7/7l2fHKgsElvsObD9F3DnVpoWPbACIym/tB2AqjYaBs
	 vITiGULW21QYL77ornQBDXL/Yge04YAUnMLQHhqr2dLDonnXK+TJzAA+gljo4bvCv4
	 80v1Bi6MC33HIJrGnHRHRirpNP+R4ZhJ66DTI/hLlTFFfF1KAFEPxZARbxIN8kIvKn
	 naUtCWjAVxT1myfwW4B5Ojbc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08E8D40E01A5;
	Tue, 18 Jun 2024 21:23:55 +0000 (UTC)
Date: Tue, 18 Jun 2024 23:23:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
Message-ID: <20240618212348.GFZnH65EdA9cCGoeoM@fat_crate.local>
References: <cover.1718606975.git.perry.yuan@amd.com>
 <7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com>

On Mon, Jun 17, 2024 at 02:59:11PM +0800, Perry Yuan wrote:
> Introduces an optimization to the AMD-Pstate driver by implementing
> a heterogeneous core topology for the initialization of the highest
> performance value while driver loading.
> The two core types supported are "performance" and "efficiency".
> Each core type has different highest performance and frequency values
> configured by the platform.  The `amd_pstate` driver needs to identify
> the type of core to correctly set an appropriate highest perf value.
> 
> X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
> processor support heterogeneous core type by reading CPUID leaf
> Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
> driver will check EBX 30:28 bits to get the core type.

There will be a special ->cpu_type member for that eventually:

https://lore.kernel.org/r/20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

