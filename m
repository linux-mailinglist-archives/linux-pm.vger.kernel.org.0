Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463F37CF500
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbjJSKVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 06:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjJSKVL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 06:21:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC7121
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 03:21:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ab2cb900fcso3979529a12.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697710868; x=1698315668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aITYjO+YGsm/lNyeL4Ki5aL7OoIQ+oAR9WJa4zw/g+U=;
        b=QD3dLeYn1zYUFh5L48gjx9aKO4LRmGJ9UcbzK6KUqsfivCjyPaIr5dBF4808V4rU3P
         P1d+FGljUeeKEq6KbGepHM5OvoqrAiprHmHdqQXWoOzSo9XHIRpjYVnbJSbwEwaQYy7N
         09Zz6yv60wkqgwbFyQ8BESHNys/RHvJsE/io5Fb+4H6zcwBh5DA4H0VcnKiEvWlZQa+k
         fT88rqHKV+PC73rNE9wqNyjFHby7Dp0uiGXJf27A4TDuu/cfxz6GJAPPL87hohevwBG2
         nTfWwZije3o0ENLUwUBmwmlbrWsGysFTyUwYj9Gs/X/5wOb7vG2le6yo3SaFsXnVb1P1
         hvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710868; x=1698315668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aITYjO+YGsm/lNyeL4Ki5aL7OoIQ+oAR9WJa4zw/g+U=;
        b=R6595M4ljOPxNbN+ZINqlKW5f076mR+U0+si1pAumFbiUP97XZIEiUxx3NMHHC+aGN
         F+7+F2197AKG+Brn7U22VY+b5cYz5oMHPcei2fQxOnNeV8Tl6xD4yKNy6d2uWgrh1yHI
         XxkSShcHMBdtnIGM76QOQ//NVx7VjuJBFZnPmpGloDoOJ0/fPn5ZgSV9thIBkbLJnfxS
         2NazJcMBk6kofmtwrDGB+LUE9BJnTHvH5UhNsLbUaYwSINCmBrLC7/aFtRUnMVyt21m0
         GJh6+F1gsyGgMM1/YChrgjNnddlnKAcxDRXcJwvIUKas09MrL97qgAiXXyn0Xc2nFHVV
         czHw==
X-Gm-Message-State: AOJu0YxuXxlMpWYa7fQM3bb6P+faVq9mwpcHtoPb12LtYUWm+J+S36jU
        mQ3/j2QjhjyxRt1RIoX55iFRZw==
X-Google-Smtp-Source: AGHT+IHgSXQIZ155HjMhQyZ2MAj3GZ1/ogxK3/KsYKplLNKM/uybb2aciaUr8aRLLJOipm0Meh5S9Q==
X-Received: by 2002:a17:90a:4381:b0:27d:1ea0:bc84 with SMTP id r1-20020a17090a438100b0027d1ea0bc84mr1562150pjg.34.1697710868475;
        Thu, 19 Oct 2023 03:21:08 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id i126-20020a639d84000000b005b83bc255fbsm1945847pgd.71.2023.10.19.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:21:07 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:51:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Message-ID: <20231019102105.jewkue3gxonzy7kw@vireshk-i7>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
 <CAPDyKFr5xC6yaB4REQ5FwROfh_Rsfco5KBw4A9T9A2JZepTk8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr5xC6yaB4REQ5FwROfh_Rsfco5KBw4A9T9A2JZepTk8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-10-23, 12:19, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 08:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-10-23, 10:06, Stephan Gerhold wrote:
> > > Add the necessary definitions to the qcom-cpufreq-nvmem driver to
> > > support basic cpufreq scaling on the Qualcomm MSM8909 SoC. In practice
> > > the necessary power domains vary depending on the actual PMIC the SoC
> > > was combined with. With PM8909 the VDD_APC power domain is shared with
> > > VDD_CX so the RPM firmware handles all voltage adjustments, while with
> > > PM8916 and PM660 Linux is responsible to do adaptive voltage scaling
> > > of a dedicated CPU regulator using CPR.
> > >
> > > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> >
> > Applied patch 1 and 3. Thanks.
> 
> I did spend quite some time reviewing the previous version. Please
> allow me to have a look at this too before applying.

My branch isn't immutable, I keep on changing it. Please provide your
feedback :)

-- 
viresh
