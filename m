Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686AA740F71
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjF1K50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjF1K5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 06:57:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2518D1999
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 03:56:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98df69cacd1so397776066b.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687949816; x=1690541816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTQsoS+h53Vzzjs8qIkqE4wzhWloV1Y4NhbaPd70qbM=;
        b=Fb/Wu62fN9GstdwqxVGC9NlOLfqSqYunhCsHpNEsTngqJ05R6sbGO6EgkSCfC1O1KU
         Rp5DtAcNNhomPtbP1F/Zlc6CnHdUmNlh43TqMavwb4JcwmLgkdunqhQ0gF/HLPBhtVFb
         pQ871BCyLXXhg7YbABeh4F6v8gJC29AbEIBjudezHIKkQe8dNPVq5CHfZvMCEecowkkH
         bjfUdhjAoQgIcZ2FFoHdXJSNDylD2m2FdTquenR3st8z29J2qkgYZsDyTY0Y1o2zTc17
         9t9x5vI0OEr6WZZEcF1tU02KQ9kr27Ma1nPLTLfrqipHihWq6LHtMQWFjCEIqfFW4MGA
         7RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687949816; x=1690541816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTQsoS+h53Vzzjs8qIkqE4wzhWloV1Y4NhbaPd70qbM=;
        b=BkcYoQM9zIAvwp07xD4qtizITec/XgVQmQr7JWiGPD4qXGyKoGi6UGCl7Wnhhuup/6
         3ME9Jf9zsEEYFWFVRVgM769yJMUgK6I0J4VWeJL0SyHy6yhBTJ2bTmNp6mb7XMDPFvSD
         NXEu4nqMDyud62juhIG9v+dIuUMktJmZP//d79Sr9UhQDrAWP/sPc8aVHHccUanc34XD
         jDsVq/husOXXAFlZ04ug71FNHkcC0Dp5FMrhamkAjX431urTAR+s21eBtDAu9Y+iDOWc
         06zQ1xM1Mcljb2rIcMFDAmRZnMbPDyM7x+xKKky41ywVwvuULRwsffgRFj/5kY71XoRZ
         Qfaw==
X-Gm-Message-State: AC+VfDyKgesV1IpW4pTk+G0ed8Xmm4cCPYJY8lOnuL8OlPitSa/MmJns
        xPshymbOIbU/qYbzoJAdJsFNsg==
X-Google-Smtp-Source: ACHHUZ7Ck01xIBnrG3uP6P5tN/Jm9n8V/n4BxNQUecjRP3n5noyncuJBJMg954rqH4xX5H0F8x01hg==
X-Received: by 2002:a17:907:7291:b0:98d:d26c:e142 with SMTP id dt17-20020a170907729100b0098dd26ce142mr11584981ejc.46.1687949816608;
        Wed, 28 Jun 2023 03:56:56 -0700 (PDT)
Received: from hackbox.lan ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id e8-20020a1709062c0800b0098921e1b064sm5544678ejh.181.2023.06.28.03.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:56:56 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] PM: domains: Add control for switching back and forth to HW control
Date:   Wed, 28 Jun 2023 13:56:50 +0300
Message-Id: <20230628105652.1670316-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is just a resend of [1]. This resend just adds the back story behind
the need for such a generic API as a cover letter. Also added my SoB tag
to Ulf's patch.

Some of the newer Qualcomm platforms support handing of the control of
some of the GDSCs (implemented as power domains in Linux) to some device
firmware. The idea behind such approach is that the firmware knows best
when such a power domain can be powered off or not and leads most of the
time to better power consumption.

At this point, if such GDSC provides HW control support, the current
implementation is switching to HW control right after the GDSC gets
powered on and it is left in HW control mode until right before the
request for power off is done. This needs to remain as is for now, as we
do not know for sure what each firmware expects from its related GDSCs.
For example, the venus driver expects the codec GDSCs to remain always
in HW control mode, otherwise the firmware would crush.

But in some cases, the consumer driver needs to switch back and forth.
And the explanation for such case is when a driver needs to interract
with the device (e.g. reading status bits) and the firmware doesn't
guarantee the GDSC will be enabled when in HW mode. Therefore, the
consumer would need to switch back to SW mode, do its thing, and then
switch again back to HW mode.

This is where the patch from Ulf comes in. It allows consumers that
actually need to control the HW/SW mode to do so.

The GDSC patch just implemets the set_hwmode op and sets it for each
GDSC that provides HW control mode.

[1] https://lore.kernel.org/all/20230627104033.3345659-1-abel.vesa@linaro.org/

Abel Vesa (1):
  clk: qcom: gdsc: Add support for set_hwmode_dev

Ulf Hansson (1):
  PM: domains: Allow devices attached to genpd to be managed by HW

 drivers/base/power/domain.c | 66 +++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.c     | 22 +++++++++++++
 include/linux/pm_domain.h   | 15 +++++++++
 3 files changed, 103 insertions(+)

-- 
2.34.1

