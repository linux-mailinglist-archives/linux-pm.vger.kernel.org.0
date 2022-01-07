Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0D487FA4
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jan 2022 00:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiAGXxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jan 2022 18:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiAGXxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jan 2022 18:53:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794DC06173E
        for <linux-pm@vger.kernel.org>; Fri,  7 Jan 2022 15:53:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so8222760pjb.5
        for <linux-pm@vger.kernel.org>; Fri, 07 Jan 2022 15:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPcxFdbNSuAjDGPM+825c9NOOVh3gwUSyNILvw1m1k0=;
        b=lhNOOhqYLhMvK4rkGdb4BXXvq5TC2C4KLjl5uJ3BMNplsn426UWj8vStE4yDA72uz8
         y9S20EG3h1F46L14QZXLuxaIRhZ7nMI0v4qxyVcG1v+y1WbvXorMN1hoA1ACB6fyZlVW
         4IBVVhMfh7FEyBP7/GqQ8XPmlFu5P2KaXUQyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPcxFdbNSuAjDGPM+825c9NOOVh3gwUSyNILvw1m1k0=;
        b=YMcSsVc0LPesTlJ28OIsobtPq96DwSUVcUdZJWt4sKPu1iYwexAKsCNJjDYCNU8nOd
         QirGsxLufz9bjhK7X00QtObxFOUG0v8cWuTc5x/+R26/vWhoaF223Cq5iZM3fHR0Fx5l
         /MvRP6O9ichrulV5aEo5jp9q9+pD+YX0KMwsmWwIK/bllTUW5lPI2mfWMlbRrIe5UnAW
         X/ULHgIUu0wJ6kGkDxbQzZKKF6XxHomrjcMWxfqqB0YWYc2ncEjokhIKFioYuWDLF08d
         IyzAgIMXVdnDaaV9W/DOLC4P5UcsVhHNEZoNDFYI/F5XY0hjQbSkOJ5f3BdY5c2Oj/Oi
         lo2Q==
X-Gm-Message-State: AOAM532p/GelaSeOTI5JOcDh2bQ6FzlhEhx3VBEb6EsAj6h+qdCDn+70
        5GdFD+K0bWP7m7f+WcKCYTyJSg==
X-Google-Smtp-Source: ABdhPJyF/beCttXDGa8cvG4GzHj8zaoaRTN3MHegrEuZhaQaILf9BIU+PkWqdqcpSpz7jwqc4/46RA==
X-Received: by 2002:a17:90b:380c:: with SMTP id mq12mr18376589pjb.142.1641599609257;
        Fri, 07 Jan 2022 15:53:29 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id e5sm13593pjr.25.2022.01.07.15.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:28 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 00/10] rk3399: Clean up and enable DDR DVFS
Date:   Fri,  7 Jan 2022 15:53:10 -0800
Message-Id: <20220107235320.965497-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series covers 2 primary tasks:

1) Resubmit prior work:

[RESEND PATCH v5 3/4] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
https://lore.kernel.org/lkml/20210308233858.24741-2-daniel.lezcano@linaro.org/
[RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/

This series was partially merged a while back, but the remaining 2
patches were blocked mostly on stylistic grounds (alpha/numerical
ordering).

2) Integrate many updates, bugfixes, and clarifications that were done
by Rockchip and Google engineers when first launching this platform.
Many of these were not integrated in the earlier series (e.g., the OPPs
changed before production; earlier patchsets used pre-production
numbers).

Along the way, it seemed worthwhile to convert the binding docs to a
schema. Among other reasons, it actually helped catch several errors and
omissions in translation between downstream device trees and the version
that actually landed upstream.

See the patches for further details.

Regards,
Brian


Brian Norris (8):
  dt-bindings: devfreq: rk3399_dmc: Convert to YAML
  dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant
    properties
  dt-bindings: devfreq: rk3399_dmc: Fix Hz units
  dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
  PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
  PM / devfreq: rk3399_dmc: Drop excess timing properties
  PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
  PM / devfreq: rk3399_dmc: Support new disable-freq properties

Lin Huang (2):
  arm64: dts: rk3399: Add dfi and dmc nodes
  arm64: dts: rockchip: Enable dmc and dfi nodes on gru

 .../bindings/devfreq/rk3399_dmc.txt           | 212 -----------
 .../bindings/devfreq/rk3399_dmc.yaml          | 339 ++++++++++++++++++
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |   7 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  12 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  28 ++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     |  25 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  19 +
 drivers/devfreq/rk3399_dmc.c                  | 230 +++++-------
 8 files changed, 525 insertions(+), 347 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml

-- 
2.34.1.575.g55b058a8bb-goog

