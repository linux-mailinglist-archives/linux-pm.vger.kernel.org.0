Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0C77B7C0
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjHNLqj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjHNLqH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 07:46:07 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FE5EA
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 04:46:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso4156052276.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692013565; x=1692618365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P1gn77Ztxq7xPn+wQ0Fs/wFqOGj6ZlA2NPjSUCwZ3U=;
        b=fHU5HVcyteFyoy8ercb7Q0BmuyOD576qTt9aNQFaZu6+A8JckEDLK1IYmFkOJRPbnJ
         +1+tSXOAG6Dr1q8G/VBwED0SKGHQH0Pg0KyNvtnOuAHWrjto2N23ing7FZt1DfYYUnF6
         DcMnmV0kN0NSKr1RHMqqlJGefP2gYE4UHs5uhVLQRV9s/Nv6hc9u99mLlkNJAFqDAwoL
         J5AsFApAqVQ2tlZZ/89AWys/6npIRdu4JhrCgSv8GlB7gAA1wIlzlfu55UcAOw0qGrH5
         qh2sJ4BlGmYV1uUC2TMykqdfD/Q+8zBkH6NdWK6iBe/DF8HPCRoDRu3J0N5xnZt0Dp1k
         9feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692013565; x=1692618365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P1gn77Ztxq7xPn+wQ0Fs/wFqOGj6ZlA2NPjSUCwZ3U=;
        b=k/5GvACgOEbkR93V0OWMEsW/XZUGvLErua0AKgBRitUHsG79tBPNLcXKPUgEznw3Su
         kXevZwAlQDpE1OLGnr9juv/lpsUzNszfN//nh/Za5wKZjTbfEIN2dLvaHMB9D0YNrHPK
         1VwT/pX6/KzYUEnhPg6bo5AD7aJbeCppzl+Fv79RGv0bdgXkGcElJ51ko4eGTyuXblp4
         c0W9LimHiYZdT18FL7yRmV/nYMljFvWfW5xaKDOMBIIdvas9NLKpd8aaUdvTFn66FvUH
         IgbHrKYfl0gaSSgkOMrfKWG1QzpwGIL06ZuvBlVz6/oDAQslAWkkUiWq9pbZdR8j1tSr
         GJZg==
X-Gm-Message-State: AOJu0YyZ3z0Rd3wLiyHzPoUw0JPassWfMj6txzQjgQVIcB7sesiN7zuM
        VcTyWEc+HjQrf7MnQqXpz5yTf+2Mp69Aphr7VKqyWA==
X-Google-Smtp-Source: AGHT+IE52lkpTSCVEEuMCNFDfYTvvpD0HznuYfzxrW7Dx9SI0gi3S2xayhsie8DQkNLi3uASK7R4w3gQBDEN6QweWhM=
X-Received: by 2002:a25:dbc6:0:b0:d09:a5e8:8692 with SMTP id
 g189-20020a25dbc6000000b00d09a5e88692mr9932582ybf.45.1692013565501; Mon, 14
 Aug 2023 04:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230731110012.2913742-1-jagan@edgeble.ai> <20230731110012.2913742-2-jagan@edgeble.ai>
 <5699457.DvuYhMxLoT@diego> <3694249.5fSG56mABF@diego>
In-Reply-To: <3694249.5fSG56mABF@diego>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Aug 2023 13:45:29 +0200
Message-ID: <CAPDyKFo=OWGSp00n7ihUuDv7ico6DPp73kYwU1rFf6GYLwKACA@mail.gmail.com>
Subject: Re: [PATCH 01/14] genpd: rockchip: Add PD_VO entry for rv1126
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Jagan Teki <jagan@edgeble.ai>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 12 Aug 2023 at 14:57, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 31. Juli 2023, 22:48:45 CEST schrieb Heiko St=C3=BCbner:
> > Am Montag, 31. Juli 2023, 12:59:59 CEST schrieb Jagan Teki:
> > > PD_VO power-domain entry in RV1126 are connected to
> > > - BIU_VO
> > > - VOP
> > > - RGA
> > > - IEP
> > > - DSIHOST
> > >
> > > Add an entry for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> >
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >
> > @Ulf: now that we have a genpd subsystem, I assume you're going
> > to pick up this patch, right?

Yes, that's the intent. At least after v6.6-rc1.

>
> Looking at other soc trees, it looks like genpd changes right now are
> often still going through these ... so I've gone forward, merged the
> genpd shared tag and applied this patch on top in my rockchip drivers
> branch.

That's fine. We are in an intermediate phase, so things are being
queued both via the soc trees and the genpd tree.

I am planning to send a pull-request to Linus for v6.6-rc1 to make
sure the delta that hasn't already been pulled by Arnd gets included
too. If you merge the immutable branch, you should have the necessary
parts.

Kind regards
Uffe
