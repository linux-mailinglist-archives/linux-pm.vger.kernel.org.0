Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FC4CEDFC
	for <lists+linux-pm@lfdr.de>; Sun,  6 Mar 2022 22:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiCFVrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Mar 2022 16:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiCFVrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Mar 2022 16:47:40 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8B15D1A7
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 13:46:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id r13so28125712ejd.5
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=j2HAd5vG/i/ouM4XIEwzIiYA/NK3wrDE41rnqHrxjdQ=;
        b=kucJw3HISYob347tQBy1lXUyG/5XX//ixQP3L4mSedKq6NzENprO7hhhGr8uFDHjxF
         ILXSchFAY/Xbwo4BLJzRlq8Dw55FgUjIjI7X4vt7TM9Hosrl0GnO1QdBTRnc2FENzIxu
         nhejmjPsMju95mNv8xlzwCaKEUEOhm5oqWuzTrf4TYSh97Tas5NoOE+jeewQmHhAW9fK
         xvyuzeNCOVRM6RazIDNKDGFzu5YYZVnc6fxcIk76MBiL/ZGq3KZuowuAi8Ulz2InbfYX
         D5TyswLgHTlCHnBIG2llLKOqaqCPmE5CSODyqSmcH7Sb+hRgwXWOPmofoWJkgeRu0/mP
         gDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=j2HAd5vG/i/ouM4XIEwzIiYA/NK3wrDE41rnqHrxjdQ=;
        b=uRH9xiJ/L7nQV+Pb875d8Qs4AH4E0ABIqE6J6peXs4eRCZCwxcbOaaCXJCPj0dryhD
         S8n2kpV3Y7pG6Xv9WxphtlYqvPlNheBS73QHBBx0TT0xyvZ62f2XMvrlpymmKIBO1Rl7
         GUaEN8RvFN84CxGOjeyvNHpvLR5gGHBVv/fHwYug0buRCbImkLd+IeWOKsJqHUJsY5wx
         8fJcCqaiMWVPmbtuGK3gx1qcTaIgMsUlDYAosVslsOjbP/ygl0CqpjJK9dI7GQd6CQwg
         YtDlrCqiGYBGLUMDykDUtavDoUQKBA73pEB1sza3U6nozuRxB5fSiv21Z8DmqY37mI60
         qcPQ==
X-Gm-Message-State: AOAM531rTQQWBwFAgbHb8QxEVa96Utt21jrQkQRQZBx0b5r67H7GWRYL
        fgS8zFe2nXjnuffFboeLJTY=
X-Google-Smtp-Source: ABdhPJwH+Z0GMURzNFEqMOtZ1LaEw6dYjb4slowJkb+CMImwz0Boc08i9VHLxxC0eICLlS6Sa50BjQ==
X-Received: by 2002:a17:907:7e90:b0:6da:49e4:c7be with SMTP id qb16-20020a1709077e9000b006da49e4c7bemr6890677ejc.493.1646603205824;
        Sun, 06 Mar 2022 13:46:45 -0800 (PST)
Received: from ?IPV6:2a01:c22:7720:f200:e6:1827:dd9f:3c0c? (dynamic-2a01-0c22-7720-f200-00e6-1827-dd9f-3c0c.c22.pool.telefonica.de. [2a01:c22:7720:f200:e6:1827:dd9f:3c0c])
        by smtp.googlemail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm3627979edx.58.2022.03.06.13.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 13:46:45 -0800 (PST)
Message-ID: <91e37a12-b393-8ae9-996b-6cbb63ea9255@gmail.com>
Date:   Sun, 6 Mar 2022 22:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] opp: Don't print error message if getting optional regulator
 fails
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The regulators are optional, therefore I see no need to bother users
with an error level message if -ENODEV is returned.

Inspiration was the following error on my system:
lima d00c0000.gpu: dev_pm_opp_set_regulators: no regulator (mali) found: -19

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/opp/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 740407252..8af5979cc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2020,7 +2020,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 		reg = regulator_get_optional(dev, names[i]);
 		if (IS_ERR(reg)) {
 			ret = PTR_ERR(reg);
-			if (ret != -EPROBE_DEFER)
+			if (ret == -ENODEV)
+				dev_info(dev, "%s: no regulator (%s) found\n",
+					 __func__, names[i]);
+			else if (ret != -EPROBE_DEFER)
 				dev_err(dev, "%s: no regulator (%s) found: %d\n",
 					__func__, names[i], ret);
 			goto free_regulators;
-- 
2.35.1

