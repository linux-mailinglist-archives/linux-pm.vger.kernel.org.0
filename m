Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BDF5E5D0F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIVIIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 04:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiIVIIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 04:08:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C1CC8CD
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 01:08:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v3-20020a1cac03000000b003b4fd0fe6c0so779429wme.5
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ARvQNMyOMyOP1V8sDexoGcQ9GOGjiChUnt03h87Fvgk=;
        b=Hf0CLrMXp2MhccozCR/XCe207jTe3dBr8f+rR0qG3UhsjP7z9xGxo+aS6WmCvV6cQf
         cOz7qD5FUuxD1nGdXqflqWWBxIoCH2VV6HgeApIAdRFbW9sUMybzjkZLIxodV7AoHOOm
         u1yzJOCOL+52o6/XKTUfcT6/IerzN2tJtSMg8FTmLf72b1hmPcLa82ZqvnE8Bdv0YTZV
         NqHJ16/rTYijJD2LI0RvBnAp5P/UhL97IjcUSUHn2EK90wjufjicQDXzwwBLhjmD4n8y
         7a3e4QkmVJMbENe89Men6OwH4OVBrV8fIU1L34XSYn2hGHwgJB5o5QlIrfhk5e9OzPAc
         c0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ARvQNMyOMyOP1V8sDexoGcQ9GOGjiChUnt03h87Fvgk=;
        b=TK+oes1A8CyMREfYcjv3cSJG2MGIZ88lHwcNqOVAgOJh89sT9HNxJThY8LzGJbRWWY
         6qoCvpiSZo0HQp1Nlr4tsw9+2EzsJSaZfeId+2G3uK+NtnbSW41Y+TxncKpSkMMD7XSc
         1lXwcyZX3aXB5ji7FxUoXuOWEZqrmqSzBKqBVmeNezb5BdeXzYQqWndKBBuxx3eCYQDv
         km34eWO4unOmVMb8PiofJD6QYzB/TOOp6lcRTNtOJnQb4DMKlUVGmwVTViks++/ok88V
         VpmuEzFoRISRM7q/ClwXgtpE51v4aC1FsmD2CNMVVyhuhwBJYfr8TKe9eaQVFJaXAEEs
         pG2Q==
X-Gm-Message-State: ACrzQf2HNKZ7eVTclQjP7Pj+AOB2oLVx3vkOMGIe2mt7gSSkTgl7Htjt
        /Mj372+DpcLSO2WpZfZx7Yc3Mr/tB2ttqLr2kJSPgg==
X-Google-Smtp-Source: AMsMyM5twWT/kjhQnt6WYWcLNJnKZDXCrJItS/TFkIahsbbx6CwuxMbyGk4eegJn4Df56Pq+baf0cIi1+FadLna8oyw=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr1329955wmq.17.1663834122445; Thu, 22
 Sep 2022 01:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus> <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus> <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
 <CAMuHMdX2rJq0DJo9D_RSMoAj9GPc-Zts5+UNCFQGF3+EYVSXgQ@mail.gmail.com>
 <20220914153038.inbch35g7ldsyzhx@bogus> <81pr96n7-p42q-s3s-1541-n777or1p612@syhkavp.arg>
 <CAPDyKFoBvX7WmJu0E1p0RuVCEKFFk===ZVnYtbz9o=RZPzHSTA@mail.gmail.com> <20220921144203.asmpurbklwdcprix@bogus>
In-Reply-To: <20220921144203.asmpurbklwdcprix@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Sep 2022 10:08:05 +0200
Message-ID: <CAPDyKFq0ryd9PZbLbtLW0hpjbbb8F0rk+33+OdvvPVitbbJvPg@mail.gmail.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Wed, 21 Sept 2022 at 16:42, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Sep 19, 2022 at 11:53:18AM +0200, Ulf Hansson wrote:
> > On Wed, 14 Sept 2022 at 19:05, Nicolas Pitre <nico@fluxnic.net> wrote:
> > >
> > > On Wed, 14 Sep 2022, Sudeep Holla wrote:
> > >
> > > > On Mon, Sep 12, 2022 at 06:58:49PM +0100, Geert Uytterhoeven wrote:
> > > > > Hi Sudeep,
> > > > >
> > > > > CC Dien Pham
> > > > >
> > > > > On Mon, Sep 12, 2022 at 6:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Fri, Sep 9, 2022 at 4:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > > On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > > > > > > > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > > > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > > > > > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > > > > > > > > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > > > > > > > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > > > > > > > > >
> > > > > > > > > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > > > > > > > > it or is there some platform/driver that is really relying on it?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > > > > > > > > Not sure if it is still used or not.
> > > > > > > >
> > > > > > > > Okay! Maybe Nico remembers more, as he authored the patch...
> > > > > > > >
> > > > > > >
> > > > > > > May be, or even check with Renesas team who tested his patch.
> > > > > >
> > > > > > I'm not aware of Renesas platforms using SCMI...
> > > > >
> > > > > Upon closer look, Diep Pham did report a build issue in the SCMI code, so
> > > > > perhaps Diep knows more...
> > > > >
> > > >
> > > > Yes indeed, Diep Pham tested the original patch IIRC and also has reported
> > > > few bugs in SCMI clock code which are fixed. Hence I know it is used by
> > > > Renesas.
> > > >
> > > > Hi Peng,
> > > >
> > > > Absence of DTS changes indicate nothing. I am aware of couple of vendors
> > > > who use SCMI on several platforms and do report issues regularly and help
> > > > in review of the code. So DTS is not a good indicator of SCMI usage
> > > > unfortunately. On reason could be that since it is a firmware, bootloaders
> > > > can detect and update DTS, just my thought and may differ from the reality.
> > >
> > > Sorry for the delay.
> > >
> > > This patch was indeed requested by Renesas for one of their platform
> > > that uses SCMI clocks. I didn't have access to the platform myself at
> > > the time but the patch was positively validated and tested by Renesas.
> > >
> > > This works in conjunction with commit 0bfa0820c274 that made generic
> > > clock pm code usable with the SCMI layer.
> > >
> > > I didn't touch any clock stuff since then and I forgot about the finer
> > > details unfortunately.
> >
> > Thanks Nico for coming back with this information. To me, it looks
> > like the patch may be applicable to some Renesas' downstream kernel
> > then.
> >
>
> Though I agree in most of the case, I am not sure in this particular
> case as they may not need any downstream kernel changes for SCMI. All
> they need is DT nodes.

Right, good point!

>
> > In my opinion I think we should rather try to revert, to avoid any
> > further problems. So I am going to send that patch and see what people
> > think about it.
> >
>
> Since I see absolute silence from Renesas, I am happy to revert if no
> one has any objections.

Okay, good!

>
> > Another option, which Sudeep doesn't seem very happy about too, is to
> > make the GENPD_FLAG_PM_CLK conditional, based on a platform
> > compatible.
>
> Correct, I would rather make it generic based on clock flags like in this
> case it is CLK_SET_PARENT_GATE or CLK_SET_RATE_GATE or something right ?

That needs some more thinking, but potentially it could work - at
least for this particular case with clk_set_rate().

Although, as it's likely that the subsystem/driver is already handling
the clock(s), the whole thing with using GENPD_FLAG_PM_CLK is in most
cases superfluous. That means we end up running unnecessary code-paths
during runtime suspend/resume (to ungate/gate clock(s) twice) - and
that involves acquiring/releasing locks too, when that isn't really
needed.

Kind regards
Uffe
