Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3967AEC4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 10:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjAYJvH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 04:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYJvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 04:51:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED28273E
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 01:51:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r2so16426428wrv.7
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 01:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaCPXkD9SZLVsUqcpjkMaFmczW7gT3DS5/0BLDeDcbQ=;
        b=Rw7ZKTIlxluTpzjoIaXA952ZSKYgO45W3mwE4xtZ2FfGN97Q0me77t81wHveCmmSXy
         fob1NruqdEF6M4PvdSIF+Rt9WTqjMYVqZ1q4h8kvtDopvY0OIUSezCIMNTHLHriz2y9Y
         C0ze5VIeMqOwGpNBH3FVctSVFOUxxG5AIr0lFAAoD3IFIznNtNfpqRhwgFktd1UfMFTh
         nxQpJ9G43+ZPw8cN/KC+vJYtiQU6cLW6t6hC3Iv+EuCWzbN1Z/ccKAbdH5ibdc9XD7mJ
         XPKlPFb/LzrDH1m5D4mRAcmBkVEtXxnxIHvgUJkUje4lTo2rA0AFrrcObtfowoRPx5dP
         yO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaCPXkD9SZLVsUqcpjkMaFmczW7gT3DS5/0BLDeDcbQ=;
        b=nbPB7DHx9HmGYM+K55nIqKAjhW65mFTlpTtngY+29JAcVrkPzX0wDr7j+QX1jxKrW7
         +VPPNVTJUCSf8bXefCa+dJHbat6ZOnrRu66nwNb2Sr6lNSG4cpVQMdDIk+vfrbkt9q96
         BJbO5De9uMFPUdll46uWeBu6xRI7Zbvr8c1ZQymkcdhNCj074P8Go5zWUuNn89N1uA3/
         qzqfD6GWiGv1g+B8hq20fU+A5+KbqTSMS8CAIz4H13Bls4O11kDpX/BgmD/60HvqYj/n
         fj/TN3Y++ojvtuOS73CevMWKGX2OOcNu//UZO1ITfRMhHYkUgP6Dd0VlVDMs9KvReHci
         99VA==
X-Gm-Message-State: AFqh2krI9xzXc5sJyFEP5QiRMvfXO9a3DMOAHrBaEsrc1FJaHLH4K516
        JUBmm9Hijc3ua8iR6Kj+mB1d7WVn4iexUu6X
X-Google-Smtp-Source: AMrXdXs4iX7MHDhQ8IpIinu+zVBZH31DduJs8o0yFDjgZqXVRfmzOBdosIhPx5NkKAMeRHZalGCImA==
X-Received: by 2002:a5d:68ce:0:b0:2be:4dc0:6684 with SMTP id p14-20020a5d68ce000000b002be4dc06684mr18346214wrw.7.1674640260896;
        Wed, 25 Jan 2023 01:51:00 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id j26-20020a5d453a000000b002bdf3809f59sm3955072wra.38.2023.01.25.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:51:00 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH v8 0/5] thermal: mediatek: Add support for MT8365 SoC
Date:   Wed, 25 Jan 2023 10:50:29 +0100
Message-Id: <20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGX70GMC/42NywrCMBREf6VkbSSm5KEr/0Nc5HHTBNpUkjZQS
 v/di0s3uhpmhjmzkwolQSW3bicFWqppzmj0qSMumjwATR494YzzC7tour5o6gWjS4QymZHakvKA
 ofG9lr5XTMhAcG1NBSxNdhH3eR1HDGOqy1y2z1uTKI/f4CYpo04rew1KCMHs3ZptTLbA2c0TeSK
 2qT9RClFgA9MhcPD+G3UcxxuNJQD1EQEAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674640259; l=1557;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=6g6r80ja2Rzpq9olLoUbWHBTm7xTpanipH7fHDJFqNU=;
 b=T+CLaw+DkWdzd1nbg+TlT6goz1/RMjgk9CSpiYrLyUOPxR6irKRnar3iyJQAhpi1Xuc2kSBCqW1Q
 JWuB6H0dDOndEuRobKtDdzYA5x9mtavP6YwfwCwZj2Gv6j1r9nf3
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset adds thermal support for MT8365 SoC.

MT8365 has 4 thermal sensors, one for CPUs and the rest for debug/dev
purposes. The CPU thermal zone uses passive cooling device with
CPU{0..3}.

Changes in v8:
- Drop support for thermal zones 1, 2 and 3 as they are used for debug only,
and would cause aggregation issues with current MTK thermal driver.
- Split up 4/4 patch into 2 patches for clarity.
- Link to v7: https://lore.kernel.org/r/20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com

Changes in v7:
- Fix devm_thermal_of_zone_register() error checks.
- Link to v6: https://lore.kernel.org/r/20221018-up-i350-thermal-bringup-
v6-0-c87b9f75550b@baylibre.com

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Amjad Ouled-Ameur (2):
      thermal: mediatek: add callback for raw to mcelsius conversion
      thermal: mediatek: try again if first temp read is bogus

Fabien Parent (2):
      dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
      thermal: mediatek: add support for MT8365 SoC

Markus Schneider-Pargmann (1):
      thermal: mediatek: control buffer enablement tweaks

 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/mtk_thermal.c                      | 108 ++++++++++++++++++---
 2 files changed, 94 insertions(+), 15 deletions(-)
---
base-commit: a2c81dc59d41e92362ab7d41d0c15471ea50637d
change-id: 20221018-up-i350-thermal-bringup-ad386d37056f

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>
