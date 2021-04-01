Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC5351DF6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhDASd3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238127AbhDASYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 14:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617301461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQXyIlDjf6rlCY52sh5innCwMBc55XbUxEkQlnRDtZw=;
        b=LqBTA3ck4UoYHUbdSHx3d2FqimlYvCbvXs2vqaXO4S67LTE5VveuF9Of8kdLtturp6xl6+
        2yWOcOz4la/orO7odZB2IbXnjkAe2p16R8DXlvIZaMzzTOdHsWngrwKlN85SqIm8+Do+q2
        yjAaFqBh03GWZ1tml6ySaFfOK5wbi2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-lqnJhyOpO6uphHj_SBXqLg-1; Thu, 01 Apr 2021 12:22:21 -0400
X-MC-Unique: lqnJhyOpO6uphHj_SBXqLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0242888127C;
        Thu,  1 Apr 2021 16:22:20 +0000 (UTC)
Received: from ovpn-113-84.phx2.redhat.com (ovpn-113-84.phx2.redhat.com [10.3.113.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 276F6614FC;
        Thu,  1 Apr 2021 16:22:19 +0000 (UTC)
Message-ID: <44e4e4e62bff778d3b0b59235c793ec84794372b.camel@redhat.com>
Subject: Re: Fix hibernation in FIPS mode?
From:   Simo Sorce <simo@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Apr 2021 12:22:18 -0400
In-Reply-To: <CAJZ5v0iPneWK69GTzWigdXjjb6VN6Hyd5=hLCdGasfnTxXCYNg@mail.gmail.com>
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
         <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
         <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
         <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
         <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
         <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
         <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
         <CAMj1kXFrBGTitSNYZC58=UdmfgbbF2MvTcfLVRpkxJ-uYX3piw@mail.gmail.com>
         <CAJZ5v0iPneWK69GTzWigdXjjb6VN6Hyd5=hLCdGasfnTxXCYNg@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-04-01 at 18:02 +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 1, 2021 at 3:54 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 1 Apr 2021 at 15:38, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Apr 1, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
> > > > > On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
> > > > > > On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
> > > > > > > On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> > > > > > > > On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > > > > > > > > Hi,
> > > > > > > > > MD5 was marked incompliant with FIPS in 2009:
> > > > > > > > > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > > > > > > > > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > > > > > > > > 
> > > > > > > > > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > > > > > > > > due to the 2018 patch:
> > > > > > > > > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > > > > > > > > 
> > > > > > > > > As a result, hibernation doesn't work when FIPS is on.
> > > > > > > > > 
> > > > > > > > > Do you think if hibernation_e820_save() should be changed to use a
> > > > > > > > > FIPS-compliant algorithm like SHA-1?
> > > > > > > > 
> > > > > > > > I would say yes, it should.
> > > > > > > > 
> > > > > > > > > PS, currently it looks like FIPS mode is broken in the mainline:
> > > > > > > > > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
> > > > > > > 
> > > > > > > FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> > > > > > > constructions and only for specified uses. If you need to change
> > > > > > > algorithm you should go straight to SHA-2 or SHA-3 based hashes.
> > > > > > > 
> > > > > > 
> > > > > > What is the reason for using a [broken] cryptographic hash here? if
> > > > > > this is just an integrity check, better use CRC32
> > > 
> > > Not really.
> > > 
> > > CRC32 is not really sufficient for integrity checking here AFAICS.  It
> > > might be made a fallback option if MD5 is not available, but making it
> > > the default would be somewhat over the top IMO.
> > > 
> > > > > If the integrity check is used exclusively to verify there were no
> > > > > accidental changes and is not used as a security measure, by all means
> > > > > I agree that using crc32 is a better idea.
> > > > > 
> > > > 
> > > > Looking at 62a03defeabd58f74e07ca030d6c21e069d4d88e which introduced
> > > > this, it is only a best effort check which is simply omitted if md5
> > > > happens to be unavailable, so there is definitely no need for crypto
> > > > here.
> > > 
> > > Yes, it is about integrity checking only.  No, CRC32 is not equivalent
> > > to MD5 in that respect AFAICS.
> > > 
> > 
> > There are two possibilities:
> > - we care about an adversary attempting to forge a collision, in which
> > case you need a cryptographic hash which is not broken;
> > - we only care about integrity, in which case crypto is overkill, and
> > CRC32 is sufficient. (Note that the likelihood of an honest,
> > inadvertent modification not being caught by CRC32 is 1 in 4 billion)
> 
> That depends on how you count.
> 
> Surely, there are modifications caught by MD5 that will not be caught by CRC32.

This is a technically correct statement, but does it matter in this
context? (Hint, probably not)

> > MD5 does not meet either requirement, given that it is known to be
> > broken, and overkill for simple integrity checks. MD5 should be phased
> > out and removed, and moving this code onto the correct abstraction
> > would be a reasonable step towards that goal.
> 
> This clearly is a matter of opinion.

Sorry, but this is not a matter of opinion.
The only reason to use a cryptographic hash is that you want to protect
from active tampering, rather than from accidental changes. And if you
need to protect from active tampering then you cannot use a known
broken hash, there is no point.

OTOH if you do not care for active tampering but only to catch
transmission/storage errors then all you care for is error checking. In
that case a cryptographic hash is overkill because it entails a lot
more computation than is needed.

> I'm not religious about it though.  If there is a general consensus
> that CRC32 is sufficient for error detection in hibernation files,
> then it can be used.  So is there such a consensus and if so, can you
> give me a pointer to some research that it is based on?

CRC32 is an industry standard to check for accidental modifications of
a bit stream. The chances of missing an accidental change are 1 in 4
billion.

Does your application require a higher threshold? If so you should
justify why you think your case is not fulfilled by an industry
standard.

HTH,
Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




