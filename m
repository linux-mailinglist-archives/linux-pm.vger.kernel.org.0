Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06FF7A1EF3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 14:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjIOMni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjIOMni (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 08:43:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F3195
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 05:43:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-403004a96a4so23322245e9.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694781811; x=1695386611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSaEjuQP3bJaj+tuqC0EES7njvk708CPwg4r5YZVC90=;
        b=RJtSTweIDYCcI4lrfEC0/wQlBeRJ3Bg17nVesialsmzNF70TzocO/KqcoHBaQPx3H6
         U6zGs1N5g3QDI0Tcx3sJJ7L/rYrhY1GLo0AZWB8Hd1sUbyXR5/9posONW1hE6U5jbaGE
         TACB0ATgmzzypbbC1XXyzXjsn8Wky5F+p9FXo+KPhqq98SVABlhQK1pXDaQgaLLzuLjk
         0yVB9S/Auu8pkrMYUyhuhGv/93gZgY6j3BXRaKE0q7n/D93Hup+Z5tz0w0zpj6xQsb74
         XGOk9NK4P43rkZJcsp0Cjdp0MSl8y3dXN7XMYteO0CFMeoe2JcSG4LwsyQvBU1AwxVJX
         dWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694781811; x=1695386611;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSaEjuQP3bJaj+tuqC0EES7njvk708CPwg4r5YZVC90=;
        b=wKfwJVMGa5hOiknCl4K3cvsMpIQoMSm6RW6+QxH10cbJFWrCLUB4a6SARufqc3N9cd
         L+orLbZGDKtHAUo7gDGf7Mztgqc5pZ30nywYsvPms1iExh3SBNwC7OM+5KEWW3CRj2m7
         GpCUzFVmU2sk5Yrko1j8xcCs+H+S9nl13jMM31zW1XYkPHheVhFk/zju3SfZyM0syM5q
         W8jIkQT8Ef5j7uOOslxnA9BS6XdQ8bbos8KtcNkGsts/6hi5Kh9rlP0lx1Pj8hP84BJ6
         Dp2pxTZ6xVDXlHWUCYlYMNOSxLkAyuB7Q2VGLfBLZNWnOwDMQUIDaEsfuORiwfwPd71m
         VXhg==
X-Gm-Message-State: AOJu0YzZipgAlan7+SxaSKa9iSUDJwy1Eh7QqfFlYjOE1ufA9Cb9qMhg
        CgyNj2tPBeGVFFGpwy2V8nkVuA==
X-Google-Smtp-Source: AGHT+IF2jyol6SrjEHegYj3kBq8qaNmHDS6ISO3rBYrj3clB5oMirv1vXA9GlH77lXUYqUG8NobeRw==
X-Received: by 2002:a05:600c:b5a:b0:401:1066:53e4 with SMTP id k26-20020a05600c0b5a00b00401106653e4mr1470885wmr.38.1694781810769;
        Fri, 15 Sep 2023 05:43:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c1c9000b004047f3b73f9sm997698wms.21.2023.09.15.05.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:43:30 -0700 (PDT)
Message-ID: <03b0cafa-49c7-8838-b116-927c9649cbd3@linaro.org>
Date:   Fri, 15 Sep 2023 14:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-2-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915121504.806672-2-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v2] Sorted the compatible and removed example
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

