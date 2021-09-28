Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A541ABAA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbhI1JX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 05:23:59 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49948
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239769AbhI1JX5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 05:23:57 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D66B23F4BE
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 09:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632820937;
        bh=Jjh03crH9Y2Dvm5lMUm2r/IxeHO4NzFIl/BuwFlsoxk=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=SXf2iBQExFSBA7VHKQmOYcuMQAtZRv2nMaV0IL4amc0/EhtNMKTzqlVZL7D6ju0Oo
         R/a1B8QrFwYCxEHTiKt73tMIjp4KiUu87+c20Ak307r8xgv1K9ifhLvdBMZ1EseZXC
         crAKP4E59QKwRopI4200Z+UnC1aKxHZJgzUnaUgPSRlhxCfPHtQ34JfwSI7zLDf33D
         XJrvXjJKTpv+KIeqddCUcGkc+Y95DpQynelJNZ9ycN5TZbDy4UROYnYdk+4HGVuSqN
         ECZQygLIVyuemkdnYUvDb9gtyBFjoft/Vljlov8feNk8Fp6QjihdPPda6OoeV9f/iA
         5vyCzb0bS97MQ==
Received: by mail-lf1-f71.google.com with SMTP id o4-20020a056512230400b003fc39bb96c7so18746960lfu.8
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 02:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jjh03crH9Y2Dvm5lMUm2r/IxeHO4NzFIl/BuwFlsoxk=;
        b=J2NsLxyqi9CgACG7siDXtwDlJWwXdCdFMyxnczv06MaW1poozyOgd2pSiC5+oB3E8l
         hwEIAZkbuCcdXlzxCsFdYhBf5K/Ze1TftVTBeMuIV++/YPJQ8yvc8kzJ9Zpl/vN2kf3I
         ZKFRyoFGdEjo7WbeJxR74FMDCQwzZwylTAPiSnqqXnT78JvQ5cTc54vwiw3J/s+WYU7y
         YLRxNYT5maHtyrIyXHKRd4R96k7U6Suqsgc21bWy6L6tO3awww1DpUkjN6+aAggKBiWT
         59sqvYkQ+I/zR19ZjzdXsEAPx31uYx7qwHsyr6PgT3uHOxZ5nBIpkYpuTvMzU/oyjKTb
         cdWw==
X-Gm-Message-State: AOAM531wesud/wt006+8JMKEmStsJnk5bD+05ZckZ6xAxUGcExlvK++W
        kjsXIQ3phYSg6uE1EMPIf4IPMdgUAu7GeW+K4lbD6y7d47iDXb2fg36yoSDjKu5NILNvwEhp+nv
        EsVluO5XUp94KlG8qr+zjJeT92ABlym8gqBIi
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr4692129lfu.297.1632820936755;
        Tue, 28 Sep 2021 02:22:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaLSINrwUzX9POmT+kfoTgosSi/5c/Nb2RqTI1uu/yiv4FGUAsY6JR6FbZll0zRc88A0rQWw==
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr4692119lfu.297.1632820936587;
        Tue, 28 Sep 2021 02:22:16 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e3sm2324551ljo.2.2021.09.28.02.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:22:16 -0700 (PDT)
Subject: Re: [PATCH 1/1] power: supply: max17042_battery: use VFSOC for
 capacity when no rsns
To:     Henrik Grimler <henrik@grimler.se>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, wolfgit@wiedmeyer.de
References: <20210919200735.142862-1-henrik@grimler.se>
 <20210919200735.142862-2-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <febc15c6-8a40-cc0c-d98c-bbefc9cc953d@canonical.com>
Date:   Tue, 28 Sep 2021 11:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919200735.142862-2-henrik@grimler.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/09/2021 22:07, Henrik Grimler wrote:
> On Galaxy S3 (i9300/i9305), which has the max17047 fuel gauge and no
> current sense resistor (rsns), the RepSOC register does not provide an
> accurate state of charge value. The reported value is wrong, and does
> not change over time. VFSOC however, which uses the voltage fuel gauge
> to determine the state of charge, always shows an accurate value.
> 
> At least one max170xx driver, found in Asus' Z00D kernel [1], chooses
> how to get the capacity based on if current sense is available or not.
> Lets change the mainline driver to match the Asus Z00D driver's
> behaviour and thereby fix so that correct state of charge values are
> obtained on Galaxy S3.
> 
> [1] https://github.com/LineageOS/android_kernel_asus_Z00D/blob/c7ab0e3ec5b5/drivers/power/max17042_battery.c#L1103-L1105
> 
> Suggested-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  drivers/power/supply/max17042_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

After explanation and double-checking of driver this makes sense. The
driver already uses VFSoc for alerts (MiscCFG register) if
!enable_current_sense.

Fixes: 359ab9f5b154 ("power_supply: Add MAX17042 Fuel Gauge Driver")
Cc: <stable@vger.kernel.org>

These could be added when applying but maybe Sebastian wants a v2 with it?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
