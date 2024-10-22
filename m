Return-Path: <linux-pm+bounces-16197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60A9A9DB5
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7C81F267B5
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D339199FDC;
	Tue, 22 Oct 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/pJC1ar"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE37199E8C;
	Tue, 22 Oct 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587464; cv=none; b=IBq314sJbarB4xTrcISdeAVGUD3eLrUzhOOzxYMnXbxL5+CzmDnzkj2pm5qhtfGRXt06M3W8ORbu20QFy6RTXibQtaIMVoia6j/bHAM4zR71jX3jEIW02m+e3MCVn73EDfh1acSUvGnPkvw7hMoUjoxKf7vxffBi4B/gqEkixF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587464; c=relaxed/simple;
	bh=oUzACdJLQfnA2tCbo0HNZjpkFejfp1Dl8JWZNQpKAec=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mQsQk31ZguYRInQuitBO/ySWttajpFgM4jTGLmmaolGPgv80b6UGIPgZxPVwlRkBuhpa3iFaMC8xxpn446g9saf4QYBJKg8jlbwqpgZ4Y50NBc7R0wskgFI+lbi170/DtuE42fwzjwmlLOJ3Y+z3ZuYS0NH6K2YhR4VGGmg433Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/pJC1ar; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729587463; x=1761123463;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=oUzACdJLQfnA2tCbo0HNZjpkFejfp1Dl8JWZNQpKAec=;
  b=I/pJC1ar9HNpfk0L1hS2nEKN0aePXEtBE+XdPkSrGim8O8DtOtoXL2oT
   IpSzvOKZZ0gNX3z1Gf9N5FVZtfh2FmUejHmlfbWeJRAhxQqJ+etVUVoIo
   3UVAVCcO4knyGmXI8JvHElJxftsZPAw6EI7HKgfxHsRiFfBbtQvmmP2Sg
   qdupEsw41uBt1G+Kb9V8vx2t2LKbKL2G7Ghhkx2XLwiRMhcVpfZpsX0Af
   ZjqU7Lr5pWaUfw6UawD51SDs2BDWO/IzYZRigRES7WbBGvxwJcdUN+lYI
   pU3ZonkbxzMpZUpbf+HtUz8KoQG96CZAPEgyHMyUQ6cO62V1DpuXLDhrf
   g==;
X-CSE-ConnectionGUID: 0AIArzdwSN2jqyEP0GXeLQ==
X-CSE-MsgGUID: 6sYqXKISQgus7MN5G4LOOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40494423"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="40494423"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:57:42 -0700
X-CSE-ConnectionGUID: SGDcPj9sSBaBD/gVJ1cbbg==
X-CSE-MsgGUID: EwCLqvLnRlGYEdsvwPmSGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80607478"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:57:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: david.e.box@intel.com, hdegoede@redhat.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, 
 srinivas.pandruvada@linux.intel.com, 
 "David E. Box" <david.e.box@linux.intel.com>
In-Reply-To: <20241017210439.3449324-1-david.e.box@linux.intel.com>
References: <20241017210439.3449324-1-david.e.box@linux.intel.com>
Subject: Re: [PATCH V3 1/2] platform/x86/intel/pmc: Refactor platform
 resume functions to use cnl_resume()
Message-Id: <172958745472.2775.2358828725323866515.b4-ty@linux.intel.com>
Date: Tue, 22 Oct 2024 11:57:34 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 17 Oct 2024 14:04:37 -0700, David E. Box wrote:

> Several platform resume functions currently call pmc_core_send_ltr_ignore()
> and pmc_core_resume_common(), both of which are already called by
> cnl_resume(). Simplify the code by having these functions call cnl_resume()
> directly.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/intel/pmc: Refactor platform resume functions to use cnl_resume()
      commit: 9fe43c8020a60b9c9ff44c4a9914e7e7df63084e
[2/2] platform/x86/intel/pmc: Disable C1 auto-demotion during suspend
      commit: 7a797cc9f80915cc5f1a5aee46d14880eb444644

--
 i.


