Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111E518F52B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 14:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgCWNCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 09:02:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35991 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgCWNCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 09:02:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so14658402oib.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 06:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MNejHvrYUFPqO165+Fp6JJRp0meFh3YZTg/Ac7HWTk=;
        b=qIry9rybl2SV+CODzDm7lEf9AGKHJ1jww/ICB51o9fAmbzI3nCV5AIQiuD98DFiqh9
         e7jOhIuIAv2+tqrvC+Yaf9HN6mGs4ce1I9Uc3Z8sBnn6146poKVb8i4RMnAlRjI6/9qf
         wwsZCy3t2TVNFMpGRP0w6/VGnJbFQrvLaIOuvVWJcpRqVQzUCAYqnixmvRSrSkDAPVB0
         AVi3quPbtG5ZW+3SdoGnZr4fV9hynKut6pIJKrFaW+VazUGKHF+jxuH7CwrVC6LsVzQx
         fTgiGMdTNQn+vMjb9eNf2MlFgjwS/RLNbMULRfChW8J2KSh5gwGWYo8OXuB9jmCLttQE
         34PA==
X-Gm-Message-State: ANhLgQ0iY4r0ppDMEHt3bK6g5JcFR/gx7Vhf119eHkIpcibkVs9W1fiq
        uSq8rkdBDz7bDsRbUaBF0k7ElXLwt3ahRygX5vc=
X-Google-Smtp-Source: ADFU+vs38uizI6VgDD3BKYog5rOH4/RKD3tAD520Db5hQEmQ7QayadM4xzCedKnoXHql4IpQiiGtHzz1ZKL6NP7ieVE=
X-Received: by 2002:aca:5f55:: with SMTP id t82mr2158620oib.68.1584968558658;
 Mon, 23 Mar 2020 06:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200323062745.wt6i5lpvgjnor7sn@vireshk-i7>
In-Reply-To: <20200323062745.wt6i5lpvgjnor7sn@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Mar 2020 14:02:27 +0100
Message-ID: <CAJZ5v0hMuERF2u+FUrfZ16JuqrHgi+V4jOLgLYw_An0uY6ngSw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.7
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 23, 2020 at 7:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - update to imx cpufreq drivers to improve their support (Anson Huang,
>   Christoph Niedermaier, and Peng Fan).
>
> - Update to qcom cpufreq to support other krait based SoCs (Ansuel
>   Smith).
>
> - Update ti cpufreq driver to support OPP_PLUS (Lokesh Vutla).
>
> - Update cpufreq-dt driver to allow platfoem specific intermediate
>   callbacks (Peng Fan).
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
>
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

Pulled, thanks!
