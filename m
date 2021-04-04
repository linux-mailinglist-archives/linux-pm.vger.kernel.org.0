Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973333539BE
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhDDUaQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhDDUaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:30:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C2C06178C
        for <linux-pm@vger.kernel.org>; Sun,  4 Apr 2021 13:30:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c8so9258717wrq.11
        for <linux-pm@vger.kernel.org>; Sun, 04 Apr 2021 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TBl38P7bIAbEuuml42sTVfJSOcbW4y2srl0KhSNAYqU=;
        b=jfAFTELaUJBbuJIrluLkTvCERKzGn5H/3rzDrTuaCmIT32B6enuQPHBQMcHiQNoqZJ
         UdXAJ6L58wCtHvbNohwVxzb0ytXioZke5nYNsyAp+cjfCFXdD+Xh+CLiQCXSJyo9x0fg
         /7eD5Fa8p4JM0jVrneiP3kf0xOjh1f7GOu6ClzaLaDVSRq2Pr1RaIEs0yVMLCUaGr0tN
         OepBstX/sjaojWqOgH5eRGn16WezjT8qTRyo3r0sNqOcx8rqCNOZsfsL+XznveTuFIHu
         bbIwcDqDjBEeR0vivgx7ODoVdfgZhzFxA/cOQdwFh+3mEcxJQP/bcljsMmAjm2Tc4nx+
         0DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBl38P7bIAbEuuml42sTVfJSOcbW4y2srl0KhSNAYqU=;
        b=JjZ93QNIzO3HnbhAWiL/gzLbGk/YMJCeRjmNsdW7JYUZfMhI+FOV8LlSfA4nUYleJR
         iJciRa3cDwYFtQVhucv76/QhJZFXA2BTtPli3PFQZ+UWGFbBWRQ1MQho+T1w2zZq/ouL
         SBr9/SfD24DYj+ClkMuU/ekUVB76jST09pQEEDb0r8XE2LDylaXqIsRYZonBXN0v+sHB
         CkpiIVuyRm9XEfUG4iXdL+23CEqB802JsG5hTmOYtnR9dmaYR2f4CuSljHaD+M7YOLtn
         zD7WgnTRXzFz+bxiYHSLbdW3gYHS08f07csrmsj4+biTHfSA2QY8JUc4aYPsq6jWuiKm
         Flpw==
X-Gm-Message-State: AOAM531L3bFJGzl3Aix+pQTm2pdleiouuy5azHZ3sAdVYXCj8RTZoUv/
        BCxz2lSJtNPj9uPRPiycFDfWC0D/sFQMBg==
X-Google-Smtp-Source: ABdhPJyKijRlhIDUswk2WIOWQKLBJlG+GewGEDazHOp5gCLS7g/gRkgIqzaueLPOVrRN9OcDbgBZ7g==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr25508280wrp.231.1617568207955;
        Sun, 04 Apr 2021 13:30:07 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f? ([2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f])
        by smtp.googlemail.com with ESMTPSA id b66sm9830071wmb.48.2021.04.04.13.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:30:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: qcom-tsens: Add compatible
 for sm8350
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Vinod Koul <vkoul@kernel.org>
References: <20210324124308.1265626-1-robert.foss@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <31232c42-ce58-cac1-63c7-eedd20b6cc76@linaro.org>
Date:   Sun, 4 Apr 2021 22:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210324124308.1265626-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/03/2021 13:43, Robert Foss wrote:
> Add tsens bindings for sm8350.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
