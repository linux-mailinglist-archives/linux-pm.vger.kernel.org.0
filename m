Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25947B1365
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjI1GyP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjI1GyP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 02:54:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B3CA3
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 23:54:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6907e44665bso11304144b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695884053; x=1696488853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORFh1G/tLLYSxkT+tmliKlXY8dPwCVzvjctTBPYPJoA=;
        b=ft1pFHQABlryPmfTY7AphwsYXbkqAVWBZC8omNIws/V7hcQMH+ZOQn++Y3fXWkh44w
         TebDlQy4J67Xxh1jZoQBiEWKhac58s03A8em3+SO6vw+QdGW+Fwpw65evWFgoFSbvI/q
         ZQXw+MPeG9eXZfDoyApmd3u5tmoHAOaJ6MapcMTI4tQva4In82iUV530zVvsxHVvoCRa
         SRrdYkFFRxB1aUlFc1BSdk4V/czcr+EgeBieC8zZd0tt9fOPFhDFQ2PehZrHVyhlTeOF
         Ub8yGJn/ZZid9WiIekHImyOKCSkUIDbmSoccCVZqOFiiIaWZgK4knUbgAzQoacBeuGUz
         Y5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884053; x=1696488853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORFh1G/tLLYSxkT+tmliKlXY8dPwCVzvjctTBPYPJoA=;
        b=opJEwSPWHdXiUWdngjVi/JTOhg7rwQmpjI4K2iEWQR+e8PPKEIW+QbMVGFIQdoNAz8
         sZ7O4YDPmrBO78ReFPClUR6ESjHFwVR62cD17Q3O+S0ShD2uwqQmKkHoM3kDgZGTynb9
         xsEtKJM8VIw0SwdvIwYD/D35/ypvmuATKQL3fhZwbIZEsk0Lb8K6x2U7mQDtZPsGcqdu
         wTn3vtnOlO5LenvPkfAdOy6SiFr8O1a/D6yrQ+o+wFP8ow5mfVDfh6wNHgQPkXRbCwB0
         f73afqkeQNfgg8BLgC4aZQn8ze4s45jtTJ0Us31w3koz0/Jb26ABPHDaot31rB4Wt3mV
         PrRQ==
X-Gm-Message-State: AOJu0YwVHiw/K9t5rDDzY05oLRSCH2NpoSKU267DjrfpTsi0Zkr6Jmc/
        skcHP4r08sBWtgpFDfRLs0NQaQ==
X-Google-Smtp-Source: AGHT+IFNRQNqqdXxxa3csygfbjqkQyvW8kGqyU9ZM1twjgU8rhX0gzHHjfRf0thapiix1HIk6FM2dQ==
X-Received: by 2002:aa7:88c1:0:b0:68f:dfda:1814 with SMTP id k1-20020aa788c1000000b0068fdfda1814mr480850pff.18.1695884052920;
        Wed, 27 Sep 2023 23:54:12 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id du14-20020a056a002b4e00b00690fe1c928esm8915642pfb.91.2023.09.27.23.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:54:12 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:24:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: cpufreq: qcom-nvmem: Document MSM8909
Message-ID: <20230928065410.4flrqdm5mtw6zt32@vireshk-i7>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-3-767ce66b544b@kernkonzept.com>
 <169454334732.1164153.5118228878567772612.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169454334732.1164153.5118228878567772612.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-09-23, 13:29, Rob Herring wrote:
> 
> On Tue, 12 Sep 2023 11:40:17 +0200, Stephan Gerhold wrote:
> > Document that MSM8909 is used with qcom-cpufreq-nvmem for voltage
> > scaling and to restrict the maximum frequency based on the speedbin
> > encoded in the nvmem cells.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> >  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied. Thanks.

-- 
viresh
