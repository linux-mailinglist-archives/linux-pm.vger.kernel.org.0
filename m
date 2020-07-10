Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E921BB36
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJQll (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 12:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJQll (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 12:41:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0F2C08C5DC
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 09:41:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so2851203pjb.4
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yv3QBCAvG6YZU7bGRxRyZKQa73z0mQNhdf8Wtgm0GNQ=;
        b=Wp/NcYU0dbUHW5C0f5j0U/BlTUrZHf7GTVEUeStgfJmsy/CTrVLHPdo9tZ9a4hpCjH
         BDf7UEzNWJQrYCAS7EOG3Hh3T/+mKCHue+LDFO/yGJ6BCBgS/Rz26L9pfRt/vjHp0mgN
         6XS5q9BqwG4C1n8k8xsLmIjGkB+Hke4t4x/tKnHaoNlL9g/WB3DeS6gVUrKtqE8Ecy3+
         HzWCCA//8SyeQvAItCMAVih2NoPy7fNMGjcwfPuCfkreUv3mBFHKbHG4Xarb3oBRShDR
         cQpeGcev2dn1T+p0oqOQ7FMlCw3Nwwt6gRJ8TuZnws2oZJBtOFBcj9qxRJDjpHw9p3M5
         luzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yv3QBCAvG6YZU7bGRxRyZKQa73z0mQNhdf8Wtgm0GNQ=;
        b=b2fFl+05nEm+ZlcAWQ4v5fN62PenCkYM7R1tR2AQJK5eWlBqmllTg+2fkUnvqX++D+
         mXVQLk5V9upMp6D6Beq+5fVtZ1iNy5eVERQATrQB7jNNXXJavzlfb51PqHyeYk+FURjw
         1EENA0P1336veE7NUuagmIy6ztr1RpcpoY0jJ5Xf2Ozzril/Sk6WQOWkCBGMvTp35FVa
         Obkg9hrYaqej4K5xAM2kBdF5Ovg//ACWhlEI2pr3TnHVUWLAnqLIrg5WIxZlG8tiObgH
         S2P9E/G60jlxiJQEvEdCGNnGYvp+n1bCPswXjLAbRIqjtu65swFMuS3gqoVo2KaWhwdw
         1voA==
X-Gm-Message-State: AOAM531P6g4qImCJjZAufwxT0gNgt/ejVtSeIzlrPyRNSRcCHRuN10Pr
        tkdvx5iDl3XSb8UnDC3Zl9jUOQ==
X-Google-Smtp-Source: ABdhPJwPV4et91gVoizdjv5AIKJiRZMhudwxxGDeDIiTxV/LirlZJ67s8UEUkjmiCal45kQB28e3RA==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr56941393plr.4.1594399300441;
        Fri, 10 Jul 2020 09:41:40 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id hg13sm5961210pjb.21.2020.07.10.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:41:39 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] genpd: Fix up terminology with parent/child
In-Reply-To: <CAPDyKFrAe4zRRAidY86L2UVyQUDeDc7HdjpJAn-r7ctYeHL0Zg@mail.gmail.com>
References: <202007081629.0840B4CB78@keescook> <CAJZ5v0iZMveZv_nfu2upLQkp5-8sNdzRf8ATQV1UadvzcN+ZGA@mail.gmail.com> <CAPDyKFrAe4zRRAidY86L2UVyQUDeDc7HdjpJAn-r7ctYeHL0Zg@mail.gmail.com>
Date:   Fri, 10 Jul 2020 09:41:39 -0700
Message-ID: <7h8sfr1fwc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Thu, 9 Jul 2020 at 14:25, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Jul 9, 2020 at 1:32 AM Kees Cook <keescook@chromium.org> wrote:
>> >
>> > The genpd infrastructure uses the terms master/slave, but such uses have
>> > no external exposures (not even in Documentation/driver-api/pm/*) and are
>> > not mandated by nor associated with any external specifications. Change
>> > the language used through-out to parent/child.
>> >
>> > There was one possible exception in the debugfs node
>> > "pm_genpd/pm_genpd_summary" but its path has no hits outside of the
>> > kernel itself when performing a code search[1], and it seems even this
>> > single usage has been non-functional since it was introduced due to a
>> > typo in the Python ("apend" instead of correct "append"). Fix the typo
>> > while we're at it.
>> >
>> > [1] https://codesearch.debian.net/
>> >
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Applied as 5.9 material with a minor subject edit, thanks!
>
> If not too late, feel free to add my ack to the patch.

And mine too.

Acked-by: Kevin Hilman <khilman@baylibre.com>
