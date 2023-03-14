Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E76BA2C6
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 23:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCNWzo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 18:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjCNWzn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 18:55:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278F39287;
        Tue, 14 Mar 2023 15:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29F6CB81BFC;
        Tue, 14 Mar 2023 22:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E536C4339B;
        Tue, 14 Mar 2023 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678834539;
        bh=35QN0bzeY/9nc3m2KusNIkEd3B6r2Kv+UZyBrvNelB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDwGM+G/X24ezRvdHhqJ7xrox/Qhgn526cw5U7Goc9Qjik18wDD96rSQm6LmeEx/O
         MctH8dMy3Kpa3CNI60F4HUtitObF97gKouMRPSBs9av5Hcjg0h1VEZeAphJughprS+
         8pRbOe8URkN7RGrJCJwl4I5Yx9z5ITFcwPmx1s3fXPU35i7v2ms96KDCb0B1yXNYTx
         mIwAhT75MxcrUuG/z67kFrBnbOaZCZmqCmgFi5RcV39+mc6IikyclukC4tM8xvCijN
         J1YZ01OC7ITgSFKs32fm8wlSLMe4xB+EnpD5FkqaicBxwZHpI3+W5YH2N4ai25fW3G
         0jAzT3JKRWhQg==
Received: by mercury (Postfix, from userid 1000)
        id D8EB110620A5; Tue, 14 Mar 2023 23:55:36 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv2 04/12] power: supply: generic-adc-battery: fix unit scaling
Date:   Tue, 14 Mar 2023 23:55:27 +0100
Message-Id: <20230314225535.1321736-5-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314225535.1321736-1-sre@kernel.org>
References: <20230314225535.1321736-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

power-supply properties are reported in µV, µA and µW.
The IIO API provides mV, mA, mW, so the values need to
be multiplied by 1000.

Fixes: e60fea794e6e ("power: battery: Generic battery driver using IIO")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 917bd2a6cc52..535972a332b3 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -136,6 +136,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 			result);
 	if (ret < 0)
 		pr_err("read channel error\n");
+	else
+		*result *= 1000;
+
 	return ret;
 }
 
-- 
2.39.2

