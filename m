Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BCA6903BE
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 10:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBIJa5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 04:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBIJay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 04:30:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7906187C
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 01:30:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3412325wma.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S2tEZY/+Gh2ONdU3efg4qsNBAC+f01To+72RyrqQtk=;
        b=SuYFJ/yKQ6P6blJ1jUuFke6n5OanTxNfGPYPa81DzdLkC3craqq6JtmUTBBNj7eYxX
         tnOfr6SRj61kqFevdnRO4Vdkc6iEWQ2Rhn8G1ThorKe9Ew5BVUN/VLuex9uoZ7vin77o
         DXsOG9uVqf7agpnf+naq928Qu5x+wFG+Dr4ZF+RYhoJitxLPV1kOoZYmlhOMaRHz6h9V
         np4l/RbW/71gbOo+UcSfr/cgueEtszAv4/CdpJLz7ZfK+ydoUsbbuNve7EGWcfUCq5yK
         px1PEko5/Jx8KaDN5wqlYrzr9OZgSUXpv/5+wVbByQkpUT3qfbFL0kt2ffDMzZ7DchQI
         y9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S2tEZY/+Gh2ONdU3efg4qsNBAC+f01To+72RyrqQtk=;
        b=vfLnlM9ma/yc9hdR206a8DINILNRlo2t7qX9KvodPBa7wnEgHx9QzyyCdHhYRfCghl
         RogZN+DBFMQqM/LXTDhqUceaMijGKZCw0odqs5J00VKvDJD/9JoUX63yo2q8EI+0RMdG
         AE4A0cJa27U3pxulOeBk1uUehAJN8SE5S1SqoGWypzWExear7VCaRDK1d7DQnKkN88Pe
         YgUEQ7JQay5zZPuao5lPwULmIxOx5PNsQpMBLZa8S5Oz2hpBJpmZ28K59IW6iDFRRp4n
         KkM8uDUPH+rr414x3iXVG5M4y34DdJKm6954+Y6WkfEEFKkeaL4iiD8IY6fQW0nhqOfP
         bQuw==
X-Gm-Message-State: AO0yUKXZ3qtOp0mrtxnZNxqF+jXVwuZzM6YTRC8jHHpVuZ75GDMU8zAJ
        vPs8tvLFgNLc2/RWgUdzwUMyUQ==
X-Google-Smtp-Source: AK7set/MlBPwn91apQp4haw/POYdIlQZOEUXPjg95MyNta9JNaTilJd1y0F3YvYTPBWaRho7alLDQw==
X-Received: by 2002:a05:600c:2a08:b0:3db:1d7e:c429 with SMTP id w8-20020a05600c2a0800b003db1d7ec429mr8968183wme.40.1675935049972;
        Thu, 09 Feb 2023 01:30:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b003e00c453447sm4477965wmq.48.2023.02.09.01.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 01:30:49 -0800 (PST)
Message-ID: <1732069d-5a0f-550e-6182-3d4c205ea25c@linaro.org>
Date:   Thu, 9 Feb 2023 10:30:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 08/11] dt-bindings: net: dwmac: sti: remove
 stih415/sti416/stid127
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209091659.1409-1-avolmat@me.com>
 <20230209091659.1409-9-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209091659.1409-9-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/02/2023 10:16, Alain Volmat wrote:
> Remove compatible for stih415/stih416 and stid127 which are
> no more supported.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

