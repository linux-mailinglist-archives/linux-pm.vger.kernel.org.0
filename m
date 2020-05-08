Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9A1CB3DE
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgEHPrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:47:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35070 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgEHPrJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 11:47:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id x73so1791408lfa.2;
        Fri, 08 May 2020 08:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KprKeb/h9kjW27OoSf2ZZ4Ya0v6rQT0g3k0Y7DumGOM=;
        b=W8JBZwKyvLMp+6zKoGup3yCa2Rn+91vUGmkVfdLrAtu7xhv0/CJhCPVYOR05at8pT7
         4KN5kCjl8CSWAJeOBN/HoFMIOXzVtJJvf1MpUt7Du+SmpRpUAEIuB1A1QXC8p+Ru70o8
         zH4XB1mqGr6Rf0rZoviQaabQDRsWlVIUjtYMaKXmxwfRsoa6WX1ojt8TWIMUH/7Ol3Ev
         AiT3hfSH7b7e0nt3E8bVUU7CD2KmKmtpAjA5LCT+2MDdI9i7XsVr1xALwnR+ixaMSkJE
         Ufl/R7DVuYdo134JxkRc9QNrsNiImR/64HPvBUZqcEW/h1jbYKwV2Cd/MYkSAct2pMV+
         jpUg==
X-Gm-Message-State: AOAM532dOb4EN4AabgnOZow190MxVMStvYaymbhDVad6gnxM/VBJih6g
        /cKXYzrdR2zXwMpDFQDUIao=
X-Google-Smtp-Source: ABdhPJyw3eaAIaBHlqv5KOfFTa+kblr0g4XntOwjG+KOrla1cyRAtkv99AWHwllLf1nfkqQPzKk6lQ==
X-Received: by 2002:a19:7d02:: with SMTP id y2mr2274606lfc.146.1588952825594;
        Fri, 08 May 2020 08:47:05 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id p13sm1447163ljg.103.2020.05.08.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 08:47:04 -0700 (PDT)
Date:   Fri, 8 May 2020 18:46:17 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 06/11] dt-bindings: battery: add new battery parameters
Message-ID: <6cfb1a37acc763143927b9541744b7bb66fbd2d8.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add:

 - trickle-charge-current-microamp:

Some chargers have 3 charging stages. First one when battery is almost
empty is often called as trickle-charge. Last state when battery has been
"woken up" is usually called as fast-charge. In addition to this some
chargers have a 'middle state' which ROHM BD99954 data-sheet describes as
pre-charge. Some batteries can benefit from this 3-phase charging
[citation needed].

Introduce trickle-charge-current-microamp so that batteries can give
charging current limit for all three states.

 - precharge-upper-limit-microvolt:

When battery voltage has reached certain limit we change from
trickle-charge to next charging state (pre-charge for BD99954). Allow
battery to specify this limit.

 - re-charge-voltage-microvolt:

Allow giving a battery specific voltage limit for chargers which can
automatically re-start charging when battery has discharghed down to
this limit.

- over-voltage-threshold-microvolt

Allow specifying voltage threshold after which the battery is assumed to
be faulty.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/power/supply/battery.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 3049cf88bdcf..5e29595edd74 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -11,15 +11,21 @@ different type. This prevents unpredictable, potentially harmful,
 behavior should a replacement that changes the battery type occur
 without a corresponding update to the dtb.
 
+Please note that not all charger drivers respect all of the properties.
+
 Required Properties:
  - compatible: Must be "simple-battery"
 
 Optional Properties:
+ - over-voltage-threshold-microvolt: battery over-voltage limit
+ - re-charge-voltage-microvolt: limit to automatically start charging again
  - voltage-min-design-microvolt: drained battery voltage
  - voltage-max-design-microvolt: fully charged battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
+ - trickle-charge-current-microamp: current for trickle-charge phase
  - precharge-current-microamp: current for pre-charge phase
+ - precharge-upper-limit-microvolt: limit when to change to constant charging
  - charge-term-current-microamp: current for charge termination phase
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
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
