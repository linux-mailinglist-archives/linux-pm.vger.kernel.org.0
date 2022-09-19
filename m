Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904825BC5CB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Sep 2022 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiISJx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Sep 2022 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiISJx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2022 05:53:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAE12AE6
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 02:53:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x29so963134ljq.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ozine1LMZl3lCyd+gDTUkyJgK4VZq5xPo6I1YmSTgwk=;
        b=C0bfl5Yo6yR3581/nF0n6kJEeIj5RBteWgMCu0HqpgK61dWDWcYla+fmuc5Xa/XSlZ
         bI+aUabiJ2ho4ZkmCZrqa9UhvilCmYPTrPhRdQybAb1P0uShrmNfbaHPiRiAdNYjcvxV
         1U1F5GqNzqP94l0HJet1lbepiCS6UMBYc9qHpd3AN8M7AS7tGoZplkQmF3kqokpJC8yK
         La4Vn9NSOkLeUr5Yzym5qG5wfWB5GWKt/E+qkAR8xwG+ZDhV26ALPbgMMmVCnIZisXyU
         R0o+PGTSeD9rQyiFMbX5NbqwRhyfeXk8kxyr8RHZl5FC5l1s/D00wMnkuQ2jcYAF/B83
         +nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ozine1LMZl3lCyd+gDTUkyJgK4VZq5xPo6I1YmSTgwk=;
        b=y/IHTk1DDfUZ9kZUzUpyVHSSF5N/KgxjCfONjIN/Ya7kCXv0ckfPkKWSkGrDysHh5b
         256hG3BFtsLj/HfPrxa8cRfouog00yzVPzYfpjeK4qTv0qrFj1GF7KLo5Fiylk3EG+iK
         xeyOUXq0YObDvGi2rqW3KCL4kgjpssEjpSwUF5m1Jwcpu9lOL2FT6XTcKQS9mKlQMBaD
         ikFKUV7fEpmb4y1W15qvbkbHeHjUB9bz/OF2h/sn5SQUeJ6zLcuafI4YimhhVOYI51Ri
         bh9ufjJPlx38W4OvBoTDXGFuLaTHFK1Ck28wE6Yd2IWl7k9JjFTtS0vYoV8kpMmT5X5y
         BZFQ==
X-Gm-Message-State: ACrzQf3Pz0G//qQ/MV/AGpTe07Z9gd0xJP61lREDZl6YTyOKeHIBATO8
        byEKwnAPAWubpBwC4fenPZrOII+nKkRlP+ghGW2rhg==
X-Google-Smtp-Source: AMsMyM5fWor7zFcZGDCoNv8tt/+3I7m5yu8diMswgk2YJB7/em0eqqnIXj479N3TRcb3sLl9C829jV6tZUmCE6lurpU=
X-Received: by 2002:a2e:b744:0:b0:26c:40bf:eaba with SMTP id
 k4-20020a2eb744000000b0026c40bfeabamr3683897ljo.367.1663581234550; Mon, 19
 Sep 2022 02:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus> <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus> <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
 <CAMuHMdX2rJq0DJo9D_RSMoAj9GPc-Zts5+UNCFQGF3+EYVSXgQ@mail.gmail.com>
 <20220914153038.inbch35g7ldsyzhx@bogus> <81pr96n7-p42q-s3s-1541-n777or1p612@syhkavp.arg>
In-Reply-To: <81pr96n7-p42q-s3s-1541-n777or1p612@syhkavp.arg>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Sep 2022 11:53:18 +0200
Message-ID: <CAPDyKFoBvX7WmJu0E1p0RuVCEKFFk===ZVnYtbz9o=RZPzHSTA@mail.gmail.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
To:     Nicolas Pitre <nico@fluxnic.net>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peng Fan <peng.fan@nxp.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Dien Pham <dien.pham.ry@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 14 Sept 2022 at 19:05, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Wed, 14 Sep 2022, Sudeep Holla wrote:
>
> > On Mon, Sep 12, 2022 at 06:58:49PM +0100, Geert Uytterhoeven wrote:
> > > Hi Sudeep,
> > >
> > > CC Dien Pham
> > >
> > > On Mon, Sep 12, 2022 at 6:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Fri, Sep 9, 2022 at 4:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > > > > > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > > > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > > > > > > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > > > > > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > > > > > > >
> > > > > > > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > > > > > > it or is there some platform/driver that is really relying on it?
> > > > > > > >
> > > > > > >
> > > > > > > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > > > > > > Not sure if it is still used or not.
> > > > > >
> > > > > > Okay! Maybe Nico remembers more, as he authored the patch...
> > > > > >
> > > > >
> > > > > May be, or even check with Renesas team who tested his patch.
> > > >
> > > > I'm not aware of Renesas platforms using SCMI...
> > >
> > > Upon closer look, Diep Pham did report a build issue in the SCMI code, so
> > > perhaps Diep knows more...
> > >
> >
> > Yes indeed, Diep Pham tested the original patch IIRC and also has reported
> > few bugs in SCMI clock code which are fixed. Hence I know it is used by
> > Renesas.
> >
> > Hi Peng,
> >
> > Absence of DTS changes indicate nothing. I am aware of couple of vendors
> > who use SCMI on several platforms and do report issues regularly and help
> > in review of the code. So DTS is not a good indicator of SCMI usage
> > unfortunately. On reason could be that since it is a firmware, bootloaders
> > can detect and update DTS, just my thought and may differ from the reality.
>
> Sorry for the delay.
>
> This patch was indeed requested by Renesas for one of their platform
> that uses SCMI clocks. I didn't have access to the platform myself at
> the time but the patch was positively validated and tested by Renesas.
>
> This works in conjunction with commit 0bfa0820c274 that made generic
> clock pm code usable with the SCMI layer.
>
> I didn't touch any clock stuff since then and I forgot about the finer
> details unfortunately.

Thanks Nico for coming back with this information. To me, it looks
like the patch may be applicable to some Renesas' downstream kernel
then.

In my opinion I think we should rather try to revert, to avoid any
further problems. So I am going to send that patch and see what people
think about it.

Another option, which Sudeep doesn't seem very happy about too, is to
make the GENPD_FLAG_PM_CLK conditional, based on a platform
compatible.

Kind regards
Uffe
