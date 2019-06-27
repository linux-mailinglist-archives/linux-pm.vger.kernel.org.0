Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D858D26
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0Vem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:34:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41396 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0Vem (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:34:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so3526773ota.8
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 14:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+AaJx3KDxvObWQHNBpCXdRZgBJlDteWyk6o/dNLc7E=;
        b=cCqi4VuBvkoYvYSVJ8a2PIIovwaJGzVPc4D7md+eFdLhmbNSvlvmLkMIf3oS2VLfBX
         Xv4k3LzrQX4eVyrlALQWFSSuvZs83Qxtr4hskWWlaG8ZZqMr/PcIH7LPr90COs3YIloX
         p7id/oXVweP9y84zhQ41ufHQnbkCMTeC5DSZLrEmvfO80bsgEuXru1MQfhSgPtZgPJjn
         h7NWCFMPXO4wjFXkeH02726b0fsCy8SAISNDVCwVosh2G0sjVKUQWm84w7k7fhwTOmkd
         MF17Kgql/x+FgFni1BxvfsiIbcP6U709CW82tFAPCtkyyfiGnYQq73pgYv/KjmXoJDtS
         87iA==
X-Gm-Message-State: APjAAAULotsKQHz2t0rAXu0z3F5wYQLJFTnASUQZ6KrO/f0K17r/pAlR
        O/2rDNXm1N/1ClQuyBW0zlFaIj99cl3ZVOHMeTI=
X-Google-Smtp-Source: APXvYqwhIOGnE3+nCiMYpr9kNlR8WAVvaB73GPsewHRu8hL5Ls/mInKzy4V51HgwlShmxbybbU0m2vqOxdDNIuNNCJM=
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr5301439oti.262.1561671281406;
 Thu, 27 Jun 2019 14:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190626072027.kjqfwwbvacn2s47o@vireshk-i7>
In-Reply-To: <20190626072027.kjqfwwbvacn2s47o@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 23:34:30 +0200
Message-ID: <CAJZ5v0jxZOjhsgGeb7zHbuNL0AUQBXiezD1LfOrC51Q9V-mCXw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP changes for 5.3
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 26, 2019 at 9:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - OPP core changes to support a wider range of devices, like IO
>   devices (Rajendra Nayak and Stehpen Boyd).
> - Fixes around genpd_virt_devs (Viresh Kumar).
> - Fix for platform with set_opp() callback (Dmitry Osipenko).
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 560d1bcad715c215e7ffe5d7cffe045974b623d0:
>
>   opp: Don't use IS_ERR on invalid supplies (2019-06-24 12:48:29 +0530)
>

Pulled, thanks!
