Return-Path: <linux-pm+bounces-27483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E07AC0467
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB0A21932
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 06:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5874922129E;
	Thu, 22 May 2025 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Q+rWL6qP"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC928F3;
	Thu, 22 May 2025 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894363; cv=none; b=VI/0jh6xekJJOaGpqgxmhRb4KDlch0GZ/fn4LssLvOO9M/f2ujN8Rlk/Gj17s64Piv8J+lArSbkkxiA2JK2Kxv9ZxtmjFsLiNiv6Jgsu0T98KT20B7+yuEteEWGGSBklDvVg+j5EutOBbcxm1UOna0lQDVCX4XaWx0K28JKEj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894363; c=relaxed/simple;
	bh=vTFSHwKixXnJKp7Guy4AgqQmaZ7Wr1XKl34JV5C9rfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=emA9zu8aBCbhf4zoi1yBrDIYLFBmT+tQleYrnBJVY2Ckp8mhJPzVzag+M8aeP0PPpXUTyjn9pneWY4ryMBSzQ4SXXD/rrjU+J9gXQx7JJdBi+RFW7Szt5uPAnj02HCgQouYfptvRNWSjjw5WtuefChm3hMnlz7iZ7jyZ8sO/VPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Q+rWL6qP; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1747894361; x=1779430361;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vTFSHwKixXnJKp7Guy4AgqQmaZ7Wr1XKl34JV5C9rfM=;
  b=Q+rWL6qP8GhopSYrRi0Aj0CRW64RMpPlvJPMKjT/KFepltAP/p+mRe+a
   l+np/Vrx3/Nt/DQpvMrbMJzRHgNp/LUMSRaRV82GU72Pr+LZTiRdvabGn
   MKmHg3xYREKXYHNVo25MudH2rCcg56Mfsb5Fe+yyNy8AB0P78ndd/q+5z
   m0iArVEZv+dtojYRvIkoFM1x1n4wP008vX/lCBnZYh9qnnjYk0QdSdOPH
   4fx8qZzd48cH4vw4XBaNlmopIfKD7W2e+QjKHUKtUHo8ZCTnoLDKyjQAI
   JoJnVnKd6QJmYO3li1bFI4nm18IOzX8YZYhjGdOfu8w96w/yFbG2hPuGH
   g==;
X-CSE-ConnectionGUID: mdmp7stMSHOkz2fJWve4qw==
X-CSE-MsgGUID: ag83AblNSGGjqHklyE6vkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="199488400"
X-IronPort-AV: E=Sophos;i="6.15,305,1739804400"; 
   d="scan'208";a="199488400"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 15:11:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 93CADD9431;
	Thu, 22 May 2025 15:11:26 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 69C20C8BF7;
	Thu, 22 May 2025 15:11:26 +0900 (JST)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om3.fujitsu.com (Postfix) with ESMTP id 0F95B400585BA;
	Thu, 22 May 2025 15:11:26 +0900 (JST)
From: Shinji Nomoto <fj5851bi@fujitsu.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Shinji Nomoto <fj5851bi@fujitsu.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86 based systems with boost support.
Date: Thu, 22 May 2025 15:10:57 +0900
Message-ID: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq subsystem has a generic sysfs interface for controlling boost
(/sys/devices/system/cpu/cpufreq/boost).
The sysfs interface can be used to enable boost control from the cpupower
command on non-x86 platforms as well. So, allow boost controlling on
non-x86 system if boost sysfs file exists.

The set subcommand enables/disables the boost feature using the following
syntax:
  cpupower set --boost 1
  cpupower set --boost 0

The --boost option is an alias for --turbo-boost. We provided the neutral
option name because the name "turbo boost" is specific to Intel technology.

The frequency-info subcommand displays the enabled/disabled state of
the boost feature as follows:
  boost state support:
    Active: yes (or no)

Additionally, there was an existing bug in the option handling,
which I fixed in the first commit.  The fix is independent of the added
functionality.

Shinji Nomoto (2):
  cpupower: Fix a bug where the -t option of the set subcommand was not
    working.
  cpupower: Allow control of boost feature on non-x86 based systems with
    boost support.

 tools/power/cpupower/man/cpupower-set.1      |  7 +-
 tools/power/cpupower/utils/cpufreq-info.c    | 16 ++++-
 tools/power/cpupower/utils/cpupower-set.c    |  5 +-
 tools/power/cpupower/utils/helpers/helpers.h | 14 ++--
 tools/power/cpupower/utils/helpers/misc.c    | 76 ++++++++++++++------
 5 files changed, 83 insertions(+), 35 deletions(-)

-- 
2.43.0


