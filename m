Return-Path: <linux-pm+bounces-16747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284B9B6963
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 17:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3383B1C2089C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA332144DF;
	Wed, 30 Oct 2024 16:40:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F051E8850;
	Wed, 30 Oct 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306427; cv=none; b=iIsivaqbqQ63IKioj2kqNL3SmXP9FUe29Vc7/mFQ/PUS1R8LyiT1KdmauCJNpViK7PhluC+URGMQUoF46EgU2vGfI1OlrGftanpYyAsVLCC67PI7mX4Mq32xMfTvomcoU28VhX22D3J2ZePxt+zk75e+vPRLeCjfjj3Xu8ps7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306427; c=relaxed/simple;
	bh=NSy4djtGccEywLN35sQdUaatd50nn5ZqliN5AQah8/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5ddCaWAYjXUdQZ6qSMJmha/iW1td5jFyyl/QINPXuRt1sF3Vesd5L/UALXC4g/r+RsDEWWwvIa2YxqCO1a6PlqQyEEmNW3c8nGdvG0LHMfuKh6e3bH+KmmEhJ1ClGRNCEZ/TrXIlEhq4PVuy94oOwvJd1oujJnZbzZ8vakNIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52D76113E;
	Wed, 30 Oct 2024 09:40:53 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 484B73F528;
	Wed, 30 Oct 2024 09:40:22 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rafael@kernel.org
Subject: [PATCH v3 0/1] Update Energy Model with performance limits
Date: Wed, 30 Oct 2024 16:39:50 +0000
Message-ID: <20241030164126.1263793-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch set allows to specify in the EM the range of performance levels that
the device is allowed to operate. It will impact EAS decision, especially for
SoCs where CPUs share the voltage & frequency domain with other CPUs or devices
e.g.
- Mid CPUs + Big CPU
- Little CPU + L3 cache in DSU
- some other device + Little CPUs

The minimum allowed frequency will be taken into account while doing EAS task
placement simulation. When the min frequency is higher for the whole domain
and not driven by the CPUs in that PD utilization, than the energy for
computation in that PD will be higher. This patch helps to reflect that higher
cost.

More explanation can be found in my presentation at OSPM2023 [1].
I have shown experiments with Big CPU running high frequency and increasing
the L3 cache frequency (to reduce the latency), but that impacted Little
CPU which are in the same DVFS domain with L3 cache. It had bad impact for
total energy consumed by small tasks placed on Little CPU. The EAS was not
aware about the min frequency&voltage of the Little CPUs and energy estimation
was wrong.

Changelog:
v3:
- changed the new fields names 'min|max_perf_state' (Rafael)
- refactored em_pd_get_efficient_state() to take only 'pd' (Rafael)
- adjusted affected Doxygen descriptions to the above changes
v2 [3]:
- added mutex to guard simultaneous updates and make them atomic (Hongyan)
- added Doxygen two new arguments description (Dietmar)
- changed patch header description (Dietmar) and added an example
- dropped the SCMI patch for now, since the notifications are not merged there yet
v1 [2]:
- basic implementation

Regards,
Lukasz Luba

[1] https://www.youtube.com/watch?v=2C-5uikSbtM&list=PL0fKordpLTjKsBOUcZqnzlHShri4YBL1H
[2] https://lore.kernel.org/lkml/20240403162315.1458337-1-lukasz.luba@arm.com/
[3] https://lore.kernel.org/lkml/20241029094452.495439-1-lukasz.luba@arm.com/

Lukasz Luba (1):
  PM: EM: Add min/max available performance state limits

 include/linux/energy_model.h | 29 ++++++++++++++------
 kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 8 deletions(-)

-- 
2.46.0


