Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8C72690E7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgINP6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgINPsW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 11:48:22 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E6FC06174A
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 08:48:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z17so13932224lfi.12
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5u2WKpvJkPwpwzBwkS2qywZLUc7DYqZR9DY2cNnCo/o=;
        b=tXk9ALF7tchrZmK6zVA38a7xdIeE/C4aKYiP1SGuF42we+yB18X8iLgOskM0hv9qr/
         ozpiDTf2brUJdueCqo7r5bQbFiaXSbMg5yCteJwLrzOZkaQvE2KPG0tp6hPWw/GA5S5v
         wIWFHsbs1/945nEEf8xqUis0ELCmJE+Q+vC4LCkJAb+3C86NbgaSRaZSTcMVIJZnJjkl
         fuOTUajTyXRUJ5uWOriU/oUR4wIYlDaungfCNdGqDgstcEXbNT4qd7h4Gy6+b1xe0sDu
         CSuM1LbKREB5Rj2hnstNNACMGKEOrqovP0La0vxIccsxmr3Yqnu579tx/7AJrPiBHjeq
         iurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5u2WKpvJkPwpwzBwkS2qywZLUc7DYqZR9DY2cNnCo/o=;
        b=p7xjyJdHVoT9ohqMUKgSfetdyZmrnZumbHlECd/0XylV3C+Tw8rGTzTOWF3wZe2duq
         csnSXd2+SnQ3NpRsRDziBvqEBrRFAwolIOC72iJWGs/dkIK33oF6g+mtVEjd+Q9mOoK3
         Z12OFafWqLi1VkC2r2fAS3X+gvFCShA5WHCB17Z5fFY/b5cK8x6hAJ/q0BMsjdFNdpio
         6eAd33Gtgd58o2qRtcoqDYZpWL6okT20MLd5L+A0sufzSRsfIfLU+h7elxX6T2cblztU
         bsAV3S1ndSJRVYcjNsu1iFgdqIdI1ThAfqA+09p73YpgEn6ZLyNVd6yXfgK5lL3xHpk8
         Bo2g==
X-Gm-Message-State: AOAM533vTpc+fHYSEljz0jZY6OOlbVNzdoHzdDgvLhvWc5/SNP6Xqena
        9H22bhkd8aoPY9uTxYJv7f+j/g==
X-Google-Smtp-Source: ABdhPJzC7nlxFXckFgeTX+8mUDAhcpiy3wXnIASCwgXXMUIo0JmYFWrQ+wiMjL8ysXqls5qRGTQXkA==
X-Received: by 2002:a19:145:: with SMTP id 66mr4764442lfb.61.1600098496882;
        Mon, 14 Sep 2020 08:48:16 -0700 (PDT)
Received: from eriador.lan ([188.162.64.187])
        by smtp.gmail.com with ESMTPSA id f19sm3834650lfs.85.2020.09.14.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:48:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/9] qcom: pm8150: add support for thermal monitoring
Date:   Mon, 14 Sep 2020 18:48:00 +0300
Message-Id: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch serie adds support for thermal monitoring block on Qualcomm's
PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
to support thermal zones provided by this thermal monitoring block.
Unlike the rest of PMIC thermal senses, these thermal zones describe
particular thermistors, which differ between from board to board.

Changes since v4:
 - Added kernel-doc comments to ADC-TM structures
 - Used several sizeof(buf) instead of hand-conding register size

Changes since v3:
 - Fix DT description to spell "thermal monitoring" instead of just TM
 - Fix warnings in DT example
 - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
 - Fixed whitespace chanes in qcom-vadc-common.c
 - Removed error message if IIO chanel get returns -EPROBE_DEFER

Changes since v2:
 - IIO: export of_iio_channel_get_by_name() function
 - dt-bindings: move individual io-channels to each thermal monitoring
   channel rather than listing them all in device node
 - added fallback defaults to of_device_get_match_data calls in
   qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
 - minor typo fixes

Changes since v1:
 - Introduce fixp_linear_interpolate() by Craig Tatlor
 - Lots of syntax/whitespace changes
 - Cleaned up register definitions per Jonathan's suggestion
 - Implemented most of the suggestions from Bjorn's and Jonathan's
   review



