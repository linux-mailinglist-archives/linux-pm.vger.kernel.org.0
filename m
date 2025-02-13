Return-Path: <linux-pm+bounces-22018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2055A340B8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 14:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182DF3A419D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C5221555;
	Thu, 13 Feb 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGNFJ3xt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCA22154C;
	Thu, 13 Feb 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454384; cv=none; b=cCUdte3Z1bohBkEQqSQa6YS5OiE4GKNgDVJRzXcGDPBm+BLxRR2jzfrFWFIDvLVPAmx99be9vAA92Nq/kKetCkJ2XZtBa+PE3vg4HQGlTBRPhJBRokA5rS7OMfi62I0CRA76hl95aRg5uBpm1xP+SbzcpehLXddAZ3NT+UK3+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454384; c=relaxed/simple;
	bh=/6Y4bYMcphEog8bwSG/+d3NhG5dlNWaIeOkYZsLICIU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HvAUPVCIOdTMWmcbwCdMPdT6Xqfoiu8HChctKhOmfvKdu3mRbcpP0qpe0EPNXvLMGD7PSXm0dQUBlYmJxOsyK1HY+MNj83AWJRX8YkgZk6FPgOuyat8nO4u+MEVUj8SRQR4m9RC+w8XAmFmgw/83W7sYRi3mnGAJXL2TZoV9lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGNFJ3xt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454383; x=1770990383;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=/6Y4bYMcphEog8bwSG/+d3NhG5dlNWaIeOkYZsLICIU=;
  b=BGNFJ3xtM72/6zQYBt9SAa9VAWOOlQciN1qBiywqCbqFt8nDL3xZeYBk
   ByLVVVc8YqWPSt+QV0jJhhq6/yNVr09ISZZ2SNrNKPA8I+f8CLb709tcW
   y8IorvLYwkcbJVJ+OoofZymyaS09OKsB2g+b+mNygRZRc8ye45SskJWL+
   z9e1JXs4y+ZkNMf3Ak6u29bwaTzmBYT5X8+Wy517rgsaRYqXTBojMaFeO
   s2pLxrQ/+PJ1T1X5WMDeXNKSFZXRdTbL79UdMf/XjIUfNztekbvolmK2E
   1P2tPkbfmRYq8ZGz0LtFJM7dhvWlEFsiq74LQa61UBGLgSW9ZpCNM0IiE
   A==;
X-CSE-ConnectionGUID: T1ls5Ha3SluHX9LRRPygiQ==
X-CSE-MsgGUID: K/kSgwMpS+GU9+gGPh7/kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39342969"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39342969"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:46:03 -0800
X-CSE-ConnectionGUID: uKKhE50DSpa5KZLLmHnd8Q==
X-CSE-MsgGUID: PWQKEyUkTYWYBDCnMXySkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112903682"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:46:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250212010621.1003663-1-xi.pardee@linux.intel.com>
References: <20250212010621.1003663-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Move arch specific action
 to init function
Message-Id: <173945435577.30492.7139384026405140484.b4-ty@linux.intel.com>
Date: Thu, 13 Feb 2025 15:45:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 11 Feb 2025 17:05:56 -0800, Xi Pardee wrote:

> Move arch specific action from core.c to the init() function of spt.c.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86:intel/pmc: Move arch specific action to init function
      commit: d026feb03bdcde33e22a75777d59ed9d8725bcdd

--
 i.


