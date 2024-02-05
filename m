Return-Path: <linux-pm+bounces-3388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261AD849974
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 13:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA30B27F27
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD219BA6;
	Mon,  5 Feb 2024 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaOtAxe0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A71AAC4;
	Mon,  5 Feb 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134455; cv=none; b=oY96SXFP+Os8LfpMFUeg4fxOIWruBuaoRpOwDObQfSw+liL13S6ZYo+HpuHKT9UA8XzmvbBxRpdQC/NzCEeeVxUewZTYOAwgGSj2KylUnPMNYrf6+3R2Ty6wDCVKPjUvPVap6avDuOYg55FTsh+QopNAjaepTOppM52gKzd815Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134455; c=relaxed/simple;
	bh=O0SdVH5ZDthg7KKYic6AJyf5Wj3+bbI/GxADCKpybx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7VupCp/cGyM83FMKUEazAY/6FEvUHI4TH1E8Z9rcO3tmW13QXatjzP9xfX0FZ81MCz7nVz+7dJUKryVfOl1l9cC+t+duSiGZA/gR8G99kP+31A2QAbLj/hBxaBvDsI0AZHhrQp9aF4yxxI8pSpetPd13b4auPsEykA4kH9vDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaOtAxe0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707134454; x=1738670454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0SdVH5ZDthg7KKYic6AJyf5Wj3+bbI/GxADCKpybx0=;
  b=OaOtAxe0X6sW/+y+3+xwWF9g2G1dwZyY262PBfLwYdhI4FSWWe5UmMs9
   bM8rK578fAx1ICFQr3TWlriba4c/a7dp7rC9ySmy4OzOHIxZsSJitFD+B
   oZBuIGf5Fjo3l2Cktzl2FKyO/8Wy3u5Z3ftY+epbk5Eo6tCtNGMdqxkM2
   nLiyMhj+iPFEB7169odjSawtO8O1U8z2RcpK3VVuzX1NvjzVNHp6VrR7N
   jJmnXm1GfWK0L1RfadXjIPFmsn4Nh0j3etKkbhrA1VWi1Gy/dTCiUSIiL
   qZIvDMlPIRf//2GZsPHot0vrEc6JXoFKV8EptaE7geYySV7k600o8Fi+1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="18032072"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="18032072"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="709702"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.97])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:00:48 -0800
Date: Mon, 5 Feb 2024 13:00:46 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <ZcDN7ovejiXe754i@linux.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
 <ZbzhuXbuejM1VLE3@nanopsycho>
 <Zbznft0x7DRWjUTQ@linux.intel.com>
 <Zb48Z408e18QgsAr@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb48Z408e18QgsAr@nanopsycho>

On Sat, Feb 03, 2024 at 02:15:19PM +0100, Jiri Pirko wrote:
> Fri, Feb 02, 2024 at 02:00:46PM CET, stanislaw.gruszka@linux.intel.com wrote:
> >On Fri, Feb 02, 2024 at 01:36:09PM +0100, Jiri Pirko wrote:
> >> Wed, Jan 31, 2024 at 01:05:35PM CET, stanislaw.gruszka@linux.intel.com wrote:
> >> 
> >> [...]
> >> 
> >> 
> >> >+static int hfi_netlink_notify(struct notifier_block *nb, unsigned long state,
> >> >+			      void *_notify)
> >> >+{
> >> >+	struct netlink_notify *notify = _notify;
> >> >+	struct hfi_instance *hfi_instance;
> >> >+	smp_call_func_t func;
> >> >+	unsigned int cpu;
> >> >+	int i;
> >> >+
> >> >+	if (notify->protocol != NETLINK_GENERIC)
> >> >+		return NOTIFY_DONE;
> >> >+
> >> >+	switch (state) {
> >> >+	case NETLINK_CHANGE:
> >> >+	case NETLINK_URELEASE:
> >> >+		mutex_lock(&hfi_instance_lock);
> >> >+
> >> 
> >> What's stopping other thread from mangling the listeners here?
> >
> >Nothing. But if the listeners will be changed, we will get next notify.
> >Serialization by the mutex is needed to assure that the last setting will win,
> >so we do not end with HFI disabled when there are listeners or vice versa.
> 
> Okay. Care to put a note somewhere?

I would if the flow would stay the same. But it was requested by Jakub to use
netlink bind/unbind, and this will not work the way described above any longer,
since bind() is before listeners change and unbind() after:

                if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
                        err = nlk->netlink_bind(sock_net(sk), val);
                        if (err)
                                return err;
                }
                netlink_table_grab();
                netlink_update_socket_mc(nlk, val,
                                         optname == NETLINK_ADD_MEMBERSHIP);
                netlink_table_ungrab();
                if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
                        nlk->netlink_unbind(sock_net(sk), val)

To avoid convoluted logic or new global lock, I'll use properly protected
local counter increased on bind and decreased on unbind.

Regards
Stanislaw

