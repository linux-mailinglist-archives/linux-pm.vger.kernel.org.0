Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D006779C9E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfG2XKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 19:10:40 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.85]:46635 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbfG2XKk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 19:10:40 -0400
X-Greylist: delayed 1265 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 19:10:40 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id AF0B8B7427
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 17:49:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sESVhJJBwdnCesESVhme2m; Mon, 29 Jul 2019 17:49:35 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RsCF2vuzTm3iwzaX6PiskbgBBNm8IovFMRJ8CCI/Gmg=; b=GaCue3ojx2KA5yk8vKLnHWpkW2
        7DexMxtvyZkfRcB/kCwqzsGtBSXxqfmdiVHfceSNJXIJnnG3zEyI1RCxltTrS4Zmc/27ICiwT45XX
        ojrNiRulP3299WA31HPphgswkUBxkg9pbhIJzbGAr8hHxepn+xbS942SAUq8Wkfo8OSsyhwtXe911
        Xg3Rkk0Sp5Ue4s/vvgQdlb0GFdL2IHrbxr5OfTfwHc/NIDMsQrYYFHDY/2wJiOsOf6FDJpC6XnZRa
        raoymwXO6PMiGYSKmo7n0pCIndftZNEtASHi/bmch+Wov8gzCVlvIKPKpWutNrTznz1PSKJkHlzyH
        rJoEih4g==;
Received: from [187.192.11.120] (port=60902 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsESU-002FpJ-FR; Mon, 29 Jul 2019 17:49:34 -0500
Date:   Mon, 29 Jul 2019 17:49:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] cpufreq: ti-cpufreq: Mark expected switch fall-through
Message-ID: <20190729224933.GA23686@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsESU-002FpJ-FR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60902
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 42
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/cpufreq/ti-cpufreq.c: In function ‘dra7_efuse_xlate’:
drivers/cpufreq/ti-cpufreq.c:79:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
   calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
drivers/cpufreq/ti-cpufreq.c:80:2: note: here
  case DRA7_EFUSE_HAS_OD_MPU_OPP:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/cpufreq/ti-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 2ad1ae17932d..aeaa883a8c9d 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -77,6 +77,7 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
 	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
 		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
+		/* Fall through */
 	case DRA7_EFUSE_HAS_OD_MPU_OPP:
 		calculated_efuse |= DRA7_EFUSE_OD_MPU_OPP;
 	}
-- 
2.22.0

