Return-Path: <linux-pm+bounces-19020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C819ECDE5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BC3188D107
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF122912E;
	Wed, 11 Dec 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqz0Qli3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5A236920;
	Wed, 11 Dec 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925720; cv=none; b=j5EX1Fw5NH+9E9dH2C6cGXtbkbTofSH3GUozAW51QTR51xH3PIFq2ARdCDG7hYxF7tExkUFd8+kTFluIIPIJDrOHPBvzICSkgmKn/zSKFvQzllwedOgE3xJ/CiT1s7j+y3N28+FWdCnZqwxJqtq3+T+X9/grOncdmY1UkT2CQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925720; c=relaxed/simple;
	bh=z7bvqZn0M0rhyTjaqGyMAz/+u7JPeej2I1K81+zZ1KY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AoYVRyzQURg+A3hkFrFu3J0qkrgfhqB/RmVMsb8b9aPj3tgtLp0xOWhQhmKo5h6xE1nxydowc2rMwObkKCQBxzugr8EqxdxDLlm/6Ph07xJBOb216LXudpZJ5EN7JSkXc1+4lgOx9DxgiSi2c/6tDhpkrbA3cW5s3V7MiaaLJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqz0Qli3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733925718; x=1765461718;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=z7bvqZn0M0rhyTjaqGyMAz/+u7JPeej2I1K81+zZ1KY=;
  b=jqz0Qli3hK5yYb5pvgRBYOaowS76s5b4oKTqfKD9gD7Nm4hP8TcJi09O
   IqFgV9oqiy3v380+ONtS9BjdXRWt/BcjrDa7w2oqOahzbfgTB5cp74FZp
   4Jdz7XGdQua7W1+RChnVX+rjqsUpQ6+8KslVpXMBdJOE0lAQp2gHzoeWa
   cs+JpQw7xegv5J6j2ICMDIEQKsc1Cjw+xvQK5/Lj+caE2o3Mv8UF80+cy
   gTCFx2oVOEtP6jtruTn05myzN/XRBf9JJ4wpznMx6xaeyzSDGEqHkgpBH
   APhtodX3knLXSVfIzQrGSAtcqYwy+P/C3maYzGGw1JCz8d+rkEOqQrGYX
   Q==;
X-CSE-ConnectionGUID: JmHmL35xR/+MprtmhP9Gog==
X-CSE-MsgGUID: Fw4WSJWxQ3yBmx5T1HHOPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44776279"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="44776279"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:01:58 -0800
X-CSE-ConnectionGUID: qUslTCWgQC+fpbTjahvecA==
X-CSE-MsgGUID: 1/SdvVgDSiiYOVdcHgnZuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99910821"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:01:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20241210212646.239211-1-xi.pardee@linux.intel.com>
References: <20241210212646.239211-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/vsec: Add support for Panther Lake
Message-Id: <173392571080.1862.18183304350747378619.b4-ty@linux.intel.com>
Date: Wed, 11 Dec 2024 16:01:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 10 Dec 2024 13:26:41 -0800, Xi Pardee wrote:

> Add Panther Lake PMT telemetry support.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/vsec: Add support for Panther Lake
      commit: 83848e37f6ee80f60b04139fefdfa1bde4aaa826

--
 i.


