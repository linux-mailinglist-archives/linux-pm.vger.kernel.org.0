Return-Path: <linux-pm+bounces-42535-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEfOIlsnjWlOzgAAu9opvQ
	(envelope-from <linux-pm+bounces-42535-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 02:05:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56EE128C5B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 02:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6A230B0FE5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF58405C;
	Thu, 12 Feb 2026 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebAb3zVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627D18AFD;
	Thu, 12 Feb 2026 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858160; cv=none; b=PQhACfR4uk/To9vm47l7nxyJ2MczuJRt0g6zpMQbW49oy+Lh2L4DNUZ/IB94xAf69Ina1yiqbwCp5M2A2PYSM7Cocypt+JheAH53ogyrnvQaVmlI0QvTxjpnahpVw1CJHjY1m/ib45ctU2w9fjz02pvIluzaOndG9fmyvKjPmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858160; c=relaxed/simple;
	bh=Vuc/g5n1fUCA+bCinhAqUXWUdfl52uU+nfuIIunGGEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwknA6JApfpCiLNfwHREvCr8m3YqdgcLL6KvO+XzPEG3S6v+kWDiUU1Fht8jSFwb3AOcA+3ze4weQslQTi38IIbFHhk4PdP9uP4J+l7zyha3bip8IiFkJ/i9U4r5zcA9PeCbLkxYfJRlhF9vDfDg8kQVyzU1ISMYg0sZxkaqTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebAb3zVK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770858158; x=1802394158;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Vuc/g5n1fUCA+bCinhAqUXWUdfl52uU+nfuIIunGGEc=;
  b=ebAb3zVKeWt7/4I8CXSje+c/2Bua/V896BZF4cSx6Sp7dXIueBEnHMPc
   e3a6+1JY+V2xIugGUB3pE+GRjbY4HSNdqwhAjVFNQ/IjhPG9BwYFFUQmm
   4663sVm3zn+UPJnuyg9oxQTwe71MOz9pQlZTV0AT8CZUav8HIFdZOf+Lf
   Ptr3YqCXFWdu9yTRgvYVF+CYLAZEPu5cxktxVwBHB1h5CLCOpy1DzRzmM
   OtDdy9VQPaQoljJ0GLAVARZAcdzIb02+TjfLHIWgaIm0YKq+fPstmbdby
   qmZTCR3fs4305J0j9vLHOzQZjBSxrDlPn1ERCqSggun3MnY36TeeA9JkZ
   A==;
X-CSE-ConnectionGUID: xba4Pa45SH+KTOoj1A15Kg==
X-CSE-MsgGUID: fspgPeK7Qxi3fLPBLnUzKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71045220"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="71045220"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 17:02:37 -0800
X-CSE-ConnectionGUID: 1By/JMSMQF2EOFfgOTR8Fw==
X-CSE-MsgGUID: XMN56S7hTbaswW/DrhzX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="235395864"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 17:02:37 -0800
Message-ID: <42845834adf97303b19f421965d4f694732b8980.camel@linux.intel.com>
Subject: Re: [PATCH v1] powercap: intel_rapl_tpmi: Remove FW_BUG from
 invalid version check
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  "Rafael J . Wysocki"	 <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 11 Feb 2026 17:02:36 -0800
In-Reply-To: <20260211223401.1575776-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: 
	<20260211223401.1575776-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42535-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: C56EE128C5B
X-Rspamd-Action: no action

On Wed, 2026-02-11 at 14:34 -0800, Kuppuswamy Sathyanarayanan wrote:
> On partitioned systems, multiple TPMI instances may exist per
> package,
> but RAPL registers are only valid on one instance since RAPL has
> package-scope control. Other instances return invalid versions during
> domain parsing, which is expected behavior on such systems.
>=20
> Currently this generates a firmware bug warning:
> =C2=A0 intel_rapl_tpmi: [Firmware Bug]: Invalid version
>=20
> Remove the FW_BUG tag, downgrade to pr_debug(), and update the
> message
> to clarify that invalid versions are expected on partitioned systems
> where only one instance can be valid.
>=20
> Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI
> interface driver")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

 Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/powercap/intel_rapl_tpmi.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/powercap/intel_rapl_tpmi.c
> b/drivers/powercap/intel_rapl_tpmi.c
> index 0a0b85f4528b..0f8abdc592bc 100644
> --- a/drivers/powercap/intel_rapl_tpmi.c
> +++ b/drivers/powercap/intel_rapl_tpmi.c
> @@ -157,7 +157,7 @@ static int parse_one_domain(struct
> tpmi_rapl_package *trp, u32 offset)
> =C2=A0	tpmi_domain_flags =3D tpmi_domain_header >> 32 & 0xffff;
> =C2=A0
> =C2=A0	if (tpmi_domain_version =3D=3D TPMI_VERSION_INVALID) {
> -		pr_warn(FW_BUG "Invalid version\n");
> +		pr_debug("Invalid version, other instances may be
> valid\n");
> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0

