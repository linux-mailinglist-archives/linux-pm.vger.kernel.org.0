Return-Path: <linux-pm+bounces-17315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814599C3C5E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466D72813C5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2321990C0;
	Mon, 11 Nov 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0sWa1bv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4415B554;
	Mon, 11 Nov 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321970; cv=none; b=PDwRq1uUbi3hs2hHe3YTCiZ7/GhS07r2pvAZ2CzoP5DZV+bb/UlJCxy2cUHxKfAonOuy4DwZkl0UmsirBgHTsR8wnsNxJ0641ytF/mgvEqxnoiHR/0ScfsuIueQYvkAfl+Mp+/NCBDVcjc7Ou62RUmGxsWDkdy8rl3M+S/o4i7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321970; c=relaxed/simple;
	bh=5o6ue3Y/9WUhxE5zoGBuUR1NiMa8Zm6mQizx/j1vSgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mpeMLPAWyA0y0Zym6l41VZ+auIxS0EZMQIKnU9snSB4KRAQVS47szVDiL9T2dE9PcPKKok5b62EEWfMiLIRNI+QtqKl+Ie8IBPNGu82WWP7yd+bNgbmPNvDNBMXggMVSqDvZjJjoPxL+zoiAuhGj37L2zzjGqI/sMu4bCSWaJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0sWa1bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD3C4CECF;
	Mon, 11 Nov 2024 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731321970;
	bh=5o6ue3Y/9WUhxE5zoGBuUR1NiMa8Zm6mQizx/j1vSgs=;
	h=From:To:Cc:Subject:Date:From;
	b=u0sWa1bvI6RRro/9TkKiMUmt3YmLZ94glC4mudUvEXjdWX+PuEmF26kpDL3ctEEm6
	 RcfyAiV7OKSBgwFuDNWm76NsP5i3S5OrIwuE/aISRPPqMT0J2pJBnph2QvxzvcUV8N
	 I5HJEDsKYmi7WBRBb265h9Z2wjNHvkaI6WwWp+m0LLMeNsoTpnDDlK6PZVSIsbc/S7
	 VleBfxRAs5jzo+HoFtjdaNm1L6vMZ+v2uCbkjcbwLRb/Foq0d9YM6htWDdp5RjXqWU
	 XvBaQT953MAXh9zBbOqFoPGATO6/eI034ieh3ThGXjfg4sHkQhmKMhQ2YXrqHOml+W
	 rR9GJNxWz9mNQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: ti_sci: add CONFIG_PM_SLEEP dependency
Date: Mon, 11 Nov 2024 11:46:01 +0100
Message-Id: <20241111104605.3964041-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_PM_SLEEP, the pm_generic_suspend() function cannot be called
since it is defined to NULL:

In file included from include/uapi/linux/posix_types.h:5,
		...
                 from drivers/pmdomain/ti/ti_sci_pm_domains.c:10:
drivers/pmdomain/ti/ti_sci_pm_domains.c: In function 'ti_sci_pd_suspend':
include/linux/stddef.h:9:14: error: called object is not a function or function pointer
    9 | #define NULL ((void *)0)
      |              ^
include/linux/pm.h:875:41: note: in expansion of macro 'NULL'
  875 | #define pm_generic_suspend              NULL
      |                                         ^~~~
drivers/pmdomain/ti/ti_sci_pm_domains.c:134:15: note: in expansion of macro 'pm_generic_suspend'
  134 |         ret = pm_generic_suspend(dev);
      |               ^~~~~~~~~~~~~~~~~~

Fixes: 7c2c8d2651b5 ("pmdomain: ti_sci: add per-device latency constraint management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pmdomain/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
index 67c608bf7ed0..f92fa9b58bb0 100644
--- a/drivers/pmdomain/ti/Kconfig
+++ b/drivers/pmdomain/ti/Kconfig
@@ -11,6 +11,7 @@ config TI_SCI_PM_DOMAINS
 	tristate "TI SCI PM Domains Driver"
 	depends on TI_SCI_PROTOCOL
 	depends on PM_GENERIC_DOMAINS
+	depends on PM_SLEEP
 	help
 	  Generic power domain implementation for TI device implementing
 	  the TI SCI protocol.
-- 
2.39.5


