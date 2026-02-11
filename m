Return-Path: <linux-pm+bounces-42520-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLUpGjXZjGn8twAAu9opvQ
	(envelope-from <linux-pm+bounces-42520-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:32:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 812AD1272C3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE5913003BE4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 19:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD57734C134;
	Wed, 11 Feb 2026 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkGiJGQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF134EEF4
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838319; cv=none; b=B8W0zPZS7xRKM/P4rY9GsWUHKmRa1Tn6YjwRRO6+K0ez2AkKm+rODhSc9C9elTdlbencBllAZJ/wc+/mRzFCYm5Cirs5imlQxsSkELW46e4E/fWI8bTpaQKwtsJRVxznNsiRbC/sb6eIplvN2xaoXlofS8vkhHTC0wCn4k897Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838319; c=relaxed/simple;
	bh=jUjoENoUndtew7O3BVM9XBFh4LjX+GLO/B0sBJJpe08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5WcrUCfiCRaRE5Bacw57Vt/GchV5OMBxNINhBhPVPB6I063IuLw47y6kZPEPK5knDNdix8jFzhTx07N1zMjeh0h4pGHozgz1js2lw2DavnpvGqVGcjSGAXEi09TI/N+h1BXjeZxySvSX5AG8dhKphd3j1I11Ln+9IsSR2MyfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkGiJGQz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770838319; x=1802374319;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jUjoENoUndtew7O3BVM9XBFh4LjX+GLO/B0sBJJpe08=;
  b=OkGiJGQzSnlC9YVniu3UY9lM+NOBqzcB7LGMHzxVnTVpj5R1ajbsqR0T
   FcKvJPj1Aicbk+lYY5ASp3yEmFENjH/6od+jwaXSJxdzO/Dv2H7w679EJ
   00MPrOZDUq9RAmVOXCDL1i0eJmnV+MupWWdU/RFc+VXMYFBEoxP5FnSkY
   1WjA7hpVV/OnIoTk7yMvKvYcECB7QtZHTQK4yEcQFY6zMn/DA2hFthbVQ
   o09Q8QhaVuf6GSd0v0tqKGhY39u85K4xdBm2bj1TYL6OxqI4Ua/Pa328d
   +AJ+fuvHEXe2ThZjw2tU9vDpUbtwljcIrkGv7yVdNIG8u127MUIH8gfgf
   g==;
X-CSE-ConnectionGUID: PEMv+QraRqG3vCgx9OCVmg==
X-CSE-MsgGUID: o3JgTLGwSc2SHdIX3vRHYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71018252"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="71018252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 11:31:58 -0800
X-CSE-ConnectionGUID: yv7bn3OHTzabiAtgWfs3Lw==
X-CSE-MsgGUID: ZnIunyAhTuK0O88fTL30LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="216492638"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 11:31:58 -0800
Message-ID: <2027fb09d9966e9877dc9fee3027ba77dd298bc3.camel@linux.intel.com>
Subject: Re: [RESEND, Cc only] RE: [PATCH] thermal: int340x: Fix sysfs group
 leak on DLVR registration failure
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>, "rafael@kernel.org"	
 <rafael@kernel.org>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>,  "Zhang, Rui" <rui.zhang@intel.com>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Wed, 11 Feb 2026 11:31:57 -0800
In-Reply-To: <LV3PR11MB876881B77D32A2854AD2908EF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251215054538.3483331-1-kaushlendra.kumar@intel.com>
	 <LV3PR11MB876881B77D32A2854AD2908EF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42520-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 812AD1272C3
X-Rspamd-Action: no action

On Wed, 2026-02-11 at 08:23 +0000, Kumar, Kaushlendra wrote:
> Adding Cc: srinivas.pandruvada@linux.intel.com
>=20
> No code changes.
>=20
> Original patch:
> https://patchwork.kernel.org/project/linux-pm/patch/20251215054538.348333=
1-1-kaushlendra.kumar@intel.com/
>=20
> -----Original Message-----
> From: Kumar, Kaushlendra <kaushlendra.kumar@intel.com>=20
> Sent: Monday, December 15, 2025 11:16 AM
> To: rafael@kernel.org; daniel.lezcano@linaro.org; Zhang, Rui
> <rui.zhang@intel.com>; lukasz.luba@arm.com
> Cc: linux-pm@vger.kernel.org; Kumar, Kaushlendra
> <kaushlendra.kumar@intel.com>
> Subject: [PATCH] thermal: int340x: Fix sysfs group leak on DLVR
> registration failure
>=20
> When DLVR sysfs group creation fails in proc_thermal_rfim_add(), the
> function returns immediately without cleaning up the FIVR group that
> may have been created earlier.
>=20
> Add proper error unwinding to remove the FIVR group before returning
> failure.
>=20
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0.../thermal/intel/int340x_thermal/processor_thermal_rfim.c=C2=A0=C2=
=A0 | 5
> ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 589a3a71f0c4..ba88d878c998 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -466,8 +466,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev,
> struct proc_thermal_device *proc
> =C2=A0			break;
> =C2=A0		}
> =C2=A0		ret =3D sysfs_create_group(&pdev->dev.kobj,
> &dlvr_attribute_group);
> -		if (ret)
> +		if (ret) {
> +			if (proc_priv->mmio_feature_mask &
> PROC_THERMAL_FEATURE_FIVR)
> +				sysfs_remove_group(&pdev->dev.kobj,
> &fivr_attribute_group);
> =C2=A0			return ret;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	if (proc_priv->mmio_feature_mask &
> PROC_THERMAL_FEATURE_DVFS) {
> --
> 2.34.1

