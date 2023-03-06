Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2C6AB8ED
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 09:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCFI6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCFI6G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 03:58:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8B6E87
        for <linux-pm@vger.kernel.org>; Mon,  6 Mar 2023 00:57:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec29so4515959edb.6
        for <linux-pm@vger.kernel.org>; Mon, 06 Mar 2023 00:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678093078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6F53wrsACQC+LR20YnHsX5rrYdEyGRK9ztMiX1JcGY=;
        b=WMmacnWgPKRbYy1Ohg3aZ32j8NOr5zrFtfttZ2on0EOu3UPSS8vO3xMgpVKzoM3edr
         u30+6abePYPs5sIg0UFFgGgJgB+2osEby1tP1csGk80DUazDJqOc1oZd6zIRM23H69dU
         mJy+At0lfJl1pkutM3U0qXfdU9gFC8mBkJfQPW27vK0ojw0gHXw2BI+TPZO85bLzZBZK
         RmxrvJQr7mqZCrN5StL+PBq90FkU5rU86xC0oI3IsUc6ScSyRdyCF+I8OCzTssBykuNC
         4ALTeivPFkcW2pZ22Wj/+e0IkR25lfe30xRcduBXFZs3v1FON0p+dwPyp8kzDhuiikNv
         gkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6F53wrsACQC+LR20YnHsX5rrYdEyGRK9ztMiX1JcGY=;
        b=27Nfq4yVzjQ/7SGPg9XRC+Zw4w6NlGrjrN7uzU4L5WLeszwAAQvYmMwYLG9Dj4gzgh
         c/vNcoEGjyc3VXdz8pYZpcrZI8HaqvwY82xnRMpDhszBuGFRpzSHZCyn+prncpTrIFkG
         3uXRoxqBfpIuuqDtA8njw0qZQB3lEAhmyb0/E8HDYvHqhdsBO9nVFNPRSXaKZMwK5/AO
         13+q3az5qM5INT5v/n43V/Z+RGMzQDAgkNYlwI0hNxx/1g4pZGCH4RKO4hfYHbBLmtwn
         Qtbb71vIeoa01yUM1YGSg5HDIs7nA9cnmrwQ/lpoXBawaJIQDH2oNLK2MuxnrMJ4+f4q
         YBEw==
X-Gm-Message-State: AO0yUKUA9liL3Xw63RJflog2CovZ3rM/EwmXUJe4mJi1FGjRUMQQX3y7
        kAYHdW+c7A3gEThTK/LCmunloA==
X-Google-Smtp-Source: AK7set9ldZmVT38SmjM5T8orPAnOxovIASfzyFxb+qQK7VUsl3kW2FQqZRNNAFEOvryKstOl57bh0w==
X-Received: by 2002:aa7:d342:0:b0:4ac:746e:2edf with SMTP id m2-20020aa7d342000000b004ac746e2edfmr8846537edr.9.1678093077791;
        Mon, 06 Mar 2023 00:57:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id x20-20020a50d614000000b004aeeb476c5bsm4106625edi.24.2023.03.06.00.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:57:57 -0800 (PST)
Message-ID: <6137e007-a474-0ff6-f3e2-368ede73d879@linaro.org>
Date:   Mon, 6 Mar 2023 09:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/15] dt-bindings: thermal: qcom-tsens: Add compatible
 for SM6375
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
 <20230303-topic-sm6375_features0_dts-v1-1-8c8d94fba6f0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-1-8c8d94fba6f0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/03/2023 22:58, Konrad Dybcio wrote:
> The Qualcomm SM6375 platform has two instances of the tsens v2.8.0 block,
> add a compatible for these instances.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

