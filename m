Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B491BD54A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 09:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgD2HBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 03:01:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40291 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2HBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 03:01:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id y4so1416205ljn.7;
        Wed, 29 Apr 2020 00:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptPYLDei9LMsvhdKW9/nay5bhWp9Qq4b7cAcaUxshS0=;
        b=sI7Q3oMH3ORGN4oKJKwqzteji/kk9Q7ewqE3/Y7odvuM0e2BrYhh5TWi3hPNyAj0G0
         tFqetBv5RxQj0P0V2mM8noMXqZrkJVRTHYJs0BKIB7RlihiLUxu9JduA1P+ows7wG0nJ
         R3O5NfaOyrbAAxh3vMvyQkLb2pav5CBz2HYhdiLQSzPbalLiH3RGTrvKIH6g93eWD3cZ
         sj9zHrnrysnAwJdjPUm0h1/3SsfazfuWrQHE+pgvu7URXktOoYH2bQ8FDBc6L0PL15wx
         GXdHWUeQCgjht+EeuABBiT8XZUa/CSUoQ9mFkzxD4HRu8tPTsBZmTSePgwtnoaVPr0kn
         KwlA==
X-Gm-Message-State: AGi0PuaPI+LONLGG8aNn+8X+fhPKfHhPahUFeSee6ysBkFRleRigCGyf
        VY0SNZgmqXTKEcDNo9qxzWU=
X-Google-Smtp-Source: APiQypKMS7huMXVCwkN0xqaQZEasmGknHyh+qzVqmq/W6qhQomOoC00vc8yxZ9z4Kv8EM7paUv0ttQ==
X-Received: by 2002:a2e:96c2:: with SMTP id d2mr20730865ljj.214.1588143668845;
        Wed, 29 Apr 2020 00:01:08 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id w29sm1775466lfq.35.2020.04.29.00.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:01:08 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:00:22 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     sre@kernel.org, robh+dt@kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v10 06/11] dt-bindings: battery: add new battery
 parameters
Message-ID: <f2f0eef84a3b0bf852ffb07e2a6224f5b19ab653.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
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

No changes since v9

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
