Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4112E431144
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhJRHTx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 03:19:53 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2389 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhJRHTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 03:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634541462; x=1666077462;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=tBE9gpFLaTdVJ/JmeejJpC/B5K1DEYpgVD8Zzk/KwLA=;
  b=DlBW55Cx91nqKZt5CKVRdt6GCnaC1WGNu1j0u1MFvYVzHzW7T6ubTM8c
   IL/3Rl0jaYM2Bu9mfbN5In+WBfibvqJhQa7IknpNFjUtl6vqsUZJBcSiG
   8fkLRb+oVLTNVcwAAxynEK6dMkdKh3WK0CHSe3oIVwGs8joo/nTx/t9Z/
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Oct 2021 00:17:42 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 00:17:40 -0700
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 18 Oct 2021 00:17:35 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <linus.walleij@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <quic_kgunda@quicinc.com>,
        <quic_aghayal@quicinc.com>, <quic_subbaram@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Jishnu Prakash" <quic_jprakash@quicinc.com>
Subject: [PATCH 0/2] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Date:   Mon, 18 Oct 2021 12:47:07 +0530
Message-ID: <1634541429-3215-1-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PMIC5 Gen2 ADC_TM is supported on PMIC7 chips and is a close
counterpart of PMIC7 ADC. It has the same functionality as
PMIC5 ADC_TM, to support generating interrupts on ADC value
crossing upper or lower thresholds for monitored channels.

Jishnu Prakash (2):
  dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
  thermal: qcom: add support for PMIC5 Gen2 ADCTM

 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |  83 +++-
 drivers/iio/adc/qcom-vadc-common.c                 | 187 +++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 431 ++++++++++++++++++++-
 include/linux/iio/adc/qcom-vadc-common.h           |   2 +
 4 files changed, 692 insertions(+), 11 deletions(-)

-- 
2.7.4

