Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5986602B9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfGEI5P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 04:57:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37595 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfGEI5O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 04:57:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so8382138otp.4
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 01:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcxPK/kMOT0F0xn+8+VtWP5JAQ2HZj3beIBgPmn4QKM=;
        b=VRXP0zviMG8wkSqUO0CZeyyw2Cbx5QaEU5JMJN7D3wQmhGCslvvfWwDXzNF6WiSZQD
         kAUmWKdqVeFt1wfWADBMkWf4rhL8tRKZsMSKVFB8uBjs/PkkM2jef+uE+kJgeF3SaxaX
         tdjZ++M8CCijnG1ms9DLb5t/2pVYLmTXFDWu16OKvk6Wy8JAWETJFCGdlQ4AoX+TVqaL
         6GHn2ZvZEHRYh6bp2t9zt7uJlI6jfzvyQm8iUXMcr1Z6NQdRWWp6z7uda5duo6fSgvkv
         V10e017Fainhtw2XOGAV4L1W12i9pLk0iovQ7jakY5FDPKr5qw/kplxZCR4vJm0e6Rsb
         pL2g==
X-Gm-Message-State: APjAAAVwO0bWODG48xyR0guEhiWH6cGtTv54cKfJpgbgDmX3jxztbmtU
        NzPDeVfWpSTTXNNYDmmO2uicPLWpw0tGf769sos=
X-Google-Smtp-Source: APXvYqzpwBGcpbSOCWMub5uiCi/S0zoNjJiI53mb8iYdeNvjppy2fZ8u22kN7jxRaRxRkvQvZ1ONDQ/IF9oi3d5QBWA=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr1894575oto.118.1562317034008;
 Fri, 05 Jul 2019 01:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jul 2019 10:57:02 +0200
Message-ID: <CAJZ5v0jZEcSpGqeccZwOw6a_QMXKdcx4K2GBeC8P0Vn-9E6vyQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/13] intel_rapl: RAPL abstraction and MMIO RAPL support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 4, 2019 at 6:34 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Besideis MSR interface, RAPL can also be controlled via the MMIO interface,
> by accessing the MCHBar registers exposed by the processor thermal device.
>
> Currently, we only have RAPL MSR interface in Linux kernel, this brings
> problems on some platforms that BIOS performs a low power limits via the
> MMIO interface by default. This results in poor system performance,
> and there is no way for us to change the MMIO MSR setting in Linux.
>
> To fix this, RAPL MMIO interface support is introduced in this patch set.
>
> Patch 1/13 to patch 11/13 abstract the RAPL code, and move all the shared
> code into a separate file, intel_rapl_common.c, so that it can be used
> by both MSR and MMIO interfaces.
> Patch 12/13 introduced RAPL support via MMIO registers, exposed by the
> processor thermal devices.
> Patch 13/13 fixes a module autoloading issue found later.
>
> The patch series has been tested on Dell XPS 9360, a SKL platform.
>
> Note that this patch series are based on the -tip tree, which contains the
> latest RAPL changes for multi-die support.
>
> Changes in V2:
>    - add kerneldoc for struct rapl_if_priv.
>    - use intel_rapl_msr.c for RAPL MSR I/F driver, instead of intel_rapl.c.
>    - changelog and coding style update.

What tree is the series against?

It doesn't apply either on top of my powercap branch or on top of
5.2-rc7 for me.
