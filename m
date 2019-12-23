Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8C129736
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLWOVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 09:21:08 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33602 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWOVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 09:21:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 53EF13FBB5;
        Mon, 23 Dec 2019 15:21:06 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=Go0Z7Dm9;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WnGWaXUCLzGK; Mon, 23 Dec 2019 15:21:05 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B9AEA3F9B3;
        Mon, 23 Dec 2019 15:21:04 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id 5B9C81451; Mon, 23 Dec 2019 15:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1577110864; bh=ksOkWQMmX+4q/9NHyXFHGnFxhabHh8Tb5y2rKm1ZcN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Go0Z7Dm9ROW3yNuSBWCeLXEiPRFcRNW+/QV8CMDtJlvpeaB9A8fG4JdjZ1/VhHWzM
         /IiJI6pG3u3NmIW89AQYTuIG+3Yj+ez09GiNu7of5u26+82ypvpWgaIYaWBkILSzjG
         fuglCTbZQ3WKs+gz3YpdXeeoVnHf1iYITeevDVnY=
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [PATCH 5/5] power: avs: qcom-cpr: make cpr_get_opp_hz_for_req() static
Date:   Mon, 23 Dec 2019 15:19:34 +0100
Message-Id: <20191223141934.19837-6-nks@flawful.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191223141934.19837-1-nks@flawful.org>
References: <20191223141934.19837-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/power/avs/qcom-cpr.c:1081:15:
warning: no previous prototype for ‘cpr_get_opp_hz_for_req’

Detected when running make with W=1.

Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 drivers/power/avs/qcom-cpr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index 484dd498f8b9..9247f53550b3 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -1078,8 +1078,8 @@ static unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
 	return fuse_corner;
 }
 
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-				     struct device *cpu_dev)
+static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+					    struct device *cpu_dev)
 {
 	u64 rate = 0;
 	struct device_node *ref_np;
-- 
2.24.1

