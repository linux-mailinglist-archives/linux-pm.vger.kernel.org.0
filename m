Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1764A1A7B7E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 14:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502415AbgDNM4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 08:56:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:50097 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502340AbgDNM4B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 08:56:01 -0400
IronPort-SDR: X6FcYjS2eqFIifHJ85BT+Ng50P9yy1a8MjiAGa9MZ+/S9yVuhkyO2QFpl+w0AZ/SORN4wp0ARS
 48bXwRkqgTiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 05:55:59 -0700
IronPort-SDR: rWUMvFQJu/iBOGiTAM3Ryuo+wwWvjD0XPzEvZwU0i8H/vuMJ0sxFgKo1GqmBX/e4Wq7ZDUSvS6
 /niiT0DnNPNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="427051389"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2020 05:55:57 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][RFC v2] tools/power turbostat: Enable accumulated energy consumption for long time sampling
Date:   Tue, 14 Apr 2020 20:56:21 +0800
Message-Id: <cover.1586782089.git.yu.c.chen@intel.com>
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
 tools/power/x86/turbostat/turbostat.c | 273 ++++++++++++++++++++++----
 2 files changed, 237 insertions(+), 38 deletions(-)

-- 
2.20.1

