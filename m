Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3659B2F28A2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 08:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbhALHAB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 02:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbhALHAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 02:00:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C13C061575;
        Mon, 11 Jan 2021 22:59:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s26so1746229lfc.8;
        Mon, 11 Jan 2021 22:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jnp0py2XfXRV0FW9+wJqG1Xqe5HVlb5LAeXT35Y7mN0=;
        b=IgwdvO6tMDacVa3SiHWu/TjA3iAHNWcRPa+jawaFDXO8AYs5RIWQI90Z+O2q29bvTp
         jxS4RaHqrmbLtwYjbz2fncA4AF8sUMzUPvPzL4Rubz7WoJ97U+PGdYot/LTNxxsBRViG
         cxqzicApETLDrTGMfLF37HRg7qmVfKjreN2eYKOzLcE4VBWvUlWlN6/Kac0Ooi4zJU3Q
         8oTD/VpC79o+E1v/khV75oraSQAhNQKgLLl2aupKhGoaot3CyD4eiDjJUoziHZVWUQG2
         Z95suwK6oBRedgJqH2TJr+3+I/ksTNIVc2R0YgOr/mF8f1h9hfRaHCScHWbyxv5vYr7N
         u0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jnp0py2XfXRV0FW9+wJqG1Xqe5HVlb5LAeXT35Y7mN0=;
        b=gVV609rwUCFlkDfABiRQGk5moTa4YG7aUgTesXgAiqm+R0MqUoLJm2lrJ35YRvLRf6
         8zz/tid9cJeNyoCJx7UItJpfqt652btUYLwr0cJerFQruQBaiNgWanOjYh/ZKLyOYABI
         28fuCViyJS7Gnj7hDwgV9XEQA7M9yv0Mi0AtQQMw1PItAoIdKJqU4jHZzj2rR7mWzPmd
         f16a2gW+AyBF9zITTNsGvrCtCFaEJyMl/2DSR+vcrQfLsNi+ctf5QyJKOKCqE1cOXB5n
         igZWZLhdPXTvOQ8jpsQj+jekQBmWCeQrbVgr6HMfbC6QsOnt5/KsJ31LHj4mlmi/YO/G
         2YBg==
X-Gm-Message-State: AOAM530tM2lzLVX7EpRh0mlSkvzSQVZ4x/cX/cvqfKK+huuo41whPiwP
        ornBIgaJEJUqKjvNqev4yDRrHyhhpVo=
X-Google-Smtp-Source: ABdhPJxyewPbnBPNbOq99xW/1Q38pnSTbJiqFKEfHz/WM8dITgwPrn7IrliG3U2e6g0WLs3rT67BBw==
X-Received: by 2002:a05:6512:33a4:: with SMTP id i4mr1605987lfg.520.1610434758991;
        Mon, 11 Jan 2021 22:59:18 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id c136sm268561lfg.306.2021.01.11.22.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 22:59:18 -0800 (PST)
Subject: Re: [PATCH v8 0/3] Introduce Embedded Controller driver for Acer A500
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201228160547.30562-1-digetx@gmail.com>
Message-ID: <c9bc0096-44df-2fd6-804b-856751f3185f@gmail.com>
Date:   Tue, 12 Jan 2021 09:59:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201228160547.30562-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.12.2020 19:05, Dmitry Osipenko пишет:
> This series adds support for the Embedded Controller which is found on
> Acer Iconia Tab A500 (Android tablet device).
> 
> The Embedded Controller is ENE KB930 and it's running firmware customized
> for the A500. The firmware interface may be reused by some other sibling
> Acer tablets, although none of those tablets are supported in upstream yet.
> 
> Changelog:
> 
> v8: - This series partially missed v5.11 kernel release, hence resending
>       for v5.12.

Hello Lee,

Could you please take a look at the MFD patch? If it's good to you, then
please apply this whole series via MFD tree.

Thanks in advance.
