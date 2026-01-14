Return-Path: <linux-pm+bounces-40848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BEDD1E964
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 12:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD51302AE22
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6D395263;
	Wed, 14 Jan 2026 11:57:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA02F3608;
	Wed, 14 Jan 2026 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391827; cv=none; b=FH2+9inMQf6jKB6f0bt59ZJoU8RhAkxsUrdogdtQsAL9PrJImCcyFr9m6q+vu5oloq7C7uo7F7YZ63EJlPEVKQb0nxd2lx28AsSZaEJVcTG28fFulq4dXQmv+Za0w/9/bFcOE0YSR3yoRq2sJ2rBPOTPekisdgU0dlEMms0IDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391827; c=relaxed/simple;
	bh=fvpFt5mZkw44VFVIqzHk688ygtKbcBYTd7qIHkZdsIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq2hA+Vf2N0Qt29hASc35sxxKdrA3e10NWn7G/a+j0Rxc9CjQ91aDOjNu8RgPQt75r2SouiZESdMM46aHuop9V6PscPQiTNJV574xu10tIQxGXV9k3Sq8ZYmk0DKEw2pIRNSkeWnlGFJvav3CKXP3MqGa+u9caMhWBj9Hdww3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FF8D497;
	Wed, 14 Jan 2026 03:56:59 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BC5C3F632;
	Wed, 14 Jan 2026 03:57:04 -0800 (PST)
Date: Wed, 14 Jan 2026 11:56:52 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: scmi: correct SCMI explanation
Message-ID: <aWeEdFdAuIiN6QJ5@pluto>
References: <e6c2e7af-ad87-4d38-9dbb-f9d6ae81fe83@auroraos.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c2e7af-ad87-4d38-9dbb-f9d6ae81fe83@auroraos.dev>

On Tue, Jan 13, 2026 at 10:33:30PM +0300, Sergey Shtylyov wrote:
> SCMI stands for System Control and Management Interface, not System Control
> and Power Interface -- apparently, Sudeep Holla copied this line from his
> SCPI driver and then just forgot to update the acronym explanation... :-)
> 

Hi,

> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> ---

Good catch..was up there all the time and never noticed :P 

... but I would certainly drop the Fixes tag.

Thanks,
Cristian

