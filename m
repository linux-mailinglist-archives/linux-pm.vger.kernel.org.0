Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D32442F2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 04:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHNCRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 22:17:13 -0400
Received: from mail1.windriver.com ([147.11.146.13]:65530 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNCRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 22:17:13 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 07E2H8i0010343
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Aug 2020 19:17:09 -0700 (PDT)
Received: from [128.224.162.157] (128.224.162.157) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Thu, 13 Aug 2020
 19:17:08 -0700
Subject: Re: [PATCH] tools/power turbostat: call pread64 in kernel directly
To:     Len Brown <lenb@kernel.org>
CC:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200717060849.12469-1-liwei.song@windriver.com>
 <CAJvTdKm9WHgQuP38Y2o1zQ-VgLKMMDup4crAPrW3pexoWft+6Q@mail.gmail.com>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <52f16995-6d2d-fa7d-ed5e-682db3461d03@windriver.com>
Date:   Fri, 14 Aug 2020 10:17:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJvTdKm9WHgQuP38Y2o1zQ-VgLKMMDup4crAPrW3pexoWft+6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

with multilib lib32 support, the rootfs will be 32-bit, 
the kernel is still 64-bit, in this case run turbostat
will failed with "out of range" error.

Thanks,
Liwei.

On 8/14/20 05:43, Len Brown wrote:
> Huh?
> 
> On Fri, Jul 17, 2020 at 2:09 AM Liwei Song <liwei.song@windriver.com> wrote:
>>
>> with 32-bit rootfs, the offset may out of range when set it
>> to 0xc0010299, define it as "unsigned long long" type and
>> call pread64 directly in kernel.
>>
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>> ---
>>  tools/power/x86/turbostat/turbostat.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index 33b370865d16..4c5cdfcb5721 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -33,6 +33,7 @@
>>  #include <sys/capability.h>
>>  #include <errno.h>
>>  #include <math.h>
>> +#include <sys/syscall.h>
>>
>>  char *proc_stat = "/proc/stat";
>>  FILE *outf;
>> @@ -381,11 +382,11 @@ int get_msr_fd(int cpu)
>>         return fd;
>>  }
>>
>> -int get_msr(int cpu, off_t offset, unsigned long long *msr)
>> +int get_msr(int cpu, unsigned long long offset, unsigned long long *msr)
>>  {
>>         ssize_t retval;
>>
>> -       retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
>> +       retval = syscall(SYS_pread64, get_msr_fd(cpu), msr, sizeof(*msr), offset);
>>
>>         if (retval != sizeof *msr)
>>                 err(-1, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
>> --
>> 2.17.1
>>
> 
> 
