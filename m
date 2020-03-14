Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A277E18596E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCOCyB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:54:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59462 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgCOCyB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:54:01 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a69d199000898155; Sat, 14 Mar 2020 11:53:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] docs: power: fix docs for ioctls that return loff_t via pointer
Date:   Sat, 14 Mar 2020 11:53:58 +0100
Message-ID: <3833355.Hds1XrS48b@kreacher>
In-Reply-To: <20200308032216.998068-1-ebiggers@kernel.org>
References: <20200308032216.998068-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, March 8, 2020 4:22:16 AM CET Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Correctly document how the SNAPSHOT_GET_IMAGE_SIZE and
> SNAPSHOT_AVAIL_SWAP_SIZE ioctls return their result.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/power/userland-swsusp.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
> index a0fa51bb1a4d..1cf62d80a9ca 100644
> --- a/Documentation/power/userland-swsusp.rst
> +++ b/Documentation/power/userland-swsusp.rst
> @@ -69,11 +69,13 @@ SNAPSHOT_PREF_IMAGE_SIZE
>  
>  SNAPSHOT_GET_IMAGE_SIZE
>  	return the actual size of the hibernation image
> +	(the last argument should be a pointer to a loff_t variable that
> +	will contain the result if the call is successful)
>  
>  SNAPSHOT_AVAIL_SWAP_SIZE
> -	return the amount of available swap in bytes (the
> -	last argument should be a pointer to an unsigned int variable that will
> -	contain the result if the call is successful).
> +	return the amount of available swap in bytes
> +	(the last argument should be a pointer to a loff_t variable that
> +	will contain the result if the call is successful)
>  
>  SNAPSHOT_ALLOC_SWAP_PAGE
>  	allocate a swap page from the resume partition
> 

Applied as 5.7 material, thanks!




