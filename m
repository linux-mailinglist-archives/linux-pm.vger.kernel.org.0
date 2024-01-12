Return-Path: <linux-pm+bounces-2157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CC82BFF6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C87E1F248BE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D359B57;
	Fri, 12 Jan 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkTk/XFB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483059B54
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705063751; x=1736599751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=77cP3GSp4MGPaP2lPdKK7cK+KaY+I91ht7QsrE6SX0U=;
  b=CkTk/XFBeGn1Zv2jeBYfshkMHJ/9wfHcBX/L+aReNzJgsI2byeokLm35
   UuD1kihFrmXrAzldi7X0G6YaYtGek5UaMacQ2bMJ2Nq/jEpzq6bLP5B0/
   nzMny31RQfoGVLZID/yW2zp+x/+9dwUBa+o2+nTOxXk9XAHQDmPmqk4Jh
   iRHdVGVPp+2dYsXkw7WhFkWjENpHaDocmqPAqpkfL4em+S7DfcukH6z3n
   VzsOFQ9+9sWGFO2BYnfYAAIdB/ArF7zRoYQ24xMsIndmvcKGC8i7dnwo/
   A6JsiPYMm7qDoKPz7bl+gBMhQmuTPYLJ/JWx70h2xlzBw7QLIGDUrwGX+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6525642"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6525642"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="17390854"
Received: from pwlazlyn-mobl.ger.corp.intel.com (HELO pwlazlyn) ([10.246.16.73])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:08 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 0/4] turbostat msr, perf controls and aperf/mperf via perf
Date: Fri, 12 Jan 2024 13:48:11 +0100
Message-Id: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Len!

Hope you had a teriffic Christmas break ;]

Sending the patches for tubostat that add --no-msr and --no-perf
options.  Rebased on top of v6.7.  The last patch also adds getting
aperf and mperf counters via perf API, which I believe you breifly
looked at, but It was before I rebased and had to make few more changes
since, so I expect some more comments on that.

Happy 2024!



