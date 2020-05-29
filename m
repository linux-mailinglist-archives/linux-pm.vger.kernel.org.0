Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E51E88C4
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgE2URm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 16:17:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgE2URl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 16:17:41 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MY5s5-1jUUQT0ciz-00YTzf; Fri, 29 May 2020 22:17:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sibi Sankar <sibis@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] opp: avoid uninitialized-variable use
Date:   Fri, 29 May 2020 22:17:16 +0200
Message-Id: <20200529201731.545859-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ebbyoNhyf4OytcmkmtSOnaq+KqQbm0MzVva7AI9uIuA50SxVFIC
 o+GEcZjQkjqYq/JNO5/g9PYUtCKiVAN/wIxB/CXjjw+NmIk2+cWR20vk+7VJD4fjrxTk6yw
 GYKdSKzH1saEevrwEv7BzsPp+exgOubRLWWzyzVVylW8KHYsrMIoEQwk7WjO1efb4ojdLHI
 vTWPMjUJpXDIOsXpncqEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uRFSlx5zQ/Q=:epQs+rTj3ZNEk83FleFRyN
 iEh/bjdRiXJIfN1LCaKIQzA0uAePp8TwdUXct93OycaArlAyBodhP1HW+hTHhGpQVm5Ta+s0a
 jt7dSPGRozk8fKM0V9FEPrbvpDxN0TeS/s7PNn28262v3rYqi2MLMlO3n64q+TdCDGB0S4hA+
 XDRYJ377xWa/xdWTriYIPWd4x8jtCV0nRl25keXHhD99h9CbpR7cHAATnMUkS+LX+rA7TNyJK
 jnfwj709wW7TeZJW0gKPTpl0g6eC7GnM+puA3sYRNyHV0NhbFq4DCPvmXUfZgY9hgkWnBoCBw
 9auI35qIpB/s/N9VNGG7okWtcCKxecb6ACFMZKXK9pH8dltuN+s+qxjs6eTeFfwJWUb8l/HCF
 apKLn1Zcv6JOmBOBvUnNsokiRHXk3m5Y1sOMq3dsAjZJgvVplD3gMk7imv7EUuVd73S5usHUG
 v9tr9ZcnuGPtriTkr4NJB9FxqOdllIIHb22cFnk7YI9c/MmxPcFJqoiNURej+WVLDOP80EW4T
 m0BkRPUvjRAVphdp4GovSJmNcqvhBcd5xOXSbhLu36ORzHl4/4w216zED/EA4QFm07OZ7NrUL
 6asMk1HD1QlTJK3VJD+LVaIXRktqqvzBnFlqyWNyc5lJtzQ3qb1ekIKjZ1f6xnJPQoWmzZL2n
 nvDyRPGaRdWnHRLEkbi/D9pCL/25yUtfSalyS9np6z66OV4wA9ZZeZGntPAutND4xTY2MryTo
 LGnv8CKZY52CNArgV7t1q0JBra9DJI1MTUR+AZftcSFoNrsWPq0c33M2O0XhdNqXKZSkbJ+RY
 ScVRq60D0L4qJCyCS8jwb6Ezskp9wD5KoXDNWyCymXxzxc1Wb0=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

An uninitialized pointer is passed into another function but
ignored there:

drivers/opp/core.c:875:32: error: variable 'opp' is uninitialized when used here [-Werror,-Wuninitialized]
                ret = _set_opp_bw(opp_table, opp, dev, true);
                                             ^~~
drivers/opp/core.c:849:34: note: initialize the variable 'opp' to silence this warning
        struct dev_pm_opp *old_opp, *opp;
                                        ^

gcc no longer warns about this, but it seems it really should,
so change the code to just pass a NULL pointer here.

See-also: 78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")
Fixes: c57afacc9270 ("opp: Remove bandwidth votes when target_freq is zero")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index df12c3804533..7302f2631f8d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -872,7 +872,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			goto put_opp_table;
 		}
 
-		ret = _set_opp_bw(opp_table, opp, dev, true);
+		ret = _set_opp_bw(opp_table, NULL, dev, true);
 		if (ret)
 			return ret;
 
-- 
2.26.2

