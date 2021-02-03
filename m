Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A530D593
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 09:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhBCIvf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 03:51:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:32820 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhBCIve (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 03:51:34 -0500
IronPort-SDR: XCGp58A/5mbre23MW/tjD8NrhVQtcgpP4K8wIZzT5GDjkwZiA0uvM1ncMmUSidU+EtSMzkGd+P
 0iDzfLrH3weA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177501312"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="177501312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:50:52 -0800
IronPort-SDR: cEUiofSbB9VAT4J4Mq9U0O8CsCSINPvUfCYDm91QeRbFgX7iUwR4gowaK27UxdG5gAFRv2k3we
 nlaibvJyA0Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="433315023"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.173])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2021 00:50:49 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] Add more CPUs support in turbostat
Date:   Wed,  3 Feb 2021 16:54:11 +0800
Message-Id: <cover.1612341978.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Alder Lake P and Ice Lake D are added in this patch set.

Chen Yu (2):
  tools/power turbostat: Support Alder Lake Mobile
  tools/power turbostat: Support Ice Lake D

 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

