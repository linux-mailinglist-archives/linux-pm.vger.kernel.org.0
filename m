Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5534178B86E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjH1Tdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 15:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjH1Td0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 15:33:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B4B4
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:33:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-997c4107d62so463450966b.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251202; x=1693856002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXKJ9YSCjc+uvpiGbHAU6z0Pnzn1Gof/Cxg44Dd22MU=;
        b=kgWRDa5GDd0Aj+nyg+JUQbLe5nBZ4OWVsxNaMKUgRaCvMpVlae5b0gkwhgy7N+dl2F
         WePZTOyQl3EtJTSpufJ2ZUlRh8maRgkuAV9lZHxsqLzaASB0/aKPZjMNux3xFF80swF1
         IlB04OxP8z434/crCuzUaRRJxFXcXBCW57F0RJJFJNH7tXg11t+/sxcBm12S/Ht1PA7C
         WB5RKIYfFtHlB+ggcMtD/xI+ZdtJl2/8iEDfSUQX+Kk9wtNzpm/Qsu/lGbM2wPyA89xm
         JxOjmrBJFbsBGqa69UBljK8sVi96RUONBJkJsBkSvMxaow8oFKKE268bLWFp4Fcj0fwK
         7mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251202; x=1693856002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXKJ9YSCjc+uvpiGbHAU6z0Pnzn1Gof/Cxg44Dd22MU=;
        b=Ps382vx+jJMjGKutOo0URTCWt6fVBDJ/w10b1VWLdJd8w3JWYyOzahwoV0N4dnMzLK
         q9o3AXJEeFCM+eHyBqUeJR1eX+rW7XUiWy4BZwg0gAl/2xiaEYUzjxoua8htk05ZOcv2
         o+bKh/m03Ys9has/BWnDHNOSYqCuy63vTLYJ62lUPhd//yM3BdvD/uCdCQkaokIagpvX
         JG6dF3gCldAWCAWxZLnIQtUeuZMpXnz+N8Urk7/WvaT10pDPnqs778pOmgEFCvfkpkNS
         ZfLDjIqTQm3clxvRNr03REH08ArbeRx2SHKDO9hf7JjMBGVaY3/53mGnH4xC2NwMPcuT
         H7mA==
X-Gm-Message-State: AOJu0Yw6rjR1qsLAbcZL66VTMQ0bjxLGIxO/yIGVDUZofYgzGW1GbefA
        7b/SOHMzLTXTTp0j/eTdeKXFVw==
X-Google-Smtp-Source: AGHT+IEgBOCwkjHNLDNFijHoMW/wM1nrW+YrqvIQrnl/sFAbs0FySay/NbJl0CtHk1RSx6qwczSsKA==
X-Received: by 2002:a17:907:7895:b0:9a1:f58b:96d9 with SMTP id ku21-20020a170907789500b009a1f58b96d9mr11327518ejc.58.1693251202274;
        Mon, 28 Aug 2023 12:33:22 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b00997c1d125fasm5060429ejf.170.2023.08.28.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:33:21 -0700 (PDT)
Message-ID: <d9560045-5c8e-96a6-48dd-c97190d0cdd2@linaro.org>
Date:   Mon, 28 Aug 2023 21:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/7] thermal/drivers/qcom/tsens: Add support for IPQ5018
 tsens
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
> The soc does not have a RPM, hence tsens has to be reset and
> enabled in the driver init. Adding the driver support for same.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

