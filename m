Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5651034607B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhCWN5Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:57:16 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40727 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhCWN4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 09:56:54 -0400
Received: by mail-lj1-f177.google.com with SMTP id u10so25749019lju.7;
        Tue, 23 Mar 2021 06:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SG2RU9BGddGqc8+LmYNU3X5hDH9nRq0LsOGSuQU+0vQ=;
        b=s0VzzVyD4zLCXcSoRrl9DTO8JC+CvDbhokb//KimK1eBtV39qos6dh4RL8WpZfNyy+
         CvUKTkxaPbEKJl9EObDmy9vRdD6YBjPj0fqKAwlpo/MWTFEb7cW9189Feab189UJDBym
         gQenjUAhWA01lATvWfss2fxtrsfODF4up1MMnlvGK/zZlVkaG3NVSuiK7OVZwEXooszi
         AY5rbjGfk8HOivJ6wuC8Fyn7JYibXH/SzCtMG2oHHX3lr5FFllHmH5B4bh4Tkf3NF/+c
         ogtKvygdKjbDM9F9+izHiBag4WEGGcrRgSiKL7HYaG3C+pFH4JXgtNA8eOrtfgf9jj57
         2jbw==
X-Gm-Message-State: AOAM530EoB2L87yRjZ7RQM3g7mfl9jndPNAPzVvDCTSGmWbnPWnLu33n
        kTaAKYh8vWYH54m0ldtm/v0=
X-Google-Smtp-Source: ABdhPJy3Q4ez4TI4HgvOym73a7CNZxNo9F4RX6+quzkcgtglSKAIYgcyFhe8wnD7m830kMhc58yt5Q==
X-Received: by 2002:a2e:810a:: with SMTP id d10mr3149259ljg.304.1616507812249;
        Tue, 23 Mar 2021 06:56:52 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id l12sm2351935lji.122.2021.03.23.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:56:51 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:56:44 +0200
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
Subject: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
Message-ID: <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devm helper header containing small inline helpers was added.
Hans promised to maintain it.

Add Hans as maintainer and myself as designated reviewer.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changelog from RFCv2:
 - RFC dropped. No functional changes.

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
