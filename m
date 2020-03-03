Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AF31785A4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 23:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCCW2C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 17:28:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38088 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCW2C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 17:28:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id i14so48818otp.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 14:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CvqyOnwi+PkF9Fgr16wftCTc9EZXvOILmAuEvAl6u4=;
        b=D+YL5bJrNyOAX2EjKPCJa/6/zU+0dkSSdg5CLZG8d+W7hj4dt/FeZAraCTvYWM1tyz
         Lva15or0RCeHCehVC1tUFT42BGn2kxlx5zMaZ5dSXpe8BiiUXXY7upcFb7Zfk4cBg96x
         DONA3eIjSY58g0Vm0EkpnWQ2MGnO1EE8BplMlYybf2SjTkDQ2yLkC0vsiRWDquqiHW7e
         BzbZ2o9RkZ3t0PATG5QLoMBZze3wxPG5+Y46oWMn2ylmmfKT4Mw9aXX+opGHILOo5k4Z
         EGaBPCQQw/4Xst1Ng290kaXGTC3Z5BQ58Hgl5kYndLzG41aTE851MLx/GxrnvKMhT6UK
         Xskw==
X-Gm-Message-State: ANhLgQ2ap1c4AB/xIW+iIENatzJes7aBDDEqKCY4Y472tOh122c1vlHH
        s4nxdGJ9MkiQIcp1RSv5CyiPfVtLWJ6oxgttFFB9VA==
X-Google-Smtp-Source: ADFU+vsm8mIq56uAO4umHWhF6LNaWtfXccWDZb85aQiftvL3HYrQ23QOp0tfNIX9jse7T+Yb5W6IL5LTXXypLpgZBug=
X-Received: by 2002:a05:6830:110:: with SMTP id i16mr62733otp.189.1583274480489;
 Tue, 03 Mar 2020 14:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
In-Reply-To: <20200303203559.23995-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Mar 2020 23:27:49 +0100
Message-ID: <CAJZ5v0j86N5WgEJhCD6a7K2NG7NoK-wqG5h-vbc-Z7qH4fkySQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cpuidle: psci: Some fixes when using the
 hierarchical layout
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 3, 2020 at 9:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - Small changes to patch 3 and 4, see their changelogs.
>
> While collaborating with Benjamin Gaignard to deploy the hierarchical layout
> for an ST SoC, it has turned that I have clearly missed to test a couple of
> corner cases in recently added support to the cpuidle-psci driver.
>
> This series are fixing the issues we have found.

I can apply the whole series, but I'd need an ACK from the PSCI driver
maintainers for that.

Thanks!
