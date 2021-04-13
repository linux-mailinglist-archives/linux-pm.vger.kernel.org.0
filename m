Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED36F35E21D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346445AbhDMO6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 10:58:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58496 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbhDMO6u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 10:58:50 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWKUn-0005E6-UA
        for linux-pm@vger.kernel.org; Tue, 13 Apr 2021 14:58:30 +0000
Received: by mail-ej1-f72.google.com with SMTP id d6so5142035ejd.15
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 07:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXFmnreZUFvpdeZOE3YRnkGXbB2aVTyeo59QFjsyW9I=;
        b=cyrH8GKa34qRQP9MKPTcGtadVeVpd4BPKET+8bSXqmMdd814vpoLLS/D0ZjKCjN52+
         2fY3oYJ6vVO0F6h2uU14eqCg64KSqsp4JqxI8pyQ9EQOt/4RkMYhng18V2NDcOHyjDT0
         fUqC0o5RGNB+oHtZTFdU26PC3btY+TrJOkNk8nuZ7JCHuPQ6Ut8rfHILL3QW9a+v9IAL
         yy4ERHVf7+1MVfF0tjU14VSIy9ounkwIYP3Yiizcr3l/IBp4KyD0SwqBY/1HbS5USTvh
         fp+MT9UlrhCG+g+9/DqYkhj6H4ynpmCaaQ/fxExobiQn533kQi4wUwmIMqYvOVskGtsH
         WEAw==
X-Gm-Message-State: AOAM530H1C7IqgHi6GAr0xDD4W5jYrT8SSLQHn+dgapbPyiswul82jcj
        wamikYUs4bFuaTonrNaCine6Zuon2u7o2GW5oDItN8Jg9+XzNiZPB1wNlqUfv6kMx5ftKayuE6s
        LUzjEukWb2IQAVPqiEhVM75QAxBNO3kkJzOjV
X-Received: by 2002:a17:906:4d17:: with SMTP id r23mr12011595eju.134.1618325909552;
        Tue, 13 Apr 2021 07:58:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu/pDogwwsc/dyeGnbfzo8QIv9u+6fKHlBwiNUQ2rfPdi8E5CISH90Pct1hqzIndiuUYdomw==
X-Received: by 2002:a17:906:4d17:: with SMTP id r23mr12011590eju.134.1618325909449;
        Tue, 13 Apr 2021 07:58:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id p3sm4395217ejd.65.2021.04.13.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:58:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: handle clk_set_parent() failure
Date:   Tue, 13 Apr 2021 16:58:23 +0200
Message-Id: <161832589345.71964.47710078429514068.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407154535.70756-1-krzysztof.kozlowski@canonical.com>
References: <20210407154535.70756-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 7 Apr 2021 17:45:35 +0200, Krzysztof Kozlowski wrote:
> clk_set_parent() can fail and ignoring such case could lead to invalid
> clock setup for given frequency.

Applied, thanks!

[1/1] memory: samsung: exynos5422-dmc: handle clk_set_parent() failure
      commit: 132c17c3ff878c7beaba51bdd275d5cc654c0e33

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
