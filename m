Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32298D718
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfHNPTt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 11:19:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36847 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNPTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 11:19:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so2945689pfi.3;
        Wed, 14 Aug 2019 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Km2pgpRIn1Rtk7yawTCCHjLc0RoQZXV3wZQhocfSUP0=;
        b=dgpu3lscVd/jWu9JCSsgEAghAmVKlj8K8eUZRyng90q9x0VLKK16ERvQYoe9ivvhh9
         A/7Vj64tFIIZaSKntT3Fe4nXIBT+X6zDn8VSamzz24bb+npc5NSZLz9REXS2vtTgy89G
         qhraCFu4Yo34LQ08HvYJP3UvXvBkIBcgect/7gHAvO4DsNo9iC7mqQRIUAniFN9s4w0s
         lDY0+9wdj/uw54YLEVma42KAINP1zSOyMedtLLEzppI+H9DrKPO+91uSi1oDv2vRALTX
         xs84o5qelR6z+tXPx3wdqF+f2fJROfBMAjtjoJ616ab7ZReY7WPlh/Qzm6iA8jICTYlA
         fJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Km2pgpRIn1Rtk7yawTCCHjLc0RoQZXV3wZQhocfSUP0=;
        b=WAGjyZcD1pB9c5BUCjycV5ipQVOAirxhasZNIbYT5fWaFgGU8ViaybbU/qqk3BqU2G
         65XbnIIkKMqewnu5kHkx2vFIh9cefkvHHNCPmBIUj5pP1goIrLFQ1GFILqpSdJHigzvN
         KxME46w7i+nM331dx8274eao+vtByPP27drPyi4N0/+rMakpa+1uaFtpIfTYpbTwjoSj
         zBfDYhjrggSBSg+C78yQdB+r/KCOis81+DarWsHMjNxmdu9h1/19WkTR3lo0XJjkH573
         QDfNlKC8GmyvVcTsfRv0/m8/5hiO/EETuOdp/SDHxMlmGN3Xtdk3uB0I8kmKmP00zjbs
         LlBg==
X-Gm-Message-State: APjAAAUnS/OxYAt9ERid5ug8wV+VwTet+X1a63bXRG8AfGsTHfC+r07m
        e0K4ek/xiwy69EZ5hUKrFZ4=
X-Google-Smtp-Source: APXvYqyUuOXNashqVyigO74bGk3hcx/QshE8qBnwuNr5dHnh3HPFUqEVisEOv+CzsemxmYQZvEQexA==
X-Received: by 2002:a63:cb4b:: with SMTP id m11mr40382624pgi.49.1565795987214;
        Wed, 14 Aug 2019 08:19:47 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g14sm100541pfo.41.2019.08.14.08.19.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 08:19:45 -0700 (PDT)
Date:   Wed, 14 Aug 2019 08:19:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot
 warnings
Message-ID: <20190814151943.GA121898@dtor-ws>
References: <1565731976.8572.16.camel@lca.pw>
 <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 14, 2019 at 12:03:19AM -0700, Stephen Boyd wrote:
