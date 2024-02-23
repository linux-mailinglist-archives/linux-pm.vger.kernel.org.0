Return-Path: <linux-pm+bounces-4350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB49861B8C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 19:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FF31C22BC4
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9713F00B;
	Fri, 23 Feb 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbAZS13H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A012BE83
	for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712793; cv=none; b=WaE4tzjumVZHFe5lKXytpNgorlL34aFJs8OKeNnyfER7/mIlXaB133dcCT/DGJEkpk4U4BIgffxySuIa6Z89dj/2NC7tkGha7JIXkKBztIYo92GK6RwJ9io677XxvJ8WdJgcSApsSbpeUErXt46IaRVPaomnL9Jdsd1cIIdYyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712793; c=relaxed/simple;
	bh=2WkvgJMrdc2BL3LK7Dwe97PYd6AE58RjzA6SZMeaw/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tE8Dqa63hYINtg9AtAgKaDzp6Idi43lxF7DTQdL8yIoeHc83QJSJbMECOD1YFUm7HadZtiPKAAqSDqMH2DQTy3lfnYv4uAn7eP8sM3gnQkb1jHqX9Vsposzeq1Agjizsk7Aq0jSrcCnnxE33czW/M8/6Cq4bR+BUgqtDuDyQOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbAZS13H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708712791; x=1740248791;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2WkvgJMrdc2BL3LK7Dwe97PYd6AE58RjzA6SZMeaw/o=;
  b=jbAZS13HQJlEj4rOFKiOlZAdXEOfqiMWMmgLmTSg9dIqZfyx10izwwkQ
   pggSEtrkcnjxHf0j7dabR3kkE3zLue8DChAmY3kINLC0Rv9AO4FrFBgZW
   +6pgHT8S9T4mjQAtYpPTUjgFe+0UaVIiWEEK8sknruqkX+yjUs8ZMpsms
   9QzCBbpc/yVczzaJELhRvFGqzIdNHLUVOzHrDaZ+78m+R1g4AWLzn8+1q
   wSDjGDc0c++6e84PUIDpEJpt+JsfxBPOUj8BR6d8qLpF2mmTaiv5HPNu4
   ZLxjDfKN95JC5ABRWxcr4BCTPvxYlVIOroJGdibXNoIhbw8ptLxuW1qhD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="5989698"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5989698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 10:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6463178"
Received: from anwespi-mobl1.amr.corp.intel.com (HELO [10.213.185.77]) ([10.213.185.77])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 10:26:24 -0800
Message-ID: <7e118d890e1907fa19021e4c20cd2a4b76d2be77.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature
 only when required
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri
	 <ricardo.neri-calderon@linux.intel.com>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>
Date: Fri, 23 Feb 2024 13:26:22 -0500
In-Reply-To: <20240223155942.60813-1-stanislaw.gruszka@linux.intel.com>
References: <20240223155942.60813-1-stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Your heading version is not correct:

It should be
 "[PATCH v5 0/3] thermal/netlink/intel_hfi: Enable HFI feature only
when required"

Not "[PATCH v4.."

Thanks,
Srinivas

On Fri, 2024-02-23 at 16:59 +0100, Stanislaw Gruszka wrote:
> The patchset is based on
>=20
> =C2=A0https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
> =C2=A0for-thermal-genetlink-family-bind-unbind-callbacks
>=20
> and implement genetlink family bind/unbind callbacks in thermal-
> netlink and
> add notifications to thermal subdrivers. Those willh allow drivers to
> send
> netlink multicast events based on the presence of actual user-space
> consumers.
> This functionality optimizes resource usage by allowing disabling
> of features when not needed.
>=20
> Then implement the notification mechanism in the intel_hif driver,
> it is utilized to disable the Hardware Feedback Interface (HFI)
> dynamically. By implementing a thermal genl notify callback, the
> driver
> can now enable or disable the HFI based on actual demand,
> particularly
> when user-space applications like intel-speed-select or Intel Low
> Power
> daemon utilize events related to performance and energy efficiency
> capabilities.
>=20
> On machines where Intel HFI is present, but there are no user-space
> components installed, we can save tons of CPU cycles.
>=20
> Changes v4 -> v5:
>=20
> - Fix hif vs. hfi in the changelog
> - Rename thermal_gnl_chain
> - Add new patch with rename of thermal_gnl_family
> - Fix syscore concurrency comment
> - Remove unneeded hfi_instance variable
> - Rename hfi_do_enable/disable
> - Avoid multiple enabling=20
> - Add comment about registering for events before they can be
> generated
> - Rename hfi_thermal_clients_num since later there will be KVM
> clients
>=20
> Changes v3 -> v4:
>=20
> - Add 'static inline' in patch2
>=20
> Changes v2 -> v3:
>=20
> - Fix unused variable compilation warning
> - Add missed Suggested by tag to patch2
> =C2=A0
> Changes v1 -> v2:
>=20
> - Rewrite using netlink_bind/netlink_unbind callbacks.
>=20
> - Minor changelog tweaks.
>=20
> - Add missing check in intel hfi syscore resume (had it on my
> testing,
> but somehow missed in post).
>=20
> - Do not use netlink_has_listeners() any longer, use custom counter
> instead.
> To keep using netlink_has_listners() would be required to rearrange=20
> netlink_setsockopt() and possibly netlink_bind() functions, to call=20
> nlk->netlink_bind() after listeners are updated. So I decided to
> custom
> counter. This have potential issue as thermal netlink registers
> before
> intel_hif, so theoretically intel_hif can miss events. But since both
> are required to be kernel build-in (if CONFIG_INTEL_HFI_THERMAL is
> configured), they start before any user-space.
>=20
> v1:
> https://lore.kernel.org/linux-pm/20240131120535.933424-1-stanislaw.gruszk=
a@linux.intel.com//
> v2:
> https://lore.kernel.org/linux-pm/20240206133605.1518373-1-stanislaw.grusz=
ka@linux.intel.com/
> v3:
> https://lore.kernel.org/linux-pm/20240209120625.1775017-1-stanislaw.grusz=
ka@linux.intel.com/
> v4:
> https://lore.kernel.org/linux-pm/20240212161615.161935-1-stanislaw.gruszk=
a@linux.intel.com/
>=20
>=20
> *** BLURB HERE ***
>=20
> Stanislaw Gruszka (3):
> =C2=A0 thermal: netlink: Add genetlink bind/unbind notifications
> =C2=A0 thermal: netlink: Rename thermal_gnl_family
> =C2=A0 thermal: intel: hfi: Enable interface only when required
>=20
> =C2=A0drivers/thermal/intel/intel_hfi.c | 97 ++++++++++++++++++++++++++++=
-
> --
> =C2=A0drivers/thermal/thermal_netlink.c | 62 +++++++++++++++-----
> =C2=A0drivers/thermal/thermal_netlink.h | 26 +++++++++
> =C2=A03 files changed, 161 insertions(+), 24 deletions(-)
>=20


