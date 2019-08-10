Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6C88E80
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfHJVLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 17:11:13 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:47409 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfHJVLN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Aug 2019 17:11:13 -0400
Received: from [192.168.0.6] (ip5f5bd16e.dynamic.kabel-deutschland.de [95.91.209.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A18E6201A3C38;
        Sat, 10 Aug 2019 23:11:10 +0200 (CEST)
Subject: Re: [Linux 5.2.x] /sys/kernel/debug/tracing/events/power/cpu_idle/id:
 BUG: kernel NULL pointer dereference, address: 0000000000000000
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
 <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de>
 <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de>
Message-ID: <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
Date:   Sat, 10 Aug 2019 23:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[+ INTEL IDLE DRIVER]

Dear Linux folks,


On 10.08.19 20:28, Paul Menzel wrote:

> On 10.08.19 19:31, Thomas Gleixner wrote:
> 
>> On Sat, 10 Aug 2019, Paul Menzel wrote:
>>>
>>> I have no idea, who to report this to, so I please refer me to the 
>>> correct
>>> list.
>>
>> I have no idea yet either :)
>>
>>> With Linux 5.2.7 from Debian Sid/unstable and PowerTOP 2.10, executing
>>>
>>>      sudo powertop --auto-tune
>>>
>>> causes a NULL pointer dereference, and the graphical session crashes 
>>> due to an
>>> effect on the i915 driver. It worked in the past with the 4.19 series 
>>> from
>>> Debian.
>>>
>>> Here is the trace, and please find all Linux kernel logs attached.
>>>
>>>> [ 2027.170589] BUG: kernel NULL pointer dereference, address:
>>>> 0000000000000000
>>>> [ 2027.170600] #PF: supervisor instruction fetch in kernel mode
>>>> [ 2027.170604] #PF: error_code(0x0010) - not-present page
>>>> [ 2027.170609] PGD 0 P4D 0 [ 2027.170619] Oops: 0010 [#1] SMP PTI
>> ...
>>>> [ 2027.170730]  do_dentry_open+0x13a/0x370
>>
>> If you have compiled with debug info, please decode the line:
>>
>>    linux/scripts/faddr2line vmlinux do_dentry_open+0x13a/0x370
>>
>> That gives us the fops pointer which is NULL.
> 
> Hah, luckily it’s reproducible.
> 
> ```
> $ scripts/faddr2line /usr/lib/debug/boot/vmlinux-5.2.0-2-amd64 
> do_dentry_open+0x13a/0x370
> do_dentry_open+0x13a/0x370:
> do_dentry_open at fs/open.c:799
> ```
> 
>>>> [ 2027.170745]  path_openat+0x2c6/0x1480
>>>> [ 2027.170757]  ? terminate_walk+0xe6/0x100
>>>> [ 2027.170767]  ? path_lookupat.isra.48+0xa3/0x220
>>>> [ 2027.170779]  ? reuse_swap_page+0x105/0x320
>>>> [ 2027.170791]  do_filp_open+0x93/0x100
>>>> [ 2027.170804]  ? __check_object_size+0x15d/0x189
>>>> [ 2027.170816]  do_sys_open+0x184/0x220
>>>> [ 2027.170828]  do_syscall_64+0x53/0x130
>>>> [ 2027.170837]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> That's an open crashing. We just don't know which file. Is the machine
>> completely hosed after that or is it just the graphics stuff dying?
> 
> No, the graphical login manager showed up, and I could log back in, and 
> continue using hte machine.
> 
>> If it's not completely dead then instead of running it from your 
>> graphical
>> desktop you could switch to a VGA terminal Alt+Ctrl+F1 (or whatever
>> function key your distro maps to) after boot and run powertop with strace
>> from there:
>>
>>    strace -f -o xxx.log powertop
>>
>> With a bit of luck xxx.log should contain the information about the 
>> file it
>> tries to open.
> 
> ```
> 2157  access("/sys/class/drm/card0/power/rc6_residency_ms", R_OK) = 0
> 2157  openat(AT_FDCWD, 
> "/sys/kernel/debug/tracing/events/power/cpu_idle/id", O_RDONLY) = ?
> 2157  +++ killed by SIGKILL +++
> ```
> 
>> Alternatively if you have a serial console you can enable the
>> sys_enter_open* tracepoints:
>>
>> # echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_open
>> # echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_openat
>>
>> Either add 'ftrace_dump_on_oops' to the kernel command line or enable it
>> from the shell:
>>
>> # echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
>>
>> Then run powertop. After the crash it will take some time to spill out 
>> the trace buffer over serial, but it will pinpoint the offending file.
> 
> I do not have serial console on this device.

For the record. It is also reproducible with Linux 5.2.6, and trying to 
print the file contents with cat already fails.

```
$ sudo ls -l /sys/kernel/debug/tracing/events/power/cpu_idle/id
-r--r--r-- 1 root root 0 Aug 10 23:05 
/sys/kernel/debug/tracing/events/power/cpu_idle/id
$ sudo cat /sys/kernel/debug/tracing/events/power/cpu_idle/id
Killed
```


Kind regards,

Paul
