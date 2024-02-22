Return-Path: <linux-pm+bounces-4280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2285FCEF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A929628CFAB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA23414AD14;
	Thu, 22 Feb 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7v7TkIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3914AD30;
	Thu, 22 Feb 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616846; cv=none; b=cw26SAU7ODgwyGz9xk13zB0I9AoPPzfFXI6xaTGd9tvlFqN50WVJTVVRnycx+WqoZxPh6GmaPgDrEO53cRMHkeZdMG6o4qNCtIZ1+HX2XOccfKHUZ6zA+5wFswxWWxCYKo+g43sC4k9XudyhBU7GamQoc1njYxDxWoPJrTACiMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616846; c=relaxed/simple;
	bh=Md4in/HQ6lUKnOOyLDQIjm6+ZUBjqPPwCh2NiQF13q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owDHaVpqeb62iC384CwacLTYkxg1BwS5xGYP91zflCRkvty/+tQQYkmdhrev+KLQIJcWgs2Ekpu2mKRzGC51DAmst2Ihaya9C2Cv3irYWOslMrdzBvYa1XXHv9gDEiVRtYOOTxKmuiG1VhR2Mmh1Jo0wC7g17uVf/WGJukJb8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7v7TkIZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708616846; x=1740152846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Md4in/HQ6lUKnOOyLDQIjm6+ZUBjqPPwCh2NiQF13q8=;
  b=O7v7TkIZ21lvkzrOOydJaVXbb0xOmd3EeYe+Jom9CwxQ8WkcJTgxjv7g
   aaSFvxf4rYGuvOx6pxRA4IC2BCxncMHiAhGsMxFK4RfK9IS18ve3kx4Yw
   KvTAXlDEdliEHxv/sc5QbqLY6maRna6MXkiMF09sq5MI2RYlDiTcPS/qO
   jm+/GjzDXvnl446GhvdW9vSHF13oLD70GQ3v6Fd1/+XoyBwyW88gxY+oE
   BzOuqIEuEfL5XsjeALXF585mULSI1GYcbji8h0mfEyfOZ/Y+vPtg3Xulv
   CZOEY6H1tKY3R4vYNPhbB4auL9N/CiIIZleXTewU8GYKKH5TfLh2w+0QV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2764323"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2764323"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:47:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5908495"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.46.166])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:47:21 -0800
Date: Thu, 22 Feb 2024 16:47:18 +0100
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
Subject: Re: [PATCH v4 2/3] thermal: netlink: Add genetlink bind/unbind
 notifications
Message-ID: <ZddshlCHwsDTFSYL@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <20240212161615.161935-3-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0hTsXjre_StGizrmUx1JUkzKr9K9KLiHrsvicivMO2Odw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hTsXjre_StGizrmUx1JUkzKr9K9KLiHrsvicivMO2Odw@mail.gmail.com>

On Tue, Feb 13, 2024 at 02:24:56PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 12, 2024 at 5:16 PM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > Introduce a new feature to the thermal netlink framework, enabling the
> > registration of sub drivers to receive events via a notifier mechanism.
> > Specifically, implement genetlink family bind and unbind callbacks to send
> > BIND and UNBIND events.
> >
> > The primary purpose of this enhancement is to facilitate the tracking of
> > user-space consumers by the intel_hif driver.
> 
> This should be intel_hfi.  Or better, Intel HFI.

Will change in next revision.

> > By leveraging these
> > notifications, the driver can determine when consumers are present
> > or absent.
> >
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > ---
> >  drivers/thermal/thermal_netlink.c | 40 +++++++++++++++++++++++++++----
> >  drivers/thermal/thermal_netlink.h | 26 ++++++++++++++++++++
> >  2 files changed, 61 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> > index 76a231a29654..86c7653a9530 100644
> > --- a/drivers/thermal/thermal_netlink.c
> > +++ b/drivers/thermal/thermal_netlink.c
> > @@ -7,17 +7,13 @@
> >   * Generic netlink for thermal management framework
> >   */
> >  #include <linux/module.h>
> > +#include <linux/notifier.h>
> >  #include <linux/kernel.h>
> >  #include <net/genetlink.h>
> >  #include <uapi/linux/thermal.h>
> >
> >  #include "thermal_core.h"
> >
> > -enum thermal_genl_multicast_groups {
> > -       THERMAL_GENL_SAMPLING_GROUP = 0,
> > -       THERMAL_GENL_EVENT_GROUP = 1,
> > -};
> > -
> >  static const struct genl_multicast_group thermal_genl_mcgrps[] = {
> 
> There are enough characters per code line to spell "multicast_groups"
> here (and analogously below).

Not sure what you mean, change thermal_genl_mcgrps to thermal_genl_multicast_groups ?

I could change that, but it's not really related to the changes in this patch,
so perhaps in separate patch.

Additionally "mcgrps" are more consistent with genl_family fields i.e:

      .mcgrps         = thermal_genl_mcgrps,
      .n_mcgrps       = ARRAY_SIZE(thermal_genl_mcgrps), 

> >         [THERMAL_GENL_SAMPLING_GROUP] = { .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
> >         [THERMAL_GENL_EVENT_GROUP]  = { .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
> > @@ -75,6 +71,7 @@ struct param {
> >  typedef int (*cb_t)(struct param *);
> >
> >  static struct genl_family thermal_gnl_family;
> > +static BLOCKING_NOTIFIER_HEAD(thermal_gnl_chain);
> 
> thermal_genl_chain ?
> 
> It would be more consistent with the rest of the naming.

Ok, will change. Additionally in separate patch thermal_gnl_family for consistency.

> >  static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
> >  {
> > @@ -645,6 +642,27 @@ static int thermal_genl_cmd_doit(struct sk_buff *skb,
> >         return ret;
> >  }
> >
> > +static int thermal_genl_bind(int mcgrp)
> > +{
> > +       struct thermal_genl_notify n = { .mcgrp = mcgrp };
> > +
> > +       if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
> > +               return -EINVAL;
> 
> pr_warn_once() would be better IMO.  At least it would not crash the
> kernel configured with "panic on warn".

"panic on warn" is generic WARN_* issue at any place where WARN_* are used.
And I would say, crash is desired behaviour for those who use the option
to catch bugs. And mcgrp bigger than THERMAL_GENL_MAX_GROUP is definitely
a bug. Additionally pr_warn_once() does not print call trace, so I think
WARN_ON_ONCE() is more proper. But if really you prefer pr_warn_once()
I can change.

Regards
Stanislaw

