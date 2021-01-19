Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2756F2FB189
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 07:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbhASGXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 01:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391312AbhASFte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 00:49:34 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761CEC061574
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 21:48:54 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b10so20561377ljp.6
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 21:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaDAnz5PWlBb3FvhcqwZjvy+ViqKXKxtEUXuyfVUfG0=;
        b=qGROhCgSdGzhZsNXSPaDyyoY6c8nRMnGYynnd1NPmCMGf8MWrc9+z7jJRYietSod5v
         Snkh4Nf8Z9dt/m5G2oPEQr6AwPgKR7AVgv0VbTKRTvBuvlcbXdi/qNJVGBmU0TgpOKIM
         COWa+4zGLbkNGGo+htqIpH8jr9dxUk20sIgO41FsyHjUzVfvjhieK5qLmI1PSL/ElNMF
         a/Uukm4BmE1VTSJuD5PxkxJ0hRDoOLUTDalZI2ew5VHX3AQc/1UY61vyDk+hGQs1JFg/
         O3DoPdlPpciL7SJD6/7wkyl4R0o5O+UkvNNFGnvEnB1Sp6b6ScuH1g8hKnuGL/99m3ng
         EkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaDAnz5PWlBb3FvhcqwZjvy+ViqKXKxtEUXuyfVUfG0=;
        b=aUw9mqtglwyHXOf7z7akAyGprdayqYslCPlk/f3hi9lpKg1xE5/oo7auw3ziPgRGqz
         EwNDubLqiAAj2vS+s5/bowPmgVBRccUkM5vYTD53zGgo4qxMIy5EWTTXkXHTToGKoJ6S
         rupr5vRrQGALSoRsoCiqtG5s1CQI9Kk5XZisqxaSJprN0VQNlLCH2Qmt0kpfSb/JDrqT
         Nhnrw6Bx3gloq0vgfmF3VnaZI9ppAyQz4HhLzxTdTbkVcLu+u2GRKnuWO1156qGyBRLM
         5jlJAmNLqMhMJazSaxPnJcozzyGxuut6q3Mef2N+NftxlvNohl6VBPZNq6r59qteVPE4
         g+8Q==
X-Gm-Message-State: AOAM531U8PjWEGB7DnMVF2a5kjxL4roawBBI8dgokImCX3Zp4BLWKXKd
        39luPQeegFH57iUJ9ZXsjzPRVQ==
X-Google-Smtp-Source: ABdhPJxr60rrFyHyqXKzidTuEJ8xN9YnUb2PM6mzzejfg9XkbpQ173bQfYl83EyRrbi0sghCKO6bMA==
X-Received: by 2002:a2e:8691:: with SMTP id l17mr572169lji.408.1611035332781;
        Mon, 18 Jan 2021 21:48:52 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.65.64])
        by smtp.gmail.com with ESMTPSA id j3sm2168207lfb.29.2021.01.18.21.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 21:48:52 -0800 (PST)
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
Subject: [PATCH v12 0/5] qcom: pm8150: add support for thermal monitoring
Date:   Tue, 19 Jan 2021 08:48:43 +0300
Message-Id: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch serie adds support for thermal monitoring block on Qualcomm's
PMIC5 chips. PM8150{,b,l}, qrb5165-rb5 board and sm8250-mtp board device
trees are extended to support thermal zones provided by this thermal
monitoring block.  Unlike the rest of PMIC thermal senses, these thermal
zones describe particular thermistors, which differ between from board
to board.

Dependencies: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-5.11-rc1

Changes since v11:
 - Drop io-channel-ranges from dts example.

Changes since v10:
 - Rebased on top of ib-iio-thermal-5.11-rc1 immutable branch, with
   IIO-related patches picked up by Jonathan.
 - Changed thermal zone device tree nodes to use -thermal suffix
   following the schema.
 - Reordered device tree nodes to keep the alphanumeric sorting order.

Changes since v9:
 - In patch 12 add comments to the code as requested by Daniel Lezcano.
 - Change copyright comment in qcom-spmi-adc-tm5.c to clearly note
   driver history.

Changes since v8:
 - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
   tables support
 - Simplified qcom-vadc-common volt/temp mapping code
 - Implement suggestions by Matthias Kaehlcke: message formatting,
   rewrite comments, remove unused variable initialization.

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


