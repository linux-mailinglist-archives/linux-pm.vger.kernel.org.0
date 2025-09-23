Return-Path: <linux-pm+bounces-35196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53756B95086
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED411900493
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156F31D377;
	Tue, 23 Sep 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3wXVvem"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036331BCA3;
	Tue, 23 Sep 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616824; cv=none; b=h4HerdR522a7d4tj8onP6/Wd0UllRbC3sW2aEodUH2Ct7iyO6axvkoxWZLQWhLclJFAILmIYQ3kTZSpvrSqHW13S9ObEQiIZg6ghX5+rUMmT8SwUixQ4D06gg2ISaFsNQ682x0TNfWUCood5h2deFKVE0fhtIag5X2zvm7WQooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616824; c=relaxed/simple;
	bh=0T5YvI7oXGfgfqD2MrSUTwY0OsPf11NBpOQYsioFh2Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P5/TX2mvlfDxvPDp43J++zGmqtmZwYf8nFmhlrXSF5u5LW9Seg9QQFNoFWi5HmmvEyabmD2xocVHf8g4QjO9VlChTsRC9py61a3cp0GWLNBbcxT3N3ihp3farOF3ge3bqGMPq0BcLeWkh9He53c3hnjOGaV4TOXfBFU7HETKeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3wXVvem; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758616824; x=1790152824;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=0T5YvI7oXGfgfqD2MrSUTwY0OsPf11NBpOQYsioFh2Q=;
  b=N3wXVvemqT0WhlkTg+OydofygzbRASs+fRMLepSTKRoZkKMBKZg8eaOq
   Bri/jOdQy9PL/Ja31cXknNG78hUy96weMMl5OQVZN4CZJAnWyXr5Y/QO0
   7MBP7JoHqc/BnV47U1CvoYNJBLlWM9xTOgAcqigwZpWZkEK0lZZWi12Ll
   vaAXUezzTmmBK4R9RkvZcy8n4ZOFtKFemZ3KCfn2pCDZfxK9G0nFTay56
   GdUe67iemtAcINDiaJcD7oP64uqAtuszRAX7Ovll+qvAZ6Us2iXCuNK2j
   h044W16SrW/dzeXd7/miT8gsjIkMkEHFDoAfZ/jRkPlrJ1ArP9FGlmJ6Z
   w==;
X-CSE-ConnectionGUID: R9fhJqRUTMa+aeYnkJGIiQ==
X-CSE-MsgGUID: 8vagAAG5QFOAzNkDsuEM+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71135537"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="71135537"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:40:23 -0700
X-CSE-ConnectionGUID: PZCXSkOxQOmK6hUgWXdWAQ==
X-CSE-MsgGUID: 1XknE6b0TCaoaqezrcQGWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="176291354"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:40:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250916191339.1748512-1-xi.pardee@linux.intel.com>
References: <20250916191339.1748512-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH] platform/x86:intel/pmc: Replace dev_warn() with
 dev_dbg()
Message-Id: <175861681457.3176.15667670615811075571.b4-ty@linux.intel.com>
Date: Tue, 23 Sep 2025 11:40:14 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 16 Sep 2025 12:13:32 -0700, Xi Pardee wrote:

> Replace dev_warn() with dev_dbg() to reduce unnecessary warning messages.
> When the low power mode priority register contains invalid data, the Intel
> PMC Core driver can still utilize the default priority list. This scenario
> is more suited for debug information rather than warning.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86:intel/pmc: Replace dev_warn() with dev_dbg()
      commit: bf726cdc9d4fabcf1ebd50f6fce5121acc7447bb

--
 i.


