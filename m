Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD936134E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDOUJt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 16:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234889AbhDOUJs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Apr 2021 16:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FB04610E6;
        Thu, 15 Apr 2021 20:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618517365;
        bh=9Hvt7ePox3QgJubOSIX8KQquBcnInyFFZh8g81xTVeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BoK9Cn3cifdfaBtZDAeHnspinFceNTSLN8CS9kWZcK33AkfoFSe/7wiPsmFpLJcD9
         l60x6pAXZ7zjbja4299g8PXTzKGpIVv3ABsCy9EjzP3k3E4VYjP2JkZL1icN8VUzt+
         iAN0bfzEe8HEfG8cUOW/c4C1vA5TW31/kugf96qwGCo3wuzmzeX70Cej3zpd4kdfjs
         cIPJxrBmDYr1CHjHtlsYsQvYmjIL2ePfj8SfuBf5szCSoAUJLzs1TdJZOZsWki6aTz
         4BQiM5o7g9HdYu/pdRsSrcmZEz3JJeRMAMyjeToxZ4NlfCvlgyDdgWmjbeXDi7xc90
         TpFXK+AN1yPRg==
Date:   Thu, 15 Apr 2021 13:09:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YHidc5Xdjo5LK0D5@gmail.com>
References: <20210415194646.13387-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415194646.13387-1-crecklin@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 15, 2021 at 03:46:46PM -0400, Chris von Recklinghausen wrote:
> Hibernation fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
> 
> This patch changes the integrity check algorithm from md5 to crc32.

The second paragraph is redundant with the first.

>  /**
> - * get_e820_md5 - calculate md5 according to given e820 table
> + * compute_e820_crc32 - calculate md5 according to given e820 table
>   *
>   * @table: the e820 table to be calculated
> - * @buf: the md5 result to be stored to
>   */

This comment still mentions MD5.

Also, this isn't a well-formed kerneldoc comment, since it doesn't document the
return value.

Also, this function is calculating the checksum *of* the table, not calculating
a checksum "according to" it (whatever that means).

Something like this would be good, I think:

/**
 * compute_e820_crc32 - compute the CRC-32 of the given e820 table
 *
 * @table: the e820 table to be checksummed
 *
 * Return: the resulting checksum
 */

Also, please try 'git grep -i md5 arch/x86/kernel/'.  There is still another
reference to MD5 that should be updated, in arch/x86/kernel/e820.c.

- Eric
