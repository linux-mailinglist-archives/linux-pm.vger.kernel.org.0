Return-Path: <linux-pm+bounces-34384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10E4B51BFA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9437A161791
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3EE264F8A;
	Wed, 10 Sep 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STjT5T9w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6423257858;
	Wed, 10 Sep 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518816; cv=none; b=RK3JLdVD0Y4/T9QnPsIv84xYyg574NOa1J2nBY5TKEfnJOYsOfck8QBGqfiBVkoykgJau/a6WVGas8RyTElXkjtw/XfsHEhMGDcthAluioEfJ/drbVWxqnCVrdqSIz8AhYFps45msIKzcPqg/BL58A2Zlr/MtF90z/BA2A2k7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518816; c=relaxed/simple;
	bh=QrYqOCxbruM21gMTV1jjXaaxQ+qUE8x/RiQoGBT0K+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tOn5PRJ2bAbGj/bDR190Edex44C4ktxdihvHdkWlNFiCuKKkHA9/tM7n3tDHqB/nEHvr5zZkNdyhClrHh/WEJoOyrdxWS97krO0Xb6sdwCNemKrLwf5vRU7mJccWHfZyhTWkHtKvf4Dfw3IRKbP+zpVUQXblvcIdt1BFZEHFvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STjT5T9w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757518815; x=1789054815;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QrYqOCxbruM21gMTV1jjXaaxQ+qUE8x/RiQoGBT0K+o=;
  b=STjT5T9wLzYfUmM4CKHyruc/d7bPZ9xZQ1q2y5Ns2wrd9OmjJsTGm/9X
   goNSx2fiGHzfvXrBgyqSeaJcdMslyQT+I4n/18wnQvPDBUhBLpfqe61Dc
   Q3ZaLaSj3SLhGmRZ3oyrIDxgBRwH4SWgHzR4RErj2+TvLm2Ae3KX6bI5V
   PRD7KigPm9N85imHMv2Y4g2yu8KhS/JlzsUzgokJoDaWv4flsRu8ZnOKC
   TuCcl4PLJtdwidYjausDN0kW+KsiCY9x45PnBVSAbdtQYWC+lPIACYQb/
   rohie+viibtB8lPx6ihMwduPMNiLveZyuvjaxIvjPRqxBHY+tdJT53jnR
   g==;
X-CSE-ConnectionGUID: +U/nWZRaRiytzSej8uOiaA==
X-CSE-MsgGUID: Ov71n1XYSCa3AAAu8GMSnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59896959"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59896959"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:40:13 -0700
X-CSE-ConnectionGUID: rfYVEpm3RD+hL8jvhNh9/g==
X-CSE-MsgGUID: pCuS3oKHQ16SXeVuD0Ma4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="204413413"
Received: from spandruv-desk2.jf.intel.com (HELO [10.98.25.49]) ([10.98.25.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:40:12 -0700
Message-ID: <dfcf7e0e55a9110c9c90334c46637c61e4cb98c7.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Enable HWP without EPP
 feature
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2025 08:40:11 -0700
In-Reply-To: <CAJZ5v0iu87EJYfJV+6gTBXkc5B5pfXo97JEfBb_ddOMnMrTCTw@mail.gmail.com>
References: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
	 <20250904000608.260817-2-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0gwXiRTo_Lri3rduA-RqDhwgK4ymwX3ttxqhTw9W6d=fQ@mail.gmail.com>
	 <CAJZ5v0jqLnnBL8fLJ3vxS_61rAigru8T1a9Q-k+cg2kptv_zUA@mail.gmail.com>
	 <CAJZ5v0iu87EJYfJV+6gTBXkc5B5pfXo97JEfBb_ddOMnMrTCTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-10 at 12:08 +0200, Rafael J. Wysocki wrote:
> On Sat, Sep 6, 2025 at 6:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg>
> wrote:
> >=20
> > On Fri, Sep 5, 2025 at 11:02=E2=80=AFPM Rafael J. Wysocki
> > <rafael@kernel.org> wrote:
> > >=20
> > > On Thu, Sep 4, 2025 at 2:06=E2=80=AFAM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >=20
> > > > When EPP feature is not available (CPUID CPUID.06H:EAX[10] is
> > > > not set),
> > > > intel_pstate will not enable HWP.
> > > >=20
> > > > Some processors support DEC feature (Dynamic Efficiency
> > > > Control). But in
> > > > this case HWP must be enabled.
> > > >=20
> > > > So, enable HWP even if EPP feature is not available but DEC
> > > > feature is
> > > > present.
> > > >=20
> > > > When EPP feature is not available don't publish sysfs
> > > > attributes
> > > > "energy_performance_available_preferences" and
> > > > "energy_performance_preference", but continue to enable HWP.
> > > >=20
> > > >=20

[...]

> >=20
> > Attached is a new version, please let me know if it works for you.
>=20
> Any chance to have a look at the latest patch?
That patch looks good.

Thanks,
Srinivas


