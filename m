Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F085166746
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 20:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgBTTim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 14:38:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54705 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgBTTil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 14:38:41 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j4reg-0005Xc-Ak; Thu, 20 Feb 2020 19:38:38 +0000
Date:   Thu, 20 Feb 2020 20:38:37 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/9] sysfs: add sysfs_group{s}_change_owner()
Message-ID: <20200220193837.3agsi2idqirzpkiu@wittgenstein>
References: <20200218162943.2488012-1-christian.brauner@ubuntu.com>
 <20200218162943.2488012-4-christian.brauner@ubuntu.com>
 <20200220111550.GE3374196@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220111550.GE3374196@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 12:15:50PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 18, 2020 at 05:29:37PM +0100, Christian Brauner wrote:
> > Add helpers to change the owner of sysfs groups.
> > This function will be used to correctly account for kobject ownership
> > changes, e.g. when moving network devices between network namespaces.
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > -  Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> >    - Add comment how ownership of sysfs object is changed.
> > 
> > /* v3 */
> > -  Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> >    - Add explicit uid/gid parameters.
> > - Christian Brauner <christian.brauner@ubuntu.com>:
> >   - Collapse groups ownership helper patches into a single patch.
> > ---
> >  fs/sysfs/group.c      | 117 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/sysfs.h |  20 ++++++++
> >  2 files changed, 137 insertions(+)
> > 
> > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > index c4ab045926b7..bae562d3cba1 100644
> > --- a/fs/sysfs/group.c
> > +++ b/fs/sysfs/group.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dcache.h>
> >  #include <linux/namei.h>
> >  #include <linux/err.h>
> > +#include <linux/fs.h>
> >  #include "sysfs.h"
> >  
> >  
> > @@ -457,3 +458,119 @@ int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
> >  	return PTR_ERR_OR_ZERO(link);
> >  }
> >  EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
> > +
> > +static int sysfs_group_attrs_change_owner(struct kernfs_node *grp_kn,
> > +					  const struct attribute_group *grp,
> > +					  struct iattr *newattrs)
> > +{
> > +	struct kernfs_node *kn;
> > +	int error;
> > +
> > +	if (grp->attrs) {
> > +		struct attribute *const *attr;
> > +
> > +		for (attr = grp->attrs; *attr; attr++) {
> > +			kn = kernfs_find_and_get(grp_kn, (*attr)->name);
> > +			if (!kn)
> > +				return -ENOENT;
> > +
> > +			error = kernfs_setattr(kn, newattrs);
> > +			kernfs_put(kn);
> > +			if (error)
> > +				return error;
> > +		}
> > +	}
> > +
> > +	if (grp->bin_attrs) {
> > +		struct bin_attribute *const *bin_attr;
> > +
> > +		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
> > +			kn = kernfs_find_and_get(grp_kn, (*bin_attr)->attr.name);
> > +			if (!kn)
> > +				return -ENOENT;
> > +
> > +			error = kernfs_setattr(kn, newattrs);
> > +			kernfs_put(kn);
> > +			if (error)
> > +				return error;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * sysfs_group_change_owner - change owner of an attribute group.
> > + * @kobj:	The kobject containing the group.
> > + * @grp:	The attribute group.
> > + * @kuid:	new owner's kuid
> > + * @kgid:	new owner's kgid
> > + *
> > + * Returns 0 on success or error code on failure.
> 
> This is fine to document, just funny it's the only one documented about
> the return value so far in this series.

I stuck to the documentation style common to the file. Most of the
functions in fs/syfs/file.c did not mention return codes
sysfs_remove_bin_file(), sysfs_create_bin_file(),
sysfs_remove_file_from_group() etc. But I'll document all in this series
with return codes now.

Thanks!
Christian
