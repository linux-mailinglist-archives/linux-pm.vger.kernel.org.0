Return-Path: <linux-pm+bounces-16242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312399AB2C3
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8EA1F2303D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5D1BC08C;
	Tue, 22 Oct 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEIhgI3K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9EC1BBBE8
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612317; cv=none; b=MSiVj3cFgyUkqkH8rI132hqiMvHLb+NQgnwKr1b+XjPLnr5rdaG4YP+Zu3scVFA60wTUi3X+jf/mXJjOMxn/QKDALa6GD0LEzB/1HXLqhNHludKBr7fa//ArIRXaMROe/3pWU4AMySMxwOyMkThSToXPStE7S/LiLVoCDthFCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612317; c=relaxed/simple;
	bh=s66Docc0SAAJ9Hcww5Q/yLBSL4jdfzEj17CDn/9Nz6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U41QuiNQVh6lZU2lXJbVo22adVck2INFXAd6vySLOnx5TJq/A9i49F9cNZuJ2TeDAzNb+fIcYtk84l1Ps4WfzLpznRel7tVRQqHpcbfIp+xZia3hMqadqeqnfTsmMbEvHuD4n+1IkyJdC7+NZ3f+O0Eu3eFegcGhIQxRqmVbEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEIhgI3K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so63948785e9.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612314; x=1730217114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+qAdZLwHg10bQdlnlE6SpqF/5RO8jActJH2b0oBf3k=;
        b=jEIhgI3K21ruRYFams134eR4nybzaga3ec3HsORYDGjeg4TDINFTk4Rc6NjpdOWPT3
         zcE+jeC2EhB36oEfh/P7Z/5jVaXERW2h0prVUs/j+aO5Ddw/LtGpiiRDsKaUdOp+zhP8
         W+yiWZNXCM7//VzsSpUIFQSECL1ViQdTY3vKVBcoiMPmAT7lxGCxfBbIYY6nl2upnCWR
         Z48SyzA5Cn4K2fr6NXO+SIM265JuxvLx/3kvfWLJjf1YrytPcJh6D/wOIyU5pYd1uyJF
         KS75B38XFtXvRRsQWhQvZsLNhMYoSwMp6eMeyaMgzLUWxmwuBCqD24zkC1rUWLSoJHa/
         o0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612314; x=1730217114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+qAdZLwHg10bQdlnlE6SpqF/5RO8jActJH2b0oBf3k=;
        b=MfcQteNjPHQG4Sl2tplWWIhuNEfKvqRA0eQGSRoC1J4Rv4sDcKUXocTt9LLywgVamn
         jaVNq1ZVetztnpmKvnbBOdJcN9i4EzQPHhqXwOTd1wiks4NvXh7yaHdmO18/1vLHKaGI
         pwU1/9yL8xVLBHUl4s7tQ+uDg1HxOBGh8lBTIq91j80bHkKTAPghhsHszO4MTHCD136f
         jlIZmH7A2QH81MqK1Bqk1QSguiOqm3Ddatrt2DygNlUVRxNK4FSi8CtiZDYeE75EW5eQ
         PmV40jjQhil4f2aV9718wJ3gZnl9QXmGxj0Q+XbHVEwzWDc9UgUllIdOHCHkzf/ExcJQ
         yNcQ==
X-Gm-Message-State: AOJu0YwquNgfhLqRo452taT98dvfMzCpoARbIFxRTog9wDu5YnV09kHU
	YGlXwzuB1+EGva1JtT6yLlyY/IJ3AXz2yN6DWjFswW0oixRkyD7jLz4kZlu1/mZFqwvWw74uhlA
	g
X-Google-Smtp-Source: AGHT+IEmIbv8Z1ZbvVLSih3Ew09REG1OKc9CcvAXVWNoBndDZsc6fgR/tC2RkZjkjIQdJAthCLpPkw==
X-Received: by 2002:a5d:4089:0:b0:37d:4b07:606b with SMTP id ffacd0b85a97d-37eb8821357mr9644698f8f.36.1729612313941;
        Tue, 22 Oct 2024 08:51:53 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58aef6sm91538075e9.22.2024.10.22.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:51:53 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	quic_manafm@quicinc.com,
	lukasz.luba@arm.com
Subject: [PATCH v6 0/5] Add thermal user thresholds support
Date: Tue, 22 Oct 2024 17:51:40 +0200
Message-ID: <20241022155147.463475-1-daniel.lezcano@linaro.org>
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
  V6:
  
    - Added a comment in the parse_threshold_get() function to clarify
      how the size is computed (Lukasz)

    - Changed comparison to check against non zero value in the
      __thermal_zone_discover() function (Lukasz)

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

Daniel Lezcano (5):
  thermal: core: Connect the threshold with the core
  thermal/netlink: Add the commands and the events for the thresholds
  tools/lib/thermal: Make more generic the command encoding function
  tools/lib/thermal: Add the threshold netlink ABI
  tools/thermal/thermal-engine: Take into account the thresholds API

 drivers/thermal/thermal_core.c                |   9 +
 drivers/thermal/thermal_netlink.c             | 236 +++++++++++++++++-
 drivers/thermal/thermal_netlink.h             |  34 +++
 drivers/thermal/thermal_thresholds.c          |  36 +--
 drivers/thermal/thermal_thresholds.h          |   2 +-
 include/uapi/linux/thermal.h                  |  27 +-
 tools/lib/thermal/commands.c                  | 177 ++++++++++++-
 tools/lib/thermal/events.c                    |  55 +++-
 tools/lib/thermal/include/thermal.h           |  40 +++
 tools/lib/thermal/libthermal.map              |   5 +
 tools/lib/thermal/thermal.c                   |  17 ++
 tools/thermal/lib/Makefile                    |   2 +-
 tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++-
 13 files changed, 681 insertions(+), 64 deletions(-)

-- 
2.43.0


