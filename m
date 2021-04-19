Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C91364D93
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 00:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhDSWRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 18:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhDSWRX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Apr 2021 18:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A6CD61077;
        Mon, 19 Apr 2021 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618870612;
        bh=qRooJuDbQ+D+m6HobSIVP6DCMoUZC3we2TUQA6ENpSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMgB1sFI1Tn3I4bsx2aEhICJD1WjRUQ4jdAvLBctLLJ1J2HBvzBw0hwpdVHLPhFZq
         DC84xZTg6CW642MyIMsYNTDztNu7FioZ+4p0edAT5UUmuw6kiBkgy74C9vXIiQITux
         8mNqrbI30uSpiTh6wwdiyI2+fFjPaUDVnlYHCUymz4hO6HXnA9jsLcFqdxqR78uHAh
         1bVWDt/ZXk8HHcry7MrAqLRWqjetuifKXcEZdi8+nJPzWJDAWEcYbdJ9pzOLuyFyj5
         gzpyNKM0Oi2UZrnY0wamBYhEX61a99zxd46FdGagye58eyZdPhDaNP/V/lLsInbmFP
         pXryfAo5s3GBA==
Date:   Mon, 19 Apr 2021 15:16:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 v9] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YH4BUx4Jkx8NtXtw@gmail.com>
References: <20210416131655.22112-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416131655.22112-1-crecklin@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 16, 2021 at 09:16:55AM -0400, Chris von Recklinghausen wrote:
> Hibernation fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.

Doesn't the commit title need to be prefixed with something like "x86/power"?

> The check is intended to detect whether the E820 memory map provided
> by the firmware after cold boot unexpectedly differs from the one that
> was in use when the hibernation image was created. In this case, the
> hibernation image cannot be restored, as it may cover memory regions
> that are no longer available to the OS.
> 
> A non-cryptographic checksum such as CRC-32 is sufficient to detect such
> inadvertent deviations.
> 
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>        by md5 digest")

The "Fixes" line shouldn't be line-wrapped.

Otherwise this looks fine.  The explanation in the commit message still isn't
great, but it's much better than it was before.

You can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
