Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FCB7DC07
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfHANAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 09:00:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46133 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHANAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 09:00:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so73472677wru.13
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yMpiQpFWP0JEpjMoJk++KflIBeJTz7OVMNcADVho+R4=;
        b=tQEPWaf+dZ44fnfNJxwvsG2mixMHkX/vyi1jSiPbobc/LJE39WeKWzQVqlZGq9Ir15
         fBXgjk9onNi6OM+FBuKnrRSrNqwcQmA9B7klNceOZOm8qa8HXu022oiog07bbJpU+3kM
         KXjpbRxkZnXUTsbH69ijQXC+V/FLziitF5nfpucubq31QmoLewCvkrFTvpQ07gv7gtQz
         r38l9N40LxcNjyWE5S/crKcJTLprMelNTS+iNhS+JT38jGD9Jj6xMNgShyVOF+zRdDMn
         H/S9cG1Q+PgbyMN+iYQr2ugXNYYWLwU/luV7B7Ynl3p8tH580ID9NHHyqEYkj5cSc8lZ
         Drpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yMpiQpFWP0JEpjMoJk++KflIBeJTz7OVMNcADVho+R4=;
        b=K3lmIZBeSX3V4HD3xx2nrAqdDTQR6Q9SKHejTmjDYMP05jvQnZzaze62HJOKdhfd+E
         cBXezf1W1Ia9A603bjJmY0x0qGK9aQYqFCClFxV02M5igAqUmwUix65vDq5OGb9LsT0c
         cyu37Nc3WVt1WDxK8qUgRgNSH6ongrzXWpk5ljyr8H8prcVEYQMeDA+xVbNrJEid5if5
         f55rBjrdrZas9DJ9NYLefIV7SZhEMq2zZMs1PQTOzojhyoXrkHJJsYA6Xt2eAOsATJy3
         z1AOJmkZ4YSHSNUnshQ4uW3TWXDZrcN4INHh1rZ3b1xmBAFQmw2Cp5p/pedBrJOj40YV
         1ewQ==
X-Gm-Message-State: APjAAAVBLvKFI7lQOrl5PC+C1iMrfPME4W9OjhL+65SOPtau/PWQvNgk
        /WIhVqpioTVSUQOFreAJscsw7A==
X-Google-Smtp-Source: APXvYqxEyB8QNNBeX9+VrmqebpoFBOtkFuHRU1y3LXbLk1JajQtfO8EHU9UZxzMnWZij8Mp3R0L8YQ==
X-Received: by 2002:adf:eb49:: with SMTP id u9mr21570883wrn.215.1564664412103;
        Thu, 01 Aug 2019 06:00:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2166:4c76:28f8:762a? ([2a01:e34:ed2f:f020:2166:4c76:28f8:762a])
        by smtp.googlemail.com with ESMTPSA id 4sm163635864wro.78.2019.08.01.06.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 06:00:11 -0700 (PDT)
Subject: Re: [PATCH v6 0/3] Make IPA use PM_EM
To:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190801124643.17112-1-quentin.perret@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ba2cd83a-7c3b-9f75-2413-a0ef3ed463d3@linaro.org>
Date:   Thu, 1 Aug 2019 15:00:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801124643.17112-1-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rui,

is it possible to merge these patches? They are acked-by since May.

Thanks

  -- Daniel


