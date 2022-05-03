Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6756B518356
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiECLkQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 07:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiECLkQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 07:40:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CD834BA7
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 04:36:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so32805866ejo.12
        for <linux-pm@vger.kernel.org>; Tue, 03 May 2022 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GkJMZ1AatgkzyJOIYma5LzQUi/ZQfXkeQZsiL/MqtxY=;
        b=TerCOfSgmJOf82jrOKVHFXDkJKzh2PuKuFji9PBvXmzWIMTnM+isWn4GQhkFSnNjSO
         JFzR6HnZsbmLRv1waafhLQ7XvLju3f+VOUPQvXXp5y+jxHCPZxvMHfBa3mXvo2SHBa1h
         RGQpKNpX0er8jt+CbgpYDxjKt7IOLkfIQTM2rn8DRqABvLuz8AZTAVSLokp3Kmg6mJUw
         SYwss+7bsHYciG7PHLnPYaaq8SbHIqPbg0hfz7o1+YYcMJ5Dr7MvI4kgFaQKAgKGqRA+
         HsWEeVNJUKEQFyt/1prLx/PNEd+GcOUA9Js9q983f1R7uxmA//MYzmEzd7ZHISk3N9Zt
         x2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GkJMZ1AatgkzyJOIYma5LzQUi/ZQfXkeQZsiL/MqtxY=;
        b=rfLmi79nICtKehvN7ugMIqrtNtgzb88I3telWdbadXxhOzF+grrWlW2FjFUufbdU4g
         tVB8oas5CnZN1nGIP0ArdSxqcNVrBDRF9rrGLD1wJ3km+fIkmQ55/D6lqqSwhshD0j1Z
         jVRTOYBxYXvILop83P2sFxaz+7jTfhoNgoduU5D57qRWsiTX4GIblJh7rtntN4QC8589
         A9iUiDxKsxBcPJv0tDCYIMXq0JjsKxiG1RzzKQLpDHLmLvK9eYa5zFHbODiJMRxiZTYn
         pvCJNtJ9uW0aE1HTG5GEQPhBbK79N7cvUzZJBmXvSLrpfK+f7MQEzr6XFp3GAUeYtNpz
         e5/Q==
X-Gm-Message-State: AOAM530cX0aWYV+cSmIKf0fNu8g/qUOSS22fHwRAUDEuKNvhW2ohA1dW
        R6zdKTrlltsbCl7LH7huie8dHw==
X-Google-Smtp-Source: ABdhPJxBgFeVe6VSCA/TATmQ+PA7ew1WQmF4bsG9bklRM+vSKGzxIu8MTLOmMesMXjm51NdcPTet0A==
X-Received: by 2002:a17:906:c145:b0:6f3:9ea7:1d41 with SMTP id dp5-20020a170906c14500b006f39ea71d41mr15055660ejc.269.1651577802184;
        Tue, 03 May 2022 04:36:42 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id og34-20020a1709071de200b006f3ef214da7sm4564190ejc.13.2022.05.03.04.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 04:36:41 -0700 (PDT)
Message-ID: <a372bd7b-d3c3-ad85-11b2-cde23e2f397d@linaro.org>
Date:   Tue, 3 May 2022 13:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] dt-bindings: thermal: tsens: Add ipq8074
 compatible
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220501182200.47328-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501182200.47328-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/05/2022 20:21, Robert Marko wrote:
> Qualcomm IPQ8074 has tsens v2.3.0 block, though unlike existing v2 IP it
> only uses one IRQ, so tsens v2 compatible cannot be used as the fallback.
> 
> We also have to make sure that correct interrupts are set according to
> compatibles, so populate interrupt information per compatibles.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
