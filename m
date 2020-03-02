Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F817571F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 10:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgCBJbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 04:31:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49997 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCBJbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 04:31:15 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8hPs-0008Gm-Cd; Mon, 02 Mar 2020 09:31:12 +0000
Date:   Mon, 2 Mar 2020 10:31:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, chenzhou10@huawei.com, rjw@rjwysocki.net,
        pavel@ucw.cz
Subject: Re: [PATCH -next] drivers/base/power: fix build error without SYSFS
Message-ID: <20200302093111.eavix4e65otpudb5@wittgenstein>
References: <20200302092918.40163-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200302092918.40163-1-yaohongbo@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 02, 2020 at 05:29:18PM +0800, Hongbo Yao wrote:
> If CONFIG_SYSFS=n, the following error is seen while building 
> drivers/base/power/sysfs.c:
> 
> drivers/base/power/sysfs.c: In function dpm_sysfs_change_owner:
> drivers/base/power/sysfs.c:708:44: error: passing argument 2 of
> sysfs_group_change_owner from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>   rc = sysfs_group_change_owner(&dev->kobj, &pm_attr_group, kuid, kgid);
>                                             ^
> In file included from ./include/linux/kobject.h:20:0,
>                  from ./include/linux/device.h:17,
>                  from drivers/base/power/sysfs.c:3:
> ./include/linux/sysfs.h:564:19: note: expected const struct
> attribute_group ** but argument is of type const struct attribute_group *
> 
> dpm_sysfs_change_owner() should only used when CONFIG_SYSFS is
> defined.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 3b52fc5d7876 ("drivers/base/power: add dpm_sysfs_change_owner()")
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>

Thanks for catching this!
An organizational comment first. The series this belongs to is sitting
in Dave Miller's net-next tree. So this fix needs to go through his tree
to. This just means, you should Cc the netdev kernel mailing list and
append make the subject
[PATCH net-next] drivers/base/power: fix build error without SYSFS
.

But about the fix. It strikes me as odd that this fails in pm_attr_group
since dpm_sysfs_add() doesn't but also unconditionally accesses pm_attr_group.

Christian
