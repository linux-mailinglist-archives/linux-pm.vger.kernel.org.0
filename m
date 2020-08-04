Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3023B606
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 09:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHDHtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 03:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgHDHtd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 03:49:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C37722B40;
        Tue,  4 Aug 2020 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596527372;
        bh=8p+XCJZnz+9HnH0A9r61I2MYnTcinVNhhgF+AKtpNpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEL7Ges95rD4FR5z0wQEU5DzHET9Wk0ntPfdgYF1QGb6pg+pTc/cxEXsOesX9z9b0
         Kvl1wyaVyXgowih1ziv7uWRTg7o7qYi3oDRRYwhWiR52hhIchpByEHyMFIRYlrgbte
         0PmNiV4WD6VTWfLuKlTns/SzYSokjI1e9OeNMeMw=
Date:   Tue, 4 Aug 2020 09:49:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ivan <yanziily@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@denx.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200804074913.GC1761483@kroah.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
 <20200802120015.GA1289@bug>
 <20200802123742.GA257810@kroah.com>
 <20200802142825.GA20261@amd>
 <20200802165738.GA293244@kroah.com>
 <20200803114950.oyb3gzyiccybah3u@earth.universe>
 <20200803115644.GC955269@kroah.com>
 <CAPtXDt1hMrgJ_9Zs6Zmkzf4b1-QfEcZPp7dKG26G6ZEqBxCgBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPtXDt1hMrgJ_9Zs6Zmkzf4b1-QfEcZPp7dKG26G6ZEqBxCgBw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 10:11:19AM +0800, ivan wrote:
> On Mon, Aug 3, 2020 at 7:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 03, 2020 at 01:49:50PM +0200, Sebastian Reichel wrote:
> > > More importantely I prefer not to merge new APIs without any users
> > > (i.e. a driver making use of those values). Having a reference
> > > driver means, that there is an example how to use the values
> > > correctly and proves it is actually needed upstream. Right now
> > > this looks like "let's modify the upstream kernel, so that we can
> > > easily maintain our out of tree driver".
> >
> > Agreed.  Qiwu, can you also submit your driver so we can see these
> > values be used?
> 
> Our driver is based on qualcomm's driver secondary development.
> 
> The driver code is for mi 10.
> 
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/qpnp-smb5.c#L1434
> 
> + case POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE:
> +     val->intval = smblib_get_quick_charge_type(chg);
> +     break;
> 
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/smb5-lib.c#L7713

<snip>

Great, can you submit these drivers as patches as part of this series?
That's the best way for all of this to be integrated.

thanks,

greg k-h
