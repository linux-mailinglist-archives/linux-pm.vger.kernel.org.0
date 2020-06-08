Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF351F13B5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFHHkz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 03:40:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:65193 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgFHHkz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 03:40:55 -0400
IronPort-SDR: vTDbiM1BYHyDPhsb+Ky3Izm9dA8HhWegU645Sj2i6EPWyF0WsAh//eLmdJdp7zWDcZqNgIy4ej
 dxh96N5OF+hA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 00:40:54 -0700
IronPort-SDR: NrnnaUFZQnglYJ7xhrb1fkBHT4kAaILlzQY9NFUOJPDv2JRivbzEAlwQsVjdVKqsQtzoask8c8
 qOOrmJ83SLJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="270426496"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2020 00:40:50 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC v2] Change trace point to cover all runtime usage count
Date:   Mon,  8 Jun 2020 15:41:41 +0800
Message-Id: <cover.1591600914.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently some code flow of runtime usage count changes is not covered by 
the rpm_runtime_usage tracepoints. Adjust corresponding tracepoints to monitor
all the runtime usage count changes.

Chen Yu (2):
  PM-runtime: Move all runtime usage related function to runtime.c
  PM-runtime: change the tracepoints to cover all usage_count

 drivers/base/power/runtime.c | 50 ++++++++++++++++++++++++++----------
 include/linux/pm_runtime.h   | 12 ++-------
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.17.1

