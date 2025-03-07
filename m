Return-Path: <linux-pm+bounces-23620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDB9A56595
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64671895ABA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954B20E713;
	Fri,  7 Mar 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpGJq7Z/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134B1A239E;
	Fri,  7 Mar 2025 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343960; cv=none; b=dXEWUyHds4dURgFCd2tXlEVT/AGsOQAf30Eo9B7NFhkcjkfYj5RB1iZQj45TRHAaAbNsAWBgUOOW/l45+RvbO/3RnQm23/V36EczPUyrrV7wOYvAG/QvJuFPbz1cLLC2UelHNOjIMyyfrJY5BFLT9BbdIn1uLPB2zdQUAHVydVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343960; c=relaxed/simple;
	bh=99wAVcYRjJq/6/DqsC5mahdq+/vz2vQmHA/zE8ELOBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HngLIDc2S3HJNHZNV8detsDpV0rwy+kjPI7tKmcLuqlcKN6ADdINeXbd76b7X75EIsWM/M9zL1JAqM6v2WKA2DsZ/clH2xHk9x4Kik2iHUMZ5V6GFki04JxSWSeV+gHOL3/a/ZQMFImUhE37Aqyi0CFJQ5RnqNWs4FX+95ye3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpGJq7Z/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741343959; x=1772879959;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=99wAVcYRjJq/6/DqsC5mahdq+/vz2vQmHA/zE8ELOBM=;
  b=TpGJq7Z/EC0AHVMXbLjn/8rit5vDP3j8ALpHH30l364DEb4nmFWD73Bg
   mY0cf2Z4ZfiKJ+S/oI5j/MOcJYgAla2A3f5GaPXmMYAc5VezWBmW8xdEN
   STFRlcyqsgquwQHw8QTQggH11XQybBKOrki6T0qLmhEXCqFHeIcd1sJdW
   Hfb6p7BJe/sJUSwlQ92kOji7EeASzmP+k+n3v7EU6X6PbN7qQT/2fg01T
   JUl7IpgsaPgSysWYgObNFeHDrptGxI6nuHPhEcmSVlxF8HfnyuH8er8Cr
   CRtj+uoCNG1yHTZky4kSM9xpNCDTVsxEo7pvZ6EFDrn38/ocSxRZDbcwi
   Q==;
X-CSE-ConnectionGUID: vLca3PQTS2mMGxy3GaPTVA==
X-CSE-MsgGUID: 32Z+F4pcQuuVhaTYsNLH4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="29968927"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="29968927"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:39:16 -0800
X-CSE-ConnectionGUID: /IWgKA95TnOML6Ea/6JBrg==
X-CSE-MsgGUID: cWCzXnrgSpi4Y+wll4CEfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="142520112"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:39:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, sre@kernel.org, Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250305053009.378609-1-W_Armin@gmx.de>
References: <20250305053009.378609-1-W_Armin@gmx.de>
Subject: Re: [PATCH 0/3] platform/x86: dell-ddv: Rework battery temperature
 handling
Message-Id: <174134395033.2047.10351866706866482165.b4-ty@linux.intel.com>
Date: Fri, 07 Mar 2025 12:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 05 Mar 2025 06:30:06 +0100, Armin Wolf wrote:

> This patch series reworks the handling of the battery temperature
> inside the dell-wmi-ddv driver.
> 
> The first patch fixes an issue inside the calculation formula for
> the temperature value that resulted in strange temperature values
> like 29.1 degrees celcius.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: dell-ddv: Fix temperature calculation
      commit: 7a248294a3145bc65eb0d8980a0a8edbb1b92db4
[2/3] platform/x86: dell-ddv: Use devm_battery_hook_register
      commit: 8dc3f0161e35d6ceb12de4a70cbed593e5b0583f
[3/3] platform/x86: dell-ddv: Use the power supply extension mechanism
      commit: 99923a0df7852311fa3d01eaddb430c958780143

--
 i.


