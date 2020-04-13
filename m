Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FFE1A635E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgDMHAm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgDMHAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 03:00:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82575C008651;
        Mon, 13 Apr 2020 00:00:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i3so67133pgk.1;
        Mon, 13 Apr 2020 00:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vq9fVC/+atcm9sq/MZsavv/suvJU7kj+o+ueUYxNyc4=;
        b=CR8c8HlxxuKiXNyCthLNzWYOFiWWWq/N2EQHg+YZb11uAbVxigFRy6IHJFMOy07j/i
         Qt1LJfKU7HudAz5rsUO7sCAOTSPeqkjXR8qjS8LPCfnt/ymY8xXDHTeQK0iB+V+6mgKs
         WJe3AaawQB54O2xlpb7A1YXAWUUrQhmqntkwSVanEw7sHLXg96bEVSJAaPGavaySrtOT
         Ds9cjEztjHzfZmUEGnCr5RVmsDAaJp+SfEdVGX1bl914YR9KHfwJ+GZOT9CENuBGQJdu
         6LwCgY2Lgf2cQjBE5JgWozwcUGJvSgCIQx0I7kXkpqNSlk/uD+PRAVKnhybHWf2nmU1+
         d+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vq9fVC/+atcm9sq/MZsavv/suvJU7kj+o+ueUYxNyc4=;
        b=RjMEU/tc2Lcj1JvCXkqYpO8M7Y2Cp0ckXGx+ywhkjQAk+Q6phu4XRmyAmoak6LK6xH
         9FCmEYSiQO5NKvmloc1X7FxQMx4c6UfVyxow/7emzE3rUeSW3UbRwxLXALa69N9yFsT3
         KE7S1tuAyGIa2mYM2Xaw3A/LlQAI2PMARWLmqLvSBwheKe5VETQGTYaucfmWKH5IWq/J
         EZZ0M0BIAi5runRy0ucX0/QlgmXStgI//hLCmyrp2YIbztZT6R1+Vj4MWnPuth4FZy64
         rQzZEkVAYzRFzUjvVI/i26VTyjXCtnE0ZADJiLH7wr4tv4euTwm0XqxAa0ShpwV2lh+v
         rW6Q==
X-Gm-Message-State: AGi0PuaVkeN2qpnt8nj8QTg+K9j4A89WNd3evfazZ8Yc3ApjOHQaxR+E
        z1NMP3gWtfzZWnQaWQiu5RQ=
X-Google-Smtp-Source: APiQypJXOLKJmWnL8c+MQV5lQGIKFp6AH0keWS6hBKsja5EQEQiaT3oQ5MtfGpxL0FMP2zNbuBvbrg==
X-Received: by 2002:a63:230f:: with SMTP id j15mr15933448pgj.393.1586761241161;
        Mon, 13 Apr 2020 00:00:41 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p4sm7815670pfg.163.2020.04.13.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 00:00:40 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RFC PATCH v1 0/2] allow idle state to be found as deepest state for s2idle only
Date:   Mon, 13 Apr 2020 15:00:12 +0800
Message-Id: <20200413070014.12960-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

We can add a new c-state to let system suspend enter into the same deep
state as s2ram when using s2idle, but we don't want other cases to use
that c-state, such as play_idle() which would find the deepest state by
invoking find_deepest_state() as well. This patch-set provides users
an option which can restrict c-state to be found as deepest state for
s2idle only.

Chunyan Zhang (2):
  cpuidle: allow idle state to be found as deepest state for s2idle only
  dt-bindings: arm: Add description to the new property for-s2idle-only

 Documentation/devicetree/bindings/arm/idle-states.yaml | 10 +++++++++-
 drivers/cpuidle/cpuidle.c                              |  3 ++-
 drivers/cpuidle/dt_idle_states.c                       |  3 +++
 include/linux/cpuidle.h                                |  1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.20.1

