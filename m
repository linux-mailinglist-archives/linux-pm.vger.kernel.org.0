Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED92C4D26
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgKZCMZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKZCMZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:25 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A78C0613D4;
        Wed, 25 Nov 2020 18:12:24 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k4so587985edl.0;
        Wed, 25 Nov 2020 18:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxZfQx8x6vTXb59BZsUf5Bt3VSeXTowGHZ6thNjZY78=;
        b=Fe+oqGlxa4rRASZssYsmj68nP+K7d24gEnwwaKAPLLCiHlZwtj963hYpoYJ/wBlrld
         K/OI2Q01tjjlYqoBW7FMYagNppiNnvWBbsKAEMtHQztjPfWpORxUD/bTdrt+2h8TplzX
         sfa1rUDQR212hoWYPtkQT8LqB+tcemnRDGQ2mr6xpsGYkz4N6CLYyXfker+2tun5zlHS
         2Q2X85Yg5tmpI2tpeoIVwCVeTq1Hu7NqCgcd0RJvGgsBgvdWfz/H6sJessKhL8xMXxfI
         TLj4P1rSXyeJUn3zHJZHOnUpT3UZ7yyxYYK/HSmBJ2QlRAj6PX+E1pkjC+7E3vMEL3qG
         MM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxZfQx8x6vTXb59BZsUf5Bt3VSeXTowGHZ6thNjZY78=;
        b=StT9+ypsdHWrFnOlK/P/DkNOj77Dq3U4jIBslD+mEBtu8+BDMOxREJ3GC6stDiuw9n
         UlHNnorCLLm84G87HMVxL6pQScHwNIA1ukGV+XK9PXluhwvwd0RSyxIllyk9baM0p+xe
         ActgntnhiUqRMvaGPpM8+uysr5kTfRuZ9c8RRY9IvSEVC7Z07qeB/vMC8BzhPHEntm4J
         pSx3cczsu6W6Mf8ItN8MIZFg6swVogXQNlYnS9dHKL8t23OyCOrj0r5WWQQHtbikzdMM
         W1ThKNr4D72ghi6ZnPRqeI/QUEdnu6MTfjwiE1pS65uDh+po0aScy4NxCenWB4itvObz
         WYLA==
X-Gm-Message-State: AOAM5324xBVitjeIkOICibSkqCGAvv0V2l6HIiB4KURezewX+HqwiWjc
        BGCw0xZifwwsix72WYi+pSmsTaxIaj5s0A==
X-Google-Smtp-Source: ABdhPJwDHCQnqLfAkLpE07/s3hPIJYKClvYHWm3tDFBLFEn9XWMX7R1nHTslK1MWDb+E9lwPfXKcOA==
X-Received: by 2002:a50:e60a:: with SMTP id y10mr474249edm.157.1606356743115;
        Wed, 25 Nov 2020 18:12:23 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:21 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/8] Add support for ipq8064 tsens
Date:   Wed, 25 Nov 2020 18:48:17 +0100
Message-Id: <20201125174826.24462-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset convert msm8960 to reg_filed, use int_common instead 
of a custom function and fix wrong tsens get_temp function for msm8960.
Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
to be registered as a gcc child as the tsens regs on this platform are
shared with the controller.
This is based on work and code here
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage

v7:
* Rework calibrate function to use get_temp_common
* Fix wrong required in the Documentation for ipq8064
* Fix hardware bug in sensor enable function
v6:
* Fix spelling error (can't find the problem with variable misallignment)
* Rework big if-else
* Remove extra comments
* Add description about different interrupts
v5:
* Conver driver to use reg_fiedl
* Use init_common 
* Drop custom set_trip and set_interrupt
* Use common set_trip and set_interrupt
* Fix bad get_temp function
* Add missing hardcoded slope
v4:
* Fix compilation error and warning reported by the bot
v3:
* Change driver to register as child instead of use phandle
v2:
* Fix dt-bindings problems

Ansuel Smith (8):
  drivers: thermal: tsens: Add VER_0 tsens version
  drivers: thermal: tsens: Don't hardcode sensor slope
  drivers: thermal: tsens: Convert msm8960 to reg_field
  drivers: thermal: tsens: Use init_common for msm8960
  drivers: thermal: tsens: Fix bug in sensor enable for msm8960
  driver: thermal: tsens: Use get_temp_common for msm8960
  drivers: thermal: tsens: Add support for ipq8064-tsens
  dt-bindings: thermal: tsens: Document ipq8064 bindings

 .../bindings/thermal/qcom-tsens.yaml          | 103 ++++++---
 drivers/thermal/qcom/tsens-8960.c             | 198 ++++++++++--------
 drivers/thermal/qcom/tsens.c                  | 172 ++++++++++++---
 drivers/thermal/qcom/tsens.h                  |   8 +-
 4 files changed, 335 insertions(+), 146 deletions(-)

-- 
2.29.2

