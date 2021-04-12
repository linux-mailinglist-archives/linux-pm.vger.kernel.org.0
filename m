Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123A835D263
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 23:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbhDLVLa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 17:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240417AbhDLVLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 17:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618261870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1rjmwGZCfV3Wdujd1F9jgDadUdVKVMwRumv0bVuOOo=;
        b=Ozb4k+5xDg97LKKn35/YTk7O24TmvXAWMVEki07CbGpNY7iyXa4Fk1Mcm6v1/Fj+KpaRA/
        wjaEne8uRavRdDFFeV15YZj/WJKIunsQHAFRAuXDl398Nnv/NbSwLlCEdOXioVbwhJmyT2
        daoN6P03M1DWccWltEuT1W+D6r5HyPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-tz4JTTSgN-SIKfWKa6REUQ-1; Mon, 12 Apr 2021 17:11:09 -0400
X-MC-Unique: tz4JTTSgN-SIKfWKa6REUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B812801814;
        Mon, 12 Apr 2021 21:11:07 +0000 (UTC)
Received: from ovpn-114-108.phx2.redhat.com (ovpn-114-108.phx2.redhat.com [10.3.114.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0F955C1BB;
        Mon, 12 Apr 2021 21:11:06 +0000 (UTC)
Message-ID: <31b88b39772636f8faee6949562c76c82f615bdb.camel@redhat.com>
Subject: Re: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
From:   Simo Sorce <simo@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Apr 2021 17:11:05 -0400
In-Reply-To: <CAMj1kXHKcJ2rSsiuk3wdr+E0EXAeJeOtGvmSEE96wf5tFOC3BQ@mail.gmail.com>
References: <20210412140932.31162-1-crecklin@redhat.com>
         <YHSHPIXLhHjOu0jw@gmail.com>
         <5795c815-7715-1ecb-dd83-65f3d18b9092@redhat.com>
         <YHSdgV6LIqSVxk+i@gmail.com>
         <CAMj1kXGZt8+5MVG-mNi67KsG8=4HCqEPs+RkrtzHusmCPFqSTg@mail.gmail.com>
         <862c8208-5809-9726-7e22-7a16fcd30edd@redhat.com>
         <CAMj1kXHKcJ2rSsiuk3wdr+E0EXAeJeOtGvmSEE96wf5tFOC3BQ@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-04-12 at 22:29 +0200, Ard Biesheuvel wrote:
> On Mon, 12 Apr 2021 at 21:51, Chris von Recklinghausen
> <crecklin@redhat.com> wrote:
> > On 4/12/21 3:27 PM, Ard Biesheuvel wrote:
> > > On Mon, 12 Apr 2021 at 21:20, Eric Biggers <ebiggers@kernel.org> wrote:
> > > > On Mon, Apr 12, 2021 at 03:04:58PM -0400, Chris von Recklinghausen wrote:
> > > > > On 4/12/21 1:45 PM, Eric Biggers wrote:
> > > > > > On Mon, Apr 12, 2021 at 10:09:32AM -0400, Chris von Recklinghausen wrote:
> > > > > > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > > > > > integrity check and is not available. Use crc32 instead.
> > > > > > > 
> > > > > > > This patch changes the integrity check algorithm from md5 to crc32.
> > > > > > > 
> > > > > > > The purpose of the integrity check is to detect possible differences
> > > > > > > between the memory map used at the time when the hibernation image is
> > > > > > > about to be loaded into memory and the memory map used at the image
> > > > > > > creation time, because it is generally unsafe to load the image if the
> > > > > > > current memory map doesn't match the one used when it was created. so
> > > > > > > it is not intended as a cryptographic integrity check.
> > > > > > This still doesn't actually explain why a non-cryptographic checksum is
> > > > > > sufficient.  "Detection of possible differences" could very well require
> > > > > > cryptographic authentication; it depends on whether malicious changes need to be
> > > > > > detected or not.
> > > > > Hi Eric,
> > > > > 
> > > > > The cases that the commit comments for 62a03defeabd mention are the same as
> > > > > for this patch, e.g.
> > > > > 
> > > > >      1. Without this patch applied, it is possible that BIOS has
> > > > >         provided an inconsistent memory map, but the resume kernel is still
> > > > >         able to restore the image anyway(e.g, E820_RAM region is the superset
> > > > >         of the previous one), although the system might be unstable. So this
> > > > >         patch tries to treat any inconsistent e820 as illegal.
> > > > > 
> > > > >      2. Another case is, this patch replies on comparing the e820_saved, but
> > > > >         currently the e820_save might not be strictly the same across
> > > > >         hibernation, even if BIOS has provided consistent e820 map - In
> > > > >         theory mptable might modify the BIOS-provided e820_saved dynamically
> > > > >         in early_reserve_e820_mpc_new, which would allocate a buffer from
> > > > >         E820_RAM, and marks it from E820_RAM to E820_RESERVED).
> > > > >         This is a potential and rare case we need to deal with in OS in
> > > > >         the future.
> > > > > 
> > > > > Maybe they should be added to the comments with this patch as well? In any
> > > > > case, the above comments only mention detecting consequences of BIOS
> > > > > issues/actions on the e820 map and not intrusions from attackers requiring
> > > > > cryptographic protection. Does that seem to be a reasonable explanation to
> > > > > you? If so I can add these to the commit comments.
> > > > > 
> > > > > I'll make the other changes you suggest below.
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > Those details are still missing the high-level point.  Is this just meant to
> > > > detect non-malicious changes (presumably caused by BIOS bugs), or is it meant to
> > > > detect malicious changes?  That's all that really needs to be mentioned.
> > > > 
> > > This is not about BIOS bugs. Hibernation is deep suspend/resume
> > > grafted onto cold boot, and it is perfectly legal for the firmware to
> > > present a different memory map to the OS after a cold boot. It is
> > > Linux that decides that it can restore the entire system state from a
> > > swap file, and carry on as if the cold boot was just a [firmware
> > > assisted] suspend/resume.
> > > 
> > > So forging collisions is *not* a concern here. Let's avoid accidental
> > > or malicious, as those adjectives seem to confuse some people. The
> > > bottom line is that there is no need to protect against deliberate
> > > attempts to hide the fact that the memory map has changed, and so
> > > there is no reason to use cryptographic hashes here.
> > > 
> > How about :
> > 
> > The check is intended to differentiate between a resume (which expects
> > an identical e820 map to the one saved in suspend), and a cold boot
> > (which need not have an identical e820 map to that saved in suspend if
> > any was done at all). It is not necessary here to protect against
> > deliberate attempts to hide the fact that the memory map has changed, so
> > crc32 is sufficient for detection.
> > 
> 
> Almost. Hibernation always occurs after a cold boot, but usually, the
> E820 memory map happens to be the same.
> 
> How about
> 
> """
> The check is intended to detect whether the E820 memory map provided
> by the firmware after cold boot unexpectedly differs from the one that
> was in use when the hibernation image was created. In this case, the
> hibernation image cannot be restored, as it may cover memory regions
> that are no longer available to the OS.
> 
> A non-cryptographic hash such as CRC-32 is sufficient to detect such
> inadvertent deviations.
> """

hash -> checksum

Simo.


-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




