Return-Path: <linux-pm+bounces-26581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77877AA7671
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D8217425D
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC02571AC;
	Fri,  2 May 2025 15:50:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C722D4DB
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201039; cv=none; b=PKl/0GoVJz+hrSdvej0WxAomXlrNMtK1z1hrUgEU58cUuW+xf+R/PE+8bUmg2wKIVZGu6GDRfXRZCPHget+Q9NOILySpL1yf1BXNN5hfOYJ1CvZhgvNlkf6VfZCnlJkgxsIBkzOBRDrOf0aFRJJhSbTTWO2HqxTThji0GDe71rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201039; c=relaxed/simple;
	bh=hxMmHpFZeJuBC4lXDpcnjahDazze78yNW3pEFKjWO2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP0PsDi+K/ZpI22GleNC4wr0gIwNciSeO0XzfyTw0kpxUHP3zFDvEiioFcR/lTFtKo7KD/tst2SCAXY5FHttPj6fWRFcj4Py7a0g0wyJn+aea8Xe7qK6utEs/a3meJafO4lhmS00X3VWZVdj4MrxFOUX2y0RVsKF7HL0szNsZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC9491688;
	Fri,  2 May 2025 08:50:26 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A770D3F66E;
	Fri,  2 May 2025 08:50:33 -0700 (PDT)
Date: Fri, 2 May 2025 16:50:30 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpuidle: psci: Avoid initializing faux device if no DT
 idle states are present
Message-ID: <20250502-cherubic-persimmon-koala-f200cc@sudeepholla>
References: <20250502140119.2578909-1-sudeep.holla@arm.com>
 <CAPDyKFobCehWO2jo2H2wMx40NLggoFOnhWKCuqcMURTLgiK1ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFobCehWO2jo2H2wMx40NLggoFOnhWKCuqcMURTLgiK1ug@mail.gmail.com>

On Fri, May 02, 2025 at 05:16:48PM +0200, Ulf Hansson wrote:
> On Fri, 2 May 2025 at 16:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Commit af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
> > transitioned the PSCI cpuidle driver from using a platform device to the
> > faux device framework. However, unlike platform devices, the faux device
> > infrastructure logs an error when the probe function fails, even if the
> > failure is intentional or expected.
> >
> > To prevent unnecessary error logs, we can skip creating the faux device
> > entirely if there are no PSCI idle states defined in the device tree.
> > Introduce a check for DT idle states during initialization and avoid
> > setting up the device if none are found.
> >
> > This ensures cleaner logs and avoids misleading probe failure messages
> > when PSCI idle support is intentionally not described in DT.
> >
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Fixes: af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Closes: https://lore.kernel.org/r/cf4e70e4-9fe5-4697-8744-8c12c41b5ff9@nvidia.com
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Rafael, please pick this one.
> 
> BTW, I was not cced the original offending commit and it was funneld
> via Rafael's tree. No worries this time, but probably easier to stick
> with my pmdomain tree future wise, to avoid any churns. This is also
> reflected in MAINTAINERS.
> 

Understood. The original patch was part of the series and I seem to have
missed you on it. Sorry for that.

-- 
Regards,
Sudeep

