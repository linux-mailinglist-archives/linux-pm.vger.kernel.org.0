Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7D68DE86
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 18:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBGRLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBGRLO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 12:11:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326033BDAA
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 09:11:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jg8so4750478ejc.6
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbURvTbpReLpP08sYQLDK4S6s064CAuQTu6FOozsWJs=;
        b=UA3hhxwD3NV+1RoRXhXI4l2FV+68YJvBziXETS3+W3duQdy+23b1JxzShlkO+DQhF1
         MOUDdPYY/h7LLyvRZ9LEKLYE+XKH+covlirwNg/QerAdxUuNxp0t9M7GWIb6QQ0lO8DT
         3t7G8rd3l77rXaaJ7wI1y4NWPj/ZXN2MavbTqdnIpsYYGxfnQ+oSgpOM2IuJ9STCGFOA
         R7LqrpSuiKUhCcTgqVNcSN1YF4fRKU1Yt3ZxpS1YGK3qAdMM4+jNLcn0afmRYvVMr/yo
         jrTPCRCbd0oe+GZD1Bw/f/bcJB2e1icjQZH+QTY2SgAkIlAMo/3b/4DThIIoTLfWqURk
         yXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbURvTbpReLpP08sYQLDK4S6s064CAuQTu6FOozsWJs=;
        b=XQmoWodl0BUoRwxj93VvyMZIVPNjL+zum8JHcNAKqDDpcEb4TAxCMfV65h/vnUQodP
         YHtw5m5SORB91eCRRnWJBUUUJL2rvd+XfLdHW50TE1D0iTwyNq4bEfcKaJsrN3dUFhhn
         NGLfXZgvBJKkMkLdgl9SdqhDkC9ZFwhOVqAoqRNMdeVGjgSr0nNj8vS/K5ELNRIP5ytd
         keEtzI9o0Jnrh4Tv30tFx26KVZVVBsdFukoL8SD9XipnANA6L1zfcCGjMFpO+apJ68nG
         EQFJTfrmP1zlzbQaVj2rypcl4vRlbjj/xHlKsDJOTA5p6SmQyZIxOgvcwQLKHQn8XstE
         rFqA==
X-Gm-Message-State: AO0yUKUJocbtko6DKlcv1NQlSKvY9/HjtEnBBSxs+92q7moR9e/zzqgU
        PCwxaCWbs/M4/1SaRrPx9X7kfw==
X-Google-Smtp-Source: AK7set8vKizSoQSkZgw64XH+10nDw9CT4gTzW5FC5214KenwCATaPoNZIpZ1T3uYixCv1KwtQpXxgQ==
X-Received: by 2002:a17:906:71c3:b0:888:4f0e:bb72 with SMTP id i3-20020a17090671c300b008884f0ebb72mr3900759ejk.40.1675789870808;
        Tue, 07 Feb 2023 09:11:10 -0800 (PST)
Received: from sleipner.berto.se (p4fca2792.dip0.t-ipconnect.de. [79.202.39.146])
        by smtp.googlemail.com with ESMTPSA id n23-20020a1709062bd700b007a4e02e32ffsm7132298ejg.60.2023.02.07.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:11:10 -0800 (PST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/2] drivers/thermal/rcar_gen3_thermal: Fix device initialization
Date:   Tue,  7 Feb 2023 18:10:09 +0100
Message-Id: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This small series fixes a window where incorrect values can be read from 
the driver before it is fully initialized. The root cause is that the 
thermal zone is register too early.

Patch 1/2 prepares for the change while also fixing a theoretical issue 
where one thermal node described in DT would describe interrupts and 
another would not. Resulting in interrupt support being disabled for 
both of them. I'm not aware of any case where this configuration would 
be used, either the SoC supports interrupts, or it don't.

While patch 2/2 fixes the real issue by fully initializing the device 
before registering the zone.

Niklas Söderlund (2):
  drivers/thermal/rcar_gen3_thermal: Create device local ops struct
  drivers/thermal/rcar_gen3_thermal: Fix device initialization

 drivers/thermal/rcar_gen3_thermal.c | 34 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 15 deletions(-)

-- 
2.39.1

