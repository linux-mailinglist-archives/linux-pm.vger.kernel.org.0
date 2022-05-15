Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3D5276AC
	for <lists+linux-pm@lfdr.de>; Sun, 15 May 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiEOJpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 May 2022 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEOJpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2022 05:45:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4E2CDCE
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:45:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t25so14966618ljd.6
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VOmZ36K2/Se2iEMUmzCNT5DsiEAqRQzghBT3JGwISGE=;
        b=WEor0tLzXnp7bu0UIT8R/nBXO+eqMyT5HFceBaoQ11xqeJ5/Jf2Wv66WcB5585b7W6
         z2bK14uU1IrnaYyoOSdKdlQanJ1cI1iyUyFEZ34Kxq7ZyLOTQemSeoflGAg7WYQsU+25
         DfIbZJrrAl+RK1LiafBFTK50ADcF7pTgtOUmA5AJY2Hj9Qm5qN0F/OVfR5MOP/dWdeWT
         3F6pkzv5bEv94vZM7CWVOoJqF37XkYPJ7NeuSrbeGydcshtKiZ6IzwYdaO4SjZBo/Vt9
         KuMRqPjKE6zulmTA4wXVZFcppbtm5/exgMv33esggHRiuwnMq8hmXbMKGunDGv2LrFDj
         CUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VOmZ36K2/Se2iEMUmzCNT5DsiEAqRQzghBT3JGwISGE=;
        b=OhPkrKY/xUnnZJw0TEHMMdwDdLf4PpjAUBi/MNssQXN/cuYy0hwkw9KOWzoYqBrxDZ
         TnEy7DuYI3C/FiawV5a2ariH0y94cFEISiNNB9iu1256rx+EVE0tesKmNlRvc4AQ13rc
         MfqyaJW/itLzgtHgX5lH2iKg61xf0Okgyd272OkuuWanP/7vJkyno7qfqFhkya9Nuxl2
         52iRTrKLSoKeEwSxMMSqmnOMp+9vxHWlZ1QxonAXgET9lWg7MXvHuYpzRQTvdyKL0Hd/
         PvFxkQ0ckx7t/HL63jM4MlGAAsi20Ph1U/kix89f2wYTLM91QXn4Qjfk5odX15dp6WFv
         phGA==
X-Gm-Message-State: AOAM5308jOYvosdlPh6/ExIDmJri6mxNPbVs1gEl6/+vIBJOxGgh5uKi
        mBHaNRhrOngk0Cxa9QFv0EpIlg==
X-Google-Smtp-Source: ABdhPJy81LqQn0Rmls65Gkci5x5pSZWL9g3WjSLGuX4ZKidOa6lfMqMC8zZ5Ugalf04cf+edi1UVZw==
X-Received: by 2002:a2e:83c9:0:b0:24d:a95d:7b7a with SMTP id s9-20020a2e83c9000000b0024da95d7b7amr7984304ljh.254.1652607939794;
        Sun, 15 May 2022 02:45:39 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w7-20020ac25987000000b0047426f59b33sm960579lfn.252.2022.05.15.02.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:45:39 -0700 (PDT)
Message-ID: <5b388fd2-7d79-7e73-b1d0-a6c8bca4def4@linaro.org>
Date:   Sun, 15 May 2022 11:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 4/6] thermal: exynos: fixed the efuse min/max value for
 exynos5422
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
 <20220515064126.1424-5-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> As per Exynos5422 user manaul e-Fuse range min~max range is 16~76.
> if e-Fuse value is out of this range, then thermal sensor may not
> sense thermal data properly.
> 
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
