Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F15330943
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhCHIPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 03:15:10 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:37876 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhCHIOz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 03:14:55 -0500
Received: by mail-lf1-f50.google.com with SMTP id n16so19647839lfb.4;
        Mon, 08 Mar 2021 00:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lCgeptqSMyKzW16UNWHWlgRoMtG+0iEIlO7nDP/oAFQ=;
        b=PgxP9QJTKXP2ulLWZptsVxtY0m3WwYNdWmAdiJcepCb9IdHIfHARTOduy1n6r4qcjL
         P2aEuvez+BVM1Tua/cLSHSTx0cZpwP1vMm/L8PaAiPDrMSyCyACwoEnxIS2+q7D9VfQx
         fASsIvwGeA8tygnpDm3b6LM8Od2Bic9tdPVf6ltbWfcMdo+1qNS4ri99NZV2UL5gz4Mb
         nyWMsq06wpmSXLBEJRyvTHK+vvYs6/nOfVkcGZmwKualjiR1VXAcR9sVNoZSP913nFXM
         mcwibVd5ZrFiUScIvPXIDg/wb26XiI/dZyBInEjbU2a3EzSF3H3YTxdR9rwS8n70r+DT
         Z5Ng==
X-Gm-Message-State: AOAM530PxgvNLmnTBPhGkZYr1UWP/R3gJU9xtaag1Go5OhNe0FSpTD3n
        EoLXE5lU1WYbl56TDd3q7uU=
X-Google-Smtp-Source: ABdhPJxQR6J2M4jgCmS7cRIRCbb+O5S1AbJyi70ot4XILJuJUhaUfi87OLkijIb5wu0ckRZOrq68+g==
X-Received: by 2002:a19:ed8:: with SMTP id 207mr13196925lfo.164.1615191293579;
        Mon, 08 Mar 2021 00:14:53 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id z4sm1261722lfd.172.2021.03.08.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 00:14:53 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:14:46 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
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
Subject: [RFC PATCH v2 2/8] MAINTAINERS: Add entry for devm helpers
Message-ID: <c9119c0a8d4daebff0221c67830b54314fc9e0f6.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
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
index d92f85ca831d..ffcb00006e14 100644
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
