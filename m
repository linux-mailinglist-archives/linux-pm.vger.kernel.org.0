Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4574B22E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGGNuq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjGGNum (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 09:50:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE0102
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 06:50:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so20992465e9.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688737839; x=1691329839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3j3NwAPFY78Qhs50ITu0+2oTOBybcQeJnKlWCP159es=;
        b=I1+TSh7b2Q202iHBO0hVfS9/ZziI37tnntx0FsMqkX69+DWkfi8eyU/v0zCNtXb6OL
         4tuLAI42Y184Vgke/lieW0SVC/kyYH5G0hrPG9W2Yl8F/+115Nqfm1pAaxEhiRrDHLDG
         x237vmBWBcvEWIK8n5TIu0MAILF6MaXGiLEGnyYnaXwSTLztju+o1QC+Jqp1CtgOQqW0
         BUG8j7fw2muDJtzkad1KsxPieG/xCFgZRvJPknzUNjZvOWNGvkissjBOF90zoQ/e688F
         TGC33aCJ20gRtzV+C4WI5xceHCURxEorMwc1DBu4fiDHRpKJVQGdRyXQsIRY1LVN/yU0
         7Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737839; x=1691329839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3j3NwAPFY78Qhs50ITu0+2oTOBybcQeJnKlWCP159es=;
        b=faowLXmDdur9d+4WyZzXU5fDWoVjaA3ObLdvEjCTKiija3ar5MeYWHpGL7EZVfO/Ej
         c6S9vr0rVHHlZJCamCjzOyyvY38GCcthrzDPFEjQj2DxaxVx8TSvAoIWSQKJAJjcO46y
         k1D7ElPvOSBlhBQgBHZ30Kh2OrI1sgU8OPKab8ibqUGILdemmelj4G+UFpOAlJEtQmKY
         A3MMFsOdF9/BCBlIzi7475YTM1GC/qf8hmdnL6I4rg5Ur1RkHE3YWWW7OOAcbvoquSMp
         T+kDcBFZTG9SWuiNfRh8Q6QzGhxsePuPJyQgi0EP6bn2vsEe+5QUlSDLGKfNRqY3PdU4
         Tj4Q==
X-Gm-Message-State: ABy/qLY+2QcDLRRDbbk0dEhplmrFDsa1baRmlsyfjPBrpIOWXMzenviw
        aAlogV0+b/w07A0qf3GF8PQ2PQ==
X-Google-Smtp-Source: APBJJlETRcrMTPhEN/HPK4s4f3CyhXH6jBzJpRJpJVuRp4Zn+qZ7qEfjxymL6GD/vVJq5JP8oFpwbQ==
X-Received: by 2002:a1c:4c07:0:b0:3fa:9850:8b1d with SMTP id z7-20020a1c4c07000000b003fa98508b1dmr4038526wmf.30.1688737839661;
        Fri, 07 Jul 2023 06:50:39 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm2542924wmc.10.2023.07.07.06.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:50:38 -0700 (PDT)
Message-ID: <26d9e485-e9f6-7217-7c88-4c9a9b4dd9ea@baylibre.com>
Date:   Fri, 7 Jul 2023 15:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/6] thermal/drivers/mediatek/lvts_thermal: Honor
 sensors in immediate mode
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
 <20230706153823.201943-3-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706153823.201943-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 06/07/2023 17:37, Nícolas F. R. A. Prado wrote:
> Each controller can be configured to operate on immediate or filtered
> mode. On filtered mode, the sensors are enabled by setting the
> corresponding bits in MONCTL0, while on immediate mode, by setting
> MSRCTL1.
> 
> Previously, the code would set MSRCTL1 for all four sensors when
> configured to immediate mode, but given that the controller might not
> have all four sensors connected, this would cause interrupts to trigger
> for non-existent sensors. Fix this by handling the MSRCTL1 register
> analogously to the MONCTL0: only enable the sensors that were declared.


Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
