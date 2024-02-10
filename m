Return-Path: <linux-pm+bounces-3732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E9E85040A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEB5282066
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71664364BD;
	Sat, 10 Feb 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1o0evzF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005492AF08;
	Sat, 10 Feb 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707562260; cv=none; b=n4GnV1j8Jhm1ZvCI1YS74UX/m14CebMQ3UesWhyRBMrmgaVjS1YieOa3iUJJaZOmwsmFQ6NSfq0xq9pE2wXWrudBzM17FaHRLsbEF9hwnZmgvz8Kjzv8ZE4HUfETOmbIRAbPIHTwJO4SxEF8JRpVsCINq43yaIOQpj8o31KcJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707562260; c=relaxed/simple;
	bh=FRX+d1XTODjUPjXDlUm/SKxlxDdNuhJFSD+LgNoSP/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ38SUX4Eygmpsnjisbrl0XKaAkC93E/88YDVrt/a8rvG8/CddU0WREDi1Y74Y7Kpqw1esNvSmhU774dx5TO1ApNQ9Ebf80w/4MpcuiuCAYPppvdYdU6P8lWkVaMvaM/lq/bnQHWjYUVMHLin5X2WSH/cjmuwhshNEBGwcCWAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1o0evzF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707562259; x=1739098259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRX+d1XTODjUPjXDlUm/SKxlxDdNuhJFSD+LgNoSP/4=;
  b=d1o0evzFrm/5h4d5EDbYuZ5zdX/Pl4zTgb0upycz+yP8DE4+p7LlB5/h
   3uVaGf7TXIiQ7P4iCjDkAll2HzPfNim37sWmutgqjgNMlPLmACbUPysd4
   6AEiqZ2/tc1WiX0b1aOQE4liPeytEeSUSHYMvrad3Z8QmiwwgtutHyLHg
   oAdbW5oIQBK0xbI0+p2ieEjLL7KxrQlgVulH4znTQSx3XV4eMTZo0b0yf
   UKbFYVCPoT2NUQqFWF8B83M0znsykjOQXS4i7a32GzyRdc0lMOdpBpt36
   MOctomEDUizQQ0ClZbO7Wdp7icdChVZ8gziBHokkhQ6lqB8z7Mw3ZUyEI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12199900"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="12199900"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 02:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934648080"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="934648080"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.138])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 02:50:54 -0800
Date: Sat, 10 Feb 2024 11:50:52 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/3] thermal: netlink: Add genetlink bind/unbind
 notifications
Message-ID: <ZcdVDEX5u982Qyes@linux.intel.com>
References: <20240209120625.1775017-1-stanislaw.gruszka@linux.intel.com>
 <20240209120625.1775017-3-stanislaw.gruszka@linux.intel.com>
 <20240209102858.51b06efc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209102858.51b06efc@kernel.org>

On Fri, Feb 09, 2024 at 10:28:58AM -0800, Jakub Kicinski wrote:
> On Fri,  9 Feb 2024 13:06:24 +0100 Stanislaw Gruszka wrote:
> > @@ -48,6 +64,15 @@ static inline int thermal_notify_tz_create(const struct thermal_zone_device *tz)
> >  	return 0;
> >  }
> >  
> > +int thermal_genl_register_notifier(struct notifier_block *nb)
> > +{
> > +	return 0;
> > +}
> > +
> > +int thermal_genl_unregister_notifier(struct notifier_block *nb)
> > +{
> > +	return 0;
> > +}
> 
> static inline :)

Going to fix this in next respin.
 
Regards
Stanislaw
> 

