Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B6382435
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 08:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhEQGYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 02:24:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:34734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhEQGYJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 May 2021 02:24:09 -0400
IronPort-SDR: cxLLQrqFjaMgdlyFYOHV9VYArK0+xaOB4rj4o8AMlhJatW2fzuoxm2aP6VvURYOh/fNgIIq0ZP
 MzjQxOS939vA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197306271"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="197306271"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:22:54 -0700
IronPort-SDR: Tq/eMG+cvuP9MQ4aGrf3PrbxaCboIg3gN/rQgFOwX8Yshmi7IfPDhFysjbuHZtxTki1lfmMznC
 oDU90IU8Fraw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="393388424"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2021 23:22:53 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] thermal: int340x: processor_thermal: Add additional
Date:   Sun, 16 May 2021 23:14:39 -0700
Message-Id: <20210517061441.1921901-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add additional attributes to RFIM, which use mailbox commands. 

Srinivas Pandruvada (2):
  thermal: int340x: processor_thermal: Export mailbox interface
  thermal: int340x: processor_thermal: Export additional attributes

 .../processor_thermal_device.h                |  2 +
 .../int340x_thermal/processor_thermal_mbox.c  | 12 +++-
 .../int340x_thermal/processor_thermal_rfim.c  | 55 +++++++++++++++++++
 3 files changed, 66 insertions(+), 3 deletions(-)

-- 
2.27.0

