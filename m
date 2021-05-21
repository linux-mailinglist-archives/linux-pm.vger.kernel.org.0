Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF52938CFD0
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 23:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhEUVYP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 17:24:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56461 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhEUVYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 17:24:14 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lkCbY-000157-I1
        for linux-pm@vger.kernel.org; Fri, 21 May 2021 21:22:48 +0000
Received: by mail-ua1-f69.google.com with SMTP id d30-20020ab007de0000b029020e2f98646dso7966013uaf.5
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 14:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSKiGkFsHm8qeUwaLdynXEY7fptjk7YiH8pCxN+OTOM=;
        b=J6ZWiXMywJQ3B4wlSzZW3njD+8pz1SEGzPLWemrZQausP0LhpbMYtkeui0wKXnRn43
         pC+Ic+tJZYaXDfeFjYpV13cQx/d562JOyamBxM2aU0rlD11Jxt7CK48ogkhpbCmVAEVL
         W+E0jKxZFFw0BcJV2FxwbI/jynL4+3wrSl0lbYDN9FKVijp9/bvXPzqbWmEJyhJICmVu
         n07gcXmj6i6L4SNJph8xAQMwkUkJZa4lGlqhvFTrCM6zFP2SC3v1BiR97X1tzcIKXxcg
         +9wzGcmpjJpTxpqerLWMYFVhTGSszxWdw9a+TgDCRL0O8kuylXETYX7h8RGgkXqQvMKK
         sGcg==
X-Gm-Message-State: AOAM531nm4z5AI0sFADhRVjUOO6Sp+EdUwRQOUlOJtmBRDWHY2m3TYMa
        D+eng69aDQOEfo306ja8ydqddSkHZjx1n6PDnYJKr7LAGmZJRy3hXBuxLcZYYnY+yLhfwZeopCz
        F0bRfDztvA5h7E2vtoueocIGwFHTli9vvg1yT
X-Received: by 2002:ab0:63d4:: with SMTP id i20mr11750989uap.21.1621632167734;
        Fri, 21 May 2021 14:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvQ2l1U8szglgOD1N+hyDpgNDWEMA/0qq5+dQBkcYT64fZxhNQR94GbFgCi0ec6pzhy1FOKA==
X-Received: by 2002:ab0:63d4:: with SMTP id i20mr11750968uap.21.1621632167595;
        Fri, 21 May 2021 14:22:47 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id 39sm798548uaq.5.2021.05.21.14.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:22:47 -0700 (PDT)
Subject: Re: [PATCH v1 09/13] memory: tegra20-emc: Use
 devm_tegra_core_dev_init_opp_table()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210520230751.26848-1-digetx@gmail.com>
 <20210520230751.26848-10-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f24704bf-c9aa-1552-659f-a3eff9086ecc@canonical.com>
Date:   Fri, 21 May 2021 17:22:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520230751.26848-10-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/05/2021 19:07, Dmitry Osipenko wrote:
> Use common devm_tegra_core_dev_init_opp_table() helper for the OPP table
> initialization.
> 
> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 48 +++---------------------------
>  1 file changed, 4 insertions(+), 44 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
