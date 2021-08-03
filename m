Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44023DEFF1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhHCOR0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 10:17:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbhHCORW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 10:17:22 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9u1wJpGMtbWdnTGUQRdrCSomsnMTyMd5qHawMI2kHG8=;
        b=cFXSjaZkfstd6O3SH1R3M/leX8ABTHIFinFVCgzBQNn7EHYrgPbb0JssWobdWM/0WF78JW
        J6wcHvwGBXMeT0RaH4E6K7LdCKVxTgzIS2IpQ8yvivN9bXAaJHcosomYBEBFqwYLTFAhGm
        QaEExjfkJVMAecy3GKO/Z8Gz0ag8a8X65Iem1Yq+ILaIINUcYSbMczhyHGVfcMu/cSiJsG
        dpp5gj7PmqiaLtDyqENlDfNebxo3FQ9C1xlUhTX+zd2XETsX/5id8LVistzUNiiYcj3OQr
        mdGMd2nMaGNCu03NqcuZHVenzTj+2IFvofXxWZm5AoxBQXIdmhTkMDPZOGrc6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9u1wJpGMtbWdnTGUQRdrCSomsnMTyMd5qHawMI2kHG8=;
        b=KbRg3It5nqDvHvuD3+uxxFMnEJl29/IuNSiRetYUBKkz7y1E5fGWfldcXoodixJFcUPRSm
        xhMc8MpmvTtaQhDQ==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: [PATCH 18/38] powercap: intel_rapl: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:01 +0200
Message-Id: <20210803141621.780504-19-bigeasy@linutronix.de>
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

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/powercap/intel_rapl_common.c | 50 ++++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_=
rapl_common.c
index 73cf68af97700..7c0099e7a6d72 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -158,16 +158,16 @@ static int get_energy_counter(struct powercap_zone *p=
ower_zone,
 	/* prevent CPU hotplug, make sure the RAPL domain does not go
 	 * away while reading the counter.
 	 */
-	get_online_cpus();
+	cpus_read_lock();
 	rd =3D power_zone_to_rapl_domain(power_zone);
=20
 	if (!rapl_read_data_raw(rd, ENERGY_COUNTER, true, &energy_now)) {
 		*energy_raw =3D energy_now;
-		put_online_cpus();
+		cpus_read_unlock();
=20
 		return 0;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return -EIO;
 }
@@ -216,11 +216,11 @@ static int set_domain_enable(struct powercap_zone *po=
wer_zone, bool mode)
 	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
 		return -EACCES;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rapl_write_data_raw(rd, PL1_ENABLE, mode);
 	if (rapl_defaults->set_floor_freq)
 		rapl_defaults->set_floor_freq(rd, mode);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return 0;
 }
@@ -234,13 +234,13 @@ static int get_domain_enable(struct powercap_zone *po=
wer_zone, bool *mode)
 		*mode =3D false;
 		return 0;
 	}
-	get_online_cpus();
+	cpus_read_lock();
 	if (rapl_read_data_raw(rd, PL1_ENABLE, true, &val)) {
-		put_online_cpus();
+		cpus_read_unlock();
 		return -EIO;
 	}
 	*mode =3D val;
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return 0;
 }
@@ -317,7 +317,7 @@ static int set_power_limit(struct powercap_zone *power_=
zone, int cid,
 	int ret =3D 0;
 	int id;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rd =3D power_zone_to_rapl_domain(power_zone);
 	id =3D contraint_to_pl(rd, cid);
 	if (id < 0) {
@@ -350,7 +350,7 @@ static int set_power_limit(struct powercap_zone *power_=
zone, int cid,
 	if (!ret)
 		package_power_limit_irq_save(rp);
 set_exit:
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
=20
@@ -363,7 +363,7 @@ static int get_current_power_limit(struct powercap_zone=
 *power_zone, int cid,
 	int ret =3D 0;
 	int id;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rd =3D power_zone_to_rapl_domain(power_zone);
 	id =3D contraint_to_pl(rd, cid);
 	if (id < 0) {
@@ -382,7 +382,7 @@ static int get_current_power_limit(struct powercap_zone=
 *power_zone, int cid,
 		prim =3D POWER_LIMIT4;
 		break;
 	default:
-		put_online_cpus();
+		cpus_read_unlock();
 		return -EINVAL;
 	}
 	if (rapl_read_data_raw(rd, prim, true, &val))
@@ -391,7 +391,7 @@ static int get_current_power_limit(struct powercap_zone=
 *power_zone, int cid,
 		*data =3D val;
=20
 get_exit:
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
@@ -403,7 +403,7 @@ static int set_time_window(struct powercap_zone *power_=
zone, int cid,
 	int ret =3D 0;
 	int id;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rd =3D power_zone_to_rapl_domain(power_zone);
 	id =3D contraint_to_pl(rd, cid);
 	if (id < 0) {
@@ -423,7 +423,7 @@ static int set_time_window(struct powercap_zone *power_=
zone, int cid,
 	}
=20
 set_time_exit:
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
=20
@@ -435,7 +435,7 @@ static int get_time_window(struct powercap_zone *power_=
zone, int cid,
 	int ret =3D 0;
 	int id;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rd =3D power_zone_to_rapl_domain(power_zone);
 	id =3D contraint_to_pl(rd, cid);
 	if (id < 0) {
@@ -458,14 +458,14 @@ static int get_time_window(struct powercap_zone *powe=
r_zone, int cid,
 		val =3D 0;
 		break;
 	default:
-		put_online_cpus();
+		cpus_read_unlock();
 		return -EINVAL;
 	}
 	if (!ret)
 		*data =3D val;
=20
 get_time_exit:
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
@@ -491,7 +491,7 @@ static int get_max_power(struct powercap_zone *power_zo=
ne, int id, u64 *data)
 	int prim;
 	int ret =3D 0;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rd =3D power_zone_to_rapl_domain(power_zone);
 	switch (rd->rpl[id].prim_id) {
 	case PL1_ENABLE:
@@ -504,7 +504,7 @@ static int get_max_power(struct powercap_zone *power_zo=
ne, int id, u64 *data)
 		prim =3D MAX_POWER;
 		break;
 	default:
-		put_online_cpus();
+		cpus_read_unlock();
 		return -EINVAL;
 	}
 	if (rapl_read_data_raw(rd, prim, true, &val))
@@ -516,7 +516,7 @@ static int get_max_power(struct powercap_zone *power_zo=
ne, int id, u64 *data)
 	if (rd->rpl[id].prim_id =3D=3D PL4_ENABLE)
 		*data =3D *data * 2;
=20
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
@@ -1358,7 +1358,7 @@ static void power_limit_state_save(void)
 	struct rapl_domain *rd;
 	int nr_pl, ret, i;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	list_for_each_entry(rp, &rapl_packages, plist) {
 		if (!rp->power_zone)
 			continue;
@@ -1390,7 +1390,7 @@ static void power_limit_state_save(void)
 			}
 		}
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static void power_limit_state_restore(void)
@@ -1399,7 +1399,7 @@ static void power_limit_state_restore(void)
 	struct rapl_domain *rd;
 	int nr_pl, i;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	list_for_each_entry(rp, &rapl_packages, plist) {
 		if (!rp->power_zone)
 			continue;
@@ -1425,7 +1425,7 @@ static void power_limit_state_restore(void)
 			}
 		}
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static int rapl_pm_callback(struct notifier_block *nb,
--=20
2.32.0

