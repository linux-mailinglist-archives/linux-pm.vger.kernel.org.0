Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014A76938CE
	for <lists+linux-pm@lfdr.de>; Sun, 12 Feb 2023 17:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBLQiT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Feb 2023 11:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLQiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Feb 2023 11:38:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8881BBBF
        for <linux-pm@vger.kernel.org>; Sun, 12 Feb 2023 08:38:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso9671803wms.5
        for <linux-pm@vger.kernel.org>; Sun, 12 Feb 2023 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CovMs7SBq/jqXM9Nd2Clx74pYW1wU5BsOqE31/XqGIo=;
        b=mKoZa0mMAsRzkjM+EwBOWs82qqu9BHrtnbdKWsIF+8utWPpmZUJzTSpwwODfKm5kX4
         x7lOyPNhKjfIxDYbQpQImL/D1PzvxggwoLvfjfnkaT5hFqRLDOkXoQY30a15+YCdkxbY
         yIt8KYoERm3a4dR2+1ZAXMM4LTqGe0jp8DMk6sx7hcgaAGvL3jP4kx/CNVAzPstxPkM6
         niwTErxjYkEObIB+ztcw/ShMklF8jL33XbJGSmhTd6sQmC1ABkn7N56Mc6PL2DLXhCdv
         Kov/V9VRoBBEWwLmWnBzt/fz0rhvau9aGZyyTRDktMS3oyjl1J8c6dFmOow9DMYHvSb7
         H4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CovMs7SBq/jqXM9Nd2Clx74pYW1wU5BsOqE31/XqGIo=;
        b=eSprxaeZqT1s7EaXTmg83WhE47Qs3nU9uhdsukkeNqYjLaktT/V+f6JeS655DXCuLO
         xSPVWSsI6lEPrVGVj9Qacb5OPTekhkcMPx+d4of1EK6LbSGwa+0XP80YVwqr7JiwGA3C
         57NDCXbRIX5eVZVJi+mDX+oR08bzJr6bSWv8Pl4/GNgjACvh3r6N8NaXJNjJ1Fyqyckk
         jcKdMqT/F+Q9X5CZx5a6jrmay9TwMuVnQUHCSL3SlOuOiuRqBRCTXQjXA4J1L1D9b2qP
         PLG3JxoWDaB0qvY11Cp1H0JwgBgTyEo5ASphJTv+90o9l0aqwrBnWfTPssgsN8Y6qpvu
         uerQ==
X-Gm-Message-State: AO0yUKUBWbbgkpG+FlbEjjl0TbZZnat8gYkN4lKMo6Pie6LmLkrkvnDu
        Y129KXsguDhG9BTXKbsb7Y78ncxEegM6Aw==
X-Google-Smtp-Source: AK7set9zzA7+a9ECyvKVmoa1ExhBvg84u9Z2YrSaCMCfXkghEiK1wwcvwbFIQyE9q9cH3AZhK7RMVg==
X-Received: by 2002:a05:600c:13d4:b0:3df:e1e9:200e with SMTP id e20-20020a05600c13d400b003dfe1e9200emr17089420wmg.39.1676219895923;
        Sun, 12 Feb 2023 08:38:15 -0800 (PST)
Received: from tool.localnet ([94.73.57.213])
        by smtp.gmail.com with ESMTPSA id w23-20020a1cf617000000b003db1d9553e7sm14432304wmc.32.2023.02.12.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 08:38:15 -0800 (PST)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org, sre@kernel.org
Subject: [PATCH] power: reset: linkstation-poweroff: add LS220D/E
Date:   Sun, 12 Feb 2023 17:37:38 +0100
Message-ID: <4927895.GXAFRqVoOG@tool>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add 2 new devices to the compatible list:
  - Buffalo Linkstation LS220D
  - Buffalo Linkstation LS220DE

Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
=2D--
 drivers/power/reset/linkstation-poweroff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/res=
et/linkstation-poweroff.c
index 02f5fdb8f..cfee2efd9 100644
=2D-- a/drivers/power/reset/linkstation-poweroff.c
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -142,6 +142,12 @@ static void linkstation_poweroff(void)
 }
=20
 static const struct of_device_id ls_poweroff_of_match[] =3D {
+	{ .compatible =3D "buffalo,ls220d",
+	  .data =3D &linkstation_power_off_cfg,
+	},
+	{ .compatible =3D "buffalo,ls220de",
+	  .data =3D &linkstation_power_off_cfg,
+	},
 	{ .compatible =3D "buffalo,ls421d",
 	  .data =3D &linkstation_power_off_cfg,
 	},
=2D-=20
2.39.1




