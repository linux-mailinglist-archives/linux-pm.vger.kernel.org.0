Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3731314643
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 03:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBIC2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 21:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhBIC2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 21:28:41 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A6BC061786;
        Mon,  8 Feb 2021 18:28:01 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e7so2574825pge.0;
        Mon, 08 Feb 2021 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=lbXXGILd1TIrkuL+FKr1OCl2sQEyrFA8+5F6sGFMLLs=;
        b=dCI6lop8uxbg37X9VxQYFkk33y+EvRnJfLwG/VbJh8bpH7A9q4DvKjk3P4OjtN5aIe
         HJ+QLIMm5NnI15UYvHReH6RoqC4N8fjKycGtACqd/D/x1hHu0XRfdlhfVEtp7mh6KmFC
         TeA1fsofxrsnouUWPHK9rKr6n8RLwROyHwxQmngMvIhcPiDZ8LKC0zbe+AHtXDbmffy+
         SMAStjCoeSjhEDMWVpA28WCD5zUd+fAUhWU+W0SWEG9E52LUEI8wd0y62dw69uaQ5yZF
         51EkjpDGMsC9iBkFgYjfzauXUz2SsaSTLTVdEaE0AiPwD1LLKIw5VL5ww4oKiIOmEaAP
         COFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=lbXXGILd1TIrkuL+FKr1OCl2sQEyrFA8+5F6sGFMLLs=;
        b=k2BvfpR40/6/98zE5SvNJSivbTj07yJsmXwWDE9ro+xm6V2u+ntpLnzwUyd4UHMM40
         0/G1RkbheM6VvQ5ud8gfmtDDvqlsplLLDPabXfS40FnxcCpRGizv6VMOSvYu21yK3aL0
         AGCwbWv1AxXUX2lfdi9hZitVP1tl2xVBtIhbrvOhcbrcHVyd9IVDImEeaNd6vdZR44EE
         qlG5SKqfbzrZgsxN40DpYs7hPjavR8meFv7+XQp4N7GVXdT3MWwTw7JqY9Fkjdzz4o3i
         +zYaGFSWDIT81SQ3zmx/c+Ex5hwq+rekA95Vyii/Jw2WSjFSLVw3Hh/KisrTUZK8c2X0
         5VfA==
X-Gm-Message-State: AOAM533KhlnMdz/I9k0LYHrMVvhiZWqTuRpoR1RkKNS379c9c8wIPfUx
        heoPBkc3rN5YOnMoNR0zTCc=
X-Google-Smtp-Source: ABdhPJwpXrlcE/SUbrdqr/90w1vB/va499IHn0SHPAbjpdPntg+FhljbUSGL2yz6svdv+NxJ0MdkTw==
X-Received: by 2002:a63:bc02:: with SMTP id q2mr19964285pge.198.1612837680557;
        Mon, 08 Feb 2021 18:28:00 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id f3sm18613585pfe.25.2021.02.08.18.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:27:59 -0800 (PST)
Date:   Tue, 9 Feb 2021 11:27:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 2/2] thermal: Move therm_throt there from x86/mce
Message-ID: <YCHzLQewQIylgyUj@jagdpanzerIV.localdomain>
Reply-To: 20210125130533.19938-3-bp@alien8.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Seems that the patch triggers some WARNs on my laptop.

For every CPU:

[    0.003751] WARNING: CPU: 4 PID: 0 at arch/x86/kernel/irq.c:390 thermal_set_handler+0x12/0x25
[    0.003751] Modules linked in:
[    0.003751] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W         5.11.0-rc6-next-20210208-00003-g3ba4c4f662ad-dirty #1928
[    0.003751] RIP: 0010:thermal_set_handler+0x12/0x25
[    0.003751] RSP: 0000:ffffb5f0c00c7ed8 EFLAGS: 00010097
[    0.003751] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00000000000001b2
[    0.003751] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff98410d00
[    0.003751] RBP: ffff9e3c5fb11460 R08: 0000000000000000 R09: 000000000003007f
[    0.003751] R10: ffff9e3c5fb11480 R11: 0000000000000000 R12: 0000000000000428
[    0.003751] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.003751] FS:  0000000000000000(0000) GS:ffff9e3c5fb00000(0000) knlGS:0000000000000000
[    0.003751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.003751] CR2: 0000000000000000 CR3: 000000039ee0a001 CR4: 00000000001706a0
[    0.003751] Call Trace:
[    0.003751]  intel_init_thermal+0x16d/0x1c7
[    0.003751]  identify_cpu+0x249/0x329
[    0.003751]  identify_secondary_cpu+0x15/0x8c
[    0.003751]  smp_store_cpu_info+0x3f/0x48
[    0.003751]  start_secondary+0x42/0xfd
[    0.003751]  secondary_startup_64_no_verify+0xb0/0xbb

	-ss
