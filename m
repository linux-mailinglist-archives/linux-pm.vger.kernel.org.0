Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D7530290C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbhAYRg4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbhAYRgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 12:36:36 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F031C061786;
        Mon, 25 Jan 2021 09:35:42 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id p13so16347700ljg.2;
        Mon, 25 Jan 2021 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X83exQMOztH+V+6RKs+mLlDQ2mY3VBp/sSkBeCvqfIU=;
        b=dLDEE8ucdkDxl02KcwK9VxrydqBs7/Gis+S8JTrtOAWFi/WQ2uKwoU9Q0n56+15h3r
         aSmNSI9G8hFoxk3YQzFpVCI91y3DmPL9XgJIAq2g8j8j/jAbsIBrc+F7ulOCS37nbQYg
         9eYqthPf3ryUCi+MAYFY95WB5+VwYW1jbRrEAws9sQqTSH0R7F02CWQUp49KY0XgmQ3r
         PnohwYm4UdmIk6r+10eX+zdGXovwmpCQnmOlptiCJ3Q5Fz5PKe4GvpHik/geDbusdCzI
         jgfu6fd5aN08FVFs61+LacwrLE9YKq2SdzhzNugkfes6z/UJsgyZ3fanyZlI/uWQ/A3c
         fPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X83exQMOztH+V+6RKs+mLlDQ2mY3VBp/sSkBeCvqfIU=;
        b=KHLv4eXklo8yofY14uNMX8UhC4vzdDz1q9d+mVyM8cE51BVGPveGYDnrAEclvLxaEH
         L+D1eKHGhpN3AxA7y1QQX3uUQekN2xQFkyo/mjmuBT+NVDGJ7oocoXmxZufKw6hb2TQX
         B3O0+qU8sg0nuLh7Fcjg8coWZqJRsuPKycWvCfKg+ye7UYM5Hnh21R9W6dKEcRrgePiB
         m4hWngYDsEljcrzCJQa94tflx3Vx2YJKn/Baz0WXBDvNYIrOqUf8ZNgjamb4DVk1AJZT
         z/iI/c+7PjbZcyoDzlp4tqhNW9JuuMZnxOPsrbgUDpmfUOTPNMyFHMl/bkPavLbaobn+
         u7hQ==
X-Gm-Message-State: AOAM531HWbwwl2AYpBAvVolJNuUoyC+2PNy8mRHfN+rroU3D4PSgyGJp
        NcGvL1VXBPEmbnbWUp7H4S0=
X-Google-Smtp-Source: ABdhPJwrVRjKISUhGPG51fA4v6H3gH94RDNCwsh4GjGzdQwUIMcUpp8sUecuEHv6y7+L/VWT8pXIyA==
X-Received: by 2002:a2e:8059:: with SMTP id p25mr682526ljg.155.1611596139799;
        Mon, 25 Jan 2021 09:35:39 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id j2sm2023879lfe.134.2021.01.25.09.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 09:35:39 -0800 (PST)
Subject: Re: [PATCH v12 4/5] drm/tegra: dc: Support memory bandwidth
 management
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
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
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20201228154920.18846-1-digetx@gmail.com>
 <20201228154920.18846-5-digetx@gmail.com>
Message-ID: <f19789d5-fdf2-8cae-9b54-db885873032a@gmail.com>
Date:   Mon, 25 Jan 2021 20:35:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201228154920.18846-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.12.2020 18:49, Dmitry Osipenko пишет:
> Display controller (DC) performs isochronous memory transfers, and thus,
> has a requirement for a minimum memory bandwidth that shall be fulfilled,
> otherwise framebuffer data can't be fetched fast enough and this results
> in a DC's data-FIFO underflow that follows by a visual corruption.
> 
> The Memory Controller drivers provide facility for memory bandwidth
> management via interconnect API. Let's wire up the interconnect API
> support to the DC driver in order to fix the distorted display output
> on T30 Ouya, T124 TK1 and other Tegra devices.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Thierry, I'm looking forward to yours review. Only DRM patches are left
unmerged yet in this series.
