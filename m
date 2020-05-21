Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8031DCCDB
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgEUM26 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 08:28:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57951 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgEUM26 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 08:28:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200521122856euoutp0277aa3563b699b829d48887087b965fea~RCuhoewmU0377303773euoutp021
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 12:28:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200521122856euoutp0277aa3563b699b829d48887087b965fea~RCuhoewmU0377303773euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590064136;
        bh=QRNTjhidHU9c61aZQR469tlN0NU7e/1LVLkXIqdFPz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaOOYRP+Hc2xS4bo1vGst62O3ZncqijEKA+n5XaeC7b25B5oER/foDK7gUENszboa
         xn4U1vxu92B0Xz1v/Hs+I1s/2qevC7cV+ENZ3UdC35MP/vOKyf3uhcPLmSM1NTUsP/
         7VzWH0oVD1QT85SXIwgpBXpUIY4XOGqilVb7UzUI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200521122856eucas1p2c876ff8e8f4abf8bb8cd57c30b8adab7~RCuhIj5K-2589225892eucas1p2l;
        Thu, 21 May 2020 12:28:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8D.E3.61286.80476CE5; Thu, 21
        May 2020 13:28:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200521122855eucas1p2b8dec2202f9913c80d93aa01842ea83f~RCug2ymOr2553325533eucas1p2n;
        Thu, 21 May 2020 12:28:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200521122855eusmtrp162da15abce02538d7853c0cc90ff84ca~RCug2LT4S2920829208eusmtrp1d;
        Thu, 21 May 2020 12:28:55 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-c4-5ec67408bcb6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.8F.08375.70476CE5; Thu, 21
        May 2020 13:28:55 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200521122855eusmtip2126c1e50b9d4023bf612017538bdc190~RCugZRkp81167511675eusmtip2j;
        Thu, 21 May 2020 12:28:55 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org
Cc:     a.swigon@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v5 2/3] interconnect: Relax requirement in
 of_icc_get_from_provider()
Date:   Thu, 21 May 2020 14:28:40 +0200
Message-Id: <20200521122841.8867-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521122841.8867-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7ocJcfiDNo3cVncn9fKaLFxxnpW
        i+tfnrNaTN+7ic3i/PkN7BaXd81hs/jce4TRYsb5fUwWa4/cZbc4/Kad1YHLY9OqTjaPO9f2
        sHn0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxvGXE9gLWrkqFi06xN7AeICji5GTQ0LARGLX
        4pdMXYxcHEICKxglzvY0MYEkhAS+MEqsXK8AkfjMKLHs4012mI73F58zQySWM0p86XjECuEA
        dSxqbGABqWITMJToPdrHCGKLCMhI7GmaBFbELNDEJHFz8QawImGBcIlLDd/AbBYBVYlnneeA
        dnNw8ApYScx/VQqxTV5i9YYDzCA2p4C1xLZjU8DO4xUQlDg58wlYKzNQTfPW2WAXSQjsYpc4
        8/M2I0Szi8Sev5vZIGxhiVfHt0C9ICNxenIPC0RDM6NEz+7b7BDOBEaJ+8cXQHVbS9w594sN
        5CJmAU2J9bv0IcKOEiealjOChCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGoVid+rpjNB2FIS
        3U/+s0DYHhIH2/vZJjAqzkLyziwk78xC2LuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+
        7iZGYAI6/e/4px2MXy8lHWIU4GBU4uF9kHwsTog1say4MvcQowQHs5II70L+o3FCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MJoFZM+42JP6RGBp+N7f
        X+Wi2g5PNrs30dykIsjD422NyOu3WZ57BfM2pD2+f0HDkeFpSP8u40WHbvxt2B9+o57PzFt7
        N99F8+R2/vJbaY69Vf4HvG+wbTaZt+4Uo/PPAvOsLUItCttZ5B+8WSaaFS3hc3Xx6VYfy9py
        6bMOqpHHbrlIKr3wVmIpzkg01GIuKk4EAPT2ie88AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7rsJcfiDJY+NbG4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x+E07qwOXx6ZVnWwed67t
        YfPo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jOMvJ7AXtHJVLFp0iL2B8QBHFyMnh4SAicT7i8+Zuxi5OIQEljJKLD61l6mL
        kQMoISUxv0UJokZY4s+1LjaImk+MEoc/HWUFSbAJGEr0Hu1jBLFFBGQk9jRNYgUpYhboYZI4
        83kBO8ggYYFQibmbq0FqWARUJZ51ngObzytgJTH/VSnEfHmJ1RsOMIPYnALWEtuOTWECsYWA
        Si4+OMAOYvMKCEqcnPmEBaSVWUBdYv08IZAwM1Br89bZzBMYBWchqZqFUDULSdUCRuZVjCKp
        pcW56bnFhnrFibnFpXnpesn5uZsYgRG17djPzTsYL20MPsQowMGoxMP7IPlYnBBrYllxZe4h
        RgkOZiUR3oX8R+OEeFMSK6tSi/Lji0pzUosPMZoCfTaRWUo0OR8Y7Xkl8YamhuYWlobmxubG
        ZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhhDFfVPi2yeuu3f0l+17BGLjj1dwbHlfomg
        8O4yBz2Xyz27i6eJ313ktd9nzZvalKoo7xyr+56/1ZuY845Ztqz76Jdrxbj2utaxec0yAeUW
        TB1BKxZsKmPflGBUvr0k2P6Xhu2LM1vYZx7cbqZybdvG9NrJb4Pt2tYJXjl19O/c9tzl33ex
        pZsosRRnJBpqMRcVJwIAVy8Mo74CAAA=
X-CMS-MailID: 20200521122855eucas1p2b8dec2202f9913c80d93aa01842ea83f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200521122855eucas1p2b8dec2202f9913c80d93aa01842ea83f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200521122855eucas1p2b8dec2202f9913c80d93aa01842ea83f
References: <20200521122841.8867-1-s.nawrocki@samsung.com>
        <CGME20200521122855eucas1p2b8dec2202f9913c80d93aa01842ea83f@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch relaxes the condition in of_icc_get_from_provider() so that
it is no longer required to set '#interconnect-cells' to <1> in the DT,
and therefore it is not required to supply dummy node IDs in the
'interconnects' property when node IDs are dynamically generated rather
than hardcoded (statically allocated).

In case of the devfreq driver for exynos-bus, node IDs are dynamically
allocated and '#interconnect-cells' is always zero.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1b51e0c..6a342ef 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -339,7 +339,7 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
 
-	if (!spec || spec->args_count != 1)
+	if (!spec)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
-- 
2.7.4

