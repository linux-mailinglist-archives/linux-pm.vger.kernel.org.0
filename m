Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D20641715F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhIXL6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 07:58:33 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34454
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244724AbhIXL6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 07:58:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F111940818
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632484618;
        bh=GX1knPnuUXedW7zKBIwh7buu4qnYLP5gHJJI8M92Q5Y=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Zzeqh5gJJdmMyeLK/VkgLRaHTF1jHGxnI5aw8/FTdwsgrWGY8uJrB3owDuG+GRXMF
         DF/O/FczK2JwoL535d6WkjMUMU70om6wEVv6Fx0Lfewb8t+lNYOBWJevG6hrpVMmtW
         BEKQHhdlRlniGEBE3BBJyz3Ja3Fn+vPYjec78JtjlPOYi8Xpo7Dtkw2abyPZPF1mpa
         /bM/Td28YtFW3SJfb+nFOos9v2CZupUS/wt0O8OpB4WLQ8U2bo6u7q0ebNmsjuK3Ab
         YXoGKYncGEjRByN5QVsBP7S8+JquRPdrk45cX4pdHm5Iz8A7yDZfYauwtFivamPvuh
         Qpxq5aAaySj3Q==
Received: by mail-wr1-f72.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso7826677wrw.22
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GX1knPnuUXedW7zKBIwh7buu4qnYLP5gHJJI8M92Q5Y=;
        b=Gz5+ZW+EwCiCVgCoYubovqExN8HFbgYtGplb9lqVnYz/D/8u9GoOX9YGAXBqX7er9L
         AXEEtVbXzI8ZfrkAGKuaULrCzrCec7pld+RGWsXMkVSRjpBNK0GMZFOfBDN5pZKKb6go
         DhGqtJy/jb4Aj/HkQdg8y4OTv9XKx0NsTkpJnLkI/ivUPd+Hi3gRPi/CKOHmYaSxK8yM
         eNhBkJApdcWFhTDQG/taxR4yXkmAKjSWbwHB/WGP2eYC9p9dgWVXEJ+9cvW6ZaclCzxc
         RcH43VKOtC046arGHpbU2z3bfoIOZJafco+CZe2Rt03xbrKUKIMFgzvrBxR7hPjeFoL1
         wkPg==
X-Gm-Message-State: AOAM530g5GmKy4c53EpdeM8ljA+v51T+Tzi5Fj9bgfJpVJCfUoqPDWmB
        fZvYDcdAGHbAmWyWzNndSgOouUjreDSOYBT1PTYhOzjLEVzWHRyPdVLdLPQoYguB0syzXoQOu4n
        8EKuGrbBvVyPtMbsD0CfSdxyYnhsjXyUGko6g
X-Received: by 2002:a1c:770d:: with SMTP id t13mr1634135wmi.77.1632484618754;
        Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXJb4pwOnliV1jgLnmbC3kFVKrJQ1Obb4/nVSeDv38AOCQxLVJrgwBjsv3xE4VMIzLKHTqNQ==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr1634127wmi.77.1632484618628;
        Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id z17sm8076664wrr.49.2021.09.24.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:56:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: power: supply: max17040: add entry with reviewers
Date:   Fri, 24 Sep 2021 13:56:19 +0200
Message-Id: <20210924115619.52927-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
References: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Maxim max17040 fuel gauge driver supports several devices used on
multiple different boards.  The driver is incomplete and has few known
issues.  Fixing these might break other platforms so mention recent
contributors who can provide feedback.  This way most of interested
parties might help reviewing the patches.

Cc: Iskren Chernev <iskren.chernev@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Matheus Castello <matheus@castello.eng.br>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da9d5383af04..9f925d0f8a3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11429,6 +11429,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
 F:	drivers/iio/proximity/mb1232.c
 
+MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
+R:	Iskren Chernev <iskren.chernev@gmail.com>
+R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+R:	Marek Szyprowski <m.szyprowski@samsung.com>
+R:	Matheus Castello <matheus@castello.eng.br>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+F:	drivers/power/supply/max17040_battery.c
+
 MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
 R:	Hans de Goede <hdegoede@redhat.com>
 R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
-- 
2.30.2

