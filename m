Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441D6007A7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Oct 2022 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJQHZg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Oct 2022 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJQHZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 03:25:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16635A2E3
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 00:25:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so17039295wrb.13
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lwOcc78AURI1aehoO4aO20ady3jzJN/W6jcM5WXRbc=;
        b=bdWvxy+P7nhe7CGMmNT4dqAaxCbm/6tLl7/H/RrQLu6kaCIyi5Ow/12EQx+6bkQ7PY
         ExfWr4BH3Yy/mBTiaxfAhef5JA5T3ptzck0tkjQqg7IJjGWhtCR2g3+9Vn6U2bWX7LL3
         qyILQOo53KX/El9Y2Ag0vzmpROCEjiPfOY/LGRNdIwswtzn5o/DxYm34QbuGok9I7LiK
         M8Y8hkEHoHsj12OhhsDki5JJulSaXWQlQuBsl21T8DVvXFiJiMh7EK7bVT6PZ9y9cFKa
         vATPn305LVmM2o06rMFWBqEJB/pl4v9d9vw4qQzwbvyhx76FH+G/OWC+idcL4Ly0GlQD
         mlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lwOcc78AURI1aehoO4aO20ady3jzJN/W6jcM5WXRbc=;
        b=aeN/uRP0ACVftEPa1XFiDNJ61+haAk+sZ65TGkFK9KetYqwJDvMFKX8PJ0PJRA72+t
         +C1bDSAnt65oklMWiUzlNA2gA79QfsY/brT+shlGDbipCdpruh8FQ82LYlOEBwHPvchX
         EmWM/wccENh2rA9Lc+zqxy8jWds5qhY5GPIkhrOmu4Y5A+Cfr+QjKGf8qU+JbwyQkp0A
         4QJBHx0Wq/sMoUuzA/NtyxsHOsmhqYAyGpkmnEgzQ0UVuuyXoOBHpyjHMWKwtbVbvgPh
         NKBN3/MZBRnC5m997FnEF0rFHCjqkmQNgiAp1ZGmEaV4hBoYoGRUmDHXWqSs/MPHR2e2
         VyXg==
X-Gm-Message-State: ACrzQf3jK6cXHPW6FGPOgCfT6ju0cUN6qugC/AwaKAEgALgiGhgVFUAZ
        LlHunzVIUKdp+SfFufBoI22aiw==
X-Google-Smtp-Source: AMsMyM71VlOBQrgAcVCq6TgroGZJtazbJYxcDNlC244zSlOvqBt0RQDO24c8HYM432jU1xkDSzeUHA==
X-Received: by 2002:adf:d0c3:0:b0:22e:6ce8:f7a1 with SMTP id z3-20020adfd0c3000000b0022e6ce8f7a1mr5204125wrh.287.1665991530223;
        Mon, 17 Oct 2022 00:25:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9? ([2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9])
        by smtp.googlemail.com with ESMTPSA id c25-20020a7bc019000000b003c6b874a0dfsm11765411wmb.14.2022.10.17.00.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:25:29 -0700 (PDT)
Message-ID: <205a7893-ed41-f0b2-1c8c-e406feb48f9f@linaro.org>
Date:   Mon, 17 Oct 2022 09:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] thermal: imx8mm_thermal: validate temperature range
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2022 09:35, Marcus Folkesson wrote:
> Check against the upper temperature limit (125 degrees C) before
> consider the temperature valid.
> 
> Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
