Return-Path: <linux-pm+bounces-9614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A990F4F0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC89B2188B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48015747F;
	Wed, 19 Jun 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4jS/Hux"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD315667E;
	Wed, 19 Jun 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817692; cv=none; b=EDEGAqNyt0UqzTbVXuLOSEcITnvh5pYkix/d/nDKha/Rfr8fkGUAyqaNRZc3nZPdjgTBpN8rKsGyZ4vF1XgEKwZo8cUSaFUEF76Zo0E6Xh01ERefkDzHPUacM/Ni6LohM8RRA8j4AjAwwtwb/LGnNA7AMqh/Xx5afjSKGzOL1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817692; c=relaxed/simple;
	bh=GOMfOjGpPzbqQerwH2FiS5nJKmYDeC/Xq1XiQ6rFh1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suSArAfaBr5YcKfQ4afp43yEU3r474aJdrlFpc5UPfiBSTf90IUgPY045W3z4mZU7e6LNKfgH42d0fGItTZqn92s7WpcILVNCt+pLTHl7wHV0Jr3XEeqI1vd1snQM/hz8OE8Yp46raeMwxu2DJ2YMqdpvSJkEmltAFYcCiAZ8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4jS/Hux; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718817690; x=1750353690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GOMfOjGpPzbqQerwH2FiS5nJKmYDeC/Xq1XiQ6rFh1U=;
  b=Z4jS/Hux1/cWORn8Lus5xdzazajGxc99Uds9Y89RJb4rfqrBDB7kUPHD
   3NFO0adKGMxS3+mixrFSnJiHycbrtJgl3WUPZgTzdeW7apOa0FZlu29e1
   uimj6CHDeXKsIdDSM4r1GWtjvx5w2PkHf+gXNOMIvTymlxcHHZorRHe7Q
   f6PNaNBJJnvY4A7BGI3XK5crmDHplKsoO7A7wi21gm2ch/TW3QJ24GpRC
   98miLV5Ich/z/u2H2lR6iRh6FaVhNKj+lOwyxLNMVZDzKE7IYBgP/ypW5
   SGuOdT58aCLbgpqETmdCP2PGQeoFxJI7iBu8zGyBk6lNhdFEcu6yUzyuh
   g==;
X-CSE-ConnectionGUID: 5ADrdKX+Tdu4KgaDo1iiSA==
X-CSE-MsgGUID: DLYHAE9NTdCuBvf7oAldqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15531161"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15531161"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 10:21:25 -0700
X-CSE-ConnectionGUID: uHcdJ619RfqVzqPHGjxVIQ==
X-CSE-MsgGUID: 4yxtOL11QhCVCeL43q6PjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41840025"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 10:21:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] Processor thermal interrupts for Lunar Lake
Date: Wed, 19 Jun 2024 10:21:06 -0700
Message-ID: <20240619172109.497639-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable MSI interrupts for Lunar Lake. Also enable Workload hint and power
floor support.

Srinivas Pandruvada (3):
  thermal: intel: int340x: Remove unnecessary calls to free irq
  thermal: intel: int340x: Support MSI interrupt for Lunar Lake
  thermal: intel: int340x: Enable WLT and power floor support for Lunar
    Lake

 .../processor_thermal_device.h                |   1 +
 .../processor_thermal_device_pci.c            | 116 ++++++++++++++----
 2 files changed, 91 insertions(+), 26 deletions(-)

-- 
2.40.1


