Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10A50330C
	for <lists+linux-pm@lfdr.de>; Sat, 16 Apr 2022 07:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiDPDNK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 23:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiDPDNJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 23:13:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB9365D10
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 20:10:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bx5so8872462pjb.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qw+wDSDDbxggXGgwwZWkwH3lrynkAiZe9UOImumjJsk=;
        b=ZBntg5kT33IkkIdLfeMCrFJ46V10rWyplYqPdTOkBQU/XYMQpe8+HCXva8iSPQmNvp
         zpJkDZKHI4T6F8Dfj65U5KEFiHArkyStQ2Vc781YA4r9vdU1briwZA5LQj4mUeXLwrPr
         /UjAA44/Q9YMtLMsE+VdFl7HvJjYT3yXDh1dIsVMVreAILb24TTcv7IHs6/5SY8Qz7DO
         SfhzouZUb6kl3u4orcMy8I85oc9Dm0xMBDJG1QuBOBR1RgxlJEs4QObI+QiRzt1pCpD3
         EI9cs/2MGrMhj5NS/L+B94OKYJ1AaoZCWKM/2Jq/mXJx9GnSV/R2or+PqKXAUg5W1LGH
         bgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qw+wDSDDbxggXGgwwZWkwH3lrynkAiZe9UOImumjJsk=;
        b=KApcQoojQCy2crY51BE9ch+9haHnhy2nNIMth3nMQfMY/B5oEgAy4Dp5TD2UdHsngX
         maeaAs3YumeiEmSoVBSk1AaLFQjopLN7D4hJHysZ1hp2ZFJTBDq/J6bsQGdyyx23VWUU
         hYY2VbBdbFMbXZhWI7X9s9teT1rgQe9VQ30BLomccq8YL86ms1M68fEsGHTD6Ky9xX/J
         TFMcyrHHckMDAVye6o5BF6VNr4Xx8I6E2KcRtmJ/2MtquNhgdULvaMSpUzGWVyH/Kr3S
         NpiUZ+D78qMpgmr236nbxUV71DMmxXE0QUH8n2v4wWp1zt53KIj5eQJs4o1RzEMWZbAX
         8ilA==
X-Gm-Message-State: AOAM532nBYStrqVF+tvFf83m8pS2vsd69sAvEnHuSxpW0fr2bYyeYUAl
        ZxBRMNJdBfWsdNx5wuuU8mtQZzwTZSbFpqp+yNnR0Q==
X-Google-Smtp-Source: ABdhPJw6LFV/gr3J5ry4mvD9Yt/mMPTMhNZ0jfRlWuoWoFKpl/HCMZo1MTjRe28Zqn4C8UkkUA4oJA==
X-Received: by 2002:a17:90a:3d02:b0:1ca:7f92:1bf1 with SMTP id h2-20020a17090a3d0200b001ca7f921bf1mr7316233pjc.177.1650078638299;
        Fri, 15 Apr 2022 20:10:38 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id f33-20020a631021000000b0039dbae3fce0sm5719120pgl.43.2022.04.15.20.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 20:10:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/2] interconnect: qcom: icc-rpm: Fix setting clock rate
Date:   Sat, 16 Apr 2022 11:10:27 +0800
Message-Id: <20220416031029.693211-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch set is to address two clock rate setting issues.

The first patch is to fix a potential cached clock rate mismatching
issue, the issue can lead to the clock rate is missed to be set.  Note,
since this potential issue requires specific time window and certain
condition (consumers need to request the same bandwidth) to produce,
the patch is based on analysis but not a real trace log.

The second patch is an extension to cache clock rates for active and
sleep clocks separately, with this change it gives us possibility to set
active and sleep clock with different clock rates.

Another chagne for enabling active and sleep clocks for icc-rpm driver
will be sent out later, which is dependent on this patch set.


Leo Yan (2):
  interconnect: qcom: icc-rpm: Fix for cached clock rate
  interconnect: qcom: icc-rpm: Cache every clock rate

 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++++-----
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.25.1

