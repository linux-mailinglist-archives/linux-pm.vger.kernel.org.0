Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8172A403985
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbhIHMKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 08:10:54 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35376 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351675AbhIHMKy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Sep 2021 08:10:54 -0400
Received: by mail-ot1-f53.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so2643869otf.2;
        Wed, 08 Sep 2021 05:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j7ojHJ1eCmWRZa3pwYfDHA3k+qFmPKIKJn/96r4lWZQ=;
        b=HKQYV3/aBH2b77KXbYvfooJkUJAD3OCRlWR2BgbyXQ1M0JYsSOSu60pHv7PMVMMUce
         v+VJgV9xH+74A4Cew96yDQhufXK1XU1Hp4PpaWdxjusbwItkHz/JpsKAsevl4rOeBWY3
         otWFBY+WzcPRGpbiYrI3bdUXyJvbms1j+qNHnYWjqnuJPJnNgXzko3mSsJ3nsm+hMFiY
         Prnb2CqEZGf2sr3uOsF5+zMpu8N2GapZgxv0YmZUtGbY4GliidgrTLSbpY9Zz22JhRkW
         h4Qr5HfJODGDhYb927bmCuFK0ItrStYMZ8oeFt72gP/oG4H9lvv/TB5xmoeHR8hpSyBP
         4iSw==
X-Gm-Message-State: AOAM530ndT3qhs2XkbyAD+ZuJ1H/vkyLWRNmUC9TpYagDnRGk0zN1CIB
        eFucp2aUV1M+vAmdaOGdIg==
X-Google-Smtp-Source: ABdhPJxWseZDeKVP+HWmuLFENdu1NKMmCTa/qCI19k9RLF4GoYFUHyFtsDm8udD9WFFDAtNTmMM4BA==
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr2643550oto.175.1631102986008;
        Wed, 08 Sep 2021 05:09:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s14sm407750oiw.8.2021.09.08.05.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 05:09:44 -0700 (PDT)
Received: (nullmailer pid 1869396 invoked by uid 1000);
        Wed, 08 Sep 2021 12:09:43 -0000
Date:   Wed, 8 Sep 2021 07:09:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     angelogioacchino.delregno@somainline.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        martin.botka@somainline.org, jamipkettunen@somainline.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        marijn.suijten@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: tsens: Add msm8992/4
 compatibles
Message-ID: <YTioBwEEQHWy9Cjf@robh.at.kernel.org>
References: <20210904211508.317560-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904211508.317560-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 04 Sep 2021 23:15:07 +0200, Konrad Dybcio wrote:
> Add the compatibles for msm8992/4 TSENS hardware.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - Separate this into a standalone patch
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
