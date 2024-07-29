Return-Path: <linux-pm+bounces-11543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7393F8F8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F01A1C21AF8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB314830F;
	Mon, 29 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvF7lMUj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8400155391
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265399; cv=none; b=h+emYsjBp2RNCprzKQu6caDzQqHv4WvjVsWVqnghgIbtd6zTnDqE+00dkrSEDyLn+9x7+hsK307sKlbwsEpeEICr/0Dw+0fU2sFlnmwIVXjzgh+2QSpvB4m8Uy/KhicTkhPBLNwR/evHrlL/zRYkLzqj4iKKmTMNsdHg3bXQ0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265399; c=relaxed/simple;
	bh=tEjeSpSLku6ovLs97psJ+YaO8hVtwTFG+gTJZqm/yuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0u6o5JS85RxgzcLwxSXMfiUfkGb8g1xzVFw9e7IRC/jgTgOF06OYYLCtbjrEBr1v9HRSFwo20VvJPuomVfFze/z/UUlJpqdJXB+AEVHnnudtXWzKmAwIQR+dqJpUOs7GwBRHBrgLA6uzrhNEAd31GkDOQ7MyGydaiWmIyDbE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AvF7lMUj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-368313809a4so1211386f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722265396; x=1722870196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz/PF2KTxR/LRLtNme7oNW/n+pDMevOG43WsuCn83eM=;
        b=AvF7lMUjye6VLM35Q/dBj0E2V29DU+9Gs+FSeHEjJ2Wgsuvo9YmNZG4O6WeKNSdPob
         gOi9+u2aGFGd7p9JxsiNuOXFXJvGDJN8HXBTpYTzSNLW5Y8aRzN5pWKJONoeqyAgeONs
         CZiycGXktEyoDbO04MZ5f13vcYGyAWTnyfixIY2520Gp7gF/JgazeEI2hHBD304rM++e
         jJ3rb2+7IUxn2zW1YNLepUkDiXPhlY2/4+Z0tkOl71Ht5QiPh6jmxX3jChXSunHG+ZAm
         M0j/eJ7a3GHUO0TYmm0/fPYJU0HS8glLNbpC7UrCvaFnRa7GdBBnzrUDJxp4+t5adwOK
         yc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265396; x=1722870196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yz/PF2KTxR/LRLtNme7oNW/n+pDMevOG43WsuCn83eM=;
        b=DPqeKJz7/aCJKjvwvFUyNBYTwneozBSdchVUfWb03hMDUUZJMcukasv50Cx2sE6Ka4
         nK2iLwdrYLkVg768GL4gLA+pGF/oMBBB3O2t8hQ4uIHUncOe/IeqxvhkVmUkE+YazhdC
         qvnaHgVuzZgntLWzAqMFvwg4mLiwJ7l7qY0KGkC1kaToufEa2TUOigDYuo/yPT73nQVc
         PGisdB+r1DpGO0NQe5GS33n9fE5u78SsLwsUCcxVF0tsfhXmem9m0xNUXkIQPklJJnEA
         +Z/YQKjkxXObx84CHC5uiULMZuD70xs6qWW2sw3+gqSlWvtl+vhIpNwSRoKM8HLrz8nR
         tGjA==
X-Gm-Message-State: AOJu0YyOht+tT8EvGFpHDwIucnixKnCfU3MvrnzdIS25SGp4wJkDGknd
	i8J6xT2H6sCHNq1FfAWBJ7i0mazRd4seLNjf631bSIOieqUIcDVe3PD6gC4h0ksKN9OEDN5Y1Z1
	d
X-Google-Smtp-Source: AGHT+IHSEeCmpzrK5jA2vxnEk4bOD8HkUV8gov/hpYtAvFS8RHTILYs0DOzhW5XqB8+kxDKCduLdoA==
X-Received: by 2002:a5d:6b83:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-36b5d7bee4emr5478195f8f.2.1722265395951;
        Mon, 29 Jul 2024 08:03:15 -0700 (PDT)
