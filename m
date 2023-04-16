Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36F26E35AD
	for <lists+linux-pm@lfdr.de>; Sun, 16 Apr 2023 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDPHW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Apr 2023 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjDPHWz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Apr 2023 03:22:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8361B9
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2023 00:22:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f3cd32799so33264866b.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2023 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681629759; x=1684221759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYDxilSTHaRNu/QgbMDlDSeJD/Woe1fa6dDJJoFZChc=;
        b=hijSW0/rWZhdkjeIw70R1kDpgT14X2TYMccOV+G1GQqVDEfg2VnGZjdT86in8TLPl6
         qtGAjMmbU5QAx3cZ7hr0BS8X1YrxVnvWvozFVP4IJiqHG1RhbRDwkmHA2L7IV/PH2ozU
         JcovnjX7t5xMbR5jGa7eKVlnGOhszbrVBCbw5B7Bj83KrfBNypqgqlRo4zUw99T0b8HQ
         F7Wf4wR+mju6gV3H9wd+fZrBqlPbMGZw/e+kRFgkEHEruCs3fvpks8ip/Iga2IHzQP/Z
         ZCZT7To6kHQWu5J57sbD9OskkbB3fXwOTahfWKwUY3gQ7dQqHPCVxNVEGCFvl89yz9fY
         7sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629759; x=1684221759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYDxilSTHaRNu/QgbMDlDSeJD/Woe1fa6dDJJoFZChc=;
        b=GA+bxJ1dQxiYXXnOrbAGH5zMM7piL/Ru64ufuSkSSWmJoZFoF2DU//L4xrWqBWvEc7
         ynMp+jFm1/c7qf6YA8Qe169lEaSAqg2wjIKDoUgAq7Eqy2rs4CxKGnTWSbS2UajMFyYy
         Q9JN+J0D13sah3PlPlBbMkWDaOjpyvcJiqtuXhgot8U0ADOrr+HoGaGZMKfXLap64YU2
         C5FqU5v3lAq2CXSGV/+0j7P9C/wlsX3sRmJW/CPA18eCZSsPHN0FLQ6O/am5IQ6OmWRt
         dE1R6iV5vzqlltT9ZLG25sM68miQcFuyMbW4CHQIXUkdBAoxgDxJo6seFe9aHI+u/rLY
         vT/g==
X-Gm-Message-State: AAQBX9cK3lGXE+x+bUiKv6P2Z3pP6/jPzmTIyWndrFaGtuUX43nez2p5
        vmbuua8qMWFMCvP9Cp5Q5jCODQ==
X-Google-Smtp-Source: AKy350ZwvcJakDdiPiyPhnoLn4iEzxClKiG5egL8E5c/oSMmrEKGt/0Rv53gAMAwGErfQMChZfncpg==
X-Received: by 2002:aa7:dd59:0:b0:506:77e6:c9e5 with SMTP id o25-20020aa7dd59000000b0050677e6c9e5mr8367392edw.8.1681629758946;
        Sun, 16 Apr 2023 00:22:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id x7-20020aa7d387000000b00506a3b5d1e3sm290585edq.13.2023.04.16.00.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:22:38 -0700 (PDT)
Message-ID: <8e2fcd4c-893c-b5e7-47dc-d4b87c0bf3bd@linaro.org>
Date:   Sun, 16 Apr 2023 09:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/6] power: supply: max17042_battery: Refactor
 max17042_external_power_changed()
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>
References: <20230415160734.70475-1-hdegoede@redhat.com>
 <20230415160734.70475-6-hdegoede@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415160734.70475-6-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/04/2023 18:07, Hans de Goede wrote:
> max17042_external_power_changed() is a wrapper around
> "power_supply_changed(psy);" and it has the same prototype.
> 
> Remove it, replacing it with making the external_power_changed
> callback directly point to power_supply_changed.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

