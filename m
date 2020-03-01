Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCBE174F6D
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgCAUJj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 15:09:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46255 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCAUJj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 15:09:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id g96so7611398otb.13
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 12:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtD4IYwYS7GzofXx2+a8VRKjZpPgD2sFbmNmLzogN9M=;
        b=dz3IyhN5C16rDH2td5yrJTlvx5Vv7nRvyAxwusQ7gpwneLGYj+Goqjzd6PKLtNiDK+
         by3/vmr3coHCeRv0RMvkkCw/M5xKRWO9XHGZ/QBP1ti4yjlw+Y8WlUW3LhX1E1oWEb9f
         pdKnMWWcEnXpvsv3pD5fzlBhpfseiP8zahtJoomKtRmevwDLbBk+qtPVAtP4cMGQbS4I
         ZgFLwNxnpglxdyJ56MYI9roRKvEgaPdikQO+VL5Gc0j4Hqz7zo4ajcdJ80lIjryrX9Qy
         HBEDvgO1QgXSbbaz6g+eZVOv/0DxT0f7DhK701J7jslxzzI80N9O96ezikhU93XpIYbS
         +zeA==
X-Gm-Message-State: ANhLgQ1To6sVsgCHNMleNZ9wrgbnX6s7BqF+ty/I8cNighhej9KmoE4q
        XrC/iMfjztdPAsBE1DXLvyePQdS2HkLrttFTBrSgXg==
X-Google-Smtp-Source: ADFU+vsgTnwoQJsl2QX+sR58R5F1jdB0HHzyxcAj/Ey8vzvvMa38N6Ez+MLzl5vIIiQGcKf9/0U/fmlPelMSqJ9XZNk=
X-Received: by 2002:a05:6830:110:: with SMTP id i16mr2126749otp.189.1583093378645;
 Sun, 01 Mar 2020 12:09:38 -0800 (PST)
MIME-Version: 1.0
References: <1583069198-21060-1-git-send-email-qiwuchen55@gmail.com>
In-Reply-To: <1583069198-21060-1-git-send-email-qiwuchen55@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 1 Mar 2020 21:09:27 +0100
Message-ID: <CAJZ5v0jqGm-u-inJ4R-Qd=muqyKHxDOGAdtgaaxMq6BHa6Wwnw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix a mem leak caused by policy->max_freq_req in cpufreq_policy_free()
To:     qiwuchen55@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 1, 2020 at 2:26 PM <qiwuchen55@gmail.com> wrote:
>
> From: chenqiwu <chenqiwu@xiaomi.com>
>
> There is a mem leak in cpufreq_policy_free() that the resource of
> policy->max_freq_req pointer is not free.

That's incorrect AFAICS.

Thanks!

> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index cbe6c94..6756f7a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1280,6 +1280,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>                 blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>                                              CPUFREQ_REMOVE_POLICY, policy);
>                 freq_qos_remove_request(policy->max_freq_req);
> +               kfree(policy->max_freq_req);
> +               policy->max_freq_req = NULL;
>         }
>
>         freq_qos_remove_request(policy->min_freq_req);
> --
> 1.9.1
>
