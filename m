Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB211C6B9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 08:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfLLHxh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 02:53:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfLLHxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 02:53:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so1603923wrh.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2BxefIfBzald1w3B2qVq4/Mnrw+MpcEMXquUNshwCQ=;
        b=a4AiFZYKsCKuIL2IwNdbbxZROXHMrl0otYb2KrvVl67D12pLPV5ToyhpKan9Lxwtah
         zH1gICMj5/TgwKYMz8rWYAhYkLvFbaPf+luFG2MN5OByqzHGjLFCO6jUb1mHIpFKSV0u
         NenALf80YXM6faIkMBsbpQTDtBl9DXbMpEN68aCSq3LQnsHuReU6Jw9N95tQCefPGNlc
         PBwSpPEIKTCZpv1jsB83030xy8Q3KSxZSEkCYRXBDp+AL3DLG+hO7GJISuPb1F7idq1g
         vTM4t4sbLHCvOFISPXgWfKf7PE8DxMboCIjJgetj1XObhZqr3gaP/61Kfxs4QR8I97/Y
         cwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2BxefIfBzald1w3B2qVq4/Mnrw+MpcEMXquUNshwCQ=;
        b=gvbKZFnubL8rEeeaB8O45N7zObZSfKHJD7vFm9XQfV9Hnu7CHFenUhb/PNaoZHx1gT
         leM8quzcvEq0zSwL1X0kaBdtDtFLMeJTVedhnIUBEEfuJn+ysUTO3eM5xSidycPo9zvl
         JlLP+CcJDZky0z3MGyXEzZZXdNKOFvP+2FrIlQe9HJWgkg8wmk3r357LtZ9mr+XDQZI3
         ZjVI0sJRYk6Yx7BM+SvUWFY+dd4HaGx+Sp7oUp7ZQsqbfb0UNCjpAi496hJvFKQJVYJy
         Q2OdYj+cPllII8hx6/2WzfZhmJE8uk07hKM7Ofeviij31/O0f1S/CdPt9LNlgQ3XsigI
         zMAA==
X-Gm-Message-State: APjAAAV6WqQTYNas2//+pz6i1CDhNvGcj18dnybufBl60G9xUg1y7PoX
        /YAhQxTcnkDL1/rMUhXM3p5pZw==
X-Google-Smtp-Source: APXvYqy0OeAvvpsa5iPv/x2SAjzroaVo9o7GLOwqpo+4emy6BPTE1Ec+48oc85wlwUtDJCgR0SQcww==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr4544132wrx.153.1576137214539;
        Wed, 11 Dec 2019 23:53:34 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x6sm5636742wmi.44.2019.12.11.23.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 23:53:34 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 1/4] interconnect: qcom: Fix Kconfig indentation
Date:   Thu, 12 Dec 2019 09:53:29 +0200
Message-Id: <20191212075332.16202-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212075332.16202-1-georgi.djakov@linaro.org>
References: <20191212075332.16202-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index c49afbea3458..2f9304d1db49 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -6,13 +6,13 @@ config INTERCONNECT_QCOM
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
 config INTERCONNECT_QCOM_MSM8974
-       tristate "Qualcomm MSM8974 interconnect driver"
-       depends on INTERCONNECT_QCOM
-       depends on QCOM_SMD_RPM
-       select INTERCONNECT_QCOM_SMD_RPM
-       help
-         This is a driver for the Qualcomm Network-on-Chip on msm8974-based
-         platforms.
+	tristate "Qualcomm MSM8974 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	select INTERCONNECT_QCOM_SMD_RPM
+	help
+	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
+	 platforms.
 
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
