Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3E364A59
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbhDSTSY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 15:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhDSTSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 15:18:23 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB530C061763
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:17:51 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so7973265oot.4
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m5D38FPKaVXPaWXHSFPjwGl10L5uuS1G4hWLi/5rSB0=;
        b=x8en4fC2bgy4uHZ0IMu38lYJhWK5Bbb2VGbO9ieiCefUCXHF0m5MJB8BPR9MhYsyUO
         Ndz0vzM3qHHnJRY661VVZtSmYlc4bONSPXqw5mR38ppyo0T8hc4a23GmfxEyJdevtK6Y
         vpEa1PQ4T4YY6Cj5Sizpn7Tyv+tRiAUYP4BDr4bIUYRQdzpBDToOwhazC05QXkroWJoU
         uGQGKfDDBeA45vDC+TEoHTtUbKv6RlH7riNFKvPJcozKHR9BUZ5lX7Kk2ZpNYL70e6kp
         y84l4RRhcdfeNAt/L1ywRpTqTx6TrKVMRpbNkJJp5Yu8y3K5ui0Fz43nxNZMT30hRUi1
         vBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m5D38FPKaVXPaWXHSFPjwGl10L5uuS1G4hWLi/5rSB0=;
        b=QGvf9AsPo7j6060v38dSluuOSP9/Kaa66tXhOQbRuAO0n5lm5B4HZ8TAsK4GuEaLms
         FruXQ6hHYv6jx8DOQF8AS+c9Z0D1PCWGB2run/SU4Dj1VIDUQlGMtaqf6mf4tjW7b1uv
         QbFIfFhfdWCUEpuX9NDi02muF6k7SYJqrIXEG88D3b0edNtAuxdda/t4f0PYGg/xJeC+
         Jlwb0iD9dOT+wpvcIt596mSXBxLssn/KCDcSwI+3/tk0xGdMZhb13MVuPO1FFcAXHuUo
         LCo6dIGxVoUJ0wsBZnq2sZOHp9iqydqV9qsvJc4IOn9/zqboZFoVowZZ3zW/0Xm1kYMI
         39Ug==
X-Gm-Message-State: AOAM530klMhs4b+angSTKXAU2cTquLnraj1Rax+MH04mDN/I5XimF1mj
        7f5ZAM+syVYcZ1fvQegUy0hm1w==
X-Google-Smtp-Source: ABdhPJz01Umh6zLfuwwGUusXjOlrZ3VrH1wOZO/VqjtjXCKZvrmxg/RnbVEb76RMNUsymXy7cdAvng==
X-Received: by 2002:a4a:94c3:: with SMTP id l3mr9789581ooi.12.1618859871144;
        Mon, 19 Apr 2021 12:17:51 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q9sm282031oig.7.2021.04.19.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:17:50 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:17:48 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 4/7] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to
 YAML bindings
Message-ID: <20210419191748.GS1538589@yoga>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-5-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119174557.227318-5-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 19 Jan 11:45 CST 2021, AngeloGioacchino Del Regno wrote:
[..]
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> new file mode 100644
> index 000000000000..bc81b6203e27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -0,0 +1,204 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-qcom-hw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. CPUFREQ
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +

Mani, I presume you're still up for the maintainership of this binding?

> +description: |
> +
> +  CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> +  for multiple clusters.
[..]
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names

This is optional in the .txt version and as such I would like you to
make this required in a separate patch following the yaml conversion.

Apart from that I think this looks good.

> +  - clocks
> +  - clock-names
> +  - '#freq-domain-cells'
> +

Regards,
Bjorn
