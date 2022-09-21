Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0345BFB9C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiIUJs0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiIUJsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:48:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7447895E52
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:45:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sd10so3940719ejc.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qcQnQhLaO6fGinlzAYyFGlxrfQHdXifdne2D0+nwBo8=;
        b=BtZBIL1KHuomtHqRQXk7130LxJRBG6iEPPC108i/uUc1zv4vtgKCRLoo92bcByFpIF
         vI0ROss4+TZ0r+d44NYvZKCBsnoPZuAaj06CgUJ7JbIbTHS5sVUVr4LxWDMIW18cS9Bl
         pieAUjljj9sMT9Hasg62luiSjPpBOsazARnp17BOwJkZeYBc6tUKcrI+m7W7QL2jDWhp
         nIJDgX1yQ527pxCDbpF1FQo+d5dPY+mc/sTH5NJtyfswXR39RJ+Snip4BC2SultPg1cT
         pcqBmuDE3fTWldjF7WFhFQPW2KMdJTYPj+AwyAWjg0M1DT25+IKfP54wYaJJpaTXj8ph
         E+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qcQnQhLaO6fGinlzAYyFGlxrfQHdXifdne2D0+nwBo8=;
        b=mlfC+jYn7AwdtRqgsWm173oltLXvcsBdldHCZyV6llD2WVaKIUD9xatvMJFzDXk1/B
         qrAir9cCDYLvDanjZox4ZslJc5xz6Nrkk/x0hx1i4bq0gmdPvtl5oMiy5dkHINetsqf9
         +PWveKlQdiegTCfxMxhC9PhwXRqa4g+m4RZgvvHp4KGP/m7JB9uhcvRlwQ22LWJm98WY
         C1PzkYspQnba73DmPFjZO/Bij/oUXFLo+zVh/qnB4JyNLTlyLaLj1uB9GKZMWb2MymGA
         xuIu2yLmF9vkJvD506plyU/7AsDXkjagPEtoAl12YdN6dgQ/z/6hDudRXyVVKCu7DRG+
         JGzw==
X-Gm-Message-State: ACrzQf3+8ipFnWiBHtZs7OqHP1FEWk8d7hNCEycvVf9TbqLfHzTFv8rN
        4hqShPQCS+m6Wk4jA8oCFBU++fWOOpbnV9cqbsNfsQ==
X-Google-Smtp-Source: AMsMyM5SFTgTYiX8ufQU/7T9uAxbJb2nQtH8wwq24aVCveMh7Phf3u4mkG9wFMawfgPj/2o3XFsj+LE+O93wVevFl1c=
X-Received: by 2002:a17:906:fd8b:b0:779:dcbe:3a9d with SMTP id
 xa11-20020a170906fd8b00b00779dcbe3a9dmr20557155ejb.235.1663753505689; Wed, 21
 Sep 2022 02:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080757.352021-1-bchihi@baylibre.com> <20220817080757.352021-3-bchihi@baylibre.com>
 <716d6471-f0e2-489e-5f9e-9e38e9e7953a@collabora.com> <CAGuA+orxfcycwcUMpLe+dkjnXPQkELQsz0vBggGKTQ04XRGc+g@mail.gmail.com>
 <2073b6bd-a4bd-4ab5-300d-2ce989e25d5f@linaro.org>
In-Reply-To: <2073b6bd-a4bd-4ab5-300d-2ce989e25d5f@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 21 Sep 2022 11:44:29 +0200
Message-ID: <CAGuA+or40GSH2QvVw033+KsGC-B9D6nRYj8zXvTs91iNDqgr8Q@mail.gmail.com>
Subject: Re: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for
 LVTS thermal controllers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, rafael@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof, Angelo,

Thank you for the suggestions.

I tested this (below) and it worked without any problem.
"make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml"
"make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml"
Should I keep it like this and submit it in v10?

[...]
nvmem-cells:
  minItems: 1
  items:
    - description: Calibration eFuse data 1 for LVTS
    - description: Calibration eFuse data 2 for LVTS

nvmem-cell-names:
  minItems: 1
  items:
    - const: lvts-calib-data-1
    - const: lvts-calib-data-2

"#thermal-sensor-cells":
  const: 1

allOf:
  - $ref: thermal-sensor.yaml#

- if:
  properties:
    compatible:
      contains:
        enum:
          - mediatek,mt8192-lvts-ap
          - mediatek,mt8192-lvts-mcu
  then:
    properties:
      nvmem-cells:
        maxItems: 1

     nvmem-cell-names:
       maxItems: 1

  - if:
    properties:
      compatible:
        contains:
          enum:
           - mediatek,mt8195-lvts-ap
           - mediatek,mt8195-lvts-mcu
  then:
    properties:
      nvmem-cells:
        maxItems: 2

     nvmem-cell-names:
       maxItems: 2
[...]

Best regards,
Balsam
