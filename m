Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03C480B65
	for <lists+linux-pm@lfdr.de>; Tue, 28 Dec 2021 17:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhL1Qjj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Dec 2021 11:39:39 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39404
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236067AbhL1Qjh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Dec 2021 11:39:37 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 513703F07F
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709575;
        bh=HGuU3G/CmacYFKUeANclkwpOH3maXtk12cKoz5IJaT0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=oxxN6eSWF7AXk4UAgg/175iDP8hmfpEDN1ZnkOItg3GnAAV8mg/Y7D7sOPyrjzRcC
         6m2XhJuKSYgwRwLLWIf+JbP4BVs/31EIC9Cn1ut+1WkTN6RrtLdfnnASUGcl1omKmN
         HDGk97b8wIj0V5RoFUY0kipcX61vKZjCnvNU5EAdxH8ErPQxZAX1dB2BZuHK74W18i
         w3+YVLp9WgODqPwAdS3pemiG25UpeceDqBDmJl2uJ4JkhJhXVwUXaDCuw5yQFB1+FJ
         4daaf9eTSGy0o9bZd/+fNE+sa+2quqmfuBpMXqbhFphcInc06uPdnUOeKGQr5v2Lwf
         dfeOkC/jDeElQ==
Received: by mail-lj1-f197.google.com with SMTP id e7-20020a05651c090700b0022d70efe931so6238572ljq.10
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 08:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGuU3G/CmacYFKUeANclkwpOH3maXtk12cKoz5IJaT0=;
        b=seO2tnP9ZPrcC3p/p5RDq5d8Y8XlAo6YyBvkkv8+fCC7I5DoZHqcdJZqMrNF/JgCG7
         ehVKMBGVbi5OwSW5fwyn4x/b9nXVQVtdSXZZCl47rG4EXKyl57eoY0U/axs66qlkUGKb
         EGy32zhwjk0HkOj/x3ESUopMXp9I/uw5qaVrSfhTkJhsu+ME05f6SfhvCs0s56WyO+sh
         jr6LSV2kw9JBHMBAU0MR3bgnreQ2J24R1mz+etIdafT2wYEjRUI87Ijo0UVdly1HAXUz
         fxoMaBDWYkeSx+oc+/EDBNLxkoep0w2B+vnysBBIiGwFe69u4vYovuWczH7y15BF4ztU
         Rv0A==
X-Gm-Message-State: AOAM531pC0Tcoppov7aBfM+LrcNMHy/YzMdnsZcSQDiVIHsBkwM7JG8c
        72PnHjDbw269TFj2okMUf2NWfjwL6HeBeAIJN5+WZqVzjdIe4dEPB6wiAf4XBmQ5qfdhh4aO2Lg
        juwlqD2BByMZNQGzkV3vwDUg0YdasaLweeUSV
X-Received: by 2002:a2e:894b:: with SMTP id b11mr12168954ljk.22.1640709574631;
        Tue, 28 Dec 2021 08:39:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2R4OjcmDuYU5dFgZyIsJA+br3TJLYbRM0hsPoVHlotH5EqETNcXzL7aQK6WUoOnCtKUrTgQ==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr12168917ljk.22.1640709574002;
        Tue, 28 Dec 2021 08:39:34 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d3sm1972876lfs.204.2021.12.28.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:39:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/4] leds/power/regulator/mfd: dt-bindings: maxim,max77693: convert to dtschema
Date:   Tue, 28 Dec 2021 17:39:26 +0100
Message-Id: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The final patch - MFD maxim,max77693 bindings conversion - depends on
all previous. Therefore this could go via Rob's or Lee's trees.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: leds: maxim,max77693: convert to dtschema
  dt-bindings: power: supply: maxim,max77693: convert to dtschema
  regulator: dt-bindings: maxim,max77693: convert to dtschema
  dt-bindings: mfd: maxim,max77693: convert to dtschema

 .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++
 .../devicetree/bindings/mfd/max77693.txt      | 194 ------------------
 .../bindings/mfd/maxim,max77693.yaml          | 139 +++++++++++++
 .../bindings/power/supply/maxim,max77693.yaml |  70 +++++++
 .../bindings/regulator/maxim,max77693.yaml    |  49 +++++
 MAINTAINERS                                   |   3 +-
 6 files changed, 365 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77693.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml

-- 
2.32.0

