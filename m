Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9252E5C001F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiIUOmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIUOmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 10:42:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B0DC97511;
        Wed, 21 Sep 2022 07:42:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 927FE13D5;
        Wed, 21 Sep 2022 07:42:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E9D3F73B;
        Wed, 21 Sep 2022 07:42:05 -0700 (PDT)
Date:   Wed, 21 Sep 2022 15:42:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
Message-ID: <20220921144203.asmpurbklwdcprix@bogus>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus>
 <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus>
 <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
 <CAMuHMdX2rJq0DJo9D_RSMoAj9GPc-Zts5+UNCFQGF3+EYVSXgQ@mail.gmail.com>
 <20220914153038.inbch35g7ldsyzhx@bogus>
 <81pr96n7-p42q-s3s-1541-n777or1p612@syhkavp.arg>
 <CAPDyKFoBvX7WmJu0E1p0RuVCEKFFk===ZVnYtbz9o=RZPzHSTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBvX7WmJu0E1p0RuVCEKFFk===ZVnYtbz9o=RZPzHSTA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 19, 2022 at 11:53:18AM +0200, Ulf Hansson wrote:
> On Wed, 14 Sept 2022 at 19:05, Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > On Wed, 14 Sep 2022, Sudeep Holla wrote:
> >
> > > On Mon, Sep 12, 2022 at 06:58:49PM +0100, Geert Uytterhoeven wrote:
> > > > Hi Sudeep,
> > > >
> > > > CC Dien Pham
> > > >
> > > > On Mon, Sep 12, 2022 at 6:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Sep 9, 2022 at 4:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > > > > > > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > > > > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > > > > > > > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > > > > > > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > > > > > > > >
> > > > > > > > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > > > > > > > it or is there some platform/driver that is really relying on it?
> > > > > > > > >
> > > > > > > >
> > > > > > > > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > > > > > > > Not sure if it is still used or not.
> > > > > > >
> > > > > > > Okay! Maybe Nico remembers more, as he authored the patch...
> > > > > > >
> > > > > >
> > > > > > May be, or even check with Renesas team who tested his patch.
> > > > >
> > > > > I'm not aware of Renesas platforms using SCMI...
> > > >
> > > > Upon closer look, Diep Pham did report a build issue in the SCMI code, so
> > > > perhaps Diep knows more...
> > > >
> > >
> > > Yes indeed, Diep Pham tested the original patch IIRC and also has reported
> > > few bugs in SCMI clock code which are fixed. Hence I know it is used by
> > > Renesas.
> > >
> > > Hi Peng,
> > >
> > > Absence of DTS changes indicate nothing. I am aware of couple of vendors
> > > who use SCMI on several platforms and do report issues regularly and help
> > > in review of the code. So DTS is not a good indicator of SCMI usage
> > > unfortunately. On reason could be that since it is a firmware, bootloaders
> > > can detect and update DTS, just my thought and may differ from the reality.
> >
> > Sorry for the delay.
> >
> > This patch was indeed requested by Renesas for one of their platform
> > that uses SCMI clocks. I didn't have access to the platform myself at
> > the time but the patch was positively validated and tested by Renesas.
> >
> > This works in conjunction with commit 0bfa0820c274 that made generic
> > clock pm code usable with the SCMI layer.
> >
> > I didn't touch any clock stuff since then and I forgot about the finer
> > details unfortunately.
> 
> Thanks Nico for coming back with this information. To me, it looks
> like the patch may be applicable to some Renesas' downstream kernel
> then.
>

Though I agree in most of the case, I am not sure in this particular
case as they may not need any downstream kernel changes for SCMI. All
they need is DT nodes.

> In my opinion I think we should rather try to revert, to avoid any
> further problems. So I am going to send that patch and see what people
> think about it.
>

Since I see absolute silence from Renesas, I am happy to revert if no
one has any objections.

> Another option, which Sudeep doesn't seem very happy about too, is to
> make the GENPD_FLAG_PM_CLK conditional, based on a platform
> compatible.

Correct, I would rather make it generic based on clock flags like in this
case it is CLK_SET_PARENT_GATE or CLK_SET_RATE_GATE or something right ?

-- 
Regards,
Sudeep
