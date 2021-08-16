Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001FE3EDBD4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhHPQ5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:57:06 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:40778 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhHPQ5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:57:06 -0400
Received: by mail-oo1-f54.google.com with SMTP id h7-20020a4ab4470000b0290263c143bcb2so5127944ooo.7;
        Mon, 16 Aug 2021 09:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWj5yBFiEzeY1CfelaVMGnWQ+sHeOn7aeheMB1RPzdk=;
        b=n3GtB/h58YLZ7bxALFabQkUEUhqV7Jsf4as2JQN5IkLc9hRXmViSIzk0EYwaJ9mVvI
         YU/zQNOss0azyTClB6P8k/gO/uoDHw1NWKNpuqfPDntFQ/2N94ojcRxZO6bOHUwjfHRK
         lf6ylWmCBmrshpQ6/O329CNU8sVGNZlZnr5KSeDNCh7U1FvNL2cApVlZ5k7NrfkAPpYE
         xJXcPt/LWQRBflvHxF96jy7CvFU6T69GF4TbHoauGLKGLFy3iZ37Gb7h0sZU/p6Ujk92
         iJ5hi1ZBrRNxg+SrschF6+Id/6NbjFTUXAB7MrORGvKwRXAHvf7hx3Tx5iMyNBtvn/no
         1MhA==
X-Gm-Message-State: AOAM532Zf2/gmfZSxWnJrfM2oX53WnKpzaPsFI7KRX+mR8+MenF24K8a
        FUnRA1sI2fsAkDocpOVxIsZ7Q0YEyB/GMBG1tjz9wTlf
X-Google-Smtp-Source: ABdhPJwkFYT0il6IQt3hh1IqQ4fqhzZd4rK10QROed0YACI5gyJWavBXRB6qbP4ZP841isi4Q2+d2cTjjvca+4vDyF4=
X-Received: by 2002:a4a:9c05:: with SMTP id y5mr12121749ooj.2.1629132994078;
 Mon, 16 Aug 2021 09:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210811201432.1976916-1-valentin.schneider@arm.com> <20210812071339.fm6kt7wugewxo3al@linutronix.de>
In-Reply-To: <20210812071339.fm6kt7wugewxo3al@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 18:56:23 +0200
Message-ID: <CAJZ5v0jOWkWEhdKJ31jq02nFWLG9g+X-NyR3jSgcQ5YfM1WcuQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cpu_pm: cpu_pm_notifier_chain vs PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 12, 2021 at 9:13 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-08-11 21:14:30 [+0100], Valentin Schneider wrote:
> > Hi folks,
> >
> > This is v3 of:
> >
> >   http://lore.kernel.org/r/20210811131405.1731576-1-valentin.schneider@arm.com
> >
> > which addresses cpu_pm's notifier chain not playing nice with PREEMPT_RT.
>
> Thank you.
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Both patches applied as 5.15 material, thanks!
