Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924E235D0EA
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhDLTU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 15:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237286AbhDLTU6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Apr 2021 15:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D493961355;
        Mon, 12 Apr 2021 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618255236;
        bh=us+Qc1vT3f53J+ggtKPb/+ymp1HxiNch+u06FxUBXUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0X16zKxKe1LhLzjb8sgtgoVRLivxcOvs85HWh8i3MZXStYMc6bJiG/IEnuSMsBtB
         honZi1B21HE09B6pMjjWxMemocS7T98zi1ELFCMl2i722cft2u5QaHP9OTVp2wGN8K
         +yKw1nFdN6FuyeQi75xUk5qmBfms3Ea7urByzkz6hJLRvp7e2vkO3TpjekzMzAjw6h
         Wlv/eTjgNx/11YByBp15yrd6lyqGFT7dppOn6D0cOSPQznN8HAzndO6H2g7yyP2Ig7
         Cm+tYGAP4mlbDqfrQ9A8m4QT5vpUz6diV5WrKf47BaxLc4QTHwL3DxrtqY2iIA+bJz
         Y5ZSVNVrQuvGQ==
Date:   Mon, 12 Apr 2021 12:20:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YHSdgV6LIqSVxk+i@gmail.com>
References: <20210412140932.31162-1-crecklin@redhat.com>
 <YHSHPIXLhHjOu0jw@gmail.com>
 <5795c815-7715-1ecb-dd83-65f3d18b9092@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5795c815-7715-1ecb-dd83-65f3d18b9092@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 12, 2021 at 03:04:58PM -0400, Chris von Recklinghausen wrote:
> On 4/12/21 1:45 PM, Eric Biggers wrote:
> > On Mon, Apr 12, 2021 at 10:09:32AM -0400, Chris von Recklinghausen wrote:
> > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > integrity check and is not available. Use crc32 instead.
> > > 
> > > This patch changes the integrity check algorithm from md5 to crc32.
> > > 
> > > The purpose of the integrity check is to detect possible differences
> > > between the memory map used at the time when the hibernation image is
> > > about to be loaded into memory and the memory map used at the image
> > > creation time, because it is generally unsafe to load the image if the
> > > current memory map doesn't match the one used when it was created. so
> > > it is not intended as a cryptographic integrity check.
> > This still doesn't actually explain why a non-cryptographic checksum is
> > sufficient.  "Detection of possible differences" could very well require
> > cryptographic authentication; it depends on whether malicious changes need to be
> > detected or not.
> 
> Hi Eric,
> 
> The cases that the commit comments for 62a03defeabd mention are the same as
> for this patch, e.g.
> 
>     1. Without this patch applied, it is possible that BIOS has
>        provided an inconsistent memory map, but the resume kernel is still
>        able to restore the image anyway(e.g, E820_RAM region is the superset
>        of the previous one), although the system might be unstable. So this
>        patch tries to treat any inconsistent e820 as illegal.
> 
>     2. Another case is, this patch replies on comparing the e820_saved, but
>        currently the e820_save might not be strictly the same across
>        hibernation, even if BIOS has provided consistent e820 map - In
>        theory mptable might modify the BIOS-provided e820_saved dynamically
>        in early_reserve_e820_mpc_new, which would allocate a buffer from
>        E820_RAM, and marks it from E820_RAM to E820_RESERVED).
>        This is a potential and rare case we need to deal with in OS in
>        the future.
> 
> Maybe they should be added to the comments with this patch as well? In any
> case, the above comments only mention detecting consequences of BIOS
> issues/actions on the e820 map and not intrusions from attackers requiring
> cryptographic protection. Does that seem to be a reasonable explanation to
> you? If so I can add these to the commit comments.
> 
> I'll make the other changes you suggest below.
> 
> Thanks,
> 

Those details are still missing the high-level point.  Is this just meant to
detect non-malicious changes (presumably caused by BIOS bugs), or is it meant to
detect malicious changes?  That's all that really needs to be mentioned.

- Eric
