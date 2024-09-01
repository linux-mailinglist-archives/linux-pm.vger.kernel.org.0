Return-Path: <linux-pm+bounces-13297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D24967438
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 04:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0992FB21D13
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 02:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083021350;
	Sun,  1 Sep 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNz/fH05"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BBB2901;
	Sun,  1 Sep 2024 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725158974; cv=none; b=ZLxvMg+afVpp6S0jIdjAQuw7HWFm6XlR/I3y6QsS3AZG9Kpqgdv4V3WSnJinJDL8ALen4T5NQhXfYgfRLubndwxe9ZaCYEwyNaRDu1+Q2jg+PX4ItrIE2gUkhb9nhVhyo1QaWtddUu0KOougE3ErNFb2MZPgtGgFuodL1ANE4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725158974; c=relaxed/simple;
	bh=7LKuiQCsNe+/DITCdIumfkr/HTWI1Tzhg1dQyEA4igY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M18Pmu9Zngcafwm6ttNpFhJTtfpQMiCR85yJFymoYJHZ7c7v96xorQ8ENHvHwznliXtfXtXvwqhJUZSmonbMpAbRhFE4VKJGjE5qxOtAlYOiUl/tV9FP5St/EMG91FqtKvq3/4JXUkSuJsWWCoRtPrk9GeizrddeEZA/6mLNxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNz/fH05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B37EC4CEC0;
	Sun,  1 Sep 2024 02:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725158973;
	bh=7LKuiQCsNe+/DITCdIumfkr/HTWI1Tzhg1dQyEA4igY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZNz/fH05jvw3JLjRlPhOureJcGdpzG0UIrQeodnbC8Wj1NY9yNDqRVBabsWuI5qYh
	 aoi4q7Ut8tLulH3caFihJmaSS3pqvxz9FVvSVlX5ZQlK7ibkTA2frIIQsuynRu+lY+
	 zp58v6b+XMDoN6LrfnHGwo3v1ScqzBO7PWyxUDRFfAF65WQFjn/P2ETzg7yncFzNwN
	 bDUbNtONuAf7mL8jZFtZzlVBjeLriqQZyaLfHLPVrUHYykMdAEsGT1zmDU5FeHgJOi
	 wqOjdl9KehjjCIITYSMxliUDkZBVt3lQzpAmb23j1/e6WJ53TyTtGvUyNy7d++CC8o
	 5DpLb3KXF59iA==
From: Mario Limonciello <superm1@kernel.org>
To: Meng Li <li.meng@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	ptr1337@cachyos.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] amd-pstate: Add unit tests for state machine
Date: Sat, 31 Aug 2024 21:49:10 -0500
Message-ID: <20240901024912.1217014-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The state machine for amd-pstate allows changing from any supported
mode to another.  This is a relatively large matrix of possible moves
that doesn't have test coverage.

Walk through the matrix as part of amd-pstate-ut tests to make sure
that all transitions work.

Mario Limonciello (2):
  cpufreq/amd-pstate: Export symbols for changing modes
  cpufreq/amd-pstate-ut: Add test case for mode switches

 drivers/cpufreq/amd-pstate-ut.c | 41 ++++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.c    | 23 ++++++++----------
 drivers/cpufreq/amd-pstate.h    | 14 +++++++++++
 3 files changed, 64 insertions(+), 14 deletions(-)

-- 
2.43.0


