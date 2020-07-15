Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796A12217EE
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOWpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGOWpd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 18:45:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48720C061755;
        Wed, 15 Jul 2020 15:45:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so4740047wrs.0;
        Wed, 15 Jul 2020 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la4qm6vspXOJfm9KXsdHliICfFa0lZg8lLjiPV4UsfU=;
        b=OCHL4KJEJK9ziZzNh1qGADUHvDHQbBolLbT1SaZsUTAFKSLTzQMOPoaSrwV0wQDgzY
         h7Vt+5UTHqfm9faomfb6XfLSxjXkr1IFLN862ngzq3/0/jXFqT5ndSaNwvaPFNipgOOs
         axYreCkhm1/1Rc25buR2LmUOa4cdOJrUxcHccryKq4MtYVR74xNHQhNXAVAwzJvYNhlZ
         R6WY7jNSH55bLUdRS9atC8D5/x6TJGwf5+6keE7MZjacghrCuNUkrsz8BOO4QH4c/PYC
         Gl5+BoC9N5IhIl+uWAxrNd09Ev74MWYNJNQE/3z+j4fMI5Gbt4POvMIpaj6UpHPsfxeu
         qNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la4qm6vspXOJfm9KXsdHliICfFa0lZg8lLjiPV4UsfU=;
        b=kuv7uffZqQiWgAd1GK9CoNTUSsIR3aRa0C7KcVFIslqBEUoCgmU0uYALhABRvyCUtX
         qyQLVtEQj83QkycY5Hc4V60n2NYnyPBGNcZBDlyzwxVf6x5Dshq4E2k36JUDRw49Hvj9
         sOwHLQ8p3xgLzHFwi62qy8cNQevtPv3NcZOuMKrNT79ByMN9zc1gLYqmT0Om+QZbm8Kt
         rt8YsF5qbmuTar5X0YU1ca8AjczDOt/XIlv+20A9yYT2vYs69I1moWUKTB/2XiIELCzl
         Gwmtar4c++ErGNCEDwmFuO0aRWPKt3j2GGKuPq2SaxM1pTV8q0qQdhKXcT+fuhTlxwCe
         gDEQ==
X-Gm-Message-State: AOAM533Ph2wxcPOHIzPcWX2FvErxy9rmXVaBJ7XhV29GQfWo/fs70XEG
        am9oKtunXzJ5Gb84eUQaTqA=
X-Google-Smtp-Source: ABdhPJxWAWBMJDcpCZDM3vJwoFjC/Aa00uTi9xyZVOCAE++3I4d/cu3sCiWcekzqs4P5EZFsIgVsHg==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr1951616wrs.105.1594853131852;
        Wed, 15 Jul 2020 15:45:31 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id b186sm5759898wme.1.2020.07.15.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:45:30 -0700 (PDT)
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
Subject: [PATCH v3 0/7] Add support for ipq8064 tsens
Date:   Thu, 16 Jul 2020 00:44:55 +0200
Message-Id: <20200715224503.30462-1-ansuelsmth@gmail.com>
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
 drivers/thermal/qcom/tsens-8960.c             | 286 +++++++++++++++++-
 drivers/thermal/qcom/tsens.c                  |   7 +
 drivers/thermal/qcom/tsens.h                  |   3 +
 5 files changed, 325 insertions(+), 23 deletions(-)

-- 
2.27.0

