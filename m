Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2A343AAC
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 08:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVHhF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 03:37:05 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46921 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVHgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 03:36:53 -0400
Received: by mail-lj1-f181.google.com with SMTP id u20so19763908lja.13;
        Mon, 22 Mar 2021 00:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQ3PaiTY3yrXW128oXOTKmB9MRClkfJjAeG90z4F670=;
        b=HBfRZmWwGzE3Uuh4EhcxibbYPEiRTOfeocrFoRvFOU8lA2sGMZP2yFBQnOwF4dndef
         f16p4n7L4HpTZY8o50PEuyranAKd6E0Z+MXucWaJirxNnTZYHOt9btbpCQaUI5XZYCIs
         xcvtSCZcJGn5I/fTHpfGn3mTs8JNL2aIcNfUTDIuOf/FIDQ6rTPPioQCmLEV8/jAmYrZ
         GmqiZZXUn/x+cBjyLEft8DPe65TlZBTSsk/hSWCJAkqpt6/aGIh0NguFcUH30mQzjspC
         86OXwHzRIo+G3xqUw5+kxzekIJ01mWWOok7mFl/QsyXpAAoZnIvOeqK7FJQnAonRMQN/
         l1VQ==
X-Gm-Message-State: AOAM532vxCPhjHCAbnNbIAQoCQ/uHiHl+9x5RxQfu2s+37OOftAr+nXt
        qf5VIOoqXyawgT6F0U855OU=
X-Google-Smtp-Source: ABdhPJzWYjRawOPGm//U/R7ppWGtgRokdpLoSf2xViSu58s6hovmWp8M40iLaLfFZP996aPBqt93VQ==
X-Received: by 2002:a05:651c:105a:: with SMTP id x26mr9078307ljm.111.1616398611316;
        Mon, 22 Mar 2021 00:36:51 -0700 (PDT)
Received: from localhost.localdomain (mobile-access-5673b7-246.dhcp.inet.fi. [86.115.183.246])
        by smtp.gmail.com with ESMTPSA id i2sm1475632lfl.308.2021.03.22.00.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:36:50 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:36:43 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [RFC RESEND PATCH v2 2/8] MAINTAINERS: Add entry for devm helpers
Message-ID: <eec1797734e3d080662aa732c565ed4a3c261799.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devm helper header containing small inline helpers was added.
Hans promised to maintain it.

Add Hans as maintainer and myself as designated reviewer.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e876927c60d..fa5ac3164678 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5169,6 +5169,12 @@ M:	Torben Mathiasen <device@lanana.org>
 S:	Maintained
 W:	http://lanana.org/docs/device-list/index.html
 
+DEVICE RESOURCE MANAGEMENT HELPERS
+M:	Hans de Goede <hdegoede@redhat.com>
+R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+S:	Maintained
+F:	include/linux/devm-helpers.h
+
 DEVICE-MAPPER  (LVM)
 M:	Alasdair Kergon <agk@redhat.com>
 M:	Mike Snitzer <snitzer@redhat.com>
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
