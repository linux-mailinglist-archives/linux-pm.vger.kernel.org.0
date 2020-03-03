Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6D1779F2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgCCPH6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 10:07:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34270 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgCCPH6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 10:07:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id w27so3076931lfc.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDm62swX1e309emODy6IWYyN9SUd3dpgxKcG7xrdMlk=;
        b=in2YL3sMp9ZVb0HypyT3fkJ9WJ/6VzmQFhOYfvsHYSCWwDcmFgMBm4A+f2vGlZR0Tl
         8dp9f/h62FrCz+jVZmP57bNnCJKUAsN2srwZWsFmlmQiYWbt6hgkzjiIqUMcRIu90KRo
         fLsDdbq8PPNnkJc3mk/8F+X+FuVDZqiBUnRS+TnoT9IijkwNcCetU8dZl3PAf+cRf7uk
         z1lYnF5mSUy4vsH/jgEbKH7cgPjMhUr7bKLbMweo5dPA4EqMBmIL8MSzbwzMwxDVELeA
         FLOmUqM6yRDS/WpYQfafp9a6QjeMFRNSa59bJqCP5/CbCLSDeKhj8toVJ65l1+Yat3St
         xBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDm62swX1e309emODy6IWYyN9SUd3dpgxKcG7xrdMlk=;
        b=YCWgpMTAUsmaQcx0yEuMuip7/qXCnaBrJjCwQyFLfeRBepBHNeJeXgJ4TAjo9DBxXu
         0YsJ1AK9h4QuXH/a4Y9KQzuUQyJvGeq9ngx6oUE4SxXJSBJy7ZZy/BCCourjHea4rg+n
         a27CsgrNz1nbMjT8y8kzdiDBairXPZYy+0SeLKnsojKhpRhJKqACQAK6me4yPuXXLrSs
         mDnymJNnj8SRVUjpozCegak+1K4rACX4G+30AqloGOUC+o2rH3lxHjWIiZXHGkNy2GQd
         F+PDbIsF7lN0N86gS2ZWdFMU/roeVUwEv4ac9q24sucJ4s4RcvFbvsYBuVTvXOGE1f4h
         nMTQ==
X-Gm-Message-State: ANhLgQ3BtNmZaHC2gqcJXMAVusTB67uw7t0QmqjDceTXGwjRvrUjPEeu
        ZM0vCiyNbHqpQ7jvRLI6idWmmg==
X-Google-Smtp-Source: ADFU+vu+xJCKU5jcGXcrD4NY7owa0bMU7ehQwZMdVV0PPkkCq1EGue6j/E/+90n6hI6Upie+o5FZJw==
X-Received: by 2002:ac2:454f:: with SMTP id j15mr3108670lfm.20.1583248075820;
        Tue, 03 Mar 2020 07:07:55 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n189sm12143135lfa.14.2020.03.03.07.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:07:55 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/7] dt-bindings: arm: Fix bindings used for hierarchical PSCI states
Date:   Tue,  3 Mar 2020 16:07:42 +0100
Message-Id: <20200303150749.30566-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The recently updated bindings to support hierarchical PSCI states, had a poor
quality from the json-schema point of view. This series fixup the related
bindings and silence various errors/warnings from "make dt_binding_check".

The two last patches updates some DTS files from a QCOM SoC, which is the first
one that uses these new bindings. Perhaps those should be queued via arm-soc
instead, but in any case there are included for reference. 

Kind regards
Ulf Hansson

Ulf Hansson (7):
  dt-bindings: arm: Correct links to idle states definitions
  dt-bindings: arm: Fix cpu compatibles in the hierarchical example for
    PSCI
  dt-bindings: power: Convert domain-idle-states bindings to json-schema
  dt-bindings: power: Extend nodename pattern for power-domain providers
  dt-bindings: arm: Fixup the DT bindings for hierarchical PSCI states
  arm64: dts: msm8916: Conform to the domain-idle-state DT binding
  arm64: dts: msm8916: Conform to the nodename pattern for power-domain

 .../devicetree/bindings/arm/cpus.yaml         |  2 +-
 .../bindings/arm/msm/qcom,idle-state.txt      |  2 +-
 .../devicetree/bindings/arm/psci.yaml         | 41 ++++++------
 .../bindings/power/domain-idle-state.txt      | 33 ---------
 .../bindings/power/domain-idle-state.yaml     | 67 +++++++++++++++++++
 .../bindings/power/power-domain.yaml          | 30 ++++-----
 .../bindings/power/power_domain.txt           |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 13 ++--
 8 files changed, 111 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
 create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.yaml

-- 
2.20.1

