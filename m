Return-Path: <linux-pm+bounces-42939-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNroG4xlmGmJHgMAu9opvQ
	(envelope-from <linux-pm+bounces-42939-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 14:45:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF5167FF4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF36C3025916
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50A7348465;
	Fri, 20 Feb 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8mwEc1C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7C347BB9;
	Fri, 20 Feb 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594991; cv=none; b=Pfb5CNnRsxptLqiMzjiOSN5PBie61bhJHMdAY1Gk+C3A7KbAHF5zPREW/N1pHLl9Z4P665zcPkAje8FVAPPL1hPfuIIVULJv5p+etyftJFa1gQfZ6KsqKXRXS4cEi9qOxL0NR+p1LMxSiO5L7M0vP+rL1CVHwnl+Y7CvUeX8Zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594991; c=relaxed/simple;
	bh=J/CnWjz0/XEWMkvW599pnkojtxcOQdayQ/SGTMGqFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbFnaQ4++9VRgSuQ0TQERFwBi3TrNZbB+sfHyXZg8+msV+I6wJVSratJODj6Ml8zsDSx1nnA4aNJynrT5oRQ2k4tQuP2MAHhi+3qXR0dWvIquA36KbVjZaR1KYZSv456cLq/BykNMrGYS+IzNAw8/OC/XJAqux1O5E9W6AtWuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8mwEc1C; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771594990; x=1803130990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J/CnWjz0/XEWMkvW599pnkojtxcOQdayQ/SGTMGqFmE=;
  b=K8mwEc1CepglGtnHdqd3tYQnouZra5ZClO+dtXm+6yuJ0AhWV1ycX5KB
   /S/7yr/wBC0wMvUTHspgU3D1urnOgKY/aYJ3OROId54gORsOW1tXHb0IW
   bApHk33SP/ZJL6EGRXcvJ0vAg3OXY0wG4BfUnCkt+eKhjj96sMx7WJ6YY
   5yv/RdQ47gEsf90aLHm/RE1mAhDBm/K1eXLbj0rJWaZSzKryGJztDNlNQ
   +90NBpypac9Ac+4UOV1eFK7bjEGitDcpyMxxexlaTdcX0MGCvb4rq/dvZ
   wLiDZT7hWzz0ZzFh2F5EeqvFYGOpQVhiHlzy+bhb350vkDKVAgqCaKbpA
   g==;
X-CSE-ConnectionGUID: mGDzl+8iQQCUUX38jdFOeQ==
X-CSE-MsgGUID: Rv+nk2dMQYa2DcsXCf5U1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="95306368"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="95306368"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:43:09 -0800
X-CSE-ConnectionGUID: 01Gs0n/1RLC3lsYNqVo0lQ==
X-CSE-MsgGUID: PCNeRVOUQ3e/9I+1NA/6FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219855760"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:43:04 -0800
Date: Fri, 20 Feb 2026 15:43:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jens Reidel <adrian@mainlining.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] thermal/drivers/generic-adc: Allow probe without
 TZ registration
Message-ID: <aZhk5Qn0vJmtxbtG@smile.fi.intel.com>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-3-fe34ed4ea851@fairphone.com>
 <aZg8ZqckhGbvkdel@smile.fi.intel.com>
 <DGJR7OIPI2ZS.ZTJ1IJWB3Z61@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGJR7OIPI2ZS.ZTJ1IJWB3Z61@fairphone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42939-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,smile.fi.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0EF5167FF4
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 12:31:36PM +0100, Luca Weiss wrote:
> On Fri Feb 20, 2026 at 11:50 AM CET, Andy Shevchenko wrote:
> > On Fri, Feb 20, 2026 at 10:19:07AM +0100, Luca Weiss wrote:

...

> >> Since the driver is now also registering as an IIO device[0], allow the
> >> probe to continue without the thermal zone.
> >
> > Isn't it dangerous?

> Why?

Just asking to see if haven't missed anything potentially dangerous for HW
at run-time.

> The idea is that generic-adc-thermal is the middleman to convert
> from one IIO input to one IIO output, and is purely informational, so
> that user space can get some temperature value to display somewhere.
> 
> How thermal management will be hooked up in the future to charger
> drivers is a bit out of scope here I'd say. There's not even any cooling
> support in the power supply core anymore, that was ripped out a while
> ago if I'm not mistaken.

Okay, so there is no possibility to get some thermal issues on running
legacy HW (that relies on thermal to be present). If it's the case, no
worries then.

-- 
With Best Regards,
Andy Shevchenko



