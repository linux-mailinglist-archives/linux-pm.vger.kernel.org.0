Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD4F4A4CC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfFRPJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 11:09:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42341 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFRPJO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 11:09:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so9557981lfh.9;
        Tue, 18 Jun 2019 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3z4ooMqqLKD/hzgGGQWs+ev7PXuSayk0SXXm5Gk74A=;
        b=YTSpVpVP1wJifrXotuGKFrWnUobbeYF1bpGOYnUcWWtAlAkm2yyUzaOJzEYmwd1Fvx
         XdYJgqrEkXfQ8QzUmfgvcBHfLVvr0/pCQtDtxWgxSqN2McdLMMNETqTqJTB5blwFdYJg
         ZLCvexoMxK0ZpFP7cM9LySFPJNeEmNXbObOtGxkKTWbiwBJDOAnGC1VA80A9Wa2sQDf1
         sQrNGbuvvMWEJDsV84Q1W/FMyzLrvPiweWXCiJ6h+5yam95dDNslkMn13w5tcTz5tqYY
         XUkrUaIRCu8bA9lgl9/qDkIBrNobZCY2R66bHhBKiiFRZke5qijXoZGxYiwD8fr8tPrV
         1icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3z4ooMqqLKD/hzgGGQWs+ev7PXuSayk0SXXm5Gk74A=;
        b=FzAVB6HQYkUYD0HvRWoj5J8yz7Ot33wMD5d+hb+JtMcOMYi/ZYCdI1pV8Vbls8/Fg+
         ZA5THXSWHAa3XT6ZjVW9jbIlTg+wGyFdLHYnSrbqAXUTJhGCEKZbirbL+semUFmL5Vbc
         d83qzaNMFLQ0jxdn2qyoC2eDrVdv7TnRl7WYktBsDR4daUFEBggAFoGaRc2uQsnM22st
         xHgEN0SGSkOUu7tq/KzKDSscrSmSssiUJVqC2dIKOepf5ek0Cao3HYfLYeNj7Fs+zOog
         nq8fbQHxx9w/nYP3jfT7LDFYqleBsJhgOO9x+mst4tyt/rI7rVwHbrweAeB7dBRD7oVO
         ltNg==
X-Gm-Message-State: APjAAAXRk/3MKpLe3wiIkFuV6Qq3rMBZGjg2bYdC9j6G9KwyDyBah8KQ
        G4Ip/mMFV33cabn+THLL91MT11MWeF35M+LNdtM=
X-Google-Smtp-Source: APXvYqwxRVNdPswQrYbmP28S6ZDttANal0lK2TpOrbDM3rh2zMCAKn/QlFl23W8/UMawrYywzOnHNSt2tnbomQmGAOU=
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr16092246lfn.12.1560870552439;
 Tue, 18 Jun 2019 08:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com> <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
In-Reply-To: <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Jun 2019 12:09:23 -0300
Message-ID: <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 18, 2019 at 11:46 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:

> Thank you so much for your reply.
> Yes, I already checked the latest mainline kernel changes until 5.2-**.
> I see that there are many cleanup related changes, but still I see
> that suspend/resume functions are missing in dw_hdmi-imx driver.

Please see this recently submitted patch:
https://lore.kernel.org/patchwork/patch/1084057/

> So, I am trying to implement myself.
> Also, I see that suspend/resume is missing even in :
> drivers/gpu/drm/imx/ipuv3-crtc.c
> I am trying this also (not sure if we need this as well).
>
> Can you point out some specific patches which can be helpful ?
>
> Currently, what I observed is that hdmi bind() functions are not getting called.
> Not sure who is responsible for triggering this bind function.
> Or, irq remains disabled after resume, and we need to enable it back
> again (but how ?)
> Or, we may need to enable vblank events and thus irqs can be enabled.
>
> So, I am exploring many possibilities.
> If you have any suggestions please let me know.

The suggestion I have is to try to use latest mainline kernel. If you
see any issues with it, please report.

The combination you mentioned in a prior thread (kernel 3.10 +
backported drm patches 4.9) is not really something the community can
help you.
