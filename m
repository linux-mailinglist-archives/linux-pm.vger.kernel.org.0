Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD04F48A0
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiDEVno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443920AbiDEPk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 11:40:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C89183A6
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 07:02:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b15so15028749edn.4
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YlvhCz+ZwurBoa4Dacny1n1zKhjoK5WjTu0ka6Xew2M=;
        b=JaBFqrGP/LYxuwnv3xPeUZFSgFCaYAP5Cc9OnqSilE1X0S9oVVSJ6EXMxe2neL3/Nd
         UhH6K5oc0/icf2hvVcQMP+5db7MSeRmMi563yaeNeT+3++H8cmrbblbpCfE4FwTqHzFY
         fBYh0THevDP3AxNl1qULJ+90gVVY4UUnhq8zUqTqnkKltzk5/ohQCROKxreOym0ut+vH
         ZxmBxwEvfGIXQMDbxsYvxty0q/GfInzTR6SY0DenLzomyHKmwQAK4xWnvfBJTF3qBLTp
         wG55NcoLaZfESKPsmdfJq+7EdqRxzt6kdl5p53pg/g96/ZlTjA7glASSgRLOCU+Qpijr
         Ejtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YlvhCz+ZwurBoa4Dacny1n1zKhjoK5WjTu0ka6Xew2M=;
        b=1iUYbTT4lPCVdlOCwFKNMZXguVskWBp5rOgyn2ZsdEPy6BOY0HBaS1280/LUeLuXM6
         2Rkc43zM/T3V/odiFs499hr00OkaHHTYICw7UVcunqH7ugvE9vtw0abGN/JmiNUdoYHd
         nJXA6iNFBzlthl0joqqUQv0bz1PpCNXqTFXCxEqA0dwRjwYhbWkpQcrYKD3++vSy5qyp
         offD0kfOHqDoAqKNW56tLIjveRW8MwkYwO9R779xCXsuXXQf7rJXAwt/OfnsKdJqEIMy
         eNyT7vByQstdZptaJZrMZ7K0f0AkVycwrIZc3FnoAkHrVJ5r5Q/fgo1TYHxyRBwCbHZC
         cmxA==
X-Gm-Message-State: AOAM533osGTtDqDTcMoLCkTVg4gHasGr6A+/2Wx7AhFMvsdDWGxyZ4R3
        fL1m4AJHlwR/EXgFI4Cbl7BZQw==
X-Google-Smtp-Source: ABdhPJzisQRw1uJSXOH6nUs9bMEsOFb2+0Ji2PIRWukr5+WRXSVe+El5YGq6vFp27YKEFnRXxC1ZRw==
X-Received: by 2002:a05:6402:26c7:b0:41b:7aef:bdf6 with SMTP id x7-20020a05640226c700b0041b7aefbdf6mr3834868edd.210.1649167344648;
        Tue, 05 Apr 2022 07:02:24 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm2630767edl.28.2022.04.05.07.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 07:02:24 -0700 (PDT)
Message-ID: <7ee4c8ab-595e-eaab-6f52-a97255ec032a@linaro.org>
Date:   Tue, 5 Apr 2022 16:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger
 support
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220404215754.30126-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/04/2022 23:57, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.

"Add new devicetree properties." instead of mixing tenses.

> +
> +      rockchip,sleep-filter-current-microamp:
> +        description:
> +          Value in microamps of the sleep filter current for the charger.
> +          Value is used by the driver to derive the sleep sample current.
> +
> +    required:
> +      - monitored-battery
> +      - rockchip,resistor-sense-micro-ohms
> +      - rockchip,sleep-enter-current-microamp
> +      - rockchip,sleep-filter-current-microamp

additionalProperties:false (on required-level of indentation)


Best regards,
Krzysztof
