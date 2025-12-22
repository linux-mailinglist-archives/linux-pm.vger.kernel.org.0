Return-Path: <linux-pm+bounces-39808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66597CD7192
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC099301559F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466A34677A;
	Mon, 22 Dec 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN0i/Hpm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48C345CD7;
	Mon, 22 Dec 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435890; cv=none; b=fba4LjnPbny/4kFjgwTCppfc1bLUN4kkxaDLNj5KkMPvIIeBTfAEHWRXpA3LIr7zFoCz/2IxwtQEBNin/NpO4R3daWR/F9TqQU2fuQZWdgadeNdouxb6TsUnuzdpMp5W4PceG6DM4nvMe4864Vh91sr8zJzxq8axp7hFPyweQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435890; c=relaxed/simple;
	bh=13hBlmRovUFLHkB/2BS2es/VlKAxV4dLlwSJdmWTynA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmBshL8otdkQWzhryYJbJT7d+oVFFY+iX1URYCQVCugy9/zIgXr6SmY3GTuMPY2COnnGR6O36qIzEa+eYqCmZSVe7iKajaMr7qUp2CXPT6LNNub1fVf0NHTp92TVqiEobP5hbQ3qS2CYkIvYkXmQkciLPrYRvyWCsQqRR6o9yrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN0i/Hpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD83C116D0;
	Mon, 22 Dec 2025 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435888;
	bh=13hBlmRovUFLHkB/2BS2es/VlKAxV4dLlwSJdmWTynA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AN0i/HpmuD/Jf7sepT/EB1J0aEbxYzfFOgvxDBCXcyCMonBcZsnE66RXGR6nXs8FT
	 TTkhMNX+x6GlnAHRjEHxC1yq6MygZiTr33FMHiD1yb2SsvLeJ4GNkNfloilYIfaQz5
	 yqx7VQ7JZZ7UubHoN0dHP9AQ60Fehi0FYMHjDBoZgHT1dtn+nWnPdZirc0iDxjJUDm
	 Mbnw+dPODufyIvyq13T1BhE4IXGKvL2cIfswoklFSYHvF8QHQg6bXUBn0VeYh7NtNW
	 XrBSCIlJd5kNYt77MssH6x70P4zb2ZOxYqqW6CaUKlBrN3OS9XQ/kphyN0wWwVfvM2
	 BymnM7/lfZAgA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject:
 [PATCH v1 04/23] drm/imagination: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 20:59:58 +0100
Message-ID: <8642685.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The Imagination DRM driver defines pvr_power_put() to pass the return
value of pm_runtime_put() to the caller, but then it never uses the
return value of pvr_power_put().

Modify pvr_power_put() to discard the pm_runtime_put() return value and
change its return type to void.

No intentional functional impact.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/gpu/drm/imagination/pvr_power.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/imagination/pvr_power.h
+++ b/drivers/gpu/drm/imagination/pvr_power.h
@@ -30,12 +30,12 @@ pvr_power_get(struct pvr_device *pvr_dev
 	return pm_runtime_resume_and_get(drm_dev->dev);
 }
 
-static __always_inline int
+static __always_inline void
 pvr_power_put(struct pvr_device *pvr_dev)
 {
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
 
-	return pm_runtime_put(drm_dev->dev);
+	pm_runtime_put(drm_dev->dev);
 }
 
 int pvr_power_domains_init(struct pvr_device *pvr_dev);




