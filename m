Return-Path: <linux-pm+bounces-4558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47386CEDA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 17:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBB12832E7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E020160624;
	Thu, 29 Feb 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBDDxMI5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03A63113;
	Thu, 29 Feb 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223196; cv=none; b=Xap79dMS5kS5qu57ncdjHsyxbkI4ij29jE7vKZbVr1cLSErW4efsx5QVQXYb/tvrKj637qiEdP2Y0xc8S8Kq31ztCsRLPuJ3ZUf207nNAdrO7KaJtqU3wWfkXAO+3Ko8h5VY+N5vlDNWCuuIUerI+TObhmmzL8iu1iJj1yb/s2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223196; c=relaxed/simple;
	bh=+yqE7u3QJuKmq7GE50inJJVYECyhDO574u1rouG3Rr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7BjSSnGmZrzfqWF01ar3VkupOeZlCeXfH871cqQ+/KUlRiyiGzmdhUjHAc7rRexV2sXzjKbnm1ZnfyvaG3P11SmbfKm8gE6SKYnOFriC41Yim4i5kprkhdiGTxmDeCaJhy5zty/DoWJ3SrP7XVvyIBMg81YbAZkSuaRobjClEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBDDxMI5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709223194; x=1740759194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+yqE7u3QJuKmq7GE50inJJVYECyhDO574u1rouG3Rr0=;
  b=IBDDxMI5KkqFZIQzI+iUSRjlvz6/PpnbK5YzxPcFVLz8uusj7H/7/vS2
   UwayGQOKUNx9pY1esJktqEaK+UsHDmXMwIBkmx7DhD+yFawt7WDC08Yce
   l7QaKUtLosqmJPv/KVZUCDUxJL2jnlLZVuSRRyyGFa1xUJjdJnThdfo3c
   ny9wCJHjF9087xSOFORV9mUfiqapo8c7zUuAXa2mlpckc3GijsTzSCsos
   NS+36pq8+wfZLRMlhsyEUYty7c7r5DcJk2gsQP8f5Imslga3rKi26XTqM
   V6fnaKtoI1q96Ziht82VPCmdRbxt8j019nbmjqJZmmj/R1fytA5nAdgyH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3867476"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3867476"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8113441"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.213.5.78])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:13:08 -0800
Date: Thu, 29 Feb 2024 17:13:05 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature
 only when required
Message-ID: <ZeCtEUGQknfHegpR@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0gw52e9zx36YgVLDO9jJw+80BP0e_C92kYyq-ys=f8pBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gw52e9zx36YgVLDO9jJw+80BP0e_C92kYyq-ys=f8pBw@mail.gmail.com>

On Thu, Feb 29, 2024 at 04:18:50PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 12, 2024 at 5:16 PM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > The patchset introduces a new genetlink family bind/unbind callbacks
> > and thermal/netlink notifications, which allow drivers to send netlink
> > multicast events based on the presence of actual user-space consumers.
> > This functionality optimizes resource usage by allowing disabling
> > of features when not needed.
> >
> > Then implement the notification mechanism in the intel_hif driver,
> > it is utilized to disable the Hardware Feedback Interface (HFI)
> > dynamically. By implementing a thermal genl notify callback, the driver
> > can now enable or disable the HFI based on actual demand, particularly
> > when user-space applications like intel-speed-select or Intel Low Power
> > daemon utilize events related to performance and energy efficiency
> > capabilities.
> >
> > On machines where Intel HFI is present, but there are no user-space
> > components installed, we can save tons of CPU cycles.
> >
> > Changes v3 -> v4:
> >
> > - Add 'static inline' in patch2
> >
> > Changes v2 -> v3:
> >
> > - Fix unused variable compilation warning
> > - Add missed Suggested by tag to patch2
> >
> > Changes v1 -> v2:
> >
> > - Rewrite using netlink_bind/netlink_unbind callbacks.
> >
> > - Minor changelog tweaks.
> >
> > - Add missing check in intel hfi syscore resume (had it on my testing,
> > but somehow missed in post).
> >
> > - Do not use netlink_has_listeners() any longer, use custom counter instead.
> > To keep using netlink_has_listners() would be required to rearrange
> > netlink_setsockopt() and possibly netlink_bind() functions, to call
> > nlk->netlink_bind() after listeners are updated. So I decided to custom
> > counter. This have potential issue as thermal netlink registers before
> > intel_hif, so theoretically intel_hif can miss events. But since both
> > are required to be kernel build-in (if CONFIG_INTEL_HFI_THERMAL is
> > configured), they start before any user-space.
> >
> > v1: https://lore.kernel.org/linux-pm/20240131120535.933424-1-stanislaw.gruszka@linux.intel.com//
> > v2: https://lore.kernel.org/linux-pm/20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com/
> > v3: https://lore.kernel.org/linux-pm/20240209120625.1775017-1-stanislaw.gruszka@linux.intel.com/
> >
> > Stanislaw Gruszka (3):
> >   genetlink: Add per family bind/unbind callbacks
> >   thermal: netlink: Add genetlink bind/unbind notifications
> >   thermal: intel: hfi: Enable interface only when required
> >
> >  drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++----
> >  drivers/thermal/thermal_netlink.c | 40 +++++++++++--
> >  drivers/thermal/thermal_netlink.h | 26 +++++++++
> >  include/net/genetlink.h           |  4 ++
> >  net/netlink/genetlink.c           | 30 ++++++++++
> >  5 files changed, 180 insertions(+), 15 deletions(-)
> >
> > --
> 
> What tree is this based on?

v5: https://patchwork.kernel.org/project/linux-pm/list/?series=829159
it's on top of linux-pm master, but require additional net dependency,
which can be added by:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git for-thermal-genetlink-family-bind-unbind-callbacks
git merge FETCH_HEAD

and will be merged mainline in the next merge window.
So at this point would be probably better just wait for 6.9-rc1 
when the dependency will be in the mainline, before applying this set.

Regards
Stanislaw

