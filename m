Return-Path: <linux-pm+bounces-16919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E59BAD88
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330FB1F2235C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB419CD01;
	Mon,  4 Nov 2024 07:59:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC8D199E8D;
	Mon,  4 Nov 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707171; cv=none; b=sHyiKNSOQ3fzLZdC29JCklQNraCXCqje8Dz4gaCaC+aTh+ztE5VIZ+6pjyB8rZZrrCpZdWF35EXv3bJ0g62u5KIvmMemw6y2k/4eh0HS8K7PF0rriHpMMDBeowNZpaJq6vlWN9jjjq/ZInaxL4ohZhE/lmYSPhCJlE7Wgn2r3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707171; c=relaxed/simple;
	bh=WIXvGA2A94TpVMNOjbk1pkQ/viHW9shMmwkmtcNq3z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTyGKO6FOhuMyd24n/TaMEVFCaqpu9BBzKROckfZrjoKeKvRV3+GNQhA5Ia6bvXKKzOrQxJPyON+PAZqF/GwKMNBLD8IdpIr5te8pHCDJxuNX5cAkQE/35IleA1iHSoHdplj4a94m1rMJNmlDls7EOeLQZ8JVDJlJX3WvVm5hiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90AEFEC;
	Sun,  3 Nov 2024 23:59:56 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441EA3F6A8;
	Sun,  3 Nov 2024 23:59:23 -0800 (PST)
Date: Mon, 4 Nov 2024 08:58:49 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, rafael@kernel.org,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, linux-tegra <linux-tegra@vger.kernel.org>,
	Bibek Basu <bbasu@nvidia.com>
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
Message-ID: <Zyh-uVSW-0d0r8oB@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
 <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
 <Zwe1p0La_AFknglf@arm.com>
 <20241029065319.zto3wlvceec3fjym@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029065319.zto3wlvceec3fjym@vireshk-i7>

On Tue, Oct 29, 2024 at 12:23:19PM +0530, Viresh Kumar wrote:
> On 10-10-24, 13:08, Beata Michalska wrote:
> > That is a fair point but I am not entirely convinced using '0' instead makes
> > things any more clearer as this is in no way a valid CPU frequency.
> > As long as we document the expected behaviour keeping the interface well
> > defined,  both options should be fine I guess.
> > 
> > @Viresh: what is your opinion on that one ?
> 
> Failing to get frequency for the CPU shouldn't be represented by 0,
> even if it is confusing for the user.
We still need to decide  whether provide a more descriptive way of informing
about such cases (whether it be 'unknown' or 'idle' ) or to simply return
an appropriate error and leave the userspace with dealing with that.

---
Thanks
Beata
> 
> -- 
> viresh

