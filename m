Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C43345EA1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 13:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCWM4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 08:56:10 -0400
Received: from muru.com ([72.249.23.125]:46038 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231328AbhCWM4G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 08:56:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2E32380E5;
        Tue, 23 Mar 2021 12:57:01 +0000 (UTC)
Date:   Tue, 23 Mar 2021 14:56:02 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-omap@vger.kernel.org
Subject: Re: [PATCHv2 01/38] ARM: dts: motorola-cpcap-mapphone: Prepare for
 dtbs_check parsing
Message-ID: <YFnlYmXt66EKxPAC@atomide.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-2-sebastian.reichel@collabora.com>
 <YFISPyIMCbp6WcAr@atomide.com>
 <20210323125123.b63euv4vi6whahow@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323125123.b63euv4vi6whahow@earth.universe>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [210323 12:52]:
> Hi Tony,
> 
> On Wed, Mar 17, 2021 at 04:29:19PM +0200, Tony Lindgren wrote:
> > * Sebastian Reichel <sebastian.reichel@collabora.com> [210317 13:50]:
> > > '<&gpio1 parameters &gpio2 parameters>' and '<&gpio1 parameters>,
> > > <&gpio2 parameters>' result in the same DTB, but second format has
> > > better source code readability. Also 'dtbs_check' currently uses
> > > this format to determine the amount of items specified, so using
> > > this syntax is needed to successfully verify the devicetree source
> > > against a DT schema format.
> > 
> > Looks good to me:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Please take this patch via your tree. I will take the other ones
> through the power-supply tree.

OK will do.

Thanks,

Tony
