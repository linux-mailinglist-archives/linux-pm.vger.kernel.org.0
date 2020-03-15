Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA1185C28
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 12:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgCOLQf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 07:16:35 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47228 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgCOLQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 07:16:34 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 2A5268050C;
        Sun, 15 Mar 2020 12:16:28 +0100 (CET)
Date:   Sun, 15 Mar 2020 12:16:27 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] power: supply: add CellWise cw2015 fuel gauge
 driver
Message-ID: <20200315111627.GA21240@ravnborg.org>
References: <20200312222448.25097-1-t.schramm@manjaro.org>
 <20200312222448.25097-4-t.schramm@manjaro.org>
 <20200313091124.GP1922688@smile.fi.intel.com>
 <fd75f94b-8e08-97da-a396-6df61c6fd89f@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd75f94b-8e08-97da-a396-6df61c6fd89f@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=z85fDJX7t83lHnj23ngA:9 a=CjuIK1q_8ugA:10
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tobias.

On Sun, Mar 15, 2020 at 12:00:35PM +0100, Tobias Schramm wrote:
> Hi Andy,
> 
> thanks for your feedback. Please find my comments inline.
> 
> > 
> >> +				dev_err(cw_bat->dev,
> >> +					 "Failed to upload battery info\n");
> > 
> > Indentation of the second line.
> > 
> I've seen quite a few different indentation styles used in kernel
> source. Personally I'd indent like this:
> 
> 		dev_warn(cw_bat->dev,
> 			 "some long error message");
> 
> However coding-style.rst specifies that spaces are never to be used for
> indentation. May I assume they are ok for alignment though?

Indent with tabs and align with spaces.

So this becomes

< tab  >< tab  >dev_warn(cw_bat->dev,
< tab  >< tab  ><tab    >_"some long error message");

Where '_' represents a space.

This is the recommend kernel practice.

	Sam
