Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96433347AEB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhCXOjq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbhCXOjh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 10:39:37 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BEC0613DE
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 07:39:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n198so21741309iod.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omwS5puHKjv17pejHb5i9USkJJrZLYB9ETUsyowGcHo=;
        b=L/zTmISKkPm4Bb8Zkz4hwGV9sdssGr2Fgi5D8wpbJMWJtrWdC+gTJCS9fZpsh1in1+
         wyzsjiYY1QuChIqAyEZI+fo2geyk4/Tn8TohZZ2W+LSh/CdmgtZVagTv0j0E4bjg9P0K
         Vup7OM0afjZgAcOZh5YBZiSDSi74G+2KdsJT2Yrt0ruc21A0ybA+V/7ekMdjTXMPneYO
         azIOAZp2YDdCQIBIS6kBXxsK0QRk0te0OTgj4Zkhg6wYK5WsqXNTT6zbGRz8mWwrh8JM
         NXj6jI+WIYRDAreFfy2WR0KNfD3GkJ1Ca86UrKD5SjX5zwVlHbJMKCXW6SxsyOTi397S
         bsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omwS5puHKjv17pejHb5i9USkJJrZLYB9ETUsyowGcHo=;
        b=dt2aPL0tKljQRGwOil5dgoN+Jek7JhLuJlN+H+86uioTLJsSCmvbzo13eSknOBYzlH
         w+6y/v7aX1D+UhxN7azFW/THoD92u9XHV+rG+z7XQ2OwOtpbzjkAPHSREWjbIcNpacO3
         zNDng1FVEkzRJHI/w3igYhRmueTli933DGpUXQ+NH5Y9l6junDgwrD+zETxesI7OQIpP
         xdcXT/BpnBC3iX4HKtlmben6EhYChaqahC1kEmEPF4BKoHkGq0EhkMwcueibnqHtRWTR
         MGbMW4vFyOVkn9Tyeh1B+arGjDq7AtJTfjwWjyH7JpNkHcbUfHrF7Bnw2rhqR8KdJxqx
         oKeQ==
X-Gm-Message-State: AOAM533qCRp4ee244co8Ue2kSrwbNYXe62cQqkum7tK1SWNK1qNQM/Y2
        gRQjvCXsFqM+xW4QtGDzk5FrH1tTvS7M3DGN0SSe5A==
X-Google-Smtp-Source: ABdhPJyTsVk1YCFajPZcgUTfkypi6NhdFvf0Emaq+8hkliOyOsf0lxwOTl6O/jALPngnl9Lo4OcfuWGA+zv8KAt4SuY=
X-Received: by 2002:a5d:93ce:: with SMTP id j14mr2794167ioo.172.1616596774845;
 Wed, 24 Mar 2021 07:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <1f1fb01e-0616-34ea-ede6-dc7dd679c3d4@garloff.de>
 <c7074c16-5d64-e829-10f6-ef91f5f6222b@garloff.de> <f6143d7a-079d-3f3c-c947-47fc9858a2bb@debian.org>
 <YFsyh5tEaiVNjqT1@lorien.valinor.li>
In-Reply-To: <YFsyh5tEaiVNjqT1@lorien.valinor.li>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 24 Mar 2021 07:39:28 -0700
Message-ID: <CAAYoRsXw5-ATytCdgDaOS0dCZ3e=wn_z1tKaxSAsNBkSrSeWWQ@mail.gmail.com>
Subject: Re: turbostat: Fix Pkg Power on Zen
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Christian Kastner <ckk@debian.org>,
        Kurt Garloff <kurt@garloff.de>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 24, 2021 at 5:38 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
> On Mon, Mar 15, 2021 at 10:54:24PM +0100, Christian Kastner wrote:
> > On 01.02.21 10:01, Kurt Garloff wrote:
> > > Issue persists on Ryzen in 5.11-rc6:
> > > kvmadmin@KurtSrv2018(//):~ [0]$ sudo /casa/src/linux-stable/tools/power/x86/turbostat/turbostat

... deleted stuff that doesn't display properly ...

> > I was seeing the same issue (no stats, program just exits with 243), and
> > Kurt's simple patch resolved it for me.
>
> Does Kurt's patch seems good to you and can be applied or is there
> anything missing?

There were multiple patch submissions. Chen Yu kindly merged them into
one, which was put out for testing a couple of weeks ago. Try it and
report back. I'll forward it in a moment.
