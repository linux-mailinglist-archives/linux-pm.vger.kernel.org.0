Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE89274771
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVR1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 13:27:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42134 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVR1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 13:27:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id x14so21891337oic.9;
        Tue, 22 Sep 2020 10:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kU4bT0i25SjrMN84gdoOesX/M8UlZc1ewy1FNxT3Nmk=;
        b=g9nVglvZ8n/aolXMm7z2bF+sKZ8HafTJ71t+Q414ucl4PK3Rip82HOzgnyCp7wPePi
         tLSO46gAP0Ga8cE3EOK6e4Z0bs/wmEyV01hH3nOPfmLl2iG8kja6bpqAyMWAliTWPeR0
         ju/qSS27SGXuE/qbTgKE0PN20j9QAuU0AsX7rwylaC0GlrVUvCoJgcBc6mZS1szxUGZ2
         fpEYqxguWzET7x3F7QfSa599Ll6QqxOHqwkF+VnFJcbX/iEi1D6llN0o5d1guFIzD0dG
         st1m9M6z3wg7QFQVxV5+knPS6wWUzLKl26zmV1MhBjhavtT7BSs6Z0c7xRODJUwC/l5V
         z/OQ==
X-Gm-Message-State: AOAM533i/qQb9asdVfFCXKqlsTRCnyKnhBS0dIbb9mnFU5o1M44GImTP
        wk1R8qdvAYGVsyzkZPEzwYxGmXjCZe5b8TlMcLA=
X-Google-Smtp-Source: ABdhPJyEOriize9tTcV0MGf37PfDaCQkXKcVAGzSX54sh0NyjzbCsHVnJJVY26WCA+OH4bwlbCodLmMMoJrGO6eTPWk=
X-Received: by 2002:aca:df84:: with SMTP id w126mr3486140oig.103.1600795663663;
 Tue, 22 Sep 2020 10:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com>
 <CAJZ5v0hJJxxb+J5UtyZe2S_Tn7ARoGvjwDjw4dq601VJrriH9g@mail.gmail.com> <20200922161215.GD30658@codeaurora.org>
In-Reply-To: <20200922161215.GD30658@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 19:27:32 +0200
Message-ID: <CAJZ5v0ipDRkPe6N9B6RzvHyCBobz8B9EoBfPh4DANrL_e86+Ww@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: governor: export cpuidle governor functions
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lina,

On Tue, Sep 22, 2020 at 6:12 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> Hi Rafael,
>
> On Tue, Sep 22 2020 at 10:00 -0600, Rafael J. Wysocki wrote:
> >Sorry for the delay.
> >
> >On Wed, Sep 9, 2020 at 12:15 AM Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
> >> capability of registering cpuidle governors, which was unused at that
> >> time. By exporting the symbol, let's allow platform specific modules to
> >> register cpuidle governors and use cpuidle_governor_latency_req() to get
> >> the QoS for the CPU.
> >
> >Which platform-specific modules may want to do that and why?
> >
> We are planning a custom cpuidle governor for QCOM SoCs. With Android,
> the idea is to make them loadable modules so they can be in a separate
> partition.

Well, the $subject patch is not applicable without a mainline user
requiring this, so it needs to be posted along with that user.

Cheers!
