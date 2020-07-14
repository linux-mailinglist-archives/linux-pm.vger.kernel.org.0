Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93821F771
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgGNQfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 12:35:33 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:44529 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgGNQfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 12:35:32 -0400
Received: by mail-oo1-f68.google.com with SMTP id o36so3442716ooi.11;
        Tue, 14 Jul 2020 09:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xq4tKGNRH3KriixnxCn9uJFwafu8U4KY8hX/LfJhHus=;
        b=YiDs65eV485lrt+lW5nub63ID42gtwNLyWQEU1PL09Oyw8qNqgjQB1f26GTBdYNH63
         KI1ciMuKYb6BVEih/5QOZC3kiuJENxc5yU7c4axemexASwJanxwD28pXLV+Hq+6sK/ij
         4Ye17M4vUHrKmrvvtWpdWt/Y5+rUewW0qZovF/QBBwXbNYor6FsJus0XAdXrLK0ahrs3
         cPwPR2uNByIFC6UnJuLRtfswP9fkT5ddhuN/WHBMp58I1Wjhdr052t52GljFmGJe3X/u
         G+pvQnTM+8NuSZBLCUOz2FqaUJw2UV/v6Pg1SxIeJa2tj7PBMjRKHw3ASXCBsO55enHx
         jeqw==
X-Gm-Message-State: AOAM5304/4XHSClLe3ptCo/WL5szvn/MqOrQ8O8g9Htuv7AmyvzRkwXk
        nar/+YIkFtqVQrMs2Bdlfe30UBdFRoYK6hWOrYDdYw==
X-Google-Smtp-Source: ABdhPJx9jwksQchlp8EzWcp4jDpRaQL5RgS6YS+xhSCdQj4OcOM3zMN5IV/4G0I2X0imPOE8KPCwOaKZyOkoPAp3Hf8=
X-Received: by 2002:a4a:3e48:: with SMTP id t69mr5360935oot.38.1594744531359;
 Tue, 14 Jul 2020 09:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org> <20200714145049.2496163-13-lee.jones@linaro.org>
In-Reply-To: <20200714145049.2496163-13-lee.jones@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 18:35:19 +0200
Message-ID: <CAJZ5v0jkDWD6Ea2_oEDtFfPDWh5ByphUqEa=3jE2ZbnW0DVEcQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] cpufreq: intel_pstate: Supply struct attribute
 description for get_aperf_mperf_shift()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/cpufreq/intel_pstate.c:293: warning: Function parameter or member 'get_aperf_mperf_shift' not described in 'pstate_funcs'
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 44c7b4677675d..f92fc69c87269 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -275,6 +275,8 @@ static struct cpudata **all_cpu_data;
>   * @get_min:           Callback to get minimum P state
>   * @get_turbo:         Callback to get turbo P state
>   * @get_scaling:       Callback to get frequency scaling factor
> + * @get_aperf_mperf_shift: Callback to get the number of clock cycles after
> + *                     aperf, merf is incremented

This added description is inaccurate.  It should be something like
"Callback to get the APERF vs MPERF frequency difference".

>   * @get_val:           Callback to convert P state to actual MSR write value
>   * @get_vid:           Callback to get VID data for Atom platforms
>   *
> --
