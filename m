Return-Path: <linux-pm+bounces-33314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 108C0B3A60D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65411C2324E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F9322A3A;
	Thu, 28 Aug 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jN6ux4rW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E12321F3C;
	Thu, 28 Aug 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398071; cv=none; b=IOzn27oeZRVeNK9SSxhWHX0mCa1s+3ynN4oNzD/U8ZOenNkK3vV3Rk+KcjutHeo0KhcSKtYH/Ay3zr2/W5YH2CT6IwNqZUJwpi/6fBfDn6JewMgnORY/pRWiRhQY9DWPuyZOnbVIzJyheSyG0poXhp2gniI+fuL+be8ELHO80mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398071; c=relaxed/simple;
	bh=ZeEpATc3yG+2ZfhU0QiMwUkrn5ohROR4JCkKzybZ1hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RaiTDCRqURAosr4VyWYE7sFbhiwqhi6TxgkzmPZ+umeklMs6R+giTyCc8OmyfRPk6J3n3UvIODSG0PwPnVEmudyerq8AIbHQDiBSnYuq/3n2VfYrfh3o7dyTm42LkHazkd88vf1NQYuy3hNMjMu1dwLXiHN1wETDYyWuUhfTBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jN6ux4rW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756398071; x=1787934071;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ZeEpATc3yG+2ZfhU0QiMwUkrn5ohROR4JCkKzybZ1hA=;
  b=jN6ux4rWSmRXOShNsKXV2d+jVvEtAXewlTYfs15PNxs4nTtrY3Dqf1un
   5A/yt978l24xEo8mKTc4NgJk1iO4i8oEUVnZYHAc5FEixHt1xiLDbjOkK
   YqTysc/fDiO2B7uUvRksZcVmjyERQiBYRzpMIJSa/cxvxUR//hBvZ4mQ7
   uWsWPn+bYX40zjvxvN88jNwf95ZtEQ5FB7oD9HZu1V6aIgfe0icwMKfbt
   mPOnaigPI6Kqt8UnKzU7SQ674PdVksvUQjfpU53upmwGSWocxOA/KGJmy
   CF01BLafk1ouaCJpkJqVimWRRS6GI7MhM1zkdj9YpD6bjtazQl691WcDr
   Q==;
X-CSE-ConnectionGUID: b5nmVEtbT7aPhKOSpwmyKA==
X-CSE-MsgGUID: DPRXOp9vSXqtPWkJSbOaYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58619085"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58619085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:21:10 -0700
X-CSE-ConnectionGUID: 8aH4qTP6T+qWtCo7+xBgDQ==
X-CSE-MsgGUID: b/Myq2S8TLuj0mYOIA11hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="175431347"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:21:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Li Yifan <yifan2.li@intel.com>
Cc: xi.pardee@intel.com, Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250826034550.2284738-1-yifan2.li@intel.com>
References: <20250826034550.2284738-1-yifan2.li@intel.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: Add Bartlett Lake support to
 intel_pmc_core
Message-Id: <175639806138.20700.307320901060487185.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 19:21:01 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 25 Aug 2025 23:45:50 -0400, Li Yifan wrote:

> Add Bartlett Lake P-core only product support to intel_pmc_core
> driver. Bartlett Lake hybrid product reuses Raptor Lake model name
> so it is already enabled.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/pmc: Add Bartlett Lake support to intel_pmc_core
      commit: 3010da6ecf2225e41a79b06bc5f4c9750a4d35cb

--
 i.


