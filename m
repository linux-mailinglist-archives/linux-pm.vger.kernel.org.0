Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664613DEFF2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhHCOR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 10:17:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhHCORW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 10:17:22 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRsxK9GZ6nFI6VodGYuBnw38AKr/uEtGEHDYZfi69/8=;
        b=Es6QNFuerxXYMYUmi2dnf/UpUXFOU5BZpPczCx6q1tAs0fs7tXnwnbsb8zJ/eRFge36k7D
        Nb72Of9GPR2XLFCZzD9JrhcOGyEpHcn1GWMjYAFsCxOQV8ciDov8Nu80hNafkfCwuPNyWm
        2xol5x1mwYKU0Xfsw9Hn7Aj4WTW/ksY7R1CdUUcbKvNqeO9oGMGyhZFFb8tp6LcuPt8fD5
        SdCdCUcK7BSyVSUlqMsjqx8hMPfoTPvb0AP05N+ch4CpQRDx5k1VjffwN/vCWTssKwiyrk
        sf+nHm2AJrcw9RdAA/icEpS3y8azDq9cu3f4TMNprYxgzPiOxq1odUM4jTTHwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRsxK9GZ6nFI6VodGYuBnw38AKr/uEtGEHDYZfi69/8=;
        b=Om3BvxS622lBsFKO7++i965k3w6Ba+2i8l7OTBJeWZs5b/6EvqS0Tulk2oUmtbiu7zYwiw
        M0uJwPgesY/Gu2BA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 19/38] thermal: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:02 +0200
Message-Id: <20210803141621.780504-20-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/thermal/intel/intel_powerclamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/int=
el/intel_powerclamp.c
index b0eb5ece9243b..a5b58ea89cc6d 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -528,7 +528,7 @@ static int start_power_clamp(void)
=20
 	set_target_ratio =3D clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
 	/* prevent cpu hotplug */
-	get_online_cpus();
+	cpus_read_lock();
=20
 	/* prefer BSP */
 	control_cpu =3D 0;
@@ -542,7 +542,7 @@ static int start_power_clamp(void)
 	for_each_online_cpu(cpu) {
 		start_power_clamp_worker(cpu);
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return 0;
 }
--=20
2.32.0

