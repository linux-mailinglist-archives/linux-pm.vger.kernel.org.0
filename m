Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE018CC44
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 09:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfHNHDX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 03:03:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45589 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfHNHDX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 03:03:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so7758893pfq.12
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 00:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=vnJZWsx1lvrYRY7FV5VKlJAIHkZ7hl+aJL7t07Sz2NU=;
        b=i5LDGuJU1FlMwYw7JT2OBp8XkKoaUQKh+pxjwspp3oo53OIS6ZAQ555a1ih7Q08gTC
         ZYO1f2PNOVVvnqpYqaF5KAiljIgLtCdiWaKuHS5FvTHj3AkpJtyzlxZ+Eu+KpXeCJADg
         CHnTL3mx1zE0P3InKm5RaGG5LXZUPslzDLkcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=vnJZWsx1lvrYRY7FV5VKlJAIHkZ7hl+aJL7t07Sz2NU=;
        b=LzntIPDFWP5z2pAHK6w04smAtQsRUkCuI/6zgGQ5Y4heMRV5ClNMqNmtoWeEXEnzhI
         kQ/fhSaCWbQeE7ydYz3/kyoDuSrLR4AHMxLjMGNS9jA6BPWNpWF3sSiJ90ca8BlqRPwP
         sUmyUOQnA0/kSA0ZRJSnyC3/Kn4LzlY1GyTp3YpfZVH/9/JzEM//ywEPLZWd7Mqc6atI
         JHvhQY33CtqvIPNYnzwakH2vBATCFCieZprvywDtYp1K27tP/XcddmbbcHe2LnKMPiDo
         XT1E1Nln8PBvYBikBUgeBkABqwi29BgenUq3KBqX3s2xsdCy73azjhHvalQZfWfwFeOb
         +2Uw==
X-Gm-Message-State: APjAAAULdU0+p+fJ4bZ6tzzDeBbj05JIMxJlOlueUu6vQPlbUPX7bOsg
        l5+LMJgPUBG/WR7RNdVsVZJwRQ==
X-Google-Smtp-Source: APXvYqzOMS3PcLN9vviLUXy1+fLQQl1B1s5iR4S4mz6hvwCTwEotngop4XjvUuWaI7ouoyq1SdFzNA==
X-Received: by 2002:a17:90a:e38e:: with SMTP id b14mr5720709pjz.125.1565766201679;
        Wed, 14 Aug 2019 00:03:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m37sm6047047pjb.0.2019.08.14.00.03.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 00:03:20 -0700 (PDT)
