Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F507080EC
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjERMOB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjERMOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 08:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D210A;
        Thu, 18 May 2023 05:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7851F64EC0;
        Thu, 18 May 2023 12:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B69C433D2;
        Thu, 18 May 2023 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684412038;
        bh=oaP1EfCM6LXrjIlM59vOkT/OQJLeqM9HzkL0UD641Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/1rUQ+jkoZyE3T2234cqV/eM/SXnBjeMWmK79NOVmLTueUvIhoKTDuJSfxL/F+VD
         pe6LqORKBe9ovLYKIRfRHAIoQ01SdndLcfrII7USITyT8Ph5jhK6mcmV4L2pt8iC1r
         kl+yg8PSVgUFqgX6Ia5yUYGUe48CupXAHGPBklw34nEcwvURMvooyLHan9RZl0maeH
         rfrqSJRCoSfr5bsOl5YVKFFXAL1nKsytBDZyFYa8S30zzKyj5G15ofa8A5ksztMSXe
         trZujYN02E6Uekfq2JN/1UTIKob5+fS2JNv/0V4CzF6Tq/3XyamPhR8Ts7aC3KvEoo
         rRH4QFXJhcCjQ==
Date:   Thu, 18 May 2023 13:13:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH RESEND 3/4] leds: Fix oops about sleeping in
 led_trigger_blink()
Message-ID: <20230518121352.GI404509@google.com>
References: <20230510162234.291439-1-hdegoede@redhat.com>
 <20230510162234.291439-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510162234.291439-4-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 10 May 2023, Hans de Goede wrote:

> led_trigger_blink() calls led_blink_set() from a RCU read-side critical
> section so led_blink_set() must not sleep. Note sleeping was not allowed
> before the switch to RCU either because a spinlock was held before.
> 
> led_blink_set() does not sleep when sw-blinking is used, but
> many LED controller drivers with hw blink support have a blink_set
> function which may sleep, leading to an oops like this one:
> 
> [  832.605062] ------------[ cut here ]------------
> [  832.605085] Voluntary context switch within RCU read-side critical section!
> [  832.605119] WARNING: CPU: 2 PID: 370 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x4ee/0x690
> <snip>
> [  832.606453] Call Trace:
> [  832.606466]  <TASK>
> [  832.606487]  __schedule+0x9f/0x1480
> [  832.606527]  schedule+0x5d/0xe0
> [  832.606549]  schedule_timeout+0x79/0x140
> [  832.606572]  ? __pfx_process_timeout+0x10/0x10
> [  832.606599]  wait_for_completion_timeout+0x6f/0x140
> [  832.606627]  i2c_dw_xfer+0x101/0x460
> [  832.606659]  ? psi_group_change+0x168/0x400
> [  832.606680]  __i2c_transfer+0x172/0x6d0
> [  832.606709]  i2c_smbus_xfer_emulated+0x27d/0x9c0
> [  832.606732]  ? __schedule+0x430/0x1480
> [  832.606753]  ? preempt_count_add+0x6a/0xa0
> [  832.606778]  ? get_nohz_timer_target+0x18/0x190
> [  832.606796]  ? lock_timer_base+0x61/0x80
> [  832.606817]  ? preempt_count_add+0x6a/0xa0
> [  832.606842]  __i2c_smbus_xfer+0xa2/0x3f0
> [  832.606862]  i2c_smbus_xfer+0x66/0xf0
> [  832.606882]  i2c_smbus_read_byte_data+0x41/0x70
> [  832.606901]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [  832.606922]  ? __pm_runtime_suspend+0x46/0xc0
> [  832.606946]  cht_wc_byte_reg_read+0x2e/0x60
> [  832.606972]  _regmap_read+0x5c/0x120
> [  832.606997]  _regmap_update_bits+0x96/0xc0
> [  832.607023]  regmap_update_bits_base+0x5b/0x90
> [  832.607053]  cht_wc_leds_brightness_get+0x412/0x910 [leds_cht_wcove]
> [  832.607094]  led_blink_setup+0x28/0x100
> [  832.607119]  led_trigger_blink+0x40/0x70
> [  832.607145]  power_supply_update_leds+0x1b7/0x1c0
> [  832.607174]  power_supply_changed_work+0x67/0xe0
> [  832.607198]  process_one_work+0x1c8/0x3c0
> [  832.607222]  worker_thread+0x4d/0x380
> [  832.607243]  ? __pfx_worker_thread+0x10/0x10
> [  832.607258]  kthread+0xe9/0x110
> [  832.607279]  ? __pfx_kthread+0x10/0x10
> [  832.607300]  ret_from_fork+0x2c/0x50
> [  832.607337]  </TASK>
> [  832.607344] ---[ end trace 0000000000000000 ]---
> 
> Add a new led_blink_set_nosleep() function which defers the actual
> led_blink_set() call to a workqueue when necessary to fix this.
> 
> This also fixes an existing race where a pending led_set_brightness() has
> been deferred to set_brightness_work and might then race with a later
> led_cdev->blink_set() call. Note this race is only an issue with triggers
> mixing led_trigger_event() and led_trigger_blink() calls, sysfs API
> calls and led_trigger_blink_oneshot() are not affected.
> 
> Note rather then adding a separate blink_set_blocking callback this uses
> the presence of the already existing brightness_set_blocking callback to
> detect if the blinking call should be deferred to set_brightness_work.
> 
> Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Tested-by: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/leds/led-core.c     | 24 ++++++++++++++++++++++++
>  drivers/leds/led-triggers.c |  2 +-
>  include/linux/leds.h        | 24 ++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
