Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6635D169F24
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 08:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgBXHZn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 02:25:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39345 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXHZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 02:25:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id e9so3770796pjr.4
        for <linux-pm@vger.kernel.org>; Sun, 23 Feb 2020 23:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pjmsw2c59UnP8bQTcR0v67l8n2Do0c3ipHd2w0BLgDw=;
        b=UAvCFsUkzi4NHTluHdWcn5wDT40ImYUMrkXDGvP+rlkh34aMNX7VR3G6cWJsG+C5kv
         VBXTaD07DS2Ntcv58V5c1jaoS+2kQSHxDDmLxOZ4MhBqVL+l7ozf3PlwOJYLy9Axl8QC
         raFopR/h6T4KN2OeT8yN+bdaxAvNCupz0mfDAv5/sdtuZjq7mSeAPkLD8VokSpzm3FSb
         XlfPvxQm2Rcbvwm+AusMJbH6xWMYEGJCldE481V0edXktO8xO3HyvQgC/Ni7+Jtb6wZh
         3MJ2Y9HI9QOABI4QjFkzEWy5Tglwf/5nGxtvr+SywIIkbcHru4PQnZ5rnMLXFcBXTTup
         ePPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pjmsw2c59UnP8bQTcR0v67l8n2Do0c3ipHd2w0BLgDw=;
        b=cWAlCZyWp9gXEot9eUighbkDba4HEfUbOTUXnyD340d4NrmOT43j7hUxl1Tl7rhSnE
         UYP/8KB+LfT6EwfaEEXN/nm672jb3pBKbiu1DfBlD5BG8+e3NAl2XmQg00IIlkDkJmeP
         RQ22xsUy3GzU8/hmqEyitR0ZSjKWVqbpcgojL5csI6vHvUXs5/PzS8365iSRYP+Boo2A
         Ik1jUgFdPMRIBA9nhHGCzMEt7Xyei35BKBm3QlSZQlIRZEtHbZA07828x988o7HsrSY1
         vO+tZ6zWaHWhJqdLIh4QOf1CSIj16xBdX6Txc1Y+NG/1kWEtHE2ZV9B2F8i/mTdLgZjO
         OMFA==
X-Gm-Message-State: APjAAAXUUsCoSE/Y7PEkuElXK7aIiQtkkhb/NNmgnT5pgMKLTuSaGJME
        jA4K4emW7P3yFPFdZihUtwzqXA==
X-Google-Smtp-Source: APXvYqyuEjegHI+TTFtAPD15xyrk4kjVIQfTd/OCLyY41lTTSOjgFzLRwSNoHBoQ46H6DvZt+SXzKQ==
X-Received: by 2002:a17:90a:d801:: with SMTP id a1mr19064921pjv.34.1582529142409;
        Sun, 23 Feb 2020 23:25:42 -0800 (PST)
Received: from localhost ([45.127.44.57])
        by smtp.gmail.com with ESMTPSA id e6sm11360185pfh.32.2020.02.23.23.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 23:25:41 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH v1 0/3] Convert thermal bindings to yaml
Date:   Mon, 24 Feb 2020 12:55:34 +0530
Message-Id: <cover.1582528977.git.amit.kucheria@linaro.org>
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
Since I was learning about YAML parsers while creating these bindings,
there are bound to be some issues.

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

Please help review.

Regards,
Amit

Amit Kucheria (3):
  dt-bindings: thermal: Add yaml bindings for thermal sensors
  dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
  dt-bindings: thermal: Add yaml bindings for thermal zones

 .../thermal/thermal-cooling-devices.yaml      | 114 +++++++
 .../bindings/thermal/thermal-sensor.yaml      |  70 ++++
 .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
 3 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

-- 
2.20.1

