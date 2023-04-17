Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056A6E415A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDQHkw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDQHku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 03:40:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038DD3A99
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 00:40:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so4487714a12.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681717220; x=1684309220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOuJf1Uk2XVzTeZs33zX+691srOKO1AbhUKqZP8jH3E=;
        b=bD/FFEpVwIhN3pNSBZp3oeHUq+WS77cAz7PD/ZDAxvCN2FFkuT1Md8xPhUGKe3V14h
         KG2U6A26i2gEjFiIYpxVVOSGJ6vCsoDHLqpw+wPcwir9uk39FZSJFROsp5b9vErKDybJ
         fd2qa2dKD/pu+lZohU/reF67C6eliqsk7s6AdMgse9o7usfrvfePAr840Ucb+9KBgMNF
         9MwSrl4L6QmFXSI53P5U/syh7tDQyfs8u+xFeKcV5EOZ3zJFkM+c6UkSUW089UdKRsUh
         Wfi98fwzrmg0JUXmrM9uIl+Z5LnhsqdhR9shJ27fNa+ELDg4kk6iYumtkPvGzyywYlyn
         WH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681717220; x=1684309220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOuJf1Uk2XVzTeZs33zX+691srOKO1AbhUKqZP8jH3E=;
        b=C7+3HKqSkwqVgy50u6cI5FzPJMZb5rWyfKlGujlC0lA9HBwoxFNjePr55uOFLpi+H/
         9jKbmqGUZ5CsShPi8g1PvNWNuC5GAmEi3GSygMatdHuuI6pWbT2rga+ScqP3/evLxA86
         RrAM9HGb0AVwagw5+S9YCsKq08B6AdbL1bi2NVomgjgp5gVpBQOEja3/qkkLwVp7DJla
         uzIAbK0qQrIQxKGXvBw4sFJHggTrkH43/5Rah8JIAQZDiP9QG8EfpSljka6j5H96x1y1
         fy2Iu5VP6wjUwSgU8j0WMkE8IJL2rFnETB04uG21qOihOetFcn+r4j8ECxbF6zEIJLGH
         bYPA==
X-Gm-Message-State: AAQBX9eer5QNVwvcK3Rc2vrj4zAHpRlqZLx/O8jh9rnEfpgDEVRjXcFK
        Gf5kK/88MCYNKlMOz+jcoWRwOQ==
X-Google-Smtp-Source: AKy350Y85eczDG7Mw8aICC9OfwA8qtxoVQbiQnVpgM7S2lQj5ctUHXmf9vdwjdbGCteBPpkM0yTRwg==
X-Received: by 2002:a05:6402:1645:b0:506:8d35:40b7 with SMTP id s5-20020a056402164500b005068d3540b7mr7121155edx.8.1681717219986;
        Mon, 17 Apr 2023 00:40:19 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c18-20020aa7c752000000b00501d73cfc86sm5527649eds.9.2023.04.17.00.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:40:19 -0700 (PDT)
Message-ID: <c240cbef-1d9e-dc1b-b619-c22dacf8d41f@linaro.org>
Date:   Mon, 17 Apr 2023 09:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 3/6] dt-bindings: imx-thermal: add imx6sll and imx6ul
 compatible
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
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-4-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230410205803.45853-4-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2023 22:58, Stefan Wahren wrote:
> Currently the dtbs_check for imx6 generates warnings like this:
> 
> ['fsl,imx6sll-tempmon', 'fsl,imx6sx-tempmon'] is too long
> 
> So add them to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

