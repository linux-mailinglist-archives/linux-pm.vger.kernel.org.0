Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCF31717F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhBJUjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 15:39:31 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38559 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhBJUj3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 15:39:29 -0500
Received: by mail-wm1-f53.google.com with SMTP id y134so3088996wmd.3;
        Wed, 10 Feb 2021 12:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4A+2k+XaOQDQdRLdda2hXalHoLO2FataTE4xahcLSg0=;
        b=E8DSUB7Svq9EBiCSaBxAWL6wZVpp6GlHFDXo+AhS7gf72CzzSEAatpzk4u79z2WWT8
         CcJtlJniZ/Vm0uMJ92JbWplquoiDKhGCKEeGRweMYOPEqPuXYGFpzHlpHLJu8EED1UJ7
         0SkusU98uvsaA2jPJt1Y+6NSf/6AW+piBcNmJU46ha8PWtFzGUYAGHnrxAZglUf2DoBh
         asyPimd0CWFbRby9518QYA88V2EX6NHcOMo6+b0nIp+lNQPxILribRtGMjeiOkoLLwSg
         rHIEa0YiSidpbCaxMoWJlblqwO8huaGcpWthkiMj/zW7ppl7oR6te32F9QLF4Jk33ije
         RnoA==
X-Gm-Message-State: AOAM5307iGxgL+swI37iOxdshgBg9eTbNTHc801M1SsqUQfarbamDhWJ
        wF1ZjFDG6EJmSv6wwXZ29xQ=
X-Google-Smtp-Source: ABdhPJwVUNzMD7J+9bMSfrZJ1hAngscnt61sEbrrRpwQSlkDT09B252mXklgnu3RkTtE1a95uj41nA==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr802274wme.146.1612989527156;
        Wed, 10 Feb 2021 12:38:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s64sm4572510wms.21.2021.02.10.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:38:45 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:38:44 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] power: supply: bq25980: Applies
 multiple fixes brought on
Message-ID: <20210210203844.pg2646qbnclth7zx@kozik-lap>
References: <20210209230527.26712-1-r-rivera-matos@ti.com>
 <CAJKOXPdy4BJMSb7KXhU8vYrJ2+qWPOw0MzTGhXQEgh1xHDZFNw@mail.gmail.com>
 <8f952bd9-1849-af7e-d54f-b897c653a126@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f952bd9-1849-af7e-d54f-b897c653a126@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 10, 2021 at 01:50:03PM -0600, Ricardo Rivera-Matos wrote:
> Krzysztof,
> 
> On 2/10/21 2:20 AM, Krzysztof Kozlowski wrote:
> > On Wed, 10 Feb 2021 at 00:52, Ricardo Rivera-Matos
> > <r-rivera-matos@ti.com> wrote:
> > > fix: corrects various register step size and offset values
> > > 
> > > fix: corrects bq25980_get_input_curr_lim() and bq25980_set_input_curr_lim()
> > > 
> > > fix: corrects bq25980_get_const_charge_curr() and bq25980_set_const_charge_curr()
> > > 
> > > fix: corrects BQ25960_BATOVP_MIN_uV, BQ25960_BATOVP_OFFSET_uV,
> > > 
> > > BQ25960_BATOVP_STEP_uV, and BQ25960_BATOVP_MAX_uV
> > > 
> > > fix: corrects busocp_sc_min and busocp_byp_min members
> > > 
> > > fix: removes unnecessary polarity check from bq25980_get_adc_ibus()
> > > 
> > > fix: removes unnecessary polarity check from bq25980_get_adc_ibat()
> > > 
> > > fix: clamps ibat_adc to match datasheet change
> > Thanks for the patch.
> > 
> > Only one fix at a time and please exactly describe what is being fixed
> > using proper sentences (starting with capital letter, ending with a
> > full stop... and usually description needs multiple of such
> > sentences). You add here multiple changes without proper description
> > of a problem being fixed. This is not the correct style of a patch.
> ACK, this patch is meant to implement changes brought on by a new datasheet
> revision.

Only one "fix" in commit msg mentions datasheet.

> The revision tweaked the register step size and offset values to
> improve the accuracy. I can rebase and reword the patch if that works for
> you.

Yes, please. "corrects bq25980_get_input_curr_lim() and
bq25980_set_input_curr_lim()" tells me absolutely nothing what was wrong
and how it's get corrected.

Best regards,
Krzysztof

