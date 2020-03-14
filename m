Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D8185979
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgCOC5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:57:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65071 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgCOC5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:57:25 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 00af069952524629; Sat, 14 Mar 2020 11:57:23 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, glider@google.com,
        linux-kernel@vger.kernel.org,
        syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com
Subject: Re: [PATCH] PM / hibernate: Remove unnecessary compat ioctl overrides
Date:   Sat, 14 Mar 2020 11:57:23 +0100
Message-ID: <5664624.X3QHRrgMSY@kreacher>
In-Reply-To: <20200308032701.998434-1-ebiggers@kernel.org>
References: <20200308032434.GX15444@sol.localdomain> <20200308032701.998434-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, March 8, 2020 4:27:01 AM CET Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since the SNAPSHOT_GET_IMAGE_SIZE, SNAPSHOT_AVAIL_SWAP_SIZE, and
> SNAPSHOT_ALLOC_SWAP_PAGE ioctls produce an loff_t result, and loff_t is
> always 64-bit even in the compat case, there's no reason to have the
> special compat handling for these ioctls.  Just remove this unneeded
> code so that these ioctls call into snapshot_ioctl() directly, doing
> just the compat_ptr() conversion on the argument.
> 
> (This unnecessary code was also causing a KMSAN false positive.)
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kernel/power/user.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 77438954cc2b..58ed9478787f 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -409,21 +409,7 @@ snapshot_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	switch (cmd) {
>  	case SNAPSHOT_GET_IMAGE_SIZE:
>  	case SNAPSHOT_AVAIL_SWAP_SIZE:
> -	case SNAPSHOT_ALLOC_SWAP_PAGE: {
> -		compat_loff_t __user *uoffset = compat_ptr(arg);
> -		loff_t offset;
> -		mm_segment_t old_fs;
> -		int err;
> -
> -		old_fs = get_fs();
> -		set_fs(KERNEL_DS);
> -		err = snapshot_ioctl(file, cmd, (unsigned long) &offset);
> -		set_fs(old_fs);
> -		if (!err && put_user(offset, uoffset))
> -			err = -EFAULT;
> -		return err;
> -	}
> -
> +	case SNAPSHOT_ALLOC_SWAP_PAGE:
>  	case SNAPSHOT_CREATE_IMAGE:
>  		return snapshot_ioctl(file, cmd,
>  				      (unsigned long) compat_ptr(arg));
> 

Applied as 5.7 material, thanks!




