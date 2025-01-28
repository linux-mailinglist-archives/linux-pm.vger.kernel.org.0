Return-Path: <linux-pm+bounces-21013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783ECA209B0
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 12:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EE33A9AAD
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A91A08A0;
	Tue, 28 Jan 2025 11:27:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7A519DFA5;
	Tue, 28 Jan 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063658; cv=none; b=sucB1oq4hGbeJVJPK9+c9jx9Uv0JpROIufD/Vg2fk/6cflowDhT47ljR+sWyuITbIGq6f/pELqitotku2wYLmh97uiTOK6qPjtpsiSmeB4LqPNVwwpFUBqg15x3G83XEIKHmM6bqLDGiYbzz1k5opmqGvLlDfzj1FK8urolacQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063658; c=relaxed/simple;
	bh=ikYGaS4pSvxK2ANZ8PGxwRXDNbEgns3dccUkaLrzlQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpYZdgqkfpDliuvdbpRo89q0DlB9jpCATnzVNdBd9wkU/wIx28WOffcMghA6rcnHcLAXJ0raBMcAlR5NQOv8nlhakGsdjgEgQr3NR1AfEUknnzip7AcdxqmgNddwSauCvZnHAzcUvp587CZPI13uxEYcLKYm2zHk6iagOLviCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 540E1497;
	Tue, 28 Jan 2025 03:28:02 -0800 (PST)
Received: from bogus (unknown [10.57.36.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACB553F694;
	Tue, 28 Jan 2025 03:27:33 -0800 (PST)
Date: Tue, 28 Jan 2025 11:27:01 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] cpufreq: scmi: Set .set_boost directly
Message-ID: <20250128112701.s2kgegovz625nuac@bogus>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
 <ec27aef491c1b71ef5f1240480c52d051cdd821d.1737707712.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec27aef491c1b71ef5f1240480c52d051cdd821d.1737707712.git.viresh.kumar@linaro.org>

On Fri, Jan 24, 2025 at 02:28:15PM +0530, Viresh Kumar wrote:
> The boost feature can be controlled at two levels currently, driver
> level (applies to all policies) and per-policy.
> 
> Currently the driver enables driver level boost support from the
> per-policy ->init() callback, which isn't really efficient as that gets
> called for each policy and then there is online/offline path too where
> this gets done unnecessarily.
> 
> Instead set the .set_boost field directly and always enable the boost
> support. If a policy doesn't support boost feature, the core will not
> enable it for that policy.
> 
> Keep the initial state of driver level boost to disabled and let the
> user enable it if required as ideally the boost frequencies must be used
> only when really required.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

