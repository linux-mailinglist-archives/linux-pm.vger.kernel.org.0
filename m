Return-Path: <linux-pm+bounces-1615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC88881EFF3
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 17:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2396B21639
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356B45957;
	Wed, 27 Dec 2023 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMwbEgaK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBC446C7
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703692877; x=1735228877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+o6Pd7GFeTeXJG2bGDb5fztwWxrinKzv0ConS7PnoE=;
  b=hMwbEgaKdQM5d14PHYiyhof1acXhDAjQNDRWfhKg/CXdKsTtg9JFVXWc
   FvJiKGMj3TMpnIfmJLPo3GN3Y1N2dB+bugM+bAI6+JvLvowRHGWwr6jAR
   1liclJGad+7qhCDQpU0dOSnd0P+nh6R7J96nQx9ljpwROn0uC/Pte0xfZ
   KopPZK/aSObLJ8owRP3Hk1SewJ5BkKFOuGOhqSZmjj8yumfjmm9fip3CC
   7Pe62F1LRlECI9t9fOdhuHTP1V4xWS6fsBNrXrr/nAR4uv8xaRHIatDNd
   qBO8Rs4do0Eyw81QhhrHVoRaT++XeiR8Is//7SxmIcnD1E2xXyotXDXTK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427628823"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="427628823"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:01:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="778269150"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="778269150"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.181])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:01:14 -0800
Date: Wed, 27 Dec 2023 17:01:11 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: netlink: Add thermal_group_has_listeners()
 helper
Message-ID: <ZYxKR5P0emZfFdUo@linux.intel.com>
References: <20231227140057.174314-1-stanislaw.gruszka@linux.intel.com>
 <20231227140057.174314-2-stanislaw.gruszka@linux.intel.com>
 <ZYwwdz2XabAuCv4y@mai.linaro.org>
 <ZYxDV3QV4gGHoT/W@linux.intel.com>
 <7f1d54e4-5f33-41b2-8f85-b18c3abc84e9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1d54e4-5f33-41b2-8f85-b18c3abc84e9@linaro.org>

On Wed, Dec 27, 2023 at 04:40:31PM +0100, Daniel Lezcano wrote:
> On 27/12/2023 16:31, Stanislaw Gruszka wrote:
> > Hi Daniel,
> > 
> > On Wed, Dec 27, 2023 at 03:11:03PM +0100, Daniel Lezcano wrote:
> > > > +static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
> > > > +{
> > > > +	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
> > > > +}
> > > > +
> > > >   /************************** Sampling encoding *******************************/
> > > >   int thermal_genl_sampling_temp(int id, int temp)
> > > > @@ -83,6 +88,9 @@ int thermal_genl_sampling_temp(int id, int temp)
> > > >   	struct sk_buff *skb;
> > > >   	void *hdr;
> > > > +	if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
> > > > +		return -ESRCH;
> > > > +
> > > 
> > > Do really want to return an error ? Shall we just bail out instead ?
> > 
> > I decided for error because thermal_notify_* are int functions and we
> > return error code for some other cases when the messages can not be
> > sent (i.e. alloc error).
> > Event if currently return value is ignored by all callers (FWICT),
> > error information could be used theoretically.
> > 
> > If returning 0 is preferable/better, I can change that.
> 
> The caller will have to handle the specific case if there is no listeners.
> There is an error if the message can not be sent but here there is no error
> related to that, just we don't send it. So having an error when there is
> nothing to do is not really an error.

Ok, will change to 0 in v2.

Regards
Stanislaw

