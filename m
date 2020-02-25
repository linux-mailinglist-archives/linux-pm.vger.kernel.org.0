Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9044916C048
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgBYMIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 07:08:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43038 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbgBYMIg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 07:08:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so5409026plq.10
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 04:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SX9C7ZPdxFmb0GlMBS8FC0FI8zrtThCVdwItF7qjLfw=;
        b=kjA6ZmUypj1HTXa94pZwT1LV+aMpSC/ydMHJTp+4q+7EG4FOXyv9INFTwKISt0b+sR
         +mJV5JIIHoFJ1f3kcrgqQyeEaYANDpG8oJd3L4pT5sJ4F/I0ds9vpCpr46TWyruzjVSb
         mYs3K4X8rs7aNqutA28nCMJUxq32XAMyf1+acFED/1cY/i/AIhDUxMobZGtpRqiSeP9e
         a17RztLLMJN/yS6+eRKQERjzDN9lXPi7R5TWZGArptDgtBQwVuD6VYoJGddV5B34zt2k
         HN2N4iFydeEBezXTM5W12mr5NceG5XLhy5v6vjWNGkKDHyPuuzq+TqCOySFSLCa7fiXt
         q0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SX9C7ZPdxFmb0GlMBS8FC0FI8zrtThCVdwItF7qjLfw=;
        b=Z7I5hJ8ae+rYe3Dr8aiyY9PTyz2WjNE/N2mvrj6KgEZUEx6+aZB9Jys+OPX3LJM78b
         EYsU3gSLThHZ/VsXgNVdJHr4grV3KPW2uAqp6z3cNJ0xvVDBDyPVa67FDMoXMLqfQPmR
         qjjqzxVDOmPTsIzhh/bcDDk1NVnWHOWdvwBP40whwjACrs/qOT5oV3+lki+7QqQxNdbG
         irertMH3yE/WXb0D+Z/8etFdbcTWL7fqfwbsiCWZ2rZRFquZpoeoIZXd8zJYxN6N5H3e
         XZfgkIxsYLfCyjgscUx7zfKearS+JIPonxIcCwIlQlqq+xNlKY/WQfpFhTjvY3RnoyEu
         WnxQ==
X-Gm-Message-State: APjAAAXy2dAEpRbPQOy1ciH6yp/77qNgsyGZGiuuPCSUwYJaKiN7ZFuB
        8DrAfD62jmiQBvwFfyJHnqFVEQ==
X-Google-Smtp-Source: APXvYqyzTnMsiUNjG7S4OAApXWLWj1aNMDRVPTG3vQ+vG4st5HCB6AZCGVIId6V9JLkteFhP1wx4RA==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr54061530ple.176.1582632514117;
        Tue, 25 Feb 2020 04:08:34 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id t17sm9471387pgn.94.2020.02.25.04.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 04:08:33 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/3] Cleanup dtbs_check warnings for tsens
Date:   Tue, 25 Feb 2020 17:38:26 +0530
Message-Id: <cover.1582632110.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make dtbs_check pass for tsens bindings. I'm working on another series to
cleanup other DT warnings for QC platforms.

Amit Kucheria (3):
  dt-bindings: thermal: tsens: Add entry for sc7180 tsens to binding
  dt-bindings: thermal: tsens: Make dtbs_check pass for msm8916 tsens
  dt-bindings: thermal: tsens: Make dtbs_check pass for msm8996 tsens

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi                     | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

