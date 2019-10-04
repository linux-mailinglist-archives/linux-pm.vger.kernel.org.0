Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2EACB844
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 12:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfJDKbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 06:31:07 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35641 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDKbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 06:31:07 -0400
Received: by mail-wr1-f41.google.com with SMTP id v8so6542611wrt.2;
        Fri, 04 Oct 2019 03:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0sO0rv2WFDM2B56JzJt62DBkoicLCV6GGFXAS4MJE9Q=;
        b=hBhpYlRQ6HS0Wpe0PpcIvDtmErIyTOaqwtoHN/rgS/uURFfnKWIogM1VpLPpKPlbSx
         Hl+HUUL3fsym1EaEzGqFChstEznGUB2JON92pLVA6Cawn59hAv1/uqyclnU8ZmKF0i+i
         8lC+rww/WZ2sdzTpqm84+FMatjne/r5/Wl7i80N/dgpc0kUGGnyBFKmxC3sVqVir/Rzq
         3kwV8tudxAPXh2VyR5OCLNpVQ+r8xXSmdRyRziovL4Ru0lDlkYCRntbqZJ7xDn+7uqKE
         DaTxwB4Uda8pNS1k7zT/duEutFqngrsPC4U1wsNNtTwzxtl2VNCGc/KJvOI8eSodudJ7
         6LJw==
X-Gm-Message-State: APjAAAX3UtZSyDAb2bLWsPsk1dVytEgtnNHPir4RKJMNaVxmJXvIyErZ
        ImAwdijswT2vfCEmlIXDjP8=
X-Google-Smtp-Source: APXvYqwRzwsUGvltETEBhrXSxWhDZg0vSWGhh6uMJ37eqdE3Dm/SZGQk+dOyT+pLpEySMZOIaLqOfw==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr10537639wrq.257.1570185064934;
        Fri, 04 Oct 2019 03:31:04 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id a13sm13449859wrf.73.2019.10.04.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 03:31:04 -0700 (PDT)
Date:   Fri, 4 Oct 2019 12:31:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Devfreq looks for unsupported frequencies on Exynos
Message-ID: <20191004103101.GA9176@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi All,

I noticed recently error logs when booting Odroid HC1 (Exynos5422) on
exynos_defconfig, 5.4.0-rc1-next-20191004:

[    5.168786] exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
[    5.177022] exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
[    5.184705] exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
[    5.192903] exynos-bus: new bus device registered: soc:bus_fsys (100000 KHz ~ 200000 KHz)
[    5.201414] exynos-bus: new bus device registered: soc:bus_fsys2 ( 75000 KHz ~ 150000 KHz)
[    5.209986] exynos-bus: new bus device registered: soc:bus_mfc ( 96000 KHz ~ 333000 KHz)
[    5.217931] exynos-bus: new bus device registered: soc:bus_gen ( 89000 KHz ~ 267000 KHz)
[    5.225222] exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
[    5.225975] exynos-bus: new bus device registered: soc:bus_peri ( 67000 KHz ~  67000 KHz)
[    5.238824] exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
[    5.245719] exynos-bus: new bus device registered: soc:bus_g2d ( 84000 KHz ~ 333000 KHz)
[    5.252653] exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
[    5.263518] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 67000 KHz ~ 267000 KHz)
[    5.280650] exynos-bus: new bus device registered: soc:bus_jpeg ( 75000 KHz ~ 300000 KHz)
[    5.288827] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 84000 KHz ~ 167000 KHz)
[    5.296957] exynos-bus: new bus device registered: soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
[    5.305939] exynos-bus: new bus device registered: soc:bus_disp1 (120000 KHz ~ 300000 KHz)
[    5.314036] exynos-bus: new bus device registered: soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
[    5.323090] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 400000 KHz)

You can see that Exynos devfreq was trying to set 532000000 Hz for
wcore, 111000000 for noc and 222000000 for fsys_apb. These are higher
frequencies than we have in DTSI.

Any ideas why? It does not look normal...

Best regards,
Krzysztof
