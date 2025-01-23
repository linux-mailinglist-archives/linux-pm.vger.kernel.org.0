Return-Path: <linux-pm+bounces-20871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63077A1A39D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B8162B93
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FF20DD64;
	Thu, 23 Jan 2025 11:52:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22020CCEF;
	Thu, 23 Jan 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737633155; cv=none; b=Y3mpu1uO6hhSIg48kBWcUCL9u3UdYBoP2fqVPY7xxB0xfZndMSX2Nid0H6qPDCEYa46dRqR2HcdzbA+jD6aUc4t2xVuKT0Hlrbu1oE6wINMkjLYiQrNnDfCICpi/7FPpMYqH0/3lgq1QQPiCKK/GnnVlaTcpUuxz2ODBf1299fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737633155; c=relaxed/simple;
	bh=QVEdvEPi8J8EKC5znL3+8xJd0NBDc4T8ikFGWLWcuHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiWIJDIJD7Csr8OVBxYFHSyt59s232PudSYBghiWpWTWpXtlHHu5NJlLDgcUDM+NuiSg3ZhXZTqrpLgtPHr3zrYDg/2SSBKzSD4K++EzuZDUIRM7Jyaub0VX7aMza+AqhtveZJABYfEUT0vB+hwF7Z6MkS7K14AtHZd4ZirkZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05C3B1063;
	Thu, 23 Jan 2025 03:53:02 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E18F3F5A1;
	Thu, 23 Jan 2025 03:52:32 -0800 (PST)
Date: Thu, 23 Jan 2025 11:52:29 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/33] cpufreq: scpi: Stop setting cpufreq_driver->attr
 field
Message-ID: <Z5ItfU78ALHgrYI2@bogus>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
 <2b89078adc1472d5ab9377ad7675cf4c07a8f7cc.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b89078adc1472d5ab9377ad7675cf4c07a8f7cc.1737631669.git.viresh.kumar@linaro.org>

On Thu, Jan 23, 2025 at 05:06:01PM +0530, Viresh Kumar wrote:
> The cpufreq core handles this for basic attributes now, the driver can skip
> setting them.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

