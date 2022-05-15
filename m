Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8605276BD
	for <lists+linux-pm@lfdr.de>; Sun, 15 May 2022 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiEOJwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 May 2022 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiEOJwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2022 05:52:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86AE31239
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:52:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b18so21258283lfv.9
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=rt8GD04SlHYb1Rr/ubbOdUfsFsvikQRWfi701Og0DSE=;
        b=O3y+znDeMkhRNhXdPi4VX0F2FuixGdSGNENwopvN8V7frsw0NHH44oubVz49zYX+El
         oDd8OW+tOVVrDwE3UClekozQ/fxvXDwz+AXE2ssqqb2U87I6LPLXs2AH+ZQlaLjA5wES
         IPY/7nw3LR5Byn72zH4DzqKyndq2NKQjcRT09gd/BtX16SCF8dXPQBPHegztztihQ+nH
         tE8n2HGqkputrTqdFF2X6D4W4BFcqphk8wHGCAksEEOFHF6zPttG1HwzCnyNxZsZnjPO
         NMeq5+KQqXocD6UthBG1H5sXuVUUUa4SMjbLg/0DJQNaj9Iayd9zI2+kVUJkSkZh1KqT
         pNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rt8GD04SlHYb1Rr/ubbOdUfsFsvikQRWfi701Og0DSE=;
        b=v3xar+5rlLBz7o39oXR03hevgrtgMB/Nhb/zRbNSd4MHA+oqh/9T02pQ3oZ8csrCSe
         O+NQ+KoWlYI71fapR2/7xXRvixlsEXhZaOS3ZkYosSlR2tFDLxWG0xWTHtTbiqtoeMN/
         3gOeVjCz/nDlMf8Lb5Lu8C8RsSkbtKPYhhTgAgSLekzmfSd64C7aOXieXwLso7HeQGG4
         Gt4q1OFTgHEkSe7dZZAfg/mt+Y28qTjH9WGbe8Q5ygIchfGxp1CgcPhse8ZeKNNvWgTe
         rQrmeVt0Ilit5Pt62udx9ZW2gj5a1t0DQvpEYoAC1D+cOVLVf7wbtFEQheXD+z0Dr9rf
         z8Gg==
X-Gm-Message-State: AOAM5326o3T1Y6qHOqk/i9+FFAHChgS9R9tw3cHm8clcy+RayxOBQJXW
        g2uLtC2jiTZ+61RwolREjlXAkA==
X-Google-Smtp-Source: ABdhPJyQJFLoQyoq67lC0iakWsWO0cEp3S1ihY/piIgS3mZir/EsLOvk7+Cw3J/JROYpmdI8MMI82g==
X-Received: by 2002:a19:7015:0:b0:473:d75a:7a3d with SMTP id h21-20020a197015000000b00473d75a7a3dmr9001190lfc.525.1652608352120;
        Sun, 15 May 2022 02:52:32 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d13-20020a056512368d00b0047255d21136sm967619lfs.101.2022.05.15.02.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:52:31 -0700 (PDT)
Message-ID: <6a6ed76a-50fa-2b05-896e-8936d3c3f597@linaro.org>
Date:   Sun, 15 May 2022 11:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag
 on exynos platform
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
 <20220515064126.1424-2-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-2-linux.amoon@gmail.com>
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
> Use clk_prepare_enable api to enable tmu internal hardware clock
> flag on, use clk_disable_unprepare to disable the clock.
> 
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Here as well you ignored my first comment:
https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#mbfc57b40a7ed043dd4d4890bedb6bad8240058cd

"This is not valid reason to do a change. What is clk_summary does not
really matter. Your change has negative impact on power consumption as
the clock stays enabled all the time. This is not what we want... so
please explain it more - why you need the clock to be enabled all the
time? What is broken (clk_summary is not broken in this case)?"

This was not addressed, you just resent same code...


Best regards,
Krzysztof
