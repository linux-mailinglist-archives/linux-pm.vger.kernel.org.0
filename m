Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3143B1785AF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 23:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCCWbl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 17:31:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33444 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCCWbl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 17:31:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so74101oig.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 14:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joFWQyZeoE78YZRD8I3xJS7KE/HtJMu5+4p7KngoND4=;
        b=DgvSeKG2bTaAOUp9scJtYpXJbz3/NeJH0wQm6xUJ2xaAUq3b1iw1v0ZIAkBjiRgTEf
         eeSuW7wO8cbuOcrBlG5u3qqCRgE38PQ0+u/cU3Tn3Rq93LboqKzWbsPC302rF0AFTsRY
         PWpfUYo4iat+bnOqHr2d/Bmact1qVZNT2kfTra+yQTF378d8cmb9QnkkSvzP4oiMeYOM
         MRQ6kWdO540LQNNEcpqxCGV9osEOaTCUZBiraqGbXPCzvMltPNPTAJB5xlomP/R3HtGZ
         zM++RsromrSUGsNsjhhpS6YOJ4cC48GF7rz5gQXCyVVkXUVKLm6nA5LS2WTGPGH9z3ND
         I+tg==
X-Gm-Message-State: ANhLgQ0nQMMVXyjYj7uBmv2QO++yX/B3zV6jSzvbll4BvVp4VuQq9Qrw
        FfTYknKzPzmkVQKpU4nmuAoR1eBIylEhRKWL3UY=
X-Google-Smtp-Source: ADFU+vurLnLpD/2EN3jHX8OhAU4NFpufhGK3chZPzmFqG5Imtn+T5wJ8rYXLqSYgvoD5dH7oi1pYIoW3YNFeoWW/qSU=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr553188oif.57.1583274700180;
 Tue, 03 Mar 2020 14:31:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583243272.git.mchehab+huawei@kernel.org> <0bda11fd334238a21e429355616caff26e99cc77.1583243272.git.mchehab+huawei@kernel.org>
In-Reply-To: <0bda11fd334238a21e429355616caff26e99cc77.1583243272.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Mar 2020 23:31:29 +0100
Message-ID: <CAJZ5v0g7KjaDCnvksovTv5qPKih8dw2M-RcG94i4ZaR1zS84_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] docs: cpufreq: fix a broken reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 3, 2020 at 2:52 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The old cpufreq docs got moved. Let's also update its
> pointer inside Kconfig.x86.
>
> Fixes: 78a0abeca1bd ("Documentation: cpufreq: Move legacy driver documentation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/cpufreq/Kconfig.x86 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index a6528388952e..62502d0e4c33 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -25,7 +25,7 @@ config X86_PCC_CPUFREQ
>           This driver adds support for the PCC interface.
>
>           For details, take a look at:
> -         <file:Documentation/cpu-freq/pcc-cpufreq.txt>.
> +         <file:Documentation/admin-guide/pm/cpufreq_drivers.rst>.
>
>           To compile this driver as a module, choose M here: the
>           module will be called pcc-cpufreq.
> --

All of the patches in this series applied as 5.7 material, thanks!
