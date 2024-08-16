Return-Path: <linux-pm+bounces-12312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE219543B8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA46F1C21374
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA284A22;
	Fri, 16 Aug 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rtc8eK2E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EF1D69E
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795968; cv=none; b=K+shYqGpYaU/Y8QmpoN6+38xEDYq2nLhho5c3zHJ17jXUH9fkrEQqUdNCLyu/tgMpPIEADHPCXM7AgApp/wJ5beH+ZMoH3UQwDTnfAnlCio/D3k5ZilD71kv0N4BziIdWkjwOGUzLPXkK5jXdPXbDK5SUxGc6W0Y6sUWql5WmK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795968; c=relaxed/simple;
	bh=ZziBc4Ib/e1VvZyzf1fXaboMdArKv6F/4pj0OlI5Z0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTuRwv8xk5iJKiKXH8/AcTUjWC80DIB1m5pOcJTpVwL15KdtR28BFZGKE8C6B0Znf+obhF6ouA6x/PUi/DPSPPQb6FeX9UCsHpp6QRSSfJrALZGA/lQ+uB37w4BDoy6Tdet0OxVudSdyEj/lfuWaMBqmpJmvoJP1vJxy6JYEeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rtc8eK2E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37198a6da58so116762f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723795964; x=1724400764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5Eva/cLxCOls6bSdFVdf+KS9uRZ2XgiBuQm3wdRNuY=;
        b=Rtc8eK2Eiw98rGJU22ovMOV8TDKWaT9/GqCn8JVwO2lW3uQJwSv4XlKb5t+qi2H3S/
         MWqhWNQXjCIXb4px4qZ7fjMgGajZosz+qi4S7lh37qGYz2zN7XerykOmoBMzTVyXm387
         h5Sm2Rw7p4dsELbLtu+f6VQQSiOlfL4HmWow5MYqk4D+MjGfHJnv7WItAUGaJnq3DxGz
         sFREfmAwirb5VvroF/dIAIMWoEQPWfPl4nuIY++BTmokcCfRH36ZrwJnbyMPkqz38CN6
         JIITMiyUMwxmk0wuwCgaWMrawU4cs1Xt5WOmJYQ98hrRAhbQk2u/KIlOCFzVXx4H9Yy9
         a3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795964; x=1724400764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5Eva/cLxCOls6bSdFVdf+KS9uRZ2XgiBuQm3wdRNuY=;
        b=J1j4x44kH6ZzgU2ASOVlvdrjtvbGzIxMp90vVovUw8V53mBk3pYwCNAn6utoFXP12M
         NiYgH1CFvsVqfd0I1BBiDNYnn9GlANrpH7FVf2QTKRy4hWlb4AEaaRw2vlZFE4q2o4k5
         FKPuEbnXEGFR1QRFAl98TX4J+YdvngzKs58Tfpay32vOdC84nus6BZxqAQPwlGqXKiMK
         O6FN3SMls/nK1o0uXDGw9INrTH+GbV5M2Qle07f+UrOMkOGeDp05ZYlap1OPr7WzVhLh
         nOindkZgAlMKbhU00aDkzEPwxobBb1oprEbXAozjQS63HHTFR9RaQ5gfeFHUhWaLpi46
         ANuA==
X-Gm-Message-State: AOJu0Yz8K7FdheKz2KEij+ann7ZFEd0YLREr7Qo9z9hD/r8dAh4h7COl
	WdKHcb8eUa86Pl+UrhmrkLwY66GALuiuLzvTUG/SfHxmVHpEAh6VdCs42RwqRRnRJMc53/f7syj
	g42k=
X-Google-Smtp-Source: AGHT+IH5hhr6D2zYn1BOuxx8GAmUN0x+ppw3cLHShwafmeKDeWRArTyh1Mv+8sYFmMXUUVslD6raEA==
X-Received: by 2002:adf:cd8a:0:b0:368:65c7:5ffc with SMTP id ffacd0b85a97d-371946c58bbmr1374409f8f.60.1723795964081;
        Fri, 16 Aug 2024 01:12:44 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm16021205e9.28.2024.08.16.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:12:43 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v2 0/7] Add thermal thresholds support
Date: Fri, 16 Aug 2024 10:12:31 +0200
Message-ID: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
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

Changelog:
  V2:
    - Compute min and max in thermal_zone_device_update() but keep
      the loop as it is (Rafael)

    - Include slab.h to fix compilation warnings on some architectures
      with kmalloc and kfree (kernel test robot)

Daniel Lezcano (7):
  thermal/core: Compute low and high boundaries in
    thermal_zone_device_update()
  thermal/core: Add thresholds support
  thermal/core: Connect the threshold with the core
  thermal/netlink: Add the commands and the events for the thresholds
  tools/lib/thermal: Make more generic the command encoding function
  tools/lib/thermal: Add the threshold netlink ABI
  tools/thermal/thermal-engine: Take into account the thresholds API

 drivers/thermal/Kconfig                       |  15 ++
 drivers/thermal/Makefile                      |   3 +
 drivers/thermal/thermal_core.c                |  21 +-
 drivers/thermal/thermal_core.h                |   6 +-
 drivers/thermal/thermal_netlink.c             | 239 ++++++++++++++++-
 drivers/thermal/thermal_netlink.h             |   7 +
 drivers/thermal/thermal_thresholds.c          | 247 ++++++++++++++++++
 drivers/thermal/thermal_thresholds.h          |  54 ++++
 drivers/thermal/thermal_trip.c                |  27 +-
 include/linux/thermal.h                       |   3 +
 include/uapi/linux/thermal.h                  |  30 ++-
 tools/lib/thermal/commands.c                  | 167 +++++++++++-
 tools/lib/thermal/events.c                    |  58 +++-
 tools/lib/thermal/include/thermal.h           |  40 +++
 tools/lib/thermal/libthermal.map              |   5 +
 tools/lib/thermal/thermal.c                   |  17 ++
 tools/thermal/lib/Makefile                    |   2 +-
 tools/thermal/thermal-engine/thermal-engine.c | 109 +++++++-
 18 files changed, 972 insertions(+), 78 deletions(-)
 create mode 100644 drivers/thermal/thermal_thresholds.c
 create mode 100644 drivers/thermal/thermal_thresholds.h

-- 
2.43.0

