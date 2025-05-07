Return-Path: <linux-pm+bounces-26810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238EAAE246
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A273462AB9
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC251289E29;
	Wed,  7 May 2025 13:56:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845B288CB2
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626164; cv=none; b=GS93myxC2eaCqJNkKN9RTYQPVAmYhkkPXG+jJjcpfzuOgrUHaYXgePv2j1glA1PD/yfwXOoYJd8MvRKt/FNAep7rOo1NZpA1shgTNPX/5ZM2V0Etmh3FMqqToFYW3V7FizZMi8cFp6ubwqWqazGYRjlJXebKx7YSFMkh06zAmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626164; c=relaxed/simple;
	bh=+DebITcp3S8eGAwURW301Sf+9B44BfMrt1C9vZ92xcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQeo5eVE8IrNJiPiJfpW8ZFGgph6cjmA+0YpAJfiw5JzGjvT5FzVQNlvHRwCvIRiL9+8pfkatqqeTZhEn+mmhSGmQCWSIy5AEy0B2kvkRgaSwlPl+hYfhaO4yzhgn2Mc3OP6md3lEBCLspqDdecvsizgcqAQg8QsrfB2sOE8L5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6BAE339;
	Wed,  7 May 2025 06:55:51 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934713F5A1;
	Wed,  7 May 2025 06:56:00 -0700 (PDT)
Date: Wed, 7 May 2025 14:55:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpuidle: psci: Avoid initializing faux device if no DT
 idle states are present
Message-ID: <20250507-crouching-lovely-wrasse-f85e90@sudeepholla>
References: <20250502140119.2578909-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502140119.2578909-1-sudeep.holla@arm.com>

Hi Rafael,

On Fri, May 02, 2025 at 03:01:19PM +0100, Sudeep Holla wrote:
> Commit af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
> transitioned the PSCI cpuidle driver from using a platform device to the
> faux device framework. However, unlike platform devices, the faux device
> infrastructure logs an error when the probe function fails, even if the
> failure is intentional or expected.
> 
> To prevent unnecessary error logs, we can skip creating the faux device
> entirely if there are no PSCI idle states defined in the device tree.
> Introduce a check for DT idle states during initialization and avoid
> setting up the device if none are found.
> 
> This ensures cleaner logs and avoids misleading probe failure messages
> when PSCI idle support is intentionally not described in DT.
>

As you pointed out in another similar fix that exist only in the linux-next,
I have also missed to point out that fact here. This is only present in
the next. Let me know if you want me to drop the commit hash reference
and repost it with -next prefix which I generally do and somehow clearly
missed here. Sorry for that.

-- 
Regards,
Sudeep

