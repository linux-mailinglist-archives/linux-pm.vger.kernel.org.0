Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4E31333C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBHN2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 08:28:31 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33613 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhBHN03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 08:26:29 -0500
Received: by mail-oi1-f176.google.com with SMTP id g84so1762697oib.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2021 05:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMjM9wpamFoY06E53UBLnHfXSS2GlhbGJebFWr4kPes=;
        b=CyXU+WkK0cLng73OqUJEueo2mYKnjfA0nEZpWo+f9rpjhymJfa9NqPEjCqM2Cew6Y8
         xhZyGONlAVS1DDB7yTO8BlLN5C5E4nC2eGuHzcYTFHPxVoPhfIG/jsv9KLqdmV8oTROV
         HFJ8DLILipuoLlWxBbJ9MM3Qt3NNTQ0hvYlQdQr0QHUh+TfrfJ3JYh+fx4a48MpXgOT4
         VUEnhJgdCEyW+n6MTEeiWdfJ42lR8+PcwdgU2XxEoxbCWlRD53DG+I6Z09tSOghcb7aQ
         1MY1KxjvussjDtycTb9USSISujawCr/pc+ySc7qs5opTDa3eP/v/uu6ptc9SO/b6oDh3
         Vpuw==
X-Gm-Message-State: AOAM530Pemw+E2OAIzgGx2sc7SjlzfnSnIm0YNRXeVnFfZrbcMSRGFYm
        iybIJfWCnMgtlqoCpQSUxi17j3UbBhL6i1aBCvk=
X-Google-Smtp-Source: ABdhPJzdPqEaTA+rKSMf6V4+2exuyBrE8M52XaS9VCvXYJN2uXCcKc0G0ELRvpTU4oM6ybUiZX8Jt0RpiYeVCkOqK4s=
X-Received: by 2002:aca:d14:: with SMTP id 20mr11587482oin.157.1612790749098;
 Mon, 08 Feb 2021 05:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20210208060614.krjwvatrp6wxxxkp@vireshk-i7>
In-Reply-To: <20210208060614.krjwvatrp6wxxxkp@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Feb 2021 14:25:33 +0100
Message-ID: <CAJZ5v0joO0drsV=Paj9wbX3rfGWEaQdw4E163Z2xbGn+QPTGew@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.12
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 8, 2021 at 7:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - Removal of Tango driver as the platform got removed (Arnd Bergmann).
>
> - Use resource managed APIs for tegra20 (Dmitry Osipenko).
>
> - Generic cleanups for brcmstb (Christophe JAILLET).
>
> - Enable boost support for qcom-hw (Shawn Guo).
>
> -------------------------8<-------------------------
>
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
>
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to 7114ebffd330bfc5a95b9832a70b6bd857d26fd8:
>
>   cpufreq: remove tango driver (2021-01-21 09:34:46 +0530)

Pulled, thanks!
