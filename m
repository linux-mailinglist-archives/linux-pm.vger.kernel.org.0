Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2AF169F02
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 08:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgBXHUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 02:20:32 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39018 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXHUc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 02:20:32 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so3765456pjr.4
        for <linux-pm@vger.kernel.org>; Sun, 23 Feb 2020 23:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pp4OJKlkTUP/JKWBsfGX5IGPygvYeWUCLyYPIlFud78=;
        b=IZOmGdk3jvbALg78q+Ogcc/os8rR7kNvGziTpMuqqxVshDSb7T0/n5kLOgxiYvrD6L
         FsaIT/opnfyAbJqctDkl/nSg+/poz+r/XpgrWrCj0upAr29DF+L7hRl6W4XhxLudNiZy
         mQLaah2Y3ds1XjtYfOSm9hQLGA8Fp+1cwAg+ZoVnIAJkSf+i0RN6yxwnEfj9WAoj1QP9
         3cCkaSDjwRYAy9gTaNUU81Rp+oHJn4ppYGFivh0T0knTRTQnKpNsuGoto8fVCwI2NNKS
         N78wCh30Yi+vNrdi6ujUkU1bDTZ7+FjVlQRwtYpE3nNUngzpsG5Jp9vpFUfwl1Z8H12w
         8FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pp4OJKlkTUP/JKWBsfGX5IGPygvYeWUCLyYPIlFud78=;
        b=F4ezeEJFhzh+7H4pCxnK+jh9Zki0uS96WIW2haY1dDfMGgsHg1nNpg+Ni42jKymDJ/
         /zsVcZJwMzVNFhEEy6vBI5ynr+KVrUeIS2AWLl1/mppo1lJAlNMzsw7zva432NoaUPdS
         Z3StJQsvDoyO/Buj3Of5W2v1UKxBgVTJd+Nlp7bO4DlAubyarW6r4N4xPWAdjaARD9UR
         yc53PQ1PPUp66ceJf1mQY1s67s1J/+uRm59ahW5nQzC7czUSDz3YAzwiFkpgVXJHWHfs
         6zAzCR+im189TSgMT1cwH01oCEfKBbDqa/s2wulunDK2RXyyFvc2WuY2C7EOy99NdwQr
         V9eg==
X-Gm-Message-State: APjAAAX1aEguY9QxWoKL9WXWX9fDbf2Tp5KCTLL3qj+XYip5+oJ5S9o5
        KQQp8JNPu3DWQhDmcVezOSFLmQ==
X-Google-Smtp-Source: APXvYqy3jXvJE7VyZtpKH6rIFhGNbXxpgKh1xaZZt9uPKJ3Z6xLRb6oa+wLz4XgROfrFkfGKGYes3Q==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr18082228pjb.83.1582528831644;
        Sun, 23 Feb 2020 23:20:31 -0800 (PST)
Received: from localhost ([45.127.44.57])
        by smtp.gmail.com with ESMTPSA id p23sm11452767pgn.92.2020.02.23.23.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 23:20:30 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH v5 0/3] Convert thermal bindings to yaml
Date:   Mon, 24 Feb 2020 12:50:24 +0530
Message-Id: <cover.1582527752.git.amit.kucheria@linaro.org>
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

