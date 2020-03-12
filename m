Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A71183049
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCLMdR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:33:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41412 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCLMdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 08:33:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id q10so4648181lfo.8
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Bo582olf9I+MMKB0pQtd/IuQwjNyfcOYDF6NIq6gKo=;
        b=v/SmbDFA9bum9xqEBrQZOBXw8nWWqls3dXOrOVMxWlA/CDQFR04wN1DwjURDMHF8kX
         9NWNCckiZ+WU4TdKgACLJz2jpwEzLbl+1R58vGlJygw4xn66vB77TPdUEuYf8RN2qqkJ
         m8bDSLr0ZusKUyMx9NGxUwOmdYU5GCDYOWywB3+V4cTyUuXw+n/aJhbri1vA2lHtlOAz
         6/jQUELdmxpUHUmCNu3MC2QwNqNHxqTjCHZJzWjk2IpWPa31AaUwj4Uu4+QCydTtGU+9
         beYTiEDwxsBYqtoCY0r1gHwO357WwcTPFfpDH9EVaGEgr+jUgqH2GhF65DsQe6MYsAWx
         /lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Bo582olf9I+MMKB0pQtd/IuQwjNyfcOYDF6NIq6gKo=;
        b=YjEwoMdlepNjdSbcD6s/TC5WXocvWszlozB0m85L5nQAsM+nm/xrVXs/sfSZbZtSdT
         RhapapO+kVng35oImKOpSzfmbnSEIzv6TaLh41J38N+Xvd8oAA4fJx38dD8+DPtzi7E8
         FTBhInoKt9cZjJWXHStbbU4dhmu2EHvrQv+DtZOOEb+D2rscUBxq1K04IXQfWW9NhS32
         iuCQJhqWtjmgiKb6g/lkwb3MFnCXfMCuXAa0L51PLN6uehuIHlXSGgi0OryU5x7H7dkc
         oCBC3ssHmskZCpw4o3Ey5iVbOoFw0X+SCrPgOIWWyDxcZINQaVHeliyrdfUeTTp3NwFm
         G2jg==
X-Gm-Message-State: ANhLgQ1gcy/MIol8+Gt1MLy0vmOGJFI1I0S0Tmrxe3+6UH2rYT9GrTFh
        LAWl00ibXklmYKa286o/z1gFBYYcPBWz0PEy5IlOQQ==
X-Google-Smtp-Source: ADFU+vuv/PMTCyaeiYoCTenY1lNCs2WeBwpMW3bw8GM67e8Mq0IfC3k0GJzP8LXAk+rWBCsmQ7trl+/XJx4vqj5piZo=
X-Received: by 2002:a19:c515:: with SMTP id w21mr2148454lfe.114.1584016393599;
 Thu, 12 Mar 2020 05:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1582548319.git.amit.kucheria@linaro.org> <5c7153cf-903d-607a-a783-35a4db7d8500@linaro.org>
In-Reply-To: <5c7153cf-903d-607a-a783-35a4db7d8500@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Mar 2020 18:03:02 +0530
Message-ID: <CAP245DXXuD+LtqF68pENzdf8p=F840tHf2RnmQ6K18xTvXMUeQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] thermal: tsens: Handle critical interrupts
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Thu, Mar 12, 2020 at 4:20 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Amit,
>
> I tried to apply the series but I've got a plethora of warnings about
> WARNING: line over 80 characters from checkpatch.

I've fixed most of the warnings, except the following. The first one
will require some restructuring of the variable names or the for loop
to fit into 80 chars and should probably be done in a separate patch.
The next three warnings should be left as it is since the lines are
longer by only a few characters and keeping it on a single line aids
readability, IMO.
The last warning gets fixed automatically as a result of patch 8, so I
left it there.

WARNING: line over 80 characters
#201: FILE: drivers/thermal/qcom/tsens-common.c:780:
+
priv->fields[idx]);

WARNING: line over 80 characters
#223: FILE: drivers/thermal/qcom/tsens-v2.c:54:
+       REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH,
TM_Sn_UPPER_LOWER_THRESHOLD_OFF,  0,  11),

