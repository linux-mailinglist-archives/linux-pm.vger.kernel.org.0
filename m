Return-Path: <linux-pm+bounces-28637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CAEAD85EE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE2A1898B90
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A775326B751;
	Fri, 13 Jun 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EykgHarO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474B2DA77F;
	Fri, 13 Jun 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804503; cv=none; b=cMbOCHCB9W3B0T3IYgQ/9S6x1uwb2bORVRPFQ/LTWshprTQl7agDG/YUOkJzhMfn8eueNWJa4o8NISc4cxamKRNKSrhQ0QGEhzC0CCakXNcR/jk9wcMxuox5FsVlZQPypOKY8yRE1w4jIOtsSmB2XHhRk9GtXkFDe+9UVLFTC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804503; c=relaxed/simple;
	bh=PjS8zzwBErJ5XZsMyktKp4mX9z2fWJ7QaMUytAfCx68=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mHNSMgTUdPNjUkaFAC478uaFHVObgKb2vMmaPIHGJh1+/69tA33Bf7ZvK/Did2i1rLAtUr0dr+tQFdSBNMWx8IukG0ie+3D7aboFuVpDGj/WZuGy/wIte0BU7LmjnWeQUv1RcYEA+0zlaZZ2FvP/PCj7TrTcKi5yVKSGcmWDxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EykgHarO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749804502; x=1781340502;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=PjS8zzwBErJ5XZsMyktKp4mX9z2fWJ7QaMUytAfCx68=;
  b=EykgHarO/HxQI8TYPTkFJKmTALj5pAlsRrYSyT9pxSAbu3xPVzVCumxh
   K2OGQ1Kj3IX87rYaXthTNblQFVLDQDCXpjO9iBpH1YEPphj2qyJsgPIBY
   EUPRHPgNkVDqNgdQHRuW6qtUHwPJJKsPWs5UYkYwDeg4Zd6fI2+zWSS1E
   yH1Yms+V+t1EwzmVdNK2f4QNi8lYbzu1HJj65bONC1JMg2hZy0X8WiaA0
   5qBW2RMWCsX2cfSYvuIMPd6QawhGpgWUR9ofwIFcFxMEjHbsPW5XFU4Hx
   mmBybGFU7hMv2flNggN/pC0jfFiwn18nNbHYLU3vLCYAJlQxJy10/e4QQ
   Q==;
X-CSE-ConnectionGUID: FBrB2gLoQI6h3lqm6J3muQ==
X-CSE-MsgGUID: uSZt///BT26aVABBx9abDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51993202"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="51993202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:48:21 -0700
X-CSE-ConnectionGUID: Gc0sCCM2RtO3reCsvYG3NA==
X-CSE-MsgGUID: nICVCTpXRo+Y/Ah2jw0t1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="148659566"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:48:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250610230416.622970-1-xi.pardee@linux.intel.com>
References: <20250610230416.622970-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86/intel/pmc: Add Lunar Lake support to
 Intel PMC SSRAM Telemetry
Message-Id: <174980449349.1640.10907164330928365040.b4-ty@linux.intel.com>
Date: Fri, 13 Jun 2025 11:48:13 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 10 Jun 2025 16:04:06 -0700, Xi Pardee wrote:

> Add Lunar Lake support to Intel PMC SSRAM Telemetry driver.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/intel/pmc: Add Lunar Lake support to Intel PMC SSRAM Telemetry
      commit: 2d5a84c3ecc075d87bcb16c1cc80277b5837c153
[2/2] platform/x86/intel/pmc: Add Panther Lake support to Intel PMC SSRAM Telemetry
      commit: be574d5eee9808a422cff0293da9b08c0e434ed0

--
 i.


