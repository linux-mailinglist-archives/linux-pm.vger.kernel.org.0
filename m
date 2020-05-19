Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421CE1D9BB4
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgESPv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 11:51:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33860 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPv4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 11:51:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id b18so702016oti.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 08:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=294OKwH951ZAzHNQ2TP/2O9nQbS4bK8FbWziMYfqIeQ=;
        b=e+iL8Sq9YzNrXRf+atyrN/JKSabK2BIYoXK48Pb9zJjvUszcz18hfkcWKYsB4vApTf
         +20ZFDBDBQY8X5K1IT01+5NQorS/mSpUNGr1S1uNq5CHgvjitfkxZqp5f3jnmi7bVKGc
         NAUrIqfkKyITJd4pLYFofNsIkj5d/UhBnZi2jvFCP+3DgKlxlJMb9/C1LgLtTT621XZw
         6v2nwmSKgv9khOT/Ur4VTTDzUaNHgdJHkWywBe4N94Kr12PZJ9jy7zdLVKGpVvL1PeNO
         IuUFeHE+c2pMf00iXkx3wsQ6v6bnWM6aJQQ+QghIoAuj8TdQPZ1csKOnrmtoxjF3n70X
         zD5w==
X-Gm-Message-State: AOAM531PzbJUrw/9/ld1Qsgnhh3ahUU7ubVtlTkR9N/EhMt+WmU9rrJq
        0pYpxWHudsbuLXFXT4ByhcrqmrZB+VdWoC3Pju4=
X-Google-Smtp-Source: ABdhPJxuiLdtE5BqzyvzDUjUybhY5ncjXvOpynKVdXiXvZWjNOSHky8dbVn3j7nRjqW8pLq1f0TucA7/pAA/wFDu8OI=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr15912895oto.118.1589903515460;
 Tue, 19 May 2020 08:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200507071951.635743820@linux.com>
In-Reply-To: <20200507071951.635743820@linux.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 May 2020 17:51:44 +0200
Message-ID: <CAJZ5v0ita4G74ai1aOhd8g6OLGoOG22PnhwrB6cGT3ECCioEbw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hibernate: add config option for snapshot device
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 7, 2020 at 9:24 AM Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
>
> Dear maintainers,
>
> These are the improvements over v2 [0]:
>
>  - switch back to atomic_t API, refcount saturates when incrementing
>    from zero
>
> These are the improvements over v1 [1]:
>
>  - move the mutual exclusion to hibernate.c (it was in user.c)
>  - switched to refcount_t API (it was atomic_t)
>  - the option is enabled by default (it was disabled by default)
>  - remove the premature "DEPRECATED" marking
>  - drop the redefinition of mutual exclusion helpers (in v2 they are
>    owned by hibernte.c) in case the option is deselected
>  - add the help message to the config option

Both patches applied as 5.8 material with cosmetic changes in the
subjects, thanks!