Received: from mai.box.freepro.com (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm12652803f8f.107.2024.07.29.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:15 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v1 0/7] Add thermal thresholds support
Date: Mon, 29 Jul 2024 17:02:49 +0200
Message-ID: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
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

The thresholds mechanism is a way to have the userspace to tell
thermal framework to send a notification when a temperature limit is
crossed. There is no id, no hysteresis, just the temperature and the
direction of the limit crossing. That means we can be notified when a
threshold is crossed the way up only, or the way down only or both
ways. That allows to create hysteresis values if it is needed.

A threshold can be added, deleted or flushed. The latter means all
thresholds belonging to a thermal zone will be deleted.
    
When a threshold is added:

 - if the same threshold (temperature and direction) exists, an error
   is returned

 - if a threshold is specified with the same temperature but a
   different direction, the specified direction is added

 - if there is no threshold with the same temperature then it is
   created

When a threshold is deleted:

 - if the same threshold (temperature and direction) exists, it is
   deleted

 - if a threshold is specified with the same temperature but a
   different direction, the specified direction is removed

 - if there is no threshold with the same temperature, then an error
   is returned

When the threshold are flushed:

 - All thresholds related to a thermal zone are deleted

When a threshold is crossed:

 - the userspace does not need to know which threshold(s) have been
   crossed, it will be notified with the thermal zone identifier, the
   current temperature and the previous temperature

 - if multiple thresholds have been crossed between two updates only
   one notification will be send to the userspace, it is pointless to
   send a notification per thresholds crossed as the userspace can
   handle that easily when it has the temperature delta information

All aforementioned actions and events lead to a notification to the
userspace. A threshold change (add, delete and flush) is notified to
the userspace with the process id responsible of the action.

Along with the kernel changes, the thermal library has been extended
to provide the different API to deal with the new threshold netlink
events and commands.

In addition, the thermal-engine skeleton uses these new API by
flushing and adding thresholds as well as getting the notification
about these actions.

Overall the series has been tested with the thermal-engine skeleton
and some selftests which are not part of this series.

Daniel Lezcano (7):
  thermal/core: Encapsulate more handle_thermal_trip
  thermal/core: Add thresholds support
  thermal/core: Connect the threshold with the core
  thermal/netlink: Add the commands and the events for the thresholds
  tools/lib/thermal: Make more generic the command encoding function
  tools/lib/thermal: Add the threshold netlink ABI
  tools/thermal/thermal-engine: Take into account the thresholds API

 drivers/thermal/Kconfig                       |  15 ++
 drivers/thermal/Makefile                      |   3 +
 drivers/thermal/thermal_core.c                | 109 ++++----
 drivers/thermal/thermal_core.h                |   6 +-
 drivers/thermal/thermal_netlink.c             | 239 ++++++++++++++++-
 drivers/thermal/thermal_netlink.h             |   7 +
 drivers/thermal/thermal_thresholds.c          | 246 ++++++++++++++++++
 drivers/thermal/thermal_thresholds.h          |  54 ++++
 drivers/thermal/thermal_trip.c                |  12 +-
 include/linux/thermal.h                       |   3 +
 include/uapi/linux/thermal.h                  |  30 ++-
 tools/lib/thermal/commands.c                  | 167 +++++++++++-
 tools/lib/thermal/events.c                    |  58 ++++-
 tools/lib/thermal/include/thermal.h           |  40 +++
 tools/lib/thermal/libthermal.map              |   5 +
 tools/lib/thermal/thermal.c                   |  17 ++
 tools/thermal/thermal-engine/thermal-engine.c | 109 +++++++-
 17 files changed, 1016 insertions(+), 104 deletions(-)
 create mode 100644 drivers/thermal/thermal_thresholds.c
 create mode 100644 drivers/thermal/thermal_thresholds.h

-- 
2.43.0


