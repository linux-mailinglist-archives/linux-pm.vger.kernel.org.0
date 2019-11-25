Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD67D108FFB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfKYObO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 09:31:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39118 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfKYObN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 09:31:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id f18so11180289lfj.6;
        Mon, 25 Nov 2019 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WJcL6zJlFuqqleMc2SkLefhJBqvomh77ELiAskEiwdQ=;
        b=JIdutctR8IGj0nY1GGFA1Nq9c87pfVEoit1PdYDo/pucpBPAiji50N0+eqzrWGReAH
         L5uzVZ6rMcd1FbkUZulHYKl1RixdeGyaXul59/1oyq/kPLmGckhYHYGlqdTsFDL0/3TW
         3JdVfKYUVAAR0fnwmNNEidkvFN1DQyolIrAwhXwCaJL3Yknlll5eOTSlTY7ir4jNNHlu
         d77dyp5tyvy3Fnke+HFu517JmSDHr8sl0nXEBMwS46ZctA0FF/kza+YAxW3azNbDiOaM
         0hJ6swR/nWe9Es/0nuuEcqNW2Rh4JvCAF/fhs/lYLH3LkySw4/ggx1dIKAmDB2cUK3e1
         3afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WJcL6zJlFuqqleMc2SkLefhJBqvomh77ELiAskEiwdQ=;
        b=D6K0W1hv6vJXr3/Hp1bRvh2hSx13BZnGew9xxkB1/OqC48bRYhONZgS8szCrom37cn
         01UEkJWfqunJwxRzjueswL0M7XCeMHEDj9Hmdtlc9nEGtx1QziUD4gY8+VU2iO7TXMcq
         P/e0Rr6zsTuyNl5nGxbiBTjMDvVc6e7CdomWX1JhoGr1SUNEbTbvzwkpMi7OL7DOwzHi
         +MMYgxHte1ICI4RrSDe6fpii+HMew4NnwXsDEk7mQUCfAmnNIgejmjUU9dC9VeEQdRWU
         WV4TRUzz60OBNiAAGO0+8WzGA752qO67Ck+CTCLVLSvZR5RaAFtSRFQ/wZ0PvI0DJveq
         ounw==
X-Gm-Message-State: APjAAAUUYX7gsIBio4iXQOYElws2xUNJcIRMlx7wrsows8ANkdIaZKbc
        m/GokubGVPE1J+hOZv78ApZ7iczF+3mpiXr24L0=
X-Google-Smtp-Source: APXvYqxXUiBF72dN+bSBfP+dVzJMyJQkB60RLYR3XrsVNUjjUY9fqHd5g80b2368oc2at00TYuTPqWhSDRZ3kyYJLlw=
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr11281925lfm.29.1574692271621;
 Mon, 25 Nov 2019 06:31:11 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-3-git-send-email-akinobu.mita@gmail.com> <00fff683-d0e2-67ae-83e3-c472fdbe9e1d@roeck-us.net>
In-Reply-To: <00fff683-d0e2-67ae-83e3-c472fdbe9e1d@roeck-us.net>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 25 Nov 2019 23:31:00 +0900
Message-ID: <CAC5umyh4Ay_PnFGp4fA0_VSimD_Bm-+xpVz56jZnd5bT239B8w@mail.gmail.com>
Subject: Re: [PATCH 2/8] ACPI: thermal: switch to use <linux/temperature.h> helpers
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 0:17 Guenter Roeck <linux@ro=
eck-us.net>:
>
> On 11/24/19 6:08 AM, Akinobu Mita wrote:
> > This switches the ACPI thermal zone driver to use celsius_to_deci_kelvi=
n()
> > and deci_kelvin_to_celsius() in <linux/temperature.h> instead of helper=
s
> > in <linux/thermal.h>.
> >
> > This is preparation for centralizing the kelvin to/from Celsius convers=
ion
> > helpers in <linux/temprature.h>.
> >
> s/temprature/temperature/
>
> Looks like this applies to all patches.

Oops.  I'll fix in the next version.
