Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA61641D902
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350523AbhI3Ln7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 07:43:59 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34782
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350512AbhI3Ln6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 07:43:58 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 091C5401A9
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633002134;
        bh=LiA1TOvesLNd2L6kNyPnkczuXXBnqvVYAhAbqt4uCJY=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=HoEd+3EpfTM9rFOJhb3CL8e0RESGHAZG1T3tlBjoGyNy784DO2D80Ekk7vcencQiO
         MDCdfi0PQHnM5uc13+9OVcMHZYbxiASgRdMpMfzEOAqOgz69ifVgYh9wj2s8HMXi3B
         mhmTR5SpEEalcBstsUT4Q1tUhNfdLVscQ7ix1T92hHLvJhNG8h5w/SEvr5qdlNp0/O
         UypldF5L7y91uZdpVZw5u/8+OHZeGUhOGwb47dLDRuI7vFxQ+Fb5dJ+25889iIug2M
         8fbzqc2UpgvNHb3QW4gCoZzMMp4RBCSUJTGXrukuEZuQpSpHTDBWvhwPlxzrtXbZVE
         +8hihoD2aZRYQ==
Received: by mail-lf1-f72.google.com with SMTP id z9-20020a0565120c0900b003fce36c1f74so5350276lfu.9
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 04:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LiA1TOvesLNd2L6kNyPnkczuXXBnqvVYAhAbqt4uCJY=;
        b=CQUoVpdLjzszsw8EJY+Q3dZXP9hmLyHBQKYpBXPf1gclA+uAjgUHGBOGjzVHXLUWSl
         ru/P4HrFQNIp8fAr50yYAjPtkpnVDj+mC19ANHn3quuEJnetV/VSJQNk2lUZYhrSwpyb
         ordqqnwiLrAy8+qxidx4uCvocFV2NMRQlJrxKNACZMpyysCeq56aS+sm0+ltAnx5Btay
         9mQYiL7YDE/NVpMBPtttR1DmeNnl8zjSEPaLbPHKYibTjU8+98pvDZJnOd4oMv6VaWsP
         TTraQVmnE9W2rEKHVTmeeOzoINfYZSZEGQaRv8Gyg1zqpV3bQbFxHEm9a6yV9hy5PmKL
         rQsw==
X-Gm-Message-State: AOAM531ojaNvdceb8FGVHfpNjw0SwahMmy77+lSTubXHRsYzFbJuEN4m
        NU4I4R1+qsNWcJOZbtQKx35wc0GWnt3fgLLIV5lcn/CREfqDLChsakbvmR8IlekXkAHBlDNsBIV
        yp4ns34OiGATTjgelc+NQ0YoJbSmgLgLst8Yv
X-Received: by 2002:a05:651c:12c6:: with SMTP id 6mr5292188lje.256.1633002133392;
        Thu, 30 Sep 2021 04:42:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ9VPROzXrnhFDEqZM3+5XH+VvEwc4uc1+UgeDBBsaFfWTg0qHNO338pvCpvOv2QinrtD8cA==
X-Received: by 2002:a05:651c:12c6:: with SMTP id 6mr5292168lje.256.1633002133221;
        Thu, 30 Sep 2021 04:42:13 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id z3sm379628lfe.50.2021.09.30.04.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 04:42:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] power: supply: max17042_battery: fix typo in
 MAX17042_IAvg_empty
To:     Henrik Grimler <henrik@grimler.se>, sre@kernel.org,
        m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
        hdegoede@redhat.com, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210929181418.4221-1-henrik@grimler.se>
 <20210929181418.4221-2-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7c8c781a-a80f-a9d2-2959-254da4844b21@canonical.com>
Date:   Thu, 30 Sep 2021 13:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929181418.4221-2-henrik@grimler.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/09/2021 20:14, Henrik Grimler wrote:
> Datasheet gives the name IAvg_empty, not LAvg_empty.
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  drivers/power/supply/max17042_battery.c | 2 +-
>  include/linux/power/max17042_battery.h  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
