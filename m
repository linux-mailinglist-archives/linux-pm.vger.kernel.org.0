Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FC42F08AF
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhAJRTo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 12:19:44 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:32906 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJRTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 12:19:43 -0500
Received: by mail-oi1-f172.google.com with SMTP id d203so17759042oia.0;
        Sun, 10 Jan 2021 09:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dpRmxYlnzoK4Lg6qNYsLrabnqdmAajbzQvyDJX0Sah8=;
        b=lSTAfPZ8ldEvDWRDiGt6CZ8Temh1k6D3iy0fi4V8e/HEQTyG0GxW2mpcFq92oAbCMY
         A4TQuF6yrpog7BcKmRImitC0/9jZ2FBXg2YgTxYZy2V7BPgRtc0cA2s6WegM522UlVFx
         ljLzJWm5NAx5z4YosHksres36ZjfpAt4jEfpE5S27U/4bpoxD+dawfdaH6DFMsuGHbdo
         qqNjEBeu+cc8hNlvGfSUpLj0E1r6qWCbR+s6D94621KRWoyHkc0PshvM4OryB8zRYlMl
         5u9qjiks6waU0C62kqA6ELZ2MIzD0IG5630lVYAZBowJ3SG2x17PBys5MBqtGsS7kP1v
         xHZQ==
X-Gm-Message-State: AOAM532HxDmL2VR1rd8Egytjm0+rHeg0iZyuvXvvAt5ItsSrB/td1Y/5
        9RekOMuUmiMlf9f48rSClg==
X-Google-Smtp-Source: ABdhPJwLUuMmsbYJA5pNeqvmXXoVg51UlNhmRIQluJbm9TYeOig/e6tOEclqP/USGyTB9k81oNqCEw==
X-Received: by 2002:a54:4785:: with SMTP id o5mr8249939oic.139.1610299142715;
        Sun, 10 Jan 2021 09:19:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g5sm3128772otq.43.2021.01.10.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 09:19:01 -0800 (PST)
Received: (nullmailer pid 785285 invoked by uid 1000);
        Sun, 10 Jan 2021 17:18:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, phone-devel@vger.kernel.org,
        martin.botka@somainline.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, nks@flawful.org,
        viresh.kumar@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        agross@kernel.org
In-Reply-To: <20210109180359.236098-16-angelogioacchino.delregno@somainline.org>
References: <20210109180359.236098-1-angelogioacchino.delregno@somainline.org> <20210109180359.236098-16-angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v2 15/15] dt-bindings: cpufreq: qcom-hw: Add bindings for 8998
Date:   Sun, 10 Jan 2021 11:18:46 -0600
Message-Id: <1610299126.062379.785284.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 09 Jan 2021 19:03:59 +0100, AngeloGioacchino Del Regno wrote:
> The OSM programming addition has been done under the
> qcom,cpufreq-hw-8998 compatible name: specify the requirement
> of two additional register spaces for this functionality.
> This implementation, with the same compatible, has been
> tested on MSM8998 and SDM630.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 44 ++++++++++++++++---
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:73:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.example.dt.yaml: cpufreq@17d43000: reg: [[399781888, 5120], [399792128, 5120]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

See https://patchwork.ozlabs.org/patch/1424138

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

