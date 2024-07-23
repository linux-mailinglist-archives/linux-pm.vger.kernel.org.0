Return-Path: <linux-pm+bounces-11332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAE793A230
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42588B22312
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E16153803;
	Tue, 23 Jul 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzugohvN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456B8814;
	Tue, 23 Jul 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743363; cv=none; b=pHF+SU/hVINvDCmsuiSJDPT18odlUepbaUcbvZ45qArrmzsVD4rrtN9Hu9Z5BL3Urnm/87ks+5ypYCr7IUbIGnSLSSIE7aeRP2ozop4QXo2DJR+qrIdykNzCxiUKWDmg5tqWR0trrC9giFjsYFMZFmlhdCSUDV+wtsZcaQrAkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743363; c=relaxed/simple;
	bh=S9KjeWnrXMvhSu9TioKq6ZgMPjPq268U2Er5nW8iUys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V63O+QinBXatjD9n4zoIDdzy8dKbVrivoycYnUsYWaR2KPdqM2n3k/+k17xsPYZKlufjQy2LibNcOMQdqeoS9StZEMIJoGEmubSSxtjdShl1LMGMxe6xHAeuHpSllMr1LS94yTeeeC6fJxamB4TsHScbEi/6uV9DZaMu1kT39wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzugohvN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721743361; x=1753279361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S9KjeWnrXMvhSu9TioKq6ZgMPjPq268U2Er5nW8iUys=;
  b=bzugohvNvCa+aTry2yDJ7Y+iI0r+KV/YPn/du3ACjIfok121oNvNKk13
   06iUQlLcn58vbeUV50FmdwFNeebEoT8RdSjGU0P1YNHiSP+eqwhVwDI5B
   Qf07fo0maKUTVFXzySq2aPluyeUB38A7YyY+ogBVfIbyRTDF+MnqVRopc
   JS1FdpG4CCvnxOQQqO3W+rE7NulaWynQophqQmGf0fqpjl+G410Gx3Dna
   rhCC2euduVRKylqG7rBsFlo8oNepebm0g4C6B+DprCLj1t+zeoG3q1yJ0
   Kd0kTJF88yh0gPtWDtGDCEfQpP7/KEAVtMvj3oLhbcdBfH28RpNNfABiK
   g==;
X-CSE-ConnectionGUID: ki7wDLTqQ7CPWyqEmpA9dA==
X-CSE-MsgGUID: j2IWleO9SCuX85lpJC9/zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19518122"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19518122"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 07:02:33 -0700
X-CSE-ConnectionGUID: xMDgwQMpR4Wozc3Pg1z9qA==
X-CSE-MsgGUID: a7t9v9CKQ1mX/bMMuS58RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56546555"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2024 07:02:33 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yijun.Shen@dell.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] thermal: intel: int340x: Fix Lunar Lake MSI support
Date: Tue, 23 Jul 2024 07:02:25 -0700
Message-ID: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some pre-production systems, there is a partial support for thermal
interrupts. This cause kernel warning and fail to register TCPU sensor.

This series address these issues.

Srinivas Pandruvada (3):
  thermal: intel: int340x: Fix kernel warning during MSI cleanup
  thermal: intel: int340x: Allow limited thermal MSI support
  thermal: intel: int340x: Free MSI IRQ vectors on module exit

 .../processor_thermal_device_pci.c            | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.45.0


