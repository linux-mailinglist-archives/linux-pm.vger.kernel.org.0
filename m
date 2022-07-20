Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78D57BD95
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiGTSTl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiGTSTi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 14:19:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5B67583
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 11:19:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z13so7717914wro.13
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NY9cJreJS+8dTIRGmrgidqYE3b7KxSEOo/TVdrxG4d8=;
        b=HeBQ+q8vwmoOwDim0LlmLDOVVnf5cKWvW0P3ll0FGcUCRb7AxtuiwiFdCqRdELVcHf
         u2+sBwsBRkKubwJrcwmj6RLl+gCNPmN5HdZ9nV52WUPxLFrpIGWnmnxhRPMY51CYzK87
         vDrGNNisSkftJhPZ8zboSC3K9w2zazdIg+620CqaxA8+oTw958VJwH4orw87YYz+QGp9
         Pw9ruxLn85LfjfXwo8EHVacwXBtDJB5rTE1o0ctARmKCdQidRUYTdgkp1ZMIVRVGhNrf
         U2ooXPBg1xW/EA56cugFZEEsyQUyZIZg3BAIcgE2z+1QnY9GF48RMDUMX5vPninvfaHO
         GYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NY9cJreJS+8dTIRGmrgidqYE3b7KxSEOo/TVdrxG4d8=;
        b=vmfLcqlebusYf2cAsS3MzJAoswVoiN1lGGCw411pC4en4RFv8THDMGsxx9aseO5nT/
         UeZqMIOHoSSPdGkKf/7BecBAjdk3/RMNKwJIFpCw7ZZY0DXpeKABDSbGc1msZnFSLyAY
         rBhCqbNi/I8rLHzdv/btYj9MijZJIpFDZ7QA1anTczbfSKE484/430Zb/5yZfPu7gq2f
         xQEaghqg+ismB/gbForITfdits1MwsHHZTewP9owscWECOd93Mu1j+zTvNMQU1iqcaan
         PexnPrzb1KQMdRo1PKR71nx3TxlDZ5MmR/CjJ9EsZZTMKeFtujH2j1cRPiRwQVNj2ygk
         R9UA==
X-Gm-Message-State: AJIora/T5OJFSzuFoX8Rm86QBX/W3oenaBi6syha8GJnH6fD+Cr1xt6O
        3RkEPWVuNdCiKZC6sqXc/o8mcg==
X-Google-Smtp-Source: AGRyM1uOSnTxFw11JEDWcRNpBDAT1cS/8w7zBzTLAlxFhmOCrLYwrxJYzMip4iynsppCZeNaBxrrjg==
X-Received: by 2002:a05:6000:156e:b0:21d:c50a:7cdb with SMTP id 14-20020a056000156e00b0021dc50a7cdbmr26493839wrz.16.1658341174422;
        Wed, 20 Jul 2022 11:19:34 -0700 (PDT)
Received: from amjad-ThinkPad-T490.home (2a01cb040613180084408ac44a1fa242.ipv6.abo.wanadoo.fr. [2a01:cb04:613:1800:8440:8ac4:4a1f:a242])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003a31d200a7dsm3400093wmp.9.2022.07.20.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:19:33 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH v2 0/4] thermal: mediatek: Add support for MT8365 SoC
Date:   Wed, 20 Jul 2022 20:18:50 +0200
Message-Id: <20220720181854.547881-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds thermal support for MT8365 SoC which contains three
thermal sensors.

Note that the V1 [0] was originally introduced by Fabien Parent [1]. He
requested that I take over this patchset.

[0]: https://lore.kernel.org/linux-arm-kernel/20220530183833.863040-1-fparent@baylibre.com/
[1]: Fabien Parent <fparent@baylibre.com>

Amjad Ouled-Ameur (1):
  thermal: mediatek: add another get_temp ops for thermal sensors

Fabien Parent (2):
  dt-bindings: thermal: mediatek: add binding documentation for MT8365
    SoC
  thermal: mediatek: add support for MT8365 SoC

Markus Schneider-Pargmann (1):
  thermal: mediatek: control buffer enablement tweaks

 .../bindings/thermal/mediatek-thermal.txt     |   1 +
 drivers/thermal/mtk_thermal.c                 | 191 +++++++++++++++---
 2 files changed, 162 insertions(+), 30 deletions(-)

-- 
2.37.1

