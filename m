Return-Path: <linux-pm+bounces-6061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EF89C894
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D256F287E93
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95CD1411F3;
	Mon,  8 Apr 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+luKZL4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65D2561F;
	Mon,  8 Apr 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590932; cv=none; b=YN4l4IHFVUfy+9LX1L9WaAYDWjmWqA3tZfsVhL4rs9i4/uJAo7A78iY+0o9nVV+RzPGmIvAke6/9Qz8o8Ls5UDUc23VyaD4A9EaL+FxrqV57qSZ62uzVOjybwLp+ll61xUuf66Ng4wY8pwW1Ldciqt1VtCiCVyEGxZB/rOrMhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590932; c=relaxed/simple;
	bh=AH28H53DqldJs4ww5n3whh1PzflM9wSUCYbhqULRZag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bytsSUN0UlIIN9vUny7pEVnRho1jKCl2HGWlhrAOzoWH6/DAN4PgfYNVcktCfXnILo9qZFQwGZuALatu6NXxoZSm0uTMJJeQk3pcLJSHmCiHFhbrMS/yZ64ADjzdZF7zuxToVsVrG4eSLsBS/qSdfPU06Mu9Pz501CcroAzmif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+luKZL4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712590932; x=1744126932;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=AH28H53DqldJs4ww5n3whh1PzflM9wSUCYbhqULRZag=;
  b=Y+luKZL4hPeZlrFPAqSGUK8xQqjqM2XQvkfzAj0abrckKJH57Ugh8c8n
   TEJ5akaWglvV7zIopVF9P7EEkKS7yuGcR+66plMFy2oJ+lVNgleh1Tje0
   69WZ5OcH0ATyBJ1q3nP2VjWz8DNjUrmFKAWyea2ka3PQzOOf5l469kmm5
   BZD/3MEJw3RdShh6KOr7+iNlPBCDaqOb4fQAd13cxUVE6k8sUgIu2h8Q4
   3RwSp7vGxAMqFXhS+VZoQT+T2Enov8YTzeWiDsMlEyIZ9NKINyPjV7/rt
   ZO+XiSxUOMM9NfkCipLBlgRVTWPWROCay7VNPxG3PvedSLVN5CkUHbRep
   A==;
X-CSE-ConnectionGUID: jfAJuWeWSQyix27MivDbFA==
X-CSE-MsgGUID: Of86VuttSFKP8j6TwHhRmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19018774"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19018774"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:11 -0700
X-CSE-ConnectionGUID: 16LSFUV3SBirKL7FH1jj9Q==
X-CSE-MsgGUID: ve+7XDGRQkG9pmWpAAYg2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24622267"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 David McFarland <corngood@gmail.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
 Enrik Berkhan <Enrik.Berkhan@inka.de>
In-Reply-To: <878r1tpd6u.fsf_-_@gmail.com>
References: <20240318191153.6978-1-corngood@gmail.com>
 <20240318191153.6978-2-corngood@gmail.com>
 <ed891842-a86f-4ca8-af29-f7921a259146@redhat.com>
 <878r1tpd6u.fsf_-_@gmail.com>
Subject: Re: [PATCH v2] platform/x86/intel/hid: Don't wake on 5-button
 releases
Message-Id: <171259092281.17776.17775713093698615601.b4-ty@linux.intel.com>
Date: Mon, 08 Apr 2024 18:42:02 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 04 Apr 2024 08:41:45 -0300, David McFarland wrote:

> If, for example, the power button is configured to suspend, holding it
> and releasing it after the machine has suspended, will wake the machine.
> 
> Also on some machines, power button release events are sent during
> hibernation, even if the button wasn't used to hibernate the machine.
> This causes hibernation to be aborted.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/hid: Don't wake on 5-button releases
      commit: 5864e479ca4344f3a5df8074524da24c960f440b

--
 i.


