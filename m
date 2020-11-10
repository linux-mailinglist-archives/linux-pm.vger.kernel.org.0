Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF4C2ADE9C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgKJSnh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 13:43:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41793 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJSnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 13:43:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id n15so13537047otl.8;
        Tue, 10 Nov 2020 10:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfF817wJaKnDcwT0IKwc1uZghn3u6l9Ye68zq2YepQ4=;
        b=dbG98dFfBLRxD8drxvR28faKe9i2vy5hpxiQZhN39Wc13ZqCcXGyLy6/OoWAzHKIis
         Fazp8LmxfhUJJsyzOSUgasZUE+HT8AABly7KG0S8YPbggVO5XpgTbD+kESUR08TfXhUb
         c3crBVq2pwV20viGjCBxpOj2d1ADD9m/MHOWO70LXjRV/FL0aYhkK0f3iz+gw0XNeKiU
         0/o78U+4fjL7jEURVBBb2Q1mtOtWz4Ul+7E5oH6p13TsVYzRw9NuOsKPYYYigtexj35S
         v6GGEOa2CB/4kouqlEcy+o/Nn6Hy1CiyrrTKR6bzRdRXeby50xTeDumBzKhkPmc6ruoh
         4hbA==
X-Gm-Message-State: AOAM532mHVvZVFWRzFOhGgAq+B0mvv6vzIN+HB4ICXKbn51RaOLT+Z1f
        UlycBmPj+sYXxt7+mHs/CucRuCTlGRltvPQBCqt7g/6Q
X-Google-Smtp-Source: ABdhPJxq07j93VE1nFV7eLHotemy6m3UOXzm0GmXLearoWZTy6R/eBXSo/yppKxoZoU7GHPZ1KVHeua4k9bodvTGS7Y=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr15722847ota.260.1605033816601;
 Tue, 10 Nov 2020 10:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20201023110254.26360-1-yu.c.chen@intel.com>
In-Reply-To: <20201023110254.26360-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 19:43:25 +0100
Message-ID: <CAJZ5v0jxAwOHbUwpqibvjW-LbZmhOPwaPrekZ6JRcQVGKb+AjQ@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: Print the driver flags of device during
 suspend resume
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 1:02 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Currently there are 4 driver flags to control system suspend/resume
> behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Print these flags
> during suspend resume so as to get a brief understanding of the
> expected behavior of each device, and to facilitate suspend/resume
> debugging/tuning.
>
> To enable this tracing:
> echo 'file drivers/base/power/main.c +p' >
> /sys/kernel/debug/dynamic_debug/control
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/base/power/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 205a06752ca9..be6744bdfc93 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -442,9 +442,9 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
>
>  static void pm_dev_dbg(struct device *dev, pm_message_t state, const char *info)
>  {
> -       dev_dbg(dev, "%s%s%s\n", info, pm_verb(state.event),
> +       dev_dbg(dev, "%s%s%s driver flags: %x\n", info, pm_verb(state.event),
>                 ((state.event & PM_EVENT_SLEEP) && device_may_wakeup(dev)) ?
> -               ", may wakeup" : "");
> +               ", may wakeup" : "", dev->power.driver_flags);
>  }
>
>  static void pm_dev_err(struct device *dev, pm_message_t state, const char *info,
> --

Applied (with some edits in the subject and changelog) as 5.11 material, thanks!
