Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C4284A5A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJFKe5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 6 Oct 2020 06:34:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38012 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFKe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 06:34:57 -0400
Received: by mail-oi1-f194.google.com with SMTP id 26so12100275ois.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 03:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MJcg7pMOxpw6rcP9BsbKPgdTQqeKQAQxCRYZNxPDW48=;
        b=EcuRrPPDLvf6T2RJnSL0uf5k/k2erWpKoNVQs69qgJXm1hsdowVTcMDfsH4wWjwhk8
         eEQXR7Bo5O2zL/23Um01OmvrRn9+hnDlYKxvc1oidu/FysF+6+Wodd23ZiC53/1oszat
         LBp4/AXASwedSHeK9ObaB5fOoxZkeH+a1G4tqGoKmroRfTnPMGvKr3O8e76UTquiM2xe
         F8QoN61aZ45AywZ6j51dX9/DnW0hR4vt+wMsMP0uH/BIQz+e/X0+AFJ/DlSGPSapx7ed
         0wisXsWLFKdwkK2U3JPx8RIvL6snDyPoXq0TYhFP6G+BY8j+GnWS6gw2P8iDMKt1ZbWW
         8eMA==
X-Gm-Message-State: AOAM532MG6oUSE1NWwud7vHvp7GXNN2Y1ipF9e2WPILduJzeoXWUS5u8
        57KT+Okq0AOOo8USJlkf3yWM3eCnmX/J/duHfKc=
X-Google-Smtp-Source: ABdhPJzJHyS7xadJn+V7j0tNIUrgibslB6MgpnGwrRS0mEnljvs5cCIyaOMSPWzwH8Nk5zKwUqzKP6rbr6/4SC8yg8Q=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2299018oii.69.1601980496553;
 Tue, 06 Oct 2020 03:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201006080859.rzwkdl5ijfbcp723@vireshk-i7>
In-Reply-To: <20201006080859.rzwkdl5ijfbcp723@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Oct 2020 12:34:44 +0200
Message-ID: <CAJZ5v0gYTtH+TD3HBd_4-NxX1z0kXhS5wHVwfY0emfDq8qbBsA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq-arm for 5.10-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 6, 2020 at 10:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - STI cpufreq driver updates to allow new hardware (Alain Volmat).
>
> - Minor tegra driver fixes around initial frequency mismatch warnings (Jon
>   Hunter).
>
> - dev_err simplification for s5pv210 driver (Krzysztof Kozlowski).
>
> - Qcom driver updates to allow new hardware and minor cleanup (Manivannan
>   Sadhasivam and Matthias Kaehlcke).
>
> - Add missing MODULE_DEVICE_TABLE for armada driver (Pali Rohár).
>
> - Improved defer-probe handling in cpufreq-dt driver (Stephan Gerhold).
>
> - Call dev_pm_opp_of_remove_table() unconditionally for imx driver (Viresh
>   Kumar).
>
> -------------------------8<-------------------------
>
> The following changes since commit 90d46d71cce279d878793a0ed4b326b4027aca6c:
>
>   opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1() (2020-09-16 13:56:08 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to bc9b9c5ab9d8d16157737db539929d57562926e9:
>
>   cpufreq: qcom: Don't add frequencies without an OPP (2020-09-16 15:22:15 +0530)

Pulled and pushed to linux-next, thanks!
