Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E4302F14
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbhAYWbu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 17:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732247AbhAYWaz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 17:30:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80AC061574;
        Mon, 25 Jan 2021 14:30:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v24so20142583lfr.7;
        Mon, 25 Jan 2021 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rxY/cwcH63wwBbkE8btXXsh21z/0kjVIZCNuqfMz3/4=;
        b=qxCej7SzAiCQdvPATKYMNOGdV7IIXUiPMn8ED38Zt0ZfSFMIfpegV4KtvFt58hV/lK
         kaDYJO3W3PJlf2mgDe26H+mLuukbCiwlqj4Iun2IVnvFHSF7HDsP/nY7rgGud4SQctBM
         nzIjbXuPD36FeU4HCvl+DUw/6qGPQAeNsuxIQLnNuq0OTltomw70IJu7aR4AgCS2uuXk
         3vBCRmM810kp0gz9Y5c0eqTmbgFUpLNRqzm4s5E5c3/+/WRD4ARxfcFf4H51nVzzrydx
         kIbo74eedznfaiBgW1Hvhg0IzsLXftpemIhv1fj7D0kIySaf7INaKrvTZNFzG8zsskVV
         6Emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxY/cwcH63wwBbkE8btXXsh21z/0kjVIZCNuqfMz3/4=;
        b=SKxI5JAOyx0zi0d3cTMQNWSl/3qsBK1eATbjuR2fLz2dzxrYCQpdhqP3jEBl/E5QaD
         J1FIhQmXDYl+cxrWntu5CfapGu/o7AThwn26TLMzxdS+wB0JpmpkgweMUYmuab9P4WKk
         cAKGE4i45LEcr+VVwd6A5IEZoOXMUTOA4oxD6QFkL1vpuEHPKOmOVcZf8k9Uafy8wS90
         4qKPgFiCP2iz3qtp8IFdWaM0Xr8FGu4BeyHMClOszzIKczyGUpDxgrQFpeuOBBacBD12
         +lLQP8fZZEGi32PrTpIsGITavi837N/HFxSkrSxxvSOlbo4Fcn0oRGHczgP5bjcInOLt
         crYQ==
X-Gm-Message-State: AOAM532GRdv1kGIgDpkeqykGInyr09PgaL3Z4yk9DdCJp2pcTqfM2Nlk
        +bg5zMAt6JrqZqB4bU1PSCdlyB9aDz0=
X-Google-Smtp-Source: ABdhPJy13OxQx+97hLxd3JsEAUsHm6w84F53K4AmVcNaDns+BhRgWvgU32MKMRYASIKcfHlZ1ecfyA==
X-Received: by 2002:a19:495d:: with SMTP id l29mr1171580lfj.465.1611613811513;
        Mon, 25 Jan 2021 14:30:11 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id x29sm2149941lfn.166.2021.01.25.14.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 14:30:10 -0800 (PST)
Subject: Re: [PATCH v4 2/4] opp: Add dev_pm_opp_sync_regulators()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210120222649.28149-1-digetx@gmail.com>
 <20210120222649.28149-3-digetx@gmail.com>
Message-ID: <42abee3f-ce18-7930-b584-17ae69bdc498@gmail.com>
Date:   Tue, 26 Jan 2021 01:30:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210120222649.28149-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.01.2021 01:26, Dmitry Osipenko пишет:
> Extend OPP API with dev_pm_opp_sync_regulators() function, which syncs
> voltage state of regulators.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 47 insertions(+)

Hello Viresh,

This is the last patch that is left unmerged from this series. We will
need it for implementation of the PD driver for NVIDIA Tegra20/30 SoCs.
Please consider applying it, thanks in advance!
