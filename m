Return-Path: <linux-pm+bounces-23480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0CA4FBD6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 11:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D794016CB24
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADFE2063E9;
	Wed,  5 Mar 2025 10:25:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649E205ACB;
	Wed,  5 Mar 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170350; cv=none; b=C4O2jQdFrjNWDJA0KwC7QTTrxh7dOJGGJaO7A18uEBsHnYYQQsmVDgnKe/H0/DUl7NF2alZBuvSqjr0SgBWlnmTYVjIhdzojh1udqDX3VWhLYPiI640FpsOrUrrU2wa7bb8elUtf1Upx9pSKjlV4N+wzr9JVtrMCxlcgCthXuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170350; c=relaxed/simple;
	bh=fVbfzVkRLJ91dCVygzh7ls9q2eT4BMQh3d0gm4OxdDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzcUOaq3ho/3/ilERFFCI2RRh2raqXsarLXjnGLvrw2i8g34rbqO1LBYpba7tFuBhZ4r3UPPPqGtQLS7I3mBrJTNbQT9u9A1FEbsfq7Nk5jZKkMnKlIKxXkvuO3z1BwuYBKIDiq2uHITl2RWTipPTRm+vu/V9F5tIlogbtZDrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 361C7FEC;
	Wed,  5 Mar 2025 02:26:01 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9EA3F673;
	Wed,  5 Mar 2025 02:25:45 -0800 (PST)
Date: Wed, 5 Mar 2025 10:25:42 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>, Jacky Bai <ping.bai@nxp.com>
Cc: lpieralisi@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	james.morse@arm.com, d-gole@ti.com, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, khilman@baylibre.com,
	quic_tingweiz@quicinc.com
Subject: Re: [PATCH v2] cpuidle: psci: Init cpuidle only for present CPUs
Message-ID: <20250305102542.36q7lmctx5jm4mg7@bogus>
References: <20241120103749.1450017-1-ping.bai@nxp.com>
 <Z8fv3X0Pivh8zbMg@cse-cd02-lnx.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8fv3X0Pivh8zbMg@cse-cd02-lnx.ap.qualcomm.com>

Hi Jacky,

I wasn't Cc-ed on the original patch.

I was searching to provide feedback but couldn't find one.

On Wed, Mar 05, 2025 at 02:31:57PM +0800, Yuanjie Yang wrote:
> On Wed, Nov 20, 2024 at 06:37:49PM +0800, Jacky Bai wrote:
> > With 'nosmp' or 'maxcpus=0' boot command line parameters,
> > the 'cpu_present_mask' may not be the same as 'cpu_possible_mask'.
> > 
> > In current psci cpuidle driver init, for_each_possible_cpu()
> > is used to init the cpuidle for each possible CPU. but in
> > drivers/base/cpu.c ->cpu_dev_register_generic(),
> > for_each_present_cpu() is used to register cpu device for
> > present CPUs.
> > 
> > When boot system with 'nosmp' or 'maxcpus=0', the cpuidle driver
> > init failed due to no valid CPU device sysfs node for non-boot CPUs.
> > 
> > [ 0.182993] Failed to register cpuidle device for cpu1
> > 
> > Use for_each_present_cpu() to register cpuidle only for present
> > CPUs.
> > 

Can you reword it something like
"

for_each_possible_cpu() is currently used to initialize cpuidle in the
PSCI cpuidle driver.

However, in cpu_dev_register_generic(), for_each_present_cpu() is used
to register CPU devices which means the CPU devices are only registered
for present CPUs and not all possible CPUs.

With nosmp or maxcpus=0, only the boot CPU is present, leading to the
failure:

  |  Failed to register cpuidle device for cpu1

Change for_each_possible_cpu() to for_each_present_cpu() in the PSCI
cpuidle driver to ensure it only registers cpuidle devices for CPUs
that are actually present.

"

With that, you can add:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Please cc Ulf Hansson <ulf.hansson@linaro.org> as well. Either him or
Rafael can then pick up the patch.

-- 
Regards,
Sudeep

