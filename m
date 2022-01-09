Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F610488853
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jan 2022 08:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiAIH7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Jan 2022 02:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiAIH7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jan 2022 02:59:31 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D8C06173F
        for <linux-pm@vger.kernel.org>; Sat,  8 Jan 2022 23:59:31 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y70so13452351iof.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Jan 2022 23:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=o1vLp5DTY9ymBiRWyr8ydS/8R5S2aODL3XlSJX0ORAc=;
        b=TjirW4RGiSGJ1QNGk4lo0ghfgu/XTWMTlTm33Fh6zkW7uu9vqobiY3VdtwNUONX04Z
         Bn2WfqPtGYk9NGeknhhbeFt8jsL+bm0wJ5uUzMJCpttLNXya59OgEOhq/rS9q/qZduVY
         WKPf4ChqCN9cJL483OsSBDqqPTzs3caGwmvhl3ei+gcASRj0c+I9Er2vBX+QLOFtcfd9
         NbqPSiOF0x8XQfykuj/LRo9MCRz9OcUlXowsh7HxOz0o/bsemfqp00XiaPKAq+uzNt70
         bDRdMrXlx6BjUNeFhxFEINhnAxCInXFJ3hm9FKXjgaMCdD4JW0YY9Vi4B+zHIaDeo7ug
         KGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=o1vLp5DTY9ymBiRWyr8ydS/8R5S2aODL3XlSJX0ORAc=;
        b=j4ouWURLSOoHQuLSUBdO/aT6UkMMfxujaZj4IxZBIz49GW1d9L9eT/4cyVOUo09r5Q
         B+CZ1xwTQvecTHVGi0ZDTcLMP4f0jul3V8OlZXk1GcXNTsvQfhg8FhZpjwACQ3z3MtfL
         P2tp1FA1Azk/F3MnMXDaRFAFnLtGUT4NlJ3g8+DcQBcG+EH2ZpJI8N1fj12QXKfwRert
         QkJXyiG9yFdLsA6SPmjSGlHpVUtm/9HYxc4X/fQnXQ3bY/uUZW+T4f1tEEj154+Kxa39
         giexyBG/rX4/j+3hC1xmxODQrWHce1JyCoUfIJsDpVKce7E8TqetWOsveswodbH2GNAV
         C8ag==
X-Gm-Message-State: AOAM530JRXZiPp1AP2omm/QC7RXoOj+e93qG7emS+PhsZ4359JBhybPq
        m/9UtMbpWbRSYKG6ssms+9aOCRaauQwyli9pTtI=
X-Google-Smtp-Source: ABdhPJzlCjSS595rxva7WREWWVg7j9czlHuIpXj0v297on11wCE0vSY0LkjIaI/tWf/RUDudfGZ4uiSbSJIDLYtyxaQ=
X-Received: by 2002:a05:6638:8:: with SMTP id z8mr33910382jao.199.1641715170864;
 Sat, 08 Jan 2022 23:59:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWoKBL9DYY8dcNMvKMV-UgfdEsPrvwzueE85N6PqMOK1A@mail.gmail.com>
In-Reply-To: <CA+icZUWoKBL9DYY8dcNMvKMV-UgfdEsPrvwzueE85N6PqMOK1A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 9 Jan 2022 08:58:54 +0100
Message-ID: <CA+icZUXg-P15y48+tr_twfq9Lvhx_R8n+y2XnW3RME5Fv-0Oeg@mail.gmail.com>
Subject: Re: [Linux-v5.16] power-supply git-pull request?
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

See upstream commit 644106cdb89844be2496b21175b7c0c2e0fab381.

- sed@ -

[1] https://git.kernel.org/linus/644106cdb89844be2496b21175b7c0c2e0fab381
[2] https://github.com/ClangBuiltLinux/linux/issues/1497#issuecomment-1008182373

On Thu, Dec 16, 2021 at 1:02 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi Sebastian,
>
> was there a recent pull-request for your linux-power-supply.git#fixes
> Git branch?
>
> Restarting my activities in the ClangBuiltLinux project I am
> interested in Nathan's "power: reset: ltc2952: Fix use of floating
> point literals" patch.
>
> Thanks.
>
> Regards,
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=fixes&id=644106cdb89844be2496b21175b7c0c2e0fab381
