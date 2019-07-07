Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4629461810
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfGGWfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37722 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfGGWfD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so11882585qkl.4;
        Sun, 07 Jul 2019 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0CL8ZubwI9pxioIsO+wdfiQKWRkWUvqc6jWagPflEy8=;
        b=j2QPKbz9mnJorrz5ljWMjblQ9fC7gblcSF7t01I0RXMNO88zVdO1dmMBvvRHob0bMF
         FHrii8L6aYSyJYEb0hoPzEhBLQ01zi7Zixg2bA+NpZMdxOf3X6hZmRc6Us/K68SY66jj
         hAdd1vbV0GUNoG5lh62kSI3Obz1XZI4WTyOajZO5ReHyO/JUBAZrsh4BoCbXgqYaGrBr
         1OB0ejUfSaLN982QgJuhrt0THhsTN3obVb/2gSUgm6gtfkqW7lFw3kwmY5Ll4OQFnuXD
         7uQFNMysU0b+QZJjjigQT2BnkLAf6ggVpWHLj1QkxgO02KCSl/d33ttZVZEmeatOIhns
         znQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0CL8ZubwI9pxioIsO+wdfiQKWRkWUvqc6jWagPflEy8=;
        b=ax7PF3CZHjx67EnHnoR2qq5cGk/dnVNrpec5J6+QaQko3n5WhQlOJBNOBlFJJAwoc9
         nZa9RUHilNsZUdP01OuN4GSndWRh0ykLtvEQGl55vDgR5xs9BXgN5NDbHo6EFKLNC/vl
         ftjyYt36BYQMQxldPoRiEhtanvEjKHiO7XmfQ830+qaKgHAZNwpDNz1D+85ghSCulCXZ
         buh98lLNBJtl9/2FICpQ7gFgjbaPnj5uHscxANTgHfU4TCYDgXqO57HN6CoXJUGynNeK
         GHS3dqOz23jNKUf+GBloa3/FdkyzXzX51UzAtDdtS5PQHSBoCwUefs/Xf6a3ETYTmbgJ
         dI2Q==
X-Gm-Message-State: APjAAAXj+IHX7JUmoNzgpahbcCHJYyZwsEVttkk/Zj2ULp1bK5hLwhSo
        DsKtwRWcEEkBllRPCAYlgaU=
X-Google-Smtp-Source: APXvYqzSKsSweq1HMKIN23WTw8T4ov81hRQm0gf9ursc2xBy/wksNMudoqyJaByxKktHo0Pq76SFsg==
X-Received: by 2002:a37:5f45:: with SMTP id t66mr11845712qkb.286.1562538902622;
        Sun, 07 Jul 2019 15:35:02 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/24] More improvements for Tegra30 devfreq driver
Date:   Mon,  8 Jul 2019 01:32:39 +0300
Message-Id: <20190707223303.6755-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series addresses some additional review comments that were made by
Thierry Reding to [1] and makes several important changes to the driver,
fixing excessive interrupts activity. In the end I'm proposing myself as
a maintainer for the Tegra devfreq drivers.

[1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com/T/

Changelog:

v4:  Added two new patches to the series:

       PM / devfreq: tegra30: Synchronize average count on target's update
       PM / devfreq: tegra30: Increase sampling period to 16ms

     The first patch addresses problem where governor could get stuck due
     to outdated "average count" value which is snapshoted by ISR and there
     are cases where manual update of the value is required.

     The second patch is just a minor optimization.

v3:  Added support for tracepoints, replacing the debug messages.
     Fixed few more bugs with the help of tracepoints.

     New patches in this version:

       PM / devfreq: tegra30: Use tracepoints for debugging
       PM / devfreq: tegra30: Optimize CPUFreq notifier
       PM / devfreq: tegra30: Optimize upper consecutive watermark selection
       PM / devfreq: tegra30: Optimize upper average watermark selection
       PM / devfreq: tegra30: Include appropriate header

     Some of older patches of this series also got some extra minor polish.

v2:  Added more patches that are cleaning driver's code further and
     squashing another kHz conversion bug.

     The patch "Rework frequency management logic" of the v1 series is now
     converted to "Set up watermarks properly" because I found some problems
     in the original patch and then realized that there is no need to change
     the logic much. So the logic mostly preserved and only got improvements.

     The series is based on the today's linux-next (25 Jun) and takes into
     account minor changes that MyungJoo Ham made to the already queued
     patches from the first batch [1].

Dmitry Osipenko (24):
  PM / devfreq: tegra30: Change irq type to unsigned int
  PM / devfreq: tegra30: Keep interrupt disabled while governor is
    stopped
  PM / devfreq: tegra30: Handle possible round-rate error
  PM / devfreq: tegra30: Drop write-barrier
  PM / devfreq: tegra30: Set up watermarks properly
  PM / devfreq: tegra30: Tune up boosting thresholds
  PM / devfreq: tegra30: Use CPUFreq notifier
  PM / devfreq: tegra30: Move clk-notifier's registration to governor's
    start
  PM / devfreq: tegra30: Reset boosting on startup
  PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
    startup
  PM / devfreq: tegra30: Add debug messages
  PM / devfreq: tegra30: Inline all one-line functions
  PM / devfreq: tegra30: Constify structs
  PM / devfreq: tegra30: Ensure that target freq won't overflow
  PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
  PM / devfreq: tegra30: Use kHz units uniformly in the code
  PM / devfreq: tegra30: Use tracepoints for debugging
  PM / devfreq: tegra30: Optimize CPUFreq notifier
  PM / devfreq: tegra30: Optimize upper consecutive watermark selection
  PM / devfreq: tegra30: Optimize upper average watermark selection
  PM / devfreq: tegra30: Synchronize average count on target's update
  PM / devfreq: tegra30: Include appropriate header
  PM / devfreq: tegra30: Increase sampling period to 16ms
  PM / devfreq: tegra20/30: Add Dmitry as a maintainer

 MAINTAINERS                            |   9 +
 drivers/devfreq/tegra30-devfreq.c      | 648 +++++++++++++++++++------
 include/trace/events/tegra30_devfreq.h | 105 ++++
 3 files changed, 607 insertions(+), 155 deletions(-)
 create mode 100644 include/trace/events/tegra30_devfreq.h

-- 
2.22.0

