Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947DE2B7E15
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 14:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKRNI7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 08:08:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34003 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKRNI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 08:08:58 -0500
Received: by mail-ot1-f67.google.com with SMTP id j14so1666108ots.1;
        Wed, 18 Nov 2020 05:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWPHmRgAyAiVkWFvG/avg7cpqXdf1GRFrh8hjqMq86E=;
        b=okEhrb7+23BdfBpE3mg/HskYTShAiiI4VSeB853UcTs5UGz+ar7ivHIwUw6DQggFKC
         a8DBG2V1kEklANpiBQtGWwiGtSiqou37QvwMWMiovsb9plfMAWJXDedBGVg05WXhp9Ek
         WgxCJbOSG+4x8c2vKRihCoM0iedt2KVSd8+vYb7yd1q/gu0y/lEwL7QCht6e/vaR4Umn
         E0t9TIYCD7BqF3cgrIKNQUuprx3o058E8Zpgi/WefVujgjomAigGZCXfajQ0INaDSOB6
         w8tZbDttPvXUVLmcHdfmkLtfZeutVoxUgyVGBBNDiSR/uDEDLzFc/OseJWmOZnB19L/B
         xqlA==
X-Gm-Message-State: AOAM531gG9W7Lh+dYzEAGdOxFHCCx9ftEipk1DiFYh0V/2c+1OLuKUo3
        hXb5asMiovqeUNAbVD19vnxaeWGmHECdmyKXpZ4=
X-Google-Smtp-Source: ABdhPJy9iny0IqrpG8MYq9o9D35sG6dk69ZBYlMT8eGqE1fZ/d1cVv/5SFn1hqFhcKnBcddc5rjGw9xNXONrNYDvMk4=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr6577141ota.321.1605704938085;
 Wed, 18 Nov 2020 05:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20201106073358.8379-1-patrice.chotard@st.com>
In-Reply-To: <20201106073358.8379-1-patrice.chotard@st.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Nov 2020 14:08:46 +0100
Message-ID: <CAJZ5v0hUnQQ2_DjjdXSE107iPNTt+dqcUxWzAH=fE4Qp7Gnnig@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] PM: Add dev_wakeup_path() helper
To:     patrice.chotard@st.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        amelie.delaunay@st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 6, 2020 at 8:34 AM <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Add dev_wakeup_path() helper to avoid to spread
> dev->power.wakeup_path test in drivers.

OK

> Cc: amelie.delaunay@st.com,
>     erwan_leray@st.com,
>     fabrice.gasnier@st.com,
>     alexandre.torgue@st.com,
>     alain.volmat@st.com,
>     pierre-yves.mordret@st.com
>
> *** BLURB HERE ***

Hmm?

> Patrice Chotard (4):
>   PM / wakeup: Add dev_wakeup_path() helper
>   PM: domains: Make usage of device_wakeup_path() helper
>   PM: core: Make usage of device_wakeup_path() helper
>   i2c: stm32f7: Make usage of dev_wakeup_path() helper

Please fold the patches into one and add the R-by from Ulf to it.

Thanks!
