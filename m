Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB0113F1C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfLEKNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:13:11 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36115 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfLEKNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 05:13:11 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so2236579oic.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 02:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m78asFY8f9keRUsJds9leXbmRNR06quDYSTULIN8+YQ=;
        b=nTtiWby+dr7k3xuwsgPG4QOlic2lDi0R3r4bhhmj+3ogbPikdb497eHKkYPb1UpKW3
         Xnnaz/OBSY2S9DGPkpnv0SfHy9qhy32lHyxxn+fS8aafNXA3vgOvDhqm1p3sBJms+XdI
         sJgYjmmPipmFVPNDn47Ql38CFyp33/VK80w2sBAFSLJr3y/tdwynkYH2dKZKiOO6vywd
         mFOTN/DiDeMMtkia3OaQea97wY8kZv4Rk+b3vuCBI2+zCwZj8lNoSTbxErgytS10XrfR
         /fcPqYka2DKav51Z8RkN8dSRQ/VSG2ms5ZmfuVkd2pCd5IjpsktO5a9wNHkNcmUVS9VO
         7zhw==
X-Gm-Message-State: APjAAAXoy+2h0KEEuRyqNo6gEpK6/kmhPCyVpmbmnwRhEebooblQgKem
        Zu80yo21cif1ibHRoJ0dy/c3oy2hsfYUFDtv+ECTWA==
X-Google-Smtp-Source: APXvYqxlJ4nr1ALVQf+7/s0+lWl9F+YOMbALAF5Gk3t3B6/fuqAbhj2tJ9gsmK1g2Og/A6YnHkKQCe0trRHF28BhW+0=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr6258345oig.68.1575540790133;
 Thu, 05 Dec 2019 02:13:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575540224.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1575540224.git.leonard.crestez@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Dec 2019 11:12:59 +0100
Message-ID: <CAJZ5v0jEuecAUS_BmxEWVdiMXEKh0ScxH1UW6udONxzqL+c3Vg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 5, 2019 at 11:05 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> Add dev_pm_qos notifiers to devfreq core in order to support frequency
> limits via dev_pm_qos_add_request.
>
> Unlike the rest of devfreq the dev_pm_qos frequency is measured in kHz,
> this is consistent with current dev_pm_qos usage for cpufreq and
> allows frequencies above 2Ghz (pm_qos expresses limits as s32).
>
> Like with cpufreq the handling of min_freq/max_freq is moved to the
> dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
> store, instead all values can be written and we only check against OPPs in a
> new devfreq_get_freq_range function. This is consistent with the design of
> dev_pm_qos.
>
> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
> need to take devfreq->lock, this means that calls into dev_pm_qos while holding
> devfreq->lock are not allowed (lockdep warns about possible deadlocks).
>
> Fix this by only adding the qos request and notifiers after devfreq->lock is
> released inside devfreq_add_device. In theory this means sysfs writes
> are possible before the min/max requests are initialized so we guard
> against that explictly. The dev_pm_qos_update_request function would
> otherwise print a big WARN splat.
>
> This series depends on recently accepted series restoring
> DEV_PM_QOS_MIN/MAX_FREQUENCY inside the pm core:
>
>         https://patchwork.kernel.org/cover/11262633/
>
> It would be great for this to get into 5.5-rc1

Not at this point.  The earliest realistic target can be -rc2.

Does this still depend on anything which has not been included into
the Linus' tree to date?
