Return-Path: <linux-pm+bounces-7512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBAC8BC3CA
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 22:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA437B2176F
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 20:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D27602F;
	Sun,  5 May 2024 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Jv/P4lby"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44067174F;
	Sun,  5 May 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714942631; cv=none; b=j6u+cG9N7zHTevFAv27eFIKm7V8PrCK3KE/qmevlI7IaDeXQZgIBegFz+fxcogw4m9lZL+XzAUzGBtnE/W96OTSTByIe4SRPlhJ0vGaxl1FwilHgKJDO+aVZcRezquSjeD2hucwKTvc3KbT84sQhHkU8cta83YPOR2Rq7rPh1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714942631; c=relaxed/simple;
	bh=B0W+vFhgmBSPGwdf0igAW7QleTkDZUuNRB40wVINrOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wt+quEHsKpvVuPYjzurAV1PNBrR5VMHV1IGMHZ/75IlDIPiSKRDeYfPqh+zZWmtTAOxBZi4mRCl6K3xRFQkbtUEbvH3HQNV7gUto8qvF6pHRrDR3heqvpChH9DzLxXXsj2e6U2kCdZjRMro//NaIDqQelSPt88ZjF5BSy1LmHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Jv/P4lby; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714942625;
	bh=B0W+vFhgmBSPGwdf0igAW7QleTkDZUuNRB40wVINrOw=;
	h=From:Subject:Date:To:Cc:From;
	b=Jv/P4lbyVhju4wdemX7EsNEco9WGqnhVjNx+vIJol7hWrCK9rt3eSxG2Ky9J3v/Rh
	 W1y7KeJRPdYB68CQHxCHNrX0fxGvjb73qT57qg3SSKkEof4Pl3C/o3yIy9SPTtW/vY
	 MoZXNNIjTyh0DbYdox7xHnS8q6zx/C5P5OdYP7MA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] platform/chrome: cros_ec_framework_laptop: new driver
Date: Sun, 05 May 2024 22:56:33 +0200
Message-Id: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIHyN2YC/x3MQQqAIBBA0avErBNGsYKuEhFiUw2RxggVhHdPW
 r7F/y8kEqYEffWC0MWJYyjQdQV+c2ElxXMxGDQWG2yUl5gm8moRd9AdZVcaqTWdt61DB6U7hRZ
 +/ucw5vwBxkfUWWMAAAA=
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Dustin L. Howett" <dustin@howett.net>, Sebastian Reichel <sre@kernel.org>, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714942624; l=1281;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=B0W+vFhgmBSPGwdf0igAW7QleTkDZUuNRB40wVINrOw=;
 b=7SZMtKOLZiVnP8Zkzw94Pl6b5MmUhbhM+5g2NJXEdNPaEewFzxPoG8scSAC27+vjXJbhN/osb
 0O9Tr3zm8f3DsK4grjYsmdjSsAhnUUHg37cbW0ergdGO/6RpQVoxsWj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Framework Laptops are using embedded controller firmware based on the
ChromeOS EC project.
In addition to the standard upstream commands some vendor-specific
commands are implemented.

Add a driver that implements battery charge thresholds using these
custom commands.

Patch 1 adds the general scaffolding and device binding.
Patch 2 implements the battery charge thresholds.

This series is based on
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      platform/chrome: cros_ec_framework_laptop: introduce driver
      platform/chrome: cros_ec_framework_laptop: implement battery charge thresholds

 MAINTAINERS                                        |   5 +
 drivers/mfd/cros_ec_dev.c                          |  13 ++
 drivers/platform/chrome/Kconfig                    |  11 ++
 drivers/platform/chrome/Makefile                   |   1 +
 drivers/platform/chrome/cros_ec_framework_laptop.c | 173 +++++++++++++++++++++
 5 files changed, 203 insertions(+)
---
base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
change-id: 20240505-cros_ec-framework-10e627c46a0a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


