Return-Path: <linux-pm+bounces-1971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29F828367
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 10:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB091C24DAB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8645364B4;
	Tue,  9 Jan 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwEAsIdC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B7364A0
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso30536695e9.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2024 01:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704793289; x=1705398089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7MJiCvLo/jKmCJa7CzUVzvfGfV/pr2Rtd+bWShZcMg=;
        b=GwEAsIdCvsvbtGtNEpkrPXZxUe2c2FW4fwG65vVzcUksoxtDTT8rYE/XSzTt2lfik3
         ZNA1HUWLjF7bIjiWfi103DcjrEk8nKqc1BjbxEKpM8hdclNurydvyEaeScnwR9IYrToD
         DddUwkcbZp8J7+cEybpuekoeaYPVNwREA9oyza3hvuK4h6p+z6jlKj9IIkZf/1Og7TR8
         xi3CEAWrWK0wY/OUw4O4N/4LqSiOwhxSRsS5JTORHbm0yTdERKQthsfQQemz0tGAFw3c
         wX2Zq2X8pa9EuLHPfJJ6OeU1j/7AgdcvL9t3podrzKoH11Cl2jF9wRkReblY/z+eX+av
         hl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704793289; x=1705398089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7MJiCvLo/jKmCJa7CzUVzvfGfV/pr2Rtd+bWShZcMg=;
        b=G+mXOGFem6Z92gSUskWSEODBnzqMtshl+H+upWw3Bqbvl905S2o9PpyFrAHGLTyA8Q
         NoLqXGPY6msa8wXuaQzTw6TzV3Ii+FKjnM8q3u+ksg5a5uLcVnUPp9zIDk4t6CsZmfyz
         /NOrQcwlpPRhoEP+gGx8AhIH9e4p8dtTMiZwm5fVrizm+O4VCaYvkZo2LXYs5dVUARBX
         pGNxyAFlh2SG7HjvYrsLwV9hHg+eSuWk5pvzZr41Vopa8w5Z3CB55ksambfYcf4w7trF
         NzyejfmZxYl7aRrm2HhFxPLhYksMGURLG6xauS46GDcLnSnio853C+kwvz3jaMD1Y9Sn
         CS2g==
X-Gm-Message-State: AOJu0YzNrVEo8JPUD4gPNIt5GXXmVMFblRm/uI+H7/H5KicPh/xh2KAf
	epN3SGZQzAL9FON3bsQfGEx2JG3ep8956g==
X-Google-Smtp-Source: AGHT+IEHPpzN1dUWfpuTGUQRmBClJbT0l7QjJbXwvM8fesxSis6UKISNmpnW+ZXOJGcKs+XIyhoU9w==
X-Received: by 2002:a05:600c:190e:b0:40d:5ca1:80bc with SMTP id j14-20020a05600c190e00b0040d5ca180bcmr2463647wmq.107.1704793288692;
        Tue, 09 Jan 2024 01:41:28 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id jg28-20020a05600ca01c00b0040e45518c1csm2803863wmb.18.2024.01.09.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:41:28 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rjw@rjwysocki.net,
	lukasz.luba@arm.com
Cc: rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 2/2] thermal/debugfs: Add thermal debugfs information for mitigation episodes
Date: Tue,  9 Jan 2024 10:41:12 +0100
Message-Id: <20240109094112.2871346-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109094112.2871346-1-daniel.lezcano@linaro.org>
References: <20240109094112.2871346-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mitigation episodes are recorded. A mitigation episode happens
when the first trip point is crossed the way up and then the way
down. During this episode other trip points can be crossed also and
are accounted for this mitigation episode. The interesting information
is the average temperature at the trip point, the undershot and the
overshot. The standard deviation of the mitigated temperature will be
added later.

The thermal debugfs directory structure tries to stay consistent with
the sysfs one but in a very simplified way:

thermal/
 `-- thermal_zones
     |-- 0
     |   `-- mitigations
     `-- 1
         `-- mitigations

The content of the mitigations file has the following format:

,-Mitigation at 349988258us, duration=130136ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |     130136 |     68227 |     62500 |     75625 |
|    1 |  passive |     75000 |      2000 |     104209 |     74857 |     71666 |     77500 |
,-Mitigation at 272451637us, duration=75000ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |      75000 |     68561 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      60714 |     74820 |     70555 |     77500 |
,-Mitigation at 238184119us, duration=27316ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |      27316 |     73377 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      19468 |     75284 |     69444 |     77500 |
,-Mitigation at 39863713us, duration=136196ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |     136196 |     73922 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      91721 |     74386 |     69444 |     78125 |

