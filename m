Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D27134F61
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 23:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAHW3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 17:29:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40524 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHW3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 17:29:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id c77so4164835oib.7;
        Wed, 08 Jan 2020 14:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeapDn2neSVVmjVhMtHBGmaBFxVH5TlGqSgnHl2gmvg=;
        b=ISthhoxPi1qe5hssu5fsgXT4wPcr1tOQQMZOAKOuwyAW19hUuqW4NbXlCO4RXhdMYI
         z/RyH+99qPZgI6PmOVn9txwW2bGXQssE3EaiHBOLnyTNw6f3Zuhq6UaPIogQGZIPpPww
         3dQsvJm0BQ9GoQ7bjtndn4/6LQMGzPGBXKwJTDUvsCP0wjmgaVjiL5YUpqmIDk72QjE5
         JFBSlpLBU1YIstWKg1OWW5nmhAYPFNiowRevldXVC+pUaiSnyW9N6pDhk4YP8LYcfh9H
         CEgbvfx/XckZ54yKrPsaP9ANoajwuLDMMRw2o8ZMBQoO692qRDIamAH5S/ASeQNsz+QV
         FSDg==
X-Gm-Message-State: APjAAAUPIxCENgCabNy9cH/SZTaTzr9uJIzoNWS15s9u13/2Dwpy4/0A
        rz5O1h3RHxMkfmHMjPL/AUI8PLI2XO+qcn1bIEY=
X-Google-Smtp-Source: APXvYqyLGaQVxY7IVmewU+GjiPA/3nr9z17jC7S4FzD7080BKYAtcP1rJuZYvT1d3ocWawNIoTfwS398cimsxE9i8rE=
X-Received: by 2002:a54:488d:: with SMTP id r13mr681737oic.115.1578522575967;
 Wed, 08 Jan 2020 14:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20200108053418.tjc62uppube6q4q3@kili.mountain>
In-Reply-To: <20200108053418.tjc62uppube6q4q3@kili.mountain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jan 2020 23:29:24 +0100
Message-ID: <CAJZ5v0hwo_NzspnM551DjJOKsJNV8ssT_FKwpj3qfhZ+r-ebJg@mail.gmail.com>
Subject: Re: [PATCH] power: avs: qcom-cpr: Fix error code in cpr_fuse_corner_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 8, 2020 at 6:34 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We're returning the wrong variable.  "ret" isn't initialized.
>
> Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/power/avs/qcom-cpr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index 9247f53550b3..0321729431a5 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -922,7 +922,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
>                 uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
>                                       step_volt, drv);
>                 if (uV < 0)
> -                       return ret;
> +                       return uV;
>
>                 fuse->min_uV = fdata->min_uV;
>                 fuse->max_uV = fdata->max_uV;
> --

Thanks for the fix, but this issue has been fixed already.
