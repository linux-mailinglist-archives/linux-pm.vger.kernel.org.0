Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF73803FF
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhENHIl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhENHIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 03:08:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879EC061574;
        Fri, 14 May 2021 00:07:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t3so1116298edc.7;
        Fri, 14 May 2021 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kAz87Mlx4WSb3cL27SNEkL0I2UewaZV6o5vYLNdlON4=;
        b=UuXtFRUP0O+sV7ASRFo0cUu1obDqwq9kWCVBEGqWbIE1/oq3zJkToBPnlcQR3LxSNh
         iw1Q8hDqukIyY8MIeNUvcGHc0vH0kOOYqlnBlYq5qdkK0IN55ZaMWtsjbcvQaKf5xtIc
         PbIrB7LuKBzklzoyB8+wkMkUiCcDxGXFePOj9BLPY/hcU/tOjiNg20FHu55zXq2WEeBV
         ehEeHFT1FbPxFaLrasK0zLM9eaBWGeeNNPnWr2yOI20x6de2n8w7PYwuEq9fg8ZqBVfL
         CjuVNDZJ9b9rukAyI8bdd9jY1Q3VwBH+ECBtals1Mj7QuqpxX7ejGBYQLs42m10+cjXw
         1XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kAz87Mlx4WSb3cL27SNEkL0I2UewaZV6o5vYLNdlON4=;
        b=YNeUeZVbfaX2vbUzquA3ZN0z6kDuSbgglZek4cgE496lsP7yGzGgod+tg/N/jjFAmH
         SK1kapUDlUYhdidvuQXwjubvlzQKL3ZFVukEWAM7lkSus3m1Xfe2/zQUQBxVonROpZUn
         TAeGr5lAYcG/uZ9h1mhnFfRqoQKKsYbYO+qkvNBeeh+YU2L3mfoJUSg/KAElcx3A+Y9C
         UUIqU2oiwaq0qW+St6XaCImBMrq/V9xIlKWo52n6q+LtUUAvwa8Cij4sqb9VjqrlcBN3
         wxx3LkI8597pJPh4q9ZkX25B6SCX3D4zRMEaMSiWvEgz7qyL/+jhKddR5qahcp0FhGs4
         /b8g==
X-Gm-Message-State: AOAM532Um71ZGrDVv7RdCfePdkNlUe51/wrH9T5+IQDmnV6TWPy9+I/b
        6M84tiEPyCWeTwD11RDpNZU=
X-Google-Smtp-Source: ABdhPJzkToVSfe5UqgCC/8i7ain6D8alwEi8DJsz9F+jFa7GnmwdmmP0iB7MB/ckXKhbeysd+y/aSQ==
X-Received: by 2002:aa7:d6c6:: with SMTP id x6mr53451578edr.193.1620976048967;
        Fri, 14 May 2021 00:07:28 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id k9sm4067820edv.69.2021.05.14.00.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 00:07:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 14 May 2021 09:07:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: Switch to pr_xxx log functions
Message-ID: <YJ4hrrUkKRkKsUtf@gmail.com>
References: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


* Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Switching to pr_debug et al has two benefits:
> - We don't have to add PREFIX to each log statement
> - Debug output is suppressed except DEBUG is defined or dynamic
>   debugging is enabled for the respective code piece.
> 
> In addition ensure that longer messages aren't split to multiple lines
> in source code, checkpatch complains otherwise.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 118 ++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 71 deletions(-)

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
