Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB86461D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGJMVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 08:21:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfGJMVY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 08:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 508677573D;
        Wed, 10 Jul 2019 12:21:24 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D57571713F;
        Wed, 10 Jul 2019 12:21:23 +0000 (UTC)
Subject: Re: [PATCH v2] tools/power/x86/intel-speed-select: Add .gitignore
 file
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>
References: <20190708231725.11353-1-prarit@redhat.com>
 <CAHp75VeyUK_ohxPwTg988gXugRh=y5QxT1zhSCmKoG5-CutRnQ@mail.gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <b0d763a8-7f07-db47-3a99-6bb21db3bb0b@redhat.com>
Date:   Wed, 10 Jul 2019 08:21:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VeyUK_ohxPwTg988gXugRh=y5QxT1zhSCmKoG5-CutRnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 10 Jul 2019 12:21:24 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/9/19 12:39 PM, Andy Shevchenko wrote:
> On Tue, Jul 9, 2019 at 2:17 AM Prarit Bhargava <prarit@redhat.com> wrote:
>>
>> Add a .gitignore file for build include/ and final binary.
>>
> 
> It has improper Cc list (No PDx86, no its maintainers, no LKML, which
> is also requirement to send patches to PDx86).
> Please, gather the tags you got and send v2 with properly formed Cc list.
> 

The problem is that get_maintainer.pl is throwing an error when I run it on this
patch so I had to make a guess at the cc list.

ie) Bad divisor in main::vcs_assign: 0

I'll backup a couple of versions of get_maintainer.pl and see if that works.  If
not, should I just copy the cc list from Srinivas' original patchset?

P.

>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: David Arcari <darcari@redhat.com>
>> ---
>>  tools/power/x86/intel-speed-select/.gitignore | 2 ++
>>  1 file changed, 2 insertions(+)
>>  create mode 100644 tools/power/x86/intel-speed-select/.gitignore
>>
>> diff --git a/tools/power/x86/intel-speed-select/.gitignore b/tools/power/x86/intel-speed-select/.gitignore
>> new file mode 100644
>> index 000000000000..f61145925ce9
>> --- /dev/null
>> +++ b/tools/power/x86/intel-speed-select/.gitignore
>> @@ -0,0 +1,2 @@
>> +include/
>> +intel-speed-select
>> --
>> 2.21.0
>>
> 
> 