More information for a better understanding of the thermal behavior
will be added after. The idea is to give detailed statistics
information about the undershots and overshots, the temperature speed,
etc... As all the information in a single file is too much, the idea
would be to create a directory named with the mitigation timestamp
where all data could be added.

Please note this code is immune against trip ordering but not against
a trip temperature change while a mitigation is happening. However,
this situation should be extremely rare, perhaps not happening and we
might question ourselves if something should be done in the core
framework for other components first.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog:
  - v6
    - Renamed s/tz_event/tz_episode/ (Rafael)
    - Used number of trip point crossed and loop through the stored
      ones in order to be immune to trip point reordering (Rafael)
    - Fixed variable names in description (Rafael/kbuild)
    - Used macro for_each_trip (Rafael)
    - Removed blank line (Rafael)
    - Fixed tz_events structure description (Rafael)
  - v5
    - No changes
  - v4
    - Reworded "trip violation" (Rafael)
    - Reworded some comments and clarified other ones (Rafael)
    - Renamed s/tz/tz_dbg/ for clarity (Rafael)
    - Used flexible array and struct_size for allocation (Rafael)
    - Renamed s/dfs/thermal_dbg/ for clarity (Rafael)
    - Used intermediate variable to prevent dereferencing multiple times a structure (Rafael)
    - Renamed variable s/trip/trip_id/ (Rafael)
    - Clarified trip_index usage in the comment (Rafael)
  - v3
    - Fixed kerneldoc (kbuild)
    - Fixed wrong indentation s/<space>/<tab>/
  - v2
    - Applied changes based on comments from patch 1/2
    - Constified structure in function parameters
  - v1 (from RFC):
    - Replaced exported function name s/debugfs/debug/
    - Used "struct thermal_trip" parameter instead of "trip_id"
    - Renamed handle_way_[up|down] by tz_trip_[up|down]
    - Replaced thermal_debug_tz_[unregister|register] by [add|remove]
---
 drivers/thermal/thermal_core.c    |   7 +
 drivers/thermal/thermal_debugfs.c | 399 +++++++++++++++++++++++++++++-
 drivers/thermal/thermal_debugfs.h |  14 ++
 3 files changed, 416 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 33332d401b13..a0cbe8d7b945 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -367,6 +367,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 			thermal_notify_tz_trip_up(tz->id,
 						  thermal_zone_trip_id(tz, trip),
 						  tz->temperature);
