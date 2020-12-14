Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791562D9EE2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 19:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440860AbgLNSWt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 13:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440393AbgLNSWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 13:22:39 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7371AC0613D3
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 10:21:59 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so17828100ioo.7
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 10:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+41xOvkhPzXEqvcapSgmuBUeyzzNHctlSYb+O7Udfg=;
        b=Aau1wPH5dsgHO29VfX+VxTNCj9IMmt5rIvftoXO/bq4D6zbBNoKiIAYGlrrGbg3s4a
         ny8wWnW+k5CkpM9oUOWjA9THy5+XPam64aYJ7vcyR4g9nryf1DL0iLcxwycbUUYPARMc
         C0R+C7v/Ad5omW+4wH3rut8YA5a/xsZTbwJXxW2992cIn5I6qy1ECiWsTkYHHRJOPp2c
         TmnL1fkZq+nHXOHwHCL2GoiG82Qrq18xNBmVVdGRoMBVWTi5jJ6OlMsH8XuuwrnD37mE
         lV2Q2LLUGeLYuXNFGFDZLg1ld9oxdOxC65V89GIxMBLWEuzylWjpfkq3yM8IX8Cu+Swm
         yfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+41xOvkhPzXEqvcapSgmuBUeyzzNHctlSYb+O7Udfg=;
        b=AnntVl9V7r+XWKmk/RDVL6v9fk0dOaEL95smnOMqCASEC+5WDTMbDNLwfngskb7/Cz
         KspQVli54ifUXez+wEBtG0gShSihBEnHutefoBSH5bRaUGB7djKmbCWc6LbQigFhVGDV
         LEvmRyZH55UCBzeg22Vsg2SwJs7HrxNiOf8tgNxVjFB9bEWyUZ2MiKs4AarniuN8am8P
         oCdD2oJa8qeYvRGWvrd5GYXJfOlIpHyKYYDibFkDryq8ixwxiIxAUuWCIWwIMuWB4/Ef
         jF3cSRHcseQa7OWTxpIe7SigGpUxh6HXHfesPzZq+GamAwLmDfVeR7rQYAR4i2SKnGvA
         1HRA==
X-Gm-Message-State: AOAM530+Bzk4AwPnoJjY7OrsSqnvs5yWfrazBeekVpRcKyDZrKg4zMym
        teUKhR37PjWXWvoqn+UafXJe5+piCNQPPScMqxVZIA==
X-Google-Smtp-Source: ABdhPJzwB0h+D+HhtQZhHSJ9tzlx8igt+fPegWrdwU5IjnflYC5GvtHfPxSH5LUVMhmFYAOcJk6a4lQ0vSKR2CFBYkM=
X-Received: by 2002:a02:23ce:: with SMTP id u197mr34431744jau.113.1607970118675;
 Mon, 14 Dec 2020 10:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20201130053640.54608-1-kai.heng.feng@canonical.com>
In-Reply-To: <20201130053640.54608-1-kai.heng.feng@canonical.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 14 Dec 2020 10:21:47 -0800
Message-ID: <CACdnJuv_W1q87wUUEBwMgnQLRuv8SzP7OOxjqY29t2tO862m-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, andrzej.p@collabora.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 29, 2020 at 9:36 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> We are seeing thermal shutdown on Intel based mobile workstations, the
> shutdown happens during the first trip handle in
> thermal_zone_device_register():
> kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down

Is the temperature reported by the thermal zone actually correct here?
101 C seems extremely excessive.
