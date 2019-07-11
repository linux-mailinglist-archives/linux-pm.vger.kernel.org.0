Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2108B65023
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfGKC2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 22:28:18 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:34402 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfGKC2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 22:28:18 -0400
Received: by mail-pf1-f174.google.com with SMTP id b13so1998703pfo.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJZ8zY88d2N4tkkHZDwEOtu2EiuE98IVyV4C3BjNEcI=;
        b=ulM0cYU4SBNaA9msJWEJPT6/RN01q8tAkQ6gpe8+b8bZrMncxfH60xJ6s54nXB5YJc
         +nm0lEZOliPbD4MxZBuvCll9Z+lN+C4AHe/fOAhbg9VgBg/ADNu7qDja73lRYMDP+sPs
         rLqAWY3TkbaX+d1NhieE+gUyFOn98hWl1E2yUJE9TQpSCdwzUP1IY+h1/eNl61gGwSQ4
         v0vB3ldlpAPiWZ/kakC6iP28fB4LHkO0z8WsiDYsbYT7wavTKEUmrSJj8ehXse0xqoZF
         Oyi5QRIFhhDmJpxS5uYTgK3HlQWJW6VdFGfm7tx9/LpZXZQ7xD76D9aE5GClw6VGltPg
         xfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJZ8zY88d2N4tkkHZDwEOtu2EiuE98IVyV4C3BjNEcI=;
        b=Ll4aSR405P2IyTuDbOoV0hipv7y4fAAeygttiCZI9hXD8YAtOdxBP1Yvc3hXsWA0BA
         WdWhJl+yP01FTDILM4kulAqrVeEswxt5tlzQ7tExheQVXqfiEU5QKn7jVxQDxWcdQORn
         u+gV5yV3UZZ7Li/A0ID79nyF8PjEjjxku+kEXZ+IprDtNuMTtj6DruWaSsuk2OyzS7da
         eEfykWm/3IHWFOqHADEVLXvF19PetNj+ZlcXbvWGfLWQ0giR/TDzJ6A7KEs/pUfwQTOG
         FPRZS6izALaH37R0EZGhao/C3zr9midt7GUgldNpw9++xdnGZir82/1ZGQb7RdqppuTr
         7HGA==
X-Gm-Message-State: APjAAAUEyA03gaRzlcjqn67GsrrAN0Bau4mqnKDjtusoihUwazpgSXBU
        zfjmcdZ1E6mW83IcwJmZ8zJSXQ==
X-Google-Smtp-Source: APXvYqwBNcW4gZeuTQR+3ladTRBgmEeF2WVujRAcPc/I7iuuqQ4q27rhPpTJrvYZoYrGF7j+ViKBbQ==
X-Received: by 2002:a65:4346:: with SMTP id k6mr1725401pgq.208.1562812097097;
        Wed, 10 Jul 2019 19:28:17 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 1sm3788253pfe.102.2019.07.10.19.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 19:28:16 -0700 (PDT)
Date:   Thu, 11 Jul 2019 07:58:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: cpufreq-related deadlock warning on recent linux-next
Message-ID: <20190711022813.zfroyk3drfarvpwj@vireshk-i7>
References: <6addb70f-6b21-4f09-e1a0-21476b55df14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6addb70f-6b21-4f09-e1a0-21476b55df14@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-07-19, 22:53, Heiner Kallweit wrote:
> I just got the following when manually suspending the system with
> "systemctl suspend" and waking it up with the power button.
> 
> 
> [  380.203172] Restarting tasks ... done.
> 
> [  380.211714] ============================================
> [  380.211719] WARNING: possible recursive locking detected
> [  380.211726] 5.2.0-rc7-next-20190704+ #2 Not tainted
> [  380.211731] --------------------------------------------
> [  380.211737] systemd-sleep/2367 is trying to acquire lock:
> [  380.211745] 0000000043cf69ce (&policy->rwsem){+.+.}, at: refresh_frequency_limits+0x36/0x90
> [  380.211761]
>                but task is already holding lock:
> [  380.211767] 0000000043cf69ce (&policy->rwsem){+.+.}, at: cpufreq_cpu_acquire+0x25/0x50
> [  380.211777]
>                other info that might help us debug this:
> [  380.211783]  Possible unsafe locking scenario:
> 
> [  380.211789]        CPU0
> [  380.211792]        ----
> [  380.211795]   lock(&policy->rwsem);
> [  380.211800]   lock(&policy->rwsem);
> [  380.211805]
>                 *** DEADLOCK ***
> 
> [  380.211811]  May be due to missing lock nesting notation
> 
> [  380.211818] 8 locks held by systemd-sleep/2367:
> [  380.211823]  #0: 000000000e253e21 (sb_writers#5){.+.+}, at: vfs_write+0x16b/0x1d0
> [  380.211835]  #1: 00000000d0140159 (&of->mutex){+.+.}, at: kernfs_fop_write+0xfd/0x1c0
> [  380.211846]  #2: 00000000383c283a (kn->count#155){.+.+}, at: kernfs_fop_write+0x105/0x1c0
> [  380.211857]  #3: 000000007e6f342b (system_transition_mutex){+.+.}, at: pm_suspend.cold+0xd0/0x36a
> [  380.211869]  #4: 000000002ee59360 ((pm_chain_head).rwsem){++++}, at: __blocking_notifier_call_chain+0x46/0x80
> [  380.211883]  #5: 000000003972eb2e (&tz->lock){+.+.}, at: step_wise_throttle+0x3f/0x90
> [  380.211893]  #6: 0000000007747f02 (&cdev->lock){+.+.}, at: thermal_cdev_update+0x1e/0x16c
> [  380.211904]  #7: 0000000043cf69ce (&policy->rwsem){+.+.}, at: cpufreq_cpu_acquire+0x25/0x50

This is already fixed in linux-next few days back. Can you try the
latest stuff again ?

-- 
viresh
