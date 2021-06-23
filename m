Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B3B3B23D2
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 01:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWXJq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 19:09:46 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:35777 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFWXJq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 19:09:46 -0400
Received: by mail-io1-f52.google.com with SMTP id d9so5559051ioo.2;
        Wed, 23 Jun 2021 16:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZLDpuA79csUJoyxxQRsR7ORuZFy0jjxYyRC2e/q9a4=;
        b=OU26BFBu2QnMKfwwJjFbP8v4anr2Je4zR25yhlGdq5oCskTtJPlkD3t/xfpewe70Wh
         sgfVwqDI3ucAb2BQLSy2YCKJj8Q+C/h7S5sPT50ElTC3uAQT+7jRubBzuygITj8sunTc
         z3gWO2Xqy3NYKxsO4dovuRC5Qds8jJ4OPhqex3jPV6AzepzSBZkwPAWtZrDknBgdvN6J
         0+9pdXWSh+UKTZvWsFsi6B87aexavGJdeBBlqRUv9XYZtAWa6IDTgl5YOPY2T3oWNboE
         e2SN/XAoP5IoIrQi+8TFgbRXzPiLxz1DJYb0+qTcEYfYpypwYHCsLWn5eYIfAGFNMAP+
         mCww==
X-Gm-Message-State: AOAM531M3jFzBWGThuvsNpqibbjkpCLl2ItWtZ3aLIxRVHowf5C88DWj
        SEVOKHBY4tdGuhoRl9S/HQ==
X-Google-Smtp-Source: ABdhPJysSMr49GWdevfUQIaAcqS/oiimDgEHRxZO4ul4XB2m7ky2tCzGBT3YSnBk7BCX9Fdml+iFXg==
X-Received: by 2002:a05:6602:2595:: with SMTP id p21mr1570908ioo.51.1624489647011;
        Wed, 23 Jun 2021 16:07:27 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id t15sm694356ile.28.2021.06.23.16.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:07:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] dt-bindings: Convert OPP bindings to DT schema
Date:   Wed, 23 Jun 2021 17:07:20 -0600
Message-Id: <20210623230722.3545986-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP bindings are one of the most common occurring bindings that are
not yet converted to schema, so let's convert them.

Note this depends on a dtschema change in property-units.yaml to allow 
a matrix for opp-microvolt.

Rob

Rob Herring (2):
  dt-bindings: Clean-up OPP binding node names in examples
  dt-bindings: opp: Convert to DT schema

 .../bindings/gpu/arm,mali-bifrost.yaml        |   2 +-
 .../bindings/gpu/arm,mali-midgard.yaml        |   2 +-
 .../bindings/interconnect/fsl,imx8m-noc.yaml  |   4 +-
 .../allwinner,sun50i-h6-operating-points.yaml |   4 +
 .../devicetree/bindings/opp/opp-v1.yaml       |  51 ++
 .../devicetree/bindings/opp/opp-v2-base.yaml  | 213 ++++++
 .../devicetree/bindings/opp/opp-v2.yaml       | 475 +++++++++++++
 Documentation/devicetree/bindings/opp/opp.txt | 622 ------------------
 8 files changed, 747 insertions(+), 626 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v1.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-base.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/opp.txt

-- 
2.27.0

