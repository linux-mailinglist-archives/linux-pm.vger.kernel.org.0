Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03DD4265FF
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJHIgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 04:36:19 -0400
Received: from sonic310-57.consmr.mail.ir2.yahoo.com ([77.238.177.30]:43810
        "EHLO sonic310-57.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhJHIgS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Oct 2021 04:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1633682062; bh=BCd3Lyhi9nz8WKEHyoHKp/1s3/i0XMMiqJGFJaxEjbU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=iypJUNHKZOXj2OGBtoXXCGX3AHY0i8Mby789Ig3F7zg4Or3HD0s0lnLaRp3xtW15nv/ed41yr5Ic29MaVr0CS1w3yxfOiA9VXPHRd7SSieKphBmH+Gzvfp2jki+Vcjoi4C3LdjgLiT1+Uf8LTM/OkyCkk20FvmnhLET+aEd1PwQYz3MAvtvicsPD2RlnoVgWyg0QHp5LOWJaoWIBovK2s/g24QoM/0Mb5fdRgvhnP4tk/YzGxOZ5ureYqcODImvK91vdexGBdgh14BWezLMVnKf4XESl5dvIiKJSizROzkFLkcnzw9ENyPOHDbsvgFuSfrRt0T4kx9+Ga18oqGriuA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633682062; bh=PHl9uFurtdMX5KTHfoFdkf2+EhPaFyGOi9hjz7L2Uym=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fP0+LvdaWO0ntjXUEsWf4nYagm8+yd1gGLIErylkZazzVWkKwCHkSEHGG3FSUo8xVYGK5kEhaLfecEZo7wxpOIten/23l1yWKqz+l6lM39JlK/sfdafmXTy/b28+rIgwO9wtkkCTaDdKIfm/yvuII9xdChmwKla6CvlzVcT5QahFCBi+rE6PkKXsUBnshpIxLgNthKYjkeXcXcFkmdoSqoMXfz7HUc2wwub2Jr0rbcKb+/1W8hkO6VJO+Scm4oFVpqnVZpOyhAYaYBWXeQ92PsY3CHVp72HauToXKNttaSevDy8KU00mwDynOppBKwS2EzYiE53KPwcXATANqPUgmQ==
X-YMail-OSG: HqUTsXYVM1nfSU.YwDc0mifVz_T6y68dcr2ylZyNwvdsgU.MhmWWcey4oXZSfRk
 DPFVFiAc5Pc7J0iN4Oc4HGMW7mxKMFAmvMbtp0vWCgQfNmaj_JRrcGz1zIOOcJc_BWFqwcQioDOy
 RBAW37_eKxktRP52bBvV3Ycek3xxBNaHf4Fw.6cMgWwoKLHJ5aK2PFABNcEL2NchLHiDUtlFIIrz
 x_ZV0n5Q_sSAhkFUBZZ.H2nbV1Br_BVqvvb6AQf0kOaGF7x9OBLu3_V.LtAh8OQVh.i2fvYmVGea
 cGjSeftzWtS7XPf7KLTgvO4v64zK3hgPfmTUt0xVq8dbLXddpbI5yVQEwagNf60kbhVDvo5n9I4w
 I_vOWV1qKmBF5nsqXph6zioSuxgXWSjDHMp5vK_njy.hVsS4YowCQd9y86Y3GctfzbMY0LfXS7ZT
 0qw3KE08mCHysDY8AemLhg0geaXnuIh6sosCNl7sNwLKBsgnhApuzxAZSdsj8E60ZUxO8fwbuKYJ
 maq03EK6_rVaXel6M8ODoKcD6MxgsUK9LwXf.mQuUyIIqY50ekgRxwqA2u7NmsoZy2v_y1HScrIY
 pAmRqTbLsTmwwMSoIPPDRATSDg8vEU6lEN5JlfsGNBZUT5FnLb0mvBDZSVTAY8f28h0xYxFgp_Rw
 C8i3OYdYA7AB5PCC8NicUr2YkHHjlicyK7OyCeekBRYxAwjBGv_EhPySZzpCg9REbF8todNIfAKG
 _ypLxUczZZjJ6L0xQKM5ZHa9QcGtryMFEJs22xlE1Fs2e7_Py5_UhNtuzQi9ifMNX6ZGEux4B2A1
 8HaUi.FHfk7IFon3c.gKafEstkVPe5KAk94mPBPbnLKcXNlbAFUUQsmgAlE0lEsT39BbYXQsxxih
 lKUNVYRz7Txnwz0Cc45GFjnW3LMx_PKkhT42_NyCUlKsB942ZPzv13pJLBU5FKO1iKa_6IXDzGvz
 VxZeVLZFYmYZjcHXca5YhAPfW7i6nSyW13d1wzDBroCyKXYsorckEIwSboTpSpQsxVwUV0pFFgV3
 YbxDMqiOgjGuQCN_ZxKLPhmfyIwpEpybJy6vvrk0ZGRfTDYwKwZ5njGZJtbEK2tD_xB6uuNOwSbK
 RSgqAZBxkQQQSKEbVSp5NkZtfmqUs29y3J1ZuT7ORw.pfdgeYDVqjp1yNLFVn0RytW5k7_mqxTCd
 WL.VSLMNtoIfPvBFydtLWzA_LucSUevmMmCoMzBmnwto59KGu8EcdIvzieB_O6Pm0wYUkskB9cla
 BCGfP9UmMyeiJjtMbn3c4PQGBtyCYgUklDBQ..AyG9VCqKJwKYmTG51JB7Abe1LRudawgLtrbBMo
 yHrsINiLZ0TPCmdzrM1uR5Kqov5YoePBGk1ltm_mgDjcseTjtbmzR.7UYwpx7qCRrPczkTwC7bOV
 DF_IiLNXFygF37kxxn_j.Y9F9l9MSEUhHmMwobwcO5OH7oPERJYSzzYmJx.Qufi1TOWJChrw.Mub
 YSoLQnoXpxVVYtVqVuJ4kGRVs_AjGUvAOCbRdod_FS0H9dD4FvKQ5MzJvshKOBqHQJc2JKOXhjlU
 ZEHON69C.53NE_aHfVpNK6n51CsZR6ky.1OfiLqom6yamegeYSQJIGfvXbf6aeb2BBbTerb1VKew
 6oDQ27GBJkggK2fAevRNKDVDJtDCCmyjRro8l4anzCtm8vTH4Yg.VpVLyE9scxwgHkD57IpN_D9P
 xO01ZQv.8b1zfHvfD9IKhRfiY34M8KPaaf9Srhs32j_pht.E3tCCsOoYZ4gBFllzkppgAcf5pdjf
 KJBJYuZE5tW.m5UuGNcdSkMFqDV59BVx62AhXB4u6LaCxq0QqOCJLHa2ha7WZdBc4xUSQSs6H07l
 BGS3TAZkGdpH6CNEdVrM.eGB328k519g3IhnD.JwBU2JuKIe22fwW8WW9ISscK_CcGKFL_hz7iyu
 NBnWW4GRQVPpP64ekbN5YR1tq4sqG32vPNgPvEq4dyPwd6a3rp5bFjXELCheH_1OdHca36p45qrU
 fcp1iw.vdW_t82Tw_Zy1.rl.5Isqt.NmJ9_Cz_xQedXbnUPnqp82k.VP_530RcRXPiFczCZa9a4R
 xqN5oBPs8S5tHlI1GyzP2xo.I6nmPxp5lkkEoYBWx84_PylPQqfuWS7klBwu3a.NyCY0Ws2k5jXj
 h.QIy64R2XDndW0SzLejP_btP4pT62rCazhb5E39rj7kK9iin71XZvKpNTchY.2h1jwZgQNea8o6
 qcxhdPFssxhSEQissDyP8X13myA6ShecddKZfK21D2JbNkcGqGu1Ymfrj1vlm1gBSPPKXjNrftPB
 o1.m6jaUTNKI_vGc-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 8 Oct 2021 08:34:22 +0000
Received: by kubenode505.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 88d24ee1868ddca6937b5b04335a75fe;
          Fri, 08 Oct 2021 08:34:21 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH] =?UTF-8?q?power:=20supply:=20rt5033=5Fbattery:=20Change?= =?UTF-8?q?=20voltage=20values=20to=20=C2=B5V?=
Date:   Fri,  8 Oct 2021 10:32:45 +0200
Message-Id: <20211008083245.2884-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20211008083245.2884-1-jahau.ref@rocketmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the rt5033_battery driver provides voltage values in mV. It
should be µV as stated in Documentation/power/power_supply_class.rst.

Fixes: b847dd96e659 ("power: rt5033_battery: Add RT5033 Fuel gauge device driver")
Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
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

