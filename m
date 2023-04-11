Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7B6DD20C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Apr 2023 07:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDKFrp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Apr 2023 01:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjDKFrV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2023 01:47:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1797E3A8F
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 22:47:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sg7so28859949ejc.9
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 22:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681192014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pS0YHLfeqUXxXueVr3xrpqfYzfFGCjkGT7qYBY7SpQ=;
        b=GVral6enKQmYqWeI17NidZmmODtmBgPO48BHtpOhGVXebFO7gIcRgTB485y+xw7YrY
         zV8iPV3ZQRCorR2soGJtBXTEe5Wx3tuUVt37a5SE5AO3UZd5FIrCOX3qtp8AHyAtFN9o
         4aJVXZGGpEjSjOO4xAU8Is13FOekSNuuZcCr7ynfyza0ftmnT5ZESjFl1kFEvVG5/f4t
         YX0unimqbu8SUs0t1t5jj98lWXmrO1PjR3yBCEUJtqfVQ57Q3/v7n3y2GMnM93I9+uCb
         SSjuU7UN0prH7hd2Jz7jof+tbCMrSqJWqdcROJQp2IDunLcEpZQcH6sSvqvdl4bjzQYG
         4RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pS0YHLfeqUXxXueVr3xrpqfYzfFGCjkGT7qYBY7SpQ=;
        b=ASkhipxAvqdkvOH+pXmrqB5gVOe/KDOU5D2KKQwVjXBSfTZ1VFptJF/mFLWr3uF2dX
         4uKY6WH3q/00eX/2j3LneIsCWxpHwt2SdGn8+N0j5hWLlJBo3sAQEVLHcNOOG0MNz5MP
         chqH2b5N55BLxZT+TL1wJOIRN286dQqwRETPDKz4wMlqN9fZNO5g+eGAf5A1jGJwWqvW
         XNqCo2f+mOOpvpBWuEScEJi4xYfShHZZ+Pl5wPFBsDIHvIHIPAkkg8pVVto2jWtbEkt5
         6JCdJ0oIYFuqrpu4p03DRB3Dp4H66a0jRX4XMzudhOxpa/+3pmafZ4s2uZDIyNZpdcF7
         eUvQ==
X-Gm-Message-State: AAQBX9cEx09ovLSC8Y2EFPQrEJ71qfPFQGhP7N3Lkhd0EMbT+jsv2qHE
        ymYNgnBZ3SPStcYJNr7vqV4lHg==
X-Google-Smtp-Source: AKy350a47ut/AkoSQIwjbjtHVtAuQPe8zGjAcqV7+PVPlBYc8n00LUtmFdTEEoQ6FmCGLG+TbipydQ==
X-Received: by 2002:a17:907:a44:b0:947:d3d0:ae1c with SMTP id be4-20020a1709070a4400b00947d3d0ae1cmr12030744ejc.0.1681192014573;
        Mon, 10 Apr 2023 22:46:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id xj11-20020a170906db0b00b0092be625d981sm5756333ejb.91.2023.04.10.22.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:46:54 -0700 (PDT)
Message-ID: <a0a64ba0-cbd0-1e43-320e-a9036da60613@linaro.org>
Date:   Tue, 11 Apr 2023 07:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/6] dt-bindings: serial: fsl-imx-uart: add missing
 properties
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-2-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410205803.45853-2-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2023 22:57, Stefan Wahren wrote:
> Currently the dtbs_check for imx generates warnings like this:
> 
> serial@7000c000: Unevaluated properties are not allowed
> ('clock-names', 'clocks', 'dma-names', 'dmas' were unexpected)
> 
> So add the missing properties to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

