Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82C826CB0C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgIPUVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:21:25 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12679 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgIPRa5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 13:30:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6247100003>; Wed, 16 Sep 2020 10:10:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 10:11:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 10:11:23 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 17:11:23 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 16 Sep 2020 17:11:23 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f6247380001>; Wed, 16 Sep 2020 10:11:22 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 0/2] Tegra194 cpufreq driver misc changes
Date:   Wed, 16 Sep 2020 22:41:15 +0530
Message-ID: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600276240; bh=KDmFmHnbdZXAGP959ydQrI6k+UcmrVJXDgccwkGxf2w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=qzXvQkx1mCXjNKRPbX5yO4g9llcmu8dnti/bkRB0zY6arVj3jC0NkByCmhCWtsb7O
         0AvBBwmNRBTMMOBEA9KeEy18O8Jmhn6BgalyGvnNvHM6H2PoevDq4mqHKtMYbYZ0Rr
         FC971T/KVyNkfiwWPxE2Ctg1gB6f0S7GakjIqzsa+b01bZek4894bbB6gr0vRMqRoO
         UzD9/VviDAjccFfASJJQNbkgdm7bvyog1pFFCtZ57hYQFnoGP3QMSNmabEdbjTFu19
         6jGdMYSZpABIlxTrXASYoMeZ6AIo437aZobV8C5SYG2V+3kjHphk/o6CjUSVasgb08
         UaVA+8o2JOk/Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch set has below two changes:
1) get consistent cpuinfo_cur_freq value from freq_table.
2) Fix unlisted boot freq warning by setting closest ndiv value
   from freq_table if the boot frequency gets filtered while
   creating freq_table in kernel.

Sumit Gupta (2):
  cpufreq: tegra194: get consistent cpuinfo_cur_freq
  cpufreq: tegra194: Fix unlisted boot freq warning

 drivers/cpufreq/tegra194-cpufreq.c | 182 ++++++++++++++++++++++++++++++++++---
 1 file changed, 167 insertions(+), 15 deletions(-)

-- 
2.7.4

