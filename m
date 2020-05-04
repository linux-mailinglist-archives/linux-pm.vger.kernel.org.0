Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D661C32E9
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 08:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgEDG24 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 02:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgEDG24 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 02:28:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E386C061A0F
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 23:28:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d25so8690894lfi.11
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 23:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IG/tGFQPJCSJYnPu8/15Qbq3jfJlPJ6HJh4I87r1NIs=;
        b=YumOYpGcROINiP9wKRrt4Kr8G2zKkJEhHgZkkk6XeLTvKHSUHl+YsFerC4ty7e9Xf8
         MfzmyGkOYAns2VLQMBAKThlZJiF7kql80QFDqWkE1uPP8tBkoUbbrPytRItJDQZ22Hg9
         9qc21PC1/rxBmnQFNViOT3LuibVLnHFOjhDwIeqncOW7vkmeOF6qBPEYNx+Q/jyme1Ye
         8J2TfumsMAOhcUxzFEesLq0nu4lbVB4Ys6TAyiZZyOYHlA0v4QJRPHhwRrynhRJTXoJk
         aDX50M54/DSdHhoT9I4ABRDKZOdZXga3kLlqVTa0kvcMADTIwafVRk6KXQ68f6QFQGDP
         38Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IG/tGFQPJCSJYnPu8/15Qbq3jfJlPJ6HJh4I87r1NIs=;
        b=hUqaA5YtHT1xOt+VX5XLf2r85sACyx23P9ZcVYK/Vv6ZI0lECL0py5Q5WagOBR6a64
         0VmWCnwzRrC2Yf0vG2gCFkJRqLHS6RcGxaSZc5VFeUXBqr40USv58Sm6a47cCgvaKE3u
         xRbgM/KV18F0fuM1QvJZu+xFS8FZn9YDil4811viJTtHUIfix315HEJ2o0B1fKLlrV4o
         uIa9I1KWRKCbR8+LVjLPJDhS/6qyuXl8cmE2HWAIv8sT5IpIhMWQQ4W7rXogKSejmNjf
         Ayrz+Cr8jHy3DnrW1UNm1ki5ZOeJjqOlOnF6jqjdSQ/PY1+vBEEW9uAePaihrUm5v6PR
         WiHQ==
X-Gm-Message-State: AGi0PubOY1vQ/910ep4lmJc6xVEdFovauCnH6tRmtbwfTNmvtCffmDT/
        x+vfDpYLLqn+qd/puh633jtJLCrIEfTu7aBq47IjIw==
X-Google-Smtp-Source: APiQypKO3fJEpw/Lg9UxJ1PfVeF0vg7F8K+oZ9DqX0zFzsZA/c0kCGb3cmKEKqUN6T9RPgBy+nmfJLzBOrTGKieDleA=
X-Received: by 2002:ac2:5dd4:: with SMTP id x20mr6381625lfq.7.1588573732796;
 Sun, 03 May 2020 23:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200501203311.143934-1-konradybcio@gmail.com> <20200501203311.143934-3-konradybcio@gmail.com>
In-Reply-To: <20200501203311.143934-3-konradybcio@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 4 May 2020 11:58:22 +0530
Message-ID: <CAP245DWJsUnR9XaW_2kzcg9Ji8DR6JgfV0Xa_7NmoMK=F4HzSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: tsens: qcom: Document MSM8939 compatible
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 2, 2020 at 2:03 AM Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 2ddd39d967662..2ce489ccbf902 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -23,6 +23,7 @@ properties:
>          items:
>            - enum:
>                - qcom,msm8916-tsens
> +              - qcom,msm8939-tsens
>                - qcom,msm8974-tsens
>            - const: qcom,tsens-v0_1
>
> --
> 2.26.1
>
