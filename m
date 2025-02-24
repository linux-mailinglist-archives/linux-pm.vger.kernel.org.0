Return-Path: <linux-pm+bounces-22831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C89A429FB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B83F17DE7C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155C264A89;
	Mon, 24 Feb 2025 17:34:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492CA26280C;
	Mon, 24 Feb 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418488; cv=none; b=TzTbQWkkcnODNIhjsTOddNl+NdvT1LM2bYYEjfh8VcpdjBXuQlbyF7OET3nEhbvbogVfscuK3mRw+9tg4yqIJEPGQrTcL11lmEAdxsjJuyrOl4t8gld1oyV8azKqUhHC8mm17mAxUp1QjD39IBOiDhXR7JhN60RKAsWLk881mmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418488; c=relaxed/simple;
	bh=edUuCxZmNUmLsPyfgUJoQW+TCJ/+pdgsueE2Hpek9Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYc6gYfSSOpkVbooiPXLzX56njCBsGL7cUqKy+0fmYUWgB874+6rGhLREZ47olsjuF+VRZa/obINELUm6I5KHCBDAYXPqXj+CUoESKcI11ROe12HHnnh6hQ4rtJR+it0Whl2HIYqiuviUlGFYzPRajuIVtD+S6LxhzgrG8FaXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF52152B;
	Mon, 24 Feb 2025 09:35:02 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA1353F5A1;
	Mon, 24 Feb 2025 09:34:43 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 0/4] Thermal: clean-up with kcalloc()
Date: Mon, 24 Feb 2025 17:33:02 +0000
Message-ID: <20250224173432.1946070-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is just small clean-up inspired by this patch [1].
It aims to keep the thermal framework up-to-date with the
recommendations in the community [2]. If there are (or will be)
some static checks in this area, we will be OK.

The patches are on top of latest thermal/linux-next branch

Regards,
Lukasz Luba

[1] https://lore.kernel.org/lkml/20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com/
[2] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Lukasz Luba (4):
  thermal: OF: Use kcalloc() instead of kzalloc() with multiplication
  thermal: k3_j72xx_bandgap: Use kcalloc() instead of kzalloc()
  thermal: int340x: Use kcalloc() instead of kzalloc() with
    multiplication
  thermal: hisi: Use kcalloc() instead of kzalloc() with multiplication

 drivers/thermal/hisi_thermal.c                               | 4 ++--
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 4 ++--
 drivers/thermal/k3_j72xx_bandgap.c                           | 4 ++--
 drivers/thermal/thermal_of.c                                 | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.48.1


