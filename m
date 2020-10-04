Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A29282D48
	for <lists+linux-pm@lfdr.de>; Sun,  4 Oct 2020 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgJDTcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Oct 2020 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDTcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2020 15:32:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D8C0613CE;
        Sun,  4 Oct 2020 12:32:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r127so3802540lff.12;
        Sun, 04 Oct 2020 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GB4h5Xl/CoQUaS0iXXY2E8krzQRbuhNv8HD6xlseMxY=;
        b=fq+RG1alzKFM4Rvwo0TAFkVbMbKqF0jBNOZkVnPZgwPBHWyq34z+myBfOIoO9KR2BV
         As6A+A7txwxqhxRf1dfQio3ljksdfMEM7sNWk5GyrUdF4OrdGYyCpzoSJPf6SakGTwo6
         b6L/RwUS7apA8i4vDcT8C04MoeoL+22W7QKPIcl+Bk3o87Erh+Yh4Tcr+SopDcHlcko+
         aV+2LkXRj46F53QJHjcTdDHAGBxsNodereE+VEOs+VUaWSUEogAiM65in79vw9Pjx3no
         I5VUM0Q91gH7Y7F6V5kkWTxNVtNd2QYoJP4DNYRhB9PKGMnF8df5OkR19xA9gN3I2gNo
         T7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GB4h5Xl/CoQUaS0iXXY2E8krzQRbuhNv8HD6xlseMxY=;
        b=sPZi3rv515zOcv1FFReUXKCIJfx13ZYXs/Wo1my1LGLx1rwP6AYq7umbuu5+vofkoN
         JQO8kIIRU3Tcq9YhqeFlUUUpEvPMepQzck5gN21QsU40kdCzYijzGkRebnzfneP4E8FD
         rG8XJoyEZQhpPBlAfews7hxqTLAcGxKTv79F/aBPePB7Y6Z9EfUb5aAkqI6YpSWy7Emq
         YC8hx7K9ay1rK4SKEmUbRzr5y+nbjURM6H8wskcOhLNii8lkH1d+AuWI63uhjFyDRquz
         xQCDS57v8+qLsnNtnnAGM3EHi3fAmxs/1TfH7yVnjq6AOHoyaGD/AEUhnpHuUoUA5iMW
         9PTg==
X-Gm-Message-State: AOAM530gKNmU9MRbk9HpM34DTS4thfwXCZpxnsYreiBIwfcFOUfh5q1E
        VKxRWTIxLGiQ+jJm5pyCoPc=
X-Google-Smtp-Source: ABdhPJyMx8jEwCN+WYeATyH6LrP4nupvH1/gIU76dr9cU8YMEblPuAOqplJEgLFVnOIXft0nSioI+g==
X-Received: by 2002:a19:8c52:: with SMTP id i18mr496992lfj.115.1601839930067;
        Sun, 04 Oct 2020 12:32:10 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-221-232.NA.cust.bahnhof.se. [155.4.221.232])
        by smtp.gmail.com with ESMTPSA id h22sm2298220ljl.101.2020.10.04.12.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 12:32:09 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Akira Shimahara <akira215corp@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-pm@vger.kernel.org
Subject: [PATCH 0/3] w1: Constify w1_family_ops
Date:   Sun,  4 Oct 2020 21:31:59 +0200
Message-Id: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

None of the current instances of struct w1_family_ops in the kernel is
modified. Constify these to let the compiler put them in read-only memory.

The first patch changes the fops field in w1_family struct to a pointer to
const and makes a local variable a pointer to const to avoid a compiler
warning. This patch is a prerequisite for the second and third patches
which constifies the static structs in drivers in w1 and power. These
changes was done with coccinelle (details in the commit messages).

With these changes applied, all instances of struct w1_family_ops in the
kernel are const.

Build-tested on x86 allmodconfig.

Rikard Falkeborn (3):
  w1: Constify struct w1_family_ops
  w1: Constify static w1_family_ops structs
  power: supply: Constify static w1_family_ops structs

 drivers/power/supply/bq27xxx_battery_hdq.c | 2 +-
 drivers/power/supply/ds2760_battery.c      | 2 +-
 drivers/power/supply/max1721x_battery.c    | 2 +-
 drivers/w1/slaves/w1_ds2405.c              | 2 +-
 drivers/w1/slaves/w1_ds2406.c              | 2 +-
 drivers/w1/slaves/w1_ds2408.c              | 2 +-
 drivers/w1/slaves/w1_ds2413.c              | 2 +-
 drivers/w1/slaves/w1_ds2423.c              | 2 +-
 drivers/w1/slaves/w1_ds2430.c              | 2 +-
 drivers/w1/slaves/w1_ds2431.c              | 2 +-
 drivers/w1/slaves/w1_ds2433.c              | 2 +-
 drivers/w1/slaves/w1_ds2438.c              | 2 +-
 drivers/w1/slaves/w1_ds250x.c              | 2 +-
 drivers/w1/slaves/w1_ds2780.c              | 2 +-
 drivers/w1/slaves/w1_ds2781.c              | 2 +-
 drivers/w1/slaves/w1_ds2805.c              | 2 +-
 drivers/w1/slaves/w1_ds28e04.c             | 2 +-
 drivers/w1/slaves/w1_ds28e17.c             | 2 +-
 drivers/w1/slaves/w1_therm.c               | 6 +++---
 drivers/w1/w1.c                            | 4 ++--
 include/linux/w1.h                         | 2 +-
 21 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.28.0

