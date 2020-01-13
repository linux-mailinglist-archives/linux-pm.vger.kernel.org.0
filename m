Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC49138CF4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 09:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAMIeI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 03:34:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35425 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgAMIeI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 03:34:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so7708906edv.2;
        Mon, 13 Jan 2020 00:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pwiky2V1HXRMgUMF8ZYenJSpk8xqF9IZsi12qqtxDSo=;
        b=fd5DUeIDDm+CQTs37RXNuHsLos0XQ7KTVgM4m3jBRdz9BG3CjjEvOGam+l/fNpHmEe
         rQXy+DS5Q+saka31qhZmDF16fxtQHpDBdXk5vspxkcdCh+In7ichPQQKK+bvXxaF7oDs
         v16ZKejP86ci/iAGwkn2FQoBaJT0K3U8I4LwRdVtc+Irf+6iCxFdw+KFMKUljKPVvUmv
         xaBmPWMJeKuFstg96LB9Wocd4aPVkrlxDOYDqegrhEt+tjQqsdmfTrF6ygOm3hRVwpG0
         q3w4krAZBXtdGiF0vLO88H0KcxFsJNHPvZSI/j6DaLfzsYmKPjS3XeKPYMZCXGhL2DY5
         IE1w==
X-Gm-Message-State: APjAAAXiMxbt8EnWFI+aHLZBaTdX30VrumHt7BDHbh3X6776V3njcnCV
        ZZBzX7RsN2ZmcaSktv62x6UZzg7sw6Y=
X-Google-Smtp-Source: APXvYqzUQpNNjJExK/G4N7n06llOe2EgioVrrlEkmNYk0/kj7RSvUBziADQn4BpMSCo3rhZmQYBPWA==
X-Received: by 2002:a17:906:66c9:: with SMTP id k9mr12247747ejp.341.1578904445904;
        Mon, 13 Jan 2020 00:34:05 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id m5sm399916ede.10.2020.01.13.00.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:34:05 -0800 (PST)
Date:   Mon, 13 Jan 2020 09:34:03 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] power: supply: max17040: Correct IRQ wake handling
Message-ID: <20200113083403.GA1320@pi3>
References: <CGME20200110100620eucas1p12fff62b485570e93b283e23c7a9e5b57@eucas1p1.samsung.com>
 <20200110100540.27371-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110100540.27371-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 10, 2020 at 11:05:40AM +0100, Marek Szyprowski wrote:
> Don't disable IRQ wake feature without prior enabling it.
> 
> This fixes following warning observed on Exynos3250-based Rinato board:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1288 at kernel/irq/manage.c:724 irq_set_irq_wake+0xfc/0x134
> Unbalanced IRQ 83 wake disable
> Modules linked in:
> CPU: 0 PID: 1288 Comm: rtcwake Not tainted 5.5.0-rc5-next-20200110-00031-g6289fffbb3f5 #7266
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0112e48>] (unwind_backtrace) from [<c010e090>] (show_stack+0x10/0x14)
> [<c010e090>] (show_stack) from [<c0b25b28>] (dump_stack+0xa4/0xd0)
> [<c0b25b28>] (dump_stack) from [<c0128088>] (__warn+0xf4/0x10c)
> [<c0128088>] (__warn) from [<c0128114>] (warn_slowpath_fmt+0x74/0xb8)
> [<c0128114>] (warn_slowpath_fmt) from [<c019e9a0>] (irq_set_irq_wake+0xfc/0x134)
> [<c019e9a0>] (irq_set_irq_wake) from [<c0772708>] (max17040_suspend+0x50/0x58)
> [<c0772708>] (max17040_suspend) from [<c05f55ac>] (dpm_run_callback+0xb4/0x400)
> [<c05f55ac>] (dpm_run_callback) from [<c05f5e38>] (__device_suspend+0x140/0x814)
> [<c05f5e38>] (__device_suspend) from [<c05f9548>] (dpm_suspend+0x16c/0x564)
> [<c05f9548>] (dpm_suspend) from [<c05fa2e4>] (dpm_suspend_start+0x90/0x98)
> [<c05fa2e4>] (dpm_suspend_start) from [<c01977f4>] (suspend_devices_and_enter+0xec/0xc0c)
> [<c01977f4>] (suspend_devices_and_enter) from [<c019862c>] (pm_suspend+0x318/0x3e8)
> [<c019862c>] (pm_suspend) from [<c01963cc>] (state_store+0x68/0xc8)
> [<c01963cc>] (state_store) from [<c03531a4>] (kernfs_fop_write+0x10c/0x220)
> [<c03531a4>] (kernfs_fop_write) from [<c02b44c4>] (__vfs_write+0x2c/0x1c4)
> [<c02b44c4>] (__vfs_write) from [<c02b7288>] (vfs_write+0xa4/0x180)
> [<c02b7288>] (vfs_write) from [<c02b74d0>] (ksys_write+0x58/0xcc)
> [<c02b74d0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> Exception stack(0xd6e83fa8 to 0xd6e83ff0)
> ...
> irq event stamp: 18028
> hardirqs last  enabled at (18027): [<c014b99c>] cancel_delayed_work+0x84/0xf8
> hardirqs last disabled at (18028): [<c0b49b1c>] _raw_spin_lock_irqsave+0x1c/0x58
> softirqs last  enabled at (17876): [<c01026d8>] __do_softirq+0x4f0/0x5e4
> softirqs last disabled at (17869): [<c0130d34>] irq_exit+0x16c/0x170
> ---[ end trace 0728005730004e60 ]---
> 
> Fixes: 2e17ed94de68 ("power: supply: max17040: Add IRQ handler for low SOC alert")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/power/supply/max17040_battery.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

