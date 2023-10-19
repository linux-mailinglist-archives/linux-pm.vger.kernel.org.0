Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F4B7CF054
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjJSGrD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 02:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJSGrC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 02:47:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14956119
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 23:46:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso4738684a12.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 23:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697698016; x=1698302816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5ZJsyvfM+Zq9ZLZKJ7GPs5PPw+WA8Q5sgTdxbhgzH0=;
        b=cxFHLl2gYPeArWdD8OdZ4mejp6dc7r3gfj3kn5D0G1algYTxcvkAHOWrjrGPG6ETBx
         J9wxDboo42wHck5krM4EmfLvigMCRwOcAbB4P0piU/sFyylFhkXpz2KpMYP51vcWLj8H
         eDk2lCNmjp6P6zE/yCTWiY6tQfa+b8GFDjVo8jN1qwQZNBCfmoAaNDupYVN8vVQJe/Un
         z3N7vdLp03UAjESWeomWEdaGJQnAFhmQOGiE4NdEvYuSG290mSr+1xFr5U/3AOGaYD0v
         +NYO7o+tCy1MapE75cB8P3o9iaFGcuhwIi50J/KmL8H0RE7BAjd0H96c2M3/ncaInnqg
         0Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698016; x=1698302816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5ZJsyvfM+Zq9ZLZKJ7GPs5PPw+WA8Q5sgTdxbhgzH0=;
        b=mk4U3FPu0OgZNsBNZ+9z2WSg5eCTjeZXN8RAh2ZtOayB0hnFKg4I+t9JMS4n4kSnDX
         UY9UIMswvG36K41b2RjcfaBg3Apfkgjdxb+D3JZqHVClyUTQvXsC2qxavjgtCqPd7x7F
         1ANa2mFjHUJ0J8Hbl2lJ3R/DISoFs9QWRf99qHXCCXah6C9wLlfYmfzbJIqnmURT2hgZ
         37JofyJ/qaVzJ5QgFxZFu49p3pYnDqcLl9h9M436QAqn8xIYHnbIcnZeYNFu2YQPb8va
         oRA5Rh6d3vNCNuU+rfEKmal6134/pIFbOqC7UGGb1pM+O/flpCPftqRcxoQvmVM8L/E9
         /TCw==
X-Gm-Message-State: AOJu0Yy3Nx2l5Zq7O+M661VO97h6WOQoZ7yIRDU+At0BEXqM3vkKcOUK
        X0bo8Lx17JaItZv1V4JxnIm04Q==
X-Google-Smtp-Source: AGHT+IFth7U4xLVcr3gM1uaQR6mB4u9ZWR6FF+K5XnVT1FArumGmO27ywj8s+aGrhbgtYNodIWf60A==
X-Received: by 2002:a05:6a21:7741:b0:13a:59b1:c884 with SMTP id bc1-20020a056a21774100b0013a59b1c884mr1325731pzc.40.1697698016581;
        Wed, 18 Oct 2023 23:46:56 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d68200b001c5f77e23a8sm1071860ply.73.2023.10.18.23.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:46:56 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:16:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] cpufreq: qcom-nvmem: add support for ipq806x
Message-ID: <20231019064653.feqpjdmblm7mmsug@vireshk-i7>
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013173854.7399-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-10-23, 19:38, Christian Marangi wrote:
> The first patch of this series was split to a separate series as it
> doesn't depend on [1] and can be applied right away,
> [1] introduced some breaking change to function that ipq806x, ipq807x
> patch was dropped to permit an easier rebase and merge of both.
> 
> This small series adds support for ipq806x qcom-cpufreq-nvmem driver.
> Special function are required to make use of the opp-supported-hw
> binding by hardcoding custom bits based on the qcom SoC ID.
> 
> The qcom-cpufreq-nvmem driver had recent changes to also improve
> support for apq8064. Because of this, this series depends on a
> just merged series.
> 
> Depends on [1].
> 
> [1] https://lore.kernel.org/linux-pm/20231010063235.rj2ehxugtjr5x2xr@vireshk-i7/T/#t
> 
> Christian Marangi (4):
>   dt-bindings: cpufreq: qcom-cpufreq-nvmem: Document krait-cpu
>   dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt
>     property

Applied above two. Thanks.

>   cpufreq: qcom-nvmem: add support for IPQ8064

This doesn't apply/build anymore.

>   ARM: dts: qcom: ipq8064: Add CPU OPP table

-- 
viresh
