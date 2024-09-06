Return-Path: <linux-pm+bounces-13751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CD96EC19
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D317B2150D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918D1494AC;
	Fri,  6 Sep 2024 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYCronVy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6714A630
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608204; cv=none; b=e7VaADn8pY8jrWvreElr0A1jO7BEGRuvddjxklBV4uq2RZc75uazvXnEqQBprHsTQAJXVk5hk7rV28A9MKZ36W7+mg4nYgn8RHyZ4vaLhC9ZvXwVAI1tkjOqXrtUubkEYqa2Xez0rpbXHuFNttZe7p7sx9XWBsbsMDQ3ffQsPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608204; c=relaxed/simple;
	bh=EAcr6Xd3mff1MxsUd7zygd/LlarQsfW13sz7U/Tcs+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEPqpGpw8O4iIyAxHLXlWhKgJeJ7dOkJn/Au+o1/noTcuodd2bj3zLHVBcLcQvHtLMAS1ig/fkC1a5TbxUrsuHV7+weo7PAawAbdTDcF4hQ5DTlvXklgVD4ny3sl9bUePgZYux83Rl1TS++JvLU6G1ehin7vl7p7h6MHBq6Raf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BYCronVy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so12769035e9.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608201; x=1726213001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mEYKJXdqgML63+bvkAyGJwYs4LjZH6SBiHQp+Q+gA7w=;
        b=BYCronVy0AcB0q1lftuPZ+aFrvRmJPAZW+wGJhLrAntD4mBlSYqUWNKAqxiIQP5HFs
         o8g/7QT9ywqRbaCmQau0nSX2cb0PS8X6WFkGaHFqppkwz93L+3+goSSOqNbXuaZW8nvq
         bmqPnkz/rls42I5isW4oEFDDomP0k+BHRQs7nYQ8Cgba9UlOeJx/OPha6zE7+CTnWfNy
         tP7DePQH3V7PnnKJB5/ARNt3ZBvD6gdlGXZlb6ugZZ6JSJ4Pzaet89fhQmazCnplFVQT
         A+6y7tQ6GBGMxUzkWLu5M45dh6VbRIm0otKBbbXpFwY4tu1r2K/Bi/8twLg/VPLyN7Xp
         1Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608201; x=1726213001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEYKJXdqgML63+bvkAyGJwYs4LjZH6SBiHQp+Q+gA7w=;
        b=S1qOM+83A4PbFkjNrt4HAXExbcpPgEG2vkgzLlWkyRUOZGSfjHSVuIzPRaGZL3HmGN
         cnrLUtN3qJUA4D5SU8l3UOI5FeU4+GaGTq6pcaUfhmrSVOYHOQy64NqJja0hiTBJbdbS
         bKaX5RhDsUc/c/IUAWo4SoxsizSbPXX7+g19oKk2zb/kk2RdP+7GSVkRI9RIgXXg5QU5
         SvVerX3yyNEo2/bNGFkgCRpRHK5Wm2hR+ebnwTnwguwqmOtdSHKE0uQ3W3TENiHwMoww
         coI0u8oH1TKZjjJZ6724HUcgxE+KkhRE9VGBIM1US+Mc3UNwspt6pj98qAJmKLzLxZ37
         zEvw==
X-Gm-Message-State: AOJu0YwJ75U5D4LUGhd4zrc7eYnXI2IAve/t7b4Vaq+fZ+Bmet6/QU9h
	wUJmFCj1eNvoM2QUtUHGA4pIjHj9blOqEItsQdgLYGy/YhV1vTvdyyq58MnyRac=
X-Google-Smtp-Source: AGHT+IETHvRxueLd7UZxuU5GkkovgTtyr8v0dIoMc7IeOswT73ItCn6EKfwoQffmcKr5egVY7udGRA==
X-Received: by 2002:a05:600c:3ca7:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-42c9f97caa0mr11598405e9.13.1725608200569;
        Fri, 06 Sep 2024 00:36:40 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-376914bfca1sm8113885f8f.18.2024.09.06.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:36:40 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v3 0/6] Add thermal user thresholds support
Date: Fri,  6 Sep 2024 09:36:21 +0200
Message-ID: <20240906073631.1655552-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/thermal_netlink.h             |   7 +
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
 16 files changed, 894 insertions(+), 49 deletions(-)
 create mode 100644 drivers/thermal/thermal_thresholds.c
 create mode 100644 drivers/thermal/thermal_thresholds.h

-- 
2.43.0


