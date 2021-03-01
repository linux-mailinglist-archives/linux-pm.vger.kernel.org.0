Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73754328531
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhCAQuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 11:50:18 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:46944 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhCAQqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 11:46:30 -0500
Received: by mail-oo1-f48.google.com with SMTP id l11so1907073oov.13;
        Mon, 01 Mar 2021 08:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwT1M9CwIR868czbWPMZ1oc4h+pxhg6CDMlbRgC10N8=;
        b=JGlaa9hz4+12ulJG/m+9/jZ2nq4TNeoMkAn7D3ctBRmsC3q+a27hqvU+eVlAkOBDQO
         K04aYZ3Alcas8ioFVhjzSnxZE+MHxgFLuKGhCjvMVWDNCxxS6f/91dsYY8Iah09Et4Wl
         VaZsMCqIHqaHWIBkFxIRq3wongUQWdEr56lM3hIQGp6NWEMFLjQDijOXlDoPSZBvoO2y
         g8/RusotxNufr1LDShy1RYpEJCvflLXJKoHvW2XMpXn+PueBra1+utVLmzjOL0Z2ZEDB
         WjeETc7MlcM9VA2ISzfcUpAHTBO6jTsBOyiA330m9dgGEHsxO/BxzhzOlBLBw6mCMfaC
         pmKg==
X-Gm-Message-State: AOAM532/s4f84KBd2gF6VNyoIIs6fQ/Z9nWJIWUtmmgrFrfMC1Psc++0
        2K0Q1Y8G1amXeGwYXq56aO+sCYwPYx5zT2YioY75+ceD
X-Google-Smtp-Source: ABdhPJyGuCTWr1cs61Tgu5eJVrIRtmKvrsQP9DisOAGV9wpD7gMPnHU9gKZosfyDTJzLzzslRXz8KNzbyKAu9WpFXy4=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr3579908oou.44.1614617140271;
 Mon, 01 Mar 2021 08:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20210224183022.11846-1-daniel.lezcano@linaro.org>
In-Reply-To: <20210224183022.11846-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Mar 2021 17:45:29 +0100
Message-ID: <CAJZ5v0igJztj3fRoGh9AjAPfe01wsBT27X8b19HAyr0t2kRgtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powercap/drivers/dtpm: Fix root node initialization
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 24, 2021 at 7:30 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The root node is not set to NULL when the dtpm root node is
> removed. Consequently, it is not possible to create a new root as it
> is already set.
>
> Set the root node to NULL when the last node is removed.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/dtpm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 5a51cd34a7e8..c2185ec5f887 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -207,6 +207,9 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>         if (dtpm->ops)
>                 dtpm->ops->release(dtpm);
>
> +       if (root == dtpm)
> +               root = NULL;
> +
>         kfree(dtpm);
>
>         return 0;
> --

Applied along with the [2/2[ as 5.12-rc material, thanks!
