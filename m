Return-Path: <linux-pm+bounces-43958-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LI5A3LvrmlcKgIAu9opvQ
	(envelope-from <linux-pm+bounces-43958-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 17:04:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7023C636
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 17:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1035B30DFF02
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAA93DA7DA;
	Mon,  9 Mar 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/Lp6mwm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DF3DA5A7;
	Mon,  9 Mar 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071835; cv=none; b=tlaNIJtWxjCEz+OX9c6oNQHQFKuf7ihPbjp1B01LUrmM4C/KJlbTPp12D2GSYr0v6cePTBxeyxp1LcI3xtYzlzMxQs26mTWzzPzTHxg+ji9Y2CPKHZo93jCfaoHUCfkNreqNC76z2WoAL12Eqpn5zXgvK942puznvC0CGuWvImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071835; c=relaxed/simple;
	bh=WkP8D/+DmWa2bPrWBRz+P4aEOSxGB9ZAWYEQjedEVU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzMuq5sjNmeAGBp7rxmBeQ9rxTUQtlxOwYziSB0ztyfs8A4Nyke0qgir+rLDfeUZEUfd+O3+UAzaQbJ/YanMxhNlA2t8zGfNwb2APw/hllc3bRrpBEq5gYeKWoiPDEmgD+ThAR5/rVzuzMRXG8vgfBJOnNic/RajKiGk2a2PlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/Lp6mwm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773071835; x=1804607835;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WkP8D/+DmWa2bPrWBRz+P4aEOSxGB9ZAWYEQjedEVU4=;
  b=b/Lp6mwmTszZuiJeapqBRQceblC0fTW6Q1fXTb6SV+FlZAB6C5CTYcqg
   maLD9MtoJb43CJ6DWUWop0DlQVRap94aMSU3Ey0RYCh0hpFSIEd9lsG9d
   n7Pj0KdRciDn2dy4Pi2QWHoZfEOBOHHorEcLovCvRPAhuPum6AAWMVDYk
   zeJzBBXc4Ghd22MkzFwCe1Z6o4CSKAL/+G4V1F7PCyilMy6TgaOIonvN6
   TENAaa2ctjXWMgZ+cUeEThRkzJ5xsz9tFq4O0EQE7cZY6Ocal/aUAVdli
   zbnw6PrPLoSVSfetLn4/+Lsfa0xCX2qilWUFtvyCo1QL6Pw0crJhfBebR
   A==;
X-CSE-ConnectionGUID: SWs17jaHQsmUBziJvh7vRQ==
X-CSE-MsgGUID: dU+iBjeVR+GDWbzeGYPhEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73977314"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73977314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:57:13 -0700
X-CSE-ConnectionGUID: Jlxx9/t9T9OUujXdfVpxRA==
X-CSE-MsgGUID: ZlRHbHJETdqLt8KLfzsrIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219937234"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:57:13 -0700
Message-ID: <42e71412208dcb6fc75bf5b606bd2ec0f0eaa21e.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] x86/cpu: P-state support for Lightning Mountain
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Martin Schiller <ms@dev.tdt.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Thomas Gleixner	 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Eckert	
 <fe@dev.tdt.de>
Date: Mon, 09 Mar 2026 08:57:13 -0700
In-Reply-To: <3e828b47bacf84ca8d19a024ac71778c@dev.tdt.de>
References: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
	 <CAJZ5v0jR0eVu2oCD+c0x9MERfYvdPfNi2T9YZrO9RLQf-+iH3A@mail.gmail.com>
	 <3e828b47bacf84ca8d19a024ac71778c@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5DE7023C636
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-43958-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 07:53 +0100, Martin Schiller wrote:
> On 2026-03-06 18:59, Rafael J. Wysocki wrote:
> > On Fri, Mar 6, 2026 at 9:27=E2=80=AFAM Martin Schiller <ms@dev.tdt.de>
> > wrote:
> > >=20
> > > This patch set contains 2 commits to get P-state support for
> > > Intel /
> > > MaxLinear Lightning Mountain. The first adds the needed code to
> > > the
> > > intel_pstate driver. The second adds a workaround to the x86/cpu
> > > subsystem to enable EIST on all cpus.
> >=20
> > Can you please combine the patches?
> >=20
> > Or does the first one work just fine without the second one?
>=20
> Well, the first patch can basically be applied without the second
> one,
> but then frequency stepping will only work on the first cpu core.
>=20
> I split the two changes because they apply to different parts of the
> kernel sources.
>=20
> But you're probably right, and it makes sense to combine the two
> patches.
>=20
>=20
> BTW: The original code from the MaxLinear SDK enables EIST in the
> intel_pstate driver, but I don't think that's the right place for it.

This is a special case. But intel_pstate driver can be disabled from
kernel command line to use acpi cpufreq driver. So in that case
enabling in intel_pstate will not help.

Thanks,
Srinivas

