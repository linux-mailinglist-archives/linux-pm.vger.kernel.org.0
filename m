Return-Path: <linux-pm+bounces-15606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FAE99C61A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 11:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003DC287702
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB72156C52;
	Mon, 14 Oct 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJyyaKKa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67F15666B
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898997; cv=none; b=tGFDDzEbNnJzy5TmexuHXNTxA4MGfc+tO3HknubJ8VsTqjrSY/BSPpfigdONXLiaWwE1S38wjtqrjp2xi/xtDUJoyKkGcIoqJHeUpfl/l4Vc47Fs7xYXqhyWRHSbByPKYTipBOT19+fxERqYrQAY6A0hOPSfbsUYPOfHsnl9n+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898997; c=relaxed/simple;
	bh=DGy4MO9G+UfgZR6n3KNq+vHUKRfqLhFOIRFttF5sa/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTUy/lPOlcs7W5wb8gPtmAe/qP2KB2rgnNGwjIBJ0O3uqYNQQyqy93M9ZCCO3Y4LoSol1nN4whmaBbRHfaeMYRt60zNKinfrswh5gXsd8XxpgZM1NDnQxFYUPYhNq/RizIUfUXoSxd82TFXPn4cMm9RzB1jP6SAsGxxZovfp4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJyyaKKa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2959085f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728898994; x=1729503794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaonG6JfWd+FiH/udmw2E99H1nz2PzJ3d75+CCzsYRY=;
        b=VJyyaKKar3HGNx4yTsNg8IxI2NVowezASk4JUJYrL0YT0PCRPCJtAYOHkoL88p6Q2P
         vUkuWUMiouuuk61UsHtUhRjk/KSPvoXnK2qglDd/uU3yj1dLYRBj+VNxC8L+R5bDN9/T
         PjVLml1Zr/axENRp809zEkyJHvUNp5YQ4y85eWUhELEs+DP/HSo2XnsA024z1uB18ycj
         HyuSlaM4zoEMSflydUq2nYVIAX2cvoBOoXLHu5+d3nRnbnTbEi7GfTTBZuDcC4mtn6nE
         Ii8yzpfP2vfMhDB3RAmD2ViTE+9RWOBx8xfi5P/AXiMGwZg2JYj8ngFSoYwXzB93u8f/
         gMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898994; x=1729503794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaonG6JfWd+FiH/udmw2E99H1nz2PzJ3d75+CCzsYRY=;
        b=gOjOOd6aTsBGmLUxqmdE+0AiLvHJ4ZN6IEndQQ6oLNj6RfBPQ5laf0WjBax7CplkKI
         bj8n8MRYE58M2Wl5uAI1nNmEz1+YROzeG7accc1IlrJ8SQNTVhEgpQokqe8Ac5zG6PE3
         ggD9zycYgnqVeD3sbDm46vCzeuYvUVM0hK5h2I5cNAtJ1NsJZBg0Ux39TM7nkEpGKa2O
         obDrD7BktNmq/LNd54Vg/9999znFS636CbCEEDJtjzV+bxeZ1VK09NJA79LipKW94c5o
         beSi/rmH41g/m33+D7m3l3lBs05PKKJ+MA7RIcNe22NqE4p/He6V85AodhsJ+Ehx177P
         mOLg==
X-Gm-Message-State: AOJu0Yy6dUfAkLZCv4dpuz8ahtw9Kde6nc4uY6OVMrsxUDpiMgbqHu1V
	ugPADky6TP/HrrN+V3LThERKEjtgD5nIIVnfJpHV7n3Z9Kw7e/AEKI2FzatySSNY+q5KeY2l8wI
	w
X-Google-Smtp-Source: AGHT+IGDkd6XqPxirXFCfTdWMbbTDWNrQklj2I9Zd11caxfIg0Yq4FOlQ8w0yLMy9QySSKHfZL0RpA==
X-Received: by 2002:a5d:5702:0:b0:37d:3a6f:80cf with SMTP id ffacd0b85a97d-37d551847f4mr7234422f8f.6.1728898993944;
        Mon, 14 Oct 2024 02:43:13 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0203sm10935840f8f.57.2024.10.14.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:43:13 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v5 0/4] Add thermal user thresholds support
Date: Mon, 14 Oct 2024 11:43:03 +0200
Message-ID: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
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
userspace.

Along with the kernel changes, the thermal library has been extended
to provide the different API to deal with the new user threshold
netlink events and commands.

In addition, the thermal-engine skeleton uses these new API by
flushing and adding user thresholds as well as getting the
notification about these actions.

Overall the series has been tested with the thermal-engine skeleton
and some selftests which are not part of this series.

Changelog:
  V5:
    - Added CAP_SYS_ADMIN needed capability when adding, deleting and
      flushing a threshold (Rafael)

    - Remove the pid information to prevent leaking pid inside
      containers. Also the information is not really needed (Rafael)

    - Renamed "THERMAL_GENL_ATTR_THRESHOLD_WAY" to
      "THERMAL_GENL_ATTR_THRESHOLD_DIRECTION". Did not used '*_DIR' as
      suggested initially because it can be ambiguous with 'directory'
      (Rafael)

    - Renamed 'last_temp' to 'prev_temp' (Rafael)

    - Used CLASS constructor/destructor to get / put the thermal
      zone's device refcount (Rafael)

    - Moved locking inside thermal_thresholds_for_each() (Rafael)

    - Reflected the changes above in the thermal library and the
      thermal engine skeleton
    

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

Daniel Lezcano (4):
  thermal/netlink: Add the commands and the events for the thresholds
  tools/lib/thermal: Make more generic the command encoding function
  tools/lib/thermal: Add the threshold netlink ABI
  tools/thermal/thermal-engine: Take into account the thresholds API

 drivers/thermal/thermal_netlink.c             | 236 +++++++++++++++++-
 drivers/thermal/thermal_netlink.h             |  34 +++
 drivers/thermal/thermal_thresholds.c          |  36 +--
 drivers/thermal/thermal_thresholds.h          |   2 +-
 include/uapi/linux/thermal.h                  |  27 +-
 tools/lib/thermal/commands.c                  | 167 ++++++++++++-
 tools/lib/thermal/events.c                    |  55 +++-
 tools/lib/thermal/include/thermal.h           |  40 +++
 tools/lib/thermal/libthermal.map              |   5 +
 tools/lib/thermal/thermal.c                   |  17 ++
 tools/thermal/lib/Makefile                    |   2 +-
 tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++-
 12 files changed, 662 insertions(+), 64 deletions(-)

-- 
2.43.0


