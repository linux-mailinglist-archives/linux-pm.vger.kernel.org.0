Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DA512ABA4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfLZKho (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 05:37:44 -0500
Received: from vps.xff.cz ([195.181.215.36]:41446 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLZKhn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Dec 2019 05:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1577356660; bh=u9ETC+o/IDmexaGn/AkVQX1tykjZ0Q5WXzCFWQs4IxA=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=hR1Cvt5PDfOSjCTfWyHa0hGTOieD3sPrxsLePg0TlTIASuwGzDl2q8GisgkgvrTND
         Ad042SwFVeTyJpga15dKzjnyL7Qx+AdS3XTEibZ3G/+eZY6Acv3SnomV22XY5ZCo6S
         Yz1kcKqWTVQjg7HfdcsxUxBJorFSPu5KJji2LpCk=
Date:   Thu, 26 Dec 2019 11:37:39 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191226103739.bz3i73gjmn5q5veu@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
 <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org>
 <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 26, 2019 at 10:27:51AM +0100, Maxime Ripard wrote:
> On Tue, Dec 24, 2019 at 07:30:55PM +0100, Daniel Lezcano wrote:
> > On 19/12/2019 18:33, Maxime Ripard wrote:
> > > Hi,
> > >
> > > On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> > >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > >> H6 and R40 SoCs.
> > >
> > > Thanks again for working on this.
> > >
> > > I'll merge the DT patches when the driver will have been merged.
> >
> > I've applied patches 1 & 2.
> >
> > They are in the testing branch and will go to the linux-next branch as
> > soon as the kernelci passes.
> 
> I just merged all the other patches (except the patch 6, for the H6,
> as requested by Vasily on IRC).

Hello,

I think you can apply H6 patch. This was just some misunderstanding
and H6 is working.

thnaks and regards,
	o.

> Thanks to everyone involved!
> Maxime



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

