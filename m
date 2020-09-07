Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B588E2603F6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 19:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgIGR6Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 13:58:16 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:39118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728861AbgIGR6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 13:58:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E88A3180A9F56;
        Mon,  7 Sep 2020 17:58:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:967:968:973:988:989:1260:1311:1314:1345:1381:1437:1515:1534:1541:1711:1730:1747:1777:1792:1801:2393:2525:2560:2563:2682:2685:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6261:8985:9025:10004:10848:11026:11658:11914:12043:12048:12296:12297:12438:12555:12679:12895:12986:13069:13311:13357:13894:14096:14181:14384:14394:14581:14721:21080:21433:21451:21627:21811:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: price32_061303f270ce
X-Filterd-Recvd-Size: 2089
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 17:58:11 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/4] drivers core: Use sysfs_emit functions
Date:   Mon,  7 Sep 2020 10:58:04 -0700
Message-Id: <cover.1599501047.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a sample block of conversions for drivers/base from next-20200903.
It requires the suggested patch that adds sysfs_emit pafunctions from
https://lore.kernel.org/lkml/a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com/

Convert and neaten the various uses of sprintf family functions to
sysfs_emit and sysfs_emit_at

Joe Perches (4):
  drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
  drivers core: Remove strcat uses around sysfs_emit and neaten
  drivers core: Reindent a couple uses around sysfs_emit
  drivers core: Miscellaneous changes for sysfs_emit

 drivers/base/arch_topology.c            |  2 +-
 drivers/base/cacheinfo.c                | 32 ++++++++-----
 drivers/base/class.c                    |  2 +-
 drivers/base/core.c                     | 27 ++++++-----
 drivers/base/cpu.c                      | 50 ++++++++++----------
 drivers/base/dd.c                       |  2 +-
 drivers/base/firmware_loader/fallback.c |  2 +-
 drivers/base/memory.c                   | 59 +++++++++++------------
 drivers/base/node.c                     | 47 ++++++++----------
 drivers/base/platform.c                 |  8 ++--
 drivers/base/power/sysfs.c              | 63 +++++++++++++------------
 drivers/base/power/wakeup_stats.c       | 12 ++---
 drivers/base/soc.c                      | 10 ++--
 13 files changed, 159 insertions(+), 157 deletions(-)

-- 
2.26.0

