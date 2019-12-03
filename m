Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE3110036
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCOeu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 09:34:50 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35688 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOeu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 09:34:50 -0500
Received: by mail-lj1-f182.google.com with SMTP id j6so4111992lja.2;
        Tue, 03 Dec 2019 06:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=M6eYxvrmGTgvLkHnmtaDrBAJscdJSkVSQQjq8E421sE=;
        b=l+EtDD0mmto9cjLtj65Q3j0IaYnGm/KLzNZuSMDoVEB55z/0UXMyoddvpqCXsqgZTt
         9SBqXWrpVo14hIcYuRGzC814fm+Eih8ZMdAyMdwNwahs4Ei0e+1Xtxcav82AAq6NXd0x
         sFX6cAydu1nv1O9C4vO00vYX/pqRfkHE6fy+5xzY9eH9D7G1uUiJycxYQNBuEgfvaSCs
         EUTVGVvKQH7oLcqAOnIvW14jv27u6lr6gjgrcIlwfJSpPOSXs4dyOFmVS0VKd+bFDvNU
         K4KDsHGdm4BDuOztsFeplbswtVRpK5zZBFIW7bb6XBktQW4TghuBK4DDJpdML+vZYOy+
         2bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M6eYxvrmGTgvLkHnmtaDrBAJscdJSkVSQQjq8E421sE=;
        b=UlQKI8Cvhv23PE5LYyFv7DPlYRD4b5SFae88afBbeNRu3YW5j6Se0SAke1P0NAkYSU
         USn31b7zNPHhyNXAuzrXo0w9yKFfl6o6hfI/1E7jLiq2/XY2uEPS2VMpdvxxmGV96rS2
         lizuAzF5nr0srNzjw93j/KERECJ52WWxUhbHpzph8rAnaPvIMwpRgKmFidiKLtGJdgJ5
         YKr5ZFvN5XS8Dn/SChWxYH+EJr0OGKWaQ8gbAJm653Iz06d0lv3jsqnxn8UcZbuTkXrE
         UR8F/MBLMEudys+2Pquydcz5vXLf7e2ri1pJk3h1Fv71750PYT4MkEJGWhcy8KSHlO2e
         ermg==
X-Gm-Message-State: APjAAAUk8ji9KCKzn7TGIWM3XXrR2IzMlOLsiQtrV5hK8TD7DM0Bx52H
        pSpL1k4CiNi/QpDJz+Rg6rVsWGV6wLE=
X-Google-Smtp-Source: APXvYqxM/TOCCnbM2c2O3Dv/w38/MFFDMAoKmFjSGRwUQRs2Ew0oMYt823SYDS7D84H94ojX/PWVtg==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr2743098lji.110.1575383688248;
        Tue, 03 Dec 2019 06:34:48 -0800 (PST)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id t27sm1493932ljd.26.2019.12.03.06.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:34:47 -0800 (PST)
Subject: Re: Issue with imx_get_temp()
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
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
References: <de442143-568d-5fbf-ed0c-d169e33e5d66@gmail.com>
 <CAOMZO5Aoj9pUpMdqVTG2pOUBUpnHsxA-Kduhia7_EJZvdEGjwQ@mail.gmail.com>
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <edcbf5f1-7d77-a384-6746-02154cbf497c@gmail.com>
Date:   Tue, 3 Dec 2019 17:34:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Aoj9pUpMdqVTG2pOUBUpnHsxA-Kduhia7_EJZvdEGjwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Fabio,

> Are you able to reproduce this issue with a 5.4.1 kernel? 

Sorry, I can test currently only with 5.1.1.

Best wishes.

--

Igor Plyatov

