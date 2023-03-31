Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540C66D1CFA
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCaJvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjCaJvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 05:51:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E322EA4
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 02:49:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x17so28167926lfu.5
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680256181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnWBUW3nUtZAoa8t2Uk9JsdIPMN187oJzfJjlXLN/3k=;
        b=SO47t4BrSz+0Ya2L17CY5aaGJmyu12XYH/60nMWB4NqBn/p8/0zEv2hk8YZTzilXHk
         K2leQyVkG4hZtep7CXRjOzCrcG0TVMTBy43uXEl2OyECJLd/oDYGMj6pdVf01oCBVVhM
         7k56sT52l9DEqL/iALbWu/GA2aCPZIj7dXv5qP5jV/UIBG2pdSphgv5t3Q8n2gXtJRpT
         3J4XmTcKq/flTsNoqwZHRLqMqXuRa+FLBI/ww3y7vhim775/t3V55vuY5AQS3vmGsct7
         pwqlA4dbd6ly7aLwYPlNpr2fY3kwTj3aY8REs3sY4aR4A3zgCbC5dUW8NeA8jpMt16yM
         tY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnWBUW3nUtZAoa8t2Uk9JsdIPMN187oJzfJjlXLN/3k=;
        b=DJin5dluIdjOpZwbCbXJ3EtOkkl40HZZdTYjv5LuVKzXuTcPu5o1r3WaGeyq3UZ0oy
         ZPqzmGTbNRE4naWUautP+oyvy/+6yFRTX63u1klFUfxRduH7HZH7H8nfTCksAi7uPHBP
         XM5HJSPvt9/j+SR4300CCnuJ7kaTKcYG0tuqXQFQr9xbGcxuTFMxnkqqqCeMRTpKdxBI
         TI4wAh7eLm1mBaFSOuqQWzADQRa0jhY57v2gl+vwMXUMTcX+9OgxOIvAyQOjlWkXCxni
         PgRbFrDZrmaYXnBga4zX04jt05hPWtPJH1uv6X2+NfGaHVBVv7PkQOVArSD4sx1RbgHH
         8TbA==
X-Gm-Message-State: AAQBX9dIQQifdCri4RXdroinKmUC2PXouGEd+6hEGBtSlQJmW6VWPiOo
        AIfJFtBDTGZhMDiYjEN2OLGUWTjMz2STRW+gmmo=
X-Google-Smtp-Source: AKy350bRaWmaWYv9VciLbpP08Z1N4J3jY/hl0ylFbIG8kB+HmxvcndpVh+yrb2bBTuHo0y3AhQEBVg==
X-Received: by 2002:ac2:4c95:0:b0:4d7:58c8:5f44 with SMTP id d21-20020ac24c95000000b004d758c85f44mr8869699lfl.12.1680256181030;
        Fri, 31 Mar 2023 02:49:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g12-20020ac2538c000000b004d85895d7e0sm313021lfh.147.2023.03.31.02.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:49:40 -0700 (PDT)
Message-ID: <d9043fa1-dff0-cb9a-afb8-8db9c3eeea2c@linaro.org>
Date:   Fri, 31 Mar 2023 11:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: bq256xx: Add
 ti,no-thermistor property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230330065202.1349948-1-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330065202.1349948-1-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/03/2023 08:52, Hermes Zhang wrote:
> Add a new property ti,no-thermistor to indicate that no thermistor is
> connected to the TS pin of the chip.
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---

So you keep ignoring my comments? I wrote extensive comment at v3. You
did not respond that anything is not clear about my request.

If you keep ignoring it then it's a NAK from me.

Best regards,
Krzysztof

