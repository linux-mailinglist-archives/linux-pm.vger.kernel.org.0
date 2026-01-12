Return-Path: <linux-pm+bounces-40669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A1D13BF0
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CDC30A2E6C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451753612E0;
	Mon, 12 Jan 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq34tck6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEA35F8DC;
	Mon, 12 Jan 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232068; cv=none; b=bWi88XnJTRsKnx4RBGHuc2rBoE+A0DgTaj6QEc6dmXf4YE9yJOKMQ6RcNs1ttyC2zErbfVwmeuExURQR5nyGIX6LwXOjspFUT8uCSAVIafs1PhCG7vEZtuxPMcMUUTDTfFU4V3Yk9yIDziCyfYOzdm3oNE4JdwVXAUP9CiAfCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232068; c=relaxed/simple;
	bh=a3TlgYsJtuSfcvrnZK1cr9fEMlfi/sVWNa+LB683VZE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XjQ2TCT4Y9XmaeiUzh9vGX+L/SjuBQxLlVmnLHFhmOcGvnxPjYmyp4swB2SutzUs2dN2yXmZzkTcrC9jDp3o4hp/qKLPqfR62CXx8o0bU6Ka4Mdgi5TbxWOlYPvN5U3y1PFSZlLfRlpOspcjoWYfPuAWdW4olswgVpULzfRBAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq34tck6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768232067; x=1799768067;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=a3TlgYsJtuSfcvrnZK1cr9fEMlfi/sVWNa+LB683VZE=;
  b=Tq34tck66yoIJtiHUzR+DERhj7w/huxSPU0QzWlvZ1LvgeWxKtJGzQfO
   mo9HmvjcGf2LuZpiorkoL+pKLIKkqH3n2HAgxeMPd9Dyr7JY7o8r7kvr5
   pj+2lYT1gqKpKaEmf7ChBrTEa3IQqMitg4nw9oGWZq0kmK295HBlcE1/j
   rpQGfTrdXt45welh5g97aw93w6fidupYv20ZHsyygNoc8Voh7UL6XQIf4
   V7si7YxygyeCBeFOH9uA+8Zv6mby3547eXVTuPKn7ZcGzQ8sXxLeQ7p/z
   wrW57+cnvRcScKMP/FIOxOCNRkVKs38x30ZzSVM9P6UjNpHo76DHx4iO3
   w==;
X-CSE-ConnectionGUID: 0QPnTB3RQTWvnhmE+eOhJw==
X-CSE-MsgGUID: IUbzbLERQoK7G6NniZom7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80613188"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="80613188"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:34:26 -0800
X-CSE-ConnectionGUID: cg8M25/zQ0iUufcbGMV50Q==
X-CSE-MsgGUID: IIySZUuNRyeqQggz4bnOTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="208960303"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:34:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20260108223144.504267-1-xi.pardee@linux.intel.com>
References: <20260108223144.504267-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH v2 0/4] Enable substate residencies for multiple PMCs
Message-Id: <176823205942.9723.15543574397569061940.b4-ty@linux.intel.com>
Date: Mon, 12 Jan 2026 17:34:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 08 Jan 2026 14:31:38 -0800, Xi Pardee wrote:

> This patch series enables substate residencies for multiple PMCs.
> The first two patches prepare this change:
> 
> - The first patch changes the datatype of LPM mode attributes to u8.
> - The second patch moves the LPM mode attributes from the pmc_dev to
>   the pmc struture.
> - The third patch enables the substate residencies for multiple PMCs.
> - The final removes one empty line.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] platform/x86/intel/pmc: Change LPM mode fields to u8
      commit: d155800918b0106e9a4147d00c81bc6f21c17233
[2/4] platform/x86/intel/pmc: Move LPM mode attributes to PMC
      commit: a1c745c84043001f696ae063c213f1eefdb03a1a
[3/4] platform/x86/intel/pmc: Enable substate residencies for multiple PMCs
      commit: ec4cda37a62cb736e9c7a5ad1630e6418e465af7
[4/4] platform/x86/intel/pmc: Remove double empty line
      commit: 291cb0fc143ca603d4e959ae3fbf4bb149281a39

--
 i.


