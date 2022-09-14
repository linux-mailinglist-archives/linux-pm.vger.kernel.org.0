Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CCF5B8DEC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Sep 2022 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiINROr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Sep 2022 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiINROn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2022 13:14:43 -0400
X-Greylist: delayed 299 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Sep 2022 10:14:40 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F2B49D;
        Wed, 14 Sep 2022 10:14:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 323AB1355A1;
        Wed, 14 Sep 2022 13:05:59 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=kBcYIzUMMLzOQ1WkSSqMTb/VLy/5DNe6qKq7qq
        gWNmg=; b=kZpa/qBFBlRZh3evhQjdk3eQHOovp5FfKGExBzolTRnLuQIfvBbBG+
        yuha2YCJpY426PPbQ/3pP0W2OuEwp8yDZZ8M6BHsaduaYadWyOWyOWqsQujQ1jN4
        JHqHZfH1OIGj/ICyCrsbxUowLIUcOy+Su/KAn81K0h9/E52Se1tFk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21EF21355A0;
        Wed, 14 Sep 2022 13:05:59 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=kBcYIzUMMLzOQ1WkSSqMTb/VLy/5DNe6qKq7qqgWNmg=; b=C9FJ8Zqf5dBTlV5mVZyAI7uWKiGoUqxaVjYbJXaZDyMxmYJQR0VQI+etR08Axj1fX08NSNSLb+cJWwaVsfEnV16AF6snv86CrSqxjuG/kHd+1utBC6dqkuZYjXy6jX9moBLQHTAVkhPazdeW6pC35xePN7k48Rl+gyY6Hh/qBig=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E48B13559F;
        Wed, 14 Sep 2022 13:05:58 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 8AAD3422E29;
        Wed, 14 Sep 2022 13:05:57 -0400 (EDT)
Date:   Wed, 14 Sep 2022 13:05:57 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peng Fan <peng.fan@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Dien Pham <dien.pham.ry@renesas.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
In-Reply-To: <20220914153038.inbch35g7ldsyzhx@bogus>
Message-ID: <81pr96n7-p42q-s3s-1541-n777or1p612@syhkavp.arg>
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com> <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com> <20220908173840.rqy335cdeg5a2ww5@bogus> <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus> <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com> <CAMuHMdX2rJq0DJo9D_RSMoAj9GPc-Zts5+UNCFQGF3+EYVSXgQ@mail.gmail.com> <20220914153038.inbch35g7ldsyzhx@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 80C8970C-344F-11ED-BB4D-307A8E0A682E-78420484!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 14 Sep 2022, Sudeep Holla wrote:

> On Mon, Sep 12, 2022 at 06:58:49PM +0100, Geert Uytterhoeven wrote:
> > Hi Sudeep,
> > 
> > CC Dien Pham
> > 
> > On Mon, Sep 12, 2022 at 6:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Sep 9, 2022 at 4:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > > > > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > > > > > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > > > > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > > > > > >
> > > > > > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > > > > > it or is there some platform/driver that is really relying on it?
> > > > > > >
> > > > > >
> > > > > > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > > > > > Not sure if it is still used or not.
> > > > >
> > > > > Okay! Maybe Nico remembers more, as he authored the patch...
> > > > >
> > > >
> > > > May be, or even check with Renesas team who tested his patch.
> > >
> > > I'm not aware of Renesas platforms using SCMI...
> > 
> > Upon closer look, Diep Pham did report a build issue in the SCMI code, so
> > perhaps Diep knows more...
> > 
> 
> Yes indeed, Diep Pham tested the original patch IIRC and also has reported
> few bugs in SCMI clock code which are fixed. Hence I know it is used by
> Renesas.
> 
> Hi Peng,
> 
> Absence of DTS changes indicate nothing. I am aware of couple of vendors
> who use SCMI on several platforms and do report issues regularly and help
> in review of the code. So DTS is not a good indicator of SCMI usage
> unfortunately. On reason could be that since it is a firmware, bootloaders
> can detect and update DTS, just my thought and may differ from the reality.

Sorry for the delay.

This patch was indeed requested by Renesas for one of their platform 
that uses SCMI clocks. I didn't have access to the platform myself at 
the time but the patch was positively validated and tested by Renesas.

This works in conjunction with commit 0bfa0820c274 that made generic 
clock pm code usable with the SCMI layer.

I didn't touch any clock stuff since then and I forgot about the finer 
details unfortunately.


Nicolas
