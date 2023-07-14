Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70728752FB3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGNDHb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 23:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjGNDHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 23:07:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF82D6B;
        Thu, 13 Jul 2023 20:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4200F61BC4;
        Fri, 14 Jul 2023 03:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC34DC433C7;
        Fri, 14 Jul 2023 03:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689304048;
        bh=9rymoG9mEwirp8s4sG3jC+PHbKcwoVV/IgliH12Y/mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSS7AnRrCw3DpEIu9mal4etXSMaqgR7wmAwv/1mnP3z0I74I/+INnovtwUeEQCZ4U
         7UqEcxZgxO3N5l9g7krje+vwM0leY79VCsmrMDWYIdIDuOchJ9VnKUWP4le/QjFV80
         +F6MOLWZarAPF+zahW1Cmony2rRy9d/5bWpvkm3WC4Q5xYCbkCjDxUtVjQywrP1j2J
         oIewMPHc6Kcn4XuibRc1M0u7+7wH1pw5Dngsw4WFE64GIQJvH1VHMHdTZvg6JlX4fI
         kTRSFFRp+9uuF77OWYj/GpncQfFt2x7VSVSHiqF7JXOZF/uFEZyTyXWY2XE39eli/L
         uM0ORSclDT9zQ==
Date:   Thu, 13 Jul 2023 20:10:58 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Olof Johansson <olof@lixom.net>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
Message-ID: <5oroxttb4cdza27mcms7zghlwxvvn47pxtjkxhrmkkyqpt2ho6@ucivd3kovqyd>
References: <20230707140434.723349-4-ulf.hansson@linaro.org>
 <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
 <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
 <1496b9c1-289a-c354-f0ae-e14fd4c9bcfa@linaro.org>
 <CAPDyKFr7Mqy5bisLcxcA_iEGWqL8SFt2mDDng7zYEaTD1vNisA@mail.gmail.com>
 <deyyt5r2wkxo7ily434gl3wudls2sbinkmnehssqshwnbzmlwf@lmqskj6zwfu2>
 <CAPDyKFoRtEXTGQkNzGza-sS_j1ajGmjtCTaoPB7PXVDE2bS0tQ@mail.gmail.com>
 <2ef84fb8-b5eb-4c9a-b8a1-0c5f33e7f572@app.fastmail.com>
 <sxyavxzvezu5dorysn3nmwq7ew5xdclpm7rg474cifnnzy54mb@jljrhirrir2i>
 <CAPDyKFoQoKx1uEpFBNfsaCFEG_9TOzSdNW90h-+bVz+_3xYObA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoQoKx1uEpFBNfsaCFEG_9TOzSdNW90h-+bVz+_3xYObA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 13, 2023 at 11:50:29AM +0200, Ulf Hansson wrote:
> On Thu, 13 Jul 2023 at 02:45, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Mon, Jul 10, 2023 at 02:45:12PM +0200, Arnd Bergmann wrote:
> > > On Mon, Jul 10, 2023, at 14:37, Ulf Hansson wrote:
> > > > On Sun, 9 Jul 2023 at 04:21, Bjorn Andersson <andersson@kernel.org> wrote:
> > > >> On Fri, Jul 07, 2023 at 05:27:39PM +0200, Ulf Hansson wrote:
> > > >
> > > > If I understand correctly, you are suggesting that each platform
> > > > maintainer should merge the immutable branch with patch1 - and that I
> > > > should send the patches (based on the immutable branch) to each of the
> > > > platform maintainers to manage. Instead of one pull request with
> > > > everything directly to Arnd, right?
> > > >
> >
> > That's what I suggest, yes.
> >
> > > > This still means that Arnd will have to resolve the conflicts as the
> > > > pull requests arrive in his inbox.
> > > >
> >
> > Yes, we will have N maintainers modifying drivers/genpd/Makefile, all
> > adding their single obj-y line. A quite trivial conflict to manage.
> >
> > > > Although, I guess what you are looking for is less work for the soc/
> > > > maintainers, which seems reasonable. Although, in that case, I might
> > > > as well share an immutable branch with the complete series, rather
> > > > than just patch1. That should help Arnd too, I think.
> > > >
> > > > Again, let's leave the call to Arnd on what to do.
> > >
> > > I think it's much easier for me to pick up a single branch with
> > > all of your patches. For platform maintainers, other changes can
> > > go one of two ways:
> > >
> > > - send a normal pull requests with changes against the same
> > >   files, and have me take care of any conflicts where they
> > >   arise. Since most of the changes are just simple file moves
> > >   rather than changing file contents, 'git mergetool' handles
> > >   these fine is most cases
> > >
> > > - If there is a non-obvious merge, the entire genpd branch
> > >   can be shared as an immutable branch, with patches for
> > >   a particular platform rebased on top of that branch.
> > >
> >
> > I already have a set of patches to these drivers in my tree for v6.6, in
> > their current location.
> 
> Right.
> 
> >
> > I'm afraid I am unable to see how we're going to handle the merge
> > conflict you're going to create in linux-next. Perhaps you're proposing
> > to just never publish Ulf's patches to linux-next?
> >
> > By me merging the immutable patch 1 and the qcom-patch, the conflicts
> > would be minimal, and except for the genpd/Makefile entirely handled by
> > me.
> 
> If you would merge the immutable branch containing the complete
> series, that should work too, rather than just patch1, right?
> 

I believe git should sort that out as well. If so I have no concerns
with that option.

Regards,
Bjorn

> As a heads up, I am planning to send the pull request with the v2
> series tomorrow, allowing a few more acks to arrive. At that point I
> will announce the immutable branch too.
> 
> Kind regards
> Uffe
