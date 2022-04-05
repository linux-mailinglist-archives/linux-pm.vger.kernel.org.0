Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278104F4894
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbiDEVm0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573222AbiDESZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 14:25:57 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD41E35;
        Tue,  5 Apr 2022 11:23:58 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id i8-20020a4a6f48000000b00324ada4b9d9so2411992oof.11;
        Tue, 05 Apr 2022 11:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/Wd9yzfBCTc9zddQ5+TUbcMzzM7qQoebbMKWMFAvjA=;
        b=kOjP1Hr3PVih3GXW2TgakCwsP7RMOuwBxIJqd77zOTxsS2wJMYlpduanVnMVFWaykx
         sZt+xMyv8sJMkx04GCdYlnhok0pqRMqOxPYceDrdQ7DKa+iVYL5VXgCM6aTXKDpI52au
         v4Dz8F90lHgvfM0pNY4/BPSsr5YKOyJgWwcoClCbDzhaOR/iDwGdzgwOXYfbWEIStOrp
         MCjMSDEOvm7cn9nbuyEIjpfJ4H3t3bPFE0rUfqT6wGzi1BEubgwQ7lPPDWaXcouzfo47
         5yj7Vu46cT6OfwwbRiRO6zKsCBKxPuFSRFKXVH8Vvj7U+86SUhDALRprekMEO7qaa/pR
         aaDQ==
X-Gm-Message-State: AOAM530ha+IokT68xfB9DWlO7HZtG0Xo83VI1tFYEOdfdhpg3+GNeQRQ
        QnCHvI0CC+7SkRD8WRHe0A==
X-Google-Smtp-Source: ABdhPJzkaQGbK1qCUt8UsIBSnyyLc44JYk4YSc7/ZzD4IJZnHlmitD8NziNjexON593vkfDmTxfriw==
X-Received: by 2002:a4a:b3c5:0:b0:324:527f:8709 with SMTP id q5-20020a4ab3c5000000b00324527f8709mr1541471ooo.90.1649183038228;
        Tue, 05 Apr 2022 11:23:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m3-20020a4ae3c3000000b00320d7c78b01sm5269410oov.20.2022.04.05.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:23:57 -0700 (PDT)
Received: (nullmailer pid 46067 invoked by uid 1000);
        Tue, 05 Apr 2022 18:23:56 -0000
Date:   Tue, 5 Apr 2022 13:23:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzk+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <YkyJPKuG1s5pLR+t@robh.at.kernel.org>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404215754.30126-2-macroalpha82@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 04, 2022 at 04:57:51PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
> 
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>                                       sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>                                          sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)

Doesn't apply for me. What tree is this based on?

Rob
