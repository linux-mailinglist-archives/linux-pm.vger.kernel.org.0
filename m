Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5107619D0A3
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbgDCHB4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 03:01:56 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:38366 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbgDCHBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 03:01:55 -0400
Received: by mail-pj1-f54.google.com with SMTP id m15so2555201pje.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2020 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgoPG2/hUtoLFUXRQ/1yO4KtUHw1u4nUyOY++M662ws=;
        b=DMxaQSsRl7CS5NyDSZ/t8wiwCsY0U9XznOGwI73DkxF0e/BmAiM8wcDULkbYIYjGHz
         bp0wxY0EC9dSG7DYy9DO4e302wvfsHWpFvoeOMnN+3HkwdOEHZVZ7QvdtXgE6Ex3EYN+
         FFuvkXTavd5L9Qcf7N43Ri3HKaYtp8L8jDhDbVVbYhMygGZ062EEYR8bCed4dojPSazX
         T/G8oDGon5ov4EUFF33CevTBB0lsE11ygi1WgduLxD5+0MTSdDO4HZLY+jag04reDYHu
         9QWAazfIDfvnjYWTnplrHtoRTKL5qlAbWxZXVFZYQc6NwrXovWy7C4jIII+90qOyOAZB
         6fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgoPG2/hUtoLFUXRQ/1yO4KtUHw1u4nUyOY++M662ws=;
        b=fuPW4Yb5pgYktE5xNfnqxvC3M9anDyy/wmiCNFTeV3SPw9yCRPCAEW3AyioUErx8eu
         DF6k/J/OcFwR1Hoiln/hCRSTqV0Wshlgt3fl+WAX3fYCTRKoXw1/hAru9fmZ6cJCMHx7
         UjtTs0DbpMEpdJlE7n94pUiXV0jt4GtYZW0IkGfvBJfu+SgTxBCOPf0upqp0/hMtgIXh
         ASz4ijY0LTms/RWmursp4HLkZBfZbJ2H3vcqjymYUmZyCKnS29+vS5P5E/dhF1T/53ke
         Ya5RDq5j59g07YMLYXtFLV1YNpcuYkmrtL8Jl/4RzhPdmdiV84W1WEfmrWz3rcpGJBsC
         17ZQ==
X-Gm-Message-State: AGi0Puaw4+nnWxYTcl9pP8gUWZbiJsEgEvn8KpJg7N/uGJQj86i/0tYs
        7ZKGTLZMcJJmm0mZ5plrVGtsRA==
X-Google-Smtp-Source: APiQypKnmLYQGUicA2+nsfU+JyFllI9CLmoA87XeGmP3476ZwWA8qaxKntfwWWuyNHupNQSdYleeOQ==
X-Received: by 2002:a17:90a:ca09:: with SMTP id x9mr8039389pjt.91.1585897314167;
        Fri, 03 Apr 2020 00:01:54 -0700 (PDT)
Received: from localhost ([45.127.44.53])
        by smtp.gmail.com with ESMTPSA id r189sm4749358pgr.31.2020.04.03.00.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:01:52 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, lukasz.luba@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 0/3] Convert thermal bindings to yaml
Date:   Fri,  3 Apr 2020 12:31:45 +0530
Message-Id: <cover.1585748882.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here is a series splitting up the thermal bindings into 3 separate bindings
in YAML, one each of the sensor, cooling-device and the thermal zones.

A series to remove thermal.txt and change over all references to it will
follow shortly. Another series to fixup problems found by enforcing this
yaml definition across dts files will also follow.

Changes since v4:
- Typo fixes

Changes since v3:
- Clarify example by using cooling state numbers and a comment
- Restrict thermal-sensors to a single reference to reflect actual code
  where there is a one-to-one mapping between sensors and thermal zones
- Add two optional properties that were missed in earlier submissions:
  coefficients and sustainable-power
- Improve description of hysteresis and contribution properties
- Added Acks.

Changes since v2:
- Addressed review comment from Rob
- Added required properties for thermal-zones node
- Added select: true to thermal-cooling-devices.yaml
- Fixed up example to pass dt_binding_check

Changes since v1:
- Addressed review comments from Rob
- Moved the license back to GPLv2, waiting for other authors to give
  permission to relicense to BSD-2-Clause as well
- Fixed up warnings thrown by dt_binding_check

I have to add that the bindings as they exist today, don't really follow
the "describe the hardware" model of devicetree. e.g. the entire
thermal-zone binding is a software abstraction to tie arbitrary,
board-specific trip points to cooling strategies. This doesn't fit well
into the model where the same SoC in two different form-factor devices e.g.
mobile and laptop, will have fairly different thermal profiles and might
benefit from different trip points and mitigation heuristics. I've started
some experiments with moving the thermal zone data to a board-specific
platform data that is used to initialise a "thermal zone driver".

In any case, if we ever move down that path, it'll probably end up being v2
of the binding, so this series is still relevant.

Regards,
Amit

Amit Kucheria (3):
  dt-bindings: thermal: Add yaml bindings for thermal sensors
  dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
  dt-bindings: thermal: Add yaml bindings for thermal zones

 .../thermal/thermal-cooling-devices.yaml      | 116 ++++++
 .../bindings/thermal/thermal-sensor.yaml      |  72 ++++
 .../bindings/thermal/thermal-zones.yaml       | 341 ++++++++++++++++++
 3 files changed, 529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

-- 
2.20.1

