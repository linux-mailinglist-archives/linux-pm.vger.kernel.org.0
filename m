Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2C66AF6F
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jan 2023 06:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjAOFHs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 15 Jan 2023 00:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAOFHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jan 2023 00:07:46 -0500
X-Greylist: delayed 430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 21:07:44 PST
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EEBA244
        for <linux-pm@vger.kernel.org>; Sat, 14 Jan 2023 21:07:43 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 03E60641730
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 05:00:33 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2ABDE64162D
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 05:00:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673758832; a=rsa-sha256;
        cv=none;
        b=ikwQq3qbML9sb76Ld3UY6uHrnR8ddqMvGfXJPyd+2HIy9HG7LeZEgS/qmzpXr/GGmnM++n
        mgalnWXpyJJ8S2AztkRF41MN/Xl1kfKYV3Imrt8CbB6uhY7oowSsP6+e1BkkRxyr6NWtWP
        leNno4IoZfqbTdvnSdib6XbGIki2Gj1uSQUa9OJYmYRGMxbmlVm6gHpvULqeem+Q0sbx2O
        rhEUnqiHMLhGqLDl/pf1BQ+9DtaD2KkthRuuL1bvyQIeKoOFxiORtVtaDsZW1Vovynk0iD
        SeOgaA0WSxLROgY29IMo9qpAYVVdseTMOGXD1uc+H6juduNHIYbd0QAYHaOsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673758832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rMV45TWEd3TD30lVcSmxU/OA109dr4q0muPvIVKyc6U=;
        b=0XCrfJhHZN4sidNyIBQvOReuB31XtVnLDusrKvlBxuwuTybtNp3Lt8o53HZjwMApesYUc+
        TB8N+XU8hfJ7lQ2lwza4+5My0qnmAngyzvteuT7f2nclbuMZSxJM4AKZiYlyo/iqvrITxl
        9V2FPQ91bdJ/z2T9BQVCB0wFxQE8zJktmlGHAcgCUEZEI+/6F0Xb2FIgB6zDB2T5Ck7dtY
        CEMYzD/CYi4xgngNa+kvqt7KFvZcbR96a/23MPSvAbY22G0sRtXIHJp4UDyRbToX/z8b0e
        1iysnm9W8EIqp2XNKm5m5f6d7lbc0esSfExM83Sr7bF4/IJN5q6ZAqP7FrwNFg==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-pr55d;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stop-Tank: 652c32380d7ef41c_1673758832681_317391484
X-MC-Loop-Signature: 1673758832681:3184853011
X-MC-Ingress-Time: 1673758832680
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.24.68 (trex/6.7.1);
        Sun, 15 Jan 2023 05:00:32 +0000
