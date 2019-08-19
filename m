Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DD94C15
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfHSRzA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 13:55:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33620 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfHSRy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 13:54:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so1603268pfq.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MW64udRZZTYjeoFAzTVzLQFQQek0N5DUnNryD8PEGbs=;
        b=BFxv2Z0JDOq1B0BGDrU+WG8JI09yP8MI9bNRj5ujd+iRomT7WccF73hGNDYcteCeBI
         OgEoRYdc1VlJCrlF+5eXz0/nYZnFP/3L6IXtFBtmT0UAKalldk48tsF2TKdwR8ITaTRS
         Dai9cDe5ro42eEYHa/vQCoPkcVg9KSssSgTY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MW64udRZZTYjeoFAzTVzLQFQQek0N5DUnNryD8PEGbs=;
        b=ie+y5zT7Xu+tnQmg16XqTMmLsHUQZd/Inh+FY0Ww8vn+ztWfKgWLu8ZFls3apfFGDD
         As1iKdBuMTUmnfQ2csbtqDo3gKuJH0tLILF1GIS7yjAP9tnH4sLEbcZiqpGcJtNlxNKs
         WQXEK8twQI/58O/jf5BRxbHwGwCwVpDgY+BkJBqfseXg9ya3VbPotTaEzKylCedZvpF8
         08Qep/l0HXEY3wVdZtIS3JUFDnBkdeKOSx1NHfsh3hEujTuEbpy61OlCrLHzQQGflKDr
         3cH9ez2CDZWVyL9CnQZCMHWtF43KeujuoTh+sPQWSZxbflayeTfmY4IKO4VQkFHN2Oqd
         p4mA==
X-Gm-Message-State: APjAAAUKvxa8DFxi/EG5n3NgpiOblTZwy8tBG/eUDi+OgFCQoZ+BbnjN
        9AGFGnQQZqJNdYEq6fXjzhMyhQ==
X-Google-Smtp-Source: APXvYqwKMjD+9wsCXJcs+RYjWqkYAICWjsDh/OArsHSIGOWXQ8I6Qgi0ieWcoAgwmfmJkqIzdyetEA==
X-Received: by 2002:a63:6888:: with SMTP id d130mr20157988pgc.197.1566237298980;
        Mon, 19 Aug 2019 10:54:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h197sm18084237pfe.67.2019.08.19.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:54:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: [PATCH v3 0/2] PM / wakeup: Fix wakeup class wrecakge in -next
Date:   Mon, 19 Aug 2019 10:54:55 -0700
Message-Id: <20190819175457.231058-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now a patch series because I found another patch to apply to unexport
some symbols.

Changes from v2:
 * Fix logic for not adding the wakeup class from dpm_sysfs_add()
 * Compile tested on !CONFIG_PM_SLEEP

Cc: Qian Cai <cai@lca.pw>
Cc: Tri Vo <trong@android.com>

Stephen Boyd (2):
  PM / wakeup: Register wakeup class kobj after device is added
  PM / wakeup: Unexport pm_wakeup_sysfs_{add,remove}()

 drivers/base/power/power.h        |  9 +++++++++
 drivers/base/power/sysfs.c        |  6 ++++++
 drivers/base/power/wakeup.c       | 10 ++++++----
 drivers/base/power/wakeup_stats.c | 15 +++++++++++++--
 4 files changed, 34 insertions(+), 6 deletions(-)


base-commit: 0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23
-- 
Sent by a computer through tubes

