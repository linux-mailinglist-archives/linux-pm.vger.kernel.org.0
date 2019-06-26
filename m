Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F167C55D8E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfFZBfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43032 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfFZBfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so345356lfk.10;
        Tue, 25 Jun 2019 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dakuSXC8S+4d3ZwgTUxyU+C7IUHzNyF1kauoHOg6pX0=;
        b=J/zWkhFq0bg3fNHcialc5pkUp7773LPu/FpnnieGQB3C/hU0HezN98HbZojxjS38fd
         33LvhjnWMFRFOxlEITiia62qce/x96BVnzu+9XYNVOok+jdFuyyIQxE3kwP5sXRtpmH2
         7c0k0yZZ1RN52w/zt9CAGZ/y1ZeHh5q8YDSub43ZKFDHEwZueFgHAfcbKrQoEFiev9GY
         +lVJeVt9ni/lZLBaBQ6ipJe0WioEX/xbagpPQ8VaToKlYqEcmOwd071K5jVxuxVuOFzz
         vgRgKobhmxwQXKsHMv+itlWnr7auFiHT142Z0ALxqxDb49f8YIhTcOHqInUZWFPh1kfN
         6gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dakuSXC8S+4d3ZwgTUxyU+C7IUHzNyF1kauoHOg6pX0=;
        b=E3b5cB3AeCt/MmYdnh2Rm8ucixmaoXN6VpQaFezrzn1lswqKFYrYI+kP+sifqqiXTm
         2y98Uql8Nx3dAbbsw1D7I/F4tVN6Q2ph8HyTf88LesBbOyy1/X6ngDu+uhvFnxAyBWGy
         uFlb7ZOHMk/y0uhhlbNWdqQ8vpx8tz8vlwA4rxpizlLO2XzsNdDXsLsxoVCO8hzENnH1
         w86vLAD3Xw/bMuShFF66STrIkgL8tZXKNqRybEDgQuv2ZWKiDl3Mz1N4uwVNVEkR4wBL
         Eh6ey3/eKTqMpSNZNeIF2Ap9gufRZBsWC0rhYTmGfgpnhLBkbR1UXobtCspXcNPx+8qn
         +NTQ==
X-Gm-Message-State: APjAAAV6BClo6j6EC8/ioIcC49FIbgDxqrAoYJpBH175EQ/zxYuV+dkn
        hX3m8JQDlcVx66WtKuLc9aE=
X-Google-Smtp-Source: APXvYqwTA4+vjBE6dTRR+9PeAJurgBpFuRGPMd2Huei0KYA06uoksUuaOEXZRtyoYUJmWTBPFovrxw==
X-Received: by 2002:ac2:5595:: with SMTP id v21mr885509lfg.54.1561512902954;
        Tue, 25 Jun 2019 18:35:02 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/17] PM / devfreq: tegra30: Tuneup boosting thresholds
Date:   Wed, 26 Jun 2019 04:32:40 +0300
Message-Id: <20190626013252.30470-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that average-sustain coefficient / multiplier is gone, it won't hurt
to re-tune the boosting thresholds to get a bit harder boosting for MCALL
clients, resulting in a more reactive governing in a case of multimedia
applications usage like 3d / video.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 30c5b3531d6f..9b172e2acd40 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -111,8 +111,8 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.irq_mask = 1 << 26,
 		.boost_up_coeff = 200,
 		.boost_down_coeff = 50,
-		.boost_up_threshold = 60,
-		.boost_down_threshold = 40,
+		.boost_up_threshold = 50,
+		.boost_down_threshold = 25,
 	},
 	{
 		/* MCCPU: memory accesses from the CPUs */
-- 
2.22.0

