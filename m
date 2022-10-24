Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E676660AA1D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Oct 2022 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJXNbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Oct 2022 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiJXNat (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2022 09:30:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35273ACF68
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2022 05:33:41 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id l9so3392626qkk.11
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2022 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cN6ievQ13OKelgQO9QAAFjWOVAIp8kFl6S2NHqMvnjE=;
        b=LHKQ5P4Tj7SB7wxOyr0cPnL7Lw8ep/oRa1X6oDKGwCzAm5Vmpbd4FV0qhA2ld6wYZ1
         HMoYvJm4hO2bzFwHaAlRSRkxHjMSGMqlkOL8cEEOD7FUo6drKtHWFiuH2ofO2jtQy5lP
         qEqaD/lEcUCgHuanQPpuMzHeHuh08Wl+W+4g1bmrQVNFbmQOb9e7Wt6CtA3ootl2X2EV
         PQgyB+8JsENxJNgEf8rjjNT0tTAx5iQeKbspRIhTT4dpbYHumEMxWSvs8manl+XBkmZ8
         ZhXCD7yhmyZVhl8tKYbbGjaRZomARDLLrbR3D97tRGdEshm4ntOmtGvJ0CQx3eLIwf2D
         MzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cN6ievQ13OKelgQO9QAAFjWOVAIp8kFl6S2NHqMvnjE=;
        b=rCZxBANtxWaoYXyrLyCK8nriHqQVL5apVL8l98us7vgEy2TDs6BeGldEWSU+qJGTK3
         fddR+MaP98CeOU5q6msgi/7eorNz/m12jlKkTzQ0TppgfG+0e2vjdpLA0HqQQJ6Mhtei
         oWZm4kiftcfwCN0V8pBg1yLtIfh56I6fMP1mTwg7jOgmHGhXc7LEf78XsjJjyv1TGqeT
         BM9NIzILH/IwtkLBmyqdSly8TDxlIhdn1N97V9bGQe9D4HGdEuG/sdgZPqEhmZBdEkwl
         nk3kMH8JLjcYBPcnc0z9yFmJBUN9UrH+BplvNQlpStcwKf2LIM4l6yueHbmzcmECDhEN
         6pew==
X-Gm-Message-State: ACrzQf1/ofInH2ljU2EuWfJAg29GP46kekGr0qZ82Sg3jrXQIMft8aYn
        NuohDhhtDINVbbmSDBsJ8CfssQ==
X-Google-Smtp-Source: AMsMyM5LZH9fzYpnRkQmI9ibZVvwW99/0fwSADaB8HWLnzA5NP3HlQNPHGWawkh79UOs7VJEuo47rw==
X-Received: by 2002:a05:620a:348:b0:6ec:a429:cc88 with SMTP id t8-20020a05620a034800b006eca429cc88mr22650579qkm.648.1666614686900;
        Mon, 24 Oct 2022 05:31:26 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006af0ce13499sm14986172qko.115.2022.10.24.05.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:31:26 -0700 (PDT)
Message-ID: <c4af67db-c7c1-84bb-c5c3-694098946bae@linaro.org>
Date:   Mon, 24 Oct 2022 08:31:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 07/21] power: remove s3c adc battery driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-7-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c-adc driver is removed along with the s3c24xx platform,
> so the battery driver is no longer needed either.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