+			thermal_debug_tz_trip_up(tz, trip);
 			trip->threshold = trip->temperature - trip->hysteresis;
 		} else {
 			trip->threshold = trip->temperature;
@@ -386,6 +387,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 			thermal_notify_tz_trip_down(tz->id,
 						    thermal_zone_trip_id(tz, trip),
 						    tz->temperature);
+			thermal_debug_tz_trip_down(tz, trip);
 			trip->threshold = trip->temperature;
 		} else {
 			trip->threshold = trip->temperature - trip->hysteresis;
@@ -417,6 +419,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 
 	thermal_genl_sampling_temp(tz->id, temp);
+	thermal_debug_update_temp(tz);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
@@ -1396,6 +1399,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	thermal_notify_tz_create(tz->id, tz->type);
 
+	thermal_debug_tz_add(tz);
+
 	return tz;
 
 unregister:
@@ -1461,6 +1466,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
+	thermal_debug_tz_remove(tz);
+
 	tz_id = tz->id;
 
 	mutex_lock(&thermal_list_lock);
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index 84e5ef3dc16c..54c8401ac93b 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -1,4 +1,3 @@
-
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2023 Linaro Limited
@@ -14,8 +13,11 @@
 #include <linux/mutex.h>
 #include <linux/thermal.h>
 
+#include "thermal_core.h"
+
 static struct dentry *d_root;
 static struct dentry *d_cdev;
+static struct dentry *d_tz;
 
 /*
  * Length of the string containing the thermal zone id or the cooling
@@ -60,7 +62,7 @@ struct cdev_debugfs {
 };
 
 /**
- * struct cdev_value - Common structure for cooling device entry
+ * struct cdev_record - Common structure for cooling device entry
  *
  * The following common structure allows to store the information
  * related to the transitions and to the state residencies. They are
@@ -81,22 +83,89 @@ struct cdev_record {
         };
 };
 
+/**
+ * struct trip_stats - Thermal trip statistics
+ *
+ * The trip_stats structure has the relevant information to show the
+ * statistics related to temperature going above a trip point.
+ *
+ * @timestamp: the trip crossing timestamp
+ * @duration: total time when the zone temperature was above the trip point
+ * @count: the number of times the zone temperature was above the trip point
+ * @max: maximum recorded temperature above the trip point
+ * @min: minimum recorded temperature above the trip point
+ * @avg: average temperature above the trip point
+ */
+struct trip_stats {
+	ktime_t timestamp;
+	ktime_t duration;
+	int count;
+	int max;
+	int min;
+	int avg;
+};
+
+/**
+ * struct tz_episode - A mitigation episode information
+ *
+ * The tz_episode structure describes a mitigation episode. A
+ * mitigation episode begins the trip point with the lower temperature
+ * is crossed the way up and ends when it is crossed the way
+ * down. During this episode we can have multiple trip points crossed
+ * the way up and down if there are multiple trip described in the
+ * firmware after the lowest temperature trip point.
+ *
+ * @timestamp: first trip point crossed the way up
+ * @duration: total duration of the mitigation episode
+ * @node: a list element to be added to the list of tz events
+ * @trip_stats: per trip point statistics, flexible array
+ */
+struct tz_episode {
+	ktime_t timestamp;
+	ktime_t duration;
+	struct list_head node;
+	struct trip_stats trip_stats[];
+};
+
+/**
+ * struct tz_debugfs - Store all mitigation episodes for a thermal zone
+ *
+ * The tz_debugfs structure contains the list of the mitigation
+ * episodes and has to track which trip point has been crossed in
+ * order to handle correctly nested trip point mitigation episodes.
+ *
+ * We keep the history of the trip point crossed in an array and as we
+ * can go back and forth inside this history, eg. trip 0,1,2,1,2,1,0,
+ * we keep track of the current position in the history array.
+ *
+ * @tz_episode: a list of thermal mitigation episodes
+ * @trips_crossed: an array of trip points crossed by id
+ * @nr_trips: the number of trip points currently being crossed
+ */
+struct tz_debugfs {
+	struct list_head tz_episodes;
+	int *trips_crossed;
+	int nr_trips;
+};
+
 /**
  * struct thermal_debugfs - High level structure for a thermal object in debugfs
  *
  * The thermal_debugfs structure is the common structure used by the
- * cooling device to compute the statistics.
+ * cooling device or the thermal zone to store the statistics.
  *
  * @d_top: top directory of the thermal object directory
  * @lock: per object lock to protect the internals
  *
- * @cdev: a cooling device debug structure
+ * @cdev_dbg: a cooling device debug structure
+ * @tz_dbg: a thermal zone debug structure
  */
 struct thermal_debugfs {
 	struct dentry *d_top;
 	struct mutex lock;
 	union {
 		struct cdev_debugfs cdev_dbg;
+		struct tz_debugfs tz_dbg;
 	};
 };
 
@@ -107,6 +176,10 @@ void thermal_debug_init(void)
 		return;
 
 	d_cdev = debugfs_create_dir("cooling_devices", d_root);
+	if (!d_cdev)
+		return;
+
+	d_tz = debugfs_create_dir("thermal_zones", d_root);
 }
 
 static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
@@ -443,3 +516,321 @@ void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_dbg->lock);
 }