On 01/08/2019 14:46, Quentin Perret wrote:
> Changes in v6
> *************
>  - Added Daniel's and Viresh's Acked-by to all patches
> 
> Changes in v5:
> **************
>  - Changed patch 02 to guard IPA-specific code in cpu_cooling.c with
>    appropriate ifdefery (Daniel)
>  - Rebased on 5.2-rc2
> 
> Changes in v4:
> **************
>  - Added Viresh's Acked-by to all 3 patches
>  - Improved commit message of patch 3/3 to explain how it has no
>    functional impact on existing users (Eduardo)
> 
> Changes in v3:
> **************
>  - Changed warning message for unordered tables to something more
>    explicit (Viresh)
>  - Changed WARN() into a pr_err() for consistency
> 
> Changes in v2:
> **************
>  - Fixed patch 01/03 to actually enable CONFIG_ENERGY_MODEL
>  - Added "depends on ENERGY_MODEL" to IPA (Daniel)
>  - Added check to bail out if the freq table is unsorted (Viresh)
> 
> Cover letter:
> *************
> 
> The Intelligent Power Allocator (IPA) thermal governor uses an Energy
> Model (or EM) of the CPUs to re-distribute the power budget. To do so,
> it builds a table of <frequency, power> tuples where the power values
> are computed using the 'dynamic-power-coefficient' DT property. All of
> this is done in and only for the thermal subsystem, and more
> specifically for CPUs -- the power of other types of devices is obtained
> differently.
> 
> Recently, the CPU scheduler has seen the introduction of Energy Aware
> Scheduling (EAS) patches, which also rely on an EM of the CPUs. This EM,
> however, is managed by an independent framework, called PM_EM, aimed to
> be used by all kernel subsystems interested in the power consumed by
> CPUs, and not only the scheduler.
> 
> This patch series follows this logic and removes the (now redundant)
> thermal-specific EM computation code to migrate IPA to use PM_EM
> instead.
> 
> Doing so should have no visible functional impact for existing users of
> IPA since:
> 
>  - during the 5.1 development cycle, a series of patches [1] introduced
>    in PM_OPP some infrastructure (dev_pm_opp_of_register_em()) enabling
>    the registration of EMs in PM_EM using the DT property used by IPA;
> 
>  - the existing upstream cpufreq drivers marked with the
>    'CPUFREQ_IS_COOLING_DEV' flag all call dev_pm_opp_of_register_em(),
>    which means they all support PM_EM (the only two exceptions are
>    qoriq-cpufreq which doesn't in fact use an EM and scmi-cpufreq which
>    already supports PM_EM without using the PM_OPP infrastructurei
>    because it read power costs directly from firmware);
> 
> So, migrating IPA to using PM_EM should effectively be just plumbing
> since for the existing IPA users the PM_EM tables will contain the
> exact same power values that IPA used to compute on its own until now.
> The only new dependency is to compile in CONFIG_ENERGY_MODEL.
> 
> Why is this migration still a good thing ? For three main reasons.
> 
>  1. it removes redundant code;
> 
>  2. it introduces an abstraction layer between IPA and the EM
>     computation. PM_EM offers to EAS and IPA (and potentially other
>     clients) standardized EM tables and hides 'how' these tables have
>     been obtained. PM_EM as of now supports power values either coming
>     from the 'dynamic-power-coefficient' DT property or obtained
>     directly from firmware using SCMI. The latter is a new feature for
>     IPA and that comes 'for free' with the migration. This will also be
>     true in the future every time PM_EM gets support for other ways of
>     loading the EM. Moreover, PM_EM is documented and has a debugfs
>     interface which should help adding support for new platforms.
> 
>  3. it builds a consistent view of the EM of CPUs across kernel
>     subsystems, which is a pre-requisite for any kind of future work
>     aiming at a smarter power allocation using scheduler knowledge about
>     the system for example.
> 
> [1] https://lore.kernel.org/lkml/20190204110952.16025-1-quentin.perret@arm.com/
> 
> 
> Quentin Perret (3):
>   arm64: defconfig: Enable CONFIG_ENERGY_MODEL
>   thermal: cpu_cooling: Make the power-related code depend on IPA
>   thermal: cpu_cooling: Migrate to using the EM framework
> 
>  arch/arm64/configs/defconfig  |   1 +
>  drivers/thermal/Kconfig       |   1 +
>  drivers/thermal/cpu_cooling.c | 428 ++++++++++++++--------------------
>  3 files changed, 178 insertions(+), 252 deletions(-)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

