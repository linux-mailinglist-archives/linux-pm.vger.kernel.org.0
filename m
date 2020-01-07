Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2F513306F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 21:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgAGUOo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 15:14:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43494 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUOo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 15:14:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so640593edb.10;
        Tue, 07 Jan 2020 12:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shdUU23K0IEf7ZFJ8JLqr2RIvpPkSrbg6xdebmpUuBk=;
        b=CE7JxfLxTCbq+CfKqig1FP7+uAICGegXA38mgHVhFcu8tIDzOnK2DmN/87NzcKkdLi
         S0yqEQucpHBMl5gcGJimsDnPnWDP5f8keVWyaxsAGHKYpc5eos/i0VoaeEzmyROQqNZu
         ZBc1ROaM/nHDqbEQxk+x7x8hOH712yObovXaEF3Cysoz77j6ua5rtY5OtdrtWmq2FbGM
         B/IsiLzExLIa/R7bTkdHvm6s0GqR/ov4ITSSuWoY55Oz+igPWKwRGsFYx5J+SAkqC3en
         cMpJElxEVCs9gv5kH9LG6xaEDoV6o96mOb5aCV4ZUNhvL56X37VFKI60fEOrAvSppDYm
         rJrw==
X-Gm-Message-State: APjAAAWpNsK3LqcVyNQO1DxQFlCGrYX9p3h1mJJn5UYPjWPF49S1kNr5
        ibQLVw7t0fTQuux9mzLXoGVBYcBr
X-Google-Smtp-Source: APXvYqxvhO+xtcJuzGv5TR4UrQN67+VzGE8I0ZqMCIB4xGEAsxpokcN4a/8SFQaVXLRtd6nc5VnFtg==
X-Received: by 2002:a17:906:1181:: with SMTP id n1mr1218322eja.218.1578428081904;
        Tue, 07 Jan 2020 12:14:41 -0800 (PST)
Received: from kozik-book ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id h5sm12464ejt.91.2020.01.07.12.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:14:41 -0800 (PST)
Date:   Tue, 7 Jan 2020 21:14:39 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/20] ARM: samsung: Rename Samsung and Exynos to
 lowercase
Message-ID: <20200107201439.GC8636@kozik-book>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200104152107.11407-5-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 04, 2020 at 04:20:51PM +0100, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Samsung"
> and "Exynos" names.
> 
> "SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
> names.  Therefore they should be written with lowercase letters starting
> with capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Although advertisement materials usually use uppercase "SAMSUNG", the
> lowercase version is used in all legal aspects (e.g. on Wikipedia and in
> privacy/legal statements on
> https://www.samsung.com/semiconductor/privacy-global/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-exynos/Kconfig                  | 36 +++++++++----------
>  arch/arm/mach-exynos/common.h                 |  2 +-
>  arch/arm/mach-exynos/exynos.c                 |  4 +--
>  arch/arm/mach-exynos/include/mach/map.h       |  2 +-
>  arch/arm/mach-exynos/pm.c                     |  2 +-
>  arch/arm/mach-exynos/smc.h                    |  2 +-
>  arch/arm/mach-exynos/suspend.c                |  2 +-
>  arch/arm/mach-s3c24xx/Kconfig                 | 16 ++++-----
>  arch/arm/plat-samsung/adc.c                   |  2 +-
>  arch/arm/plat-samsung/devs.c                  |  2 +-
>  arch/arm/plat-samsung/gpio-samsung.c          |  2 +-
>  .../plat-samsung/include/plat/samsung-time.h  |  2 +-

Applied.

Best regards,
Krzysztof

