Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA91358AFE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhDHRKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:10:37 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35378 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhDHRKb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:10:31 -0400
Received: by mail-oi1-f176.google.com with SMTP id x2so2924521oiv.2;
        Thu, 08 Apr 2021 10:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXeneS4Vm02HCmXz91kKGlV2Pqy/N/GNJfg+AxZBAHE=;
        b=RYPxumAf6cf7yy1Tkj/NfwdzLGDTd72BiGrDNrcHhhxf1XIiW3aqeKZtxxZZfxOFVx
         CAnmQWkQwXmHvA5+GlCYCHWINBYxb56gP4werVJxcrcjlpniWjBc/P7q77BE/heWSYuI
         96D3c1AnMCJE3grvPPCYlINa2oYrSHoGCOfdcNZamJaQdFeP9rBa2pPy3KU0+Jxm8mrn
         B32m4MuY7FwG25q60j+tUD0zQbA4v+BemdbmCgaj4lmYp0cWqYl1o9GHYmbvAmltzTdC
         ZSwOac1v9mTt4Cp+tmzgdiNvj4lRTMy0tXLuAoVUCwj+yqULpgBPzmnBCr4rn24Tw7cH
         +7TQ==
X-Gm-Message-State: AOAM532wGc0VIPKESzNTwzCCLI9Lma9pcwbTH33ds/WgoKAXAO5n2miQ
        xzfUON9WEL7vWi2JWu1b5pHWM5InbOHCFpsI+n0=
X-Google-Smtp-Source: ABdhPJyHJ1ur7FDHpcs0/qsYhAL+F/SFsFucAeoUmeEwMNoj+kzTbjN1rWNzyyHmRG1sJhIIrQaubOIbN9aAqttSDlI=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr6705265oib.69.1617901819073;
 Thu, 08 Apr 2021 10:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210330063923.2269702-1-wanjiabing@vivo.com>
In-Reply-To: <20210330063923.2269702-1-wanjiabing@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:10:08 +0200
Message-ID: <CAJZ5v0huxxwVjbOo0wicMRQkx2vfj1Z6=B7OHTbuKFC2bazxDA@mail.gmail.com>
Subject: Re: [PATCH] linux/intel_rapl.h: Modify struct declaration
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 30, 2021 at 8:40 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> struct rapl_package is declared twice. One has been declared
> at 80th line.
> By reviewing the code, it should declare struct rapl_domain
> rather than rapl_package. Modify it.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/intel_rapl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 50b8398ffd21..93780834fc8f 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -33,7 +33,7 @@ enum rapl_domain_reg_id {
>         RAPL_DOMAIN_REG_MAX,
>  };
>
> -struct rapl_package;
> +struct rapl_domain;
>
>  enum rapl_primitives {
>         ENERGY_COUNTER,
> --

Applied as 5.13 material with edited subject and changelog, thanks!
