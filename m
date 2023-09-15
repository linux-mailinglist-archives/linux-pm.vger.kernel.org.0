Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAB7A2933
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjIOVQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 17:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbjIOVPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 17:15:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E48E78
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 14:15:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c43b4b02c1so7934115ad.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1694812502; x=1695417302; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7teTS75eyEcS4dZgXo+EcQywzkucHFzMxSjJFBdTG8Y=;
        b=gQFM8VApOidWK0tDq0dRoHGzmCkfDoMbNV8gns2ba5RfW/7ZRoB3EquxOCaI7mBvsb
         Ux2wCnc1eXaIeLe3O6HH/GVq3xIwewSTNpTJRmMwd1HIDWm8UMfqq/m1zHBcXNT2Xu6g
         9y1ZugZuykwcnH2MAz36QkBqxlv38SmbxMIq3u44DYlWhyKIBy2yjokC2Kuzi9N5wpyk
         baBPSAVjQBfqFad3c663Yc1itkgf3S97BKToEhcGq19bSnLeccFMarPQ9oRglVqZ0I4p
         TqsgNILa/uJ3SUzaNmpQITFeFB61MfZ9Zf46mEX1PpyiPJX8c8vwNaMcCuNM5gxQAl3m
         od+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812502; x=1695417302;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7teTS75eyEcS4dZgXo+EcQywzkucHFzMxSjJFBdTG8Y=;
        b=W0QgWgmvdIY+a4OR855sdFOMjxwS9ryzNrUaQspkB8rc9LGoKzMJU7+w/je3KzivXM
         +cE1npHALpOpivetXwEjI24k3+3mNzKc8biGpQHd9xqlp52ImieflAcu7qvmrPyIkjNy
         F6cNG477pB6yt8x3zL6RQz2LcusRYy4ZrW7Gl/DN2WqQUesYnco22y1NIxcD9ukEebMp
         cU9Bkfjxilh7dHg91Ml3Xst9lMEMqgBr1+uHEIi53LVPxsXq8kcP/Bx+k4UMjYZfifJz
         KvTht3PeDEcSXSIo7ave80mCsAB4xmJsQ458/+LoK+n1FmE5Lat5zdD0JsSvCWBoXXQo
         l0Kg==
X-Gm-Message-State: AOJu0Yx35PidPoNNeyGmfR2pIjLv/3x0WUwNM7HJvDU3xHp3af3VAi/M
        aVVJvEHjPYtfOKBUfPGqFJJnGA==
X-Google-Smtp-Source: AGHT+IG+M7M64WtxGxEzGQ+nMIdywrrCr5EkuN09OBfh+ct5EkdMstf4ZBHrJuQ7SW4gopMdT0gz/Q==
X-Received: by 2002:a17:902:ea0f:b0:1bf:557c:5a2c with SMTP id s15-20020a170902ea0f00b001bf557c5a2cmr3127053plg.44.1694812502564;
        Fri, 15 Sep 2023 14:15:02 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001b9fef7f454sm1478417plb.73.2023.09.15.14.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Sep 2023 14:15:01 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Swapnil Sapkal'" <swapnil.sapkal@amd.com>,
        <rafael.j.wysocki@intel.com>, <Ray.Huang@amd.com>,
        <li.meng@amd.com>, <shuah@kernel.org>
Cc:     <sukrut.bellary@gmail.com>, <gautham.shenoy@amd.com>,
        <wyes.karny@amd.com>, <Perry.Yuan@amd.com>,
        <Mario.Limonciello@amd.com>, <zwisler@chromium.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20230915104057.132210-1-swapnil.sapkal@amd.com> <20230915104057.132210-3-swapnil.sapkal@amd.com>
In-Reply-To: <20230915104057.132210-3-swapnil.sapkal@amd.com>
Subject: RE: [PATCH 2/2] tools/power/x86/intel_pstate_tracer: Use pygnuplot package for Gnuplot
Date:   Fri, 15 Sep 2023 14:15:03 -0700
Message-ID: <00b201d9e819$b2447e80$16cd7b80$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKwVkrK5CGttHhKf0ienv16Lobu0QKE+b5trlszgRA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2023.09.15 03:41 Swapnil Sapkal wrote:

> In intel_pstate_tracer.py, Gnuplot is used to generate 2D plots.
> In current implementation this tracer gives error while importing
> the module because Gnuplot is imported from package Gnuplot-py which
> does not support python 3.x. Fix this by using pygnuplot package to
> import this module.

As described in the prerequisites section, the package name is distribution dependant.
On my distribution the original package name is phython3-gnuplot,
and it is working fine.

sys.version_info(major=3, minor=8, micro=10, releaselevel='final', serial=0)

I don't currently have python3-pygnuplot installed, and so this patch breaks
the  intel_pstate_tracer for me.

So, I installed the python3-pygnuplot package, and it still didn't work, as there
still wasn't a pygnuplot module to import.
So, I found something called PyGnuplot.py and so changed to that and got further.
But then it got upset with:

  File "./intel_pstate_tracer.py.amd", line 298, in common_gnuplot_settings
    g_plot = gnuplot.Gnuplot(persist=1)
NameError: name 'gnuplot' is not defined

I gave up and returned to the unpatched
intel_pstate_tracer.py
And checked that is still worked fine. It did.

So, I do not accept this proposed patch.

Not really related, but for a few years now I have been meaning to
change the minimum python version prerequisite to >= 3.0 and
to change the shebang line from this:

#!/usr/bin/env python

To this:

#!/usr/bin/env python3

I have to use the latter version on my distro.
Back when I looked into it, things were inconsistent,
so I didn't know what to do. The kernel tree has 52 .py files
of the latter shebang and 11 of the former.

... Doug

> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
> tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py      | 1 -
> tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
> 2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> index 2448bb07973f..14f8d81f91de 100755
> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> @@ -27,7 +27,6 @@ import re
>  import signal
>  import sys
>  import getopt
> -import Gnuplot
>  from numpy import *
>  from decimal import *
>  sys.path.append(os.path.join(os.path.dirname(__file__), '../intel_pstate_tracer'))
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index ec3323100e1a..68412abdd7d4 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -32,7 +32,7 @@ import re
>  import signal
>  import sys
> import getopt
> -import Gnuplot
> +from pygnuplot import gnuplot
>  from numpy import *
>  from decimal import *
> 
> @@ -295,7 +295,7 @@ def common_all_gnuplot_settings(output_png):
> def common_gnuplot_settings():
>      """ common gnuplot settings. """
> 
> -    g_plot = Gnuplot.Gnuplot(persist=1)
> +    g_plot = gnuplot.Gnuplot(persist=1)
> #   The following line is for rigor only. It seems to be assumed for .csv files
>      g_plot('set datafile separator \",\"')
>      g_plot('set ytics nomirror')
> -- 
> 2.34.1


