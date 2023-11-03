Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1527E0843
	for <lists+linux-pm@lfdr.de>; Fri,  3 Nov 2023 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKCSgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Nov 2023 14:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjKCSgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2023 14:36:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E9D47;
        Fri,  3 Nov 2023 11:36:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D3DC433C9;
        Fri,  3 Nov 2023 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699036589;
        bh=t9OfWxjmRBsqiXsPbyw2EcQvdxCl+LfcMDqz160D6P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU/FOCJ/cTCilDbfiLeOP72tgqUIXdMSVGR+Ke5guOy/o/T/rbXj1FufplOpovd+w
         Itxd0lOZTAw1wvsRc9+8rylrt0HhsOmJY6QfDgh+OjdSGr6t4EBqGkhhDCqM8tmeme
         mDRNr1NzPYZtZ4Sg7B5sdiVLT0UnDsz90WxQ6vXs=
Date:   Fri, 3 Nov 2023 19:36:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers core: lookup sysfs power group before removal
Message-ID: <2023110353-bring-contented-c9f8@gregkh>
References: <20231101173627.2658-1-jose.pekkarinen@foxhound.fi>
 <2023110139-dupe-snipping-5700@gregkh>
 <835b2930c710381b8da38eca821aa92d@foxhound.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <835b2930c710381b8da38eca821aa92d@foxhound.fi>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 03, 2023 at 07:49:39PM +0200, Jos� Pekkarinen wrote:
> On 2023-11-01 19:54, Greg KH wrote:
> > On Wed, Nov 01, 2023 at 07:36:27PM +0200, Jos� Pekkarinen wrote:
> > > Hinted by syzboot, there is a few cases where the sysfs power group
> > > may
> > > not be there, like the failure while adding it, or adding its runtime
> > > group, or when the sysfs firmware loader fallback fail to populate. In
> > > the last case, the device_del function will be called leading to
> > > attempt
> > > to remove the sysfs group. This patch will lookup for it in advance to
> > > grant that it is effectively there before cleaning it up.
> > > 
> > > Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
> > > 
> > > Signed-off-by: Jos� Pekkarinen <jose.pekkarinen@foxhound.fi>
> > > ---
> > >  drivers/base/power/sysfs.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > > index a1474fb67db9..6601729c4698 100644
> > > --- a/drivers/base/power/sysfs.c
> > > +++ b/drivers/base/power/sysfs.c
> > > @@ -834,5 +834,7 @@ void dpm_sysfs_remove(struct device *dev)
> > >  	dev_pm_qos_constraints_destroy(dev);
> > >  	rpm_sysfs_remove(dev);
> > >  	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > -	sysfs_remove_group(&dev->kobj, &pm_attr_group);
> > > +
> > > +	if (kernfs_find_and_get((&dev->kobj)->sd, pm_attr_group.name))
> > > +		sysfs_remove_group(&dev->kobj, &pm_attr_group);
> > 
> > What's to keep it from going away right after finding it?
> > 
> > In other words, what is wrong with removing a group that is not there?
> > What error happens?  It should be fine, or are you seeing real code
> > failures somewhere?
> 
>     No, this is just hitting a warning that sysbot complains about by
> setting panic on warning, no big deal, though it can be a wrong behaviour
> in ueagle-atm driver, since it defines to disconnect the device if the
> firmware is not there, no matter the sysfs fallback.

Then fix the driver please.

And what warning are you seeing exactly?

thanks,

greg k-h
