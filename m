Return-Path: <linux-pm+bounces-13924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F74972A3B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6126283B46
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 07:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FC717C21C;
	Tue, 10 Sep 2024 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmHzDAPO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBE17BB1A;
	Tue, 10 Sep 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952090; cv=none; b=kc1bzpLqwdGGlTqs0sjclx9NTjwv2U/h0wzgQXiYkY0DbbVP2rib5Cn2cxaK7Hwy+OjJqoYTLWNEngLuywiOOPeIlO6TrR/K67jtesT5RRiDLruJ13Y6Awc3ngjNoqIYZN5ZibHzpUthnj1f6OTL+vRAsSbbOEKYR9UJgRoFhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952090; c=relaxed/simple;
	bh=V1J6HYaNIi0kxdp1i7xtFJaVP1RaW0C5i4reV5ZcDrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSG6DxSy1NtlSqYaBbD9/SrgxGg/nd1JMJpeXXli71A1N4NeYF8rlQVGBg/At9b9bvrfHUdwXN+uoVsGEIZSvZOCpsMvIe4px5HZz2+xdlIpoPOpC7GOmTA4fmV8Sb2PNeZLejBtsCl1GMOySkcy2cs1BOOLe1XzcLFwTxiOzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmHzDAPO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725952089; x=1757488089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V1J6HYaNIi0kxdp1i7xtFJaVP1RaW0C5i4reV5ZcDrY=;
  b=YmHzDAPOhYwbx9t51pBFQK9qcoUkxFe2BVAlPUcnBlzt+I3w2Wr2K9eE
   E5wtdHlRc1bO4ZXEEr7DiQRUX2iGsogHcfUFRoYcl7BbiKIz9m4lmPHnq
   EsKjINJx4MZa5nQfzfqMauDTuEDXGXcuP/qQfJqpegeVMoiFCtOkMrtma
   47Lr/Es45zOam8jG7ZkEqpV7j8TDi8CDvCIuNCEM3eWZvNbvw5wvOkuAC
   thlN1/b/K2oDttfFiVzpqjFvxJ/o2bxInBb1K6Y+xXQc8lhCPeizBm/yk
   yOT2sCrkmoyZs8D6NOuaJIDuj/LH12nBkA1Q7lSJBn+m3YU7SfOnTkwe1
   g==;
X-CSE-ConnectionGUID: 9nNfGO08RbSzJL8fgJ1yIg==
X-CSE-MsgGUID: 6737wyBwRqmVKAzt48Cbxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24624148"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24624148"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:08:08 -0700
X-CSE-ConnectionGUID: Vyt3HIRiRb+8eKgQWeHRxQ==
X-CSE-MsgGUID: Tq045nH8TgeU/VR3DmyMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="90220710"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.125.67.115]) ([10.125.67.115])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:08:07 -0700
Message-ID: <e442f597-cfa5-4c1c-9db0-da0485813b26@linux.intel.com>
Date: Tue, 10 Sep 2024 00:08:07 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] platform/x86:intel/pmc: Remove unneeded h file
 inclusion
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
 <20240828222932.1279508-6-xi.pardee@linux.intel.com>
 <8bda80eb-c0b8-c9c7-5c18-bb06701a69cb@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <8bda80eb-c0b8-c9c7-5c18-bb06701a69cb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/2024 4:02 AM, Ilpo Järvinen wrote:
> On Wed, 28 Aug 2024, Xi Pardee wrote:
>
> In the subject:
>
> h file -> header
>
>> telemetry.h header file is not needed in arl.c or mtl.c. Remove
>> them to avoid confusion.
> I'd also note this is cross directory/driver include, so perhaps something
> along these lines:
>
> telemetry.h from PMT is not needed in arl.c or mtl.c so remove
> the cross-driver include.
>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks! I will modify the commit message in the next version.

Xi


