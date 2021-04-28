Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35F936D46F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhD1JFs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 05:05:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:1522 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhD1JFs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Apr 2021 05:05:48 -0400
IronPort-SDR: aOcTg/IZvFCiaUr4wZWupa7l42GWuD3EIH9BbT6fYzQpQ62XIcL4DgH7A4+nPQNJjxkTpJHiLd
 UEKNQUT5Hnvw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="183836813"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="183836813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 02:05:02 -0700
IronPort-SDR: 9nQBvUbQM2Uq3UQjVXNkkDOv+4LFTTC23729isTETMuSfYCkr0VGMMr9JRKmBsH7djpjGWoSY6
 RR3QC5BOdusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="423437549"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.173])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2021 02:04:59 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     youling257 <youling257@gmail.com>, Kurt Garloff <kurt@garloff.de>,
        Bingsong Si <owen.si@ucloud.cn>,
        "Artem S . Tashkinov" <aros@gmx.com>
Cc:     Terry Bowman <terry.bowman@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Calvin Walton <calvin.walton@kepstin.ca>,
        Borislav Petkov <bp@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] tools/power/turbostat: Fix long time duration RAPL calculation
Date:   Wed, 28 Apr 2021 17:08:45 +0800
Message-Id: <cover.1619600637.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A combination of patch set to fix the recently introduced long time
duration RAPL calculation issue found on AMD CPUs.

Youling, Kurt, Bingsong, Artem, could you please confirm again
if this patch set works for you on your platform?

Bas Nieuwenhuizen (1):
  tools/power/turbostat: Fix turbostat for AMD Zen CPUs

Calvin Walton (1):
  tools/power turbostat: Fix offset overflow issue in index converting

 tools/power/x86/turbostat/turbostat.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.25.1

