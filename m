Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8693EAC80
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfJaJXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 05:23:06 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42550 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 05:23:05 -0400
Received: by mail-il1-f193.google.com with SMTP id o16so4729362ilq.9
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 02:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcqb+IhaSDNJqj7Em32KI5EwoshodE6lIm8MXsmML5E=;
        b=weLvOuQe1qp7SmhCa5wqkA+qSy/HEWoAjkcTVlSLmbLlzcNRUYU35rD6ep79Car13u
         zKYBIaW1HL+b+Ge52YcNvy+uigJvgEvkl2WJ5/xcQHSfo9uz/tLpaufL77nD/StOag98
         5g0E/oajUNfHB3BaXhwyd+V6VC0DOOCkEdTVe6hgSLb+zF/DQRZrhi8Ja6YM6EH63NbX
         INzL+8Y+jxQq1t32aM9SzxjjwZgkcoJxE2WGtHVb8mRN9BOIuXfCMQrYFOtkHs0AiBgO
         GZAfXiwJTEGGz8yJ8QLfyZ+vTPRonyzYtQnbfO6X8991QDuI76GzMx0tXFymBenoUEsH
         rruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcqb+IhaSDNJqj7Em32KI5EwoshodE6lIm8MXsmML5E=;
        b=HykKv2VUdrDU3yxOdtaOVqH6oNx3RWeVjegEON6X1nDcLDMCMcd17FRCbIPKbjG3Jl
         uoOA4Bmt89ALPszZa0eRq+eO1rXE8Tggo1R09uPd0u78QyLYZHtQ/tlsVBMxAwUFrXRF
         5W7E4hlStvQaiY5fTx/nR4ZiCCZTQLTVnxqnKsW4jL1H1+PYbrPGSAJyjbZ9Ix+bAnl0
         bOLwU4UcBj3iuEzuFuT/w1Mm3dhIno1WBfzjkM1Y2A6OykcB043jWgNiWAQtEcoUOqkt
         xoi2GG0/gxK5u/mOufrbhqXfOXDzCjmnlb2ZiD/MZFJdzbFS9rUvlzgFXZfj5CWg4tJ1
         gn9Q==
X-Gm-Message-State: APjAAAXWTqm+BrZpzl0vFWxwxGudUjTUzwrQ3L+ka/ZhoXYyNZBQ2FuG
        jO4gkN92lPaahtycFCIgTeT7dWgV3sxgNuN2+SwauA==
X-Google-Smtp-Source: APXvYqwTEs0TXLg+Y9KN1LSZ7g7ly19CRMffOhO7e8e4HHml/6cDYR6bH9s2YdOlfMGLddxa8lx0sqJHYZVTLpNjaAw=
X-Received: by 2002:a92:af99:: with SMTP id v25mr5291400ill.167.1572513784923;
 Thu, 31 Oct 2019 02:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191031052159.4125031-1-jhubbard@nvidia.com>
In-Reply-To: <20191031052159.4125031-1-jhubbard@nvidia.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 31 Oct 2019 14:52:53 +0530
Message-ID: <CAKohpomBZPYyX_u2xSzE4UenR0s3eFo5SOmDZ=4NLVcD_pA5iQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: powernv: fix stack bloat and hard limit on
 num cpus
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 31 Oct 2019 at 10:52, John Hubbard <jhubbard@nvidia.com> wrote:
>
> The following build warning occurred on powerpc 64-bit builds:
>
> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of
> 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> This is with a cross-compiler based on gcc 8.1.0, which I got from:
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/
>
> The warning is due to putting 1024 bytes on the stack:
>
>     unsigned int chip[256];
>
> ...and it's also undesirable to have a hard limit on the number of
> CPUs here.
>
> Fix both problems by dynamically allocating based on num_possible_cpus,
> as recommended by Michael Ellerman.
>
> Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
