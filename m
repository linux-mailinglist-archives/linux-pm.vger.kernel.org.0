Return-Path: <linux-pm+bounces-14558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02F97E930
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AE92810B3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A4195B18;
	Mon, 23 Sep 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYF6H/nc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053AC19580B
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085613; cv=none; b=cwTvT1EWthp+4qZ18d08K0kyOe8YbqR+61/FOIUakb3poAA350pkIRLidI79tgBv11B+iWowOIu48S9+448BoZiW2V65hs1nVTPNlcRpSpuqp/FI6i2V53g6bWxoF15izYK6xnoQQhPHQ4EHG2dEDJgi1DXtcXG7zZXZ700wCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085613; c=relaxed/simple;
	bh=h9wCXCzge/7pjHAsTiF24nQOEtdLPzhlTqX6X2I8S4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7cICBaK6Z1jzKeaZ/5vCCuGXboB1RDL+2GMZriWkQWZ1vaGffjQqZ19c87h62OkRRk++EBb014oGiqh5MaEtfn/MqTem3rTF295tfe+6Q0zzBqii9nDPONrjNZqq7TEItQvPOjWJ/EiJem4aIzV4eyf9Ojtdb5cqKi6ws23VIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dYF6H/nc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374bfc395a5so2672498f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085610; x=1727690410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCDW5f7z1X54LYH7U789CJkJl+8jsyNS+1Q1CPdtMY4=;
        b=dYF6H/ncWh+9wY6v8Xvjwzadif3cRKdwOHfpnqkbqwGp8zWsfeFk0VkCsunPiJKmOq
         BCMXLftQq0auQY6yVkxD6q8FUdeMSNPwiq81/Supp3I6rf6piK3US1BFL/zHpcF+xWZg
         ezDxo3MYoXGAjcAamKzYTNya2FGmN9CqA1Xd+obeWF54PY6fQkzc0HPLlrTOv3k4+J0R
         qHltL2CRqz1AeGdHmNwY5A2hiWD/P5Nltt4DUX142froYr4r7k02vSg9t8yg+9Za6bWX
         RVzSvmjW83ukuGbWlUaj8R51Pk2jHbnkD6UbdCWed/3ahTdAoAl0iFItkYxWnmnEThZX
         q7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085610; x=1727690410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCDW5f7z1X54LYH7U789CJkJl+8jsyNS+1Q1CPdtMY4=;
        b=Ogp5JjSA+EEQj49lHosvkkeC0dnckP1iL4Jh6Fv/4MWXYQroogHZN986tgUa5H0MSp
         0Ie/oYCpqkZUyb3cwaeGod01mdHk+8B6dkfgb/bgHU64RMFubfRSSnG43pfM/e1edxPk
         dGHwrYD5/qdTCEXbic7r8NSqWzw8wPtdGjQdBkGxFSXT4yGGTsbeyZ/KZym1cP+gLzSZ
         njesAYoNXJRQxh3+uGxRsATAkBAxwA/+bJVmfAcr8BRw6s4lUUOUasWEuft3KPqE4iI/
         2hs9KGbze4r0Z/kv3JOeNW2eYihAGrZSVgLbVLHPLqMf5TK+lJKhtWSvwDU4hCLU7xA0
         zbNw==
X-Gm-Message-State: AOJu0YwPM8pnY2LGxM3DNrdVgjC9CVydHS0BCCXdIifrJOdtBbzG+AbR
	s1OVS4FgF87RB7ZYs3vffcp3SYlEfjYVxN71boGMDsO2NvgsWwHLiX1KDSHLup4gnWSu5wnB1LF
	Y
X-Google-Smtp-Source: AGHT+IH4V0HCRp/t3hMiZk8L3E6+v4tSqgvmFHWOc5Wvll52LzNGGm/gGiprpb2NvIF+kGoNHVK+gw==
X-Received: by 2002:a5d:4f05:0:b0:374:d006:ffae with SMTP id ffacd0b85a97d-37a41497226mr7020882f8f.6.1727085610168;
        Mon, 23 Sep 2024 03:00:10 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm23977216f8f.49.2024.09.23.03.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:00:09 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v4 0/6] Add thermal user thresholds support
Date: Mon, 23 Sep 2024 11:59:56 +0200
Message-ID: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trip points are a firmware description of the temperature limits
of a specific thermal zone where we associate an action which is done
by the kernel. The time resolution is low.

The userspace has to deal with a more complex thermal management based
on heuristics from different information coming from different
places. The logic is much more complex but based on a bigger time
resolution, usually one second based.

The purpose of the userspace is to monitor the temperatures from
different places and take actions. However, it can not be constantly
reading the temperature to detect when a temperature threshold has
been reached. This is especially bad for mobile or embedded system as
that will lead to an unacceptable number of wakeup to check the
temperature with nothing to do.

