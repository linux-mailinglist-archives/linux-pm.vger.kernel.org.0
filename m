Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA16A513138
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 12:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiD1K0a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiD1K02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 06:26:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDC20BDB
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:23:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l18so8594980ejc.7
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Q0r841q8Lmj207L3/SuGuqZgNI0g9j5NTczRIpmDaEw=;
        b=R9xSeKE68VTgVWlDJZSjcG7dyqcla7RWBQrLbvg1sZfaZcgtu0Ud7RtIlTswsdpAos
         zvu24qu3TOTRdih5EtF3rjKxIznFoFsMaYpvhAysCRx9ybBJiKT6g7sUQktOhZdsVf5L
         uqpjtxmawQQf9f/1uzw+1JTbt5LGpiTfF/0XH+ySXUXRt+Z/H8PfwpCI9p5fEh0fUMFb
         L+d67xGvggiCg++e0CfmLbqhSdsxm8gHh1yl7FdN5cr+zZxpEWz26CMXHXQFHAjiypOW
         0zDScN5vMElHsiqcYn6ituCJS8Pn2S0/mV1phN4OaXLw+5P+iHpd12bOcruQz1sj2nZx
         3/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q0r841q8Lmj207L3/SuGuqZgNI0g9j5NTczRIpmDaEw=;
        b=zoB9nhOXLFGeSPSKlbHWL3SSDqG7ImtJLvpOcr90T0kdLC3jSH4ggAPhoNV6JRFjxd
         zvpq0v/XXlVXf/Ei/ulZ2BrK/ChBJcQJscC6o68PrDeWrIzmRUYPq5LZkzDukYiRbmZP
         FuCHeA93qfj+U7xhsD4Yen363jBB8H4Xzsq9nHjtEQ7TKH8ltsSuDo7uHc/kTEEjRkFb
         X4znF4MgOEtEeNRm/zazoN6h/zp+Cqgtu3X/8lXMWX/5VirkgJhT+bGb2CiX+g4GL03k
         gu5T6tCng+WdBOvtK8Z+zb8qHv1Ug9zlrNMdfM1rcQCC5qJPc1lN7gjUla8gPl89jYio
         e2cg==
X-Gm-Message-State: AOAM531OLnY2cuRWDylBM74OZnksYi7UgCX1T5OCa8pXBVF5kxjwsjkm
        8mLqbvNysn6xqHq0ILBxVAwWqqeF+V1Y6g==
X-Google-Smtp-Source: ABdhPJz/LCaM1IEwSnXb6OQ38sLpgLyZHrqkqQfaA3KS4ii7yW32/U8imRnZA6jMMsEd59dFqG45oA==
X-Received: by 2002:a17:906:43c2:b0:6e8:47dd:47ed with SMTP id j2-20020a17090643c200b006e847dd47edmr29964740ejn.600.1651141391346;
        Thu, 28 Apr 2022 03:23:11 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id le4-20020a170906ae0400b006f38734cadbsm6355463ejb.136.2022.04.28.03.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:23:10 -0700 (PDT)
Message-ID: <e77d9ff9-67a5-e0f3-8ad8-848342ed4dfb@linaro.org>
Date:   Thu, 28 Apr 2022 12:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] interconnect: qcom: use icc_sync_state
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427145616.523557-1-krzysztof.kozlowski@linaro.org>
 <4769c796-6edd-c23a-ee2a-ce54495548f7@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4769c796-6edd-c23a-ee2a-ce54495548f7@kernel.org>
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

On 27/04/2022 17:34, Georgi Djakov wrote:
> On 27.04.22 17:56, Krzysztof Kozlowski wrote:
>> Use icc_sync_state for interconnect providers, so that the bandwidth
>> request doesn't need to stay on maximum value.
> 
> Did you test this? In general, we should not enable this on boards that
> do not have full interconnect scaling support in consumer drivers yet.
> Some of the interconnects could be enabled by default by the bootloader
> and usually later during boot the consumer drivers request the bandwidth
> that they need. But if the requests are missing, the interconnects
> without bandwidth users will be disabled when we reach sync state. So
> this may (or not) cause issues...

I understand, thanks for bringing this up. It does not look like an
issue of interconnect provider but instead consumers and DTS. It's not
the job of provider driver to know all possible uses and DTS files. The
driver should expose itself and if platform is not ready, should not use
it by not enabling the interconnect. It's a job for DTS, not for the
interconnect provider.

Imagine some out of tree DTS which cannot use interconnects because we
assume that all users of that provider are missing bandwidth requests.
No, instead provider should allow anyone to use it.

I understand my change might cause unexpected issues, but it is still
technically correct, just maybe should be followed with disabling in DTS
the providers without proper consumers?

Best regards,
Krzysztof
