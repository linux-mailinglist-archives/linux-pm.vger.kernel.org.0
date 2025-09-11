Return-Path: <linux-pm+bounces-34446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E23B52C37
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299EB177095
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F92E54D3;
	Thu, 11 Sep 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsKsJbWz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD861F5851;
	Thu, 11 Sep 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580716; cv=none; b=dFxBdgwzey8rwL7A/7RaOCdkeaa2USi57xZ1CKon3gnp2c5GHGxh4Fd6zHEZWmBBwbWIjSVhV/1BqYa7CvCS8FMIHAddtDLcRMbqlSffNprHPLSO8epFSO2Yg/XtSHmVheiQSFRhLp1c+lzu9lnTZcTl+ITJkKS3ue+DBc7E4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580716; c=relaxed/simple;
	bh=pSGlt6/+W2nibb4b8wVtcHSpDe4HPa3+qg0Y1LB/eW8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mgdRJ0kASjB0dw+2MGTjJUSXv34GF1Scxtgx8lCqR97dSek32ZViYi1PAOJTs8Wkh5C2+a0BXcIko+t0JeD2QZhxeGIznNfv4nns48FhUInRRLR7ETsvn0nU+8icEAfRwb+2uuhtbdrQs+E1uhMXOKeofd8QQFzqppdJq289bmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsKsJbWz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757580715; x=1789116715;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=pSGlt6/+W2nibb4b8wVtcHSpDe4HPa3+qg0Y1LB/eW8=;
  b=LsKsJbWzFJq7bXEEswidcRiyYudtwSBZwGs9CT9hh3tU2ydx7H4XnK52
   v/GSKcIUnGeZJdbE0B9EwVC7BVIFT4k6P5MF68FfczpuyIgzjgQjAd1RT
   OQm19UO8b7XyGH1IpKrEGIYrDjvsPy3vFsNykYmkS/0lK2aNRm0Kx4xDw
   X25ubj5DYTPpU+mHwO3eRCgbuL0xNOtk3pTGpgy5shTrz4hDXSQ6VXBFa
   YkJm7E2/JeAPcry0IIMz+MKqxz2vMTRNnarDqybs/Efr1dQodYw5KyVk6
   WY1SlfCYjSf4JIkYqzAcVRrhNHeH2kS4y5Vp7eRIJkVyDuk+qoHEBHyBG
   g==;
X-CSE-ConnectionGUID: JejZ7o5lRAOaAamRGF5H4A==
X-CSE-MsgGUID: ulrfaijyQQCQ1KrNvfbNNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59599531"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="59599531"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 01:51:55 -0700
X-CSE-ConnectionGUID: PjoPVMnwQ6OV0XvzGJgpDw==
X-CSE-MsgGUID: eGlujMz9SAaiy7i5AhWVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="172926059"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 01:51:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250910210629.11198-1-xi.pardee@linux.intel.com>
References: <20250910210629.11198-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH v4 0/5] Enable SSRAM support in PTL and LNL
Message-Id: <175758070621.12104.14529289787048036133.b4-ty@linux.intel.com>
Date: Thu, 11 Sep 2025 11:51:46 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 10 Sep 2025 14:06:20 -0700, Xi Pardee wrote:

> This series enables SSRAM support, including achieving PMC information,
> low power mode substate requirements in Lunar Lake and Panther Lake
> platforms for Intel PMC Core driver. This patch series will not modify
> the functionality of Intel PMC Core driver in previous platforms.
> 
> The first patch enables SSRAM support for Lunar Lake platforms. The next
> three patches introduces a new table in telemetry region to get substate
> requirement information for platforms starting from Panther Lake. The
> last patch enables SSRAM support for Panther Lake platforms.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
      commit: feae929d8e6cb4e8d78a930c8b75326229e6b921
[2/5] platform/x86:intel/pmc: Move telemetry endpoint register handling
      commit: 1e508af6bc4b24a7924b619800f1b138281f0e82
[3/5] platform/x86:intel/pmc: Improve function to show substate header
      commit: 612326e0a87a5c75d35146ee172eb46bcd09089a
[4/5] platform/x86:intel/pmc: Show substate requirement for S0ix blockers
      commit: a22bc8643889ef5a3c032700f69001fdc457413c
[5/5] platform/x86:intel/pmc: Enable SSRAM support for Panther Lake
      commit: 8e54e493c9926105e771873b151d5eba80fbb856

--
 i.


