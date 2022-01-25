Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5604D49B9B6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jan 2022 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiAYRIx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jan 2022 12:08:53 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50916
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241135AbiAYRFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jan 2022 12:05:34 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B28233F1E8
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130332;
        bh=dSvKZ8AHHeBFaUwfnKaz2QA3fzKNbqhnfNH57EfO12U=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=BOz5CwyW9SZaVU0hdxBLIug4WGNw7Zp8QeR7Qed1cjWli1KLDTH62t/hyQwE6s/sR
         Rsz1a5dGdUHm6XTBoIbXiXMtYx8KIGS+w9GjfK4+d6HdKTns5PL+wYQHiIUV+160ZD
         Y5FvpIyeSXwaj+L5kHWhS//bxTz6oW2we95h/jJLBZd5PbSqR9JE/C8GasI4WgqXVX
         R2P3M3dRh86jjyZ8b43N8XyNniIvU+VdFh2B2FZP7JIHnYg3N8N7fRNA0XUWGAgSWM
         UGvfQEKp1Ppo49x8sZLDUu12IN2ftn2aRJYoRXRURSg3W76XwlNlhuxCAVqxd08H/l
         ktDejOOs/RM+g==
Received: by mail-wr1-f70.google.com with SMTP id t13-20020adfa2cd000000b001d09443ee4fso3334077wra.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 09:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSvKZ8AHHeBFaUwfnKaz2QA3fzKNbqhnfNH57EfO12U=;
        b=hg7zRDfUMCcTTurqfKVx8xoKILmFzy7e9ulr2G6ut9czqwtDPFS1leUrYtbPUxh5Wt
         ChNYeYTagZiqBh7GGAFz1tsPtJ/87/2Lhgs5OuQpfrDTvmsEd55kK2DXn0xSB6bGLPNz
         19J0oHY5+7ctsNP9x7e+HfqvCPPdTa8cpaL9gyaA+Mh48BsheHTBoeu9ySsHbYGQTFF3
         9OWxDyjoJqzhtwuAa94Pw302n2Y1SX7ZF8lUwjraW25a6PmF6kwKzwZfqeED3WnAO81N
         IOH1hrHJWTXugg75xa3H1OL3wCod+wesRipmrKB/khh5ybqC9xTNXmmRSt3iYJM1AYhX
         IlIg==
X-Gm-Message-State: AOAM530OR1ktC3T+MbsQeSH9ikXw5Nj8qUEym+nvKK5qEu4lBYNKiZo4
        u3fHX4LhTmBuIt4rSikpzxl8RStKMOV7J1rjvm4Jielshy9KOIypreU2jp4i7ws8Q3hu2vY1vPq
        iyIbX7ux3rjk00/V4xPYXIbAaSWVobMftTf3q
X-Received: by 2002:a1c:c915:: with SMTP id f21mr3793715wmb.39.1643130332352;
        Tue, 25 Jan 2022 09:05:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7hsKMSTS+c3tg8hbEizs0VHVpl83/TDWW7Ey8qOCr5k/EuXQApytnig+iht+MKtj+BSx35g==
X-Received: by 2002:a1c:c915:: with SMTP id f21mr3793698wmb.39.1643130332208;
        Tue, 25 Jan 2022 09:05:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o15sm1082377wms.9.2022.01.25.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:05:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] ARM: dts: exynos: drop old thermal properties from Exynos4210
Date:   Tue, 25 Jan 2022 18:04:54 +0100
Message-Id: <164313029072.79782.14492454091056440886.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 22 Jan 2022 14:25:52 +0100, Krzysztof Kozlowski wrote:
> The samsung,tmu_gain and samsung,tmu_reference_voltage properties of
> Exynos Thermal Management Unit driver are not used since April 2018.
> They were removed with commit fccfe0993b5d ("thermal: exynos: remove
> parsing of samsung,tmu_gain property") and commit 61020d189dbc
> ("thermal: exynos: remove parsing of samsung, tmu_reference_voltage
> property"), so drop them also from Exynos4210 DTS.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: exynos: drop old thermal properties from Exynos4210
      commit: e20bd06fc421fba4099be51d3f56b9b1741b499b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
