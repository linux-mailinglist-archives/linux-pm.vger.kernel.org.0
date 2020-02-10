Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483B515743F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBJMLe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 07:11:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38543 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgBJMLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 07:11:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so6862392ljh.5;
        Mon, 10 Feb 2020 04:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lB5Gls1bE5ZTM4FMK83JW7NErQx+DjSi+JPZdDq6b/Q=;
        b=fgXpoB97Z2uDj0LPfwUfTrJuc/09JkoKK0RpXenJ2XGazDyNxD3DCtxP0hGTbdSejs
         EXHfRZgdCNlm//vlzUNbx0WWptrNrbUhnJHDdzY+jCtEhlBXS9KCWgDoMl9wagNLYxTa
         htuC/Ha+ickz1eJL/Po85qgTOrdY0zr1q1XcNFLMCyftFTX5powedeuzcEarraBE4fhu
         HznNE7SUrH6/dXxtMkzAZqLEjLT5E8fhR7in1XpEZ6mIjm1bp6TGEd8fl3nfWRue3lRC
         COo9lgE/gZYvtEa49PMGROahvpGVCf8X/vENiNhvKScrNsZ+Aum44C9ujHD61I/WVr2v
         nPXw==
X-Gm-Message-State: APjAAAU0MIoVI5lmgKFvsWRyklISXG1fsp+GR0F3/bSVnbrq3z5kakS0
        VzPbPh4Ieso2YUacDpNFFKxhYYcU
X-Google-Smtp-Source: APXvYqzBK31c7zKdZ+qT85bpPwAbr58MQfb3D4n4F3URm6rq4jWZ6p1cySqQbYIll3nD6/mRI1XBeg==
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr741897ljn.48.1581336690406;
        Mon, 10 Feb 2020 04:11:30 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b20sm133154ljp.20.2020.02.10.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:11:29 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:11:20 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Support ROHM BD99954 charger IC
Message-ID: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support ROHM BD99954 Battery Management IC

ROHM BD99954 is a Battery Management IC for 1-4 cell Lithium-Ion
secondary battery. BD99954 is intended to be used in space-constraint
equipment such as Low profile Notebook PC, Tablets and other
applications.

Series introduces "linear ranges" helper intended to help converting
real-world values to register values when conversion is linear. This
version just meld the helpers in power/supply but this is hardly the
correct place. Maybe they would fit regmap?

This version of series introduces ROHM specific DT binding entries
for few charger parameters. I think these parameters are pretty common
and maybe the "rohm,"-prefix should be dropped and we should try having
common properties for different chips?

If this seems reasonable I can try drafting parser functions in
power/supply framework and extract the corresponding DT yaml bindings
into generic power-supply.yaml doc.

Please let me know if you think these properties should not be common
- or that the power/supply framework should not contain helpers for
parsing these properties. Then I'll just drop the RFC from series and
submit the ROHM specific properties and do DT parsing in this driver.

Patch 1:
	BD99954 charger DT binding docs
Patch 2:
	Linear ranges helpers
Patch 3:
	BD99954 driver

---

Matti Vaittinen (3):
  dt_bindings: ROHM BD99954 Charger
  power: Add linear_range helper
  power: supply: Support ROHM bd99954 charger

 .../bindings/power/supply/rohm,bd9995x.yaml   |  118 ++
 drivers/power/supply/Kconfig                  |   14 +
 drivers/power/supply/Makefile                 |    2 +
 drivers/power/supply/bd70528-charger.c        |   65 +-
 drivers/power/supply/bd99954-charger.c        | 1056 ++++++++++++++++
 drivers/power/supply/linear-ranges.h          |   36 +
 drivers/power/supply/linear_ranges.c          |   89 ++
 include/linux/power/bd99954-charger.h         | 1075 +++++++++++++++++
 8 files changed, 2398 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
 create mode 100644 drivers/power/supply/bd99954-charger.c
 create mode 100644 drivers/power/supply/linear-ranges.h
 create mode 100644 drivers/power/supply/linear_ranges.c
 create mode 100644 include/linux/power/bd99954-charger.h

-- 
2.21.0


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
