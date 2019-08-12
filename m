Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5438A337
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfHLQYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 12:24:45 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33821 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfHLQYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 12:24:45 -0400
Received: by mail-ot1-f47.google.com with SMTP id n5so161080935otk.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EX5SqmQimFHHDLW4N4+79Vwj96/2MHoKe+E0fsyJiX4=;
        b=CFmKhYzbI6hIG26EYtPFKdHkeYvVR2LPoEEm1pWnytsnlQjp8uMPlRXJMT4XFPG7Nv
         rgb5569VHjTgVD1Fw2h6+J4/BQgIJJ4Y7y5gNs0SBffw7jpP8QVBO4M/HIbQjpAaa+rb
         oeRnCHlfwZ0DeWobS/2ZmZR0i6iz7uX31WObeAY4TSlcqlDDnOPLMsGDlAAxSd9VdIK6
         mFP6LdlZaGVqB0J1BDRvCpZRlaQbzkDD5nWY3rBN+kBy3eWG6JvzxH2370ZZk4mRkTwa
         bFw004BCG9Ozzkcbd3Kdl3I+0dHSs/liYIYyDatgTOqrNIsd/cRof1FjCqwLGnq2ePe9
         kTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX5SqmQimFHHDLW4N4+79Vwj96/2MHoKe+E0fsyJiX4=;
        b=kWW+sSzDSwLPKUUb21kMV46LFAQfl/CQ6U51wnrs3lPTlUuxLs/RgHGKQeDCkw3QpH
         EMGxKEJ+01K6Ry7x7gLSlkR8VGvsQkHCQQ8TDy/Zkw38Y44UsD+1ossDmg2pJyedLK4d
         A1gniHEsFdrgl+sMmwzUnW4oepaJzTk9tFsU+eB6wN2PlvlfSCJ/gebCAHQ9L1oeCCmy
         DWhwx0aKcR7avdy7zEfHyzdtjmqKW3ugnHuRzQ3DLT7KtXToG889WNkJFV6fQiZBb13E
         SJIFEeOSpKaILo8m7ONHB+Wh8FPeIcn89APVgig3taQBW1wG/wBZsQZp7VSNFHW80Xib
         Wrig==
X-Gm-Message-State: APjAAAULpe/udrETInoZbHTECUbjVmOVu/P/dEDYnqodSELsVeTdLUFW
        /Ypgp3EjXvudi1g3Bbja7EWd4TE6VYgfHfL2Ouv9VA==
X-Google-Smtp-Source: APXvYqxmA37cnUt7FIlqtFhijw1GGQINjQ3ttgIzYfaSdF7wC+dpqlZzx5JzYkaAhf5q5G+YBVHWpBw7Op+QeBoNKA4=
X-Received: by 2002:a02:ba91:: with SMTP id g17mr12832603jao.11.1565627084182;
 Mon, 12 Aug 2019 09:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
 <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de>
 <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de> <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
 <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de>
 <20190811094630.GA18925@eldamar.local> <alpine.DEB.2.21.1908111456430.7324@nanos.tec.linutronix.de>
 <20190811153326.GA8036@eldamar.local> <20190812112853.53ecc122@gandalf.local.home>
In-Reply-To: <20190812112853.53ecc122@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 12 Aug 2019 09:24:30 -0700
Message-ID: <CACdnJusGKAx-APuDi2+hqSSVXeeH5hBq4Chi-rPirDos4MvhgQ@mail.gmail.com>
Subject: Re: [Linux 5.2.x] /sys/kernel/debug/tracing/events/power/cpu_idle/id:
 BUG: kernel NULL pointer dereference, address: 0000000000000000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 8:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> From what I understand, Matthew's "lockdown" work is to prevent the
> system from doing anything to see what is happening in the kernel. This
> includes tracefs. This looks like it is working as designed.

Oopsing the kernel isn't working as designed. Ben has a patch to fix this.
