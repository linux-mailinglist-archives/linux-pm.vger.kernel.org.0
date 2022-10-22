Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213D2608E77
	for <lists+linux-pm@lfdr.de>; Sat, 22 Oct 2022 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJVQZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Oct 2022 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJVQZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Oct 2022 12:25:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F1D6714E
        for <linux-pm@vger.kernel.org>; Sat, 22 Oct 2022 09:25:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o64so6532610oib.12
        for <linux-pm@vger.kernel.org>; Sat, 22 Oct 2022 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzLyt5KfVsh3C7/6psv5Axae2ZfgYzJFYNPQgsCwAN8=;
        b=LdemYcLSDbSaXNV/CjOK/zFEEfU+FnjOmzQvaW5igezJetDTDh1c/ltQ1d5TxPSD6Q
         KMyH94CfzBVhND9YZTyWT/2GugBos82fuLDwZCc4ObnLahqa1eA5eryaIEe7YxtDep09
         mGV2p7UIxom18re8/dFcoVaPxtCDR2TTPo4l3lHgDMDehSP8PgK0CdNaCqv4Ay1IXGqK
         0WdjZwTRu4962MkskdEgvf0YZbyGkdETnim3vh4PX5ot/bKidVVRLS8CQCQNn6f7m+um
         P/a3eBNCfGrqKwxWEHUTwF9MibTzgBSpo1b0RvrJO93Xbze56admw1ZuQl+Lg6XXLJBW
         L7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzLyt5KfVsh3C7/6psv5Axae2ZfgYzJFYNPQgsCwAN8=;
        b=BwlIrrUvkVCLELD7Rak6f6ikAf7d4Gxod0CSI8YctAuF9IP9434BWjg9qYOK6UKNRB
         9Jd2iT4wFSrkzHW9Aj2N9Wug+sH7r+nrwTDVj5Y7/t1QUuj6NX/VMpIxRDg22kfSd+Cv
         lQEJvgzer2zBf9GEfCNHU4MlGywEmaHWZvIJqKspwhdk2tQPHzaLb1N8GWvUn+nw/zEQ
         enDPHrItqwRpkDc3rU+5WEYCsoS16fO7DAankTAL9HOsWpgX5mSUXaUMHgX+x2GyexPW
         ItyFDJ5WXokqsO6LsWqfbD6mvmAOLjlBIWA5DP8+70wximx3Yn7GMJJZRpz/juTQWYNc
         EnmQ==
X-Gm-Message-State: ACrzQf3r2FCroTrGDnmcpyPHu+YsowtmFYld02ErFOFNljGEAZDVo4n8
        4h7m8Z7IOs0gwKrzICuOXqbRGQ==
X-Google-Smtp-Source: AMsMyM6G/qBQ5q+e3exrCCY2O2Iwx3RvA6R1ab3lI2MiOifZwLs0NLsdCDsaszoZddt7PqF/v0GliQ==
X-Received: by 2002:a05:6808:b31:b0:354:9436:2e52 with SMTP id t17-20020a0568080b3100b0035494362e52mr26858262oij.1.1666455864517;
        Sat, 22 Oct 2022 09:24:24 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id ce5-20020a056830628500b006619dd066fbsm2421041otb.5.2022.10.22.09.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:24:23 -0700 (PDT)
Message-ID: <dfd381b7-bfb1-732e-d3ca-9ed463c55bb6@linaro.org>
Date:   Sat, 22 Oct 2022 12:24:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-thermal: Support the RK3588 SoC
 compatible
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20221021174721.92468-1-sebastian.reichel@collabora.com>
 <20221021174721.92468-3-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021174721.92468-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2022 13:47, Sebastian Reichel wrote:
> Add a new compatible for the thermal sensor device on RK3588 SoCs.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

