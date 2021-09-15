Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF940C0EF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhIOHw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 03:52:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44958
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236739AbhIOHw0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 03:52:26 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD6A840268
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 07:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631692267;
        bh=3UuhH6DfF97G63xEabBbDhstzQxGbUL43IU2MzmFk4s=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UYw9c0j9eac3HCzWQmm3jQ6gJ18zP+LHIMsuEOOoIsof7k7nFQdee+EYcCGmN2D1N
         nijS9C4zfkM7hNnbEGnEBrKtcI8PnaBWg4WdS91ztGlhCnCEdViv7rqiP306JrbZKY
         XGBpobvadbOYK2Qnqjt3C1IZAU7NZwkwMq8Z0y8JB3L4+QATTyZOqHHD74LON1QvSP
         3URttKG9mkhakfKFKQhpnqeZ6VD6e2NbyQwi+TpDFoY7SpCoJFSdXhD7jl9Jt4eIVX
         CUX7RP9Lk/O3KrrpQM4jU7oGGxNCMPDR2dRq2LhKoeFcecpeZJxesqX9IcpPCAwDEG
         9L1VfxEUFUs5g==
Received: by mail-ed1-f69.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so1097280edy.14
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 00:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UuhH6DfF97G63xEabBbDhstzQxGbUL43IU2MzmFk4s=;
        b=K/uQyhkvSWKCUFu7UCNj+EYno1vWwdds2F6KuNFuqZnD/Ar8nJRk4MOFKorJ5eFYAQ
         RxDH2WTqT6UgSChx7AGxp4oHEBwAnQ/+YCjUvxgZ67tyoZA2fVAMX33SFRVX59iCHztE
         JIWdvNSMaqUIQRNX0WcJEJLO4UAGeDRwg4dbva6y8Ep5LT2xR3HckN7kZ4xlSjJCH61E
         8JuZ0RvJI97S4TWntQqfJWESUYqpSh7Wscr1pNjn6MUUysHIdVf0hS/RXXz8+jBUk4RG
         j/5c0/H9g1G9Iv2AxBrnOORZnj2YNMEFUfo6d1ULfIuvsZ4KugvXT3k9xZhU/iUJeIAb
         f3RQ==
X-Gm-Message-State: AOAM530F89AmFfgYwZ7d4dK77PbO7fWQHAmQeK7SeXzagG4sL1/M4Wr6
        IiO5GTOA0CDDFtbkUpFg1MKjvGq27GO3onKX886HScSOoWctyPCmM+FBZSLDyiAFmkWLH1vLa5F
        AJTQuqBpUn7r41Fp/eAmSVGb1TS8VOBH8RBvs
X-Received: by 2002:a17:906:9aca:: with SMTP id ah10mr15858278ejc.471.1631692267470;
        Wed, 15 Sep 2021 00:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ3105Y/iQTlTiucEVyhs8Y5dCC+GLZzdNSu4AJG3m4GNgDvfkECg7+b3PmxdlHBXvw0U+bA==
X-Received: by 2002:a17:906:9aca:: with SMTP id ah10mr15858264ejc.471.1631692267342;
        Wed, 15 Sep 2021 00:51:07 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n11sm591922edr.51.2021.09.15.00.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:51:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 4/4] ARM: dts: exynos: align PPMU event node names with dtschema
Date:   Wed, 15 Sep 2021 09:50:58 +0200
Message-Id: <163169222223.16372.15525688455985156121.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820150353.161161-4-krzysztof.kozlowski@canonical.com>
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com> <20210820150353.161161-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 20 Aug 2021 17:03:53 +0200, Krzysztof Kozlowski wrote:
> Use hyphen instead of underscore and align the PPMU event node name with
> dtschema.
> 
> 

Applied, thanks!

[4/4] ARM: dts: exynos: align PPMU event node names with dtschema
      commit: fb9b199e562d66af90f61d70eb737fa5e4deac2c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
