Return-Path: <linux-pm+bounces-37663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB3C429C3
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAC0188C3C1
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6084E2D839F;
	Sat,  8 Nov 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHpODTU3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E1285074;
	Sat,  8 Nov 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762591781; cv=none; b=FVqiQJ3wd33tySb0o3h3w1FYuz8i/HSLsyvyQBTSQEUCL2l+3Jz5se3OHCOHmsZnoPObVefKORA9WHxliIj3FGo/WD4EAGkZrEdof8i8nGEdHOYZL87oE1SBuZxEAHxKp+8nG/MJ1YDKf7GKH9g4pBEWvVSaU+cpEZt0DmOYIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762591781; c=relaxed/simple;
	bh=mnsX5oZvc6KicplQGBev1Go5Sm9jz8nOYybtSPtKzvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwTcC5HbO/ekF929uWF9pZGwiFjaZaKczqMBHU6YbClzxI5gKC1KofbBECY6567oOkAbfDjVad8I+kbNxMZKH+XGvRqZwTyujoT0SZxTZq/zExsXaena/TtqzRlk+7amhWIunVOg1UrbEgcpjncphVccHGbOqeWVstTEJxd5yWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHpODTU3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762591779; x=1794127779;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mnsX5oZvc6KicplQGBev1Go5Sm9jz8nOYybtSPtKzvk=;
  b=RHpODTU3gCejSloVvv3U58KmCC4W4pR1IbnMbN/s/DfvV76Q5K73IlvG
   Xd6uGzyb3LuUpatrBFpxHkWGf9s+WO26Ey7MsyRrnbJATo190Hh+Sq23T
   EAh8rrVYvrIixSCuQM2H3TGp19Owvlwz48uHZju7mWKJW4uQ4iglsJ4DX
   ccXPeR58oh0Ly5IgvZQBYgVv85Wya/WFw+Zci46rVtOOaa4FCpoVd2hfF
   PWxz9bC6PLB7GPiQcwj7q1rKEt6OBtVWGQ4AEmflK0N9zaDcZDu9hd4y3
   jHVWPfYwW92wgWTPVghzdu4x8Ebc1hUiIKgMbArbMftrjXXZv2uX21sWN
   A==;
X-CSE-ConnectionGUID: EJ8xo80bTcaCRuxHVl+msA==
X-CSE-MsgGUID: KEJ33fldSB+BdIeFsGKgRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64655658"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64655658"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 00:49:38 -0800
X-CSE-ConnectionGUID: xBVhfPaBT+2fMxRrPhEZrA==
X-CSE-MsgGUID: l4ReFr9QSXyld3hn68hOaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="187500245"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 00:49:39 -0800
Received: from [10.245.245.139] (abityuts-desk.ger.corp.intel.com [10.245.245.139])
	by linux.intel.com (Postfix) with ESMTP id BF6BB20BA6F5;
	Sat,  8 Nov 2025 00:49:36 -0800 (PST)
Message-ID: <f1194b6840459447f36e5d387320ef295aa8166d.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpuidle: Add sanity check for exit latency and
 target residency
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>
Date: Sat, 08 Nov 2025 10:49:35 +0200
In-Reply-To: <12779486.O9o76ZdvQC@rafael.j.wysocki>
References: <12779486.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 20:07 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Make __cpuidle_driver_init() fail if the exit latency of one of the
> driver's idle states is less than its exit latency which would break
> cpuidle assumptions.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

LGTM

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>


By the way, I have a more paranoid validation patch, which validates
latency and also more. Sure I can rebase it later on top of this
patch.=C2=A0

I did not have time to polish it yet, but sharing just in case there is
a quick feedback.

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH] cpuidle: Add idle states validation

Validate the idle states table provided by the underlying idle driver. For
example, validate that deeper idle states have greater latency and target
residency compared to shallower states.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/cpuidle/driver.c | 58 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 9bbfa594c4425..6bcedad534dd9 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -20,6 +20,10 @@
=20
 #include "cpuidle.h"
=20
+/* Maximum allowed latency and target residency values */
+#define MAX_LATENCY 50000 /* 50 milliseconds */
+#define MAX_RESIDENCY 1000000 /* 1 second */
+
 DEFINE_SPINLOCK(cpuidle_driver_lock);
=20
 #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
@@ -148,11 +152,46 @@ static void cpuidle_setup_broadcast_timer(void *arg)
 		tick_broadcast_disable();
 }
=20
+/**
+ * validate_state - Validate an idle state.
+ * @state: The C-state to validate.
+ * @prev_state: The previous idle state or NULL.
+ *
+ * Return: 0 if the idle state is valid or -EINVAL otherwise.
+ */
+static int validate_state(struct cpuidle_state *s, struct cpuidle_state *p=
rev_s)
+{
+	if (s->exit_latency =3D=3D 0)
+		return -EINVAL;
+
+	if (s->exit_latency > MAX_LATENCY)
+		return -EINVAL;
+
+	if (s->target_residency > MAX_RESIDENCY)
+		return -EINVAL;
+
+	if (s->target_residency < s->exit_latency)
+		return -EINVAL;
+
+	if (!prev_s)
+		return 0;
+
+	if (s->exit_latency <=3D prev_s->exit_latency)
+		return -EINVAL;
+
+	if (s->target_residency <=3D prev_s->target_residency)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * __cpuidle_driver_init - initialize the driver's internal data
  * @drv: a valid pointer to a struct cpuidle_driver
+ *
+ * Return: 0 on success, -EINVAL in case of invalid C-state data.
  */
-static void __cpuidle_driver_init(struct cpuidle_driver *drv)
+static int __cpuidle_driver_init(struct cpuidle_driver *drv)
 {
 	int i;
=20
@@ -166,6 +205,17 @@ static void __cpuidle_driver_init(struct cpuidle_drive=
r *drv)
=20
 	for (i =3D 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s =3D &drv->states[i];
+		struct cpuidle_state *prev_s;
+
+		if (i > 0)
+			prev_s =3D &drv->states[i - 1];
+		else
+			prev_s =3D NULL;
+
+		if (validate_state(s, prev_s)) {
+			pr_err("Idle state '%s' validation failed\n", s->name);
+			return -EINVAL;
+		}
=20
 		/*
 		 * Look for the timer stop flag in the different states and if
@@ -194,6 +244,8 @@ static void __cpuidle_driver_init(struct cpuidle_driver=
 *drv)
 		else
 			s->exit_latency =3D div_u64(s->exit_latency_ns, NSEC_PER_USEC);
 	}
+
+	return 0;
 }
=20
 /**
@@ -223,7 +275,9 @@ static int __cpuidle_register_driver(struct cpuidle_dri=
ver *drv)
 	if (cpuidle_disabled())
 		return -ENODEV;
=20
-	__cpuidle_driver_init(drv);
+	ret =3D __cpuidle_driver_init(drv);
+	if (ret)
+		return ret;
=20
 	ret =3D __cpuidle_set_driver(drv);
 	if (ret)
--=20
2.51.0


