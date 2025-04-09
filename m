Return-Path: <linux-pm+bounces-25007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38262A8241C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 14:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1211BA2B67
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203C254B09;
	Wed,  9 Apr 2025 12:02:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BC945009;
	Wed,  9 Apr 2025 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200120; cv=none; b=UDjLX25ZkPKgGk+9AwXk20kweQaqleJCb56Bn7K/TNiA5GKzeWAu0oQfHfrDjK4fBU6/5PH1kDkhBopUr7YnKOc3QGsro6K0MgQCXGZoXMlXtv+LNspl0uwuRYqqQdVUSff2nm8b3/tyf2/bXT4q+ofZZmxFnt3S71Nep9+q0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200120; c=relaxed/simple;
	bh=rPUV8FgJegitXiVQUTfiLM1o0/uBOnP4q0gwO7/J0sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBpUlTtmYmfY3Rajj0BtMy4P9mzQ9jSjOW/2jT4MeQTI053dBGAsMeG0E5LYaAMk+IdNxp/K2IPcWONXb4YR7JQX+f0NqJZyyWENhCGZk0EGeIx1UZWkneixhVdUl3asvcETmAyL/1M1ihhpBPKPbmEL2Tk+55+ZXdcuMbUfXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B351715A1;
	Wed,  9 Apr 2025 05:01:57 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81AC03F59E;
	Wed,  9 Apr 2025 05:01:55 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:01:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Henry Martin <bsdhenrymartin@gmail.com>, arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference
 in get_rate()
Message-ID: <Z_Zhp38o9KiicPVw@pluto>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
 <0558b7f7-8c69-4664-afc6-bae4fdc6f071@web.de>
 <20250409-merry-gay-lemur-8288cf@sudeepholla>
 <52aa52a5-7081-41ee-872e-f1728c06daf1@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52aa52a5-7081-41ee-872e-f1728c06daf1@web.de>

On Wed, Apr 09, 2025 at 01:48:33PM +0200, Markus Elfring wrote:
> >> Can any other summary phrase variants become more desirable accordingly?

I agree with Sudeep, the above sentence is completely incomprehensible
to me

> >
> > This is meaningless, sorry can't parse. Ignoring it as others in the
> > community are doing already.
> Do you care if the term “null pointer dereference” would be used in consistent ways?
>

...this is more comprehensible, but again I cannot grasp what's yor advice
specifically on this commit message.

Thanks,
Cristian

