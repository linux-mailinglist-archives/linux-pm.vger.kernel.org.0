Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD82ABE71
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgKIOSP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 9 Nov 2020 09:18:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36606 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIOSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 09:18:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so9045669otm.3;
        Mon, 09 Nov 2020 06:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VPDRH1c3QIWZAvuOlt82daB4gdbQvXFejkuuDmKSKgE=;
        b=U3OWKMTCLXb2nzcRDeON06qLOyyXL0QWQBbeoep9YJJ1OEtVPi+f1yi8HBxCiMWCvh
         p3+LHGH6miKdmyr8lcREr+qRzQXJUH8ao9U76q/ahwtCSzenTVI4eaUJC2tfKvSJizxw
         Azd5IuDvNnbo5hKgO9jNetlpbqtr2FD/6P0FB9dI+IRTmMG8KKf4K8T5vgU01OZB6h/L
         ROg7T/QG7Y1FZV8JkbxXV7fQ/99Ytfo6ueQHno09WdFtLtLQF1QSx6sC6NXssMIabh3N
         LYmU5Z0Alz++QAN1+zqR788ocv+Zx8U/xzJDUlaffa/ScA8ICm6ZH5O7p2h6BID/OMYM
         kkTg==
X-Gm-Message-State: AOAM532P8qbmT3Qm06iN1FmatxjolXgYfyx3ozsj8OZbQxjaRwStCsNe
        ku9XIulW8NgjNq7kPWvtR/FUd3m+d66pbnC4k/M=
X-Google-Smtp-Source: ABdhPJwQU/OV8+ocELllAUlHF8+PDa5M7twEyVegLfZDobgJr59vN4RrllLBHCXrI44X+weTf3h7GXgCz7mpKj2XNfg=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr11184607otu.206.1604931493992;
 Mon, 09 Nov 2020 06:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20201103151139.29690-1-pali@kernel.org>
In-Reply-To: <20201103151139.29690-1-pali@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Nov 2020 15:18:03 +0100
Message-ID: <CAJZ5v0gxRHUt7dij7zFomXxmCEPVxiTEv+qu8kZESbsE3A+bBQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] cpufreq: Add missing modalias for tristate drivers
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 3, 2020 at 4:14 PM Pali Rohár <pali@kernel.org> wrote:
>
> Some of cpufreq drivers are tristate, can be compiled as modules, but do
> not have defined modalias for automatic loading. This patch series add
> for all those cpufreq drivers missing MODULE_DEVICE_TABLE macro, based
> on OF definitions, or MODULE_ALIAS for platform drivers.
>
> MODULE_DEVICE_TABLE is not explictily added only for speedstep-centrino,
> speedstep-ich and speedstep-smi drivers as it was removed in commit
> b11d77fa300d9 ("cpufreq: Convert to new X86 CPU match macros").
>
> Pali Rohár (9):
>   cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
>   cpufreq: highbank: Add missing MODULE_DEVICE_TABLE
>   cpufreq: mediatek: Add missing MODULE_DEVICE_TABLE
>   cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
>   cpufreq: st: Add missing MODULE_DEVICE_TABLE
>   cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
>   cpufreq: loongson1: Add missing MODULE_ALIAS
>   cpufreq: scpi: Add missing MODULE_ALIAS
>   cpufreq: vexpress-spc: Add missing MODULE_ALIAS
>
>  drivers/cpufreq/armada-8k-cpufreq.c    | 6 ++++++
>  drivers/cpufreq/highbank-cpufreq.c     | 7 +++++++
>  drivers/cpufreq/loongson1-cpufreq.c    | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c     | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 +
>  drivers/cpufreq/scpi-cpufreq.c         | 1 +
>  drivers/cpufreq/sti-cpufreq.c          | 7 +++++++
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 1 +
>  9 files changed, 26 insertions(+)
>
> --

Viresh, any comments?
