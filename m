Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727B680250
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 23:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395180AbfHBVuq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 17:50:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36253 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395178AbfHBVup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 17:50:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so74173246ljj.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2019 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+6NeIcL7nIjmDGVLWabC3vXM+Jl0SVqaRvJgDEpCqw=;
        b=zW3PTB/WFvF+k/aMp2lt6zvwPsJOXSOWNvK4f2fEkcHmPImTWcM4t8CfbJgvDztVZ/
         Q+X25hSkndasM80otX/J5yTNL1FNvqXYEEENQp55f7PNUAmfF/Qla14xP/qKRF4Qx+D/
         iueJUlhJ3B7BrHzJ5hRmFEKtPiZg15ap+2+26eJNzIXV2BBDtR0xeosrH8TRq4UJM69t
         zanGCNJ+48SzWEfcaDnw+Cjsyspsuy2lF1QzxAuEiJT7JbsnmH3KhH5U71qNyJfVPJGG
         15m+snrj+nLwv+GjsSqpSaOpRl2y0XxF9Q3ceTMk10LLo6Mtb2+D8gruB8NTkqL+xrHF
         yVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+6NeIcL7nIjmDGVLWabC3vXM+Jl0SVqaRvJgDEpCqw=;
        b=HajRlB7H9rd1weZlQrPr7TVUIIigiwF707DHuIbA0s2nCt3kPKeEjNfoThcKuOGHIr
         UcVaz2/zaE58exfsNzPFEGje8BgfLIsuQB+p32l0LkbRCuxwiCZJQ0L5bqV4MShZKa6P
         5M0b5btw4GbCbgVllfJpzBHRd1Y1TFawWfjmObZ/Brhd4ne1FAc1bcb1K0kyTkMgTjcb
         L1GH8jUY8loqMJ165eReKJYal1nE7QF0Gp8jYf0GENVrh4R74Qwep+o4wqIxv43JkciW
         c6MRiYpEnuHZCeH4Aslcj2CV+wfhhTh7i5ejWfD55AGk8qe/WY3j35ygnoUrwpmw9tAb
         /q4w==
X-Gm-Message-State: APjAAAXpcPavKjjyvSjKpTmLaIqmJAS1Dhv57V1PkkwpSfp9cDuF70Gk
        jd9DsfYoA2xorj/+BBT21SMT/Cp3OiI+zfkc9HnK0A==
X-Google-Smtp-Source: APXvYqyBjPR9tsFzJkl8sdRatkgQDGJTpofe1VtOni4strgFOm/fAXU02CWmWIzEblvJBHgoefzqjSHWEou+yWPYBLs=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr7977275ljo.69.1564782643699;
 Fri, 02 Aug 2019 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190717141848.31116-1-yuehaibing@huawei.com>
In-Reply-To: <20190717141848.31116-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Aug 2019 23:50:32 +0200
Message-ID: <CACRpkdYvzWA0iZad4yamjhnwbA4rm6FgCQBP3nr1gKCg8_kRAA@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: ab8500: remove set but not used
 variables 'vbup33_vrtcn' and 'bup_vch_range'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 4:19 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/power/supply/ab8500_charger.c:
>  In function ab8500_charger_init_hw_registers:
> drivers/power/supply/ab8500_charger.c:3013:24: warning:
>  variable vbup33_vrtcn set but not used [-Wunused-but-set-variable]
> drivers/power/supply/ab8500_charger.c:3013:5: warning:
>  variable bup_vch_range set but not used [-Wunused-but-set-variable]
>
> They are not used since commit 4c4268dc97c4 ("power:
> supply: ab8500: Drop AB8540/9540 support")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for fixing my forgotten codepaths!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
