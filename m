Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4F49C97A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 13:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiAZMUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 07:20:15 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59344
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241178AbiAZMUP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 07:20:15 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 364903F324
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643199614;
        bh=Zy1mWsJIGrWjngZWHcXr/+Qcbe/NYONm87sNBe72gBM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bugqfrJaZb9GYlBqvooakLl8ZqtCMB0fVi7WfuHPUHeWGUMbvYMSOfPVy+oK5f4mC
         oWYuzqelwLVaDTzkmt4LQcnOFw3RW+USmrcOm/oseMuTt98Gi+/mJSHRYWEN2yrqXg
         X2X103hF8HmCaCP6q+aFPY0LYB5Hx0YPbhUurGCxPCKD+KgWac2ADFObvCyrkK2GyE
         b2Q+xk6ZIMgJDO8mrx20LRIbLp5LJvXZhsYp2i/muV/pr/1Gf0VpM4uazZOiAf44fJ
         eCvyo4wNgtEASDjfZnVbABEyGNtJR42kidhhJsif0hU9gJl4of4BdXRSpgpm3lRyQM
         eiRj5S65ZzFgA==
Received: by mail-ej1-f72.google.com with SMTP id p8-20020a1709060e8800b006b39ade8c12so4806622ejf.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 04:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy1mWsJIGrWjngZWHcXr/+Qcbe/NYONm87sNBe72gBM=;
        b=Kelh1UTyzIfG/X2kMMuN5zkSRQmZwaX5nVV1q9BzQpCIL3RFRDLZh/Km6EQpFEBZ2E
         I1PZ0YpXrdZtMxfyVjLdKz6yoyLV9pdx2UpYgSi6ivGl4z7oA/vPLXySOTkbLHxcAAZj
         zb68nin74g+gnzXmNwpQhjRvr05lvr1MtN4nljOEJTC8EojLhRa4igl4uKXSyGgkIKjS
         3NJw3TCvLM/uqQWJznDPrmGKxgPXr6YDbyybMU3mCMMjVWWg3EQp+ZBoVwVB8l4NEcOL
         GwvmUWPiKUQKJXaI9MlFBCkn8QLYUOT6I9ccfMNFrNqU3Jz3eC0MqAHRcZtEt5HHnmFZ
         5IhA==
X-Gm-Message-State: AOAM5322VP90K8aOkmWuX81pJHpBBeEYZfCIrNcK7Sud2cknrATZQqSO
        VCHkakfBq3Oq7XgbKuG3rIWu1vSxdNk/RPfUZhEnYiIYHBGDNOIEKlAA+mWd0ptQX3qFd7SPAap
        pat3FT75rLJP3JB7Ky+rhVAGv1mma1L7B12WSMWN80aKtQBKe9DcL
X-Received: by 2002:aa7:d9d4:: with SMTP id v20mr25242664eds.234.1643199613874;
        Wed, 26 Jan 2022 04:20:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPDDizeCtdPTrTut64wf6EiUCUrIfWcLoLXQhowkQAazriFsywtmIt6LfySdWJze1nv+DKgt/4Jih/Izt5wng=
X-Received: by 2002:aa7:d9d4:: with SMTP id v20mr25242649eds.234.1643199613727;
 Wed, 26 Jan 2022 04:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
 <164313029072.79782.14492454091056440886.b4-ty@canonical.com> <c4a6d5a4-647a-f80c-e487-a5434e744bae@linaro.org>
In-Reply-To: <c4a6d5a4-647a-f80c-e487-a5434e744bae@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Wed, 26 Jan 2022 13:20:02 +0100
Message-ID: <CA+Eumj6rUZ=e6oOZyRMEEoXn2uh0FpuUQbJaT3rsX3rhXT67pQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 1/3] ARM: dts: exynos: drop old thermal
 properties from Exynos4210
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 Jan 2022 at 12:57, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 25/01/2022 18:04, Krzysztof Kozlowski wrote:
> > On Sat, 22 Jan 2022 14:25:52 +0100, Krzysztof Kozlowski wrote:
> >> The samsung,tmu_gain and samsung,tmu_reference_voltage properties of
> >> Exynos Thermal Management Unit driver are not used since April 2018.
> >> They were removed with commit fccfe0993b5d ("thermal: exynos: remove
> >> parsing of samsung,tmu_gain property") and commit 61020d189dbc
> >> ("thermal: exynos: remove parsing of samsung, tmu_reference_voltage
> >> property"), so drop them also from Exynos4210 DTS.
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/3] ARM: dts: exynos: drop old thermal properties from Exynos4210
> >       commit: e20bd06fc421fba4099be51d3f56b9b1741b499b
> >
>
> I guess up to me to pick 2 and 3

Yes, please.

Best regards,
Krzysztof
