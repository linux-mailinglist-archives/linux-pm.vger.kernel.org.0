Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187624792BB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Dec 2021 18:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhLQRVx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Dec 2021 12:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbhLQRVw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Dec 2021 12:21:52 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580CAC061574
        for <linux-pm@vger.kernel.org>; Fri, 17 Dec 2021 09:21:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bi37so6062477lfb.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Dec 2021 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DKDbAPgWRjftMAZ4AX+N8/6OW1hd8YHK7CRuaZo7N9w=;
        b=qu+YVNL1Go+MIEgGIY7uj/TwjkgWTIdWamj0auq+OBGR7dMiNzlNoCYR2xxid8Dzfy
         r5wHMtWoj9QInRSl317LoLr5jq15ch1hCb8hhoaoQrxmThuqq4D46zGMEm9TYbdrU8GH
         dS+vuM+G3uAGfHWbNdna2D/Fa8P3NhBeGjM4KEm2u0+3qPHJ1tpnjNGUZizDaqrwHDn+
         Oenf5vR+h6ZW+GVuR5yoyYryk0E1aXBDYsgdOjZwxFY+5algQQ1rFl/jFFXyGRq6A0kG
         ddmlYNEK2H9XCdgogx8PVurzpUzFfR0ERZ49mknKyjkGziJ6kl6iueBjPPrbDGhw41rV
         1+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKDbAPgWRjftMAZ4AX+N8/6OW1hd8YHK7CRuaZo7N9w=;
        b=UG9rgAgkxf/Wx2LXZAyQAsJbof65/udsnh5FVLk8gyq/Oi5m2GQgFPHc6KdOXvMh64
         +MoRSN6j5JQDhXpPiW6v646gxt6L5mfXOi8nQL4KuVkdbB8jbRGzBASZqWyaf+tV8014
         qZHOEPMPb+KBg37IfsoFKP0AqaH1U4+UdQAqL0piRoUgJMFdMZyQnWhFNV64NkZwQyOo
         ff9PmPVP0kChqVFb3QSHuzi+JOxXAzUbGFa5HL9WMjPzMGDiVx1CGhpfseiX9SvoBZi7
         UoJDUNqD0e0pCF5fijSxsiiN61unGRsvUDjakUQpoN6BbJQha4eAVrV6icrm0lydO/9U
         gFmA==
X-Gm-Message-State: AOAM531pWWVHG5Zg7aGgoIb9Oqb4a47AkCo4pNq9fEuADvyc4Cyyh+50
        ZFBEH3leRvTizzPVBV8YbzxIqId15TBR92iW7zokbA==
X-Google-Smtp-Source: ABdhPJzbCesvIKQ6uvwOZDusnV1v5sFY5Iq4dhVjpVN+PZ84oR7hXwi0dw6qDoxHODpMYgHvc2xRM2QAczMdz3rmjX4=
X-Received: by 2002:a05:6512:310e:: with SMTP id n14mr3676224lfb.167.1639761710665;
 Fri, 17 Dec 2021 09:21:50 -0800 (PST)
MIME-Version: 1.0
References: <4717160.31r3eYUQgx@kreacher>
In-Reply-To: <4717160.31r3eYUQgx@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Dec 2021 18:21:14 +0100
Message-ID: <CAPDyKFqGixF-GEMHBPjFpzRoFS88JyJTHwoBHbyaB+OTBNw1pg@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Fix error handling in dpm_prepare()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 16 Dec 2021 at 20:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 2aa36604e824 ("PM: sleep: Avoid calling put_device() under
> dpm_list_mtx") forgot to update the while () loop termination
> condition to also break the loop if error is nonzero, which
> causes the loop to become infinite if device_prepare() returns
> an error for one device.
>
> Add the missing !error check.
>
> Fixes: 2aa36604e824 ("PM: sleep: Avoid calling put_device() under dpm_lis=
t_mtx")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/power/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1902,7 +1902,7 @@ int dpm_prepare(pm_message_t state)
>         device_block_probing();
>
>         mutex_lock(&dpm_list_mtx);
> -       while (!list_empty(&dpm_list)) {
> +       while (!list_empty(&dpm_list) && !error) {
>                 struct device *dev =3D to_device(dpm_list.next);
>
>                 get_device(dev);
>
>
>
