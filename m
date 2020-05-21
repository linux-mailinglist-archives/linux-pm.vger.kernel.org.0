Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB81DD3AB
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgEURC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 21 May 2020 13:02:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50882 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgEURC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 13:02:27 -0400
Received: from 89-64-86-91.dynamic.chello.pl (89.64.86.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 2f872cf926dcd0e8; Thu, 21 May 2020 19:02:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance on error
Date:   Thu, 21 May 2020 19:02:23 +0200
Message-ID: <7515020.pTbQcekcxr@kreacher>
In-Reply-To: <20200520150230.GC30374@kadam>
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn> <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com> <20200520150230.GC30374@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, May 20, 2020 5:02:30 PM CEST Dan Carpenter wrote:
> On Wed, May 20, 2020 at 01:15:44PM +0300, Dmitry Osipenko wrote:
> > 20.05.2020 12:51, Dinghao Liu пишет:
> > > pm_runtime_get_sync() increments the runtime PM usage counter even
> > > it returns an error code. Thus a pairing decrement is needed on
> > > the error handling path to keep the counter balanced.
> > > 
> > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > > ---
> > >  drivers/staging/media/tegra-vde/vde.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
> > > index d3e63512a765..dd134a3a15c7 100644
> > > --- a/drivers/staging/media/tegra-vde/vde.c
> > > +++ b/drivers/staging/media/tegra-vde/vde.c
> > > @@ -777,7 +777,7 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
> > >  
> > >  	ret = pm_runtime_get_sync(dev);
> > >  	if (ret < 0)
> > > -		goto unlock;
> > > +		goto put_runtime_pm;
> > >  
> > >  	/*
> > >  	 * We rely on the VDE registers reset value, otherwise VDE
> > > 
> > 
> > Hello Dinghao,
> > 
> > Thank you for the patch. I sent out a similar patch a week ago [1].
> > 
> > [1]
> > https://patchwork.ozlabs.org/project/linux-tegra/patch/20200514210847.9269-2-digetx@gmail.com/
> > 
> > The pm_runtime_put_noidle() should have the same effect as yours
> > variant, although my variant won't change the last_busy RPM time, which
> > I think is a bit more appropriate behavior.
> 
> I don't think either patch is correct.  The right thing to do is to fix
> __pm_runtime_resume() so it doesn't leak a reference count on error.
> 
> The problem is that a lot of functions don't check the return so
> possibly we are relying on that behavior.

Actually, the function was written with this case in mind.

In retrospect, that has been a mistake and there should be a void variant
to cover this case, but it's been like that for several years and the
documentation doesn't really say that the reference counter will be
decremented on errors.

> We may need to introduce a
> new function which cleans up properly instead of leaking reference
> counts?

Well, even with that, all of the broken callers of pm_runtime_get_sync()
would need to be changed to use the new function instead?

Is that what you mean?



