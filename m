Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511FF465059
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 15:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245328AbhLAOuk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 09:50:40 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40529 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351461AbhLAOuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 09:50:00 -0500
Received: by mail-oi1-f172.google.com with SMTP id bk14so48964854oib.7;
        Wed, 01 Dec 2021 06:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHlQKFdRmHGrGusvRZxAIIy9u1JQqYfGD9T6CB33KYM=;
        b=3FiezFslMLAtKuir2T298DE4MhwryGsZ/M5M9ds61Tzhli/GMYKbxVHv65eVx3r0HY
         OSRvD+vbAay6A0oyN896oltHs7WFnZThvCAdhhjzo7y8FPoSON4QQWLqXMdGyLJf5EWm
         sJTRfETMVE1wSylVuLr12mk4Pj/bzt9ipS8wr1Oj3sPrKlSE3LjVDXoUMQDbWj/Dl1XV
         x6dyCziakOnGcLzM9hsHOAEQlXe9JvfCBk6qeesEkX87zl/LjqTgWOdGUfe+EIKeK8s8
         kcB0Kk4LVMCQkDJe9StFFQCMB7yZMMTah379p6SWlyjDVWUxPaRyyvmz3BrPOyP24grl
         tmxQ==
X-Gm-Message-State: AOAM530O7x0eUwd/fyRhUCBiswrabO2J2iGWb7BdVJulxRuodn4VE9eT
        kROYyaaSQTrtRpzIkQlf1sYPw8pGM18yCccNtmg=
X-Google-Smtp-Source: ABdhPJz3iqJlu25kel8NkDOAqEIDYIppOuUIXsOo5T5so4K6B2b9xfKsnjrS2jUAwAhaYdj1u6BcVDTz+x0ayz8Ocfo=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr6381292oih.51.1638369999775;
 Wed, 01 Dec 2021 06:46:39 -0800 (PST)
MIME-Version: 1.0
References: <4239b61f-f8c5-462f-2951-fbba2dec8b1d@gmail.com> <20211201063041.GC684@gondor.apana.org.au>
In-Reply-To: <20211201063041.GC684@gondor.apana.org.au>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 15:46:28 +0100
Message-ID: <CAJZ5v0iEFye=BJjqUQUDP+e3r_fSWxj-bv=W7aaJO7fuk5wyZg@mail.gmail.com>
Subject: Re: crypto: stm32 - Revert broken pm_runtime_resume_and_get changes
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Shixin Liu <liushixin2@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 1, 2021 at 7:30 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sat, Nov 27, 2021 at 02:39:52PM +0100, Heiner Kallweit wrote:
> > When discussing whether pm_runtime_resume_and_get() should be annotated as
> > __must_check, I became aware of RPM usage in crypto/stm32.
> >
> > Following two patches replace usage of pm_runtime_get_sync() with
> > pm_runtime_resume_and_get() w/o checking the return code.
> >
> > 747bf30fd944 ("crypto: stm32/cryp - Fix PM reference leak on stm32-cryp.c")
> > 1cb3ad701970 ("crypto: stm32/hash - Fix PM reference leak on stm32-hash.c")
> >
> > This results in RPM usage like the following in stm32_hash_export():
> >
> > pm_runtime_resume_and_get(hdev->dev);
> > ...
> > pm_runtime_mark_last_busy(hdev->dev);
> > pm_runtime_put_autosuspend(hdev->dev);
> >
> > This is broken. After pm_runtime_resume_and_get() the usage count may be
> > incremented or not. If not, then the call to pm_runtime_put_autosuspend()
> > results in exactly the imbalance that the patch claims to fix.
> >
> > Therefore I think both patches should be reverted, or the return code
> > of pm_runtime_resume_and_get() has to be checked and properly handled
> > in the driver logic.
>
> I agree.  But we can't revert them completely because it does
> fix some genuine issues with the ones where we do check the error
> code.  What about this patch?
>
> ---8<---
> We should not call pm_runtime_resume_and_get where the reference
> count is expected to be incremented unconditionally.  This patch
> reverts these calls to the original unconditional get_sync call.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The rule of thumb is to use pm_runtime_resume_and_get() if you want to
check the return value (and act on it) and pm_runtime_get_sync()
otherwise.

> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Fixes: 747bf30fd944 ("crypto: stm32/cryp - Fix PM reference leak...")
> Fixes: 1cb3ad701970 ("crypto: stm32/hash - Fix PM reference leak...")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
> index 7389a0536ff0..05087831e199 100644
> --- a/drivers/crypto/stm32/stm32-cryp.c
> +++ b/drivers/crypto/stm32/stm32-cryp.c
> @@ -542,7 +542,7 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
>         int ret;
>         u32 cfg, hw_mode;
>
> -       pm_runtime_resume_and_get(cryp->dev);
> +       pm_runtime_get_sync(cryp->dev);
>
>         /* Disable interrupt */
>         stm32_cryp_write(cryp, CRYP_IMSCR, 0);
> diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
> index 389de9e3302d..d33006d43f76 100644
> --- a/drivers/crypto/stm32/stm32-hash.c
> +++ b/drivers/crypto/stm32/stm32-hash.c
> @@ -813,7 +813,7 @@ static void stm32_hash_finish_req(struct ahash_request *req, int err)
>  static int stm32_hash_hw_init(struct stm32_hash_dev *hdev,
>                               struct stm32_hash_request_ctx *rctx)
>  {
> -       pm_runtime_resume_and_get(hdev->dev);
> +       pm_runtime_get_sync(hdev->dev);
>
>         if (!(HASH_FLAGS_INIT & hdev->flags)) {
>                 stm32_hash_write(hdev, HASH_CR, HASH_CR_INIT);
> @@ -962,7 +962,7 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
>         u32 *preg;
>         unsigned int i;
>
> -       pm_runtime_resume_and_get(hdev->dev);
> +       pm_runtime_get_sync(hdev->dev);
>
>         while ((stm32_hash_read(hdev, HASH_SR) & HASH_SR_BUSY))
>                 cpu_relax();
> @@ -1000,7 +1000,7 @@ static int stm32_hash_import(struct ahash_request *req, const void *in)
>
>         preg = rctx->hw_context;
>
> -       pm_runtime_resume_and_get(hdev->dev);
> +       pm_runtime_get_sync(hdev->dev);
>
>         stm32_hash_write(hdev, HASH_IMR, *preg++);
>         stm32_hash_write(hdev, HASH_STR, *preg++);
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
