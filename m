Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D477A2CA84E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgLAQbB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 11:31:01 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:44507 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLAQbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 11:31:00 -0500
Received: by mail-oo1-f48.google.com with SMTP id i13so532238oou.11;
        Tue, 01 Dec 2020 08:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp8iWWWHPT2Pl4u80hu8E2e1qsXynxOIhIpt5M0kvuw=;
        b=cSlqyU/2MjAR0HHoceOcAL2l5ppCqiOySiaqXY8CKgnchohx3o2MGFW1MqOUZep/pq
         jg2nVJ1zzU5+gqXST6djCVtPxIEYCM9S9FJiEJlXRis6PGd5AYLAI7yUyv//jeArc9Yy
         7MlTL68iMdROZes9jnRJ6DIEviP1224hTyIh9lBxMUzL33igRN3JJvJIzsMjvtIUAVzR
         z6k6+IBKuAD0ZG6npNhikkOncV9pDSfSexF9Y4EAMaJ/CcXuvnXv5Mk5u4bqzF7Ay0S/
         HDdgv65HNdMRTfec8SVMQbXzEaxEUBaHV7eEQT1vvwS0CFr08dpAiUl2szF8s4cQMYEf
         FRZQ==
X-Gm-Message-State: AOAM531AO9gVdcC/tHLJqTHbCCbd4D/uM0Z2h2jJ9yPRZGDT7xOkoET7
        Ilaq0A4zrdMAyVaQT4hInwGUgw4f580vgm4CuzU=
X-Google-Smtp-Source: ABdhPJxhsM5gRQOWgBECZTVf5/IPMk1HzG+wAoXHRZQf31qtr6foTaaOmxOFobYWLnpvjGDt7j3u210Bl3hjzhq+Tcc=
X-Received: by 2002:a4a:bb07:: with SMTP id f7mr2444634oop.44.1606840214306;
 Tue, 01 Dec 2020 08:30:14 -0800 (PST)
MIME-Version: 1.0
References: <a3689b5f-2835-066c-dcb5-6103a0e09f89@linuxfoundation.org>
In-Reply-To: <a3689b5f-2835-066c-dcb5-6103a0e09f89@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Dec 2020 17:30:03 +0100
Message-ID: <CAJZ5v0j-ytbMfmq+6Y=0aOdKi2B4a-JCbOvdO=ujG0MOTphwEA@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.11-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 10:47 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.11-rc1.
>
> This cpupower update for Linux 5.11-rc1 consists of a change to provide
> online and offline CPU information. This change makes it easier to keep
> track of offline cpus whose cpuidle or cpufreq property aren't changed
> when updates are made to online cpus.

Pulled, thanks!

> Please note that there is a conflict in
>
> tools/power/cpupower/utils/helpers/misc.c
>
> between commit:
>
>    748f0d70087c ("cpupower: Provide online and offline CPU information")
>
> from the cpupower tree and commit:
>
>    8113ab20e850 ("tools/power/cpupower: Read energy_perf_bias from sysfs")
>
> from the tip tree.
>
> Stephen fixed it up and can carry the fix. Hope this works.

Thanks for the notice!

The conflict will now move to the PM tree merges I suppose.
