Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40BE53E917
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jun 2022 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiFFJU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jun 2022 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiFFJUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2022 05:20:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D837AAF
        for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2022 02:20:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u12so27715405eja.8
        for <linux-pm@vger.kernel.org>; Mon, 06 Jun 2022 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPuEXMq+9lFEX3s+CewNQ8QOCm+DO64U8n+0VKR7QWA=;
        b=HK+Nt7xTLdOK4LakJ8fa1HYObrvUhYOKzTayvt6U/GnZYaeLXZmchU+MGT8KOKEoAC
         mT4eXur0L2XfiuDlWK0H7ob5mehbXpY1L1L1ox73iApWtDylOAkhlO/PfAR4OVpbd/E7
         RHgV5b8Z3peVnFnsvRJfBuwFhCEBiyem9XiokL1U3euUdohlP6/sWhyhiGY4wVGa/Uqs
         rQ0Xcl9tDp4pIA6sswu97F74HnZKzGIsAGzcc3FXX0ri0YR9Akjm5OpbegeXFjNJ6G9c
         +UVy4AWPEoxw1sY9oNlYLfvfEOR1z7wjMJVRoagfACbjncjKmD48fekXNKxSiyVsai9J
         v27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPuEXMq+9lFEX3s+CewNQ8QOCm+DO64U8n+0VKR7QWA=;
        b=PHO9F7UzPYzAa5tqTtddM5qGYtdYlB1tIxuWBFeDbGqTi5EpWsG4llDCxjSvBRKwPD
         Op+px7Yhk0Oq1MD0m4zpAZidCqtQXGXYhLX/T+z1J4Lz0nV3dDQ2Y5r3A7uMmQ9Ke5Jl
         v39I7/6QS35LQlLM0W/q6lAqC/Q/RE11LkrLwPhaKcEVcEoU8k1K1wu7a7vHzcYM2ndn
         tz0h4vm0UAa8W67PAUgGv8jkMSQiW7nT2RLVa8VVXRRijH/sOO6RKzGQCm/fNAG4iq8Y
         qkx52UT33Htj1RjDAs98zXgyyfD0jF8jN+pWNfmhcjKuIEaqNrJgy8KazlcpOveJ9t8A
         TWmg==
X-Gm-Message-State: AOAM53373lqjxyfTx1iePMOm8lXhliaG37imIQW+IighksQk2BFvSC1f
        anPYAvEKh2bwC4KzGCWe4nxGzA==
X-Google-Smtp-Source: ABdhPJynT3v+VtJjrcp5BZ+V7EHBhpEc6hW6mQHDxxG6yYlPB0AL8NMfBPALluerzvpAZmm45rf8gg==
X-Received: by 2002:a17:906:af0d:b0:708:d48a:271 with SMTP id lx13-20020a170906af0d00b00708d48a0271mr20415081ejb.329.1654507251574;
        Mon, 06 Jun 2022 02:20:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090636c600b006feb6dee4absm6067412ejc.137.2022.06.06.02.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:20:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        linux-samsung-soc@vger.kernel.org,
        Miaoqian Lin <linmq006@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Fix refcount leak in of_get_dram_timings
Date:   Mon,  6 Jun 2022 11:20:46 +0200
Message-Id: <165450724182.62574.13510345979647280538.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220602041721.64348-1-linmq006@gmail.com>
References: <20220602041721.64348-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2 Jun 2022 08:17:21 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> This function doesn't call of_node_put() in some error paths.
> To unify the structure, Add put_node label and goto it on errors.
> 
> 

Applied, thanks!

[1/1] memory: samsung: exynos5422-dmc: Fix refcount leak in of_get_dram_timings
      https://git.kernel.org/krzk/linux-mem-ctrl/c/1332661e09304b7b8e84e5edc11811ba08d12abe

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
