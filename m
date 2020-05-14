Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA51D2EB0
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgENLrq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 07:47:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40650 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENLro (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 07:47:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id v128so7441996oia.7
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 04:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q46vUJwAl39FNDzxN9NSRe4sL6otBGE87NrewJ9vp4k=;
        b=Co0RXX3HErahBvFBNVyPv0q81aaACYSasmNzB663sgs96cWWCx+gom9fn1nSpW0xPm
         Jg3a2PY7szM6ll7WGxxU7uIBYgu7nY3cI8xRnHYCvoPFEZOAY9urfkMDB+0pdMG2Y0mh
         Q56OvVpO2bcgzH/cJznXU9LSFD2RbEAZJcikASDw/04UJ5I/ajMqu72zRVTNLV6mySdj
         9Lyyf5TYjq1lFAm4z8M6UiDbPBCI4+YPwLGrEa6DXggTukhyrbmASc4TBTVo3Nd4DtzK
         lMCi6ezhBtUQbFZ8jQ74tKBp42r8x52oTNYtxDHdGMZG5g4WqbLOxxX5aK70UKTkiMFB
         x0KQ==
X-Gm-Message-State: AGi0PuZKfs2bB9Kzkjoq2U5LiafRHuWhi8bjb2N0SG5MRMGADtZvb0Py
        b9rWqBwQoVgkeacd6EWHllFv1+XoY9CnBYRa8Xk=
X-Google-Smtp-Source: APiQypKd56ihoatKA3JhBJMUJA8TRkk5hUpSmdmHek3jiZjWU/ra8NGLLFVAly7DAvcLxzfwZL+m2m99QAddIs4RYV8=
X-Received: by 2002:aca:4fd5:: with SMTP id d204mr9618868oib.103.1589456864285;
 Thu, 14 May 2020 04:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200513101751.111907-1-pterjan@google.com>
In-Reply-To: <20200513101751.111907-1-pterjan@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 May 2020 13:47:33 +0200
Message-ID: <CAJZ5v0hSGYCwAED6TWq=dPv+W=YSZ3p+3T1tbkfbhL5pWnOO8A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Delete unused define_one_ro/rw macros
To:     Pascal Terjan <pterjan@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 12:18 PM Pascal Terjan <pterjan@google.com> wrote:
>
> They were already unused when cpuidle was introduced.
>
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
>  drivers/cpuidle/sysfs.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index cdeedbf02646..7729cf622d1e 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -167,11 +167,6 @@ struct cpuidle_attr {
>         ssize_t (*store)(struct cpuidle_device *, const char *, size_t count);
>  };
>
> -#define define_one_ro(_name, show) \
> -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
> -#define define_one_rw(_name, show, store) \
> -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
> -
>  #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
>
>  struct cpuidle_device_kobj {
> --

This patch doesn't apply on top of the cpuidle material for 5.8
present in linux-next, thanks!
