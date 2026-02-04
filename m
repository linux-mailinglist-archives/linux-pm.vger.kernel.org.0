Return-Path: <linux-pm+bounces-42041-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIKeDtL7gmm6gAMAu9opvQ
	(envelope-from <linux-pm+bounces-42041-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 08:57:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F1E2DD1
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 08:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CDBE302BA5E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060838F251;
	Wed,  4 Feb 2026 07:56:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68B38F249
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191813; cv=none; b=AxhM0/OlR5wSf4Nltq0uzOGiyJSqg+h7h1D+2F+vG28vjmIbvQUkriEefex+Rwa+zzWczRjUg+a5n9XdwdZ7bkadvDjfpY/d7mRTWWmg8ktcapXSQguwbwR2WkHBNlCS6LChjlFK4wML7u2e47AhSThpxCkmUsEFegaFbHCSRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191813; c=relaxed/simple;
	bh=Bo7ME9ToS5tPp5uXCO48/XFese+VeUE1U4BmF1HgIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chWlnNENRYfxnKovbvE/v59CYTawd8O/tqU7hZEA5V3B4Spyf1fh00HCD67eVj3dn20UckG/59qGMUGv6M2Wg8E0dOY6jB0e98UhZlQgveLbPJNn9piGotufDuTuJXLNsOJ5/ursb7TAbp3MWv9l0XfBNPwA9HhhDfsovKm0Ses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5f524301a76so452328137.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 23:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191812; x=1770796612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXGWtBpUTgth/iKHPt+hkEg/14yqbliQ+nz6kMcrt74=;
        b=S9eClN2ugdSXJcRqzRkkcf8OhL4HMxIovkNtEQ3enbhViUBLtmLGSpGdbzPIDRqNcD
         pYAstS9sdDM7gfh+1i9nnXCs9MHlnb5MTs/88iaW23fvsie705uc6i6Aa69MgmxuILLk
         ojA23V55+AFUklgBpFhq6RXTKWTq8zA/mwa7/ADgoEWrhw3s8G73b+hngQhYGaRW8+2k
         2vP/xrHFvDkPQR5K7gjkLOrzZ8qHZ0rGTCe+pUQxU1TLqySUXSzENOifoaIJCwGAJrKC
         alQYxdNOSTrskMQ+rue9BBoVtLySMzEX77POkHUx0VmsgpF356/W4FBhHBRutCQebQkf
         KwVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuvRxLx2uUqIdd26dPgRVX1UU1Qba3yAeoudZis+iBGcxWWdtUIGTvPdGe95wD1S07wwcLo/lhfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaEA6ZjRLxF0WUDm2hnsQlzwUfCJF/QDT2JJPFvp7bF6fC8Fd
	nOVt/PyjI+qVwrVEsqCDoAGMhuLFedpcmD5Z1hG6vX82nG9wcAAKDP0beeQdRgXoR38=
X-Gm-Gg: AZuq6aIoVn1BK2Z09cMvV6hYkTl3UUM6C8wCHPkFGGNOL0qKtSocXCwKH09+6EGxsRs
	MWfofP6KLAOfPUkEIMuQyrAd/n4gqt716HucPF/hljMup+IDCDqBaH9+qGyBlC0yj3+OFCRqZ+T
	vZXMtd3/Fg1KBNHXzYUhsmTagptFSN4IvY9kxa+znYu9/KqvP23SczSNpiSSRadu2xZ4QF1zHHR
	RdzcFjPlKM3Wqvr0vkO1QjeoE7I8L2mVSroWD5a+8nXG+wYHDQNnC1mYaINaJMy8TPZXRYnfL3v
	TRxViBPlhxXUwhHuYltwkkDeJEqsZ7KIeTLhyPa06z6wewd26lLR6iXys6AynnpGFTNuHEBY8u3
	UtyGASkQvL7aeP57y9yzqx4LdBM29HNyU0nDu+LMRiYAG+LwXhbPJDBf5NwzUpBogqd3o5JGNk8
	udEFym/CYtsfy8Cue9h2jTTCwVmO2qDWjDVdC7+NzhNckcTG8W
X-Received: by 2002:a05:6102:d8a:b0:5f8:e53a:2d81 with SMTP id ada2fe7eead31-5f92a0184b7mr1966449137.8.1770191812582;
        Tue, 03 Feb 2026 23:56:52 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948dfe6e174sm580232241.4.2026.02.03.23.56.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 23:56:51 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5f5418c40daso657468137.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 23:56:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkdkrY3Sj8ThXbkQBX6uMlUJT4JqeE5lvM5a6OAqSSS7yZQyunT0Os24tugGntjONmh3IGpisTEw==@vger.kernel.org
X-Received: by 2002:a05:6102:3f10:b0:5ef:b32c:dff8 with SMTP id
 ada2fe7eead31-5f929fb3cf1mr2280613137.5.1770191811365; Tue, 03 Feb 2026
 23:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203170824.2968045-1-visitorckw@gmail.com>
In-Reply-To: <20260203170824.2968045-1-visitorckw@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Feb 2026 08:56:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com>
X-Gm-Features: AZwV_QiZ43YMMxxlNYjUnXgr3m8Z6Sx77aM5dfYmM2j6flED7-BvFG_oafzMSL8
Message-ID: <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add QEMU virt-ctrl driver and update m68k virt
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: sre@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	daniel@0x0f.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org, 
	Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ccns.ncku.edu.tw,gmail.com,0x0f.com,vger.kernel.org,lists.linux-m68k.org,vivier.eu];
	TAGGED_FROM(0.00)[bounces-42041-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D00F1E2DD1
X-Rspamd-Action: no action

CC vivier

On Tue, 3 Feb 2026 at 18:08, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Introduce a generic platform driver for the QEMU 'virt-ctrl' device [1]
> and transitions the m68k 'virt' machine to use it, replacing
> architecture-specific hooks.
>
> The new driver ('qemu-virt-ctrl') registers a restart handler and
> populates the global 'pm_power_off' callback.
>
> On the m68k side, the platform initialization is updated to register
> the 'qemu-virt-ctrl' platform device. Additionally, the 'mach_reset'
> hook is bridged to 'do_kernel_restart()' to ensure the kernel's restart
> handler chain is correctly invoked.
>
> Verified on QEMU m68k virt. Both system reset and power-off were
> confirmed functional by invoking 'reboot(LINUX_REBOOT_CMD_RESTART)' and
> 'reboot(LINUX_REBOOT_CMD_POWER_OFF)' from userspace.
>
> Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
> ---
> Changes in v2:
> - Use devm_register_sys_off_handler() instead of register_restart_handler()
>   and global pm_power_off.
> - Switch Kconfig to tristate to support modular build.
> - Add .id_table to platform_driver and use MODULE_DEVICE_TABLE() to correct
>   module auto-loading.
>
> v1: https://lore.kernel.org/lkml/20260112182258.1851769-1-visitorckw@gmail.com/
>
> Kuan-Wei Chiu (2):
>   power: reset: Add QEMU virt-ctrl driver
>   m68k: virt: Switch to qemu-virt-ctrl driver
>
>  MAINTAINERS                          |  6 ++
>  arch/m68k/virt/config.c              | 42 +------------
>  arch/m68k/virt/platform.c            | 20 ++++++-
>  drivers/power/reset/Kconfig          | 10 ++++
>  drivers/power/reset/Makefile         |  1 +
>  drivers/power/reset/qemu-virt-ctrl.c | 89 ++++++++++++++++++++++++++++
>  6 files changed, 124 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/power/reset/qemu-virt-ctrl.c
>
> --
> 2.53.0.rc1.225.gd81095ad13-goog

