Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAE37516F
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 11:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEFJXx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 6 May 2021 05:23:53 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35754 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhEFJXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 05:23:52 -0400
Received: by mail-oi1-f182.google.com with SMTP id v22so38838oic.2
        for <linux-pm@vger.kernel.org>; Thu, 06 May 2021 02:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQNMl//t6XmGHORdCe7VCW/ZdfmDxYYfngwlf/H8WAQ=;
        b=l9QoCx7PC8X3D171DZCJf5q3fwkwsXOtJMq6dk27OpDmUFj3HH+DIfOVsgzZ1jvW8e
         lJa5KTMhFBuoPpycpIqb1fDF6qGOc04aVJFCYlS8Rv70CTpRqUpmg8EXbtxsaGMl2l8i
         CXLjmLUC0rrn67aKGutoc7mPVpHTH5m1EZJG5N0Ps7e9DXyjjE2NhGjPHEVyL3nYPTIC
         Eczefa7XHWxR1n8+WENkY0P13ZN3J3zTct17L4uijNKQkJMDpY/4qhCm2iVwFGXY5FNJ
         Oa/IHxyeNEqROKntH//XdHu53FxmqOSq/0payyIN3bpndMdXBAcVqZBTMjSTrGtO0FCo
         sh1Q==
X-Gm-Message-State: AOAM531HDnkjQcAANUJWzghMr8KyVql6lvyvciINOcuY7VDa4b9bS1oE
        D60GOGXfD1c+NNrhrkvTT0yUkIzaihmHA22vyvPDMOt5
X-Google-Smtp-Source: ABdhPJxDrjNbzZyCUmXIjQBTIVaJ+VQmtQAs1cbaV4m4nB8L+FDMwZAALeNPNb6O+99EpB1PIyN9uLGw12PSbxUaSX4=
X-Received: by 2002:aca:bc89:: with SMTP id m131mr2442802oif.71.1620292974891;
 Thu, 06 May 2021 02:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <83426b2264f23a3a790aa6c1cc631669ede81e66.camel@yandex.ru>
In-Reply-To: <83426b2264f23a3a790aa6c1cc631669ede81e66.camel@yandex.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 May 2021 11:22:43 +0200
Message-ID: <CAJZ5v0id_5yY8P=Nc+psNmxb_PTmgxryxMDZ2taxOKfynojWfQ@mail.gmail.com>
Subject: Re: How to detect s2idle from a drivers/pci/quirks.c ?
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 6, 2021 at 2:04 AM Konstantin Kharlamov <hi-angel@yandex.ru> wrote:
>
> Hello! I'm solving a bug where s2idle (as opposed to a deeper `mem` suspend) results in external monitor no longer detected, and `dmesg` having PCI-related errors and a stack trace.¹
>
> I pinned down the problem to the fact that `quirk_apple_poweroff_thunderbolt()` should not be called upon s2idle.
>
> Now, the last bit is: how do I detect from within this function that the ongoing suspend-mode is the s2idle (aka freeze) ?

There are a couple of ways.

The one that I would most likely choose is to call
pm_suspend_via_firmware() and skip the quirk if that returns 'false'.




> That is, so I can return from the function early in this case, without powering down any hw. I studied code there and in suspend.c, to no avail so far.
>
> 1: https://bugzilla.kernel.org/show_bug.cgi?id=212767
>
