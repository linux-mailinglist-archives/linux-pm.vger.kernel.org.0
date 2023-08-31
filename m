Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC66378E6DA
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbjHaGzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbjHaGzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 02:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D097E0;
        Wed, 30 Aug 2023 23:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17D3DB8214E;
        Thu, 31 Aug 2023 06:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB377C433C7;
        Thu, 31 Aug 2023 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693464913;
        bh=grzKBzpetMZY5pdHGAMbnhEOjQCjw9xTNEpumNTXwc0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sspU5rM1PBNw//1BbhEu4+mqq94+fmuemobfJp5WDzZsgguk+bGecuAatllWXvuGM
         mVc9JlEnqfLb4Cxqu3SdIP4JA093SJsWiGy/83LDTIrXklcN6QewyDTpsCdl565QY9
         zGyVuytze8UgNF9kbkYLkX2OYSmHenaNIaBB7/PF/Gz5sOLLdWSqFNtDxJPAsv1ku0
         XTMJ3qEi6xIuwLVxqYumt1onQ/HwwqpIPoV7ysqquYsCR3RQBt5HJPas5wie21+MuB
         nk0Om86w4MwsHy8wq6B8sYKCjSB+/UWjGbfReszLgPnTLcCFS2juv58SFOwcMsZ4kD
         rhjvvyOVFVIBQ==
Message-ID: <33be5c62-fd51-0485-ed4d-d9c79f26d85a@kernel.org>
Date:   Thu, 31 Aug 2023 15:55:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata,scsi: do not issue START STOP UNIT on resume
Content-Language: en-US
To:     Rodrigo Vivi <rodrigo.vivi@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Paul Ausbeck <paula@soe.ucsc.edu>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        TW <dalzot@gmail.com>, regressions@lists.linux.dev,
        Bart Van Assche <bvanassche@acm.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux Power Management <linux-pm@vger.kernel.org>
References: <20230731003956.572414-1-dlemoal@kernel.org>
 <ZOehTysWO+U3mVvK@rdvivi-mobl4>
 <40adc06d-0835-2786-0bfb-83239f546d92@kernel.org>
 <ZOjgJl4nlieu3+kL@rdvivi-mobl4>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZOjgJl4nlieu3+kL@rdvivi-mobl4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/26/23 02:09, Rodrigo Vivi wrote:
> I have the CONFIG_PM_DEBUG here with no_console_suspend.
> If you remember any other config or parameter that would help, please let
> me know that I collect it again:

Coming back to this previous dmesg output as I am in fact seeing something very
similar now. See below.

> [  104.571459] PM: suspend entry (deep)
> [  104.585967] Filesystems sync: 0.010 seconds
> [  104.618685] Freezing user space processes
> [  104.625374] Freezing user space processes completed (elapsed 0.002 seconds)
> [  104.632448] OOM killer disabled.
> [  104.635712] Freezing remaining freezable tasks
> [  104.641899] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)

suspend start and freezes the user tasks, as expected.

> [  104.669767] wlp6s0: deauthenticating from 08:36:c9:85:df:ef by local choice (Reason: 3=DEAUTH_LEAVING)
> [  104.679812] serial 00:01: disabled
> [  104.683466] sd 7:0:0:0: [sdc] Synchronizing SCSI cache
> [  104.688902] sd 7:0:0:0: [sdc] Stopping disk
> [  104.693176] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [  104.698419] sd 4:0:0:0: [sda] Synchronizing SCSI cache
> [  104.703730] sd 4:0:0:0: [sda] Stopping disk
> [  104.885912] sd 5:0:0:0: [sdb] Stopping disk
> [  106.163215] PM: suspend devices took 1.514 seconds

All devices are suspended. No issues. Then resume starts...

> [  107.003217] serial 00:01: activated
> [  107.076779] nvme nvme0: 16/0/0 default/read/poll queues
> [  107.123917] r8169 0000:07:00.0 enp7s0: Link is Down
> [  107.208945] PM: resume devices took 0.241 seconds
> [  107.214746] pcieport 0000:00:1c.0: PCI bridge to [bus 06]
> [  107.220274] pcieport 0000:00:1c.0:   bridge window [mem 0x43700000-0x437fffff]
> [  107.227538] OOM killer enabled.
> [  107.230710] Restarting tasks ...

... remember this one ...

> [  107.231803] pcieport 0000:00:1c.2: PCI bridge to [bus 07]
> [  107.236474] done.
> [  107.240599] pcieport 0000:00:1c.2:   bridge window [io  0x4000-0x4fff]
> [  107.242574] random: crng reseeded on system resumption
> [  107.249119] pcieport 0000:00:1c.2:   bridge window [mem 0x43600000-0x436fffff]
> [  107.249405] pcieport 0000:00:1c.6: PCI bridge to [bus 08]
> [  107.259714] PM: suspend exit
> [  107.261623] pcieport 0000:00:1c.6:   bridge window [io  0x3000-0x3fff]
> [  107.276554] pcieport 0000:00:1c.6:   bridge window [mem 0x43500000-0x435fffff]
> [  107.283849] pcieport 0000:00:1c.6:   bridge window [mem 0x70900000-0x709fffff 64bit pref]
> [  107.293567] ata7: SATA link down (SStatus 4 SControl 300)
> [  107.304150] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  107.310975] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  107.319173] ata5.00: configured for UDMA/133
> [  107.324620] ata5.00: Enabling discard_zeroes_data
> [  107.398370] ata6.00: configured for UDMA/133

