Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327B72DAD7D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 13:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgLOMuk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 07:50:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33383 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgLOMub (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 07:50:31 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kp9m1-0005r3-Ph
        for linux-pm@vger.kernel.org; Tue, 15 Dec 2020 12:49:49 +0000
Received: by mail-lf1-f71.google.com with SMTP id h15so10207548lft.20
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 04:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vegz+8PijbmQ0bh5O5W54R6ODTmPDdKWoz3bBiTeMUg=;
        b=E+QdbxRW35dtKaeecAshhKuRa46AiKbncsdGamT/WouU4AiVX/3qkVVhMG6nnxzs7b
         61fVun+KvJlxGSbMypBoBC6A0xseq9JtTnMGhxECiqWzCXG4tKE6rs0YQvyo6TgvcOZU
         HrkjkdMMYEfyOJ68cZ3b+PRWTefRSJxSxVlrTNCYGxoBE7oOGQapcsb1OYlxvo0pdEHL
         NGoHYHl9zb7PJzefbqia3E1HQIF1pfjEJNlUO3k0/BB0+lsMnc2hl9jJ/GkKZZovIGIU
         IFhu8gEvwLnJ73i6Y9Po/5EAAU/zTbEiO76nj7MwMd8YjD4TMnb08i0icSqDizuh+FpD
         WC6A==
X-Gm-Message-State: AOAM532X8zNMv+96nUQakZbQxHMLz1Ni6RE5PLKG22RitBx2RC3GUqf7
        LyB0X+2nDb/GYvbDZejpvX5pTsaAiAlAougTRBkbRfDFrjt+bNSmY+Lv/2I7/QtwZmEhk/oqH4d
        RcvVirPPrkFPhtRoCBZqXcZq2jVAumyACjVVCrlJD9Z67EzAQp+N8
X-Received: by 2002:ac2:561b:: with SMTP id v27mr3208880lfd.425.1608036589232;
        Tue, 15 Dec 2020 04:49:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUuS+LeWsmrnu7qIi5R61k+8mvBc0h+L76/AV97qvw3oJkKqju0w8P/ovhLy0uWQ4cURZEhs8wlH6Ga5pbU60=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr3208876lfd.425.1608036589004;
 Tue, 15 Dec 2020 04:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20201130053640.54608-1-kai.heng.feng@canonical.com> <CACdnJuv_W1q87wUUEBwMgnQLRuv8SzP7OOxjqY29t2tO862m-A@mail.gmail.com>
In-Reply-To: <CACdnJuv_W1q87wUUEBwMgnQLRuv8SzP7OOxjqY29t2tO862m-A@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 15 Dec 2020 20:49:38 +0800
Message-ID: <CAAd53p4Z_yH_t5HS4PnPbSAx-PKd85yqhie2mA0VCvJ-yqKD8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
To:     Matthew Garrett <mjg59@google.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 15, 2020 at 2:22 AM Matthew Garrett <mjg59@google.com> wrote:
>
> On Sun, Nov 29, 2020 at 9:36 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > We are seeing thermal shutdown on Intel based mobile workstations, the
> > shutdown happens during the first trip handle in
> > thermal_zone_device_register():
> > kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
>
> Is the temperature reported by the thermal zone actually correct here?
> 101 C seems extremely excessive.

According to ODM/OEM, it's correct.
It's a short period when Intel Turbo Boost kicks in.

Kai-Heng
