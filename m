Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC4760163
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 23:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGXVmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGXVms (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 17:42:48 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207C2E9;
        Mon, 24 Jul 2023 14:42:48 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bb73eb80e4so873451fac.3;
        Mon, 24 Jul 2023 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234967; x=1690839767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YDEOCxfksj50BYekGWN5kBjZF6KNbRMO2noGv80eKw=;
        b=Vdgxk0sOSXflrDk/Qqpjh8is/yXAKEX/Clwokrq1ge0hm/sW7cErreteVv11bN//nM
         N7yWVZzfjyiA2M/pA9mBcnuciW4VAsXTVHgbAqahFPm3z9RcrjW17Q3d+a3y0NrBt9FM
         We/LFI9MwTLJ7y5ICJMiN2/85Bex+2R99QpUGMbFO76nqaYVmgyxEB9mReTKbcNXZ7pX
         dvoGM/H52VAhHr159gizBNZdREHUzQUxl6gPGbsbmYIYeUMolteBkdELHUhgqcnJE92v
         psTCL7RbRa+ngOKMuNv7wzzmCE3XlwzTbPpW/7Et7HZrVFiNZEvvChd73jlgoMiAQped
         2mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234967; x=1690839767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YDEOCxfksj50BYekGWN5kBjZF6KNbRMO2noGv80eKw=;
        b=WFVoephAsvQM0f/RUxQQLtSuErTgRrRWQX8nbe2pDGVpZVO+J5Fax0bJzV8KyE+DmK
         yYg18FIY+62yBXV73xuERPV2qmbev58ULPvQYEy607uUnF4PU7VQWelsnxyQ9XYrprza
         nu6KtYgID8G7nqqEdZRkS2YRKDpRuta0AQUpHYaARP+nWoyTEHqJNpP79aW/vKOkTopy
         fUAHEy/76EUIaIJIttqW0hiI0qTct8PGPICXHW9mA2Ts+Uarf4Vu6BTTI+bGNtDozyXH
         qvLRzYfNeHv8Gd7oNQ7Li4c6ABL6l69oxhP9MwtGe9q/3uvuChhcBqGOSDJmge1htd7G
         zPtQ==
X-Gm-Message-State: ABy/qLbG4owSPm7LhpRopSb/EgWv/nyCWenYpelTiwmZHF1eP1GjsGpr
        2jIuu6DsbUtQ/rdQSCxj6eK+iEQW7NfX1Q==
X-Google-Smtp-Source: APBJJlFwQ7j78w7vqBsy9bbBH+5qOlupSPLNR4dIm1JLXIJgl+mD5+pLZv50Z6dM+mWZl1nDY+NRdw==
X-Received: by 2002:a05:6870:e310:b0:1bb:6e1d:970a with SMTP id z16-20020a056870e31000b001bb6e1d970amr4484882oad.53.1690234967331;
        Mon, 24 Jul 2023 14:42:47 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::3cbb])
        by smtp.gmail.com with ESMTPSA id t199-20020a0dead0000000b0056f3779557esm3087185ywe.113.2023.07.24.14.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:42:46 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 0/4] SDM670 CPU Frequency Scaling
Date:   Mon, 24 Jul 2023 17:42:10 -0400
Message-ID: <20230724214209.208699-6-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds CPU frequency scaling and the OSM L3 cache controller to the
SDM670 device tree.

Richard Acayan (4):
  dt-bindings: interconnect: add SDM670 OSM L3 compatible
  arm64: dts: qcom: sdm670: add osm l3
  arm64: dts: qcom: sdm670: add cpu frequency scaling
  arm64: dts: qcom: sdm670: add frequency profile

 .../bindings/interconnect/qcom,osm-l3.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 194 ++++++++++++++++++
 2 files changed, 195 insertions(+)

-- 
2.41.0

