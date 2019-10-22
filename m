Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2829AE0301
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfJVLgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 07:36:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40443 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388671AbfJVLgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 07:36:36 -0400
Received: by mail-vs1-f66.google.com with SMTP id v10so11073093vsc.7
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3wKbTBUKP6SIGW0M4ikXUtvVnEKJUreL442G2T7ab4=;
        b=Ye8tfWt1asteO3/JF1kojzWMFxRIk4e7BCZMzzJ97nkAJUqURkc0tHVJjJYRmrS2FE
         fEQ05ifQf6jkm6M0mUmEY+GPZNGARhDym439OMiF5h/bRTvEG2sPUl3hMFZfJRWXAdsK
         pUP4WWfCR2VZOBzq9FJjVtCaOBEFChMrRQ9kdUueMinNuL5fUZwgW9gcPhzR59erCdKV
         AI6adQGevE3aX/Y0lotJQJNdh6r9CHUOXi23/AyDrv5Kg39fi4NMO+dxubtCMg/fssTV
         buwQ9wF14UhQkenOMo1jSeeE19rLk/DyTI7y6NJhAalPMwytSf+beQMAkOTO0Vr5OLQL
         TBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3wKbTBUKP6SIGW0M4ikXUtvVnEKJUreL442G2T7ab4=;
        b=mW81QKDFLJZC/hcdO1pYr6AxTMkQD9+pS+2cUX09rTrIs0JqOi4QJAk3GYXXkJAH3s
         WnHwALkOJSQTnKEGjU4WDMLz7MfqA3+LCGEuALemjG9azJBhq+3N0cIqF8xcmBqxksGe
         SaYNMqZ7Hqf0Uac4ru/O6NLaeqAiO7WM2UnEjRDClJikSBufGSND8UL0u1NTKf5N7qWI
         PJDDjZwhI/fWGHkCLrOsY2g815CJgX7kU6Sg7S+CGCQMSbBxOCnVzcBQq7FLaj4K4ESa
         w0Tm+aPF0vJtCShm6Rbdy901FahM4RCQBVRr191Mm1gPVvvre7o+oKMl4tKJypL0dx0z
         NdwQ==
X-Gm-Message-State: APjAAAX2teBx2GdEaHnxH7M254qsxwaNPkZl+ugrFXNNevGawP4JWwAQ
        b42EQOGGQOktxihcbHWemadOJTuAYuI5JrPMPvEHOw==
X-Google-Smtp-Source: APXvYqwuhOE31x77XR1VxuIqjduSlWdBjdu2uW4BzvMyCy0l28uEXKzKRCKHQYGfhDpkiANT16UsxmyGqeILUyu62rI=
X-Received: by 2002:a67:fe42:: with SMTP id m2mr1563331vsr.67.1571744194906;
 Tue, 22 Oct 2019 04:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191022111856.44118-1-weiyongjun1@huawei.com>
In-Reply-To: <20191022111856.44118-1-weiyongjun1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Oct 2019 13:36:23 +0200
Message-ID: <CACRpkdb0JMTj3xzLODdYbQe=o=pY3LbVP0RLcdBn-teDEu5EsQ@mail.gmail.com>
Subject: Re: [PATCH -next] power: supply: ab8500_charger: Fix wrong pointer
 passed to PTR_ERR()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 22, 2019 at 1:19 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
>
> Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

If Sebastian has pulled Jon's branch into his tree he can apply it
in the power tree I suppose.

Yours,
Linus Walleij
