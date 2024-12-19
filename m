Return-Path: <linux-pm+bounces-19516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F19F7AD2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 12:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786B6163BE3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736C22371E;
	Thu, 19 Dec 2024 11:58:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEDF1FCFCB;
	Thu, 19 Dec 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609488; cv=none; b=AQPtuun+kJQvZQ08eUAr4VFqyiGAWjWYkfmHI4N96pJb2YhTVYfYjJAgc3BqYyJE4j1IMAFRb+o8UGirFQPrIrddRDW9KBo8FQwJt+lSmfpkAsW51LwHyG1YM6Gq43W50jJawHJiJEVy1Bplh4Tw+fOsW65r3btstiL+jt2j5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609488; c=relaxed/simple;
	bh=9QyEbko00vRNEvfAa8AOjeJA/QUr06UTEbZ8U/z9g1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0GMaaUHxArS1Fi5q+Epz/C5iitmIAMkKrXHirzlUdo77noJWoHPTMNFDxMFqj8jb7QLE9cCjhns5owHUSdToB195Jr6gfrtbAeZsDtKa3Q7IWtTj+B0O6Ba7hlvBFLfopmNYiP5DA0wMySp3hYlu2Pe+YAALatnSjK75y97U4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B3C31480;
	Thu, 19 Dec 2024 03:58:33 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 073D83F720;
	Thu, 19 Dec 2024 03:57:59 -0800 (PST)
Date: Thu, 19 Dec 2024 12:57:07 +0100
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
Message-ID: <Z2QKE3uml7CRm0DD@arm.com>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
 <Z2CmcelSy89NULtz@arm.com>
 <20241217042726.isllh5bulpnwql7i@vireshk-i7>
 <Z2Haw_o8gF-Ce1gx@arm.com>
 <20241218041127.khdwo3hzmywcwuh5@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218041127.khdwo3hzmywcwuh5@vireshk-i7>

On Wed, Dec 18, 2024 at 09:41:27AM +0530, Viresh Kumar wrote:
> On 17-12-24, 21:10, Beata Michalska wrote:
> > On Tue, Dec 17, 2024 at 09:57:26AM +0530, Viresh Kumar wrote:
> > > On 16-12-24, 23:15, Beata Michalska wrote:
> > > > My bad as I must have misinterpreted that message. Although I am not entirely
> > > > sure why this might be unacceptable as it is not such uncommon approach to use
> > > > signed int space to cover both: expected positive value as well as potential
> > > > error code case failure.
> > > 
> > > This part is fine. The problem is with handling frequency here. Signed int can
> > > capture up to 2 GHz of freq, where as unsigned int can capture up to 4 GHz and
> > > so we would really like to keep it at 4 GHz..
> > Right, though the arch_freq_get_on_cpu operates on kHz values.
> 
> Hmm.. Missed that.
> 
> If you still want to keep it, make that change in a separate patch and
> the new sysfs entry in a different one, so related people can easily
> review.
> 
Will do.
Thank you for your feedback. Much appreciated.

---
BR
Beata

> -- 
> viresh

