Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BA395A2E
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhEaMN5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 08:13:57 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37789 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhEaMN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 08:13:56 -0400
Received: by mail-oi1-f172.google.com with SMTP id h9so12105192oih.4
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 05:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xeIrNxGUUrupyJvBT9/ypfeaUXvxtauBqG4MRF0ZP8=;
        b=FqqVracn1khI7gPG2BNwQMyyT3S67ycAj9baBeyv+qUnYGsL4VeYCmEi9pthHOAB1h
         6NODks+UH+QyfqYDczt3UbVDpw+L88S/jlJk64z33w6ROH1UcgJT9LUHz/1x4OhKU7JZ
         xzlqZlxATIRjvgoaN1u539UwUnyUW63cV1CiXH0vvHXgDZXKoPHbiNRHMAAYq6nJE5ki
         TWm3qaCkEmj2nQ2T+aIM8n7SpaXuhHXqX7s6MC7w8Ypnc1SNGmsN0DpVpHRWlfZZWZWY
         9pOUvhqOFIjyymVw0qSNN7UPWo7xK5OR+CqbXPnzoPA69Cgnt6i5PP1LGFCGkDwmP+93
         Q/yg==
X-Gm-Message-State: AOAM530jgL5kIvaAcQ199J+u+euCmqP34wgSaKWDmI9wVbEyKVX7Gziv
        7y/PWWBmbzpaw7y4YQiwxC6Fm+PQ1zQ+jdnj0e+KYSXb
X-Google-Smtp-Source: ABdhPJwxaSztuVoioAigkxD0SFM8FJr+Sufa5yp15dSYuINSh+xkIoIDj+W7h9tHT/fsAq8mXwIWPTuwTT/QFvCEmyE=
X-Received: by 2002:aca:380a:: with SMTP id f10mr17778536oia.157.1622463134120;
 Mon, 31 May 2021 05:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <1622445367-37754-1-git-send-email-zhangshaokun@hisilicon.com> <20210531071924.bfomsgnukytf7yru@vireshk-i7>
In-Reply-To: <20210531071924.bfomsgnukytf7yru@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 May 2021 14:11:57 +0200
Message-ID: <CAJZ5v0hrLc+dj3ARDm9=tS+vDiF+2=VDgCOoKdtVg31+WBTqzQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: stats: Clean up local variable of cpufreq_stats_create_table
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 31, 2021 at 9:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 31-05-21, 15:16, Shaokun Zhang wrote:
> > Local variable 'count' will be initialized and 'ret' also is not required,
> > so remove the redundant initialization and get rid of 'ret'.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > ---
> > ChangeLog:
> > v1-->v2:
> >     1. Address Viresh's comment, get rid of 'ret'
> >
> >  drivers/cpufreq/cpufreq_stats.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.14 material, thanks!
