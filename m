Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566C816587B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 08:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgBTHef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 02:34:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34680 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBTHee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 02:34:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so3152888ljc.1;
        Wed, 19 Feb 2020 23:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wXda0LyWckmOxCnu3svogcv/3s7lvsQvOxCdmqlN0xY=;
        b=D7Uc2RPGA0cbVeLQZ+eGd835uL/rqhCKrAUA2bfj1XMUFIHsNqYn0MZzYBNbYN5LY7
         8Mr4JlTH494RuJjgJoDwTE6kLi2JYaBKQfFkSVyLayeclUOc89sjB41dZa+75gWcbq/r
         qGpMJoPxnLwXGznavzjv/jAXEvF06v+TGca9BPj7CdwAHxVsL46BrCjGCNjcF1h2eEEm
         cVf3eEFQ4ifiT6O0OOklGSqNNQTh5BShGemSVS6Talp4IRdC9byFFOx01ce2CFy7qtoE
         ZZSdCGYW/EjoJsGNWcwlGCfgd/S/fOmwZV6RERvDB7rX+XVjbbYwk2se1qk3MQ3jacKE
         YSsg==
X-Gm-Message-State: APjAAAXu/PP9g78itDHibHQ/7oaYKDCe6KFfTUXW4MZKl4OMJlg3H0eB
        qcYhG0Mov6APmyJilhsK/ug=
X-Google-Smtp-Source: APXvYqz/C8xvZsGRp6+GrWlhC0fklQ19iCSL9tLVLoErEIBwsW7OcMSutpzrdaGhC6S9CU54nYAa9A==
X-Received: by 2002:a2e:6817:: with SMTP id c23mr17518667lja.263.1582184072548;
        Wed, 19 Feb 2020 23:34:32 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e8sm1316105ljb.45.2020.02.19.23.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 23:34:31 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:34:19 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "GitAuthor: Matti Vaittinen" <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [RFC PATCH v3 1/8] dt-bindings: battry: add new battery parameters
Message-ID: <b666945726093d586d3ab528e1a75a51175c6612.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
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
---
 Documentation/devicetree/bindings/power/supply/battery.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 5c913d4cf36c..1ad05dd59213 100644
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