WARNING: line over 80 characters
#224: FILE: drivers/thermal/qcom/tsens-v2.c:55:
+       REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,
TM_Sn_UPPER_LOWER_THRESHOLD_OFF, 12,  23),

WARNING: line over 80 characters
#225: FILE: drivers/thermal/qcom/tsens-v2.c:56:
+       REG_FIELD_FOR_EACH_SENSOR16(CRIT_THRESH,
TM_Sn_CRITICAL_THRESHOLD_OFF,     0,  11),

WARNING: line over 80 characters
#266: FILE: drivers/thermal/qcom/tsens.c:107:
+                                               IRQF_TRIGGER_HIGH |
IRQF_ONESHOT,

total: 0 errors, 5 warnings, 0 checks, 375 lines checked


>
> Also the log contains the Link, but actually it is not necessary as my
> scripts are automatically adding them so it ends up duplicated.

OK, my git hooks automatically add those when I pull those patches
back to spin a new series with reviewed-by/acked-by. I will disable
the hook.

> Can you resend the series without these warnings and the Links?

Sending it out in a few moments as v7.

Thanks,
Amit

> Thanks
>
>    -- Daniel
>
> On 24/02/2020 13:58, Amit Kucheria wrote:
> > TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog supp=
ort
> > in case the FSM is stuck. Enable support in the driver.
> >
> > This series was generated on top of v5.6-rc2.
> >
> > Changes since v5:=C2=AC
> >  - Introduce a function tsens_register_irq to handle uplow and critical
> >    interrupt registration and reduce code duplication
> >  - Clarify reason for patch 04
> >
> > Changes from v4:
> > - Add back patch 1 from v3[*], I mistakenly didn't post it for v4.
> > - Remove spinlock from critical interrupt handling
> > - Change critical interrupt handler to fall thru watchdog bark handling=
 to
> >   handle critical interrupts too
> >
> > [*] https://lore.kernel.org/linux-arm-msm/77dd80eb58f0db29a03097cb442d6=
06f810a849a.1577976221.git.amit.kucheria@linaro.org/
> >
> > Changes from v3:
> > - Remove the DTS changes that are already queued
> > - Fix review comments by Bjorn
> > - Fixup patch description to clarify that we don't use TSENS critical
> >   interrupts in Linux, but need it for the watchdog support that uses t=
he
> >   same HW irq line.
> > - Separate kernel-doc fixes into a separate patch.
> >
> > Changes from v2:
> > - Handle old DTBs w/o critical irq in the same way as fix sent for 5.5
> >
> > Changes from v1:
> > - Make tsens_features non-const to allow run time detection of features
> > - Pass tsens_sensor around as a const
> > - Fix a bug to release dev pointer in success path
> > - Address review comments from Bjorn and Stephen (thanks for the review=
)
> > - Add msm8998 and msm8996 DTSI changes for critical interrupts
> >
> >
> > Amit Kucheria (8):
> >   drivers: thermal: tsens: De-constify struct tsens_features
> >   drivers: thermal: tsens: Pass around struct tsens_sensor as a constan=
t
> >   drivers: thermal: tsens: use simpler variables
> >   drivers: thermal: tsens: Release device in success path
> >   drivers: thermal: tsens: Add critical interrupt support
> >   drivers: thermal: tsens: Add watchdog support
> >   drivers: thermal: tsens: kernel-doc fixup
> >   drivers: thermal: tsens: Remove unnecessary irq flag
> >
> >  drivers/thermal/qcom/tsens-8960.c   |   4 +-
> >  drivers/thermal/qcom/tsens-common.c | 185 ++++++++++++++++++++++++----
> >  drivers/thermal/qcom/tsens-v0_1.c   |   6 +-
> >  drivers/thermal/qcom/tsens-v1.c     |   6 +-
> >  drivers/thermal/qcom/tsens-v2.c     |  24 +++-
> >  drivers/thermal/qcom/tsens.c        |  63 ++++++----
> >  drivers/thermal/qcom/tsens.h        | 103 ++++++++++++++--
> >  7 files changed, 320 insertions(+), 71 deletions(-)
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
