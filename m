Return-Path: <linux-pm+bounces-41306-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cv1NfhIcmnpfAAAu9opvQ
	(envelope-from <linux-pm+bounces-41306-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:57:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490AF69557
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DDB302BE39
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B444D8DA9;
	Thu, 22 Jan 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miPkebd/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7304D2EE3;
	Thu, 22 Jan 2026 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096979; cv=none; b=XMdnm7A7KFNOd/mor7vuCYCEaebqOUGSkoHS7BiHBedeTWkO7IC+NMFdZn/JSXZ+0qOpjPSGshawgy41X0x0iWoB0gPPApSJEy2ripyVJE2VY0Ywc8gKaUMlSeeml+3xTi2Tpt9QojvnkS/SL3GkyEjgDWsEWTsqk8HgTKXCHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096979; c=relaxed/simple;
	bh=jiiGYS7yIEt86jT4gMkHWUd8F/0dtdZtPIKbbDy3cEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr3dhAU6MC3SxEhpoCtH4uu6eR2M0sOXc/XHYdzaYqzJDtWD90kJNTAsYRgR6gmiRTBLaZvzyoOH2dqLo8Nq7/BYbYJfvEtVnMR5bg9vqA7ACDBpQtN7J2PM4vzAfQT7eMrixIj7F17Sv3jSImrvCUMKH8pJpx9OsLo8EwCy9Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miPkebd/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769096976; x=1800632976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jiiGYS7yIEt86jT4gMkHWUd8F/0dtdZtPIKbbDy3cEE=;
  b=miPkebd/ACFJqdAfckAhUe0S9lVZznjAo5442+Lv3XNnt0vMqQVq8h1w
   3O20Wm9y24MC/zagXRnwXqqrKKQr/ga7wOvOcnystORsimeFFsovWx9ua
   oG8USlglkKcbsrw2YZuxmU7yxFBjp4k0Nh5xo7rLjFgi2ITxHH30SiYDl
   gcn2NitnTt0AZIYV5m59y8m/LGJd7gym1SGFvAdNzOTNc2LK5kptTPW8F
   F88sZ/KcEcmuLQZWp9D0Gn5/K+78BwwJ5ZrBPfVcC/T4tlUg9LChR4meR
   8jwCy4XFboDLYYpJf8be7K8FHcF8uosb4UlkT7juVRnN5xjFrOQZnKXG4
   w==;
X-CSE-ConnectionGUID: OIw0MkSOT4qEzALw7bL0SQ==
X-CSE-MsgGUID: XqpO1bvOT5qD+/GLUM/E8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="87920158"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="87920158"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:49:33 -0800
X-CSE-ConnectionGUID: iyeuz8qfSZSiaLkk+7C83Q==
X-CSE-MsgGUID: zYANt7XOT5CsfP9keON1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206672073"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:49:32 -0800
Date: Thu, 22 Jan 2026 07:55:49 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Disable SMT when hybrid systems
 are enabled
Message-ID: <20260122155549.GA18021@ranerica-svr.sc.intel.com>
References: <20260119074118.835922-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074118.835922-1-tianyaxiong@kylinos.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ranerica-svr.sc.intel.com:mid];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41306-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 490AF69557
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 03:41:18PM +0800, Yaxiong Tian wrote:
> When hwp_is_hybrid && !sched_smt_active(), the driver enables
> hybrid_capacity_scale and disables ITMT. According to the original code
> logic, these related actions are one-time operations; therefore, I
> believe the original design intent did not support dynamic runtime
> switching.
> 
> However, SMT can be toggled via related interfaces in /sys. When SMT is
> enabled, the system is no longer hybrid, and the original settings become
> incorrect.

Indeed I was able to enable SMT siblings:

	$ echo on > /sys/devices/system/cpu/smt
	$ echo 1 > /sys/devices/system/cpu/cpu1/online

> 
> To resolve this confusion, permanently disable SMT by calling
> cpuhp_smt_disable().

IMHO, the user should be able to enable SMT back if she or he chooses to. Instead,
the sched domains should be rebuilt with asym packing and without asymmetric
capacity.

