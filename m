Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4B76C1F3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 03:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjHBBP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHBBP5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 21:15:57 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738C9DA;
        Tue,  1 Aug 2023 18:15:56 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58451ecf223so67846107b3.1;
        Tue, 01 Aug 2023 18:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938955; x=1691543755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lgSai1pyDo8uOL0Li7NXwby3lHChba1aN2NkNAk8ChA=;
        b=d2qefvngyl+FkAUn/Hz/mYDEi7bj5tRhLCBzMNuJclcKvvkf8ekZBS12JdlLlMKl5s
         /Zjs/vHU7Dcdwcj5zG3jADEdUbxduHP6HDBtFPYI9FhYuhrK//m1bp/khCVBazusZeg/
         8gcGAl4p4HIWWrJxsCQZW+omruF2shi62+ZtYImA3lsHPCWDKF3z/U7Xx6pOo70mKTtr
         P46swCZWR4tXLGLQVTE49lAsptVRMMy43tXTkoL8kDnTYt5lWt5JbJIWV+BGx4Fb3XHW
         eT4BWC1eBpPU4TGXKPA6qgLhcP2Uv9+aDLv6qevgRyjQIXzebYGtjkl6d1UdYNaFtGN+
         eq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938955; x=1691543755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgSai1pyDo8uOL0Li7NXwby3lHChba1aN2NkNAk8ChA=;
        b=QU+R7gdstvfRnzl6PSXp0ntGO60tknuIXa3MG4VlNF3/eqjuVgwD/uMFagB6emJ0n5
         MNwQjrU47dOqS+E87yIFuubHKqx/SUwlDE5po0niZQ5aNHMaK5otUGs+O9C0b37r7W5K
         fMtu2eCE5GbzJuGrexBylvWr3r6c33tI/BQoPRZg8Pz1vVk+bSTufZRRSdkhXPc6qnoF
         StA5vbYWIg89JqLqGJZigga/uB47a2sHroC+pmTsnGiPYgwksexUrsS/9CH7SDRru5YK
         G7IisN2EFbnnQklk7/IWONNu22NqJIcctySvxBDW03etSiLFJ3273l9/yv65hp8jwqV8
         uqdQ==
X-Gm-Message-State: ABy/qLbRjfqfQ9KitvgPp7plDOBRTbDbRkvHFNJACF/ZYC/QVOj7qwDa
        1E6fbJRnpx/EVOtr2KvhrOI=
X-Google-Smtp-Source: APBJJlGlzw2SMUfGNhMDwi5dlSIyG2RhrKJ5YpTyqhgji+itA679YEe+hNhV0TnZMHDWnZeWuO21rA==
X-Received: by 2002:a0d:ca92:0:b0:577:1e1e:c94e with SMTP id m140-20020a0dca92000000b005771e1ec94emr13040495ywd.39.1690938955584;
        Tue, 01 Aug 2023 18:15:55 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::7cda])
        by smtp.gmail.com with ESMTPSA id i145-20020a819197000000b005844ae2bfa3sm4159464ywg.95.2023.08.01.18.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:15:55 -0700 (PDT)
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
Subject: [PATCH v2 0/4] SDM670 CPU Frequency Scaling
Date:   Tue,  1 Aug 2023 21:15:48 -0400
Message-ID: <20230802011548.387519-6-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes since v1 (20230724214209.208699-6-mailingradian@gmail.com):
 - removed voltage documentation in device tree (3/4)
 - amended commit message to mention bandwidth scaling (3/4)
 - accumulated review tags (1-2/4)

This adds CPU frequency scaling and the OSM L3 cache controller to the
SDM670 device tree.

Richard Acayan (4):
  dt-bindings: interconnect: add SDM670 OSM L3 compatible
  arm64: dts: qcom: sdm670: add osm l3
  arm64: dts: qcom: sdm670: add cpu frequency scaling
  arm64: dts: qcom: sdm670: add frequency profile

 .../bindings/interconnect/qcom,osm-l3.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 175 ++++++++++++++++++
 2 files changed, 176 insertions(+)

-- 
2.41.0