started bringing back up devices, but suspend comes back again.

> [  108.563229] PM: suspend entry (deep)
> [  108.573610] Filesystems sync: 0.006 seconds
> [  108.580617] Freezing user space processes
> [  108.586774] Freezing user space processes completed (elapsed 0.002 seconds)
> [  108.593793] OOM killer disabled.
> [  108.597055] Freezing remaining freezable tasks
> [  108.603246] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)

which freezes the tasks, again.

> [  108.621515] sd 7:0:0:0: [sdc] Synchronizing SCSI cache
> [  108.621522] sd 5:0:0:0: [sdb] Synchronizing SCSI cache
> [  108.622018] serial 00:01: disabled
> [  108.635420] sd 4:0:0:0: [sda] Synchronizing SCSI cache
> [  108.640747] sd 4:0:0:0: [sda] Stopping disk
> [  108.644148] sd 5:0:0:0: [sdb] Stopping disk
> [  108.983487] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  108.991923] ata8.00: configured for UDMA/133
> [  108.996423] sd 7:0:0:0: [sdc] Stopping disk
> [  109.973722] PM: suspend devices took 1.363 seconds

And suspend finishes, followed by resume starting.

> [  110.721600] serial 00:01: activated
> [  110.802094] nvme nvme0: 16/0/0 default/read/poll queues
> [  110.873036] r8169 0000:07:00.0 enp7s0: Link is Down
> [  111.032278] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  111.038583] ata7: SATA link down (SStatus 4 SControl 300)
> [  111.044065] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  111.051326] ata5.00: configured for UDMA/133
> [  111.056118] ata5.00: Enabling discard_zeroes_data
> [  111.131795] ata6.00: configured for UDMA/133
> [  112.713764] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  112.724250] ata8.00: configured for UDMA/133

Resume restarted the devices, but there is no "Restarting tasks" ! So the user
tasks are frozen, hence the "hang". There are no user processes to run, so no
coming back to the shell.

So even without the libata patches fixing the resume mess, this issue does not
look like a libata issue. I think your bisect hitting the no_start_on_resume
patch is simply because that patch changes the timing of things and makes it
easier to hit this issue.

Adding PM folks because I am out of my depth on this one...

PM folks,

Rodrigo hit an issue doing suspend+resume cycles in a loop, with the resume
triggered a very short time (wakealarm) after starting resume. This ends up
with a hang. I could recreate the same in qemu. I cannot get wakealarm to work
for some reason, but I have a virtio device not supporting suspend which
triggers the resume in the middle of suspend. And repeating "systemctl suspend"
again and again, I end up with a similar hang:

[   98.455929] PM: suspend entry (s2idle)
[   98.466622] Filesystems sync: 0.008 seconds
[   98.473871] Freezing user space processes
[   98.476372] Freezing user space processes completed (elapsed 0.001 seconds)
[   98.478197] OOM killer disabled.
[   98.479199] Freezing remaining freezable tasks
[   98.481887] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)

suspend starts, freezineg the tasks.

[   98.493890] virtio-fs: suspend/resume not yet supported
[   98.493971] sd 2:0:0:0: [sdc] Synchronizing SCSI cache
[   98.499658] virtio-pci 0000:00:05.0: PM: pci_pm_suspend():
virtio_pci_freeze+0x0/0x50 returns -95
[   98.504241] virtio-pci 0000:00:05.0: PM: dpm_run_callback():
pci_pm_suspend+0x0/0x230 returns -95
[   98.507762] virtio-pci 0000:00:05.0: PM: failed to suspend async: error -95

Failure of the virtio device suspend which will trigger pm_recover+resume.

[   98.509451] ata3.00: Entering standby power mode
[   98.511197] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[   98.512917] sd 0:0:0:0: [sda] Synchronizing SCSI cache

Here, the scsi devices already suspended (asynchronously) do their thing.

[   98.515562] PM: Some devices failed to suspend, or early wake event detected
[   98.521098] virtio_blk virtio3: 4/0/0 default/read/poll queues
[   98.548229] OOM killer enabled.
[   98.549338] Restarting tasks ... done.

The tasks are restarted due to the suspend error above.

[   98.551734] random: crng reseeded on system resumption
[   98.559697] PM: suspend exit
[   98.561038] PM: suspend entry (s2idle)
[   98.566692] Filesystems sync: 0.004 seconds
[   98.574461] Freezing user space processes
[   98.577265] Freezing user space processes completed (elapsed 0.001 seconds)
[   98.579351] OOM killer disabled.
[   98.580341] Freezing remaining freezable tasks
[   98.583109] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)

but here, for whatever reason, the tasks are suspended again despite the fact
that we should be resuming. After this, I only see the scsi&ata devices
finishing suspend and then being resumed all normally. But no coming back to
the shell. It is frozen...

Any idea ?

-- 
Damien Le Moal
Western Digital Research

