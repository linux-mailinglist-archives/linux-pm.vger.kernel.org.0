Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC867A069A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 15:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbjINN5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjINN5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 09:57:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF511BE7
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 06:57:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A1BC4339A
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 13:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694699869;
        bh=Z0KDPgWeo5efMthoztpzOwWCTyxNs6un0zRktA7SDYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SRiUQ4cbahnMav6KqOA3GbBaLpxpFjP8/2il91aOk1pb7dhobJxjBWX0xkTYRCv1E
         uLCReUMvbCC8fh0lpsC5ftxYr1DdhI9X7kX847r+EbWJieKxEtNgD/1SlrZlvZjTmh
         bJ2Ci90BXURGza5QTuFfGTnY/0CUsqdeZELpjSXmcdUkUFQocmag3eb0iOhWzoz4Xg
         96d7nvGMTftr2zXk4uoHnAEzkP/rDRVbFF10Ng7T2438OTQ51CpEmxGylTQXh3qInd
         Ao/6kbcpExGoJolmLp3IEWU5VulKhntIs8w5XbzqqGtIdtNx8OwOLVCC7zEMKqPWtD
         14iNpvX8KE6rA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-502a25ab777so1650296e87.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 06:57:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YwuEKs1r3mCwgFBM4MAQZOJqWLzqWaQo4Gsel20kq8hQbB5w3Mc
        0/aivIQsbDIOOmusLt8Nq0D3FroG/ab3CbLw8A==
X-Google-Smtp-Source: AGHT+IHNdUOKkW3vz5F79REP5vnA/Wx2ToSwyPSlJlky6TGP6WTmHPQrFclX9Rm3JGY8kBBMtjsqiC2wd7kqF+WVhFA=
X-Received: by 2002:a19:2d5a:0:b0:502:c950:592e with SMTP id
 t26-20020a192d5a000000b00502c950592emr4029898lft.25.1694699867677; Thu, 14
 Sep 2023 06:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud> <CAPDyKFoENVp7+VjKkPpJWDecowxYD=QM6TSa6HjyzOZ=z7r81w@mail.gmail.com>
In-Reply-To: <CAPDyKFoENVp7+VjKkPpJWDecowxYD=QM6TSa6HjyzOZ=z7r81w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Sep 2023 08:57:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLxxmdPTLhZ6MTfuAcM0V7pmfRLiK8L3AZhhQKcvy_PCw@mail.gmail.com>
Message-ID: <CAL_JsqLxxmdPTLhZ6MTfuAcM0V7pmfRLiK8L3AZhhQKcvy_PCw@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] Missed starfive pmdomain changes for v6.6, now for v6.7
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>, arnd@arndb.de,
        changhuang.liang@starfivetech.com, jiajie.ho@starfivetech.com,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        walker.chen@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 13, 2023 at 5:31=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 13 Sept 2023 at 15:56, Conor Dooley <conor@kernel.org> wrote:
> >
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > Hey Uffe,
> >
> > Here's those missed changes in patch form. I figured it might be a bit
> > easier this way given the name of the subsystem is in flux, doubly so i=
f
> > you'd like to put the header change of Rob's on fixes.
>
> Not sure we really need to queue up patch 1 for fixes - or is it
> fixing a real problem for us?

It's a dependency to remove some implicit includes, but I still have
more fixes for 6.6 so either is fine.

Rob
