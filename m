Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA13EDB3E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhHPQve (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:51:34 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44741 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhHPQvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:51:33 -0400
Received: by mail-oi1-f174.google.com with SMTP id w6so27508017oiv.11;
        Mon, 16 Aug 2021 09:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQ0idBXXtrFco3xaPvnnCXSKmRuX4CohDur19kAJhIg=;
        b=LEh80OXgK7QCi4teG/1ENC9BdGz1am0yu+Mcbut8B7NsVF9eOPUjhZTemqSGMDxaL/
         tDO26lgoGmoi/5Gm0F6e3UQ2SbDq454grCGNsGpnpShhmdOGgFjc7IStgOiW5uihz7tD
         GXrLT7oA3W5U7NL+ZhUsEQmIgUAfOKhFQ0RubWAsHAJ2MG44qW26FdkNwg0huDjZq85Q
         lxqWofdR3IdNF4HiwQ6Pm/4tZyCda59uMxVw4IjPA/JUmHJI7rQ5Fb0QoF7FGb654B1d
         x4XKSDrxGSrx3s4IeBrkyYOS46BGn5hj+AZ4CMy1x8IwtREhW3QUrnFgqG8XsoUXlWvD
         +y/g==
X-Gm-Message-State: AOAM531HmE/2+XDxtw/Z4JttVnTOoV36nsn1m+EbJv9wvdC47nGJxL9x
        rgx6YtAruasNUAkpFLirPcQjZKdvfmdlXKFdqqE=
X-Google-Smtp-Source: ABdhPJx3ege31T3c9rfsXiS7wA/hfK5M/UZh2WntN6a6vxSZsSsyiMPYBPmIAI5VKar8QrJc6nPFrcb1/zmyEQC7Zbw=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr32893ois.69.1629132661639;
 Mon, 16 Aug 2021 09:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210810014442.7446-1-rdunlap@infradead.org>
In-Reply-To: <20210810014442.7446-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 18:50:50 +0200
Message-ID: <CAJZ5v0gVpmf3_73f0X6yEWA+vkP2LGjdmU+c6AtofAm_tiEXqg@mail.gmail.com>
Subject: Re: [PATCH] kernel/power: unmark 'state' functions as kernel-doc
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 10, 2021 at 3:44 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix kernel-doc warnings in kernel/power/main.c by unmarking the
> comment block as kernel-doc notation. This eliminates the following
> kernel-doc warnings:
>
> kernel/power/main.c:593: warning: expecting prototype for state(). Prototype was for state_show() instead
> kernel/power/main.c:593: warning: Function parameter or member 'kobj' not described in 'state_show'
> kernel/power/main.c:593: warning: Function parameter or member 'attr' not described in 'state_show'
> kernel/power/main.c:593: warning: Function parameter or member 'buf' not described in 'state_show'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/power/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20210809.orig/kernel/power/main.c
> +++ linux-next-20210809/kernel/power/main.c
> @@ -577,7 +577,7 @@ static inline void pm_print_times_init(v
>
>  struct kobject *power_kobj;
>
> -/**
> +/*
>   * state - control system sleep states.
>   *
>   * show() returns available sleep state labels, which may be "mem", "standby",

Applied as 5.15 material, thanks!
