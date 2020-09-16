Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842F026CC4A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgIPUk6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:40:58 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:47174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgIPUky (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 16:40:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E27EB1803A837;
        Wed, 16 Sep 2020 20:40:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:968:973:988:989:1260:1311:1314:1345:1437:1515:1534:1542:1711:1730:1747:1777:1792:1801:1981:2194:2199:2393:2559:2562:2914:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3870:3871:3872:3874:4605:5007:6119:6261:7903:7974:8603:8660:8784:10004:11026:11658:11914:12043:12048:12296:12297:12438:12679:12895:13148:13230:13894:14096:14181:14394:14721:21080:21433:21451:21627:21939:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: flame67_0e044bd2711c
X-Filterd-Recvd-Size: 3245
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:40:50 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>, linux-doc@vger.kernel.org
Subject: [PATCH V3 0/8] sysfs: drivers core: Add and use sysfs_emit and sysfs_emit_at
Date:   Wed, 16 Sep 2020 13:40:37 -0700
Message-Id: <cover.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Add a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done.

Add a generic sysfs_emit_at function that can be used in multiple
call situations that also ensures that no overrun is done.

V2: Add drivers core conversions
V3: Add a few more neatenings and conversions to drivers core
    Add mm hugetlb_report_node_meminfo conversion

Joe Perches (8):
  sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output
  drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
  drivers core: Remove strcat uses around sysfs_emit and neaten
  drivers core: Reindent a couple uses around sysfs_emit
  drivers core: Miscellaneous changes for sysfs_emit
  mm: and drivers core: Convert hugetlb_report_node_meminfo to sysfs_emit
  drivers core: Use sysfs_emit for shared_cpu_map_show and shared_cpu_list_show
  drivers core: node: Use a more typical macro definition style for ACCESS_ATTR

 Documentation/filesystems/sysfs.rst     |   8 +-
 drivers/base/arch_topology.c            |   2 +-
 drivers/base/bus.c                      |   2 +-
 drivers/base/cacheinfo.c                |  49 ++--
 drivers/base/class.c                    |   2 +-
 drivers/base/core.c                     |  59 +++--
 drivers/base/cpu.c                      |  84 ++++---
 drivers/base/dd.c                       |   3 +-
 drivers/base/devcoredump.c              |   2 +-
 drivers/base/firmware_loader/fallback.c |   4 +-
 drivers/base/memory.c                   |  62 ++---
 drivers/base/node.c                     | 306 ++++++++++++------------
 drivers/base/platform.c                 |  17 +-
 drivers/base/power/sysfs.c              | 160 ++++++++-----
 drivers/base/power/wakeup_stats.c       |  17 +-
 drivers/base/soc.c                      |  64 +++--
 drivers/base/topology.c                 |  10 +-
 fs/sysfs/file.c                         |  55 +++++
 include/linux/hugetlb.h                 |   4 +-
 include/linux/sysfs.h                   |  15 ++
 mm/hugetlb.c                            |  18 +-
 21 files changed, 532 insertions(+), 411 deletions(-)

-- 
2.26.0