Message-ID: <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565731976.8572.16.camel@lca.pw>
References: <1565731976.8572.16.camel@lca.pw>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 00:03:19 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Qian Cai (2019-08-13 14:32:56)
> The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [=
1]
> introduced some baddies during boot on several x86 servers. Reverted the =
commit
> fixed the issue.
>=20
> [1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.co=
m/
>=20
> [=C2=A0=C2=A0=C2=A039.195053][=C2=A0=C2=A0=C2=A0=C2=A0T1] serio: i8042 KB=
D port at 0x60,0x64 irq 1
> [=C2=A0=C2=A0=C2=A039.197347][=C2=A0=C2=A0=C2=A0=C2=A0T1] kobject_add_int=
ernal failed for wakeup (error: -2 parent: serio0)
> [=C2=A0=C2=A0=C2=A039.199845][=C2=A0=C2=A0=C2=A0=C2=A0T1] INFO: trying to=
 register non-static key.
> [=C2=A0=C2=A0=C2=A039.201582][=C2=A0=C2=A0=C2=A0=C2=A0T1] the code is fin=
e but needs lockdep annotation.
> [=C2=A0=C2=A0=C2=A039.203477][=C2=A0=C2=A0=C2=A0=C2=A0T1] turning off the=
 locking correctness validator.
> [=C2=A0=C2=A0=C2=A039.205399][=C2=A0=C2=A0=C2=A0=C2=A0T1] CPU: 12 PID: 1 =
Comm: swapper/0 Not tainted 5.3.0-rc4-
> next-20190813 #3
> [=C2=A0=C2=A0=C2=A039.207938][=C2=A0=C2=A0=C2=A0=C2=A0T1] Hardware name: =
HP ProLiant XL420 Gen9/ProLiant XL420
> Gen9, BIOS U19 12/27/2015
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1] Call Trace:
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0dump=
_stack+0x62/0x9a
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0regi=
ster_lock_class+0x95a/0x960
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
platform_driver_probe+0xcd/0x230
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
platform_create_bundle+0xc0/0xe0
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_init+0x4ec/0x578
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? do=
_one_initcall+0xfe/0x45a
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ke=
rnel_init_freeable+0x614/0x6a7
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ke=
rnel_init+0x11/0x138
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? re=
t_from_fork+0x35/0x40
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? is=
_dynamic_key+0xf0/0xf0
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? rw=
lock_bug.part.0+0x60/0x60
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
debug_check_no_obj_freed+0x8e/0x250
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0__lo=
ck_acquire.isra.13+0x5f/0x830
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
debug_check_no_obj_freed+0x152/0x250
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0lock=
_acquire+0x107/0x220
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
pm_relax.part.2+0x21/0xa0
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0_raw=
_spin_lock_irqsave+0x35/0x50
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
pm_relax.part.2+0x21/0xa0
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0__pm=
_relax.part.2+0x21/0xa0
> [=C2=A0=C2=A0=C2=A039.239588][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0wake=
up_source_destroy.part.3+0x18/0x190
> [=C2=A0=C2=A0=C2=A039.239588][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0wake=
up_source_register+0x43/0x50
> [=C2=A0=C2=A0=C2=A039.239588][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0devi=
ce_wakeup_enable+0x76/0x170
> [=C2=A0=C2=A0=C2=A039.239588][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0devi=
ce_set_wakeup_enable+0x13/0x20
> [=C2=A0=C2=A0=C2=A039.239588][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0i80p=
robe+0x921/0xa45
> [=C2=A0=C2=A0=C2=A039.339546][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_toggle_aux+0xeb/0xeb
> [=C2=A0=C2=A0=C2=A039.349486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ke=
rnfs_create_link+0xce/0x100
> [=C2=A0=C2=A0=C2=A039.349486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? sy=
sfs_do_create_link_sd+0x7b/0xe0
> [=C2=A0=C2=A0=C2=A039.349486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ac=
pi_dev_pm_attach+0x31/0xf0
> [=C2=A0=C2=A0=C2=A039.349486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0plat=
form_drv_probe+0x51/0xe0
> [=C2=A0=C2=A0=C2=A039.349486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0real=
ly_probe+0x1a2/0x630
> [=C2=A0=C2=A0=C2=A039.349486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? de=
vice_driver_attach+0xa0/0xa0
> [=C2=A0=C2=A0=C2=A039.349486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0driv=
er_probe_device+0xcd/0x1f0
> [=C2=A0=C2=A0=C2=A039.359562][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? de=
vice_driver_attach+0xa0/0xa0
> [=C2=A0=C2=A0=C2=A039.359562][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0devi=
ce_driver_attach+0x8f/0xa0
> [=C2=A0=C2=A0=C2=A039.359562][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0__dr=
iver_attach+0xc7/0x1a0
> [=C2=A0=C2=A0=C2=A039.359562][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0bus_=
for_each_dev+0xfe/0x160
> [=C2=A0=C2=A0=C2=A039.359562][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? su=
bsys_dev_iter_init+0x80/0x80
> [=C2=A0=C2=A0=C2=A039.359562][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
kasan_check_read+0x11/0x20
> [=C2=A0=C2=A0=C2=A039.359562][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? _r=
aw_spin_unlock+0x27/0x40
> [=C2=A0=C2=A0=C2=A039.369488][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0driv=
er_attach+0x2b/0x30
> [=C2=A0=C2=A0=C2=A039.369488][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0bus_=
add_driver+0x298/0x350
> [=C2=A0=C2=A0=C2=A039.369488][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0driv=
er_register+0xdc/0x1d0
> [=C2=A0=C2=A0=C2=A039.369488][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_toggle_aux+0xeb/0xeb
> [=C2=A0=C2=A0=C2=A039.369488][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0__pl=
atform_driver_probe+0xcd/0x230
> [=C2=A0=C2=A0=C2=A039.3=C2=A0=C2=A0__platform_create_bundle+0xc0/0xe0
> [=C2=A0=C2=A0=C2=A039.769489][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_toggle_aux+0xeb/0xeb
> [=C2=A0=C2=A0=C2=A039.779556][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_probe+0xa45/0xa45
> [=C2=A0=C2=A0=C2=A039.779556][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0i804=
2_init+0x4ec/0x578
> [=C2=A0=C2=A0=C2=A039.779556][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_probe+0xa45/0xa45
> [=C2=A0=C2=A0=C2=A039.779556][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ne=
tdev_run_todo+0x2f/0x4a0
> [=C2=A0=C2=A0=C2=A039.779556][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? qd=
isc_create_dflt+0xf0/0xf0
> [=C2=A0=C2=A0=C2=A039.779556][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ne=
t_olddevs_init+0x67/0x67
> [=C2=A0=C2=A0=C2=A039.779556][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_probe+0xa45/0xa45
> [=C2=A0=C2=A0=C2=A039.789486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0do_o=
ne_initcall+0xfe/0x45a
> [=C2=A0=C2=A0=C2=A039.789486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? in=
itcall_blacklisted+0x150/0x150
> [=C2=A0=C2=A0=C2=A039.789486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
kasan_check_write+0x14/0x20
> [=C2=A0=C2=A0=C2=A039.789486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? up=
_write+0xee/0x2a0
> [=C2=A0=C2=A0=C2=A039.789486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0kern=
el_init_freeable+0x614/0x6a7
> [=C2=A0=C2=A0=C2=A039.789486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? re=
st_init+0x188/0x188
> [=C2=A0=C2=A0=C2=A039.789486][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0kern=
el_init+0x11/0x138
> [=C2=A0=C2=A0=C2=A039.799563][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? re=
st_init+0x188/0x188
> [=C2=A0=C2=A0=C2=A039.799563][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0ret_=
from_fork+0x35/0x40
> [=C2=A0=C2=A0=C2=A039.803412][=C2=A0=C2=A0=C2=A0=C2=A0T1] serio: i8042 AU=
X port at 0x60,0x64 irq 12

Besides the bad error path causing the big stack trace, I think there's
a race between when the serio device is added with device_add() in
serio_add_port() and when i8042_register_ports() calls
device_set_wakeup_enable(). The serio_add_port() function is called from
a workqueue that is schedule to run by i8042_register_ports() calling
serio_register_port(), but otherwise there isn't any guarantee that the
workqueue has actually run by the time the function returns and
i8042_register_ports() calls device_set_wakeup_enable().

This means that the device may not have actually been registered yet,
and thus doing other device like operations on the serio device before
the workqueue runs will lead to weird behavior because the parent device
isn't fully registered with the driver core. That causes the error
message above:

> [=C2=A0=C2=A0=C2=A039.197347][=C2=A0=C2=A0=C2=A0=C2=A0T1] kobject_add_int=
ernal failed for wakeup (error: -2 parent: serio0)

So maybe we need to add another hook after the device is added
successfully so we can do the wakeup things.

I also notice that device_set_wakeup_capable() has a check to see if the
device is registered yet and it skips creating sysfs entries for the
device if it isn't created in sysfs yet. Why? Just so it can be called
before the device is created? I guess the same logic is handled by
dpm_sysfs_add() if the device is registered after calling
device_set_wakeup_*().

There's two approaches I see:

	1) Do a similar check for device_set_wakeup_enable() and skip
	adding the wakeup class until dpm_sysfs_add().

	2) Find each case where this happens and only call wakeup APIs
	on the device after the device is added.

I guess it's better to let devices have wakeup modified on them before
they're registered with the device core?

Here's approach #1
----8<-----
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1b9c281cbe41..27ee00f50bd7 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeup.h>
 #include <linux/atomic.h>
 #include <linux/jiffies.h>
 #include "power.h"
@@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
 		if (rc)
 			goto err_runtime;
 	}
+	if (dev->power.wakeup) {
+		rc =3D wakeup_source_sysfs_add(dev, dev->power.wakeup);
+		if (rc)
+			goto err_wakeup;
+	}
 	if (dev->power.set_latency_tolerance) {
 		rc =3D sysfs_merge_group(&dev->kobj,
 				       &pm_qos_latency_tolerance_attr_group);
 		if (rc)
-			goto err_wakeup;
+			goto err_wakeup_source;
 	}
 	return 0;
=20
+ err_wakeup_source:
+	wakeup_source_sysfs_remove(dev->power.wakeup);
  err_wakeup:
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
  err_runtime:
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f7925820b5ca..5817b51d2b15 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -220,10 +220,12 @@ struct wakeup_source *wakeup_source_register(struct d=
evice *dev,
=20
 	ws =3D wakeup_source_create(name);
 	if (ws) {
-		ret =3D wakeup_source_sysfs_add(dev, ws);
-		if (ret) {
-			wakeup_source_free(ws);
-			return NULL;
+		if (!dev || device_is_registered(dev)) {
+			ret =3D wakeup_source_sysfs_add(dev, ws);
+			if (ret) {
+				wakeup_source_free(ws);
+				return NULL;
+			}
 		}
 		wakeup_source_add(ws);
 	}


And here's the second approach for serio.

---8<----
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index b695094290ab..f12bed00d6d0 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -439,6 +439,24 @@ static int i8042_start(struct serio *serio)
 	return 0;
 }
=20
+static int i8042_added(struct serio *serio)
+{
+	device_set_wakeup_capable(&serio->dev, true);
+
+	/*
+	 * On platforms using suspend-to-idle, allow the keyboard to
+	 * wake up the system from sleep by enabling keyboard wakeups
+	 * by default.  This is consistent with keyboard wakeup
+	 * behavior on many platforms using suspend-to-RAM (ACPI S3)
+	 * by default.
+	 */
+	if (pm_suspend_default_s2idle() &&
+	    serio =3D=3D i8042_ports[I8042_KBD_PORT_NO].serio)
+		device_set_wakeup_enable(&serio->dev, true);
+
+	return 0;
+}
+
 /*
  * i8042_stop() marks serio port as non-existing so i8042_interrupt
  * will not try to send data to the port that is about to go away.
@@ -1312,6 +1330,7 @@ static int __init i8042_create_kbd_port(void)
 	serio->id.type		=3D i8042_direct ? SERIO_8042 : SERIO_8042_XL;
 	serio->write		=3D i8042_dumbkbd ? NULL : i8042_kbd_write;
 	serio->start		=3D i8042_start;
+	serio->added		=3D i8042_added;
 	serio->stop		=3D i8042_stop;
 	serio->close		=3D i8042_port_close;
 	serio->ps2_cmd_mutex	=3D &i8042_mutex;
@@ -1397,17 +1416,6 @@ static void __init i8042_register_ports(void)
 			(unsigned long) I8042_COMMAND_REG,
 			i8042_ports[i].irq);
 		serio_register_port(serio);
-		device_set_wakeup_capable(&serio->dev, true);
-
-		/*
-		 * On platforms using suspend-to-idle, allow the keyboard to
-		 * wake up the system from sleep by enabling keyboard wakeups
-		 * by default.  This is consistent with keyboard wakeup
-		 * behavior on many platforms using suspend-to-RAM (ACPI S3)
-		 * by default.
-		 */
-		if (pm_suspend_default_s2idle() && i =3D=3D I8042_KBD_PORT_NO)
-			device_set_wakeup_enable(&serio->dev, true);
 	}
 }
=20
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 29f491082926..590639467ea3 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -544,6 +544,8 @@ static void serio_add_port(struct serio *serio)
 		dev_err(&serio->dev,
 			"device_add() failed for %s (%s), error: %d\n",
 			serio->phys, serio->name, error);
+	else if (serio->added)
+		serio->added(serio);
 }
=20
 /*
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 6c27d413da92..2e216ba881a9 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -35,6 +35,7 @@ struct serio {
 	int (*open)(struct serio *);
 	void (*close)(struct serio *);
 	int (*start)(struct serio *);
+	int (*added)(struct serio *);
 	void (*stop)(struct serio *);
=20
 	struct serio *parent;
