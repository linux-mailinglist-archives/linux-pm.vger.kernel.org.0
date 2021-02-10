Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAD316451
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhBJKvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 05:51:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37870 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhBJKtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 05:49:35 -0500
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1l9n35-0003Xp-My
        for linux-pm@vger.kernel.org; Wed, 10 Feb 2021 10:48:43 +0000
Received: by mail-ej1-f69.google.com with SMTP id yc4so2284889ejb.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 02:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:organization
         :mime-version;
        bh=fbZODEynTk8KIxFQkGB4RefR0hE1fym2+Xyhrsnzu5A=;
        b=frXQZ//FRpH2bnw8ePaexgvYbthikjRo0CxVwFx5KK7mMCWq/xW3jw/IbNb/UusEn0
         dXjXexeXkgXBG3l7Jix5u8V5XrwXCeDyd2iiNVKrP8zi8oi39Yj+skA89hz60/YOaZ0S
         8Q2ouxBsrMrkooVgX+8pcaa/2m9JbODnS5iOUzcGMZM3lu77567wfygDtDPiTg8q/yip
         4BzIMKgdKRqGQsYfJEQ8KKxvj41HyH7LQ+f+hdbanfhZAe3d3bgxWq4OcwpXVwzQFSPO
         YtGP6Mq/za+om26VGzW+2ubXZTYXY/sUc3DrYDQT1/rc+JncWitRw0o7ZbZGSWAQhdHU
         3B1w==
X-Gm-Message-State: AOAM531YNpjXZC/1Gw+Vsppg18cEtX5/ZwPjDn5+c+Be8KNEqFCKbJbO
        IqiN3IdBBqa3UwYP9ouf/f4Ucfgp8wT39DO3zb33jGCZTp+JPnMd8RVSlpHdwWNtMjUb+TbD3LM
        G3h+0LPgMeDEu4dX1eiZFR88UnBELVhz163om
X-Received: by 2002:a17:906:d0c3:: with SMTP id bq3mr2290839ejb.424.1612954123422;
        Wed, 10 Feb 2021 02:48:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9NF6hS2YW4fND0UJVdN+X6/DxWiZF+y7SJqfqwpg6oWblzfPBC5lxW34Eqe1Xqhgbb15VeA==
X-Received: by 2002:a17:906:d0c3:: with SMTP id bq3mr2290824ejb.424.1612954123154;
        Wed, 10 Feb 2021 02:48:43 -0800 (PST)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v1sm878642ejd.3.2021.02.10.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 02:48:42 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Wed, 10 Feb 2021 11:48:29 +0100
To:     stefan.wahren@i2se.com, nsaenzjulienne@suse.de
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: bcm2711_thermal: Kernel panic - not syncing: Asynchronous SError
 Interrupt
Message-ID: <20210210114829.2915de78@gollum>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uv0BMDlp0lj2jnv1M84PBY8";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/Uv0BMDlp0lj2jnv1M84PBY8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Trying to dump the BCM2711 registers kills the kernel:

# cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
0-efc
# cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers=20

[   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError
[   62.857671] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
[   62.857674] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
[   62.857676] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=3D--)
[   62.857679] pc : regmap_mmio_read32le+0x1c/0x34
[   62.857681] lr : regmap_mmio_read+0x50/0x80
[   62.857682] sp : ffff8000105c3c00
[   62.857685] x29: ffff8000105c3c00 x28: 0000000000000014=20
[   62.857694] x27: 0000000000000014 x26: ffffd2ea1c2060b0=20
[   62.857699] x25: ffff4e34408ecc00 x24: 0000000000000efc=20
[   62.857704] x23: ffff8000105c3e20 x22: ffff8000105c3d3c=20
[   62.857710] x21: ffff8000105c3d3c x20: 0000000000000014=20
[   62.857715] x19: ffff4e344037a900 x18: 0000000000000020=20
[   62.857720] x17: 0000000000000000 x16: 0000000000000000=20
[   62.857725] x15: ffff4e3447ac40f0 x14: 0000000000000003=20
[   62.857730] x13: ffff4e34422c0000 x12: ffff4e34422a0046=20
[   62.857735] x11: ffffd2ea1c8765e0 x10: 0000000000000000=20
[   62.857741] x9 : ffffd2ea1b9495a0 x8 : ffff4e34429ef980=20
[   62.857746] x7 : 000000000000000f x6 : ffff4e34422a004b=20
[   62.857751] x5 : 00000000fffffff9 x4 : 0000000000000000=20
[   62.857757] x3 : ffffd2ea1b949550 x2 : ffffd2ea1b949330=20
[   62.857761] x1 : 0000000000000014 x0 : 0000000000000000=20
[   62.857767] Kernel panic - not syncing: Asynchronous SError Interrupt
[   62.857770] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
[   62.857773] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
[   62.857775] Call trace:
[   62.857777]  dump_backtrace+0x0/0x1e0
[   62.857778]  show_stack+0x24/0x70
[   62.857780]  dump_stack+0xd0/0x12c
[   62.857782]  panic+0x168/0x370
[   62.857783]  nmi_panic+0x98/0xa0
[   62.857786]  arm64_serror_panic+0x8c/0x98
[   62.857787]  do_serror+0x3c/0x6c
[   62.857789]  el1_error+0x78/0xf0
[   62.857791]  regmap_mmio_read32le+0x1c/0x34
[   62.857793]  _regmap_bus_reg_read+0x24/0x30
[   62.857795]  _regmap_read+0x6c/0x17c
[   62.857797]  regmap_read+0x58/0x84
[   62.857799]  regmap_read_debugfs+0x138/0x3f4
[   62.857801]  regmap_map_read_file+0x34/0x40
[   62.857803]  full_proxy_read+0x6c/0xc0
[   62.857805]  vfs_read+0xb8/0x1e4
[   62.857807]  ksys_read+0x78/0x10c
[   62.857809]  __arm64_sys_read+0x28/0x34
[   62.857811]  el0_svc_common.constprop.0+0x7c/0x194
[   62.857813]  do_el0_svc+0x30/0x9c
[   62.857814]  el0_svc+0x20/0x30
[   62.857816]  el0_sync_handler+0x1a4/0x1b0
[   62.857818]  el0_sync+0x174/0x180
[   62.857842] SMP: stopping secondary CPUs
[   62.857845] Kernel Offset: 0x52ea0b080000 from 0xffff800010000000
[   62.857847] PHYS_OFFSET: 0xffffb1cc00000000
[   62.857849] CPU features: 0x00240022,61806000
[   62.857851] Memory Limit: none