> Quoting Qian Cai (2019-08-13 14:32:56)
> > The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [1]
> > introduced some baddies during boot on several x86 servers. Reverted the commit
> > fixed the issue.
> > 
> > [1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.com/
> > 
> > [   39.195053][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
> > [   39.197347][    T1] kobject_add_internal failed for wakeup (error: -2 parent: serio0)
> > [   39.199845][    T1] INFO: trying to register non-static key.
> > [   39.201582][    T1] the code is fine but needs lockdep annotation.
> > [   39.203477][    T1] turning off the locking correctness validator.
> > [   39.205399][    T1] CPU: 12 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-
> > next-20190813 #3
> > [   39.207938][    T1] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
> > Gen9, BIOS U19 12/27/2015
> > [   39.210606][    T1] Call Trace:
> > [   39.210606][    T1]  dump_stack+0x62/0x9a
> > [   39.210606][    T1]  register_lock_class+0x95a/0x960
> > [   39.210606][    T1]  ? __platform_driver_probe+0xcd/0x230
> > [   39.210606][    T1]  ? __platform_create_bundle+0xc0/0xe0
> > [   39.210606][    T1]  ? i8042_init+0x4ec/0x578
> > [   39.210606][    T1]  ? do_one_initcall+0xfe/0x45a
> > [   39.219571][    T1]  ? kernel_init_freeable+0x614/0x6a7
> > [   39.219571][    T1]  ? kernel_init+0x11/0x138
> > [   39.219571][    T1]  ? ret_from_fork+0x35/0x40
> > [   39.219571][    T1]  ? is_dynamic_key+0xf0/0xf0
> > [   39.219571][    T1]  ? rwlock_bug.part.0+0x60/0x60
> > [   39.219571][    T1]  ? __debug_check_no_obj_freed+0x8e/0x250
> > [   39.219571][    T1]  __lock_acquire.isra.13+0x5f/0x830
> > [   39.229491][    T1]  ? __debug_check_no_obj_freed+0x152/0x250
> > [   39.229491][    T1]  lock_acquire+0x107/0x220
> > [   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
> > [   39.229491][    T1]  _raw_spin_lock_irqsave+0x35/0x50
> > [   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
> > [   39.229491][    T1]  __pm_relax.part.2+0x21/0xa0
> > [   39.239588][    T1]  wakeup_source_destroy.part.3+0x18/0x190
> > [   39.239588][    T1]  wakeup_source_register+0x43/0x50
> > [   39.239588][    T1]  device_wakeup_enable+0x76/0x170
> > [   39.239588][    T1]  device_set_wakeup_enable+0x13/0x20
> > [   39.239588][    T1]  i80probe+0x921/0xa45
> > [   39.339546][    T1]  ? i8042_toggle_aux+0xeb/0xeb
> > [   39.349486][    T1]  ? kernfs_create_link+0xce/0x100
> > [   39.349486][    T1]  ? sysfs_do_create_link_sd+0x7b/0xe0
> > [   39.349486][    T1]  ? acpi_dev_pm_attach+0x31/0xf0
> > [   39.349486][    T1]  platform_drv_probe+0x51/0xe0
> > [   39.349486][    T1]  really_probe+0x1a2/0x630
> > [   39.349486][    T1]  ? device_driver_attach+0xa0/0xa0
> > [   39.349486][    T1]  driver_probe_device+0xcd/0x1f0
> > [   39.359562][    T1]  ? device_driver_attach+0xa0/0xa0
> > [   39.359562][    T1]  device_driver_attach+0x8f/0xa0
> > [   39.359562][    T1]  __driver_attach+0xc7/0x1a0
> > [   39.359562][    T1]  bus_for_each_dev+0xfe/0x160
> > [   39.359562][    T1]  ? subsys_dev_iter_init+0x80/0x80
> > [   39.359562][    T1]  ? __kasan_check_read+0x11/0x20
> > [   39.359562][    T1]  ? _raw_spin_unlock+0x27/0x40
> > [   39.369488][    T1]  driver_attach+0x2b/0x30
> > [   39.369488][    T1]  bus_add_driver+0x298/0x350
> > [   39.369488][    T1]  driver_register+0xdc/0x1d0
> > [   39.369488][    T1]  ? i8042_toggle_aux+0xeb/0xeb
> > [   39.369488][    T1]  __platform_driver_probe+0xcd/0x230
> > [   39.3  __platform_create_bundle+0xc0/0xe0
> > [   39.769489][    T1]  ? i8042_toggle_aux+0xeb/0xeb
> > [   39.779556][    T1]  ? i8042_probe+0xa45/0xa45
> > [   39.779556][    T1]  i8042_init+0x4ec/0x578
> > [   39.779556][    T1]  ? i8042_probe+0xa45/0xa45
> > [   39.779556][    T1]  ? netdev_run_todo+0x2f/0x4a0
> > [   39.779556][    T1]  ? qdisc_create_dflt+0xf0/0xf0
> > [   39.779556][    T1]  ? net_olddevs_init+0x67/0x67
> > [   39.779556][    T1]  ? i8042_probe+0xa45/0xa45
> > [   39.789486][    T1]  do_one_initcall+0xfe/0x45a
> > [   39.789486][    T1]  ? initcall_blacklisted+0x150/0x150
> > [   39.789486][    T1]  ? __kasan_check_write+0x14/0x20
> > [   39.789486][    T1]  ? up_write+0xee/0x2a0
> > [   39.789486][    T1]  kernel_init_freeable+0x614/0x6a7
> > [   39.789486][    T1]  ? rest_init+0x188/0x188
> > [   39.789486][    T1]  kernel_init+0x11/0x138
> > [   39.799563][    T1]  ? rest_init+0x188/0x188
> > [   39.799563][    T1]  ret_from_fork+0x35/0x40
> > [   39.803412][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
> 
> Besides the bad error path causing the big stack trace, I think there's
> a race between when the serio device is added with device_add() in
> serio_add_port() and when i8042_register_ports() calls
> device_set_wakeup_enable(). The serio_add_port() function is called from
> a workqueue that is schedule to run by i8042_register_ports() calling
> serio_register_port(), but otherwise there isn't any guarantee that the
> workqueue has actually run by the time the function returns and
> i8042_register_ports() calls device_set_wakeup_enable().
> 
> This means that the device may not have actually been registered yet,
> and thus doing other device like operations on the serio device before
> the workqueue runs will lead to weird behavior because the parent device
> isn't fully registered with the driver core. That causes the error
> message above:
> 
> > [   39.197347][    T1] kobject_add_internal failed for wakeup (error: -2 parent: serio0)
> 
> So maybe we need to add another hook after the device is added
> successfully so we can do the wakeup things.
> 
> I also notice that device_set_wakeup_capable() has a check to see if the
> device is registered yet and it skips creating sysfs entries for the
> device if it isn't created in sysfs yet. Why? Just so it can be called
> before the device is created? I guess the same logic is handled by
> dpm_sysfs_add() if the device is registered after calling
> device_set_wakeup_*().
> 
> There's two approaches I see:
> 
> 	1) Do a similar check for device_set_wakeup_enable() and skip
> 	adding the wakeup class until dpm_sysfs_add().
> 
> 	2) Find each case where this happens and only call wakeup APIs
> 	on the device after the device is added.

So from i8042 POV what it is doing now is completely wrong, as it is
operating on structure in an unknown state, and what you propose below
makes total sense, except I'd use bus notifier and not a dedicated
callback, unless we see more serio drivers needing it.

Thanks.

-- 
Dmitry
