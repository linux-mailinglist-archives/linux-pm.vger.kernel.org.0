Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA5A1B81BA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 23:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgDXVsd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 17:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXVsd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Apr 2020 17:48:33 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EFDB216FD;
        Fri, 24 Apr 2020 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587764912;
        bh=/Flh79nNPN9TxKaLGme5W4hkOaqTdEn8R2DTFhqf+zo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e/0CtyihQizoahvum6szmpYpGJtmSQIFkuXvdTrSS670sqIcGAmPFlZBa13+XObeU
         t5XXxRvntjTYQnV2UTSrjXNUlYkGaQ1cnNGt9Cr7bqpXwix+wHJlIRYot/ECRCOqtp
         0oEGg5rsaQFqjTsESmkfFNteBnTm/ShZI2vJHdB4=
Received: by mail-qt1-f170.google.com with SMTP id h26so8960045qtu.8;
        Fri, 24 Apr 2020 14:48:32 -0700 (PDT)
X-Gm-Message-State: AGi0PuamCWNZ0OxHIbF2rkeNIiu4ALWzz2B36LTvP5BHK2IqJ0Qr2krF
        7btCxDWLJZz7yT3wSq1OMux++ZzAdHDQKc+KJQ==
X-Google-Smtp-Source: APiQypL4JJo4fnsihFTOStqlmUkReE8AtASTbdGhFb4Wqybx4fc8PwdXXMT6vIbr014VWfZHaMQ0/yzYClt+9x0QYf8=
X-Received: by 2002:ac8:7cba:: with SMTP id z26mr11972735qtv.143.1587764911775;
 Fri, 24 Apr 2020 14:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200422201216.10593-1-ansuelsmth@gmail.com> <20200422201216.10593-2-ansuelsmth@gmail.com>
In-Reply-To: <20200422201216.10593-2-ansuelsmth@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Apr 2020 16:48:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUbM7ed2q7so4Uibiz2URRg1juoGRExy9Ta3J-LWAFow@mail.gmail.com>
Message-ID: <CAL_JsqLUbM7ed2q7so4Uibiz2URRg1juoGRExy9Ta3J-LWAFow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: opp: Fix wrong binding in qcom-nvmem-cpufreq
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 3:12 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Update binding to new generic name "operating-points-v2-qcom-cpu"
>
> Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index 64f07417ecfb..537e1774f589 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -19,7 +19,7 @@ In 'cpu' nodes:
>
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -       - 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
> +       - 'operating-points-v2-qcom-cpu' for apq8096, msm8996, msm8974,
>                                              apq8064, ipq8064, msm8960 and ipq8074.

This is not how you fix the backwards compatibility issue pointed out
on the Fixes reference.

Rob
