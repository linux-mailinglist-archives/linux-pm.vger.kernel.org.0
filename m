Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F4D132455
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 11:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgAGK7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 05:59:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41979 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGK7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 05:59:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so75933016otc.8;
        Tue, 07 Jan 2020 02:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzQpxAWpBjjHGr3KKrvvbrwcil+/kjftdWNGOuYtDAI=;
        b=ckSDLWvXjqH+BkAbu/8h/nMInKjjHV1uCp0oQXsOIx0YIH9kmf0PtOpuPwYmJKMsEZ
         hqgy8zmliCvevGi6KHDq0zl34NQaf61KlgjJkEKZrNWu7CI2ZURAGQ6TCNJtrDJHGpdY
         DBkqrpAWpuxjThy1XIdYUpeVlVDoYS4YK7HAVMNxTu6y2EG50NN+YPBNPq3W8JsE+SbA
         mtB3UoLFDT9+pcXMzG2FKwbMSejZxfn5wE/dF4jFVERRXSZj8JVK8Bv9dyk0YVBY1h7U
         /Kgpt5hWlUNMNaBVQEOE3H5TZpX4ZEFviAr1Sje0ujcmkbuVxl7+/iACv14Mwfm4bNGO
         e4Jw==
X-Gm-Message-State: APjAAAXRv04VdjkwQRvsrCyOrTRUNJZtmhfGwBVDp3jxwwEO9Fc0B+Te
        eomv/o5w4uH7UDqF8eMb7QyFvyNzeNOrvFjQMqg=
X-Google-Smtp-Source: APXvYqxDfK07U/wMncRfQCZHxtfHO04TlLY8Ae2d+UTpTfFq86JlFtKF5/CqpNnccY1AB/fvpOWFP/U/y2yLWMZ29KM=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr114709103otr.167.1578394756732;
 Tue, 07 Jan 2020 02:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20200106120558.37758-1-colin.king@canonical.com> <20200106191458.GV3755841@builder>
In-Reply-To: <20200106191458.GV3755841@builder>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 11:59:05 +0100
Message-ID: <CAJZ5v0jxEv8UKUuf+PBtaGR95Dpie3vdSOd=VDw21RgYTqM5DQ@mail.gmail.com>
Subject: Re: [PATCH][next] power: avs: fix uninitialized error return on
 failed cpr_read_fuse_uV call
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 6, 2020 at 8:15 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 06 Jan 04:05 PST 2020, Colin King wrote:
>
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently when the call cpr_read_fuse_uV returns an error the value in the
> > uninitialized variable ret is returned. Fix this by instread returning the
> > error value in the variable uV.
> >
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied, thanks!

> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/power/avs/qcom-cpr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> > index 9247f53550b3..0321729431a5 100644
> > --- a/drivers/power/avs/qcom-cpr.c
> > +++ b/drivers/power/avs/qcom-cpr.c
> > @@ -922,7 +922,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
> >               uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
> >                                     step_volt, drv);
> >               if (uV < 0)
> > -                     return ret;
> > +                     return uV;
> >
> >               fuse->min_uV = fdata->min_uV;
> >               fuse->max_uV = fdata->max_uV;
> > --
