Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C768E37FE0B
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 21:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhEMT2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhEMT2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 15:28:10 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C0DC06174A
        for <linux-pm@vger.kernel.org>; Thu, 13 May 2021 12:26:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f12so22493897ljp.2
        for <linux-pm@vger.kernel.org>; Thu, 13 May 2021 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcTyI8CdqDYS+DLvWcEReUWNJFD/4vgGxlJYUQdhn98=;
        b=bVD78BCgzVDTYgRpvMwtI20LjNpcjZE4ug8fPOgkwqZd8jPUisd3g4ekz2la/BIgHF
         Czg4XeaVQmqDGXkKSjeQpbpG9NqHyTVkGlTnstlgeaSofhF4+VrLOdKZbBJv/BeqO9zC
         gfVjgew5vXKeNkTAz5Fed195VIoW0t04HzU/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcTyI8CdqDYS+DLvWcEReUWNJFD/4vgGxlJYUQdhn98=;
        b=I/4Y2ZOjTw2MQVLAzGh/AfwCH/T/rbibM90jRoXk6g+Z4QCGBdpAZUruUbREviQ5oU
         Ha+315vDP9rmYREWS6JJvYqODKjBZLoJ8xijjVGPZhXg4sp2ypmPmxphmHz9t98pfjVH
         IzakKVa3Mx9oD46BL28nNay/sJC+ccW/s0TSmELEO6Ggl+zzP2ABJ/lrQNeiAWt6UbrR
         XS4z6BYmaP8IBba1eH+HcrksgnLjuTEHdbR5wdiwvnHXQptItVJE3AKeui9bHApB5pq9
         NV3ZI/DaBcpqwj+VWvPEFfUAXFo7P51UJ3DssJ0IuZ6v0MvOdGA39rqCWnjGYZpog2U5
         Cyhw==
X-Gm-Message-State: AOAM530wW6gsOQUmQW16qSRacvh7+PASyiq+9D+mmSbmiZpC7Que54Oy
        /2EeusvYctG/EJmZugIqCDzjNOFiOZuCTpxu
X-Google-Smtp-Source: ABdhPJzLtCNQvk9wBASih5cnutPBQH4rR3raJh30SdYGQTwP9YEM3C7Gl7cVcGNrstwBw57pZhuHZA==
X-Received: by 2002:a2e:780a:: with SMTP id t10mr31818763ljc.38.1620934017508;
        Thu, 13 May 2021 12:26:57 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q27sm372901lfd.266.2021.05.13.12.26.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 12:26:57 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f12so22493847ljp.2
        for <linux-pm@vger.kernel.org>; Thu, 13 May 2021 12:26:56 -0700 (PDT)
X-Received: by 2002:a2e:c52:: with SMTP id o18mr3512611ljd.411.1620934016634;
 Thu, 13 May 2021 12:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
In-Reply-To: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 May 2021 12:26:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSF1Vozzmst-H_xgy20XZx0t55uBwn8B6Rqjhe0JfOwA@mail.gmail.com>
Message-ID: <CAHk-=wjSF1Vozzmst-H_xgy20XZx0t55uBwn8B6Rqjhe0JfOwA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.13-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 13, 2021 at 12:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> These revert an unnecessary revert of an ACPI power management
> commit

I think it would be kind of nice to see more of an explanation than
"was not necessary".

The original report of problems was apparently wrong - but it would
maybe have been good to just mention how that all went down..

                Linus
