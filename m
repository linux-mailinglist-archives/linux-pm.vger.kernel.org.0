Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B407D35766C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 22:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhDGU76 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 16:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbhDGU76 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Apr 2021 16:59:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B933461157;
        Wed,  7 Apr 2021 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617829188;
        bh=sNiMUrpcF7JCIFONZnfz0/BK1ymmENjoizIXIsUdAy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3lIlDBcoNuzA9mn2/q7yoSwhj/VqmvbRRMkPOw91ZpYqdgYkFmOOAbeMEYNuyf9a
         mkx0l3la3/1KDC+FjIxHPlVxnN1mPvGibzc3DpQMe4kTAMu38oR1kp0HJBIBs5oETi
         Z7N/6ezFOwgtchPnLLyx1LAK4Uk8GPZbUFtuGSKszT0f5UD9tRqjE3gvVjE/ZS9em/
         zPRyJUqaki9uwH5NMbUsbciqfC1BtmkueRIYq6Se9C/meEI9zCcBrshXTM9BK0w+Ks
         XwdhPYok2WtwQdmE9SEJlwmRQfU56Hle3EQyIpQ/x59lLP3PHVFu4nSsYp66a9drQ5
         y+KjBL4N3XYvQ==
Date:   Wed, 7 Apr 2021 13:59:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YG4dQlLrsAAUL3eq@quark.localdomain>
References: <20210407100421.27542-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407100421.27542-1-crecklin@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 07, 2021 at 06:04:21AM -0400, Chris von Recklinghausen wrote:
> Suspend fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
> 
> Prior to this patch, MD5 is used only to create a digest to ensure integrity of
> the region, no actual encryption is done. This patch set changes the integrity
> check to use crc32 instead of md5 since crc32 is available in both FIPS and
> non-FIPS modes.
> 
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>        by md5 digest")
> 
> Tested-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>

Please include an explanation about whether this use case requires cryptographic
security or not.

- Eric
