Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F24B40D759
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhIPK1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 06:27:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35282
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234839AbhIPK13 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 06:27:29 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9871240260
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631787968;
        bh=INMMbJweLKtfIFqOp/z9nDfacvXLONpOGUN41e2Lxa0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=PBKB2WvI17sQ6wgPR2MfLynZNvg+lJLU7igwaI94hHDCUTqiZ/fJbcYQwMaMWRHkw
         xj2qN9x+7Al1CDcENZDp18URw8P2C02R2zaa6m92sbO/531dBXr7YVEOR+PCsKgEc2
         LIU+Pke4NDf44fns34n8lwzMCxxy+Tpdc7zf7qFbjOIRlKUirylwS5CbRjIXyPjPMp
         PfCVVSNz+YFYMjCXd8ef+MSAZ43XljyeEVsT+4UOmhFmXX24BrLb1cg0OR4yyJg7QG
         Pnl6UM8viyNLNGaIeJkWZtFH533xFInNWY7XQsnx34uZOAWa1vTh+hg+yRzuYQpLJZ
         P6QKbwri+JgSw==
Received: by mail-ed1-f69.google.com with SMTP id ec14-20020a0564020d4e00b003cf5630c190so4950265edb.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 03:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=INMMbJweLKtfIFqOp/z9nDfacvXLONpOGUN41e2Lxa0=;
        b=1P3z4WrvY2WFj/lK2Ae07qVJkiUDOCV5Z/Itb0lPtp2NIEZfqBTGjmH3U8mLeB6PrL
         XSnIxhgJEohiD2pfqBpxA1j+R/HJOJFN7iadBnaSydMb/As7g5CU+8iag7GalvINxyAK
         lzB1OUDvV+qzeXJ9tW7ghWE8gzUGt2jaDwgq3BRKujZe5xIu1peAesNz6ousJ416YaHR
         kuuEnRTpFqP/F5GR2dll5Ym/IOcwrS8pmf152hzr6xHUFdvPNYIohBQyV+dCSJVQYfph
         fbzNX0OrPSLprKbTECcQ0o07MOMjq4Bm9rsS26NCoXoljZc+FXS0PoVk0NTBPHTqd8Wc
         X4Ag==
X-Gm-Message-State: AOAM531EUez/d3u1gcV0YJ5C6396xV+pYoBzvHKe4qOGyTSx2eH16n8M
        S/WBzdnSnWjw92MtSsN4tpoZVzmOk6iIkcpzhGMgzmMoR4a1W9ohT5xRCNYt28z37pM4sV2VcVw
        hp8HCar/AXv9rjWfhVItWeg1d6ajv018UcGWU
X-Received: by 2002:a17:906:52c5:: with SMTP id w5mr5356759ejn.567.1631787968303;
        Thu, 16 Sep 2021 03:26:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb9N/GLWxTk0KNEb248UKXPfMbCCsC1PbReC6Ab21JP1EcUI71yB8XTalRhNhya3VMa/vctA==
X-Received: by 2002:a17:906:52c5:: with SMTP id w5mr5356746ejn.567.1631787968167;
        Thu, 16 Sep 2021 03:26:08 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id b14sm1221085edy.56.2021.09.16.03.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:26:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] power: supply: max17042_battery: Clear status bits
 in interrupt handler
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dirk Brandewie <dirk.brandewie@gmail.com>, kernel@puri.sm,
        stable@vger.kernel.org
References: <20210914121806.1301131-1-sebastian.krzyszkowiak@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <42c74aa4-55ef-194b-b26c-945399d16a4b@canonical.com>
Date:   Thu, 16 Sep 2021 12:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914121806.1301131-1-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/09/2021 14:18, Sebastian Krzyszkowiak wrote:
> The gauge requires us to clear the status bits manually for some alerts
> to be properly dismissed. Previously the IRQ was configured to react only
> on falling edge, which wasn't technically correct (the ALRT line is active
> low), but it had a happy side-effect of preventing interrupt storms
> on uncleared alerts from happening.
> 
> Fixes: 7fbf6b731bca ("power: supply: max17042: Do not enforce (incorrect) interrupt trigger type")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
> v2: added a comment on why it clears all alert bits
> ---
>  drivers/power/supply/max17042_battery.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
