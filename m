Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1875945528C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbhKRCW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbhKRCW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:22:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EF2C061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:19:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b40so18095534lfv.10
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZxmOzcc3LC/0N8q5QTBhk/vecbRNubeeedDXrYZLRE=;
        b=xa/Ktx1Ul5LB8tNtvjJiWU3NrYqD9WC/q3pMaQ82Wner8JN5w95mEqpNVKc2L07dU3
         nwvTWRkD71PjZiHwtDkG2GfHmbilcPLxBiNn+C/FY9ti5xnwY/03txrLAddMfYweZ5dW
         KxmWbDymBJdZC8ju7pkxOO/tgYK8J17DauoW/KGSfqLILSlBR+O8twI5juw84TXqOFQb
         S2JGUTY2v/Ed9yyrTp5R/uoVdoI7tlKvGgGq2e5aOdgqKQXRo50oQZGph9nXdisHR23Z
         g706Jt/24bpyekK1UHtmhRr/DPq6rpvsKojkQ4PZjOARuQ41uOH9voSr/D1Q3r58c9H/
         f4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZxmOzcc3LC/0N8q5QTBhk/vecbRNubeeedDXrYZLRE=;
        b=owlFksokJJP4T60vDZ0Zy6xb8RhICaDFebMWG1XyOJQfi4GQw9HW/YFJXK/tqpGiSs
         1kh0q0WQgit/OltrxH8cVihYPwExYL0a+BtuSeEp8KVYr6WIjB7zquPbdwl+hxJfzTtC
         qTvY1NtHOdXlNLN7r85HdcDk45yLtkzoXIflvGHXgmeea+upTm/FGGjJRj9+hFQgIA7o
         UjYEEZqT5H+J6vd8HNy3JbnoYQCfG2knQp33WqLB4Zzqg3yV+EvVP8TjUhsA17xCn+DK
         KC/fhNjSeF/Sa5/6EfK19rHDcLdzZm80Dskon3jWG111MafgFJ4CLpQpyVIs8uPtDqdr
         c0YQ==
X-Gm-Message-State: AOAM531r+fWSC186IF2ciCe1k/8ytsV29dOwXAvMgmhWHgQGlwf8m2NC
        6UieY3zu4sKSpI/++1uU+qgw3g==
X-Google-Smtp-Source: ABdhPJyhOlfCEva0K+9B6q517QSDec5Fx/ygHsptbvI7EqzP2DtZDqMb7IbW714Wh5GDjtjg56KVww==
X-Received: by 2002:a2e:bba0:: with SMTP id y32mr12484155lje.138.1637201995776;
        Wed, 17 Nov 2021 18:19:55 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:19:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/16] AB8500 charger to use power_supply_battery_info
Date:   Thu, 18 Nov 2021 03:17:36 +0100
Message-Id: <20211118021752.2262818-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is the first set of patches starting to migrate the
AB8500 charging code to use the struct power_supply_battery_info.
We drop some cruft along the road.

This series does not add anything to the struct, just reuse
what is already there. Adding new stuff comes in the next
patch series.

The AB8500 charging code has not been in working condition for
some time, but it is slowly getting there. Some of this is
just regular maintenance.

Linus Walleij (16):
  power: supply: ab8500: Use core battery parser
  power: supply: ab8500: Sink current tables into charger code
  power: supply: ab8500: Standardize operating temperature
  power: supply: ab8500: Drop unused battery types
  power: supply: ab8500: Use only one battery type
  power: supply: ab8500: Standardize design capacity
  power: supply: ab8500: Standardize technology
  power: supply: ab8500: Standardize voltages
  power: supply: ab8500_fg: Init battery data in bind()
  power: supply: ab8500: Standardize internal resistance
  power: supply: ab8500: Standardize termination current
  power: supply: ab8500: Make recharge capacity a constant
  power: supply: ab8500: Standardize CC current
  power: supply: ab8500: Standardize CV voltage
  power: supply: ab8500: Standardize temp res lookup
  power: supply: ab8500: Standardize capacity lookup

 drivers/power/supply/ab8500-bm.h       | 121 +-----
 drivers/power/supply/ab8500-chargalg.h |   8 +-
 drivers/power/supply/ab8500_bmdata.c   | 566 ++++++-------------------
 drivers/power/supply/ab8500_btemp.c    |  61 ++-
 drivers/power/supply/ab8500_chargalg.c | 315 +++++++-------
 drivers/power/supply/ab8500_charger.c  | 536 ++++++++++++-----------
 drivers/power/supply/ab8500_fg.c       | 371 ++++++++--------
 7 files changed, 796 insertions(+), 1182 deletions(-)

-- 
2.31.1

