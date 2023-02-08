Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE5468F7C0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 20:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBHTEW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 14:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjBHTEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 14:04:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1056481
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 11:03:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o36so14053451wms.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2023 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/qR2Zj0XR4DYuN5EhmzO11WflKoqRk8RRrg6Mw7qFw=;
        b=UspaLc7BP0fMOsZ+uzIurMV+IhsX9DlpJOYvruoZlfwrcYSRYSwU1Tsvsz6MIu7Gzy
         i3V6nLQ8DpuonSl9d20x24zKESs1dTY0SREsrVRu0GDdul8saqFZkWDPtcHbw1DbT84W
         mdlnJUFxqEO7bLLKST5YYF0u3eMc/XsISu6fugPaAhSH/JogIp/iBL3+76QSSXD5nik1
         E/W7s4lUps01YR8ue0vrH/IZI23iDRp9d5OJD+2HH0DzZXADd2HGubXpML0qrNjNk1iS
         nxRaDTg4VirDxCYxLJouvnjMKqoc+DoT9g6Hc5XshdcCtZrfRUEJNVf4F5GV1mPYZndg
         JQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/qR2Zj0XR4DYuN5EhmzO11WflKoqRk8RRrg6Mw7qFw=;
        b=H9HQSN9AYeinObr4kcXHsy7VLIIQaE5W5NnGAHH4Md4uTCslBR1ohOEE6SXu3yUoHU
         B8Vs+m4YL6l8pWwyHz/uN3hNLEMpeUeuih/nufq7Eovp9NCpHCox6mgjR2t8a22Pc8ds
         YQ2XctOk09ynpHAzzSGzJ/fF7wySmfMPW+B0Fwb5C2/ImkWXeg/ls4RVftM+LhAiHmzZ
         kGLgIcJyzvh+Yw4QN2jkuIVd73gml+xNFJSvOu5IsNqQt2vTE8akEbxk6RpJl6P4Acau
         uUuTpYTVYa/uEfBRWHf6FKFak8kaq3vuOhoHUdI6HL3nRQ7NKyOqCiEhbAsl4KQ1yMks
         OOdg==
X-Gm-Message-State: AO0yUKXuiJQXacBbNnZZGWeEVGpuKcA+KUInpMHDsVmH8njLh1gUMu4S
        4n0Affh1XOS86maRLnDJMeZKkw==
X-Google-Smtp-Source: AK7set+5/HS1scAK2y+zdu5rH2Ihh/gQ4IdULb4Dct+vEglwFsXUUS7kEW4g7hrs8z8z1840pbKtAA==
X-Received: by 2002:a05:600c:a697:b0:3e0:1ab:cf2a with SMTP id ip23-20020a05600ca69700b003e001abcf2amr7411296wmb.39.1675883024969;
        Wed, 08 Feb 2023 11:03:44 -0800 (PST)
Received: from sleipner.berto.se (p4fca2792.dip0.t-ipconnect.de. [79.202.39.146])
        by smtp.googlemail.com with ESMTPSA id c12-20020adffb4c000000b002b6bcc0b64dsm14201382wrs.4.2023.02.08.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:03:44 -0800 (PST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/3] drivers/thermal/rcar_gen3_thermal: Fix device initialization
Date:   Wed,  8 Feb 2023 20:03:30 +0100
Message-Id: <20230208190333.3159879-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This small series fixes a window where incorrect values can be read from
the driver before it is fully initialized. The root cause is that the
thermal zone is register too early.

Patch 1/3 is new in v2 and removes a unneeded call to set_trips() when 
resuming from suspend, This call was in v1 changed as part of addressing 
the initialization issue, it's nicer to get rid of it before that is 
needed.

Patch 2/3 prepares for the change while also fixing a theoretical issue
where one thermal node described in DT would describe interrupts and
another would not. Resulting in interrupt support being disabled for
both of them. I'm not aware of any case where this configuration would
be used, either the SoC supports interrupts, or it don't.

While patch 3/3 fixes the real issue by fully initializing the device
before registering the zone.

Niklas Söderlund (3):
  drivers/thermal/rcar_gen3_thermal: Do not call set_trips() when
    resuming
  drivers/thermal/rcar_gen3_thermal: Create device local ops struct
  drivers/thermal/rcar_gen3_thermal: Fix device initialization

 drivers/thermal/rcar_gen3_thermal.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

-- 
2.39.1

