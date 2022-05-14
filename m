Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF552728F
	for <lists+linux-pm@lfdr.de>; Sat, 14 May 2022 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiENPXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 May 2022 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENPXy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 May 2022 11:23:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6932EDB
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 08:23:52 -0700 (PDT)
Received: from [192.168.178.20] ([94.31.90.216]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1N94uf-1nsDnv2XEV-0165Zm; Sat, 14 May 2022 17:23:40 +0200
Message-ID: <4ca23609-11f4-881b-6676-83ac80dff254@dorianrudolph.com>
Date:   Sat, 14 May 2022 17:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Dorian Rudolph <mail@dorianrudolph.com>
Subject: [PATCH] power: supply: core: Fix boundary conditions in interpolation
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2ix1TB6bbyHJUN7IUeW2XXfZHjp3F3MBb6rfrvM5/rY3gylcKe/
 9roCN4mYZhYQDFTvX1RZuarcBJ5bth2UseVTMEZrvBIx1kl1JGoMWsgvdJ+Admfs3ehBFH9
 Pw+6dNwISfEP1YdNrLhgDBotnkQSB3kFZUHy499q4D0UKHlv4w9XAI/bhdMM1NYpUnvnHCk
 zPzAva3PA19Nq4B3u5yjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hRrR6YyKntk=:m+9vLnKmGDqx4zfd5mxmDI
 Rdd8GWeFIC0zDPKtNVNMD5GuUHl/1GHySzZS6czAQvhOAz1GvLuut4IatP2NwKVRW1i36hEgH
 oyfQd+2Uw4LJHYARkEn0wbmrEJdySec3cd5uXE0FLvSIOJACI7uzSeKY5IM6+oILUP/bt0A6r
 vQ/KKyE4p9RrOBkiarB38wrHpK5SrOoDsFtstzQR+62ZHYTTZYkRPuHBx/+r6Fp5q7S8ZiTFV
 ukHmbRPQy3abgBute2LArXl7sceFol6hKQ35kSVTWubhwKbR3AWL96lhk9WI/RxKwnA77Kdjq
 gaylRTBq+BFywyRSn3HdSNjGuolFETsoRRAJUjP0/UnEJ0p9KkmgcqqE9fgc63rUQe8sSIMeN
 rdyzy3rY50R6UE4S6l7gbxha9rnHZ3vG8sZEN/tkFMwJ8mF/pv78FhCxUzSofp0Uz5ifIvMmI
 VCaBWsHB9TggOjlbahMVi6Ge19wow2mBl1bj3J245BG1+vbxZLi1IZwZiVPIYMfTU3rU6xyHm
 jocfSgXXv5ShW9KwDMUq62eT941B5SSBd+fpzkfxGht+u8nfuvzwSFSFM6SKRWBcXtC0aPfkF
 lI/MnRC5LH6qW9/rKM6wkuBAcZQzNUnele1VKmzwIFxl2udF+Z2KaFNXkPapHvFpU+5iNUv1T
 XS0L2cpUV3ldGvpMy0WwUepkFpAIMXc2NDH0Ig4TKwnCOrUFKTTU/U0oRSdTs2NEiRytEB504
 ojZnRYnxPwnOtaDCwJH90c9FC69oCb3nDgf6+lHCWSuTjG19MD2kGhrgz+8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The functions power_supply_temp2resist_simple and power_supply_ocv2cap_simple
handle boundary conditions incorrectly.
The change was introduced in a4585ba2050f460f749bbaf2b67bd56c41e30283
("power: supply: core: Use library interpolation").
There are two issues: First, the lines "high = i - 1" and "high = i" in ocv2cap
have the wrong order compared to temp2resist. As a consequence, ocv2cap
sets high=-1 if ocv>table[0].ocv, which causes an out-of-bounds read.
Second, the logic of temp2resist is also not correct.
Consider the case table[] = {{20, 100}, {10, 80}, {0, 60}}.
For temp=5, we expect a resistance of 70% by interpolation.
However, temp2resist sets high=low=2 and returns 60.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dorian Rudolph <mail@dorianrudolph.com>
---
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ec838c9bcc0a..3828ba9d0eab 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -801,17 +801,17 @@ int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *t
 {
 	int i, high, low;
 
-	/* Break loop at table_len - 1 because that is the highest index */
-	for (i = 0; i < table_len - 1; i++)
+	for (i = 0; i < table_len; i++)
 		if (temp > table[i].temp)
 			break;
 
 	/* The library function will deal with high == low */
-	if ((i == 0) || (i == (table_len - 1)))
-		high = i;
+	if (i == 0)
+		high = low = i;
+	else if (i == table_len)
+		high = low = i - 1;
 	else
-		high = i - 1;
-	low = i;
+		high = (low = i) - 1;
 
 	return fixp_linear_interpolate(table[low].temp,
 				       table[low].resistance,
@@ -838,17 +838,17 @@ int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
 {
 	int i, high, low;
 
-	/* Break loop at table_len - 1 because that is the highest index */
-	for (i = 0; i < table_len - 1; i++)
+	for (i = 0; i < table_len; i++)
 		if (ocv > table[i].ocv)
 			break;
 
 	/* The library function will deal with high == low */
-	if ((i == 0) || (i == (table_len - 1)))
-		high = i - 1;
+	if (i == 0)
+		high = low = i;
+	else if (i == table_len)
+		high = low = i - 1;
 	else
-		high = i; /* i.e. i == 0 */
-	low = i;
+		high = (low = i) - 1;
 
 	return fixp_linear_interpolate(table[low].ocv,
 				       table[low].capacity,
-- 
2.36.0
