Return-Path: <linux-pm+bounces-1613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D476A81EFC8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 16:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7709BB212FD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199545961;
	Wed, 27 Dec 2023 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5YCDlrm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EF45947
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703691100; x=1735227100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+PmKG0wOX7BUp9XCJiIt46UJW1qKHvvAMlG90QnOTys=;
  b=h5YCDlrmeGSvKtI6oQplRpdYsa5hRmvjWMpZZMobBUBBBgFQPbtFXRiB
   Qvm4nzbcHZQ9OJgaOcrcqjZTfw4c4vKPBKJogephotqkd7Nfmxrw0Vhn9
   XkBIF0argMHRQfmS+yNHxnEmNfcXRH8zKVK1IbtUaES7KcwpkkDuQPzaW
   gjGZLo060tDr4Cg0L0kPDwZPsOacB8nK9wIgtJok6OnOuKSEW0wTrH9Ko
   msEDAwDUizkGtipLJXEK+J+MCengvZfIBxOgjGzWs+PNpRRlg2/2FYxVa
   5+eAciCsOf7+Tm30TzntvACxJQQxSvzsqtnvEUSk35Bxm26bfLt15Jkq5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="399240511"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="399240511"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 07:31:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1025417959"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="1025417959"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.181])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 07:31:37 -0800
Date: Wed, 27 Dec 2023 16:31:35 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: netlink: Add thermal_group_has_listeners()
 helper
Message-ID: <ZYxDV3QV4gGHoT/W@linux.intel.com>
References: <20231227140057.174314-1-stanislaw.gruszka@linux.intel.com>
 <20231227140057.174314-2-stanislaw.gruszka@linux.intel.com>
 <ZYwwdz2XabAuCv4y@mai.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYwwdz2XabAuCv4y@mai.linaro.org>

Hi Daniel,

On Wed, Dec 27, 2023 at 03:11:03PM +0100, Daniel Lezcano wrote:
> > +static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
> > +{
> > +	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
> > +}
> > +
> >  /************************** Sampling encoding *******************************/
> >  
> >  int thermal_genl_sampling_temp(int id, int temp)
> > @@ -83,6 +88,9 @@ int thermal_genl_sampling_temp(int id, int temp)
> >  	struct sk_buff *skb;
> >  	void *hdr;
> >  
> > +	if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
> > +		return -ESRCH;
> > +
> 
> Do really want to return an error ? Shall we just bail out instead ?

I decided for error because thermal_notify_* are int functions and we
return error code for some other cases when the messages can not be
sent (i.e. alloc error).
Event if currently return value is ignored by all callers (FWICT),
error information could be used theoretically. 

If returning 0 is preferable/better, I can change that.

Regards
Stanislaw

