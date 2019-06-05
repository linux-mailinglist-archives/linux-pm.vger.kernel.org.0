Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF955354B9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 02:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFEAYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 20:24:10 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37619 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFEAYK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 20:24:10 -0400
Received: by mail-oi1-f175.google.com with SMTP id t76so1956052oih.4
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2019 17:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o0xL1QihkfMHo7DI3paUmZXWDl9oR7z1jLaaqluWzDw=;
        b=T+oDmCZDsauvvPCjKbIbPC03KqzUMbRYyT3F6r6LUHsF54pMZp3TFADm5Swz6LBrWq
         eyHFAHm8HRkYBnsydUJ9jHpmzxL19crbDuHitNp/UAwhWQeWW4Dbvs3jKx4etmz5klIC
         tageCpAiolsNegMeIeyO+Fb+dz0ShU5Aeb5PPYZab4UOPAsmC0QkjqI0SYXeCQyzj0G/
         RX6Mv+BKRCalFvuVatxAUdd2ROO/a66fgzRL9udTVQ7XExX2c4+XfEnBb38CRMLtddCS
         b3eD4ekesWYwNueBnm1Hljs8dtIJLCaZWhfe4Ntti+AfN4LAN5m3OawuhJgk/EmyEKqz
         31Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o0xL1QihkfMHo7DI3paUmZXWDl9oR7z1jLaaqluWzDw=;
        b=n+Oq1Bjs6s2hZks0yiyBlN4SgWqKXvbgO1XzkHHzA+XIxB1iFyoeZJWM8MVD8E5Ffm
         k1vIG2F0qd2x2RMoSzbugPyQAXPSkpUHcyMWoH1A1nPWnEheCJ5HOpfubuHBs4A8FhX2
         MR84rpsDrbuciY/GWAwEY95upX3mPY4gN4dOoemVPjPym4qASdU+iUe/CH5SrK/aIKQj
         SQqv1W79VoQgqZJPXOtpB+3c+ZKQ/jqbyjptBm6bMl8RxmLXNkR/ZUC8uo7UVAW6yW1k
         tZb+ZPJ8sbFAXurvHBf2NPYMVAoY/dY2z9UkmeaPAbKFJfh+bBUsnzKlrLQTxmRotbXz
         BzRw==
X-Gm-Message-State: APjAAAWfOKSY3o/tOww/H/Oc7+vxbQ1jobBES5IumXcjp7sgc6WJQcaR
        aEbPgAaH9ZsS64Ilb3tBC82K0XNLcfVQo7g7Ki88SA==
X-Google-Smtp-Source: APXvYqw5PkGU8gjbuk6q6kOEFTbo2O4p1uw4LtJ3fBgeRY3dRW0YramMydPE/oKPqCNqT4jnFaunG/GdPwYmQr/OkX4=
X-Received: by 2002:aca:5f84:: with SMTP id t126mr4216913oib.18.1559694249371;
 Tue, 04 Jun 2019 17:24:09 -0700 (PDT)
MIME-Version: 1.0
From:   Tri Vo <trong@android.com>
Date:   Tue, 4 Jun 2019 17:23:58 -0700
Message-ID: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
Subject: Alternatives to /sys/kernel/debug/wakeup_sources
To:     rjw@rjwysocki.net
Cc:     hridya@google.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Rafael,

Currently, Android reads wakeup sources statistics from
/sys/kernel/debug/wakeup_sources in production environment. This
information is used, for example, to report which wake lock prevents
the device from suspending.

Android userspace reading wakeup_sources is not ideal because:
- Debugfs API is not stable, i.e. Android tools built on top of it are
not guaranteed to be backward/forward compatible.
- This file requires debugfs to be mounted, which itself is
undesirable for security reasons.

To address these problems, we want to contribute a way to expose these
statistics that doesn't depend on debugfs.

Some initial thoughts/questions: Should we expose the stats in sysfs?
Or maybe implement eBPF-based solution? What do you think?

Thanks,
Tri
