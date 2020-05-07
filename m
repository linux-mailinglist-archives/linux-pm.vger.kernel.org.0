Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5A1C823B
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 08:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGGLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 02:11:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38411 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGGLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 02:11:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id e25so4986633ljg.5;
        Wed, 06 May 2020 23:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KprKeb/h9kjW27OoSf2ZZ4Ya0v6rQT0g3k0Y7DumGOM=;
        b=LSFK3nbRDOs9UMZ/gtFkuAZtY1U/bo2cXiqOdoyJKH9ApagnnTvJGHZkGr5fkSijdo
         AhGTLYw1JweLDIBzu0D16M+zXk6JdoCEC52cSdeR4nA8LBy4PDg5NyxCQN3y08wRNsom
         /fMisb6b/qGucLjnM8n5KSW5pE3N89fgRoG5szW6ySlkXnykLY3HEGLJjMnpXcMPUESE
         rPTpGyXWRuk9C8TreUz6K5v/RwuY9CdnqzPeTTtl4SBIxt6Wv284NkDsTJrIRrMaEuZy
         OEf5t9W4c8x/z+JX8zfE+7qPE3gutwHc3WamGQ2ndlA7wjKpHj4omZYktToqRYsXqyM4
         ylpw==
X-Gm-Message-State: AGi0PuawO6wpXEWvKGRCoXcSHIX3ewVF7l0WDaGqEsjAVwld5OOvekGq
        2/LKAQetgS0DAsd4m1Q6wKKkDiMtWso=
X-Google-Smtp-Source: APiQypKb9Hn82Q8kZeqqYq/EAuBvCn+5mGtpwnuEROaY0Cg9N1wact70nN1a7xIQ7qd8+EoPJE9bRQ==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr7018069ljj.136.1588831872522;
        Wed, 06 May 2020 23:11:12 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id u21sm2625894ljo.61.2020.05.06.23.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 23:11:11 -0700 (PDT)
Date:   Thu, 7 May 2020 09:10:26 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 06/11] dt-bindings: battery: add new battery parameters
Message-ID: <cef68ff32c3cd6042fe0a3deb6b7081c7633957b.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
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
