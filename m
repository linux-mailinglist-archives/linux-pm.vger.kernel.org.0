Return-Path: <linux-pm+bounces-19882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608049FF7AF
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338E016222E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E691A8F84;
	Thu,  2 Jan 2025 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt/TsWdZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F281A4F2F;
	Thu,  2 Jan 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811441; cv=none; b=L9FiEPFKhBJqGAxdePX3McvFW17dRhNvXKyTlUtpi7R3PHiMa+mtQgaTCdBJT6R7DZKco9npL9xLHZXcBbbT7D4QWX1cnC6hLe68wCicaxZLD/fwnF8rf2e4djNNTVrmJNlgk1Akeen8Wkya6vUVlx8iiKQWIuekaLFXK5K7oPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811441; c=relaxed/simple;
	bh=1a+Uph2h+v+Y+ToVfeb1NyuIX2gYgygd6YVvm6ksRIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gufYHXHNhvH5wL/WcItEtD0ibcn1PpgUnOBavGb0meLIBWzyNJGGTIbuJFnR5cC9PxuYKesD15/t3vmGEIGQA2QwmZ1uynhsvyFp12y8+zG+svvgkfSIaxU9DBlL3Y4KpxKaLuh1/O0zDUuY/451xjN/epXwV2kq0bfLpAzcdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt/TsWdZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735811438; x=1767347438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1a+Uph2h+v+Y+ToVfeb1NyuIX2gYgygd6YVvm6ksRIo=;
  b=Zt/TsWdZISk5p5k6gHbZ9XVRAs63Cl/Cx0SQR3ScAStgC2swyFvJRUQ5
   4KQ8JQCU4V1sERg/t3bBc8Fa/+LfmhWGIXg7iOvGsMhgcHPKtGrOHD6VX
   o4Dcnv0SmqH+tMuPsIQVmRsngBYqAMk0lRCBJV111EtKkEHHA9RH/K+s8
   63v1axHp5K2gdmNGbiKYBgHTHGp5PZDsPU8c+MeJ5/515r89u6mt/gRMC
   zzuUDTaXmLx5PwKUDTL/36nUinLAMq7CIhPZauAHakmTaWOc7AMeZukie
   nSPvrnPOKOI9iEg/wXbkI0Su9IEfcs+zg7rOCu9iLSFI1C0bXQPL/vTpI
   g==;
X-CSE-ConnectionGUID: DT1aPfOsTn+nP+axnQSo8g==
X-CSE-MsgGUID: Mg+pdgwZSs6TAmPx98V9+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53593252"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="53593252"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 01:50:37 -0800
X-CSE-ConnectionGUID: NyygQtYoRc6j4Q9BCECZHQ==
X-CSE-MsgGUID: nbe0k4ZjSfGWlRrqgRUKkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105511164"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.245.102]) ([10.245.245.102])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 01:50:35 -0800
Message-ID: <f597da81-abdc-4133-b5ad-432792b6aa6e@linux.intel.com>
Date: Thu, 2 Jan 2025 10:50:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, gautham.shenoy@amd.com, tglx@linutronix.de,
 len.brown@intel.com, artem.bityutskiy@linux.intel.com
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
 <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0jhK51+pkf=Amr=qXWzK3e1xC_tdt0iqQXxVfeE4pcFJQ@mail.gmail.com>
 <2320a952-334d-4d52-a15a-669a5670df7d@linux.intel.com>
 <CAJZ5v0i=_wNubB8_yQtBZYLYJ+f==c9OVMpxbtYHfFCJR+nsng@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0i=_wNubB8_yQtBZYLYJ+f==c9OVMpxbtYHfFCJR+nsng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>> And honestly I'm wondering why adding a parameter to mwait_play_dead()
>>> is better than introducing mwait_play_dead_with_hint(), in analogy
>>> with the existing mwait_idle_with_hints()?

Well.. Maybe that wasn't that good of an idea. I've given the rationale
in the 0/4:

> Changes since v6:
>  * Renamed mwait_play_dead to mwait_play_dead_cpuid_hint in 1/1, so that
>    mwait_play_dead name can be reused for the function that takes the
>    MWAIT hint as an argument. This leaves the comments around the
>    smpboot.c file that reference the old mwait_play_dead() unchanged.

It makes the patches simpler, in a sense that I don't have to update the
comments each patch when moving things around and renaming.



