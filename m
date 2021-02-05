Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBA310271
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 02:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBEBx0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 20:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBEBxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 20:53:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC386C06178A
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 17:52:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y10so2750104plk.7
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 17:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HPlCt/oLMkzfdSzMbmF5TMe9TN1Pemw5Bf1xj8IPkbc=;
        b=aaG88vmPvUfGM+ENAlspEss54lgXvtTfMg1yw0Ql+KXLOFMxNllsPhTgb5xD5vwMml
         LKssZfpTlxkEKEnt+aWgG7SwotZi4G0ZYlUJftzq6jjL5Vx49gbNPC9tUaGQPLJ4D7IM
         hTavVEUW3lsn+B0Lo96JJ73j2/1BsGxN3VgDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HPlCt/oLMkzfdSzMbmF5TMe9TN1Pemw5Bf1xj8IPkbc=;
        b=Bxv9kaNJcNktDxjbkTGvSjI2r0sWsUfi5hOVHahQYLx1eJJ0YGYmz0AlM4NA043iMi
         /Ay7H0d2w3Tdmf7cdvUczixsZryJ5T8qTXE1hJ6L+4A8Wa0Ao4Z9jl3rI7Oj2yufX8uH
         yGpdLbpF+HzWs1lV58CSNrvIuqbYMj1gdQEUoxXAMch8nBOsRO7xnSsYs950zYdHMNVu
         wVkLi66KS0c/IvkSWq2OSKf6ryxNdgyr4fTi+duhBQzMw7LyqdMEu0R+IDH90ZAPwfJU
         5W2olw9xUFsysT+AMEDvQyYmZP4amxLldzUeeyzTaDA+fLIz+8C22lPhTphogSB8BCMk
         +f2Q==
X-Gm-Message-State: AOAM533ICA+ASSkrkAtm6tOTXeaDHztAeyf9rZ3CTDoyHr7DBfE2oRQ0
        gutnLF2D4ViPXyuvEkS5BiZUPQ==
X-Google-Smtp-Source: ABdhPJztxs5hvHnG2TytvQiPpYtx+iVGjsBzbaRXxg+ESnHMEM6gYYE5tWFqg+xsj1ShR/Ew4HAcYg==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr1780338pjs.200.1612489958131;
        Thu, 04 Feb 2021 17:52:38 -0800 (PST)
Received: from localhost (162-207-206-139.lightspeed.sntcca.sbcglobal.net. [162.207.206.139])
        by smtp.gmail.com with ESMTPSA id h124sm3327073pfe.216.2021.02.04.17.52.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 17:52:37 -0800 (PST)
From:   Benjamin Li <benl@squareup.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Jun Nie <jun.nie@linaro.org>
Cc:     kernel@squareup.com, Benjamin Li <benl@squareup.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Clean up MSM8939 interconnect driver
Date:   Thu,  4 Feb 2021 17:52:03 -0800
Message-Id: <20210205015205.22947-1-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Following up on a review comment on commit 6c6fe5d3dc5e ("interconnect: qcom:
Add MSM8939 interconnect provider driver") to clean up some log pollution.

This is based on icc-next (which appears to contain a refactor commonizing
functions into icc-rpm.c).

v2:
- Update commit message to add a full explanation, rather than referencing a
  previous commit.

Benjamin Li (2):
  interconnect: qcom: icc-rpm: record slave RPM id in error log
  interconnect: qcom: msm8939: remove rpm-ids from non-RPM nodes

 drivers/interconnect/qcom/icc-rpm.c |  4 ++--
 drivers/interconnect/qcom/msm8939.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.17.1

