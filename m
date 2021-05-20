Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEE1389CC3
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 06:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhETEmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 00:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhETEmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 00:42:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E9C06175F
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 21:41:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e15so1658643plh.1
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 21:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nekcyqt8slKf0il2RVdbXCValEx/1aJ6m5AGD2qejqc=;
        b=S59sn/IdnGlOHJ+pk7c/Vc1FAGzbIRCuqBZ+5tVlRsEKCRucH6zw8WcnFhDqEq8n9E
         Eq8UXNTlgHYX0Y/p7X+nTRard8TUK2d9FatfoOAyPG5NPU22DN2qsWmiSUTcHbaOkYHK
         mm2SZVBezhrdhZkUkva3XHLtM1ZJbV2fS9RYNphViMzxqKt/+lT1sBP1xhxs4ClO9Tt9
         a+VmbWG8m61BDFA/CZDvy7JlUxBBmR81OuqzxmsEf8fQfVuvezuGAMTv4Q8i7NUIoI/u
         6K+AekbwRfLzJya0ld66603RqcDlnWRcmAY/5fO2Xx/FS/jhpZx6f0FKgv2wGM0X9U7u
         IybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nekcyqt8slKf0il2RVdbXCValEx/1aJ6m5AGD2qejqc=;
        b=fEGom6f2bdKyNd3alYhQSL6LJLcDYHw3fO/Fywa1cbHiGMsjOv/XCBNdyi32uJA8Sm
         cY2JMKLKfFJpJFZsa7CqDTmNQwbl8uD9dRJeXSqBWYr8byYW5rH++lUPtNmcqSNT9+2v
         dcRK7+iU+Olr372B0/cZPltu4uE7DeApKPrJ4T27PwqbxL0CRRRUGjzj96hn7OWQ56zC
         XkuSjZhgroyl2d2VrjZjTYxlyq/SGTL3NGV1vrYH2G9Ru0Pc0h9aBEjadjHiH+ztI71F
         kwR45TqsIhwT1uG2lvvFR3YeXbt9fUnKGZMq3uGgaWvqKOG2jkfPvmMyNq3kpxXB9rdg
         GxMw==
X-Gm-Message-State: AOAM533Qn7KFmGmQGKLqeSIH7ZDmjGvvk8HG2Iv1iNzCTw3yn2HouThr
        l0PBkLkg0uaMtTaCgKwdQOok/g==
X-Google-Smtp-Source: ABdhPJzPcQMpepM6NfQu5R+VN+7n4BOFRcVd6kuxVtxCoqphEG4YGKIqou6wpC+PjXEzCPklFrP2zA==
X-Received: by 2002:a17:902:7847:b029:ef:4421:6a2e with SMTP id e7-20020a1709027847b02900ef44216a2emr3564340pln.44.1621485693039;
        Wed, 19 May 2021 21:41:33 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id n11sm842295pff.96.2021.05.19.21.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 21:41:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: dt: Rename black/white-lists
Date:   Thu, 20 May 2021 10:11:28 +0530
Message-Id: <3741541ed1162033394663894de2f8d8554334f1.1621485236.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename them in accordance with the coding guidelines.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 0bb10402f02c..bef7528aecd3 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -15,7 +15,7 @@
  * Machines for which the cpufreq device is *always* created, mostly used for
  * platforms using "operating-points" (V1) property.
  */
-static const struct of_device_id whitelist[] __initconst = {
+static const struct of_device_id allowlist[] __initconst = {
 	{ .compatible = "allwinner,sun4i-a10", },
 	{ .compatible = "allwinner,sun5i-a10s", },
 	{ .compatible = "allwinner,sun5i-a13", },
@@ -100,7 +100,7 @@ static const struct of_device_id whitelist[] __initconst = {
  * Machines for which the cpufreq device is *not* created, mostly used for
  * platforms using "operating-points-v2" property.
  */
-static const struct of_device_id blacklist[] __initconst = {
+static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
 
 	{ .compatible = "arm,vexpress", },
@@ -179,13 +179,13 @@ static int __init cpufreq_dt_platdev_init(void)
 	if (!np)
 		return -ENODEV;
 
-	match = of_match_node(whitelist, np);
+	match = of_match_node(allowlist, np);
 	if (match) {
 		data = match->data;
 		goto create_pdev;
 	}
 
-	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blacklist, np))
+	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np))
 		goto create_pdev;
 
 	of_node_put(np);
-- 
2.31.1.272.g89b43f80a514

