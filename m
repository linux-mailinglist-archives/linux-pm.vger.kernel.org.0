Return-Path: <linux-pm+bounces-26384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC135AA0FEC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 17:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAA3B25C3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7521B9C1;
	Tue, 29 Apr 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+iIImQ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493F1DAC81;
	Tue, 29 Apr 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938929; cv=none; b=P1D9CxsEQ2p0WIbgvfssqUUE4R0MqOyiSKT3VqniWzZc18z1mGSP2kp9ZSl6f5P3UBLWu1SCWY3vrUuOMfraUnYCJ/J1qvE/rsYkcosu7sKLBtdRQtWfLiDXB1SGgLOTByy+Is6S4fkT+Po/2UYA/L8xq7U3tNuPYVdHkLHnZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938929; c=relaxed/simple;
	bh=CXyUkgUJ+Frrj1lxE9e4nGDb9q3jnTeEzXMZBRjwMCg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W2y+QM7Bo9zwMT/NFhoMlyZlwbSrk+DgJIXZEDmlYkoGr1qX85sqo/na+W+sqMc7lEgIFVCdCqbfZVP5r8EKDtlZdJ8luxaA5gt+ylwb1WjTOt8TcvcLv3FHUxKohlYt1GP2vAqbP187UKfnXv+i3latYhLvAlNsA8kfoy6LdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+iIImQ/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745938928; x=1777474928;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=CXyUkgUJ+Frrj1lxE9e4nGDb9q3jnTeEzXMZBRjwMCg=;
  b=B+iIImQ/Z9lcY5nh4eHyvgssFqYPVaX3BYw5jgWY27pa0PUUoFonrNDJ
   S8XDiirlgKMdVVbeFiX40j3RwHga47+sg8D82srYITgFyM2y25Wi/tGkW
   6i4fNYRL0QuVl8ZIg9ayOr46gK+PB/shbLskOoATXklRglE9QQd1XBx4I
   YQSbcv7V3q4XfI1wQU3hQGdFEEoz/mbnh1z3eEnffHnC8ZMB4Q7mxDhrH
   v9DkOLVn8x7GY/hi8030XYdX2u+kXYfzprXBsCfYyLJh+OTeILJdU+QFB
   gLjyiS+MhgqfCbnhIFGruQmWS/3+PbNzlKs0AFewb/ee/vah6wpZol9+w
   A==;
X-CSE-ConnectionGUID: KIJNvFzNQZy43ju3TGvjbA==
X-CSE-MsgGUID: 7OEtgm0qQamXjbey17zZZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="35179160"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="35179160"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 08:02:07 -0700
X-CSE-ConnectionGUID: lhuL/3jCRTGBN9KfmEd2Hg==
X-CSE-MsgGUID: QaAvmvplT1SptIJiB9729w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="138833173"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.205])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 08:02:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250425195237.493129-1-xi.pardee@linux.intel.com>
References: <20250425195237.493129-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH v5 0/5] Create Intel PMC SSRAM Telemetry driver
Message-Id: <174593891838.4147.15233566963314671509.b4-ty@linux.intel.com>
Date: Tue, 29 Apr 2025 18:01:58 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 25 Apr 2025 12:52:28 -0700, Xi Pardee wrote:

> This patch series removes the SSRAM support from Intel PMC Core driver
> and creates a separate PCI driver for SSRAM device. The new Intel PMC
> SSRAM driver provides the following functionalities:
> 
> 1. Search and store the PMC information in a structure, including PWRMBASE
> address and devid for each available PMC. Then Intel PMC Core driver
> achieves the PMC information using the API provided by the new driver.
> 2. Search and register Intel Platform Monitoring Techology telemetry
> regions so they would by available for read through sysfs and Intel PMT
> API. Intel PMC Core driver can achieve Low Power Mode requirement
> information from a telemetry region registered by the new driver.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86:intel/vsec: Change return type of intel_vsec_register
      commit: f6347ba78ad48eef2a79d2063d77a32d015c58af
[2/5] platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
      commit: f3d766cced899fa626e3f6f6ace43e16061ea19e
[3/5] platform/x86:intel/pmc: Use devm for mutex_init
      commit: 95350cbf5c4b7453d15990ad776b7b101fd6a290
[4/5] platform/x86:intel/pmc: Move error handling to init function
      commit: 75c7b75459efeb5b600d99421f3d08f485d33896
[5/5] platform/x86:intel/pmc: Improve pmc_core_get_lpm_req()
      commit: a946156129a6adb702dff43111c1d8cdab4f9362

--
 i.