+
+static struct tz_episode *thermal_debugfs_tz_event_alloc(struct thermal_zone_device *tz,
+							ktime_t now)
+{
+	struct tz_episode *tze;
+	int i;
+
+	tze = kzalloc(struct_size(tze, trip_stats, tz->num_trips), GFP_KERNEL);
+	if (!tze)
+		return NULL;
+
+	INIT_LIST_HEAD(&tze->node);
+	tze->timestamp = now;
+
+	for (i = 0; i < tz->num_trips; i++) {
+		tze->trip_stats[i].min = INT_MAX;
+		tze->trip_stats[i].max = INT_MIN;
+	}
+	
+	return tze;
+}
+
+void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip)
+{
+	struct tz_episode *tze;
+	struct tz_debugfs *tz_dbg;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	int temperature = tz->temperature;
+	int trip_id = thermal_zone_trip_id(tz, trip);
+	ktime_t now = ktime_get();
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+	
+	/*
+	 * The mitigation is starting. A mitigation can contain
+	 * several episodes where each of them is related to a
+	 * temperature crossing a trip point. The episodes are
+	 * nested. That means when the temperature is crossing the
+	 * first trip point, the duration begins to be measured. If
+	 * the temperature continues to increase and reaches the
+	 * second trip point, the duration of the first trip must be
+	 * also accumulated.
+	 *
+	 * eg.
+	 *
+	 * temp
+	 *   ^
+	 *   |             --------
+	 * trip 2         /        \         ------
+	 *   |           /|        |\      /|      |\
+	 * trip 1       / |        | `----  |      | \
+	 *   |         /| |        |        |      | |\
+	 * trip 0     / | |        |        |      | | \
+	 *   |       /| | |        |        |      | | |\
+	 *   |      / | | |        |        |      | | | `--
+	 *   |     /  | | |        |        |      | | |     
+	 *   |-----   | | |        |        |      | | |      
+	 *   |        | | |        |        |      | | |
+	 *    --------|-|-|--------|--------|------|-|-|------------------> time
+	 *            | | |<--t2-->|        |<-t2'>| | |
+	 *            | |                            | |
+	 *            | |<------------t1------------>| |
+	 *            |                                |
+	 *            |<-------------t0--------------->|
+	 *
+	 */
+	if (!tz_dbg->nr_trips) {
+		tze = thermal_debugfs_tz_event_alloc(tz, now);
+		if (!tze)
+			return;
+
+		list_add(&tze->node, &tz_dbg->tz_episodes);
+	}
+
+	/*
+	 * Each time a trip point is crossed the way up, the trip_id
+	 * is stored in the trip_crossed array and the nr_trips is
+	 * incremented. A nr_trips equal to zero means we are entering
+	 * a mitigation episode.
+	 *
+	 * The trip ids may not be in the ascending order but the
+	 * result in the array trips_crossed will be in the ascending
+	 * temperature order. The function detecting when a trip point
+	 * is crossed the way down will handle the very rare case when
+	 * the trip points may have been reordered during this
+	 * mitigation episode.
+	 */
+	tz_dbg->trips_crossed[tz_dbg->nr_trips++] = trip_id;
+
+	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
+	tze->trip_stats[trip_id].timestamp = now;
+	tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
+	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
+	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
+		(temperature - tze->trip_stats[trip_id].avg) /
+		tze->trip_stats[trip_id].count;
+
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
+				const struct thermal_trip *trip)
+{
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_episode *tze;
+	struct tz_debugfs *tz_dbg;
+	ktime_t delta, now = ktime_get();
+	int trip_id = thermal_zone_trip_id(tz, trip);
+	int i;
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+	
+	/*
+	 * The temperature crosses the way down but there was not
+	 * mitigation detected before. That may happen when the
+	 * temperature is greater than a trip point when registering a
+	 * thermal zone, which is a common use case as the kernel has
+	 * no mitigation mechanism yet at boot time.
+	 */
+	if (!tz_dbg->nr_trips)
+		goto out;
+	
+	for (i = tz_dbg->nr_trips - 1; i >= 0; i--) {
+		if (tz_dbg->trips_crossed[i] == trip_id)
+			break;
+	}
+
+	if (i < 0)
+		goto out;
+
+	tz_dbg->nr_trips--;
+
+	if (i < tz_dbg->nr_trips)
+		tz_dbg->trips_crossed[i] = tz_dbg->trips_crossed[tz_dbg->nr_trips];
+
+	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
+
+	delta = ktime_sub(now, tze->trip_stats[trip_id].timestamp);
+
+	tze->trip_stats[trip_id].duration =
+		ktime_add(delta, tze->trip_stats[trip_id].duration);
+
+	/*
+	 * This event closes the mitigation as we are crossing the
+	 * last trip point the way down.
+	 */
+	if (!tz_dbg->nr_trips)
+		tze->duration = ktime_sub(now, tze->timestamp);
+
+out:
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+void thermal_debug_update_temp(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_episode *tze;
+	struct tz_debugfs *tz_dbg;
+	int trip_id, i;
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+
+	if (!tz_dbg->nr_trips)
+		goto out;
+
+	for (i = 0; i < tz_dbg->nr_trips; i++) {
+		trip_id = tz_dbg->trips_crossed[i];
+		tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
+		tze->trip_stats[trip_id].count++;
+		tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, tz->temperature);
+		tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, tz->temperature);
+		tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
+			(tz->temperature - tze->trip_stats[trip_id].avg) /
+			tze->trip_stats[trip_id].count;
+	}
+out:
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+static void *tze_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	return seq_list_start(&tz_dbg->tz_episodes, *pos);
+}
+
+static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
+
+	return seq_list_next(v, &tz_dbg->tz_episodes, pos);
+}
+
+static void tze_seq_stop(struct seq_file *s, void *v)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+static int tze_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_trip *trip;
+	struct tz_episode *tze;
+	const char *type;
+	int trip_id;
+
+	tze = list_entry((struct list_head *)v, struct tz_episode, node);
+
+	seq_printf(s, ",-Mitigation at %lluus, duration=%llums\n",
+		   ktime_to_us(tze->timestamp),
+		   ktime_to_ms(tze->duration));
+
+	seq_printf(s, "| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |\n");
+	
+	for_each_trip(tz, trip) {
+		/*
+		 * There is no possible mitigation happening at the
+		 * critical trip point, so the stats will be always
+		 * zero, skip this trip point
+		 */
+		if (trip->type == THERMAL_TRIP_CRITICAL)
+			continue;
+
+		if (trip->type == THERMAL_TRIP_PASSIVE)
+			type = "passive";
+		else if (trip->type == THERMAL_TRIP_ACTIVE)
+			type = "active";
+		else
+			type = "hot";
+
+		trip_id = thermal_zone_trip_id(tz, trip);
+		
+		seq_printf(s, "| %*d | %*s | %*d | %*d | %*lld | %*d | %*d | %*d |\n",
+			   4 , trip_id,
+			   8, type,
+			   9, trip->temperature,
+			   9, trip->hysteresis,
+			   10, ktime_to_ms(tze->trip_stats[trip_id].duration),
+			   9, tze->trip_stats[trip_id].avg,
+			   9, tze->trip_stats[trip_id].min,
+			   9, tze->trip_stats[trip_id].max);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tze_sops = {
+	.start = tze_seq_start,
+	.next = tze_seq_next,
+	.stop = tze_seq_stop,
+	.show = tze_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tze);
+
+void thermal_debug_tz_add(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg;
+	struct tz_debugfs *tz_dbg;
+
+	thermal_dbg = thermal_debugfs_add_id(d_tz, tz->id);
+	if (!thermal_dbg)
+		return;
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+
+	tz_dbg->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
+	if (!tz_dbg->trips_crossed) {
+		thermal_debugfs_remove_id(thermal_dbg);
+		return;
+	}
+
+	INIT_LIST_HEAD(&tz_dbg->tz_episodes);
+
+	debugfs_create_file("mitigations", 0400, thermal_dbg->d_top, tz, &tze_fops);
+	
+	tz->debugfs = thermal_dbg;
+}
+
+void thermal_debug_tz_remove(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz->debugfs = NULL;
+	thermal_debugfs_remove_id(thermal_dbg);
+
+	mutex_unlock(&thermal_dbg->lock);
+}
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
index 341499388448..155b9af5fe87 100644
--- a/drivers/thermal/thermal_debugfs.h
+++ b/drivers/thermal/thermal_debugfs.h
@@ -5,10 +5,24 @@ void thermal_debug_init(void);
 void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
+void thermal_debug_tz_add(struct thermal_zone_device *tz);
+void thermal_debug_tz_remove(struct thermal_zone_device *tz);
+void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip);
+void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
+				const struct thermal_trip *trip);
+void thermal_debug_update_temp(struct thermal_zone_device *tz);
 #else
 static inline void thermal_debug_init(void) {}
 static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
 static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
 static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
 						   int state) {}
+static inline void thermal_debug_tz_add(struct thermal_zone_device *tz) {}
+static inline void thermal_debug_tz_remove(struct thermal_zone_device *tz) {}
+static inline void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
+					    const struct thermal_trip *trip) {};
+static inline void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
+					      const struct thermal_trip *trip) {}
+static inline void thermal_debug_update_temp(struct thermal_zone_device *tz) {}
 #endif /* CONFIG_THERMAL_DEBUGFS */
-- 
2.34.1


