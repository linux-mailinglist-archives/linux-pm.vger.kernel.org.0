Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671105276B2
	for <lists+linux-pm@lfdr.de>; Sun, 15 May 2022 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiEOJrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 May 2022 05:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiEOJrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2022 05:47:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF52CE00
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:47:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 4so14936943ljw.11
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=upa/6mpRaWNXap42b9Fhlm8p2m3O0ZkowJnqV9qxhSQ=;
        b=HGkdTfyNZ9z/VGOlOGeZ9tAiAMmwoFj7ayxLFWg3rtt8qaITsMQK34okgbeZU1LChw
         C48Ec3/SYgwKMVa46Vch+2vEBW1+BEJjNW+ve3Xbi3tNwDS+ulL5kkRAP6Y5P2niF9Bc
         /job2hmJckfc3OomT2QCZFoq27ZJCUYQKhbb5Pkyk5z5RCbAAEb80i8LfvWbjyW3Ltzb
         5k+N4kJqalYM1tRGnVG/v4OoC9WmBXO/MaRcZ9rgF1dwdPDBlC8Sa/iDhvY1gQw1gA9I
         fC7SMXROJHGhw/C/gXFajxD8xPQ+nxTB4jgH4QFAlSQ1vgTl0+I4SWbQfTDPOKg7OXvK
         28mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=upa/6mpRaWNXap42b9Fhlm8p2m3O0ZkowJnqV9qxhSQ=;
        b=lhEXzyNdPZgCvotrbfxZS6Vuct4ombfe73NclnO/qjUr8yQdy2ug8K9wQDbPd7JxcR
         R/TaLDizqGZVTvM7OHGLdTzJ0sgrlVff8kwp5QvPkBDUQ18Ih9agmhSEXuEt4pecgbbs
         T9yDT2xyWOAZVnVWvPHZRugjwe/r8LE5ZfJosbdVyMF6bO+arUhkzEg0gZmXtD3hBbFw
         LHx5n9v5ZJKqKtA352iutUNOHF47U6wQ81YLeWYX7Y6cO5NHj/HkSsVOK3rFpqHDake4
         N/w3h7RL690pbU/eF5pjurdfN49GAM3LI42Tafe8PEXZi9cYuxSEjjm489tqIxowm55P
         /rug==
X-Gm-Message-State: AOAM530L23Lx0+fi327YCoAJMqC01aHNQA/9ZJVOyA+Q0LtbYId5KeRd
        ToxjWa105EAPGzL0bHG7F+zbWg==
X-Google-Smtp-Source: ABdhPJwAVzbhaRncsmXG2PPgEj1lsAU7Zv6JTkPGQs3geo7EWnhPD3WsyxPVyrP0b45i3KZuWQ27+Q==
X-Received: by 2002:a2e:a7cd:0:b0:24f:505f:737d with SMTP id x13-20020a2ea7cd000000b0024f505f737dmr8170269ljp.168.1652608036714;
        Sun, 15 May 2022 02:47:16 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g16-20020a2e9e50000000b002539cd7b05dsm864178ljk.46.2022.05.15.02.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:47:16 -0700 (PDT)
Message-ID: <2a8e9301-5da6-46b0-850f-f3f12447d400@linaro.org>
Date:   Sun, 15 May 2022 11:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 5/6] thermal: exynos: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-6-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> Use the newlly introduced pm_sleep_ptr() macro, and mark the

s/newlly/newly/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
