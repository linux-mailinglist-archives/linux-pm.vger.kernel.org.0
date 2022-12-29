Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F05658C85
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiL2MF7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 07:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiL2MF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 07:05:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43126CD
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 04:05:56 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a184so1740003pfa.9
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 04:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFt/9SdMGfTEVCLCVkiPAaVjO+1ZMNg673Kf483FlMw=;
        b=zeRF4EPO9yZmbZX5LQqkiT84jiJu0uU8LRMEC52xpjJDrlz8OYTDt0Ebk5xGYoq4a3
         I6f9Kkag/WV8srQtn+Xu/+ClyP4v+GOqlbjcGzbDqLtLhK0oeXBdVBQsAkqSm4Q9Udki
         0OyR/PuRzq65wqFgZ6Q/jDxH+ZU7u0yZHSQHXRakZDkPFMx1CtSKPqBAtwnyqqJ7jQli
         eztT+I7WZTnj7BKA5Zr8i3NLDQWY9lT9zozuSAbFKgaewIhFvkij6qcXvgNY7SMCNNPd
         +XCNBqf9XWi6Z3TQweBASwLKCNmnOf1GrwMOQu7BpojCSqHxUcx6fM7mwcROZEIkt9m+
         kh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFt/9SdMGfTEVCLCVkiPAaVjO+1ZMNg673Kf483FlMw=;
        b=OkTfnIUQLaHaspZE0wP+IvvuBMluNUWPeMd+qNTg8zSB2+Dhe7fbrNJeFlsnbQwtFl
         9l1bT0EoCvCEyB3HIlElnjTpfUsNCdKZkbvy5/TVoJ6O8+m8LDpOk17Q6O2FXZ2Yw5gs
         ZWilDbqZN0/zLJpt7F4/PsmiZ8JTWFT2/fHj24sFV/B7zDLWVRvdc1oBl+kUN9CC2DXP
         LOS+VV88ZzSMzvpA9S6Tbt/fa5N05x7iFkSESrVsTNmPmolVbzoB7cCYIz3tIiQbhg62
         n06T4AT7YOlvgZuBxQEvuiUJEaeasiAMCDSDAUFbGFCk/k4QVnfPBwFwljDS3Vq7swbj
         qkhA==
X-Gm-Message-State: AFqh2krj1yHq+9kEPpAsCCB2qmk2+9C5SPuMlqqlGgrgoZ5Ec+AzQV6C
        hYaFFzuae9OsTEipcqTl/gYEuQ==
X-Google-Smtp-Source: AMrXdXtm2PzXld+2NQtlz1s7eORtwWEuPoJ8A7kNC4dyLdlcm5OboMi6TM6M32CZt1nPIo/Iher0VQ==
X-Received: by 2002:a62:65c3:0:b0:580:1cbe:edb6 with SMTP id z186-20020a6265c3000000b005801cbeedb6mr28082526pfb.20.1672315556132;
        Thu, 29 Dec 2022 04:05:56 -0800 (PST)
Received: from T480 (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 64-20020a620543000000b0056bd1bf4243sm11983976pff.53.2022.12.29.04.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Dec 2022 04:05:55 -0800 (PST)
Date:   Thu, 29 Dec 2022 20:05:47 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/20] thermal/drivers/tsens: fix slope values for
 msm8939
Message-ID: <20221229120545.GA18875@T480>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
 <20221229030106.3303205-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229030106.3303205-8-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 29, 2022 at 05:00:53AM +0200, Dmitry Baryshkov wrote:
> According to the vendor kernels (msm-3.10, 3.14 and 3.18), msm8939
> uses non-standard slope values for calibrating the sensors. Fill them
> accordingly.
> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
