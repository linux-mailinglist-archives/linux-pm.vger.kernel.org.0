Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B397A268C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjIOStF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjIOSs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 14:48:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D64C19
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 11:45:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ab244f2c89so1608633b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694803544; x=1695408344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc6N8q1gZ95xd8ZpHAufgS4nDSL1wE+rjEdZ65KQsuw=;
        b=qaGc3i2kjpKiLBAflyHXKX/F+6iOeJ+awGWr88gEK67InMTl5x/kuRDzAKHO4bD2rj
         EMTcLNDozSD5VlUEBf1zaHmcu0MNKrkDcTamASiqNbvuLnLSE44Or5sCLEXqPgExxIrT
         a5oOlZyC7j2973zEvGxNjCcPtH1MRzYz0+FB8e6xqxh0Aioau0Qh2boDzwn0tbTYjDog
         QwL1n3Q6ENrblqq4zn1Mfzdhz++wodZDJESN7U25WsbTp7N9S9i8we1Ugcowsm0N6xCY
         XGPF5aYlECdwT3QVIkWslAzBGzUX6gtJ4XlvQM7ZgoU6+rqoVKwDp9XXD571GxzMmEbO
         l3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803544; x=1695408344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc6N8q1gZ95xd8ZpHAufgS4nDSL1wE+rjEdZ65KQsuw=;
        b=WCNKz6Ep0oy2RopMhem8RVcRv5+/wJ56i3YF61VWWbqRZSIzAyPUfGR6MRzmgU68mo
         2tU+ma7NrYX9jo/SFyraR5PfsBRCENi27HlhalZJXEOm0e52Dyp8QFNhgyYoA+Ew4A05
         nDDO5RgIAbEwMU9D2z9wtkth02WOQi9qRFEWJgNmabdJb2y1EeRh0kiLFd1JlEl4n2Ys
         EqwqojRStZpMA6PwPeMesoTLaIs+Dc5eHFgghzxl2B4S3sA52RHdaR2V4dW1f7lmW8fE
         OnJ4quweiF01soswFki9Z3fEZTUyzbJz7rxQW6xjaUcl9ktI4mAQwfTSRck9UiMM6eFv
         10lw==
X-Gm-Message-State: AOJu0YyqBWZ2Ekv5gLNVUj6z/V7SNoJnYbA6/shq5RZLiQr2UIzyjgAK
        /+wrsrrB2coWWixgxm/c67hOJB7T4SSNBURR4WolWA==
X-Google-Smtp-Source: AGHT+IHzJEqXtPBsPW5jLeFQcrS9Dk5aUh3URVKOBbbZYM9R7XAZ4gEp09I5Ct3eiDOjHZCwgOeYUuK9STXkvNcsKSs=
X-Received: by 2002:a54:418a:0:b0:3a7:45e0:c0eb with SMTP id
 10-20020a54418a000000b003a745e0c0ebmr2846439oiy.24.1694803544202; Fri, 15 Sep
 2023 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230915121504.806672-1-quic_srichara@quicinc.com> <20230915121504.806672-3-quic_srichara@quicinc.com>
In-Reply-To: <20230915121504.806672-3-quic_srichara@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 15 Sep 2023 21:45:33 +0300
Message-ID: <CAA8EJpo6hb=cxJ8wTLf+fEc8B30dhT67XWbqiNrMoRfUxUnqSw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] thermal/drivers/qcom: Add new feat for soc without rpm
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Sept 2023 at 15:15, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
> enable tsens would not be done. So add a flag for that in feat
> and skip enable checks. Without this, tsens probe fails.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