On the other side, the sensors are now most of the time interrupt
driven. That means the thermal framework will use the temperature trip
points to program the sensor to trigger an interrupt when a
temperature limit is crossed.

Unfortunately, the userspace can not benefit this feature and current
solutions found here and there, iow out-of-tree, are to add fake trip
points in the firmware and enable the writable trip points.

This is bad for different reasons, the trip points are for in-kernel
actions, the semantic of their types is used by the thermal framework
and by adding trip points in the device tree is a way to overcome the
current limitation but tampering with how the thermal framework is
supposed to work. The writable trip points is a way to adjust a
temperature limit given a specific platform if the firmware is not
accurate enough and TBH it is more a debug feature from my POV.

The user thresholds mechanism is a way to have the userspace to tell
thermal framework to send a notification when a temperature limit is
crossed. There is no id, no hysteresis, just the temperature and the
direction of the limit crossing. That means we can be notified when a
temperature threshold is crossed the way up only, or the way down only
or both ways. That allows to create hysteresis values if it is needed.

Those thresholds are refered as user thresholds in order to do the
difference with the trip points which are similar.

An user threshold can be added, deleted or flushed. The latter means
all user thresholds belonging to a thermal zone will be deleted.
    
When one or several user thresholds are crossed, an event is sent to
the userspace.

All aforementioned actions and events lead to a notification to the
userspace. A user threshold change (add, delete and flush) is notified
to the userspace with the process id responsible of the action.

Along with the kernel changes, the thermal library has been extended
to provide the different API to deal with the new user threshold
netlink events and commands.

In addition, the thermal-engine skeleton uses these new API by
flushing and adding user thresholds as well as getting the
notification about these actions.

Overall the series has been tested with the thermal-engine skeleton
and some selftests which are not part of this series.

Changelog:
  V4:
    - Fix missing stubs when THERMAL_NETLINK=n (kernel test robot)

  V3:
    - the first patch of the v2 series has been merged

    - Modified the description to split the information between the
      cover letter and the patch 1 description (Rafael)

    - Made the thresholds code as part of the core (Rafael)

    - Converted the thresholds into a list and directly declared in
      the thermal zone device structure (Rafael)

    - Changed the name of the field in the thermal zone device
      structure to user_thresholds (Rafael)

    - Added #include "thermal_thresholds.h" (Rafael)

    - Combined the conditions in the function
      __thermal_threshold_is_crossed (Rafael)

    - Moved the function thermal_thresholds_flush() before
      thermal_thresholds_exit() (Rafael)

    - Change thermal_thresholds_handle() to return void (Rafael)

    - Move the list field on top the of the structure threshold and
      renamed it list_node (Rafael)

    - Changed THERMAL_THRESHOLD_* notifications to
      THERMAL_TZ_THRESHOLD_* (Rafael)

  V2:
    - Compute min and max in thermal_zone_device_update() but keep
      the loop as it is (Rafael)

    - Include slab.h to fix compilation warnings on some architectures
      with kmalloc and kfree (kernel test robot)

Daniel Lezcano (6):
  thermal/core: Add user thresholds support
  thermal/core: Connect the threshold with the core
  thermal/netlink: Add the commands and the events for the thresholds
  tools/lib/thermal: Make more generic the command encoding function
  tools/lib/thermal: Add the threshold netlink ABI
  tools/thermal/thermal-engine: Take into account the thresholds API

 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/thermal_core.c                |   9 +
 drivers/thermal/thermal_core.h                |   2 +
 drivers/thermal/thermal_netlink.c             | 239 +++++++++++++++++-
 drivers/thermal/thermal_netlink.h             |  34 +++
 drivers/thermal/thermal_thresholds.c          | 235 +++++++++++++++++
 drivers/thermal/thermal_thresholds.h          |  19 ++
 include/linux/thermal.h                       |   3 +
 include/uapi/linux/thermal.h                  |  30 ++-
 tools/lib/thermal/commands.c                  | 167 +++++++++++-
 tools/lib/thermal/events.c                    |  58 ++++-
 tools/lib/thermal/include/thermal.h           |  40 +++
 tools/lib/thermal/libthermal.map              |   5 +
 tools/lib/thermal/thermal.c                   |  17 ++
 tools/thermal/lib/Makefile                    |   2 +-
 tools/thermal/thermal-engine/thermal-engine.c | 109 +++++++-
 16 files changed, 921 insertions(+), 49 deletions(-)
 create mode 100644 drivers/thermal/thermal_thresholds.c
 create mode 100644 drivers/thermal/thermal_thresholds.h

-- 
2.43.0


