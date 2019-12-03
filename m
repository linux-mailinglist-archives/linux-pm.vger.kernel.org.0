Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F335311006D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 15:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLCOgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 09:36:51 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36878 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCOgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 09:36:50 -0500
Received: by mail-lf1-f41.google.com with SMTP id b15so3166682lfc.4;
        Tue, 03 Dec 2019 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MWlNOpLYUXyynuUbBoIlviu99rJXrCd1w27Szcg8nxQ=;
        b=boobbRiKrIPjTW6itg9nafPgOCtMvWmGC+ptOoIn5x21f/zUx5kM10rE0nzo4pSTyr
         op0gr1Irwb5qdB0agrw0bFdeZGASEocLnYXJF72RlBDdjxMKu706I6gXAFiscKk3/bWx
         KYM05YFPnzhzQ0uG1n/NEOW8XX5gn987+4RQqOlw/fQvtehhzWRRsqZzeyr7/5iFaOtA
         JKk6/1fXdf9O0PT6UXfkYmrglOdQLtSbfU2f1+UDQCE3lDTSIyDQfUfkAB5nhpNXouAW
         VTuqE7uRpjx2Hi0zA+r4S2sDwaC7FCWOB8WVODyAic0sGkujN1IuRLS6v5O2zeFYl7kE
         F/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MWlNOpLYUXyynuUbBoIlviu99rJXrCd1w27Szcg8nxQ=;
        b=AKV8tinKCZo3t2OhpRAaGf2G8lSWsWx34KHGvNq2FYVZWEqhnrST90lpNSw8+zdgM2
         w5PBnmIvzltT6yYzhSyG41tgrOU9pv7NbkuMikKlOEWY9yAP4A6uFy6e5qxFM/MEgobb
         d+B7bX+k5ZqthYkBMN/YpfLGcrfVnAvGtLj+9iTJwJ7EQza5H2c8PCKWEWGTka6Xv6JH
         bszKOnEcbhLUDZaL+OOnI4WASPLSU4FRYQrCXX1nBd5wlJ1joKw9mRBswEpXWKJA6sAk
         ynKcAprE4stikqZWBVHb4913+UOStB8CUIx4Cl44r8CKNbTNmVumAdyuKzzI/1XXLMz0
         QeYg==
X-Gm-Message-State: APjAAAUzAbiEtVKEb82owQblnl54nXw03a2FRIFuRfT9Qtjz851ZY6WJ
        YgcX9Ke1zschY4pt+tsfBp8j0Uk9Ftk=
X-Google-Smtp-Source: APXvYqxz+iqVJ1nXYsxcFQM+E9DEQaIYjcDD18Lb+xCZkg87RKMsYuZ0gozZM4Pc+YR3dILDlKilrA==
X-Received: by 2002:ac2:428d:: with SMTP id m13mr2986962lfh.64.1575383808313;
        Tue, 03 Dec 2019 06:36:48 -0800 (PST)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id l28sm1454032lfk.21.2019.12.03.06.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:36:47 -0800 (PST)
Subject: Re: Issue with imx_get_temp()
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com>
 <20191203101509.wte47aad5k4mqu2y@pengutronix.de>
 <CAOMZO5Cn993y9VeFN6hPO3-cfNnUKiuFd_rqAZ8htz=dO6t6ig@mail.gmail.com>
 <CAOMZO5BniszDhWKkoWY=P62kv9cY160r9P=pjpbSOZasxJvdBA@mail.gmail.com>
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <77fff313-3f40-6b5e-fe30-5a65a189bdff@gmail.com>
Date:   Tue, 3 Dec 2019 17:36:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BniszDhWKkoWY=P62kv9cY160r9P=pjpbSOZasxJvdBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Fabio,

> Does the following patch help?
> http://code.bulix.org/l3rz2e-982595

Thank you!

Patch applied and will be tested.

I will inform you about results.

Best wishes

--

Igor Plyatov

