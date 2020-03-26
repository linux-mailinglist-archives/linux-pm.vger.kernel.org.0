Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2523194756
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZTSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 15:18:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43149 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTSk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 15:18:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so7125619otb.10;
        Thu, 26 Mar 2020 12:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zI0TwvsWVYhlJVr19T19enByryhK08B3uBQBVeTRjY=;
        b=NNxcOgBIEJo1cXT9MqV7z4owAq5wt0IRldauAD/p4p/mLiSjlnGBSWBnqEgS6QZYog
         T540cjjBcMuRlL0wbbwoVMIpT11jy+B8BTM8bore9lg51IQxajUYQ8qtJWDFXDpT4U2k
         AYtFPxTcdynqkvZ3zeRb7DTKxFyoT0lRJ9zixwivIunsrEeS0nYOrL0225Gm01OCsviK
         cuBHLH/xPiEraA2Z+waEjasck5VV7Fw4YWl9Rk3ZNk4lRORffQYoR3jJs0f2KAb/Qf4X
         b2MpVozd0Y8mO5BkS54doFWGJSN6RwRgh4r2H7mbr5r/pgBuywoxSplK040rI8AW2kdE
         jyVw==
X-Gm-Message-State: ANhLgQ34T8aJngQd44ULJFkgkLguz2sOrvVfFBld7bJEVJqnhP6pUDaC
        EGHh8yXCe5yZ8zX8w0FO4azHEygJQqHalesZbTjS7g==
X-Google-Smtp-Source: ADFU+vuK4kISyUSvbd8lSoZFRj3ieawYyrBiTo4R5Rxz0RRx7BltA46EjHJ8e5WuRny7Y3Y0tc2SGe+kDAOHJiiJ8oo=
X-Received: by 2002:a05:6830:14cc:: with SMTP id t12mr7236262otq.118.1585249833999;
 Thu, 26 Mar 2020 12:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200326162007.25670-1-dsmythies@telus.net>
In-Reply-To: <20200326162007.25670-1-dsmythies@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Mar 2020 20:10:22 +0100
Message-ID: <CAJZ5v0iGJ288aLqUWGD35mNQ3WX_sDvS82HOzXPewWE_44j6yw@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: fix a broken y-axis scale
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 5:20 PM Doug Smythies <doug.smythies@gmail.com> wrote:
>
> A fixed y-axis scale was missed during a change to autoscale.
> Correct it.
>
> Fixes: 709bd70d070ee6d775c6e77e40e8444bd5fa123f
> "tools/power/x86/intel_pstate_tracer: change several graphs to autoscale y-axis"
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index 256199c7a182..3c47865bb247 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -235,7 +235,6 @@ def plot_duration_cpu():
>      output_png = 'all_cpu_durations.png'
>      g_plot = common_all_gnuplot_settings(output_png)
>  #   autoscale this one, no set y range
> -    g_plot('set ytics 0, 500')
>      g_plot('set ylabel "Timer Duration (MilliSeconds)"')
>      g_plot('set title "{} : cpu durations : {:%F %H:%M}"'.format(testname, datetime.now()))
>
> --

Applied as 5.7 material, thanks!
