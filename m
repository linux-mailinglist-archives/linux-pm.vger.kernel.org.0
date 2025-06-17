Return-Path: <linux-pm+bounces-28889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52959ADC7DB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E78D18947C6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8C2C08AB;
	Tue, 17 Jun 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="sUBCKre8"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA3221568;
	Tue, 17 Jun 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155316; cv=none; b=MHFO4/VEXUfFwBFJO7ifieZEc6UuhAXYauJ9OVqichc82f+4qvX4XdpA2/nVpoQ6/buEgxoahendbyzGiDNqLiLAz29QG+zJDFePTXtNIwpADOA36CLVANt8vCn0kQap7PUWD+01GW3cm28jMWE7mAlcJXfR6ygdV5XZYhb+kao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155316; c=relaxed/simple;
	bh=qi167v05pSdImwk+jUtorfAvfqhSdptwLbnqtnr/hK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1J/b/PZS8s7pp12ZnQAnzW/iXW+OlU5YgLGA6XL4LVZTe5jGad2yufZKfXWq6QeKeS2PgnNwdruD+Z/oiLb0m34NxiySeMHqyAx3NrF/r+k+QvzyzxEmIyzpt4jKaD/bh8ATf1CFYO99Hu0yizuZ/VNbI1eQzOTZa297vunSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=sUBCKre8; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1750155313; x=1781691313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xAGT5VwsBh5YQsXs7TeqXfNEzf33+wLYzOeBX75jZec=;
  b=sUBCKre8P2o3shBda7aM1/HuH6f1m+BzbtyJIGKonZIlSLNp8FyxBNee
   vhyGmRVz/nSHM+/nIWolpijPM4dry4Qr+Jg1vq/oAWJS2p6R3NCJuor8P
   VYUN6C92S/Fhwv7rn267cvxZMvzOzWsyZL78XReQPbvyqEriie9W7rz87
   kUKTtm/etL0redylHQcwYxvq1tzZ3PdcVT+hhSJMs12R1imYCA+SC3Q1R
   gndhhb2Sd6r9ebakyqAK3pCU38CFPh3opcAQelXWHWmfL7U7QQEYdsH4B
   5TGLmbcvGJUFDSHo/mN6lJ0sFppjMr7kL91RUPvpkHIkK+CYr97wnWRx/
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 19:15:05 +0900
X-IronPort-AV: E=Sophos;i="6.16,242,1744038000"; 
   d="scan'208";a="543112704"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 19:15:05 +0900
Date: Tue, 17 Jun 2025 19:14:58 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shinya Takumi <shinya.takumi@sony.com>,
	20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com
Subject: Re: [PATCH v2 0/2] cpufreq: userspace: add CPUFREQ_GOV_STRICT_TARGET
 flag
Message-ID: <aFFAIrGNlsGyKVLc@JPC00244420>
References: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>

Hi Rafael,

Could you please take a look at this?

Thanks

Regards,
Shashank

On Tue, May 27, 2025 at 09:59:08PM +0900, Shashank Balaji wrote:
> In-Reply-To: 20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
> Changes in v2:
> - Instead of modifying the documentation to say that variation in frequency is
> possible despite setting scaling_setspeed, add the CPUFREQ_GOV_STRICT_TARGET
> flag to the userspace governor to make its behaviour match the expectation when
> used with the intel_pstate driver with HWP enabled
> - Mention in the documentation that variation in frequency due to hardware
> factors is possible
> - Link to v1: https://lore.kernel.org/r/20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com
> 
> ---
> Shashank Balaji (2):
>       cpufreq: userspace: set CPUFREQ_GOV_STRICT_TARGET flag
>       cpufreq, docs: userspace: mention variation in freq due to hw coordination
> 
>  Documentation/admin-guide/pm/cpufreq.rst | 4 +++-
>  drivers/cpufreq/cpufreq_userspace.c      | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> ---
> base-commit: 914873bc7df913db988284876c16257e6ab772c6
> change-id: 20250522-userspace-governor-doc-86380dbab3d5
> 
> Best regards,
> -- 
> Shashank Balaji <shashank.mahadasyam@sony.com>
> 

