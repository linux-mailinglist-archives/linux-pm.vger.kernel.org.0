Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9689259066
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgIAO3X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgIAO3G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 10:29:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055CAC061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 07:29:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s205so1770877lja.7
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8r0GGXDUyWzO1yQhe44+kpzKtZu+hSLAG2hxx4RFcqg=;
        b=vMQjkKXBLiPUbN4DyTDFr9jvb5/4FGzFXnutFtp3zk4J1bGbOWUtaXIIOdjQCe3tr6
         tsslovJBANSxPGjom7m+wza718pGmrQKLRdHGOuW+mefYWEg5t33MikidCZEcrIgsZsd
         yxeE8980DV9VeZDA7WyetRBFS4BA87CB3WPI7KtSKN1ejFQoSfPt8p7KJkIj0cY6qV7V
         IWFIJW6r6yDbKWNn3lZdPy2x22YFn0P2DauVj3PKRlr3c6+nrc7FvEDZufq12o6/N250
         6gMya87peFdAnqRT/o3eui4YRPwgC+mNDPb9nsRpjWhtEoAhqG5liPjY6L/yfVWMAFic
         z0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8r0GGXDUyWzO1yQhe44+kpzKtZu+hSLAG2hxx4RFcqg=;
        b=daSLdCVAC931XSvHSgd18i4rMVwG4UAjbWCg0SbMmtZAyMwPUkeYB19p1d6bvBCrlu
         z070/KW7ihnf4HM2h5ofWbZ4HXPbLMCmqpJE6tYgDTODBw9RZ12dYD4y6gSM7sAjy+tu
         pXCiuySXcZGg4xOJFcDinQzCb8v5LQOM6ngHxHlMaQjSe3AIdsFiyBe1p1hEkFJOVm68
         ZhAz4cqottYkOL70G4lyK740zDbv3/ryoR2vbWk7SwPsX9vjJl+FcuFMCNuoRVkXjqF1
         B5N3sK8r/6BkVEShRCIuAeldT36Y2uOmGeIBZWfUAqVVCfzRZN/jA2XYN20bQaLynHv2
         23gA==
X-Gm-Message-State: AOAM531MFK2Z3M1M7+uhJdCGxQ+QLg/HWq9A8OD6qHxoXU9NKHgud3zZ
        096PO8L/eDqc1OIvKaDXmvlI7A==
X-Google-Smtp-Source: ABdhPJwM9jXlVeuDf4nVw+bhzh3toIu125PwHgmX3p19ZtLGCpivJhYXeHA7a60S81qS3mfD5g4pJw==
X-Received: by 2002:a2e:b5a3:: with SMTP id f3mr720227ljn.70.1598970544272;
        Tue, 01 Sep 2020 07:29:04 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id r7sm318313lfn.84.2020.09.01.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:29:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] cpuidle: psci: Always create the PM domains
Date:   Tue,  1 Sep 2020 16:28:57 +0200
Message-Id: <20200901142859.224381-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This coverletter is mainly to help keeping track of the patches part in the
series. Please have a look at each patch for more details.

Kind regards
Ulf Hansson


Ulf Hansson (2):
  firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
  cpuidle: psci: Allow PM domain to be initialized even if no OSI mode

 drivers/cpuidle/cpuidle-psci-domain.c | 59 ++++++++++++++-------------
 drivers/firmware/psci/psci.c          | 12 +++---
 include/linux/psci.h                  |  2 +-
 3 files changed, 39 insertions(+), 34 deletions(-)

-- 
2.25.1

