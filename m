Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BEC7CDDFB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbjJRNzU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbjJRNzS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 09:55:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B8FA
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 06:55:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4707C433CB
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697637316;
        bh=bz03Bc6iJIc0qdSq2nHXKel3IGRWo3LANcjeYvVFnu0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L+i3aQ3A4TO3NT/i0QR8R/odoSDTaHjQzLn/K3rhrMxSQgBc5QodhfWjVK5g5L/h8
         U9PwCrRMNcFV4HkcCxeBQXNCma74WEKUgsQpO+lQ1+YIwbkmmO35G0kKYuVI+L6dIp
         Hu23DtfbHptO18jk+ossAsdVqzovLD0tk0JgWxZN01+f4zG17lxn/Mr4N6tXrCfCB0
         p83ZyxRNSU2KuTxa2KllYuAWjX1+BxGzDZ1wtS+veTT4jLJPwiFVDbHXoNHFmjnRa3
         X9SV92ntbvhK/BIfL+SlmN/Jtb/e0Gc4Ps4dz8YuCEULXvdy6erq6FvAaMN9X5gu5H
         MaxBQ8ged+noQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BD9E6C53BD0; Wed, 18 Oct 2023 13:55:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218023] Overheating Ryzen 7 4800Hs processor
Date:   Wed, 18 Oct 2023 13:55:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: workshere359@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218023-137361-DkR4Ajbn9l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218023-137361@https.bugzilla.kernel.org/>
References: <bug-218023-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218023

--- Comment #2 from workshere359@gmail.com ---
(In reply to Artem S. Tashkinov from comment #1)
> I'm 99.9% sure it's either a hardware failure (malfunctioning fan?) or a
> buggy bios.
>=20
> The kernel cannot make your CPU run at unsafe temperatures. It's the CPU
> task to throttle if it heats up.
>=20
> It's great you've found a workaround but it's not a kernel issue and ther=
e's
> nothing that can be done in the kernel to fix it.

Hello! Thank you for your response!

I installed latest bios 310.

Alright, I started dealing with pwmconfig and fancontrol. I immediately
encountered the issue that I don=E2=80=99t have pwm1 :slight_smile:

Here=E2=80=99s the ls output:

device  fan1_input  fan1_label  name  power  pwm1_enable  subsystem  uevent
Here=E2=80=99s the pwd:

/sys/devices/platform/asus-nb-wmi/hwmon/hwmon5
From what works for me:
echo 2 > pwm_enable - works
echo 1 > pwm_enable - says it=E2=80=99s an invalid value
echo 0 > pwm_enable - turns the fans on at full speed. Honestly, I=E2=80=99=
ve never
heard them running so powerfully. However, I think you=E2=80=99re right; th=
is fan has
potential, and perhaps they could cool the processor effectively.

here sensors:
```
sensors                                                         =EE=82=B2 =
=E2=9C=94=20
amdgpu-pci-0400
Adapter: PCI adapter
vddgfx:      718.00 mV=20
vddnb:       674.00 mV=20
edge:         +46.0=C2=B0C=20=20
PPT:           4.00 W=20=20

k10temp-pci-00c3
Adapter: PCI adapter
Tctl:         +52.5=C2=B0C=20=20

BAT0-acpi-0
Adapter: ACPI interface
in0:          11.85 V=20=20

asus-isa-0000
Adapter: ISA adapter
cpu_fan:     1900 RPM

nvme-pci-0300
Adapter: PCI adapter
Composite:    +30.9=C2=B0C  (low  =3D  -0.1=C2=B0C, high =3D +76.8=C2=B0C)
                       (crit =3D +79.8=C2=B0C)

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +53.0=C2=B0C  (crit =3D +103.0=C2=B0C)
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
