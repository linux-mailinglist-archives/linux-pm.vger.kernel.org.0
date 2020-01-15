Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28813CBF5
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAOSTJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 13:19:09 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36277 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgAOSTJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 13:19:09 -0500
Received: by mail-vs1-f65.google.com with SMTP id u14so11028093vsu.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h013w+9WgJO2kYWk7JjC3zQtUFZXFRw4gnhS7EAhQaM=;
        b=GsPYFTKsSyIh7bghmpg7jcxT0kREYJjrjxEraVDNu3vblrX5fNUroHzHfbMK4mHOkR
         Q6RDy2Ebwieo9D8EG69jUl0YSe/6W7vdUu3/wyUJ2DgDL3ZxXHeBmlp/sCCjeEUJbX94
         2uHj7m/PhttTODgI7RJjxbV1J+1VC5qjnGDXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h013w+9WgJO2kYWk7JjC3zQtUFZXFRw4gnhS7EAhQaM=;
        b=GGeYaJ3oiMPt20hcsBqfVbcIbrO3P3gUJXYyeOStZqfNmkshP+Ja8UwRo6Dgqza5b4
         6lR43uxcDrdbOGx9vEup+YgjdDcp8knSzN0bq1Nk2ZbZ08aj3cefAtuS2dEisrhwBUMG
         KiVsrIUO8SsQshhqE0DgHIWWYoDFeJBTg53r48J5qzDdPsXqN+ukS7nI4RbuiXw4d7up
         kZs+fZD41CqwmmCjVK9fjX3zJwIb7JWYGamLYchOUS3f793WweLzlZGeg/jIcq/s1gCp
         QvZv8W3Oxr2FLQ9R0/UWH8AHs1s5W5pS4nealae5aS5Ov4IMO2w9PnMLa1g3K68qxL5P
         QppA==
X-Gm-Message-State: APjAAAXGFKgNY8uFBHt4FHxZ/qLBRvUE9rrQ1TXEmN0sPWTLaFTv3m1L
        nSj/PfcmEDZYh4Iz+YuOC2rfdmnrYBc=
X-Google-Smtp-Source: APXvYqz5hyC4oLUoUxGxgJhuY1b+sESg+dxazNy5STeqw9yoacZ+timUx6rvsCrWkY83xHlVKzX47w==
X-Received: by 2002:a67:fc1a:: with SMTP id o26mr5482998vsq.229.1579112348316;
        Wed, 15 Jan 2020 10:19:08 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id q25sm5591247uao.0.2020.01.15.10.19.07
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:19:07 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id z24so6626268uam.7
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 10:19:07 -0800 (PST)
X-Received: by 2002:ab0:5c8:: with SMTP id e66mr15143592uae.120.1579112346977;
 Wed, 15 Jan 2020 10:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20200115013751.249588-1-swboyd@chromium.org>
In-Reply-To: <20200115013751.249588-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jan 2020 10:18:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XS4iPbxzBNHrmEQYCy5uEzce3Oucu-Jveoycc8hJn10A@mail.gmail.com>
Message-ID: <CAD=FV=XS4iPbxzBNHrmEQYCy5uEzce3Oucu-Jveoycc8hJn10A@mail.gmail.com>
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Jan 14, 2020 at 5:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This tracepoint is hit now that we call into the rpmh code from the cpu
> idle path. Let's move this to be an rcuidle tracepoint so that we avoid
> the RCU idle splat below
>
>  =============================
>  WARNING: suspicious RCU usage
>  5.4.10 #68 Tainted: G S
>  -----------------------------
>  drivers/soc/qcom/trace-rpmh.h:72 suspicious rcu_dereference_check() usage!
>
>  other info that might help us debug this:
>
>  RCU used illegally from idle CPU!
>  rcu_scheduler_active = 2, debug_locks = 1
>  RCU used illegally from extended quiescent state!
>  5 locks held by swapper/2/0:
>   #0: ffffff81745d6ee8 (&(&genpd->slock)->rlock){+.+.}, at: genpd_lock_spin+0x1c/0x2c
>   #1: ffffff81745da6e8 (&(&genpd->slock)->rlock/1){....}, at: genpd_lock_nested_spin+0x24/0x34
>   #2: ffffff8174f2ca20 (&(&genpd->slock)->rlock/2){....}, at: genpd_lock_nested_spin+0x24/0x34
>   #3: ffffff8174f2c300 (&(&drv->client.cache_lock)->rlock){....}, at: rpmh_flush+0x48/0x24c
>   #4: ffffff8174f2c150 (&(&tcs->lock)->rlock){+.+.}, at: rpmh_rsc_write_ctrl_data+0x74/0x270
>
>  stack backtrace:
>  CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S                5.4.10 #68
>  Call trace:
>   dump_backtrace+0x0/0x174
>   show_stack+0x20/0x2c
>   dump_stack+0xc8/0x124
>   lockdep_rcu_suspicious+0xe4/0x104
>   __tcs_buffer_write+0x230/0x2d0
>   rpmh_rsc_write_ctrl_data+0x210/0x270
>   rpmh_flush+0x84/0x24c
>   rpmh_domain_power_off+0x78/0x98
>   _genpd_power_off+0x40/0xc0
>   genpd_power_off+0x168/0x208
>   genpd_power_off+0x1e0/0x208
>   genpd_power_off+0x1e0/0x208
>   genpd_runtime_suspend+0x1ac/0x220
>   __rpm_callback+0x70/0xfc
>   rpm_callback+0x34/0x8c
>   rpm_suspend+0x218/0x4a4
>   __pm_runtime_suspend+0x88/0xac
>   psci_enter_domain_idle_state+0x3c/0xb4
>   cpuidle_enter_state+0xb8/0x284
>   cpuidle_enter+0x38/0x4c
>   call_cpuidle+0x3c/0x68
>   do_idle+0x194/0x260
>   cpu_startup_entry+0x24/0x28
>   secondary_start_kernel+0x150/0x15c
>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> I think the commit that this is "Fixes"ing is a stable commit, but I'm
> not positive.
>
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not an expert on these code path, but it looks sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
