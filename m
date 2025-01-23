Return-Path: <linux-pm+bounces-20872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4FA1A3B7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 13:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28AD1885C48
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62B20DD45;
	Thu, 23 Jan 2025 12:01:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7791D432F;
	Thu, 23 Jan 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737633698; cv=none; b=Dq9Wh4u6lSL5tCZNLF2GqCvRDsJur7ltLTJVmsFqXiCCNztj/+v6sckMWpzTZOCj5ki8W01sUrLekn2E6QY+z8dMkxFXYU8czzMCEBgmvp8i9NQPIMlmwr+HkaBEXz+/+xEJUS1nMbYPFW/k61yyIHjWc+zWKeh2XJDXdG/pM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737633698; c=relaxed/simple;
	bh=PaoOFn6JXXsIq16ZOXpO7kHfAaEgKspiCBXQ/wULbpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnKOH3tbi6yLHlyDeut6Kbn6vT/QFkzCq97PbowcqDTbzSbcxZQIvWz8x622TsJawhC6hWjjjFcsLViAMyNtguFprNws5n7+nEFno/8ZdFUYO4EV5sTYCvZQ8SLUhaUnEwkshQZ/ciu5wwjMR+rf0z8rS0EAenEFpjORlQ693AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02DF1063;
	Thu, 23 Jan 2025 04:02:04 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06A7B3F5A1;
	Thu, 23 Jan 2025 04:01:34 -0800 (PST)
Date: Thu, 23 Jan 2025 12:01:32 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/33] cpufreq: scmi: Stop setting cpufreq_driver->attr
 field
Message-ID: <Z5IvnF_dw3ez33Bv@bogus>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
 <d4893396c4bacdd995d03a296b9d3ff44e71d072.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4893396c4bacdd995d03a296b9d3ff44e71d072.1737631669.git.viresh.kumar@linaro.org>

On Thu, Jan 23, 2025 at 05:06:00PM +0530, Viresh Kumar wrote:
> The cpufreq core handles this for basic attributes now, the driver can skip
> setting them.
>

I know this is boiler plate commit message but it made me go check if boosts
are handled too even though I checked it in 01/33. So if possible, you can
add "basic attributes including boost frequencies", that would be good,
aligns with the change below and makes it easy to refer in the future if
required. Not a must, I will leave that to you. Anyways,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

