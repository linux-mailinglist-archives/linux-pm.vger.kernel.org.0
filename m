Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EA4469501
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 12:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbhLFLa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Dec 2021 06:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhLFLa6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Dec 2021 06:30:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C3C061746
        for <linux-pm@vger.kernel.org>; Mon,  6 Dec 2021 03:27:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d10so4525976lfg.6
        for <linux-pm@vger.kernel.org>; Mon, 06 Dec 2021 03:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9l63LtAsEZ6fYHmNhW8V7RRUrW8tCaNYojj6Fpbnsc=;
        b=uhNWdOyxLAH1Gc7+kfxaRvlBBxUi+OUvBxT5uZ0MOKxizvOmvT318NzaXaxpgw/j12
         7lRwLYKdcc5KUs9Fc50Fq8DKy/A7KKAeq8cff7oh8663DfqPnV2vwd4HJV2xgc85tANm
         J2BclrLK3nrm+2VdoUwNv+J9IfzZ9sBQpnaagZJ7SDnMJqTOQBFLVuLc0qihXmhluHPf
         Ty1PfL08Bau65qVKyF/4HKxHZgtOeH0/EXHXFObc9F0SvFeSEFerQLHFdTm4wp+ULNww
         VsVL16KfxarQ+zyZ4j+WJjHKFlA8res7tCsbIob1g/eJkCUTNHAKc2oJUIN1JAcNRgcw
         cc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9l63LtAsEZ6fYHmNhW8V7RRUrW8tCaNYojj6Fpbnsc=;
        b=S2QECEKVQp/lU21jgxiiBoBydj5PupUcH+xxQI9VD91yN2aubr/Glq0me9VDkHC2iP
         qb3vZj/lFMndqORm5MiWxI3lCYvbj/jmu/PoEnqCHti6eokJ7yafitd4Vnxy9TJUDg+0
         zVuNWYUfEaU8Oi6acxX04q2KZRgAy4PBT5v/7sXyrUsGbkq/ViNwU5SNW5QvgFgfAhAH
         TpWsS/+odsRjn36XE7C0hQYSonUMSH9UnfEM8KLdcEayDAfUXKTuLeaA5JMy/KnvQ87P
         uQ5gg7MGhLyMjq2j+LPFy1dV5eIJnueGT9TG5tybs+YVDi5VLMCRFSEDN/dtM57S3LLy
         Rvig==
X-Gm-Message-State: AOAM533WSG5BJ+b6NmeYJUaIbVqVKMMX4SuKHUDww79GCygt/QPdlkfY
        HlZ0z+lthq09eFDzo8QqmBc8oicFYaxp4/YlB19PYw==
X-Google-Smtp-Source: ABdhPJwdIQ1dnfeDSo3UmRCh16RMfUAdPKZVinqmUpBJqmAuCFq6pTZ0DBJ+jHVBxeOd5eeEcWhJfajHk8NyYduX3rE=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr35870671lfv.233.1638790048200;
 Mon, 06 Dec 2021 03:27:28 -0800 (PST)
MIME-Version: 1.0
References: <2633024.mvXUDI8C0e@kreacher>
In-Reply-To: <2633024.mvXUDI8C0e@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Dec 2021 12:26:52 +0100
Message-ID: <CAPDyKFq4KPbrQM7B79NsE1MjiOJ-3rRNt8ZEN+JvW=_pS-1JbQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Fix pm_runtime_active() kerneldoc comment
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 3 Dec 2021 at 17:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The kerneldoc comment of pm_runtime_active() does not reflect the
> behavior of the function, so update it accordingly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/pm_runtime.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -129,7 +129,7 @@ static inline bool pm_runtime_suspended(
>   * pm_runtime_active - Check whether or not a device is runtime-active.
>   * @dev: Target device.
>   *
> - * Return %true if runtime PM is enabled for @dev and its runtime PM status is
> + * Return %true if runtime PM is disabled for @dev or its runtime PM status is
>   * %RPM_ACTIVE, or %false otherwise.
>   *
>   * Note that the return value of this function can only be trusted if it is
>
>
>
