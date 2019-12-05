Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61311407D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 13:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfLEMDi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 07:03:38 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44319 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEMDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 07:03:38 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so2114544vsj.11
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 04:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh/sTB6L//7j5NXRAkRpDvOGMYdCPg3GVgIMMAoU6SM=;
        b=LKmIsj5Xbad6lkdgasr1aoaHZqyCIqu9l3oAjSwy0ruOAdbQjr9PgtJUX/fMoYt6RK
         KKcBGnrcEf3KmLS3OSS7aiYivuWS4uMSc8VUauQWWR0PRNLNq4WwCp6KQivBwRtb9D0X
         qsC0JlSPLNktXZ0QJtbDd68W7M6uNPiEMGWHULzVirTaUGGfom00u64Nnu/aAL0y0Op/
         +ymEAK2ZFN2cIsOofbenjZgLbhz5YCArmi/iaoyLYsBbQh4HJEbtGzLRVBBlLhxtaqo4
         0P4PXo5am6GQ6/0oeniGxIuOFkf4r0hhEQdR1V0KrXAecPqsWQtxIgtgsOIGvpFJ7AD+
         66Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh/sTB6L//7j5NXRAkRpDvOGMYdCPg3GVgIMMAoU6SM=;
        b=G1tCl1RZCaTM6WAc39SisHs+hWxjwF7y/KR01SfDdKB8BfbN+DZ8W7gcV1F7WgJAHL
         VFX3GcTu8TVb4uOSjTtVDOKF9QkFwI2PD8O6hA+M3xBrT92iyev+1mmHW3tH9A2fNqiU
         HLgkz/k+ylANtSpg4VE7URaQPr3lQ4M4bKUm8Pwk/T83PQ051qFLqOGRDg4X5JkU+a7R
         N0xvrL7x79Um24pzF/+di25IGAMBeR7DvMMIPA5ncXw1PkU0ObzY3+EnzRQr1oX0WqfU
         QiA29IgF6J+emA6sm4qEPy0Gy0m9Iex8grh/ClfWDOKgdE9X0easRMKtZ0fLh+C8mDwT
         Ih2A==
X-Gm-Message-State: APjAAAUG/ItlVyWbjPRi91VmAKvG+64gvSvCBeV13w98ImlOP6AK0tz+
        PWA0rcvXVUaVO8s7+g0S1xhweySM2VCKdeWMwrYoCg==
X-Google-Smtp-Source: APXvYqxKmXFZ2pxFMFxxgEft/5dJ1SHB7zIYMHUaSiT0++FIkE5acrECUfpknJOrTCnlGriN+0c+LkuN3Z9PWWmRHOc=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr5211937vsf.200.1575547416765;
 Thu, 05 Dec 2019 04:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20191205115150.18836-1-rui.zhang@intel.com>
In-Reply-To: <20191205115150.18836-1-rui.zhang@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Dec 2019 13:03:00 +0100
Message-ID: <CAPDyKFqFswOjqNn0s7Y3BAeYuVr+z2NrX3fbn+yu+O1vgWb8tA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Add Daniel Lezcano as the thermal maintainer
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 5 Dec 2019 at 12:52, Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add Daniel Lezcano as the co-maintainer of thermal subsystem.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8abdb50af79..0efadb61fe8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16287,7 +16287,7 @@ F:      drivers/media/radio/radio-raremono.c
>
>  THERMAL
>  M:     Zhang Rui <rui.zhang@intel.com>
> -R:     Daniel Lezcano <daniel.lezcano@linaro.org>
> +M:     Daniel Lezcano <daniel.lezcano@linaro.org>
>  R:     Amit Kucheria <amit.kucheria@verdurent.com>
>  L:     linux-pm@vger.kernel.org
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git

Great!

Did you guys also agree on how to work with the git tree? There is one
common git, maintained by Rui?

Just to let people aware of the workflow...

Kind regards
Ulf Hansson
