Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB51AEAE4
	for <lists+linux-pm@lfdr.de>; Sat, 18 Apr 2020 10:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgDRIbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Apr 2020 04:31:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:9878 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgDRIbM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Apr 2020 04:31:12 -0400
IronPort-SDR: Rdk0uKTxrCtnJuz2Jtd9nncjie8rJ5PXrBJzY6wxySY8a1EHWuYJlkLUQ44TRTeA8LQrt0x86w
 OHrQ1aQkLFTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2020 01:31:11 -0700
IronPort-SDR: hL1EjEYgZTvU2tAV9UO+xA2cb625vugVGc729HMVv1FGFqKwbRjC1RtWx/aeNTO0YrKYNU2TEC
 I4b4xEdTOkRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,398,1580803200"; 
   d="scan'208";a="455864199"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2020 01:31:04 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][v3] tools/power turbostat: Enable accumulated energy consumption for long time sampling
Date:   Sat, 18 Apr 2020 16:31:34 +0800
Message-Id: <cover.1587196252.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RAPL Joule Counter is 32 bit, turbostat would
only print a *star* instead of printing the actual energy
consumed due to the overflow of RAPL register.

Introduce the accumulated RAPL mechanism to avoid the possible
overflow.

Chen Yu (3):
  tools/power turbostat: Make the energy variable to be 64 bit
  tools/power turbostat: Introduce functions to accumulate RAPL
    consumption
  tools/power turbostat: Enable accumulate RAPL display

 tools/power/x86/turbostat/Makefile    |   2 +-
 tools/power/x86/turbostat/turbostat.c | 292 ++++++++++++++++++++++----
 2 files changed, 248 insertions(+), 46 deletions(-)

-- 
2.17.1

