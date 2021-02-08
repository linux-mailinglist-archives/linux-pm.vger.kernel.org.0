Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F193139D1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhBHQmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 11:42:21 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46606 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhBHQlt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 11:41:49 -0500
Received: by mail-oi1-f181.google.com with SMTP id k25so16204451oik.13;
        Mon, 08 Feb 2021 08:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThLQib0vbE0ELv0+iOCjIn3TgGjZaF25CvVRr6GIWa8=;
        b=MsgG2YV7HrFj8EsRzkJ2sa07SikmjKpmJPYRmhybNP7DUV84E5KzYbKfFnGZ+V+IdT
         iPkYSPoTaXP/pDfjkqcbh/XSoFnnJ21Gdk5MDOUN7XMkX5zFM6gyHEy0HbyTd/ZjWYGy
         D0edG/mbMCE+ofGMguX/mvVAhlKolTiuquEyWh9jTbXDv247O7yzxDdr7g1IUB4iQQUw
         J8BeG6Q6ev72MnlTielHkjJX6GaRLkfpa2HVd9OOil5Is6ylf3/h/BENcwggq0pPz0pg
         n4ZC+mxBzMueS6EQ9UTtdALa7EbGAAZ0ihpbS0XQUOFSzz0sZATceetSEXFnAkO/m0hu
         qnkg==
X-Gm-Message-State: AOAM5325b8Cbc8zkPdt2nIyGblt0lITahGt/rjst11mZwUtNlEmM/ggo
        hdv7nHozYzSrYWzYgz31/Q4oU1gmjf1qdBbVw4k=
X-Google-Smtp-Source: ABdhPJwtL0j0/DDGI/WQfni1MRlfErfRVstv1DaehZlL1UKUwiMqb8f+NvdoWRvTQSjsGi2g31g2A9hlEmgrSVMsA8Q=
X-Received: by 2002:aca:d14:: with SMTP id 20mr12267922oin.157.1612802469189;
 Mon, 08 Feb 2021 08:41:09 -0800 (PST)
MIME-Version: 1.0
References: <b2393aa6-747f-56e0-707a-96bfc54d9a0f@linuxfoundation.org>
In-Reply-To: <b2393aa6-747f-56e0-707a-96bfc54d9a0f@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Feb 2021 17:40:58 +0100
Message-ID: <CAJZ5v0ivhnNs=FdW8hkchTxWHJGZ=M28az1kvU3M5Y4XLXAe3Q@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.12-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Fontenot <nathan.fontenot@amd.com>, rrichter@amd.com,
        Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 8, 2021 at 5:11 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.12-rc1
>
> This cpupower update for Linux 5.12-rc1 consists of:
>
> - Updates to the cpupower command to add support for AMD family 0x19
>    and cleanup the code to remove many of the family checks to make
>    future family updates easier.
>
> - Adding Makefile dependencies for install targets to allow building
>    cpupower in parallel rather than serially.
>
> diff is attached.

Pulled, thanks!
