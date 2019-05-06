Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0655C14ABB
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfEFNR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 09:17:28 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40186 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfEFNR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 09:17:28 -0400
Received: by mail-wr1-f48.google.com with SMTP id h4so17224667wre.7
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2019 06:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Oh8yGa7KaAND9FbnIE72MJkl17NYp9pioZYW/WS5+WI=;
        b=yQDQpPxkJSKvfbzaktGEBf0ycIst2QjKEXx3+YFbiYH4OWMpyIx3IOJ+howJR5SsrR
         N9mjZfTyUAXKsfsMQzcqFX8wORz2DNYVtsTc1U24KlVAB/ogk20bGzkaaEsh8d8RDlLM
         IYYTyH6w9F8UOfYguLEXyqxWHi/dsixm4Sz1angRWNPiVApPgADeu7iUH0wjoyG6L2my
         FR5e+O5dd2H0OvEYCMyUPDYDyy88O3TPZDWa2l/Qr+8n3VCVxxvBwcdbzIpHtw5r+0iy
         hCCQbt3Nq36zq++eF8q1dQIjomUAnVu/ucGvx0ByMFDP64HaNYdLiuno+L/CUMu/pbHa
         dA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Oh8yGa7KaAND9FbnIE72MJkl17NYp9pioZYW/WS5+WI=;
        b=UP8WBxJe2CUSmaMGvqZVQ9YTLD3b/9SLKx8wFhFldvNUgAhd1M2ugwVea9So6wXORq
         KGIEoQ3J79GciPfHgStYFZsyxGRMZar8ZmE3RqVgk34VXXLFRPnYQ7YUWS4JaHqhK4Pk
         cn++clN6XqN3RdSses9G59/xWUanVmSzvCxiJQRYm4YBT1DhBp5Q6D9x8RlFhYdnY+gb
         LjsYgrwUFH5Edh+XSKAybYPf/MdaQs1i84jV6gbgfXWDWBEYvE7FQReg+zfNggEtoUIN
         MYVuAuPwqaSiQsy2bYfkAHZ6c+7P9DnVOWueiZ+cHmFhJefVIe3OksY9t+Iiz6fxHO6o
         o+4A==
X-Gm-Message-State: APjAAAUzopLKz/LvY0zkhHnqWECdCEq+K4egcT8DY2p7GdO/vEoLJWDn
        gV7XficLpexMYRALNBk8DG4zRerc+Q8=
X-Google-Smtp-Source: APXvYqwplCggB0mb0G5YFvWUgsL21gQN/BZYesjAoZaq+VDrHAYzlHs83Lch/plxeayppFbm1f1njg==
X-Received: by 2002:adf:8068:: with SMTP id 95mr17411560wrk.174.1557148645735;
        Mon, 06 May 2019 06:17:25 -0700 (PDT)
Received: from [192.168.0.41] (64.93.129.77.rev.sfr.net. [77.129.93.64])
        by smtp.googlemail.com with ESMTPSA id v18sm9050787wro.11.2019.05.06.06.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 06:17:24 -0700 (PDT)
To:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Missing patches for thermal for 5.2
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Message-ID: <b3fbf910-d073-1dd9-649c-eea370ae71f7@linaro.org>
Date:   Mon, 6 May 2019 15:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Eduardo, Zhang,

AFAICS, the following patches are missing for 5.2:


[PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m

[PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl setting error

[PATCH v3 2/3] dt-bindings: rockchip-thermal: Support the PX30 SoC
compatible

[PATCH v3 3/3] thermal: rockchip: Support the PX30 SoC in thermal driver

[PATCH] thermal: cpu_cooling: Actually trace CPU load in
thermal_power_cpu_get_power

[PATCH] thermal/drivers/cpu_cooling: Remove pointless test in power2state()

[PATCH - resend] thermal/drivers/cpu_cooling: Fixup the header and copyright

[PATCH - resend 2/3] thermal/drivers/cpu_cooling: Add Software Package
Data Exchange (SPDX)

[PATCH - resend 3/3] thermal/drivers/cpu_cooling: Remove pointless field



This one is pending:

[PATCH] thermal/drivers/of: Add a get_temp_id callback function

The series [PATCH v3 00/13] QorIQ TMU multi-sensor and HWMON support
depends on it.

Hope that helps.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

