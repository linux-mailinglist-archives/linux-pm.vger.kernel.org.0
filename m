Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4AF824DC
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfHES3M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 14:29:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42814 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbfHES3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 14:29:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so86234029otn.9
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M3AJraLHTVvDG0WIPnqlH8z6GNkMUc/mJzGFD1Yjx8=;
        b=anbss06ZbLzmz55bz0D6/naX3nWE2xQSBGE9YYJgEEC+c6ev+givrb1pAJElvCg8M0
         FS08Ejk+g3jEp8MPkKm9CynpgHjRLbMO+Tr5S/q3e3ocdUAuV/v54h0WDWsooNlYOxpu
         iPvCLjtb6zXOlyqxlyH/k2At9FQW2upLQEUTqPuDiX5seAB1udBnrwEEI3cuwq88drTR
         1rju25pjaJumOKGKQ5Linq1gXRZd+D2se/IfZ7Vjw1ttvRWyf+7MHUz/NeEfB/WAveFH
         kfWGtN2vvg70+8U9lMwSzORm2wh0eOCIQqwp4KXu2HK4vYeqOWOLFdBS8VzJ9M2q4b1u
         c+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M3AJraLHTVvDG0WIPnqlH8z6GNkMUc/mJzGFD1Yjx8=;
        b=DMrYINoetwip0gLwsIownFQOGh/9EyDfPOV3JsyU/2jNxin/pKChY04EFjLe4pY8wG
         gsj6GqaoNDQNKySZhk9aizfPO9ocVsmG7LsHJNzdN1OktKuWlyOorhUwNVWa/MF0EzfB
         eaFzu8Q863Nv5Wxg+3maeSM724hFq6WSNpxG/nU2QVYZJ0yxyzWJ9vPyy2wAl/c2EPlK
         Ga80Qqy/4Je8pkOv3skHE1MYEOPJC81G+58JqDF3CaxxfyCmw6HenAqEM/v+J/Qkjhy6
         Fzj9SQl4nDQ2FqRCa9nfMGq60HG/vQnhHiD6MASejt/ksjZq2A+/CEtDgXMFRzQzMyAO
         89DQ==
X-Gm-Message-State: APjAAAUUhWu+kxhicVzkpjxuxJk+SoQX43A8VJaVsE592aLuWJhwus0y
        Ej5SEel8HFVY3J+ZWYmXcQgsuwQHoKX4f+KlKfU=
X-Google-Smtp-Source: APXvYqyyDzM/BdKK7/lu8S4iauqE10dCEgom40FH/iNO9Qe61bvCJju+WUYxbL0xFIi68/khSHysUTC4oDgoK7gwqvU=
X-Received: by 2002:a9d:5f02:: with SMTP id f2mr29480658oti.148.1565029751713;
 Mon, 05 Aug 2019 11:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190731050549.GA20809@kroah.com> <20190731212933.23673-1-kaleshsingh@google.com>
 <20190801061941.GB4338@kroah.com> <CAC_TJvdUReRL-Xqq-sSOZ6w1FpEA=Uzys22Mami1USrErnkw+Q@mail.gmail.com>
In-Reply-To: <CAC_TJvdUReRL-Xqq-sSOZ6w1FpEA=Uzys22Mami1USrErnkw+Q@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 5 Aug 2019 11:29:00 -0700
Message-ID: <CANA+-vBO-dE6kqgHZ843oMOkkQhXN=3JZLiJby4pR_E2bxd7Zg@mail.gmail.com>
Subject: Re: [PATCH v2] PM/sleep: Expose suspend stats in sysfs
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tri Vo <trong@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 1, 2019 at 9:34 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> On Wed, Jul 31, 2019 at 11:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 31, 2019 at 02:29:33PM -0700, Kalesh Singh wrote:
> > > Userspace can get suspend stats from the suspend stats debugfs node.
> > > Since debugfs doesn't have stable ABI, expose suspend stats in
> > > sysfs under /sys/power/suspend_stats.
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > > Changes in v2:
> > >   - Added separate show functions for last_failed_* stats, as per Greg
> > >   - Updated ABI Documentation
> >
> > This is nice, I didn't even know some of these were in the debugfs
> > entries, so this should be more helpful to people.
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Tri Vo <trong@android.com>
