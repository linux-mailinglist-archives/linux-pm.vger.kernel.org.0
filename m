Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969B322AAC6
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGWIhi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 04:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGWIhi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 04:37:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58BAC0619E2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 01:37:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so747114wrm.12
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Da0sXf4knrzxwq9B1S2PcUH+pe63k6N/+odsq7CE4Q=;
        b=mPMAq3VMk4qcqqR+w/kC5fyrh8FUvFAscpk+3PTX14hWcsTPnyps/CJ9E66HdDnxh8
         sOdAgBrEzmr7gIxZs3TxVQIS0UZkvUhpkGFPNnFaC4vVU2imF3jYbtifdkuX0Mzt2P84
         pyHMfTI6K9hfZw2pKKgBICeZ+MXNNE0pUjgM/hfz8p7KzCmE6hekFXlKEZ9fF7NqqhVD
         mO97EVZFhtLO4Rbp6+fjwlVs4taWi2WNxsw76syqhr+d02dG/4itawq4aZZI2df0CA4Z
         7nWtKjQIk5AVegAxAIxhNe/tEweVHvpR1Ssh/1X+81mP/PyoVs85wJ0DSvq48HTDUXeY
         IWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Da0sXf4knrzxwq9B1S2PcUH+pe63k6N/+odsq7CE4Q=;
        b=MYjv0USXkvUw80VHbYwuVoIFFb74ucEj+1gkSb+8QTmqxVNH7RQFabEVv6HP90JhHG
         igD8BkfhKKwTD5muxtQF6/1RnHJZpWivc5oVhn8EfwP7zM0Lw6WuCC6hH8P99G58sj/k
         QLXE5XP7m0Bd5wopA1CYDxCt701QPWaSaDHyEyWc45z4Eu+LtwNyJCje4OmEVfcr1+0w
         MI95LCwcUeCWiQPbLUTJIClCBRYKdQIYgOwetSRXJyVkTVax0I/1J6ktsCqM32i4RJry
         pQgRHWfv43P7Lnh0tSuaMBBqRLXW4bOl1v34nCDBt6wKTOVJWLIxpqFVYUDmvirs1PRE
         bNqg==
X-Gm-Message-State: AOAM533c6767I9OK4+oWzWV+SBvXCj4fi+J5qEoXLF82Fw1y1SGt8B4V
        N5jmLszecPU298FNt9U+dxXkSMT+xRc=
X-Google-Smtp-Source: ABdhPJx6myFezyrm6PhKVULen8LMKsY5Syjsjnip37vaPOrsLNJ+WrA4SmXAhJHS3d7EILe/vQLGxw==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr2925353wro.43.1595493456513;
        Thu, 23 Jul 2020 01:37:36 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h11sm3105039wrb.68.2020.07.23.01.37.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 01:37:35 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 0/2] interconnect fixes for 5.8-rc
Date:   Thu, 23 Jul 2020 11:37:33 +0300
Message-Id: <20200723083735.5616-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

Here are two late fixes for the current release. One of them is a fix
related to the icc_disable() function, which was introduced during the
last merge window and the other one is a minor driver fix. Both patches
have been reviewed and tested and also got into linux-next recently.
Please apply to char-misc-linus when possible.

Thanks,
Georgi

Georgi Djakov (2):
  interconnect: Do not skip aggregation for disabled paths
  interconnect: msm8916: Fix buswidth of pcnoc_s nodes

 drivers/interconnect/core.c         | 12 +++++++++---
 drivers/interconnect/qcom/msm8916.c | 14 +++++++-------
 2 files changed, 16 insertions(+), 10 deletions(-)

