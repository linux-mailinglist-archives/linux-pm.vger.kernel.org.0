Return-Path: <linux-pm+bounces-19446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477C9F6DD8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A12F169888
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0641FBCAF;
	Wed, 18 Dec 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmOPPqSD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB761FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549124; cv=none; b=nkFzE9OG/7tLjCNjz7HDUSTLy48skXD3iwlsV4+8hX1Lk2skVtbOF3R8FhCUHV/7mSA5XD0hZ9BvTTP4FVJcGJO+GHVFUFe9Za8RGqdkLlkKv9AhrN8vCXrEmj00q7bNZ8Xa1mrwnSfXKcH5KQeNOy9c+taITuIo0wF4tNcxkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549124; c=relaxed/simple;
	bh=glm69Gmz8ifTcu5mKnMoX0vQwezlmH72RNyF/Tk6CPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeHMS1kAZPSz63BLMdIQly0vgO5b/3jpkoqj+H6ggaJ8l4FLx60qGe7JshwRAFiipYvaogGCmMiWBLnhztFVfSuMr0nzK8VAa2xFNhdaXkSuPt+5gGcycagEAJt4c+eDufu61fmv6JRQoQKwlvX7k/yMupzGDjb1lqFGJzmaYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmOPPqSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AC7C4CECD;
	Wed, 18 Dec 2024 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549124;
	bh=glm69Gmz8ifTcu5mKnMoX0vQwezlmH72RNyF/Tk6CPA=;
	h=From:To:Cc:Subject:Date:From;
	b=JmOPPqSDp34aVqs0zVuspVf/oBXdyjFQD7M8H9ZSwgLJ/P1Xz9FinKsDzunYZxhnE
	 kUhGL9G6YDD+WOmvCkNsrq4EnVerhetOnTftcv5jvz/SrYzmlNZ4RN1TYNj0YyXkeC
	 GLatDoaDfVV/760EpeCQI4Rl2ptiEluSHyq9bKG0+7qvo/pDZFqNiQ5JMFlu8rljMg
	 0nBL910gwDvV4e7YXfbNd861ahY/m23RrfQH261NqQ4A0ORi4x1urm9sAzXFexN2Qf
	 uTZr5wDq3uLVy3/D6j3egRNmgwkGLUtZYM0W5jTaih6JgL0zUCh9jywgeKe8srMsRW
	 6itM9yydxwVoA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	shuah@kernel.org,
	trenn@suse.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 0/7] cpupower improvements on AMD systems
Date: Wed, 18 Dec 2024 13:09:49 -0600
Message-ID: <20241218191144.3440854-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

cpupower shows a number of errors on AMD systems configured
in 'active' mode where the hardware transitions states for
the user.

Clean up those errors and add some extra information for the amd-pstate
preferred core feature.

Mario Limonciello (7):
  cpupower: Remove spurious return statement
  cpupower: Add support for parsing 'enabled' or 'disabled' strings from
    table
  cpupower: Add support for amd-pstate preferred core rankings
  cpupower: Don't try to read frequency from hardware when kernel uses
    aperfmperf
  cpupower: Add support for showing energy performance preference
  cpupower: Don't fetch maximum latency when EPP is enabled
  cpupower: Adjust whitespace for amd-pstate specific prints

 tools/power/cpupower/lib/cpufreq.c        | 18 ++++++++++++
 tools/power/cpupower/lib/cpufreq.h        |  8 +++++
 tools/power/cpupower/utils/cpufreq-info.c | 36 +++++++++++++++++++++--
 tools/power/cpupower/utils/helpers/amd.c  | 18 +++++++++---
 4 files changed, 73 insertions(+), 7 deletions(-)

-- 
2.43.0


