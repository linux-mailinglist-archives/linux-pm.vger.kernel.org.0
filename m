Return-Path: <linux-pm+bounces-27030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8291FAB2BEE
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 00:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09444175625
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A926156E;
	Sun, 11 May 2025 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duJMGrNW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820F64D;
	Sun, 11 May 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002768; cv=none; b=bUR617f/tJCDs5BXL8nm4MvtVqH4NW8VuTBYkDykS0jtHm45nAxzMe/7Cw32pUIgBLqCjifsVZ51GUeCtVzRWLRblZ50NA0dnS3oSuvB+5wPIPaB+ya0hywWrjbO1Zn83dxzcX/4GWG9Ht5gcTDwo4ahdODvmKbl6DUTMnCJtzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002768; c=relaxed/simple;
	bh=zEr8YVTgxUuRemG9tXDQYzlbeBXo0eInFAWLvVMrc58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZJ3+n2rUAb3rOtNVMjkjpD/8vsZND96MXCODggZj9ObJhHjGL/yMHLZPTlrZs0BlR/q7nRb66qx1YnCTlwNbNnsy5D8MLXZWUkPSqXvH+iYdcZ//S7N8Ocv6xF/kNeS3ZeMjZndiY1jJCsq+fLioYsGGHG8LZ9monov2Ohrv11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duJMGrNW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747002766; x=1778538766;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=zEr8YVTgxUuRemG9tXDQYzlbeBXo0eInFAWLvVMrc58=;
  b=duJMGrNWA0fqilwsqnbMD9yIUMlF5VqUtNHV6kYNg5p9+8Q6fuIrhDmC
   w9qIJVIuSiaE/4sA54bGIooANU06L8mIjbPcX9ThBMUUgbJ9z1WFJTMDX
   QGRuc6StEinsLVF5bQ06j7vt0lbfkNkVMUzXtjBmJ2Rz/8pEhisFkTIjS
   KMJVSjj6T1pNGG9SXlU/6YC+OB8RsXPtcjTIz1MkL/13bUWwvtTp+bccG
   /wr22siHTbC77WGSd5e/oXRRueaBI6GA5xQbAkSu0V8h5UFFL1VCSxY/D
   NMIxlNxOL+kZSLK3vDJl3OGYRu6PO8fjDCg9Ep4VUw/FidOCUxCggnR3h
   A==;
X-CSE-ConnectionGUID: xsbJkyImSLS9iOI47jrsAQ==
X-CSE-MsgGUID: QdkRQuB7TzqsvaNq/GtPmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="60131767"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="60131767"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 15:32:44 -0700
X-CSE-ConnectionGUID: xDId60qfQney9Ln7vSKHjw==
X-CSE-MsgGUID: 6nWs04uSQRaXoOijCNk0nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="160450300"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 15:32:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc: sre@kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250429003606.303870-1-W_Armin@gmx.de>
References: <20250429003606.303870-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2 1/4] power: supply: core: Add additional health
 status values
Message-Id: <174700275600.13063.9398321342899509983.b4-ty@linux.intel.com>
Date: Mon, 12 May 2025 01:32:36 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 29 Apr 2025 02:36:03 +0200, Armin Wolf wrote:

> Some batteries can signal when an internal fuse was blown. In such a
> case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
> to perform meaningful diagnostics.
> 
> Additionally some batteries can also signal when some of their
> internal cells are imbalanced. In such a case returning
> POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
> applications to perform meaningful diagnostics.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] power: supply: core: Add additional health status values
      commit: e6b07a34038716e010d9fd1ac74c1d84a501f369
[2/4] platform/x86: dell-ddv: Implement the battery matching algorithm
      commit: 52e59cf1332dc4da5aecaa64c20f4a9f902e3186
[3/4] platform/x86: dell-ddv: Expose the battery manufacture date to userspace
      commit: 366a50722c7071120a494aaf91c9193922e3d8f6
[4/4] platform/x86: dell-ddv: Expose the battery health to userspace
      commit: d5251eef71bab8bd0b9ea3fe0005ad3d2553c3bb

--
 i.


