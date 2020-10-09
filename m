Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B22288D05
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbgJIPpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbgJIPpG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 11:45:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C470C0613D5
        for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2020 08:45:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p15so10053885ljj.8
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2020 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78OLxeXd/qqHICuSPZPT2mV0KDo9INE1o8uV6MpD8lE=;
        b=dkhypCfVvytecpOifa9Nwq1YYrAmA87B1xjSGQiJs0fg9sPK8Z4XaCSPrkr8Ln8gpH
         udsmQ+zhWRY/i5AoNcOCRdKyUprefllEuMkHGCAW7AGUPLzf34wL/DQyqkDWBivv0Q8g
         qDtotQBk0yGlVZshk+LB8iF6euDDaCly5LUJQyqPecD6eDXGGAv/QacvNqC5oSm9dgVc
         uU5vKorx3l5JjofTrQM/xUNCZypkqD10aEBjOjCVAdKxwVyNMG8PT6L35W3pYjdnfP26
         XRjq7Sc/aP3rRbHJESKeBa8m7ybky4kuoNm5BNd+r1TYFbT16dPI7E75a1y2Jbkdjtyg
         1mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78OLxeXd/qqHICuSPZPT2mV0KDo9INE1o8uV6MpD8lE=;
        b=HvMQC7gKtZ3E8HfjI022owkHMTbCCchkrSzCs/9YsVgk38UguKDFrhYiTBKh4mY2sx
         4V7bZpn4uF2yUJ/yjlRwWIEAVsuf1u3Lzbrlb4TFdPByuHgTGpgB1DaGuXOiSzDY05ql
         OrnOl1Jxs7QccwezPr9fACeDxoRAzSTOa0FlBIc0hbtN20ctXQfR5C3hXGLK6wZ0scwZ
         hi5Ug0hzoph0jHrB3xZzYo+tz1GrJ382MrMwiKpW9q0Z/ZvyNZk5xcPsqDcly/9VvW/5
         2py+G+wh59/SbKEX7QYi23BMChFarpWgk7TIUAmtV7j4GlPW/P8XwI1yJl+L5l+BCo3b
         Y2pg==
X-Gm-Message-State: AOAM530FKYROJfPKbQ4HnbRP4QFEBCvy67AjVrQBNat8RSZQu26I7N37
        rrcHy3PoaZ6/iCUzqKjZAXGoHA==
X-Google-Smtp-Source: ABdhPJwgnobWRlQ1yWB3wNqiOFb/QLw+U5G2YtchsBVf1l4gzwJxMph8xyyajcLtQWFY1F6BE0c0qA==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr5716703ljp.375.1602258304606;
        Fri, 09 Oct 2020 08:45:04 -0700 (PDT)
Received: from eriador.lan ([188.162.65.231])
        by smtp.gmail.com with ESMTPSA id r4sm1505597lfc.162.2020.10.09.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:45:03 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v8 00/11] qcom: pm8150: add support for thermal monitoring
Date:   Fri,  9 Oct 2020 18:44:48 +0300
Message-Id: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



This patch serie adds support for thermal monitoring block on Qualcomm's
PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
to support thermal zones provided by this thermal monitoring block.
Unlike the rest of PMIC thermal senses, these thermal zones describe
particular thermistors, which differ between from board to board.

Changes since v7:
 - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
 - Use explicit sizeof(var) instead of hand-coding 1 when accessing
   adc-tm registers.
 - Remove buffer read from adc_tm5_init().
 - Remove extra on-stack var from adc_tm5_get_temp().
 - Minor formatting changes as suggested Daniel.

Changes since v6:
 - Added include <linux/bitfield.h> as noted by Jishnu Prakash.

Changes since v5:
 - Reworked DT bindings:
   * Removed qcom,adc-channel, instead it is parsed from io-channels
   * Renamed qcom,hw-settle-time to include -us suffix
 - Re-added monitor enabling which got lost during refactored. Noted by
   Jishnu Prakash.
 - Use threaded IRQ handler as susggested by Jishnu.

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





