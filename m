Return-Path: <linux-pm+bounces-13854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE19707EF
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D901B2141E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F416FF44;
	Sun,  8 Sep 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yCBQyQc+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41243158A13;
	Sun,  8 Sep 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804317; cv=none; b=jvc2rTLGlwTb9LCqdZ1JU1QWmi944ClGjoJhcFe/yN3GLEbA3UQBCh4fb2kX6bNYg6GY54Phx/JGzRJf15JUN2CptdMY4xcBsI7lD/kOmY6NJQrhQH7zjlaAdo7rybp+7zCj5PsdCf1uTrzttHZpsNq2Tr/Zgu2MoRTuMhQTggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804317; c=relaxed/simple;
	bh=3SQrPlKSW6WMQp47CSJG6ocgVQYwZ0hPYBeedZ45sRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uebHrtf9MuXf03cHfkNN15KV5mU14ZpliVT7yKElofMwz2QP6t3A5QqLZ/kHocvZVlP+ZA7swvEgM9ygPI9/3Vbc2uOFuvnjkYWQkHvn+jRH+1OHSRk1cWX5rtzDe3jFQMxkWvDAUi3EvoVbP5JUIhiSfivwKqaj73yfTlis3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yCBQyQc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E3AC4CEC3;
	Sun,  8 Sep 2024 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725804316;
	bh=3SQrPlKSW6WMQp47CSJG6ocgVQYwZ0hPYBeedZ45sRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yCBQyQc+9SNdkpPrqDEwY1o8MudqIKkPXw1aOZokO1CRij6pgFYi81t1fUaYQj5Z5
	 lqaZQJSyLR6NbaDwIxadinOQ/8wCYffqPILdnHjPv6mzMm+XdbrZXDkGuYA6M2rWe6
	 WHsF5j6xlh8o3pDlU+Q0zGtuq0R7/iGQ4CxX6bHE=
Date: Sun, 8 Sep 2024 16:05:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Jones, Morgan" <Morgan.Jones@viasat.com>,
	Sasha Levin <sashal@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Arcari <darcari@redhat.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"perry.yuan@amd.com" <perry.yuan@amd.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"li.meng@amd.com" <li.meng@amd.com>,
	"ray.huang@amd.com" <ray.huang@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: linux-6.6.y regression on amd-pstate
Message-ID: <2024090834-hull-unbalance-ca6b@gregkh>
References: <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
 <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
 <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
 <be2d96b0-63a6-42ea-a13b-1b9cf7f04694@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2d96b0-63a6-42ea-a13b-1b9cf7f04694@amd.com>

On Thu, Sep 05, 2024 at 04:14:26PM -0500, Mario Limonciello wrote:
> + stable
> + regressions
> New subject
> 
> Great news.
> 
> Greg, Sasha,
> 
> Can you please pull in these 3 commits specifically to 6.6.y to fix a
> regression that was reported by Morgan in 6.6.y:
> 
> commit 12753d71e8c5 ("ACPI: CPPC: Add helper to get the highest performance
> value")

This is fine, but:

> commit ed429c686b79 ("cpufreq: amd-pstate: Enable amd-pstate preferred core
> support")

This is not a valid git id in Linus's tree :(

> commit 3d291fe47fe1 ("cpufreq: amd-pstate: fix the highest frequency issue
> which limits performance")

And neither is this :(

So perhaps you got them wrong?

thanks,

greg k-h

