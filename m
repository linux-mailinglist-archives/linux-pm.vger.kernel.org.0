Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CFD26C7FB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgIPSgm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 14:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgIPS3N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 14:29:13 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19725C0A8898;
        Wed, 16 Sep 2020 05:56:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so6542931ota.10;
        Wed, 16 Sep 2020 05:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSV7beY8QnOVtgzVdZnUtZuTvKoFmwg9z8LNmIBeTUg=;
        b=cmqs8VWQWuuIkKuHoCmICC/RDIkKwSLn8nLvLe40jxX21Bbxway42jK0l1PpZNHnfb
         0ZAA+jWPluzPip+rP94yyf0L/oDrqSJyS4Im8G5J50O1DRACiRkaIPAoCznjZBjqLtk5
         jBuZ+G2Nz4RExWkO5sFHEVyVvzY8fOCMWTcoBTXNt55ZynGWOZEVEIuY1BFlbxTj/INu
         ET0ZUnqpGVxUMuYYPklBpjRlUbM8UjPHdVRbH5DBFHyiBU1gMcEqW5PsGCVcMVx2HmJf
         WIoQieCPWsmfkgpaSNa/FY/SVxUwA/AzLNe15pCW/pAu3VOoUIVd+ir78D6F9U8PRECZ
         +Ycg==
X-Gm-Message-State: AOAM530DDIGt6WjW5T+oFx2kqE0JCXA5lPkk8BgRBbl97jC0urG8iyS6
        HKuw1d1lj0Q4KjUAjIGPC8w45iSASHmZ1xYVrh4GyYW/
X-Google-Smtp-Source: ABdhPJxsBY+YxMhxeJDPgjewT6+zp4SOgN5BJwIW9A2xZGcZMC3QGI7WwgkMe0Ng550QOb4souLWpZkVDPAlrqpW2ug=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr16326592otj.262.1600258686519;
 Wed, 16 Sep 2020 05:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200821184810.22484-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20200821184810.22484-1-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Sep 2020 14:17:54 +0200
Message-ID: <CAJZ5v0hopjUuoWG3S=zGt_fR6r8qxWrj5X-evnmvm=13Vxs4hA@mail.gmail.com>
Subject: Re: [PATCH] powercap/rapl: Add support for Lakefield
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 21, 2020 at 8:46 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Simply add Lakefield model ID. No additional changes are needed.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Applied as 5.9-rc material (with a minor subject edit), sorry for the delay.

Thanks!

> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 6f55aaef8afc..d85a3d95ef20 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1036,6 +1036,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,         &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
> +       X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_core),
>
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     &rapl_defaults_byt),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        &rapl_defaults_cht),
> --
> 2.17.1
>
