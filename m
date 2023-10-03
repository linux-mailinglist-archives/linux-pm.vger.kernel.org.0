Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED57B6B30
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbjJCORa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Oct 2023 10:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJCORa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 10:17:30 -0400
X-Greylist: delayed 4528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 07:17:26 PDT
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8CBF;
        Tue,  3 Oct 2023 07:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696342642; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m21DvYCe5Kjoitispbp8pi+OjSCcMwcxGTnjAKbRM2/uu4wZrDEwv5Ae2thqlhgWtF
    rVaiMgIPi08++oSeGvp7i1Umnx/ARg0rE45yKEoEfxdECw11faOtLT/1vqNDPW+ItfCX
    QXJv1JWdpM7oxM5eHZXiWBDztY7lXFabWEt95u1GlqbBBwcVQ3sFguEYrYuR1D+Fp6vN
    2GbQziE2H3UjiGFkcqQ7reWblOlAUypHCO0LRW9kdOqDbmxZXyb53rNfWukk0Y5XTZWm
    OG+VOxElUGGKtD5gCN6rj/a0s40sAO/oDdNWJhjxb+FJMEfvHOpnJkUizfgEPquQwIOp
    HB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696342642;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DY2B59JOY3X92aFmEbqZxcd1eO6nSLlBopRosxIGxQU=;
    b=BqZBCUIqLU26TVRb6I7AzMgr7xqh4ZLeTLK/ycXVKJldmKmsC/JUNB742aRgrfQGf1
    gjvksQ5/lU5Tyyv7mr+7FLeKG1kokFc5xKGREqw23aFQRkmAnIwqCZ05kOt7WldXivSM
    TkFxPcBdR/qctSznWVzgJSGHHEeK0hKbBFOSwunSouTQVIuzqo6rzZCQtVkcnXxYpbnN
    HFrGSvy6fQQYewSOsBykBJtB4xvQGkyFIYaTK1Zfl0O69pNuTjkv5ai0iZWqr8df7pQz
    qcn2Okr8ZssXS6MTvKFXrM/3DDJmSmwnP8ZxLmAUmut1XLFfFMCQHl5W3ygxgRM8Elxu
    jMBQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696342642;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DY2B59JOY3X92aFmEbqZxcd1eO6nSLlBopRosxIGxQU=;
    b=Tc+siTG+XYIr1U/e35jdJR56torMXXpFlEQHCWGpV87eoITVdeiHQWSQhxXyb9BTGO
    FrCwV6rwaQi7dnzNRXcuuKAOXmwnfSrYrg1cvLngKJX3mfngnwC8h1Omj8TCr8oAep3c
    p4LCPPhUDSfCewG4/5mSoaTOkGgV3bq29fEqQxqr2Y5qmTGDX13bGn47w+72MtzzZSCP
    ts+4B+AeZyIruOdQLp141I391+xTFfFZTf4W93hymhCw63WfbofNsZo9N+NLvIu5JTHC
    1gluICM4aFkSxw5RncTcF+/ahhmasu+moSJZylPJL4vgNrO1OdAAvCO0l3Qyv9AfAhGX
    xUxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696342642;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DY2B59JOY3X92aFmEbqZxcd1eO6nSLlBopRosxIGxQU=;
    b=SEtZQyGzMMvgS0HSDNgv102v+11rGMN5s3cmOVAFCXuI9q058Yv9kebj2+lZLpAXnc
    BQQ0VVz8MCZMPiWT8BDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93EHL2To
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 16:17:21 +0200 (CEST)
Date:   Tue, 3 Oct 2023 16:17:15 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 05/23] interconnect: icc-clk: add support for scaling
 using OPP
Message-ID: <ZRwia2_imBfRfv7X@gerhold.net>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
 <20230827115033.935089-6-dmitry.baryshkov@linaro.org>
 <493aff10d698c9ca5bdbeae45250f5fe.sboyd@kernel.org>
 <7312633f-3b53-43a1-b6e3-010513c2a1e2@linaro.org>
 <ZRwQvP_GbvwvLAn8@gerhold.net>
 <CAA8EJpr9WH+MQdOJQ5yockg9TsUnDcenGbs=dq4Nt0SSBaK=0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr9WH+MQdOJQ5yockg9TsUnDcenGbs=dq4Nt0SSBaK=0A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 03, 2023 at 04:36:11PM +0300, Dmitry Baryshkov wrote:
> On Tue, 3 Oct 2023 at 16:02, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Tue, Oct 03, 2023 at 11:30:28AM +0300, Dmitry Baryshkov wrote:
> > > On 28/08/2023 21:09, Stephen Boyd wrote:
> > > > Quoting Dmitry Baryshkov (2023-08-27 04:50:15)
> > > > > diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> > > > > index d787f2ea36d9..45ffb068979d 100644
> > > > > --- a/drivers/interconnect/icc-clk.c
> > > > > +++ b/drivers/interconnect/icc-clk.c
> > > > > @@ -25,12 +28,16 @@ struct icc_clk_provider {
> > > > >   static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
> > > > >   {
> > > > >          struct icc_clk_node *qn = src->data;
> > > > > +       unsigned long rate = icc_units_to_bps(src->peak_bw);
> > > > >          int ret;
> > > > >          if (!qn || !qn->clk)
> > > > >                  return 0;
> > > > > -       if (!src->peak_bw) {
> > > > > +       if (qn->opp)
> > > > > +               return dev_pm_opp_set_rate(qn->dev, rate);
> > > >
> > > > Just curious how does lockdep do with this? Doesn't OPP call into
> > > > interconnect code, so lockdep will complain about ABBA?
> > >
> > > Unfortunately it does. It seems, the icc-clk is not a proper way to go here.
> > > I will take a look at reusing set_required_opps for this case.
> > >
> >
> > Could you elaborate a bit which locks exactly cause trouble here?
> > I'm probably missing something here.
> >
> > From a quick look at the OPP code I don't see a global lock taken there
> > for the entire OPP switch sequence, so I'm not sure how this could cause
> > an ABBA deadlock.
> 
> For example:
> 
> [    7.680041] Chain exists of:
> [    7.680041]   icc_bw_lock --> regulator_ww_class_acquire --> fs_reclaim
> [    7.680041]
> [    7.687955]  Possible unsafe locking scenario:
> [    7.687955]
> [    7.699039]        CPU0                    CPU1
> [    7.704752]        ----                    ----
> [    7.709266]   lock(fs_reclaim);
> [    7.713779]                                lock(regulator_ww_class_acquire);
> [    7.716919]                                lock(fs_reclaim);
> [    7.724204]   lock(icc_bw_lock);
> 

Hm, I'm not entirely sure how to interpret this. Is there really a
connection between OPP and ICC here? It looks more like ICC <->
regulator and somehow related to memory allocations (the fs_reclaim).

Was there more output around this?

In general, I would expect that adjusting a regulator from an
interconnect driver should be made possible somehow. Just because the
RPM firmware or similar typically handles this internally on Qualcomm
platforms doesn't mean no one else will ever need to do this. If you
have a higher bandwidth requests, need to increase the clock, which
again depends on a higher voltage, then you need to be able to do the
regulator_set_voltage() from the ICC driver somehow.

Thanks,
Stephan
