Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED183EBE08
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 23:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhHMVre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhHMVrd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 17:47:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9883EC0617AD
        for <linux-pm@vger.kernel.org>; Fri, 13 Aug 2021 14:47:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w20so22434790lfu.7
        for <linux-pm@vger.kernel.org>; Fri, 13 Aug 2021 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eT0SyDLhtqUCRVoTbFA0TfLCPJmpdZc1LYFo2vzcrU=;
        b=Z7llxaB03js+5zDqMl9BJeU8H603XLw8p0usL4lrTwS3FMi3UtyJAdU1gA5WtzQ5aP
         qp0K/OxL+afYh795ltTSFjme1o+v67sL3pNfGWUPAHja4xu4MZAPcSk1wfJPtG5GY5QS
         kNn84rHKdih51ram5Y6A+lxip7ybeLuymORIGF9DMkF6EQdgTFC237xBhQrCNKmPG2xN
         dgImHkqxU95PBDIjx4NfAtovGSGQG3QZN5es6qdAraUOddZGHiZGgTb0dkgDC/80f/Mn
         b2SZrAorG4gJ42Vf1cAZcRwF2sgZqq5R4+b81fbBIn6WyR2BMsO2FEw5VL80EoE+Vm54
         9gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eT0SyDLhtqUCRVoTbFA0TfLCPJmpdZc1LYFo2vzcrU=;
        b=XEaUECemCWw6Yt+H83p1utISon+3efMvn3qbsXmMpj/v4PnIm7UYuFp4zU2kkhfIWJ
         Dn57VFhqQ2VJrupkG3jtjg8N5G/ICtFOipIsRJ4ehIE/QPs0xPtfY2vUAz2wAfgF/lCt
         SnVqq8rQ1k32mLlfJSn5udL+2qqcBHy8g9LDGYqUa89D6/SZBoBM9fR45N94398p17hA
         icaI+8zcnEFhBh2xmG6m140lS0v2/860mxeGMKeyJ1EvLN8OZVeKf+uiMft2uD9IYOft
         uGEMx9NQ0fMd29PGtGF25/HBPH9Blxd9lQpwzObtq8PvMueIEOqDVhjBdL7pQjpXCDXi
         +2TQ==
X-Gm-Message-State: AOAM533eQcmbIbWiJFvS2YaBZdwnnoXrVcXOG9vT5ms/m/cL77SBELxR
        nNElpcZpjvzDLJ5AN9M9peP+Cp27NEmEnLAAWkweFA==
X-Google-Smtp-Source: ABdhPJzIl9ij4hoqRja2SJhOC1MMNQl/5QwyoHXCpxzvQa+0J3XpSsf519mnSkQWEtXLfDnZLZmoVyxR0QNhVU0wdJg=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr3156477lfd.529.1628891223784;
 Fri, 13 Aug 2021 14:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210805085828.3451909-1-linus.walleij@linaro.org> <YRa5UnBcmW1KBIEd@robh.at.kernel.org>
In-Reply-To: <YRa5UnBcmW1KBIEd@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Aug 2021 23:46:52 +0200
Message-ID: <CACRpkdbcVJbMnCQ3P1nPmFUsJSw2jgpr2BEzz6GBUQLhBVuO_A@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] dt-bindings: power: Extend battery bindings with type
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 13, 2021 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Aug 05, 2021 at 10:58:27AM +0200, Linus Walleij wrote:
> > This adds a battery-type property and bindings for the different
>
> s/battery-type/"device-chemistry"/
>
> Otherwise,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob, Sebastian tell me if you can fix this when applying
or if you want me to respin the patch.

Yours,
Linus Walleij
