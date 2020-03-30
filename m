Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3644B19769E
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgC3Ii1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 04:38:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33057 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgC3Ii1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 04:38:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id z14so2567789wmf.0;
        Mon, 30 Mar 2020 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7dT77Mj8SFfgoSadzsoTpTpaeQ7c6h2QTZMTMg5w18=;
        b=QwBMkhl+nqKTSY1XSOzTHAjPupV6mq5wO4yaX4cblyxkTiak2UrTY+Z7Su93Z7aQf0
         x3Vs6FIhR4Y2a6mR0PQUel5wUIrNAGOGHMPBVvpIft7fn61c+cGNrebVDjZdsHrc1wgx
         GDZ3lbzKaGaLqxwbdefO2ZN3TxgY8ZGDyDJn5sC+XWMBiHTIKlHN8SBdK9m23wo8v3rQ
         CiN81B4HqXHILMC0uUOw1z53jHcIiiB8FvxTpkrgl+yBBBcQk7FB2WIhGLZxfpZfHi2q
         qgYgAuRENu31KypW6q27ab/jZzv/JCNRnvHX6jfi4kYHHI4cRQC86qI/jifE3Ia2YEl0
         c7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7dT77Mj8SFfgoSadzsoTpTpaeQ7c6h2QTZMTMg5w18=;
        b=j+Zfx2PcSNq3rAZEAV2bkc9IdU1qFSTRtPbrjpVx36pMy2wCh23/jYfE0h96IuxAeW
         nGdICblpeRHKFP0RxzAA4M8bdWBTs96hE5LTRI84rCj1h9tyhDcURzxCLvCSxlfaeERd
         x+9r7lu0KvGhlaPry0ZceKcmvDrxOUty3i0d29/dmoR0nVhHjXhrWAXf2xp/uyWjpAqi
         BHO9CyCl84Fy4YtmV7RYJsqFWA5euVBIfIrE76glg4tO2cwGDtniqtcou7MpXhmKJwNp
         tmB8kyPvjZeF5a0LJFgYiAIHQbry8auVDpIb1YZZneGLNJevxIcBpF4kVlUsKVe+32QI
         OkMA==
X-Gm-Message-State: ANhLgQ3hZRmH3jWdagvq1CPgU1J6gbNtoy039JJ6k2NtCmosflncua9f
        4FMpVuf/PQUNlCFuOHvvMAuCQtaDZYrapHDcW10=
X-Google-Smtp-Source: ADFU+vuF1lMbuqMXNh6El+A/BD+TdA9UFO6/f3q1PrZ1gEs2kWmu/sTZ17ZP9QJo3REUe7XlcvpwTMeY7D1ca8YEN7A=
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr12576715wmf.118.1585557505217;
 Mon, 30 Mar 2020 01:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200304121943.28989-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20200304121943.28989-1-daniel.baluta@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 30 Mar 2020 11:38:13 +0300
Message-ID: <CAEnQRZDsfSohbkbLd73AjN=2C3C6MTBdKqt84DHXkscjpq9rKQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] Introduce multi PM domains helpers
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        rafael.j.wysocki@intel.com
Cc:     rjw@rjwysocki.net, "Brown, Len" <len.brown@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, khilman@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rafael / Ulf / Aisheng,

Any comments?

On Wed, Mar 4, 2020 at 2:20 PM Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> i.MX8QXP/i.MX8QM has IPs that need multiple power domains to be up
> in order to work. In order to help drivers, we introduce multi PM
> domains helpers that are able to activate/deactivate multi PM domains.
>
> First patch introduces the helpers and second patch demonstrates how
> a driver can use them instead of hardcoding the PM domains handling.
>
> Changes since v1: (addressed Ranjani's comments)
>         - enhanced description for dev_multi_pm_attach return value
>         - renamed exit_unroll_pm label to exit_detach_pm
>
> Daniel Baluta (2):
>   PM / domains: Introduce multi PM domains helpers
>   ASoC: SOF: Use multi PM domains helpers
>
>  drivers/base/power/common.c | 93 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 19 ++++++++
>  sound/soc/sof/imx/imx8.c    | 60 ++++--------------------
>  3 files changed, 121 insertions(+), 51 deletions(-)
>
> --
> 2.17.1
>
