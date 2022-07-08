Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B056B97B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiGHMMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jul 2022 08:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiGHMMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jul 2022 08:12:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F989CE3A
        for <linux-pm@vger.kernel.org>; Fri,  8 Jul 2022 05:12:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o4so30287853wrh.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Jul 2022 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8w8iUnO06xpNNTx1uNb/VB35F/Bn/nD/eESgVEkqCWk=;
        b=rkYLkHFWtyAYhX2gYXIXFR9VqWhIThf8hJGmlpcr5pedzfOUkhZS2FT9jaR87iAWpF
         LP5mzBIAq0ar7sEnqj7wZjcI/B9OKhA+Dk6kdqVhjjYEza0CNnWrVnGkFqrjmFzZS6/h
         ltfCKvue/44X/0XjTI/fDHUwUmE1XqIv/Vlv84JH+XopP8PekPB34mbFdEFdLIOfhks4
         LdDkAoJLrTrRbBHkYXlInHv9P0SDWa4XH5qLWh4U39D0172Kl/qrBLQU8OS9GULiQjVZ
         xduV/jy0r0DbyoSoay+380Sa1tG2cHODBEWs6SF7TyuDEbI/2yy3xwLBwBGmala40EYA
         wcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8w8iUnO06xpNNTx1uNb/VB35F/Bn/nD/eESgVEkqCWk=;
        b=IqZ0aWFUb3KJD+xdK4NKmnBPwjK6omfSpAKsSI3ULPnDoNEG2BHsycxaetlRzp3qNu
         gCwSvCZXcWHsT5P5hNzkwbNwQvUopoA3D86toyUbojHGjvWIgXOWggMscJuV6F89OMNJ
         X5v7UiCvd700mIH/GSwEtpmbIz0MDZEJwXqJ8yW0A8W5ZxqM32+2PEG59DabPiCMUrpU
         EfNBYjFhx1aMbYb/qHeOvLRoIN74ftFwLrPGNzz5Zk7i58PVMw4fah2UgSAnGSCkNkS0
         aLBlS2x/B631wSLKQUioXNoBLvHcIQdz3vMt5RNzwUGNQpHoCyxbHXpI4TVkczC12sMl
         q5ig==
X-Gm-Message-State: AJIora/8drqVp5pMwBSOlQYZZpqx6WJLu/TMhfIXeb/tMkZoCzEcSJdU
        tdTo/BV/oWCx16XgHvixNcKIcQ==
X-Google-Smtp-Source: AGRyM1vQuLeTvDT59elqz89G6EwR6xpO739ErCOJg2JIBohiqo5MAy9lHed0BjiYPiw23B54pXDj4w==
X-Received: by 2002:a5d:6c63:0:b0:21d:2a53:c7a9 with SMTP id r3-20020a5d6c63000000b0021d2a53c7a9mr3180760wrz.34.1657282318803;
        Fri, 08 Jul 2022 05:11:58 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c1d0300b003a03ae64f57sm2030549wms.8.2022.07.08.05.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 05:11:58 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, stephan@gerhold.net
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v3 0/3] msm8939 cpufreq preparatory work
Date:   Fri,  8 Jul 2022 13:11:53 +0100
Message-Id: <20220708121156.2165250-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

V3:
- Drop the exclusion of msm8939 from cpufreq-dt-platdev.
  I'm happy enough to bundle this in with CPR. - Stephan

V2:
- Previous series title "qcom-cpufreq-nvmem: Add msm8939 with some fixups"
  https://www.spinics.net/lists/linux-arm-msm/msg116201.html

- Drops adding msm8939 to the cpufreq-nvmem layer at all.
  cpufreq and CPR go hand in hand so we need to do the addition to
  cpufreq-nvmem in tandem with the associated CPR driver update. - Stephan

  We can still add in msm8939 to the cpufreq-dt-platdev block list and
  fixup the dt binding check errors found doing that.

- Adds a patch to the error reported by Rob's bot.
  Rob said he thought Krzysztof had a patch for that but, I couldn't find it
  so I just added a fix as the first patch - bod

- Adds Acked-by Rob to second patch
- Adds Acked-by Krzysztof to third patch

V1:
Fix up some missing compat strings for the qcom-cpufreq-nvmem yaml.
Add in msm8939 as a compatible qcom-cpufreq-nvmem.


Bryan O'Donoghue (3):
  dt-bindings: opp: opp-v2-kryo-cpu: Fix example binding checks
  dt-bindings: opp: Add missing compat devices
  dt-bindings: opp: Add msm8939 to the compatible list

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml      |  7 +++++++
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml  | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.36.1

