Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10D42874B3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgJHNBS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 09:01:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14219 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbgJHNBS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 09:01:18 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f0d300001>; Thu, 08 Oct 2020 05:59:28 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 13:01:13 +0000
Received: from sumitg-l4t.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Oct 2020 13:01:08 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>,
        <sudeep.holla@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 0/2] Tegra194 cpufreq driver misc changes 
Date:   Thu, 8 Oct 2020 18:31:04 +0530
Message-ID: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602161968; bh=9s6nKoWby0Js5iN47SgUtQbN+f24ZBXQFZNUNtCSHjY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=GB4hmWVTxMQOJ+foPyXJ2sZ77tlLlBVDogPMt7IRxy3JG13R/6Rb9+bzlVvFJLjRX
         03hiaE21R5Qjho5sDA97q38ZCSJauOxvTWAZI5fwEeQGZPoCoPElsiHrhPlD127VtT
         PDyAqHh7ZHx5NjrGt1lGtc7yk9WuE1qjTTEoSuRcsx6275m44503doHC4urbfN3y+9
         8nSzKVvT6kFsCQJqgLqWpG7FJ6TSdLt76+ZeZ4skFDFLdSVmXfO0jgcq4iKq9AQQ9+
         K0w7pZ/mcPNVFs0peWhm/2ehdSvARKPwX9o/+js+yWV4/4W47WQmMr10wFI6gyZwxM
         aGULkdDEH6Ang==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch set has below two changes:
1) get consistent cpuinfo_cur_freq value from freq_table.
2) Fix unlisted boot freq warning by setting closest higher
   freq from freq_table if the boot frequency gets filtered while
   creating freq_table in kernel.

v1[1] -> v2:
- Minor changes to improve comments and reduce debug prints.
- Get freq table from cluster specific data instead of policy.
- Set a freq from freq_table if boot freq is not present in table.
- Add online hook to fix unlisted boot freq warning in hotplug-on.

Sumit Gupta (2):
  cpufreq: tegra194: get consistent cpuinfo_cur_freq
  cpufreq: tegra194: Fix unlisted boot freq warning

 drivers/cpufreq/tegra194-cpufreq.c | 153 +++++++++++++++++++++++++++++++++----
 1 file changed, 139 insertions(+), 14 deletions(-)

[1] https://marc.info/?l=linux-arm-kernel&m=160028821117535&w=2

-- 
2.7.4

