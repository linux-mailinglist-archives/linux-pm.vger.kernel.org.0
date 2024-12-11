Return-Path: <linux-pm+bounces-19013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D266C9ECC07
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 13:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8D2812F7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6D225A44;
	Wed, 11 Dec 2024 12:26:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABFC1AF0D8;
	Wed, 11 Dec 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919986; cv=none; b=E0ckk7w+Ggy6fggJiy5hl+UmcAFA8x+FWDnusOnwdl2SS459keuOTfFlcB2RbJBT3Lftr5XS7PvKGsn2+TPovyg/TopVl7t9CUPR6cdgbhKyStqkP96LGCvCymjrGC82pQJFK6zTT0OK3GBIpFC6yJY/oQPBjvyizfZW07wl1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919986; c=relaxed/simple;
	bh=CMD3gNybcJ5JjeDKCsz6o4vTu775eZsLLhca21py2y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HnCI1fdpcy1RKmzoestqnrMV81A43Ey5iYKUnrbo98gOP8OUqhgU1vQq8s9JYZ0LEsJFdLIIUInzAod2V4g9K9XcJ9pEwRCNfLJeU8r8FOyJ2kS+JnqgY24dZjwrIQNRLVFsSt9At7xXcEzCmS0aKHynrkKn36frYh5qWOPA7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B33F1063;
	Wed, 11 Dec 2024 04:26:52 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6AB93F5A1;
	Wed, 11 Dec 2024 04:26:22 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] cpufreq: Init epp_policy as CPUFREQ_POLICY_UNKNOWN
Date: Wed, 11 Dec 2024 12:26:03 +0000
Message-Id: <20241211122605.3048503-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a tiny cleanup for consistency, when offlining epp_policy are
reset to CPUFREQ_POLICY_UNKNOWN, but initialized to equivalent 0.

No functional changes intended.

Christian Loehle (2):
  cpufreq: amd-pstate: Use CPUFREQ_POLICY_UNKNOWN
  cpufreq: intel_pstate: Use CPUFREQ_POLICY_UNKNOWN

 drivers/cpufreq/amd-pstate.c   | 2 +-
 drivers/cpufreq/intel_pstate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--
2.34.1


