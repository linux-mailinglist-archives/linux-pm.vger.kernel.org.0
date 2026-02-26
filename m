Return-Path: <linux-pm+bounces-43234-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOLbI7X9n2n3fAQAu9opvQ
	(envelope-from <linux-pm+bounces-43234-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 09:00:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43D1A231E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 09:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A13302EE8D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736E392C33;
	Thu, 26 Feb 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGCKaC/4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9C392C25;
	Thu, 26 Feb 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092773; cv=none; b=ELXEAoGMApfXQ/AMTwF/bx8CteUkt/ZpegFob+mZSMYziI6wHF0F1goHGgOXc1vm9cc8FP/keOshqyTu193BuWBoRdS+FkXEzFtVdz9DSfBq64Ze1nb9XnHEyZbLjvI/oHDUuK2kxkqcUps5zr72KoIT8Ef3AXlPDjeOJiHG9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092773; c=relaxed/simple;
	bh=rs0qEAZbdxZqApzkbG0FHEalQVhLZ+XgQWmJpEIvOnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocrEaihzW9hXAhYrWz8g7DN9mKyJ9680dE7kDYYh6IgBx1YWXpxWuMx3wPtFruT6dysXC/Gk5fhxCWtS15GV4a5bCgChvAVyXTUIrt7vJcD1vuqrJ9SskuHHLaqnwunezY0qrVTxB1/IsaOPl7gvRpsGskDCFyY75Gf3AyYoe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGCKaC/4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772092771; x=1803628771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rs0qEAZbdxZqApzkbG0FHEalQVhLZ+XgQWmJpEIvOnc=;
  b=BGCKaC/4Y/7r2QjozsOIM8/GJiwHkczy4z1Pyq74VsATwUzok/6mjejx
   lg0Rt/7dpletnSQsY3UQs4ZEqOhzIwFSk7zA/EntThZ29XZJQxAtooTTL
   ozy/d8EdYtfLsc90h1Eq1yV+CzCEj8K8GhzkW+h/8WGXQbjKggmHyjPmN
   FoRfqH6aIp94d9PcU/fRLfmoJDWYvxRIRyj++aDb/MOQFw9HN0n1JGnIG
   pcDT1Yagj9oRLqIIuaGiWyJ9NRRyVdZqpO9sgGpGNb6XqAmnP5lPKwvYS
   QUO9SrIerbfPxinuXGcf+pXvXD9kWq2tqsi39XHZDoaZDGuYBynyCyFsB
   g==;
X-CSE-ConnectionGUID: LYEW1837SVO1RU7MM+Kzfw==
X-CSE-MsgGUID: TP2nw6Y9R12xbKscDpOgjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73018073"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73018073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:59:30 -0800
X-CSE-ConnectionGUID: HXHY4jaTS763fk0dqYE34Q==
X-CSE-MsgGUID: n89NMNHmQ2uMu7evv5CMDQ==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 25 Feb 2026 23:59:20 -0800
Date: Thu, 26 Feb 2026 15:39:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Antoine Tenart <atenart@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Yury Norov <yury.norov@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
	hariprasad <hkelam@marvell.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 09/12] fpga: m10bmc-sec: switch show_canceled_csk() to
 using scnprintf()
Message-ID: <aZ/4whL40HHi/85Z@yilunxu-OptiPlex-7050>
References: <20260219181407.290201-1-ynorov@nvidia.com>
 <20260219181407.290201-10-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219181407.290201-10-ynorov@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43234-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: DA43D1A231E
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 01:14:01PM -0500, Yury Norov wrote:
> Switch show_canceled_csk() to use a more common scnprintf("%*pbl").
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 10f678b9ed36..5ae76b8ece18 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
>  
>  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
>  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> +	return scnprintf(buf, rest_of_page(buf), "%*pbl\n", CSK_BIT_LEN, csk_map);

As Thomas mentioned, use sysfs_emit()

>  }
>  
>  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> -- 
> 2.43.0
> 
> 

