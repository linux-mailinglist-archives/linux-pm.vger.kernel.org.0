Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5C6DB070
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjDGQSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjDGQSe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 12:18:34 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A36BB8E
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 09:18:33 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-18412684c50so1998085fac.5
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680884312; x=1683476312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf5CfE+SYAzVMi9NiuZgvXY9kKuTcDv8Naw6AmY70cM=;
        b=iuvpokBX8LD9oYBTJCd0XNJaHi0+4+yzoT8SodXRW8ERmB3TFybbEVqQYyRSOl2yE5
         JQUMxxHabWJerXXoDDx0bv3MrafLF7RsyvZe3r2OAVUA9seGazRoIfqMpzTf4K/nAeda
         zM882Cypw9sVQ0zrYxKqQRgnsHW02sLZKYRslSPnkeQfQRpS6FyK+xxVOTEPl98bvS0K
         4HsjR864WUUA0sM5SXHahk+5CI0GW+ON8sk1crX6DYEBiCEbqs9KjMkQb0erdkTTpk7z
         koGHIpoyMdgdp96v1fRjHU523DsSEAJ9dp1yHwGEtwKz2SJpT6oHIQ7PSu7/4SdjzaGq
         OX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884312; x=1683476312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xf5CfE+SYAzVMi9NiuZgvXY9kKuTcDv8Naw6AmY70cM=;
        b=zrDhOdhmKUsZ24Iz7zZoIvT1txh3X7K2vJbW4JkWWM6Aa/wOsLNqRSjRis4apq4M8p
         7cM3t1PXecwcCH3F/JvS+R1KWq5CAv28eEzz16NaUfg9qKL35FKtRGUKSQiXts1doX6z
         M6jFFBg8ALKdHPju6m1ECsoyzLDGIuCNV8RIMi5dWMBgo2Dz48RvOyUlgrNalTrltZyu
         VzxtxG41WyCtu1Xbt60sNdeQE7+AlsiL3IxrmdA9BW2sHU8bRJiEsmgSfDCyxBC6fC1J
         8w6479jNcahCJKz9IMjNHfV3odfcd67G1ci7ksRIImX/6mREvOIf5gaCRwyDEHMGRpRI
         +vrw==
X-Gm-Message-State: AAQBX9dFOU2j8DZthJnwdbzo7Yy3aKN/13EWhRpeoIHs0V0BFTvI+YL6
        E7yY/AJympn4gaGdXEVMAoLLPYb0XbU=
X-Google-Smtp-Source: AKy350ZpE4pGcrfQtH1K51srnkOgAEMfZYYTKi+L4/c0kQUpGkm3dIaLL7lesjwM4HpcV7lpHN9NsA==
X-Received: by 2002:a05:6871:106:b0:17e:6eaa:9452 with SMTP id y6-20020a056871010600b0017e6eaa9452mr1302597oab.13.1680884312671;
        Fri, 07 Apr 2023 09:18:32 -0700 (PDT)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id zj18-20020a0568716c9200b00183f77dcdadsm1369212oab.33.2023.04.07.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:18:32 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     maccraft123mc@gmail.com, lee@kernel.org,
        jiapeng.chong@linux.alibaba.com, sre@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2] power: supply: Remove unneeded code in rk817_charger
Date:   Fri,  7 Apr 2023 11:18:26 -0500
Message-Id: <20230407161827.127473-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407161827.127473-1-macroalpha82@gmail.com>
References: <20230407161827.127473-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Some code was left over from debugging the driver while it was in
development. Please remove this code as it's not needed.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 36f807b5ec44..eba9a17d991b 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -816,19 +816,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		}
 	}
 
-	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_PWRON_VOL_H,
-			 bulk_reg, 2);
-	tmp = get_unaligned_be16(bulk_reg);
-	boot_voltage = (charger->voltage_k * tmp) + 1000 * charger->voltage_b;
-	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
-			 bulk_reg, 4);
-	tmp = get_unaligned_be32(bulk_reg);
-	boot_charge_mah = ADC_TO_CHARGE_UAH(tmp, charger->res_div) / 1000;
-	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_OCV_VOL_H,
-			 bulk_reg, 2);
-	tmp = get_unaligned_be16(bulk_reg);
-	boot_voltage = (charger->voltage_k * tmp) + 1000 * charger->voltage_b;
-
 	/*
 	 * Now we have our full charge capacity and soc, init the columb
 	 * counter.
-- 
2.34.1

