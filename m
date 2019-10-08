Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD67CFD90
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfJHP0t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 11:26:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHP0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 11:26:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so19843072wrm.12
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2019 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2oIehGoOMVCceq4ryG/0Q4N7vU0pUYa7bMlMOgxii4=;
        b=GWEjCSDj8XMob/ZTZqi3m004svLDmGi8+jtceuXNDkMOg2teXgVLfb/Mzsrw9EK49F
         zHu3I9w7bqAZPIgw+1sy0Yuto3Le2BzSZhfPRtFlqKW/8Xtsk0ZIf23Yyo+jxEUlH5bY
         IfV3pkkDct++s6IOuVoRcfSZjtbG0ZaljMxR4jJYZmQSofN14H219IomARDYTQu/3RpM
         qdUsW9yZQ53MicCg7QT9mSiZ3COLx6q+HAz1paefVyxkhmWA2qxLlOxLWnzLSTeLTZHr
         U+swRh+SKfXj8vRnKG23pmDJHFzTrdRWLEl6L8IykeJmOu0tAntnARwBIm2sadw0qzpD
         FCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2oIehGoOMVCceq4ryG/0Q4N7vU0pUYa7bMlMOgxii4=;
        b=TyClnraCbVmOXMAlhgmwBbE1tUKOw5/VuCnK1lkh8e/8Vx/MdSLvJQ7SaBRRKHxyfO
         79rKSSPaBkyw9a+K8Jfgb0cA0OnhLcNnlVLGhXiorgu0UZ73p+SmRiV5Rl0jn/pOZZSU
         ONTOmhGsC3QCcZdgN5UbROA8EsTkPH6nLcsmFCUUeeZmMfOhyZiPJejptBtD69dqCdqd
         9X72UeX7pE4FWOVRfWnoZfVaJmE1Qsl+U5+dAq106rNxKhUtRbJ794qsi2fO9cquR2NK
         bSSnwBof9hwUz7YOxv45EOP1HCQXoNEhjTexYXhwdhaHlUi7XwmzhE3G9EjDt9aRnrTE
         lOyQ==
X-Gm-Message-State: APjAAAXolD1V9+WRQpgaDgqH/eVcPxfXrnIVnLIvZBEm7vT8iK1Zmw+E
        yIxNxQuZG14cbseS7qA4nmSUb+EV8SfSxBmAnr+6p9kWqAk=
X-Google-Smtp-Source: APXvYqwtq3DpzKGtSTLI1nWQJTAa6oyJxH+FwoM21U/hTFWHGY4k1BlsSrMieCwYB8Y4HaM95gIJbcdC/YJC0XbKbJs=
X-Received: by 2002:adf:db04:: with SMTP id s4mr3716759wri.80.1570548405344;
 Tue, 08 Oct 2019 08:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
 <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com>
In-Reply-To: <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Tue, 8 Oct 2019 08:26:33 -0700
Message-ID: <CAA25o9TpBm+LNwVccTaUng4vQ1Q9_Wz2QftGho7DG_+26CCYoA@mail.gmail.com>
Subject: Re: hibernation memory usage
To:     James Morse <james.morse@arm.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Bas Nowaira <bassem@google.com>, Geoff Pike <gpike@google.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you for your reply!

I understand the need for saving all state, not just process/task
state.  But for many of the systems that could benefit from
hibernation, the majority of RAM is taken by user processes (I am
thinking laptops).  It should be possible to copy their anonymous
pages to disk more or less directly, without making an extra copy like
it's done for all other pages.  I am not sure what happens with kernel
tasks, but they don't have anonymous pages (that I know).

I am curious to know how/if hibernation is currently used in practice.
It doesn't seem practical to require that user processes take less
than 50% of RAM at all times.  There may be special cases in which the
restriction can be achieved by terminating non-essential processes
before hibernating, but I don't know of any.

I would also like to know how much work it might take to avoid the
extra copy of the anonymous pages of frozen processes.

Thanks!

On Tue, Oct 8, 2019 at 3:33 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Luigi,
>
> (CC: +linux-pm mailing list)
>
> On 03/10/2019 18:16, Luigi Semenzato wrote:
> > I am working on a project that uses hibernation, and we've noticed occasional failures
> > with "echo disk > /sys/power/state" returning ENOMEM.  I added some logging and noticed
> > that the failures seem to correlate with total anonymous pages being approximately 1/2 of
> > total RAM.  The allocation strategy isn't explicitly documented and the code is a bit
> > tricky (as usual), but I am getting the sense that a copy of the entire RAM in use is made
> > prior to saving it to disk.  Is it the case then that hibernation is guaranteed to fail if
> > anon memory is more than 50% of RAM?
>
> I'm pretty sure it is. If 50% of memory needs saving, you can't create a snapshot of it.
>
>
> > Since tasks are frozen, that memory cannot change> and the copy seems redundant (except it probably makes things simpler).
>
> Tasks aren't the only thing changing memory. Hibernate save/restores the entire system,
> including the kernel data and text. (what happens if a task is waiting for a syscall to
> complete?)
>
>
> Hibernate needs a snapshot of memory, and the disk drivers, block layer etc need to write
> to memory (and allocate it) in order to get their work done.
>
> To work with this, hibernate's create_image() stops secondary CPUs and suspends all
> devices. Now that only hibernate is running, it calls swsusp_arch_suspend() which then
> call swsusp_save(). This creates the snapshot of memory.
>
> Once this is done, devices are thawed, and hibernate() goes on to call swusp_write() to
> write the snapshot to disk. Finally, processes are thawed.
>
> (create_image() is called by hibernation_snapshot() from hibernate()).
>
>
> If you don't need to save/restore the kernel state, you might not need hibernate at all.
>
>
> Thanks,
>
> James
