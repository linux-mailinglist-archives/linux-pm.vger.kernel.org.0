Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E119199E4E
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgCaSph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 14:45:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:15082 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgCaSph (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Mar 2020 14:45:37 -0400
IronPort-SDR: gJfjGxAvXhvL4DmX4qoAGLvkDhre59XWe8tZtuRoUV2D6H+m1yZsJn16TRfZma/JpAAY2+DrzV
 ForfPtR0RamQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 11:45:36 -0700
IronPort-SDR: zm4uUFx0EZdeysPbdQSBr5/blLu7c5wJUBAtX1dwRExJ+qEXEX3NIGo7NuyEeN6LVwrNt0JlAg
 1taGleO553RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="395596154"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 11:45:34 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC] Add long time sampling time support
Date:   Wed,  1 Apr 2020 02:44:16 +0800
Message-Id: <cover.1585679838.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the RAPL Joule Counter is 32 bit, turbostat would
only print a *star* to indicate the overflow due to long
duration.

Print the actual energy consumed for long sampling time.

Chen Yu (2):
  tools/power turbostat: Make the energy variable to be 64 bit
  tools/power turbostat: Introduce reliable RAPL display

 tools/power/x86/turbostat/Makefile    |   2 +-
 tools/power/x86/turbostat/turbostat.c | 322 +++++++++++++++++++++++---
 2 files changed, 287 insertions(+), 37 deletions(-)

-- 
2.17.1

