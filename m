Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC314B5775
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiBNQyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 11:54:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiBNQyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 11:54:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243A65152
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 08:54:04 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A50A40335
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644857643;
        bh=Z4S/EJbvQ1weqsHWE/JQuNYq7y3Ue8zFIgR4/tFO2mA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=h6HGD6x6Vp5W9HmAl6ZKCZuxIYXPH+As2Gofc0sFyrzLUHYso568ptKjMCrLtRaPg
         npO5CAbxxSxqbf4k4TYYWX5TLxxTOcaL/P/DOK6OUCMxmbJVdAYjRZhLt1tjb1FohA
         2LMz72r5A21Oeia4TXH4mv5bJsf2gbEpMYgJKL2lj+xPhp6BDfx6nsEmNQeNI7umxs
         25h+qgamtJK4YLDOqVtA5YPUSx7cNT/Tf1Kolmz9hh3wkHXJOssVjlYTsPVSd29/PG
         pSaBPfub3Fqn1L5z8QkqKsJ61ahCbow0WspNs1RZ9FnqI6mFEOmHnjLGlGlQSJUbRS
         mj+fuuI7gFkUA==
Received: by mail-wm1-f70.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so5249334wmi.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 08:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z4S/EJbvQ1weqsHWE/JQuNYq7y3Ue8zFIgR4/tFO2mA=;
        b=fzg7nZULcUhMJ4aygM/I2MEMgduKS3mo5gO8ewUPOH5ZihZGVoaNcpRS3Wi1foy6eX
         iz/F1761ZFjbfjuC48Y8WNJGTLgptgXCwd7Rg02p9Z5ncVIBcAiOI9x7WKDs61s5hjp4
         kTgdzA7mPyXM5PsLWjPiiigxGM3KT3h4ISK6/OdJ/OGfXFfoMXgkseRrWcTRtgCZx7EY
         dKRJtH0Cpy5Gy486Qu3oNdPF1mpYRlQAh5Kcuc/EHWx/mZ4MgAUzpTMocpt2twPTFVul
         03ywfz3KKz8hRUOp9CSHzEKodsqlApCqocUhb7ypl0kGRKlQVbnrZTPAVor5hMEPQ3pk
         Wn5Q==
X-Gm-Message-State: AOAM531be+FGcs7sGFjGB78KU9aJXhcZHamfggV4VQwNU7v3VQg/I0Wu
        dUzqV3wccsGGPxbsfdPffhTC6QcsdIk6kD+mW/+MJsjf5HN6yXQx7roVMTBmsqYZhpASlu5j6Ao
        jfdDml3H1BDQ8D9ihzroP0gXul51UVM/BLyUg
X-Received: by 2002:a5d:4485:: with SMTP id j5mr406257wrq.495.1644857642744;
        Mon, 14 Feb 2022 08:54:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSf3b2QSKeODIAdKKEC369EQy5hjdyp/pGhW6kuWrBv4X2cL2F9qX6q7z2Gv0yC52ifPjbYQ==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr406243wrq.495.1644857642592;
        Mon, 14 Feb 2022 08:54:02 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y17sm12488792wma.5.2022.02.14.08.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:54:01 -0800 (PST)
Message-ID: <79ecad6e-d9c9-c798-0933-43da4dff9dd6@canonical.com>
Date:   Mon, 14 Feb 2022 17:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max14577: convert to
 dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
 <YgqGy7a/kq2+jZQm@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgqGy7a/kq2+jZQm@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/02/2022 17:43, Mark Brown wrote:
> On Tue, Jan 11, 2022 at 06:43:36PM +0100, Krzysztof Kozlowski wrote:
> 
>> +    required:
>> +      - regulator-name
> 
> Why is regulator-name required?  While it's a good idea for users to
> document names for supplies on their boards it shouldn't be a
> requirement or something that a driver would care about.

Indeed, there is no need for requiring the name. I guess I copied it
from other schemas.

I think this was not applied yet, so I'll send a v3.

Best regards,
Krzysztof
