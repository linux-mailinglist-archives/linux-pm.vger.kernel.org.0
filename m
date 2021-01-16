Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69842F8F67
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 22:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAPVRa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 16:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbhAPVRa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 16:17:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91799C061573
        for <linux-pm@vger.kernel.org>; Sat, 16 Jan 2021 13:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xykoqslaO0Cbq5SkheG7stC7FdZ7948Spd6+ldavv40=; b=dZ4tU0XFzKTMfgIgHg/PjNC2sA
        Y2rBhlpqanJy6KEHQgrKOdLQ1zhwi9c9fqDgVz1M0g4jkxrWVtD43/mfrL9dztrv4K/cvk2wuQYkQ
        Ojbl33NDyT+6wzucI0NI4ANmAetPjABaOFEm67/4Y9sq/Dk1vXY3vLJDSlSJG42xkFmS0G7IRmk1z
        m68BmMc5iflm0OS/fbKBXZ7Dh4VB5ZRmZcE9wknPwitl0d8MQCDu2D2zfBB7ECIGF6pnKVpZAX+9B
        nBvFDWzefMdzyif+MYxTSwyROhtgPaY8T5/zLqkytnmneQ7P/emcECSeUlR/Kd7JgOGeLWj9LvUGp
        XvQ6x+0g==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0swA-0006pg-EJ; Sat, 16 Jan 2021 21:16:46 +0000
Subject: Re: 5.4.89: sbs-charger.c:undefined reference to
 __devm_regmap_init_i2c
To:     Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
        nicolassaenzj@gmail.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210116153911.GA22392@fold.natur.cuni.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a7c5bf4c-4bab-07ea-b76b-3b0f54a44620@infradead.org>
Date:   Sat, 16 Jan 2021 13:16:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210116153911.GA22392@fold.natur.cuni.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/16/21 7:39 AM, Martin Mokrejs wrote:
> Hi Julien,
>   probably not your business these days but it seems building your 
> driver fails now in linux-5.4.89 release. Would you mind checking this 
> and contacting the right people?
> 
> ld -m elf_x86_64 -z max-page-size=0x200000 --build-id --strip-debug -o 
> .tmp_vmlinux.kallsyms1 -T ./arch/x86/kernel/vmlinux.lds --whole-archive 
> arch/x86/kernel/head_64.o arch/x86/kernel/head64.o 
> arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirks.o init/built-in.a 
> usr/built-in.a arch/x86/built-in.a kernel/built-in.a certs/built-in.a 
> mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a 
> crypto/built-in.a block/built-in.a lib/built-in.a 
> arch/x86/lib/built-in.a drivers/built-in.a sound/built-in.a 
> arch/x86/pci/built-in.a arch/x86/power/built-in.a 
> arch/x86/video/built-in.a net/built-in.a virt/built-in.a 
> --no-whole-archive --start-group lib/lib.a arch/x86/lib/lib.a 
> --end-group
> ld: drivers/power/supply/sbs-charger.o: in function `sbs_probe':
> sbs-charger.c:(.text+0x1db): undefined reference to 
> `__devm_regmap_init_i2c'

I just sent a patch for this:

https://lore.kernel.org/linux-pm/20210116211310.19232-1-rdunlap@infradead.org/


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
