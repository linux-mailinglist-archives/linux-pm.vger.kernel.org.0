Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC17426659
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhJHJNW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 05:13:22 -0400
Received: from sonic310-57.consmr.mail.ir2.yahoo.com ([77.238.177.30]:44165
        "EHLO sonic310-57.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhJHJNV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Oct 2021 05:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1633684286; bh=j/C/7EcWI4/xBTeDjvQxRyW1xFKFia5pRimR/ZbRAoA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=dcKEorEFo6vieBSs/ZYJ35WNCPRgQ5AtYcBEonnQZQQSSWyXooge1t7Wp8KvM2LX5fhPrjrvh0cCNkHnoOHU6lUQ+ghTq7zu3b4CDtLNd8od7tUnxlUzo0IAqM9DQ0bsgO397WiMVOe2BVUkmhVsLczonyEHtlfC1VOUnm01on44/oHIlQfG3HNh2uYjt7kvhIit19ydQzk4lXhbSSgbITdcewLTJL7+d/f1FxVpDLU4K9FpUx1+dVAQysDgj4TYXcDTHXdHdD7cARUaS2ZLIBJGMfuw4NZG1PBBFAEd+2WrdToc1MqO2CND32pkaeqiaL8rm9ge5GGMBTMj3IupSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633684286; bh=+MH+BZEc/GPJYRqWr4oRwSN3IuXWKqBLtevDzdq6jM0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UcVH8VSol5IKlK2m3Or6IU1kXslYYJloWEdnTu4KzkxQCyJjWxKhkq++Cg+qN5v875wImALd/rSb1SewhHlvSwoAagS9nYqAULou+tE/IYwHHpThKxwRU7VzYV/7lyIHkxOgvN8ljbAGxLHukeAp71jeM3E/jf/exOMRvhkpDzUp1KIsu3P7i115kvouSgzKGbLIvGlwystSOqeK7IztJA7kmCYOtzI5vU6Z9iLBPXVN1nxqmJ3+TqZZswrFwjE8uGfvpO747pM7TpHouybWWxIjhZedNhEfitcwOTHh/ATJQDnw05TcoIJQIvy6lIJpxjhcxWS1/RB0cdq5Qv1Tpw==
X-YMail-OSG: IcQvx0MVM1lAzujugsPaSUCNocCu.5CfBoJ_Q_eMFDPwGb31ZJcF9ZzX3Wnqfhr
 Gkv.tucEPYHzkRa1V4geIc6G5u8vZ6rATlWP4unLeNh37GAEidm1jn8Nxx3rGmXGFcgXYrL3jDNW
 iHbav1tJ81rVtH1eG3ln.9.m0nuFvaAFeWUBk.8TK93GJ1x8r0jv1iYZeC5wL8yyiICMHWnsaP7i
 hz.SwnVRABfKaNti34T0W9hVQc5LVVXSzERXms1H5We5f9_rAY0grKIkssalFo6yWjl5TzDNgdQ7
 tXTDMq7Jo1tUSjJtxgNKd6149qSaGeGRF0Ey2KCg1.WdKUUQenoCqthufq.Uy1jGt86vB71ujFF9
 5CVlXlG9G7kaRjcLeOijUJjDmuYqEd5gVVFumo0rDKWi8kh4xOPWPH2ZAWlAvfPSNbquoaBHaBtA
 hWkrppKIHVv0j9NC26I6YQ.3SIevzr0jAUeWQ7RHCDjOMl4fi5g0ZDHBuQRwgkTwuUFBCKVyyoCJ
 QIobecNTym5q9tYliWuhGQqOeHQbxsFXdEBWCXFaXnWm9DdH6a_1D123NJmlfLdt55Ewc5m5g8S8
 5ZcNhmk.U17.V7U4re5EYIJwOSy0dUFQCCvxr6Y8MRgo6qQekIu9ts8aNJet.kahw2YvZE6x.QBx
 kL.oc01Fgt_prGPgE6IbIlmJiQsez.7p7jytzF2qquoJ35RI_SFGe_v8w4pVN4TzWe3TTLz9LuLN
 _zmmb.znp63yIV1nvdf8QSupdsYybUgVvuVd0a2hA_qG1OJBxzAZY3pCSWw52ytwWQq.xzB0ruMj
 zKqjlVgyeva1SpzTIfsaUh29.x2cZv.EHV_ADRRQCQt8DA36aAdZ1P3rOEpoJE0F0t5h4rDW5ADV
 UP3WFvOSkU.p3oQfV.xY4YLl37jXTV1_GgK5RLDToLWjvUjI.buaZAFLHHlI59Y6uMWWClJ8SSn_
 9lKnBtMwzS4T2COvydLE27uEBoqlVAHCHVx7O.2TDCHgPmJbdRtUhdT3GNaFKTkCbsLkxqeuQ7TG
 GQCvLo2UIk_bL6cwyPgRpxj0jViD6_Pfk.qG8lSn9tUOYw7ZR5bbHYD2bzc76p2GzUUdkYTEayoa
 mQW39cDgyViXFMrLw2sbYW1sQn9hQQgE1Q9ZUKZJvs1yjyh0bvV9mjwHCErF.d0KO6rRO3OHdg.C
 H7FA2_qSAPGLs7LHoJMQ3aoPGpWIgwTPy13UozWawyrjE3JTp4o8wJyYk_M8nf9BNsf9jEZog4Ko
 dRkaP_l3LfR6ihibS.Jp2VWqPddxDbSukYQMD0f.m9v70PCc1WQI7hyS532JiEZxghVNmTpxJP.B
 ZVKkQXqKmviIpCPTQo4XZXWGZBonNGPtDPkJdLPpVVpPUjHbJyLXzZ5yuKb2hZFeRMC39GJKI3RZ
 lt99mXHRdIx7eZv.1Zkwd7JiAtOyEH_xBOJ1mrZSyWqk1LwQ60TJ7sDm6qtj8XIJdS1M9ExwPSAo
 GZDN8R948WNE0VWVdLJqFd0JlNYEy9_z2tGCNYUWbe3DQHxmxSnXgojNDhrOBEfEZt05nJoafjnq
 r_rivU7tHggbcu5wTGAWwIbTT7mqVWgVhpQZx60OFZof3msXWaT7LySB552BiQe9iiwmfQ6ZUHOR
 xxoiYQvRbL09csXiypQdkdPZAMrbgG8Oir3Nl.rQ1GigO0qy8dwPWGCTjBHZeqS5niRDSvInQsAN
 bDIPEOU3sryY.I3_Gno4230Unj26CbvGCDx5h0f_sAS7HatdFpxrN2lD6Ojn0xGSvTq34zwwTSST
 vY4RQinWtBZE03S6nwn5TENvInqjNUKmlMWawTsiwl6eqQvdRhlRbxQCWctVgNgMSpsLO8XhesOb
 lbe0e_ZXtBEioUo6Uf_dsI3SsfycSltMdBvXIh0kZWrncptJNGwmQS.Alf3AJD7.NoI0knd9QCl6
 2hznEQOv.egTlgUVUu4k4DhLDKAvtu17r3AehPdV6sinVcplPq6Z.nwCE3XLH6iYPaOk2kOdL0Gv
 OdQZzANAjGJdimnyjGt9IICq_OUQ8nWPCP5XgGtUlJsno2Ulra4EReZLeUCRAM9cjKkwXnIIaClH
 BM.f1Z0CAHpHCXCWP.JQmxyctCtUe.6nTiCIMjtNmRBBXkIR7m4L_unH4YTgv8qol22wdcqH5iMG
 Dmah3F5Y3Yd6JlBFeFUEoF3jD4NjN8W5nHWJoLG1V0_x3.SKKcF1iXXVBTiRS_Vlb0rf8vnLUgFB
 K0jm_p2ohj9Zm.2th9LG7Jfq.3P.jTQ7brMLUjB7jhlueLZvOhRZFMBMGibWw2uFx6UrKBuSupO4
 xlwm7dsBKGAepZiht
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 8 Oct 2021 09:11:26 +0000
Received: by kubenode508.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 43536220324474b9ed9f3288f91e3cfb;
          Fri, 08 Oct 2021 09:11:25 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [RESEND PATCH] power: supply: rt5033_battery: Change voltage values to uV
Date:   Fri,  8 Oct 2021 11:05:43 +0200
Message-Id: <20211008090542.3893-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20211008090542.3893-1-jahau.ref@rocketmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the rt5033_battery driver provides voltage values in mV. It
should be uV as stated in Documentation/power/power_supply_class.rst.

Fixes: b847dd96e659 ("power: rt5033_battery: Add RT5033 Fuel gauge device driver")
Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
Replaced special character greek my by u because of encoding issues in e-mail.

 drivers/power/supply/rt5033_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 9ad0afe83d1b..7a23c70f4879 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -60,7 +60,7 @@ static int rt5033_battery_get_watt_prop(struct i2c_client *client,
 	regmap_read(battery->regmap, regh, &msb);
 	regmap_read(battery->regmap, regl, &lsb);
 
-	ret = ((msb << 4) + (lsb >> 4)) * 1250 / 1000;
+	ret = ((msb << 4) + (lsb >> 4)) * 1250;
 
 	return ret;
 }
-- 
2.33.0
