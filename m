Return-Path: <linux-pm+bounces-19396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BDB9F575C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 21:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A827A50D6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D91F6671;
	Tue, 17 Dec 2024 20:11:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0B14600D;
	Tue, 17 Dec 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466305; cv=none; b=TyXpzWFQPhX5in0fY3cNNq8709D+Q4hQiQeVDGTHx/LwNJSxhk0EYUbHkbpCKrTDKX1NM6W1g/50DSREOKz22+p4TuEBDMbMP5DIQMJPGgWxbC1bsoE+h79lrYw61J9Sex+1ykPvXk3Ux7ih2PAmYoWZXGOK90iR311L5ktffJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466305; c=relaxed/simple;
	bh=/opUnMx2K0Pl0/ZfgAIgm53hcedOyWVqswmB7Q4uL38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRYkqbikV/onklqAE2Z83WfgwJ2Jgl5WXwnd65r+BNyuQjUzAK1T6BhidwljpAykAkTnme6pE/mo4M7OyKtuwDzwGSNT1kUmkSN7O7Ck2+84kgtKRZYjYxWKjCPGARaTDhlY6p41XxBrzxcmihTOyZjpY3yunxfxmrmCbDaF8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089D4497;
	Tue, 17 Dec 2024 12:12:09 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825133F528;
	Tue, 17 Dec 2024 12:11:35 -0800 (PST)
Date: Tue, 17 Dec 2024 21:10:43 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Z2Haw_o8gF-Ce1gx@arm.com>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
 <Z2CmcelSy89NULtz@arm.com>
 <20241217042726.isllh5bulpnwql7i@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217042726.isllh5bulpnwql7i@vireshk-i7>

On Tue, Dec 17, 2024 at 09:57:26AM +0530, Viresh Kumar wrote:
> On 16-12-24, 23:15, Beata Michalska wrote:
> > My bad as I must have misinterpreted that message. Although I am not entirely
> > sure why this might be unacceptable as it is not such uncommon approach to use
> > signed int space to cover both: expected positive value as well as potential
> > error code case failure.
> 
> This part is fine. The problem is with handling frequency here. Signed int can
> capture up to 2 GHz of freq, where as unsigned int can capture up to 4 GHz and
> so we would really like to keep it at 4 GHz..
Right, though the arch_freq_get_on_cpu operates on kHz values.

---
BR
Beata
> 
> Maybe we need to move to 64 bits for frequency at some point of time, but at
> least we should try to not break it for now.
> 
> > Enabling the new attribute for all is an option, tough not entirely compelling
> > one as exposing a feature that is known not to be supported seems bit
> > counterintuitive. On the other hand using cpufreq driver flags won't help much
> > as the support for the new attrib is platform-specific, not driver-specific.
> 
> -- 
> viresh

