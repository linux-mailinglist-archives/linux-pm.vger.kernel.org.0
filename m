Return-Path: <linux-pm+bounces-16521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92BB9B1F9B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9007C1F213CC
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83594172BB9;
	Sun, 27 Oct 2024 18:17:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31541CABA;
	Sun, 27 Oct 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053058; cv=none; b=q9LWXqz1mJeIs8GnQDCGyl9wUifwoIyRfeX4UkSPQMRRql9VYnl9ooe51CwVdd60IzAMTKgrrtBmlRrNVTzjqNOtMxt8qArQKOTDodqY+0L9MGCIbxBzQkugQPc6muVzWr04C1ZXbE06JF78bjbwDCjSwqbnNS7AMNtgZ4uSACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053058; c=relaxed/simple;
	bh=Bm7Q82ADY6XlrlhPImr2gBu8KmdPHQQlep8Q2uUx3tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+wE3mgB/9F1+oDXZoMXeS+IxqtaIzIcBihmdSZPlGCeANS2gTHZxoJw1+txPMCj024n11T1WvC6DDr1oGAVq+Hrg2z1HJBYlOocQu47uT/wtH2qDfUzcEeUd7XNEZe/OJvZ1bseKHkbF2dvoRtGQUUdlQw0lF1jMh7OJwaymjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7972F497;
	Sun, 27 Oct 2024 11:18:03 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEA5B3F73B;
	Sun, 27 Oct 2024 11:17:29 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:16:56 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: viresh.kumar@linaro.org, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v7 0/4] Add support for AArch64 AMUv1-based average freq
Message-ID: <Zx6DmCBYQZkLWRhf@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <Zw-cje76QgQIN5kq@arm.com>
 <ZxAnbflwMuIWpKCW@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxAnbflwMuIWpKCW@arm.com>

On Wed, Oct 16, 2024 at 10:51:57PM +0200, Beata Michalska wrote:
> On Wed, Oct 16, 2024 at 11:59:25AM +0100, Catalin Marinas wrote:

Hi Viresh,
Hi Rafael,

> Hi Catalin,
> > Hi Beata,
> > 
> > On Fri, Sep 13, 2024 at 02:29:40PM +0100, Beata Michalska wrote:
> > > This series adds support for obtaining an average CPU frequency based on
> > > a hardware provided feedback. The average frequency is being exposed via
> > > dedicated yet optional cpufreq sysfs attribute - cpuinfo_avg_freq.
> > > The architecture specific bits are being provided for AArch64, caching on
> > > existing implementation for FIE and AMUv1 support: the frequency scale
> > > factor, updated on each sched tick, serving as a base for retrieving
> > > the frequency for a given CPU, representing an average frequency
> > > reported between the ticks.
> > > 
> > > The changes have been rather lightly (due to some limitations) tested on
> > > an FVP model. Note that some small discrepancies have been observed while
> > > testing (on the model) and this is currently being investigated, though it
> > > should not have any significant impact on the overall results.
> > > 
> > > Note that [PATCH 2/4] arm64: amu: Delay allocating cpumask for AMU FIE support
> > > can be merged independently.
> > 
> > What's the plan with the rest of the patches? Are you going to respin?
> > The first patch would need an ack from Rafael or Viresh if we are to
> > merge them via the arm64 tree.
> >
> I am still waiting on any feedback on [PATCH 1/4] - changes to cpufreq, as that
> one drives the changes in arch specific bits. There is also an ongoing discussion
> on how to handle idle cpu cases - so I would say we still need to agree on few
> details.

Would really appreciate your feedback on above mentioned [PATCH 1/4] ->  [1]
as well as the discussion at [2].

Thank you.

---
[1] https://lore.kernel.org/all/20240913132944.1880703-2-beata.michalska@arm.com/
[2] https://lore.kernel.org/all/ZxAl77IYcMO2SfWh@arm.com/
---
> 
> ---
> BR
> Beata
> > Thanks.
> > 
> > -- 
> > Catalin
> 

