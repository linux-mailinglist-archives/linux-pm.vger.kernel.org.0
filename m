Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8DF2941B2
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391938AbgJTRra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 13:47:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33652 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391926AbgJTRra (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 13:47:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id s21so3049099oij.0;
        Tue, 20 Oct 2020 10:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0uibEfz+ciy8ofxK6YZ+EAdpctLhGnvS3VskKto7xY=;
        b=KtTYdHSktybr/ufJQaVQgLBmQb4WW0eCcpf1XR5SGfRlpjbproSdxca1bhnmNDLT4I
         DrW3ZPXzdrw4bkCPxBa+odT0e55K0L/AhRPpcmg3AjrVLLHkV8PQ8z/Urv7jHeE8VoiU
         kC+6Mo/ZCiHgSffPGdw4MUO+bQ/b4wmXhYOcRdoCHHkmw/HeezBxNacBkSGDtE6z8aA/
         RqlYtj84S8FEr/BNYqsnt0BN9sd8f0MxuvZ65ecEzyuIQO0yWhYvOOQJflSZDa3GIN9k
         Cn6g50AASFQQtlBUFcFEF4CHG35VXTLfWn3Njp8i7OChLSR4X6DtFXXC930W8YjLvZUl
         czPQ==
X-Gm-Message-State: AOAM530kPMR4761tk/1xqQKvz98alPFIKhVrNsEizafTB9vkFiJLMIFZ
        WbJX7mjDnlwMOK6x2q4f6ek7V3iNPN9iQvGxFdM=
X-Google-Smtp-Source: ABdhPJw9lF7hmug0zt5tWMRwOEX4oLuIdlBiODwkuCna7zAa6GyAijNwB1Copu+Sj701FKCpaQYEhGAJWblXosY0+ew=
X-Received: by 2002:aca:5256:: with SMTP id g83mr2703332oib.71.1603216048705;
 Tue, 20 Oct 2020 10:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201020150027.27392-1-huobean@gmail.com>
In-Reply-To: <20201020150027.27392-1-huobean@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Oct 2020 19:47:17 +0200
Message-ID: <CAJZ5v0i=R_TqENKJmBEHDpmGAAcg-++8mbBEOYXZwf2cRvvqag@mail.gmail.com>
Subject: Re: [PATCH] PM: Fix typo in pm_runtime_set_active() helper comment
To:     Bean Huo <huobean@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 5:00 PM Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> This patch is to fix typo in the comment of helper pm_runtime_set_active().
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 6245caa18034..18b02dcc168e 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -479,7 +479,7 @@ static inline int pm_runtime_set_active(struct device *dev)
>  }
>
>  /**
> - * pm_runtime_set_suspended - Set runtime PM status to "active".
> + * pm_runtime_set_suspended - Set runtime PM status to "suspended".
>   * @dev: Target device.
>   *
>   * Set the runtime PM status of @dev to %RPM_SUSPENDED and ensure that
> --

Applied as 5.10-rc material with edited subject, thanks!
