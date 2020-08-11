Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39E8241D2C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgHKPby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 11:31:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:25702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbgHKPby (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 11:31:54 -0400
IronPort-SDR: B2+jD7nvxTXECvRnNRQKD9b/jLMMqDYUrsMhi0ByjxJFMpxIv1s0t49piobR3BYwQU4LsPMNRT
 8tE5n/NoJ4Ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="238588441"
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="238588441"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 08:31:54 -0700
IronPort-SDR: kp0EHMCemPHZhg+a3AXanMgr+SzKKlEyrqRDEczMzE/VSLZEHgLXn4HyUQ0zZ952q4FqKajvo0
 FYNJereQCueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="439077136"
Received: from xzhao1-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.175.227])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2020 08:31:50 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Subject: [PATCH v2 0/3] perf/x86/rapl: Add Intel SapphireRapids support
Date:   Tue, 11 Aug 2020 23:31:46 +0800
Message-Id: <20200811153149.12242-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, all,

This patch set adds rapl perf event support for Intel SapphireRapids
platform.

Patch 1/3 fixes a regression that Psys RAPL Domain sysfs I/F is missing.
Patch 2/3 introduces support for different energy unit quirks.
Patch 3/3 introduces support for Intel SapphireRapids platform, which has
          fixed energy units for DRAM RAPL Domain and Psys RAPL Domain.

Any feedbacks are appreciated.

thanks,
rui

v1..v2:
- add ACK from Jiri Olsa.
- update patch 3/3 to solve a conflict introduced in the merge window.
