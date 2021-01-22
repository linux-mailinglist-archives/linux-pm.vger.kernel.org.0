Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB230096D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbhAVPtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:49:33 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:43645 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbhAVPsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 10:48:14 -0500
Received: by mail-oi1-f179.google.com with SMTP id q25so6395368oij.10;
        Fri, 22 Jan 2021 07:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obBVYWunD09RcWHjfPC7xYI+/1GTmUoKVdSiuh/HzBI=;
        b=On7hGhCQPtAqhNrQSWhQK71qLEGOXatFLtqu5dY9pKtRUX0LgmowInp0W2CCnZSR9Y
         EtIi+B+ZIM3znXbpnomSMOCKPlleTpGbRb/iLnjekUl3PSIwHmy+R24xFNXiQUC4QjNZ
         289mfxHuPrjX58/1ykuCeyBYCbi4InONfNbSZeWrnfrM6URKy9A/g8DnK+Xh+mEpAS1r
         A/ZSPMRXPPyy3cUZGFwwZKEXAoi1gWfrCWBA9vzI92S2Nus08oujw/vboeWK/FBKrOc8
         oLPm+MV0qbHj95PBrFefAmq6djN4NR4d4gn2TciGhBqh4IRHl+ZJwiMoXtxS9wPwJQEH
         JHDw==
X-Gm-Message-State: AOAM532WWrkBIUQbjsukbzYsSxbQIZRBmqTaNDPLitGl/ZTXx+DhGAc/
        rdW6qyhjVBbwcMgWEfFGRdV7HXvHwkhvFsKPUrkIMUaQ
X-Google-Smtp-Source: ABdhPJzNVBnHBx92DN2o3Y2h2uF4nQ9US/6gE/boTMoYiSvhY3JzMd4mFwTnUDuKVsr5kPSW3sKN0QVDfkGFqoNVfgw=
X-Received: by 2002:a05:6808:9a8:: with SMTP id e8mr3771099oig.157.1611330453485;
 Fri, 22 Jan 2021 07:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20210115235646.290819-1-trix@redhat.com>
In-Reply-To: <20210115235646.290819-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:47:22 +0100
Message-ID: <CAJZ5v0gx=6dRPpv1Y+323JrjaBdsXPPoOgChxa93dhF4Q+BXyw@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: remove definition of DEBUG
To:     Tom Rix <trix@redhat.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 16, 2021 at 12:58 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Defining DEBUG should only be done in development.
> So remove DEBUG.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/idle/intel_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 28f93b9aa51b..3273360f30f7 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -37,7 +37,7 @@
>   */
>
>  /* un-comment DEBUG to enable pr_debug() statements */
> -#define DEBUG
> +/* #define DEBUG */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> --

Applied as 5.12 material, thanks!
