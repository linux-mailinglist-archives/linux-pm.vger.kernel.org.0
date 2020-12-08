Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CFD2D30FA
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgLHR1G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:27:06 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34075 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbgLHR1F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 12:27:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id s75so17107881oih.1;
        Tue, 08 Dec 2020 09:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1zY1oOe+Ope2G0rrLvuUis2arfGoeooX6HiAv2WBqI=;
        b=Wm+ya7MAk3qEt9ujQlH5MRWqpYljU5K/ozzMBn9SMOtou+vbzeuLghCJQPXXJb/Uvk
         flzYpX68FmXPMADjv3ukQNBClXjdQN8uLmNAZ4krWJxsPvrAODYHOkhLgl3nDY6Y7kXs
         axHZbGcMqv6tmuNlgTihgeOkMagfkI7PAMoa5NF+lj5zJTpd4WS1SGCpx9ElVomGSsuS
         vIoFqQCCOUf4U96lij0kopiyI8sCcOuzmKeOz/FFC79Nmu0IQpUB3sqYng8dTX8pNFPO
         XOhs4LHn59zw9clXFB/9+kAkl9bBdOOspeAc5YGN9xe7meP0yGamOeMFBHDncWafVBBU
         S3JA==
X-Gm-Message-State: AOAM530tAbLKy8gEjqa1Q+AUm5fZqyMXBfGznGH+iJ9L+GNZ7EmLlMNS
        zKzX+zqG1TLIyRt24dYl38phEDVyNfGt7fYM11kKyOuj
X-Google-Smtp-Source: ABdhPJxg9HbnfWdauC/RJjIIJGlde2STMRuIqZ3LyhZZF8m45HG/HbQeMjc46sISzCcT+Jq1dMdHq9Un0w8YH3eeNHg=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr3375148oib.69.1607448384809;
 Tue, 08 Dec 2020 09:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20201130225039.15981-1-ilina@codeaurora.org>
In-Reply-To: <20201130225039.15981-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 18:26:13 +0100
Message-ID: <CAJZ5v0g+nK+jV+Gy+BKEALRtsXDK0HnDbz07Nv3KPK5L3V3OKg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Better domain idle from device wakeup patterns
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 11:51 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> Hi,
>
> The v5[1] of the series brought out some interesting discussions. The
> most important being is it worth adding the additional expense to all PM
> domains even if no wakeup pattern is available. It seems like
> maintaining a domain specific flag that the governor could check is a
> generic enough option. That should disable additional overhead for
> domains that do not need this feature.
>
> Ulf suggested that we could allow wakeups only if any of the domain idle
> state specifies a residency. However, we don't want to check for next
> wakeup everytime the domain enters idle just because the domain
> specifies an idle state with residency. This is also not desired.
>
> Also, if the domain checks for next wakeup, should the parent domains of
> the domain also check for next wakeup? And when do we set that up? These
> are questions that we don't know the answers yet. So, let's enable the
> domain governor only if the domain sets up the flag or when the device
> in the domain specifies the next wakeup.
>
> The previous post of the series explaining why this is a useful feature
> is v5[1]. Please let me know what you think.

Ulf had comments on the previous versions, so waiting for him to
respond here, thanks!
