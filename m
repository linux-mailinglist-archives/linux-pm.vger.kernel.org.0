Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60363DF588
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 21:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhHCTXb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 15:23:31 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:41748 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbhHCTX3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 15:23:29 -0400
Received: by mail-il1-f175.google.com with SMTP id j18so17481872ile.8;
        Tue, 03 Aug 2021 12:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dcNrqzMlwCfzPEAk0jxveiZAemfDBtg5jSgVcUhKT/k=;
        b=LMntrGX72BxRKlQlQEgS/BsUDzc/+7gKnHOXAkF4tlbHeonUbVx1BKup0TIO+h7N5n
         xQN4iX8htlopXV4JScALvrBQWMtt2wV2vYx05VSbMWycJ5AnGrtClPGnPZG2hShrtxzE
         fiU6yKvSD+DAiRFPtxaCy8Nc3SGhATbzsQ5tXVtU5rC0Ov3u1WQaxPsv7YYW9rRUQkpK
         6Af4CWZkidr/jzNXm0VeTkmtIcc+oa81+J70GS1/n0Pe48+eohO0n9a7sqroh98yZN6w
         B4dOYOFIpV6fKqBHJoJLtWrPyGzFbDztKYI+6//TItayaAk2V+U3yztOPNr68Ez4Jhu1
         vs7g==
X-Gm-Message-State: AOAM533/YJ93C1DybHKC46CjgOAArovlPvSxiV8GCCapJcUq2xOw8PwX
        OcBWSCXlo1bVZkfjWVEBjw==
X-Google-Smtp-Source: ABdhPJxglGdS0ljuNlZ3K1k0hr4l/wTy9w6Xl+KKhZUy8PWhPtEOO+68VZwP637ma+e96FrBZAvp4A==
X-Received: by 2002:a92:c143:: with SMTP id b3mr530334ilh.145.1628018597391;
        Tue, 03 Aug 2021 12:23:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t11sm7905636ilp.66.2021.08.03.12.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:23:16 -0700 (PDT)
Received: (nullmailer pid 3594635 invoked by uid 1000);
        Tue, 03 Aug 2021 19:23:14 -0000
Date:   Tue, 3 Aug 2021 13:23:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     mka@chromium.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, agross@kernel.org, rjw@rjwysocki.net,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        sboyd@kernel.org, tdas@codeaurora.org, devicetree@vger.kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: cpufreq-qcom-hw: Add
 compatible for SM8250/8350
Message-ID: <YQmXolN5bk+WdYNi@robh.at.kernel.org>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-2-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627581885-32165-2-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 29 Jul 2021 23:34:42 +0530, Sibi Sankar wrote:
> Re-arranging the register regions to support per core L3 DCVS would lead
> to bindings breakage when using an older dt with a newer kernel. So,
> document the EPSS compatible for SM8250/SM8350 SoCs and use them in the
> CPUFreq-hw driver to prevent such breakages.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
