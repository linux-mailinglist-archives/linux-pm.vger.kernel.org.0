Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27B82219DF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGPC2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPC2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:28:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB39C061755;
        Wed, 15 Jul 2020 19:28:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so5266515wrp.2;
        Wed, 15 Jul 2020 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsRpl4HFoDzQHdJmbJ2aLmqfJZ85+Q+C8XgOBbFtdNk=;
        b=iJqvRTCjPwF29LVysp5cR+WTjEK0keVLezq5UpBh8TBKpPZMK/F1qaiNn1b5v5B8D/
         FwctVpY5g6H34diBhlhZNS/o24RejCvBwMPgfodxR9W7lY1L1ma7q9zqrPlsldw+BTW7
         Gx/b+M7X8ZWs2xUpCoWMwWF94G84TibCIrYoiVvZ2xvCgr/qre442EmfS4tTlmggpjqU
         fFtFOjQuTtdRrxJ8UgiV9lQGFkf59TbBtj0Ub8HLW+7UYT+vkmOSLKVtdBfxZ9LTLW3Q
         6qZf2jga/SNKtQ4BSDn07BsiXrSc/MslbL/NgvxM/WzNW1dZCrfFE8aH2/qNTNN8Qd4Q
         4MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsRpl4HFoDzQHdJmbJ2aLmqfJZ85+Q+C8XgOBbFtdNk=;
        b=FseyxY/qq96AnUI1ztkjKrsb8l6jUoB+DyeEr7wMLE8l8nVX6pv/vrw5mhs7xvc1Sg
         B4dF6DArC9XJe/vUY9CmOqJq2fDFfOxxniS3B5GjsdvUOBwRr8XyUUHVWVx2CgRYLDN/
         AwSxw24HMEWu1uAdbp0/ATSZA63y5rFaZBMJaIWfcFGgVyU6u+X10eO7AWes9CfJR59O
         tRbEyNEwlt7FJu93dfILXZTcvZoBflqp1do45aPvRjHIFUA4pcIeAqQlq2jNmTVM0/e4
         rXVncZlCp/SvKuyezUbepDZq/uce2XWqz18I5SlXsGuygwLuKG4e3L/QIbP50nBCYA7Z
         oO4Q==
X-Gm-Message-State: AOAM533Dbg7ENMtUGUh+SeJvtcVH3xrX3aqjpvdkR3TqrtxO4f5OCwdi
        c4jj9KqF1RwFNbfp9nrx8mE=
X-Google-Smtp-Source: ABdhPJwrSM7RmbkryD0nvdl24d++HH4tjwvWPp/fUZyADj3sIpMbiC0aSTMbqhMcCPbZCNQrTAFH4g==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr2579614wrv.155.1594866502289;
        Wed, 15 Jul 2020 19:28:22 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id u1sm7477611wrb.78.2020.07.15.19.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:28:21 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 0/7] Add support for ipq8064 tsens
Date:   Thu, 16 Jul 2020 04:28:09 +0200
Message-Id: <20200716022817.30439-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ipq8064 SoCs tsens driver is based on 8960 tsens driver. This patchset 
expand the 8960 unused driver with interrupt support and set_trip point.
Ipq8064 needs to be registered as a gcc child as the tsens regs on
this platform are shared with the controller.

v4:
* Fix compilation error and warning reported by the bot
v3:
* Change driver to register as child instead of use phandle
v2:
* Fix dt-bindings problems

Ansuel Smith (7):
  ipq806x: gcc: add support for child probe
  drivers: thermal: tsens: try load regmap from parent for 8960
  drivers: thermal: tsens: add ipq8064 support
  dt-bindings: thermal: tsens: document ipq8064 bindings
  drivers: thermal: tsens: add interrupt support for 9860 driver
  drivers: thermal: tsens: add support for custom set_trip function
  drivers: thermal: tsens: add set_trip support for 8960

 .../bindings/thermal/qcom-tsens.yaml          |  50 ++-
 drivers/clk/qcom/gcc-ipq806x.c                |   2 +-
 drivers/thermal/qcom/tsens-8960.c             | 287 +++++++++++++++++-
 drivers/thermal/qcom/tsens.c                  |   7 +
 drivers/thermal/qcom/tsens.h                  |   5 +
 5 files changed, 328 insertions(+), 23 deletions(-)

-- 
2.27.0

