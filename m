Return-Path: <linux-pm+bounces-43718-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHsUAwH7qWk7JAEAu9opvQ
	(envelope-from <linux-pm+bounces-43718-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:52:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A936E218AAE
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8881F3030DBD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9335AC23;
	Thu,  5 Mar 2026 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZdoUuIw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CF33A031;
	Thu,  5 Mar 2026 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747460; cv=none; b=UbfIlF+Lg0xSOdnVdGT7rxIoUb5g5HSYl+WhSq1pP0RqanhlKd/63PFLVYk41kZfN9XQV+2c6ENoUxywZ/2KMAIQgKNNKGWuA3oKbCwmowTrojTB9sV4PpqJ34wLqeloMvoxfRzy06GsPG9vKXNxZxsaAW1FeDq1A2cwhV5O/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747460; c=relaxed/simple;
	bh=JZ7+Rv9V9B4qagIG1WXRU68ajAGdudsiQAvAX6AFd7Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHKXMFWFonIfVrP+krkQk9z1pwGTTE1rkrlrQQZl4vld2IzuAU0hrt3m7w8qdZie+hHNYNLAllFh4GOQOtCbpDaFlkSWIICdfZUBPtn7GYlO7CaMykLS9Jvm6SrBOEUobZ3qhNs7eaLC0ieFEIcRsaCsE8QSx+3JDOk7k9CZlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZdoUuIw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772747459; x=1804283459;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JZ7+Rv9V9B4qagIG1WXRU68ajAGdudsiQAvAX6AFd7Q=;
  b=GZdoUuIwmJ1XJa27fdSRaRdRWU+U3//vW79bwnuVv7EBtFqHQU5V7qku
   dcZQnjd5sFn0inYTcttr7ngdkpIZ503p7eKu/Z4AiGGzj1w7X0gsQ4Dgw
   Riqa5VV0F98ULTr0EfaWLndPhjRTVDseuho/gDr7oeN8oWT4beFeO0GaW
   wKjaNE8c7qr/+rxswNcaLNaZStp6/uoVFJru8DldkZXcO4oXfZcXCfyTD
   Qr144ZempXlomWmGFlrPLg8HInNQl06WGfJuTKiEABwFEAZLMeOhy5VuG
   g45haglSvZ3eLVQ+a8zRlEQnYnufaQXWeMWVHNuOrhkL4H7pbdrMWgI8q
   w==;
X-CSE-ConnectionGUID: laRcA0eYQCCUlyyaaTPCfw==
X-CSE-MsgGUID: KYDAwQYQTS68WDJw2hKAAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73549641"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="73549641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 13:50:51 -0800
X-CSE-ConnectionGUID: TH/GRi/+R3O3PXQ4KwQV9Q==
X-CSE-MsgGUID: 47EOmecOSpy9oZn5AvlZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="249279443"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.221.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 13:50:50 -0800
Message-ID: <f9a7677b7ac4a85f77a438cd08e02c4fe7ea6ff6.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Allow repeated intel_pstate
 disable
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Artem
 Bityutskiy	 <artem.bityutskiy@intel.com>
Date: Thu, 05 Mar 2026 13:50:43 -0800
In-Reply-To: <20260219181600.16388-1-fabio.m.de.francesco@linux.intel.com>
References: <20260219181600.16388-1-fabio.m.de.francesco@linux.intel.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A936E218AAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43718-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 19:15 +0100, Fabio M. De Francesco wrote:
> Repeated intel_pstate disables currently return an error, adding
> unnecessary
> complexity to userspace scripts which must first read the current
> state and
> conditionally write 'off'.
>=20
> Make repeated intel_pstate disables a no-op.
>=20
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Signed-off-by: Fabio M. De Francesco
> <fabio.m.de.francesco@linux.intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 1625ec2d0d06..d639cc150092 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3470,7 +3470,7 @@ static int intel_pstate_update_status(const
> char *buf, size_t size)
> =C2=A0{
> =C2=A0	if (size =3D=3D 3 && !strncmp(buf, "off", size)) {
> =C2=A0		if (!intel_pstate_driver)
> -			return -EINVAL;
> +			return 0;
> =C2=A0
> =C2=A0		if (hwp_active)
> =C2=A0			return -EBUSY;

