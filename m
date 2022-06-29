Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417FD55FDB5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiF2Kq3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiF2Kq2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 06:46:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7713E0C6
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 03:46:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d2so19993074ejy.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cMdpnW5I3sDfoMvD9YsVURL6JcznIQt8/xjMwDyc9j0=;
        b=lfFr6WdZD53FjuE59FWp279jcSFgvI/GN0+R8iikc7l0/5lVFlG3OkvqB7i0lA1Wvk
         3Jk+ma+haSSfeXNjbjTstxhgd5kv1uJwjK2fZM+EXXfRImTA8DJkunOZnEqPeYwkLX8u
         KcbSSZjfpFZQgRQ/++fni2InvatqowwUX6fzPu5wzkC/yDIM1PdKsEdyi75K9xRuuY8D
         Ix6suQS/WWYNScEL16LctEYA7VNkKLa1tRXoDCLhRp4FnA7n+8oE/GvBxsITwfEODmS8
         S7JmuAebqgX+xFvIGcpr1kIe7q9D2BWfEX6g3iQg+LxiydvstfZYDK8i2aY6cAJmIPUh
         /SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cMdpnW5I3sDfoMvD9YsVURL6JcznIQt8/xjMwDyc9j0=;
        b=nL2CcDOLTY+fPddOMXeodvVncRSqmJBQUinpCxYpNRFiz11VnkcMt+G0jSww2MSI9y
         db4/VQjMDOaCxHyKkpAbRrRqDC4kd3Tgbpe6V/eyhr3D9a5Q6sE438vGDnlRQBfmU3Tm
         01FimodOjK8LvF5DAmoYz54iSN0YmbtgMVUjerglLe09rlK+A2knf3WMz3wURqgWVDmf
         PImq3i/ZE2LWj6H23cAAB3un2JYV9DGRqPS/iDbYUbClUKLhcVDUEXlwYCDGwC7h1wAA
         O+rgDEtK6on3p+5HcHYPkA/z+a/4lOy+qOrWKFbBzQUVScmgXpbYfMU78Jpu1qYFQ3Yc
         mgSA==
X-Gm-Message-State: AJIora/pExp7VuFvBiW/BnZJVnr0CL1FkRjF1CA7cW9dlimQsOuxkjeN
        XzkSFsqgbowua9lgVdyaPQ94jQ==
X-Google-Smtp-Source: AGRyM1vLC5RPlTyC27/aUFLIdJiU2aF7FeDA/rmWREwug6CILbkLX1jWla5EjOsjyQfNPfqA5WxyGQ==
X-Received: by 2002:a17:906:b150:b0:711:c6a5:c5c1 with SMTP id bt16-20020a170906b15000b00711c6a5c5c1mr2661941ejb.177.1656499586211;
        Wed, 29 Jun 2022 03:46:26 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m2-20020a50ef02000000b00435a997303bsm10998148eds.71.2022.06.29.03.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:46:25 -0700 (PDT)
Message-ID: <dd32ee3a-9aa9-94d0-4064-ff2f72abf0fe@linaro.org>
Date:   Wed, 29 Jun 2022 12:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] dt-bindings: thermal: qcom-tsens: Add MSM8909
 compatible
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
 <20220627131415.2868938-3-stephan.gerhold@kernkonzept.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627131415.2868938-3-stephan.gerhold@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/06/2022 15:14, Stephan Gerhold wrote:
> MSM8909 uses the TSENS v0.1 block similar to other SoCs like MSM8916.
> Document the "qcom,msm8909-tsens" compatible in the existing schema.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
