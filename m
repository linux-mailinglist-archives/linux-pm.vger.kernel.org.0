Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3929CA1E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372762AbgJ0U0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:26:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34208 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372761AbgJ0U0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:26:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id z2so4067399lfr.1;
        Tue, 27 Oct 2020 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4zirdglvRKElBhw1oHaKvJRIsORyh5R1+dsaAdlhLCs=;
        b=Afy4UATbiLcRJ6mibHq/8mDeJ03DWWHqsG+y0nIeJTOrw7fDiP64+33bMCToTKEvja
         xdFOthRZHqmnPIhGj5ZfKnR43BhyllTOKmU529IGQ81mPWs7B6LzYbzjZm0m0p2w9V/s
         OXf1jshGMJ7NvufDXleu+jo0icuXTQP3gbZ0XFpfqw1tfsr2lhM2htiAk91NrNQHmx0z
         goMHZioTJ1x5uocbN4WtGpSYhdYpgrAn23R1bCiQ2akaXIMpbCgikGZ7OhVnlLlyLo3r
         n/D+jkdH2lUm5BcglFOmF7MexwtT1D+REZp5CJ/zawPbsDx4vF5mz6NmZFZFrUJyTwlT
         3XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4zirdglvRKElBhw1oHaKvJRIsORyh5R1+dsaAdlhLCs=;
        b=OT6YrVbQESlBpnmCmDgOqummlT0fGMPhuSY3v/Lg6ILK0BEFuXqkNWTD8e2HihVhl4
         kbPi73D01Ijw3+Fve430CmP0RQ/x8DpmXinYWF6Mpt8ye2zgdGGiMPWC1CrTyexfC7o1
         /Vw9jVY6SiKSVKO/to03J11AI44byeS/pPoQ+s1k6sNNZbj3XUMHU0DxpjhzphPfW8kP
         bd+vgLCPU3kN14W9OKkEkKqVFA7RPx59KkxhBSCv8Jiu38TzjsxOs0m8b4oAf+n6RaGk
         wO/byQnX7V35KlzDTs5zJAIh2p5GxGJk37sFxswaNmpZGy2b2GNx9vwlTMRBoxAJGgc4
         1Qow==
X-Gm-Message-State: AOAM533mmairIfTlSWfRGjx/KRgwCujK4tIhrXjIVIroIWWouIwp0eCx
        iDTGJsyo6HP/ylVXJu2X+o8TTE2kzSc=
X-Google-Smtp-Source: ABdhPJycQ9/ABotDTtJ/6fjLHoGmXYUNWeaWgm/69zF9L+kp2N7BWN//ZPWGWmM3YEiQjlV15T1SvA==
X-Received: by 2002:a19:9d5:: with SMTP id 204mr1361256lfj.583.1603830378059;
        Tue, 27 Oct 2020 13:26:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id t10sm283304lfc.258.2020.10.27.13.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:26:17 -0700 (PDT)
Subject: Re: [PATCH v6 46/52] opp: Put interconnect paths outside of
 opp_table_lock
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-47-digetx@gmail.com>
 <20201027051013.5gr4s3wuuwxsd7ax@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <44169d24-4afc-5388-788f-d1e8263fc627@gmail.com>
Date:   Tue, 27 Oct 2020 23:26:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027051013.5gr4s3wuuwxsd7ax@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 08:10, Viresh Kumar пишет:
> On 26-10-20, 01:17, Dmitry Osipenko wrote:
>> This patch fixes lockup which happens when OPP table is released if
>> interconnect provider uses OPP in the icc_provider->set() callback
>> and bandwidth of the ICC path is set to 0 by the ICC core when path
>> is released. The icc_put() doesn't need the opp_table_lock protection,
>> hence let's move it outside of the lock in order to resolve the problem.
>>
>> In particular this fixes tegra-devfreq driver lockup on trying to unload
>> the driver module. The devfreq driver uses OPP-bandwidth API and its ICC
>> provider also uses OPP for DVFS, hence they both take same opp_table_lock
>> when OPP table of the devfreq is released.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
...
> 
> Never make such _fixes_ part of such a big patchset. Always send them
> separately.

Perhaps it's not obvious from the commit description that this patch
doesn't fix any known problems of the current mainline kernel and it's
needed only for the new patches.

> Having said that, I already have a patch with me which shall fix it for you as
> well:

I see that yours fix is already applied, thanks!
