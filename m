Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5184D0A4F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 22:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbiCGVxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 16:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCGVxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 16:53:33 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763831C12A
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 13:52:37 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4AEF33F7E2
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646689956;
        bh=avS2eWzHwYAlHNx2d4yWSoiGc/ntu1FTeA6bPKX64Gc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UwXb6kahRIHz71CjmuWBrp+37h7dZrVUpkRmS23GBO+mpdXe70gt4qOYtakf/Gf2I
         BkQkmAEOaeOrfoG+vjyFZhK6kDmzsQgc7OzRiZos/wzzK9ViqQJw+dyMCVoYhCig3w
         33eMmE4rqNGvG33Bp6hM+cC5xodejbgbTNSwl+S7GklxO8Qrn9NafS4olc+10+f4Gd
         /czwh5e2yIDOGK51hBU6uIkL9CC49AEwx0AcgsqbfYCp0nxMKl9B/h2RhOshlymfJg
         pZXgUgmIAmF+5Ra3vwcYtTG0WprcWRbEIEhz4ucO6iC9KgIOzZLZeU8YoQejMjSjoN
         LVGEXezauqSdg==
Received: by mail-ed1-f70.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso9420361edb.10
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 13:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=avS2eWzHwYAlHNx2d4yWSoiGc/ntu1FTeA6bPKX64Gc=;
        b=f1g0DVA1kRz61W9iQAgvPzRfiSTSki1mMpnmkG8+ZFhIzGM7vHiarm8W7TI1MSCFRg
         5fu4P4yjU+hIR9B7t31kiMF2UOnFyYPaXBhyyYYs1ZNJiVO6Cv4/U2E8zBiULkuAJem7
         kixut3g0aPhvU+OdR1n22FHai9MqIxmk7TgYaZ8Y2dwJIg8p+AvwZ431CsEaTVtTSCY7
         gPjGf+QbC1xQ8NnJZabhpvvs2kMvrXiU6VVtSHZz2Y7XSLtkz3zX2C15egOjamTEbYX6
         aiJebgYyNoSAFkyMwVKdVKICCbvm5bmINWr3g3GZaoLLIblmXFGdYiZ0bs8KIQMWNkB+
         hnlw==
X-Gm-Message-State: AOAM530KtSSeOTn3L5nla1iZ70a5dmsFb2OhY0QM0kZsDX8Y9PXT6Ax/
        RM1SGpsVF8MnHLN0P/6czRo0+jO7mh1xXWVmu/XTTRe2D25W6jxrb+oYt4WqXjiAee40V7dVr0v
        V62gmaHfIlZ+kyg0Va4iXLj4EaWZ3fiNp56bZ
X-Received: by 2002:a05:6402:644:b0:416:4ade:54e3 with SMTP id u4-20020a056402064400b004164ade54e3mr5828299edx.222.1646689955070;
        Mon, 07 Mar 2022 13:52:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhroSgyUUiu+9iga34EIiz+zQNtDh2UNpPeDJ+/rC9xXcmLwdoBP4LNusITQji+CJ1nzOyPw==
X-Received: by 2002:a05:6402:644:b0:416:4ade:54e3 with SMTP id u4-20020a056402064400b004164ade54e3mr5828286edx.222.1646689954927;
        Mon, 07 Mar 2022 13:52:34 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id gs39-20020a1709072d2700b006d3ed4f51c6sm5289571ejc.0.2022.03.07.13.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 13:52:34 -0800 (PST)
Message-ID: <7f99b453-5510-d7f2-3d9b-b3ac3415fa62@canonical.com>
Date:   Mon, 7 Mar 2022 22:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] devfreq: mediatek: add platform data to support
 mt8186
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
 <20220307122513.11822-4-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122513.11822-4-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2022 13:25, Tim Chang wrote:
> add specific platform data to support mt8186.
> 

You just added this driver in patch 2. No need to split such actions
because this is initial submission, so it can support two devices.
Squash with previous.

Best regards,
Krzysztof
