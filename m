Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3533064E1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 21:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhA0UP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 15:15:57 -0500
Received: from cmta20.telus.net ([209.171.16.93]:41353 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbhA0UP4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 15:15:56 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 4rDblqUdWAW584rDclWDV1; Wed, 27 Jan 2021 13:15:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1611778514; bh=vJLUO4WSoikN0H8RRFdELxpBwFthADyS4c2d+MVtH8w=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=0G7WWZ3K5URV4LE3QgwDE35lAZi5rM2qxsmc7ttF+uChEFVBop89JF5xyNA/VPWXD
         MZynKu7aHfH9iyzNUqxDC9SrmaDCTyfzi3w7CHCC2Js3V9RY8phzyzFoGsMxAMp+gK
         w5J+csiPb0SfZcsBUmOxLEw2qapK9+wtETmojKzXj1BRcan6/dYKvxy6jHkV5pzULB
         VlmFlV0MBL/GRhU7uwYfG2BSCTThnAOv3BVjGbHIJj+CyoZBO+5Ry5cfsCbPUmOUpH
         9VWw0VjMrIiaMr0bH65NJBJdpPxSgdBzsdw0VYIbDn0erhu0e6U47cXvYJCw18SZrG
         ilOCHIewUe9zQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=I9qg+Psg c=1 sm=1 tr=0 ts=6011c9d2
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8
 a=gu6fZOg2AAAA:8 a=danhDmx_AAAA:8 a=bDUaqqT8Zo0RXodL1CwA:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=P4VdviVPEcjfz_PVVggX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Borislav Petkov'" <bp@suse.de>,
        "'Artem Bityutskiy'" <dedekind1@gmail.com>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Len Brown'" <lenb@kernel.org>,
        "'Linux PM Mailing List'" <linux-pm@vger.kernel.org>
References: <20210127132444.981120-1-dedekind1@gmail.com> <20210127185957.GD8115@zn.tnic>
In-Reply-To: <20210127185957.GD8115@zn.tnic>
Subject: RE: [PATCH] tools/power/turbostat: fix compatibility with older kernels
Date:   Wed, 27 Jan 2021 12:15:10 -0800
Message-ID: <002201d6f4e9$1e9f6c10$5bde4430$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: Adb03uGqvr2xxxpTS2u0QwjkIOWzCQAB41YA
X-CMAE-Envelope: MS4xfEUVWZ+o8s15GmO6kryft2cfUWeBxm7Zz/bXll74+t5YSDT4ItghU2GRDSZbATrqmDs4akgO35qN0P6pAwP+Yg4Q/R+uYdD1PbxZmANECs/moxgzLJu1
 u1SlEQ8LBcscd8wqmEnYwTtgNReZTrvoR01YO3GEckVH6s/FqYLp8RWziMIEp1GfvIXFiFbGkD0nbr9Ir0U5gnJ7mA3NW4uUwEJpCDb7W/lZya5lo3FtXXUi
 3rse0VODo1KgKp72ltS5UfPiwHlYf9RIstMKBO+jFJH91oxsrdM4VjTE4etaBskN
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021.01.27 Borislav Petkov wrote:
> On Wed, Jan 27, 2021 at 03:24:44PM +0200, Artem Bityutskiy wrote:
> > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >
> > Commit
> >
> > 6d6501d912a9 tools/power/turbostat: Read energy_perf_bias from sysfs
> >
> > added a useful EPB print by reading EPB from sysfs's 'energy_perf_bias' file.
> > However, older kernels, which do not necessarily have that sysfs file (e.g.,
> > Centos 7's stock kernel does not have it). As a result, turbostat fails with
> > older kernels.
> >
> > This patch fixes the problem by ignoring the sysfs file read errors.
> >
> > Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > index 389ea5209a83..12e014f2c24b 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -1839,7 +1839,9 @@ int get_epb(int cpu)
> >
> >  	sprintf(path, "/sys/devices/system/cpu/cpu%d/power/energy_perf_bias", cpu);
> >
> > -	fp = fopen_or_die(path, "r");
> > +	fp = fopen(path, "r");
> > +	if (!fp)
> > +		return -1;
> >
> >  	ret = fscanf(fp, "%d", &epb);
> >  	if (ret != 1)
> 
> So I was under the impression that things in tools/ are tied to the
> kernel version they're shipped with. Which means, you should probably
> get the one from the centos kernel.
> 
> However, if this is supposed to work on older kernels too, then

It is supposed to work with old kernels. Here is a quote from Len from [1] (2019.09.05) :

  > The latest turbostat and x86_energy_perf_policy utilities
  > in the upstream kernel tree should always be backward
  > compatible with all old kernels.  If that is EVER not the
  > case, I want to know about it.
  >
  > Yes, I know that some distros ship old versions of these
  > utilities built out of their matching kernel tree snapshots.
  > Yes, applying upstream fixes to .stable for such distros is a good thing.
  >
  > However, the better solution for these particular utilities, is that
  > they simply always use upstream utilities -- even with old kernels.
  >
  > When somebody reports a problem and I need them to run these tools, 
  > 100% of the time, I start by sending them the latest upstream version
  > to replace the old version shipped by the distro.

Which is also what I do. I was also trying, so far without success, to
get a distro to relax its stringent, unnecessary, turbostat dependency
checking [2].

> 
>   6d6501d912a9 ("tools/power/turbostat: Read energy_perf_bias from sysfs")
> 
> would need to be extended to first test the sysfs file's existence and
> if not there, fall back to the MSR reading...

Yes agree, the information is still required.

[1] https://marc.info/?l=linux-pm&m=156770359620861&w=2
[2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1844201


