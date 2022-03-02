Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A04CAE54
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiCBTMX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 14:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiCBTMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 14:12:22 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A34CA70E
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 11:11:38 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 030D93F1DD
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646248297;
        bh=GaYw4kCctZBBNhWvc3Kw60zWpr3KVDaGcQGc1mdC2b4=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
         In-Reply-To:Content-Type;
        b=Yjyn82LWq4JdYHpcCba/f6htp/DxQlbSs2OR8H09Bdb+1elGdzdQT9mpyKhDjW5m8
         CB43GTgyMtq4OQnn0n9i9jySOVK5wWWFlPhUWjOm/zXnusMySZRpXvaj2SkLt+8BBT
         grjtuESil5jVvocJqlBDo/Knc0fl3/a7SBqzsmUcRtjahTmlfztvi994mmt6BGWNco
         BYLjNAEUiuT0uOVBw1jjpwJ2R6fCdTwN6B0am2v8BrnMCv85QxgR7+AHlzvReLHAsY
         zlQJ+SZMw+tGMOB6onGsz14x7RmmBnr3IwdprND/1RL6LksZaKjVuUTozpjFQQicfB
         zkWjZeum136Pg==
Received: by mail-ed1-f71.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so1535344edw.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2022 11:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=GaYw4kCctZBBNhWvc3Kw60zWpr3KVDaGcQGc1mdC2b4=;
        b=gxmy6oDj43k2gJei8FFtKqKV8zY+RBdVuuvx/KcuvsNKxKXmzNqUm4UioWiwfHRN5V
         m5wxopS8oOTTkf7eIEyG444tXcBQO929Mu9tRiR1dRD+c8yZrsTN/UXYTFD25RHNKNNF
         Tfc+HkH89VlvD+ppDTEy+K9r9lKX3CEwk1baP8o68NJWnLG+AFBjUyDGcn3IKug8z/ux
         t3I8M7u1RbkKzhLrc+Ea2KFln+tvpc7kEgJpo+cMHD0twoCR7lXBMf4HkIW4c1lQRgc1
         V8WKKHZJ0d75PsJ2x+AHRayxIQGRLBE2PHSx4xbPGoAk0BOyyYBs3PCOjccpRJX9+7in
         7w/w==
X-Gm-Message-State: AOAM530TPW9+yVXdCQhzqauaYASYsNiZ8G7++sn6TWRhoob2D3ldSI9d
        2TwUpbfvOjc2Q02LUqoqaSfK9Uh5EHGZYu5JpEalhRomC+NtNcEVqZRZ5So02IaBev7XzqVcGDf
        h1T6eFKqylAO9Oroqx68fS9GHtQR5YWZfaGkS
X-Received: by 2002:a05:6402:268a:b0:410:cc67:e792 with SMTP id w10-20020a056402268a00b00410cc67e792mr30904319edd.218.1646248294666;
        Wed, 02 Mar 2022 11:11:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwqfGfmP/tGSJH5mfrKeEt6JKMiIgeF57IarG3eDMPZk0vtlCiLO1EFcxl9lhHC1mVyG1Uhg==
X-Received: by 2002:a05:6402:268a:b0:410:cc67:e792 with SMTP id w10-20020a056402268a00b00410cc67e792mr30904303edd.218.1646248294485;
        Wed, 02 Mar 2022 11:11:34 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709062ad300b006d1289becc7sm6512974eje.167.2022.03.02.11.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:11:33 -0800 (PST)
Message-ID: <d27ee47c-6c03-3927-4cac-46a1c2515ab6@canonical.com>
Date:   Wed, 2 Mar 2022 20:11:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: thermal: samsung: convert to dtschema
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
 <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/01/2022 14:25, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC Thermal Management Unit bindings to DT
> schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/thermal/exynos-thermal.txt       | 106 ----------
>  .../thermal/samsung,exynos-thermal.yaml       | 184 ++++++++++++++++++
>  2 files changed, 184 insertions(+), 106 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> 

Hi Amit, Daniel, Rafael and Zhang,

The patch got review from Rob. Could you pick it up to thermal/PM tree?

Best regards,
Krzysztof
