Return-Path: <linux-pm+bounces-38000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3158C5A1A0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 22:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B687A342A8C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334431B839;
	Thu, 13 Nov 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkFW+DAH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE52261B6D;
	Thu, 13 Nov 2025 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068938; cv=none; b=Jw4Wb84Hbo4gFxHq3Btf3HIxqbiCXKNyYoWrjwMnxVs+9r8tmc95Oh4Pw0Clkp80GKKo5fYhSc4wl9vyzKt+zTdIuYQtT9u0b//1r7/t0o56nBB1fax/Qf1gy1TAHFTclw+CmNvwHkxBbD2+r6qkRkjMMuRaV8iNGmH3S1nedkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068938; c=relaxed/simple;
	bh=amL5JRP9mOGKXlzYgVy2K+ZxEXVI6wDfqzJ9HEMwmPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kkGTXXG7jrP0X8DHtWeGLmSrXLkb3Vg7Rq3ZmDeweXPag7WmCj4SHED0DsJ/KzeDXq/1kxJ6hE9v5R1TAKaSSWtQ+Kl6357Q7Dnpe2gySnEt0sr//7D75Z52eteQSLizMbsOdIiSOCU/9sDlcurGsQNbQaBQSUtld34D7dNpFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkFW+DAH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763068937; x=1794604937;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=amL5JRP9mOGKXlzYgVy2K+ZxEXVI6wDfqzJ9HEMwmPU=;
  b=VkFW+DAHSOI1KRL8yphQiWRP/NxPTCuY1QJ+ByGZc2ShB3JXUjJZxJdk
   8G1L/dtVkGOwrZc/vnNGFk5cL2JfbCIAIGEDtWJUrYFCHTJ1f+gDK/aOc
   I7oZZ3FG614KxEBSztE6RIMJxqDlhewX43FYLkmQ+81ANyaBcB87rmzeK
   2XSQi46WRaS6klUPzW5T7MMa3icWV2e2hw7IN9TmcgvWML21bMH0yGzQn
   IMHaPj+hM/86FBHcujB0OVoiPauGdl+bzOeBRqVGE6IKvA4VTuXLawfS2
   3iX7yBO+OaIIIlml0FmJU86v40v+5UXRGaarBkQ5+LtE0DY5rLsKUI0RW
   A==;
X-CSE-ConnectionGUID: dlXSSg2nSI2ZKf+DO+MvPQ==
X-CSE-MsgGUID: zgymYMCFTPCs8DBLGXkIpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65320825"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65320825"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 13:22:16 -0800
X-CSE-ConnectionGUID: u8S8toQBQuuwLtDnS7U4ig==
X-CSE-MsgGUID: hBA7AVVAR3yP5tJxbe8ISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="190034895"
Received: from cmdeoliv-mobl4.amr.corp.intel.com ([10.125.108.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 13:22:14 -0800
Message-ID: <a5cade96778a936c724f56761ecc4a0cbfcbaa2f.camel@linux.intel.com>
Subject: Re: [PATCH] Documentation: thermal: Add documentation for thermal
 throttle
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, rafael@kernel.org, 
	daniel.lezcano@linaro.org
Cc: corbet@lwn.net, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 13 Nov 2025 13:22:13 -0800
In-Reply-To: <9b1e04c2-03f0-44d0-88f0-757a51a6d79d@infradead.org>
References: <20251113014116.196638-1-srinivas.pandruvada@linux.intel.com>
	 <9b1e04c2-03f0-44d0-88f0-757a51a6d79d@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 21:49 -0800, Randy Dunlap wrote:
>=20
>=20
> On 11/12/25 5:41 PM, Srinivas Pandruvada wrote:
> > Add documentation for Intel thermal throttling reporting events.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>=20
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy. Since I posted update, didn't add Tested-by.
Please check again.

-Srinivas

>=20
> > ---
> > =C2=A0Documentation/admin-guide/thermal/index.rst=C2=A0=C2=A0 |=C2=A0 1=
 +
> > =C2=A0.../admin-guide/thermal/thermal_throttle.rst=C2=A0 | 84
> > +++++++++++++++++++
> > =C2=A02 files changed, 85 insertions(+)
> > =C2=A0create mode 100644 Documentation/admin-
> > guide/thermal/thermal_throttle.rst
> >=20
>=20


