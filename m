Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E8CF711
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 12:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfJHKdP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 06:33:15 -0400
Received: from foss.arm.com ([217.140.110.172]:32888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbfJHKdP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Oct 2019 06:33:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8E3815BE;
        Tue,  8 Oct 2019 03:33:14 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10C173F6C4;
        Tue,  8 Oct 2019 03:33:13 -0700 (PDT)
Subject: Re: hibernation memory usage
To:     Luigi Semenzato <semenzato@google.com>
References: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Bas Nowaira <bassem@google.com>, Geoff Pike <gpike@google.com>,
        linux-pm@vger.kernel.org
From:   James Morse <james.morse@arm.com>
Message-ID: <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com>
Date:   Tue, 8 Oct 2019 11:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Luigi,

(CC: +linux-pm mailing list)

On 03/10/2019 18:16, Luigi Semenzato wrote:
> I am working on a project that uses hibernation, and we've noticed occasional failures
> with "echo disk > /sys/power/state" returning ENOMEM.  I added some logging and noticed
> that the failures seem to correlate with total anonymous pages being approximately 1/2 of
> total RAM.  The allocation strategy isn't explicitly documented and the code is a bit
> tricky (as usual), but I am getting the sense that a copy of the entire RAM in use is made
> prior to saving it to disk.  Is it the case then that hibernation is guaranteed to fail if
> anon memory is more than 50% of RAM? 

I'm pretty sure it is. If 50% of memory needs saving, you can't create a snapshot of it.


> Since tasks are frozen, that memory cannot change> and the copy seems redundant (except it probably makes things simpler).

Tasks aren't the only thing changing memory. Hibernate save/restores the entire system,
including the kernel data and text. (what happens if a task is waiting for a syscall to
complete?)


Hibernate needs a snapshot of memory, and the disk drivers, block layer etc need to write
to memory (and allocate it) in order to get their work done.

To work with this, hibernate's create_image() stops secondary CPUs and suspends all
devices. Now that only hibernate is running, it calls swsusp_arch_suspend() which then
call swsusp_save(). This creates the snapshot of memory.

Once this is done, devices are thawed, and hibernate() goes on to call swusp_write() to
write the snapshot to disk. Finally, processes are thawed.

(create_image() is called by hibernation_snapshot() from hibernate()).


If you don't need to save/restore the kernel state, you might not need hibernate at all.


Thanks,

James