Received: from p5b071e4a.dip0.t-ipconnect.de ([91.7.30.74]:51102 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pGv85-0000Ae-12
        for linux-pm@vger.kernel.org;
        Sun, 15 Jan 2023 05:00:30 +0000
Message-ID: <07e4bb6502042ae103824de53c1c382b2be2f658.camel@scientia.org>
Subject: suspend to RAM broken on Fujitsu Lifebook U7512
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-pm@vger.kernel.org
Date:   Sun, 15 Jan 2023 06:00:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey.


I've had reported that previously[0] but LKML was probably to general
to get feedback.

I got a new Fujitsu Lifebook U7512, which has an Intel i7-1270P and
runs with Debian unstable (kernel 6.1.4).


A previous error that I've described in [0] that occurred on resume
(after suspending to RAM) and which had to do with i915 has now been
fixed - not by the patches to i915 (which haven't made it into mainline
or stables kernels yet), but by a BIOS update (which is now at the most
recent on published) provided by Fujitsu.
So the i915 related issues should be gone (I guess) - at least no i915
related errors show up anymore in the kernel log and also the other
symptoms described in the i915 bugs linked at [0] are gone.



However, another issue remains:

When I go into suspend (to RAM) the system doesn't actually seem to
fully suspend:
- the fan keeps still running (though it sometimes slows down after a
  while)
- while I see the typical (well at least for Fujitsu notebooks) LED
  blinking pattern which indicates suspend to RAM, ... resume is not
  triggered by pressing the power button (as it used to be in my
  previous Fujitsu notebooks - in addition to opening the lid), but by
  pressing any keyboard key, which also means that at least the
  keyboard is still powered on.


# cat /sys/power/mem_sleep
[s2idle] deep

I manually set that to deep, and then tried suspend&resume again, but
on resume the system just freezes: screen doesn't go on, neither would
I hear any fan that indicates CPU utilisation,... the only thing what
happens is that the power LED and the F-Lock[1] LED go on.
Doesn't seem I could do anything than long-pressing the powerbutton to
shut it off.


With s2idle, a suspend/resume cycle gives the following output to the
kernel log:
Jan 15 05:55:43 heisenberg kernel: wlan0: deauthenticating from 50:e6:36:3c:99:36 by local choice (Reason: 3=DEAUTH_LEAVING)
Jan 15 05:55:44 heisenberg kernel: PM: suspend entry (s2idle)
Jan 15 05:55:44 heisenberg kernel: Filesystems sync: 0.016 seconds
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware regulatory.db
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware iwlwifi-so-a0-gf-a0.pnvm
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware regulatory.db.p7s
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware intel/sof-tplg/sof-hda-generic-2ch.tplg
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware iwlwifi-so-a0-gf-a0-72.ucode
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware i915/adlp_dmc_ver2_16.bin
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware i915/adlp_guc_70.bin
Jan 15 05:55:44 heisenberg kernel: (NULL device *): firmware: direct-loading firmware i915/tgl_huc.bin
Jan 15 05:55:51 heisenberg kernel: Freezing user space processes ... (elapsed 0.039 seconds) done.
Jan 15 05:55:51 heisenberg kernel: OOM killer disabled.
Jan 15 05:55:51 heisenberg kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jan 15 05:55:51 heisenberg kernel: printk: Suspending console(s) (use no_console_suspend to debug)
Jan 15 05:55:51 heisenberg kernel: intel-hid INTC1070:00: failed to get button capability
Jan 15 05:55:51 heisenberg kernel: e1000e: EEE TX LPI TIMER: 00000011
Jan 15 05:55:51 heisenberg kernel: ACPI: EC: interrupt blocked
Jan 15 05:55:51 heisenberg kernel: ACPI: EC: interrupt unblocked
Jan 15 05:55:51 heisenberg kernel: i915 0000:00:02.0: [drm] GuC firmware i915/adlp_guc_70.bin version 70.5.1
Jan 15 05:55:51 heisenberg kernel: i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc.bin version 7.9.3
Jan 15 05:55:51 heisenberg kernel: intel-hid INTC1070:00: failed to get button capability
Jan 15 05:55:51 heisenberg kernel: nvme nvme0: Shutdown timeout set to 10 seconds
Jan 15 05:55:51 heisenberg kernel: nvme nvme0: 16/0/0 default/read/poll queues
Jan 15 05:55:51 heisenberg kernel: i915 0000:00:02.0: [drm] HuC authenticated
Jan 15 05:55:51 heisenberg kernel: i915 0000:00:02.0: [drm] GuC submission enabled
Jan 15 05:55:51 heisenberg kernel: i915 0000:00:02.0: [drm] GuC SLPC enabled
Jan 15 05:55:51 heisenberg kernel: i915 0000:00:02.0: [drm] GuC RC: enabled
Jan 15 05:55:51 heisenberg kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
Jan 15 05:55:51 heisenberg kernel: OOM killer enabled.
Jan 15 05:55:51 heisenberg kernel: Restarting tasks ... done.
Jan 15 05:55:51 heisenberg kernel: random: crng reseeded on system resumption
Jan 15 05:55:51 heisenberg kernel: PM: suspend exit
Jan 15 05:55:51 heisenberg kernel: e1000e 0000:00:1f.6 eth0: NIC Link is Down
Jan 15 05:55:53 heisenberg kernel: wlan0: authenticate with 50:e6:36:3c:99:36
Jan 15 05:55:53 heisenberg kernel: wlan0: send auth to 50:e6:36:3c:99:36 (try 1/3)
Jan 15 05:55:54 heisenberg kernel: wlan0: authenticate with 50:e6:36:3c:99:36
Jan 15 05:55:54 heisenberg kernel: wlan0: send auth to 50:e6:36:3c:99:36 (try 1/3)
Jan 15 05:55:54 heisenberg kernel: wlan0: authenticated
Jan 15 05:55:54 heisenberg kernel: wlan0: associate with 50:e6:36:3c:99:36 (try 1/3)
Jan 15 05:55:54 heisenberg kernel: wlan0: RX AssocResp from 50:e6:36:3c:99:36 (capab=0x1511 status=0 aid=2)
Jan 15 05:55:54 heisenberg kernel: wlan0: associated
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: iwlwifi 0000:00:14.3: Unhandled alg: 0x707
Jan 15 05:55:54 heisenberg kernel: wlan0: Limiting TX power to 20 (23 - 3) dBm as advertised by 50:e6:36:3c:99:36
Jan 15 05:55:54 heisenberg kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready


What else can I say... the system runs in native UEFI (no CSM)... if
you need any other information, don't hesitate to ask :-)


Any help in fixing this would be greatly appreciated.

Thanks,
Chris.

PS: Please keep me CCed, as I'm not subscribed.


[0] https://lore.kernel.org/lkml/137702a8b3abf9cd7083acd05156bdf970b0a41d.camel@scientia.org/
[1] That's just a permanent switch between the F*-keys and the
    "multimedia".keys.
