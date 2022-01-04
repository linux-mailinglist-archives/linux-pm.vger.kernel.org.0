Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CBF484B02
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jan 2022 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiADXDh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jan 2022 18:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiADXDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jan 2022 18:03:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3548C061761
        for <linux-pm@vger.kernel.org>; Tue,  4 Jan 2022 15:03:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so626178wmj.5
        for <linux-pm@vger.kernel.org>; Tue, 04 Jan 2022 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=YnlOWDgjlMB4rFNWbCTyi5cSZMFsXGAB6TZsI/YdqCk=;
        b=clzvY5RRW6gMAQ8mJr4Cl/33PlAnapvDAyreT4+opYtxJi3lVggDAbqchheZVxc0BB
         QlbkGIGo5mquIDv2XgAvfEmZHqSUANJcUI1wCkOhILeDZPX5q+eOkZXQtFGITRoHV2Ti
         Z9gX5i2cDhjI39797aPotpd1ZbttsUaSBrtsWGyVBkO60smSoGvNhYCXPwknQ7qgSnsT
         YkclEIfT6l9nhOX8rGqQqmuni2/E3JOexYsFktjdWO7fHRIKO7QWjZO0HSMD9Tkwwez/
         rOzJwUGskYr8/fM0MkEpj8fmKgHpllMQGkZ0qqhwnzu0jsbDomqky1R604kZZQwqeOkX
         FCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=YnlOWDgjlMB4rFNWbCTyi5cSZMFsXGAB6TZsI/YdqCk=;
        b=lhnhPwBPvZvsiaqR4uxTX0gCrY1vAucxeKhVc8dNf190AeYGJ7qh5NmK/Sg3OwS15f
         Hiob+huXn/IqlEW/+2aGG7ZKgdbwtaEjaRv3wDI8rfFj3hBFw5MJwkXwprLP3B1PEyaq
         1rvGlBjDAM2ElqLFzuNhCPt4114qmX2ZUtwr6m+2M1UQvXbejl1th6rJ3OS6F4r0tKLj
         fP2fiZn3OhrnIOtrcEn45mCD6v2OS3U3RDVUz/ipcye7+bNLvgUmKcOxgZfRfgpmsQ5R
         2V2A2dh6DdLIZzf7LZHL9F0EAPqTVJPqNo3xgkC2Y9oOV68c0SkiLx0RFqCO+BIWN1Nm
         /Thw==
X-Gm-Message-State: AOAM5310ElSJlZ7XA77YijRc4VnyRnynC/xLJQvrRgznOUQJNOQFMGri
        PM8k4oMYcX9hYK4vLDNQMio=
X-Google-Smtp-Source: ABdhPJxnEifo5VIFZa6qO1chEpu7UXfsS5b+WVvgpkm5jNGxr/RgHbEj2Rm0vcbGA0nQN0VOCtk/Pw==
X-Received: by 2002:a1c:9a88:: with SMTP id c130mr456286wme.98.1641337414582;
        Tue, 04 Jan 2022 15:03:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2f:5b00:f9ee:e9e3:d08e:f6e9? (p200300ea8f2f5b00f9eee9e3d08ef6e9.dip0.t-ipconnect.de. [2003:ea:8f2f:5b00:f9ee:e9e3:d08e:f6e9])
        by smtp.googlemail.com with ESMTPSA id g18sm39554455wrv.42.2022.01.04.15.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 15:03:34 -0800 (PST)
Message-ID: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
Date:   Wed, 5 Jan 2022 00:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Warning since "power: supply: add charge_behaviour attributes"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since 1b0b6cc8030d ("power: supply: add charge_behaviour attributes") I get the following warning:
power_supply_init_attrs: Property 37 skipped because it is missing from power_supply_attrs
Seems the patch misses the following:

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 2cfce2b2e..ef5109102 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -179,6 +179,7 @@ static struct power_supply_attr power_supply_attrs[] = {
        POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
        POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
        POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
+       POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
        POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
        POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
        POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),

Didn't this show up when testing before submitting the patch?
