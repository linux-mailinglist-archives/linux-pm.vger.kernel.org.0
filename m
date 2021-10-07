Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E63425664
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbhJGPOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbhJGPOr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 11:14:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63422C061570
        for <linux-pm@vger.kernel.org>; Thu,  7 Oct 2021 08:12:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n8so24882860lfk.6
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qByRQYZPSzZU4McHDu1g1Gg/B9VSIdti+qORh5qCX3g=;
        b=oNxwO3KqZD0UPefLF9YLmk1EfwVmQLQMYSAuKF48XB1XLqmNXaXmmWq3qa90wRb3Dh
         R+9OIfCfq8nyaX2X6DzesZ77z5EYuIny8Pj/LRUihYJYlaaY+/NKqlDFgxmkq3R2yBOX
         QUCGXHE+qu/Z3ooOBrXxBCBUP+5kKPHNBESXkUgeaTM4EXBc/nA8md2y4zAxiyhO54yK
         PrVF4oGsEjiLfcFUNMOH5zaMnx4ouBTxs1wVRNkQMMEVrUOv6/iCrdAH4v68dMrowSl7
         uLTyD8NWBv0eD1xWQHeF0vckQMpBEBROtp+/hLT9keniqA6rBNzcEIhEsu0KJw0SP2U9
         Ay6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qByRQYZPSzZU4McHDu1g1Gg/B9VSIdti+qORh5qCX3g=;
        b=0iDy/kqfcXjeYAsn6dwpH6S5ynjZW3rkL5fLGMKZpe4r95Mc5+MuDS65VK9hJXXDQ3
         nA23qIMXIXYLy//tg+WyhM2vXNygBahl61aUT1NXj5xpXkGoDcMzDIRhOwxQ9g73PN+K
         B87ThiwIo3+m2kayQcyHrYv9AeM/lr0fwZ3wT/9m2mMiYz1CA3vu5KMlC3oOURp0B6Tl
         esqhWNXmv7kXKHXSINTWYfe1ogm+M3A/Ag6UQcofNvqhWbBkjyCRoCqOaoolnOxLYu1D
         Ci/AaCYdloJ4Sma3ea03/Fkfw7b46mZT2A0dQn36gNNoPwPpVn90/+WH2WIMfqLyqwt1
         Rtkw==
X-Gm-Message-State: AOAM533LXCZYHV1i/VHzaSFUucADAYJMdMV4GQVH87C9NAiRkJAw3/GL
        wT1JFn9w5mGsg0hs09/EFSk1ONJjrlTUuLAyft2dmw==
X-Google-Smtp-Source: ABdhPJykZwmeGaMvUFZnZ9N56cekxKt0yxTYZT6M3qJHhgw25+3gvXxOlaOgq63tPEsxH14DLsl8yGMfckv+Z/Gno/k=
X-Received: by 2002:a05:651c:4d2:: with SMTP id e18mr5213721lji.432.1633619564176;
 Thu, 07 Oct 2021 08:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211006224008.394191-1-linus.walleij@linaro.org> <1633608336.217732.121526.nullmailer@robh.at.kernel.org>
In-Reply-To: <1633608336.217732.121526.nullmailer@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Oct 2021 17:12:32 +0200
Message-ID: <CACRpkdZ0hr+bb708iLcYMUEmiA6MD2uN9OFFs8qNRUV-RipkTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: ab8500: Standard monitored-battery
To:     Rob Herring <robh@kernel.org>
Cc:     Marcus Cooper <codekipper@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 7, 2021 at 2:05 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, 07 Oct 2021 00:40:06 +0200, Linus Walleij wrote:

> > Make monitored-battery the standard phandle to the battery we monitor
> > for the AB8500 charger components. We make the old "battery" phandle
> > deprecated, and the new one required so we detect and fix all users to
> > use the standard phandle name.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../bindings/power/supply/stericsson,ab8500-btemp.yaml | 10 +++++++---
> >  .../power/supply/stericsson,ab8500-chargalg.yaml       | 10 +++++++---
> >  .../power/supply/stericsson,ab8500-charger.yaml        | 10 +++++++---
> >  .../bindings/power/supply/stericsson,ab8500-fg.yaml    | 10 +++++++---
> >  4 files changed, 28 insertions(+), 12 deletions(-)
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.

All of these are fixed in patch 3/3.

Yours,
Linus Walleij
