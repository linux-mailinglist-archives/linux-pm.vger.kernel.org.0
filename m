Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8561A42EAA6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 09:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhJOH4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 03:56:11 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56150
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236271AbhJOH4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 03:56:10 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C2E340016
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634284444;
        bh=FjiBWD6KOGxZjHagQXbhzd7t02HLGEzw8kC0g/03pT0=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=N7kkHNmx7Z3QYzFop+eq5FGv9Nf6e3oIOxcrJLa9N3TPbSVL+vN6TKaaxU9NSF5gC
         fqRWmOn4qBNUlsZEEg+Yk1WTx3z33KtjOViBRew15gAT9VYYmlINY0NyYYE/l03/vR
         NCuveaoQbj2qW/P1hN6JleJrPgJ/hU8H8/VeAE4z2n0lnwJ+KVq/wx/hRZivIi2UIf
         V035jHYKqGdM4vNrtOZ8fdxenosslkPjeI8FtmMzGeUfQuQgY8Vz1FKmCxiEm9sKUU
         mGWz7y3idKIbcfpjyyzGeut5rbGjZeWLmQYV78e57eKDSy94nu8u1KOWongeeK72D3
         GqLhOHFf2q8fA==
Received: by mail-lf1-f70.google.com with SMTP id k18-20020a05651210d200b003fd86616d39so1203114lfg.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 00:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FjiBWD6KOGxZjHagQXbhzd7t02HLGEzw8kC0g/03pT0=;
        b=QAp8WCbaH4RdmcwpfBhVsc2ubKsdZzkLK98ZyMyOGkqVXtJ0N02vDBGjWWK6loeHZ7
         vB12a0ILWq7DkGbtQRtu3sxlA0u6DYThRhFTq/uv6Y4Q2cgT5Vm2uZgZUQqmry9uPwdW
         Fm/OkxpSvFrDRRsRX1pAqU27n+yE8vd5CHSQEJBNPcloqDsb1lhwyZGl/BuliPsRbd5K
         P5z1uSjsCCgYC9Ufsgmmo6Hkioj6J87UQ3pl6JZdwDzfhoZs6FoM6EiklZx9KeQyzEha
         4FIdIS7qW9iI4wzPZWcUU5Kb0Mx8Zu7wRLVU3ZfQqECMgeViblBAwpaaBXNlO+u8QKYr
         rvpQ==
X-Gm-Message-State: AOAM531hgAfVPTH8j/5udKL+H53kPaIkxFAcqdb8T3C42EqLyBkHacHF
        rN8aYBo+FATu1US/0E7jsnNifN7tQiS5yr/HeE8vDB/uwGF1kXI5aZLH5RJ1K/19ZYPEPCFIMj8
        oXKyu7hUbhWLGjh6U9JmjJUeobxEymVitej/t
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr6952812lfd.645.1634284443571;
        Fri, 15 Oct 2021 00:54:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytuH16ozPDRBURVxxyw+MBmbGvp1XT8IaLvklkb1cqqLUeYlT2L317N/zAHeTSLIGf4sTXcg==
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr6952798lfd.645.1634284443418;
        Fri, 15 Oct 2021 00:54:03 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a26sm31023ljq.127.2021.10.15.00.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:54:03 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: memory-controllers: correct path to LPDDR3
 bindings
To:     Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211015072857.9770-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a34f6c91-8e94-e446-31fe-085f1e50b2c0@canonical.com>
Date:   Fri, 15 Oct 2021 09:54:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015072857.9770-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2021 09:28, Krzysztof Kozlowski wrote:
> The LPDDR3 bindings were moved to memory-controllers/ddr.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> I will fold it into original patch.
> ---
>  .../devicetree/bindings/memory-controllers/ddr/lpddr3.txt    | 5 +++--
>  .../bindings/memory-controllers/samsung,exynos5422-dmc.yaml  | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 

Squashed into "dt-bindings: Relocate DDR bindings".

Best regards,
Krzysztof
