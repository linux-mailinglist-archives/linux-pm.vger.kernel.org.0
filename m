Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13149736E
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jan 2022 18:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiAWRKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jan 2022 12:10:45 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43086
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239108AbiAWRKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jan 2022 12:10:44 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBFE23F17B
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957843;
        bh=9aUVeDHijgpk/gPdmhnxkt4h8TZ5fsPsv2xLl017ipQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=HBF8rJH647PAOgyAXPxRwd4FzBWJimgJQINeSKLo1u4WZtdHM+BHlNHJ7mIaP6alM
         oBZyoL8d/hzo6Ga+njWrakX+T8c4bcqlAoXGlA3iPyXz79mUhB7F2Tj3X/7lsDqikM
         xv70tsNCkGJj9JIdMgvPh8UnS3s/9q9zmdysgl9/r7ZfwLsJS5N22g8uqC805rnfth
         TLb4N+t7GfM+IMDFhP+lOwMjbraH2fGwzID9GUHimYbrTpcHRiH7MWUQab4nWytD4y
         pxrR1aPy6GG59y7xXSdrhJX9Rd5fbrH3cn3O4fajQd0aJjyz0Znl9gNndhGeYQiDUj
         ATQUfg/U20Uig==
Received: by mail-ed1-f72.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso11504199edr.21
        for <linux-pm@vger.kernel.org>; Sun, 23 Jan 2022 09:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aUVeDHijgpk/gPdmhnxkt4h8TZ5fsPsv2xLl017ipQ=;
        b=O6lTFWMYqJmEFeyZRfmIq7TXtfMnVbVrk7nlbedh6lAwCF5yh5DT3qiPdRFmvVji9Z
         2XvfW3CStHEv6Km12I3f9KXrjgPV8048t9i13QuA5nSOF2OZXgtWvbxda0wmwaIaGQTH
         7S8yXkk31/j018MZz0m9l1nbeM7Xb8pkupUIZmaZrWrbYarNyDkt4qrq0pL7Z56e3WLu
         Xh0azmAE0PMoDjyNTTXy/yS9XNLq7BNroYEgkb9KRqhta2xzCzHhrwkFutIJJEyTwgJl
         bYmbNKSvsMfFwopK4BR9a5gYil1twiSbwGBBA+SlrEc7LFzehIgI4x2q/9r/SmNpcD+w
         wvUw==
X-Gm-Message-State: AOAM530wLVrQdBceaIfMn+YwHxw/qz2c4ydonAFV0mfcUPfXRSYi8MB1
        3HXGnFq854Nwtbdg3nJjqFhPARI69v4/KcVGwF2r+b8c7L7ymYFC7roRkLUXHakG8L0nhMdvQQ5
        4LlzYoSLCsBasrlh+S1RXAaHXaO202v6d5nYG
X-Received: by 2002:a17:906:4ccb:: with SMTP id q11mr10028602ejt.398.1642957843643;
        Sun, 23 Jan 2022 09:10:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMefem0jCf3PJq8lnGfLau04Ms1Hd+SIUWXl64m0Pg5L2zvBjINugQgs92nw/gH+x7IuW1rQ==
X-Received: by 2002:a17:906:4ccb:: with SMTP id q11mr10028597ejt.398.1642957843504;
        Sun, 23 Jan 2022 09:10:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l2sm5208665eds.28.2022.01.23.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:10:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/4] ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and Rinato
Date:   Sun, 23 Jan 2022 18:10:36 +0100
Message-Id: <164295777264.25838.2090071538223607341.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174337.223320-2-krzysztof.kozlowski@canonical.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com> <20220111174337.223320-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 11 Jan 2022 18:43:34 +0100, Krzysztof Kozlowski wrote:
> The newly introduced dtschema for MAX77836 MUIC requires proper naming
> of extcon child node.
> 
> This should not have actual impact on MFD children driver binding,
> because the max77836 MFD driver uses compatibles.
> 
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and Rinato
      commit: 8d6f5af71e2ada6214df028441d479e1925e105b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