Sprinkling printks around regmap_read [1] shows that reading from 0x14 (20)
seems to cause the issue:


[   40.456230] map=3Dffff020a069c9c00, from=3D0, to=3D3836, count=3D131072
[   40.462520] map=3Dffff020a069c9c00, i=3D0
[   40.466319] ret=3D0, val=3D0
[   40.468922] map=3Dffff020a069c9c00, i=3D4
[   40.472684] ret=3D0, val=3D0
[   40.475292] map=3Dffff020a069c9c00, i=3D8
[   40.479048] ret=3D0, val=3D0
[   40.481649] map=3Dffff020a069c9c00, i=3D12
[   40.485492] ret=3D0, val=3D0
[   40.488080] map=3Dffff020a069c9c00, i=3D16
[   40.491922] ret=3D0, val=3D0
[   40.494523] map=3Dffff020a069c9c00, i=3D20
[   40.498497] SError Interrupt on CPU0, code 0xbf000002 -- SError
[   40.498499] CPU: 0 PID: 486 Comm: cat Not tainted 5.11.0-rc7+ #8
[   40.498501] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)


...Juerg

[1]
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/reg=
map-debugfs.c
index ff2ee87987c7..9465f5a2f3b8 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -229,6 +229,7 @@ static ssize_t regmap_read_debugfs(struct regmap *map, =
unsigned int from,
        if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
                count =3D PAGE_SIZE << (MAX_ORDER - 1);
=20
+       printk("map=3D%px, from=3D%d, to=3D%d, count=3D%ld\n", map, from, t=
o, count);
        buf =3D kmalloc(count, GFP_KERNEL);
        if (!buf)
                return -ENOMEM;
@@ -253,7 +254,9 @@ static ssize_t regmap_read_debugfs(struct regmap *map, =
unsigned int from,
                        buf_pos +=3D map->debugfs_reg_len + 2;
=20
                        /* Format the value, write all X if we can't read */
+                       printk("map=3D%px, i=3D%d\n", map, i);
                        ret =3D regmap_read(map, i, &val);
+                       printk("ret=3D%ld, val=3D%x\n", ret, val);
                        if (ret =3D=3D 0)
                                snprintf(buf + buf_pos, count - buf_pos,
                                         "%.*x", map->debugfs_val_len, val);


--Sig_/Uv0BMDlp0lj2jnv1M84PBY8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmAjuf0ACgkQD9OLCQum
Qrch+g//dS9eU3X3FHOYgZoRvUdTOkyCVKh7XsMdI8vt97nSVhuXVulSSFblU67d
VXm2C/vo0D8xN2XEPZ7RWVriiE+tLpD4L3R+dIuCF1PvgapIdJ0k+6zzemu/f7KW
TEwgB/Z6KDLkjoAY5+Wana8ZgmfNgeFgBAJAOe64GnKABpOPg6fx/2LX4L5ntYSx
h5o7BYBft+S9VEef7qLLmAYvtESB8CYr88lBlqTosUYoX517ScghZpxigEc+0QtY
JOQups6w/wwUoI/CdJvLprF5JcqEUipih75RslniKnmU6vBJJt1gwyoKry6teYnb
igir9mwnsh3NCt9EHqCRkwXz9Kvn2amE9vQLiqXVpydY34bXdzBzjVz87W9tEL8z
nvjqu36Quw7PFoql4uqWKzLRetrK4n0qSMSddXg7yLvVJraFcEZqm8OV7bgZBPIF
NmXIBEFtFLzahXzjvMO50baK7512A7wjUFYuP6qeKwgbHrWrlgtXRThtCifcRqBk
BGQb4i6PEl8WBiBIMaLP4Zlc0kxazAY7tGfoi5wjZqAmQLwZm0/KPCbKEOvxa+Mh
vEleG56bYOV8M1SrQQONhKQLqCJAKDWYBV9bUrCAbuDgSnLhQ8+F8II+qSyirVRG
kqQE7FgV1IAg7r9Oj6nI58/hkkRVO7BZ/Zy4LX5YSsgTYfCQjjM=
=Jlzp
-----END PGP SIGNATURE-----

--Sig_/Uv0BMDlp0lj2jnv1M84PBY8--
