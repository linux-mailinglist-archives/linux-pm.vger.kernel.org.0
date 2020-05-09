Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193621CC254
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgEIPQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 11:16:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35687 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgEIPQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2020 11:16:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id g4so4796487ljl.2;
        Sat, 09 May 2020 08:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Cg3G60rZUQuGotkg/nEmi6CTgypKYah/ph6hteIHFa4=;
        b=OUhPOgXUDLPmmO1bv8CE65YdjKvaG9tpQZPyBccL2JoBZWw9vAW0sWmQ9WOvEMCvSR
         nsWIJYZx9MC9g5Ex66Yvy75Yz9NFOy+3HC7nU3C66h+CWKf4AU08ANDwmoe12vpZcamX
         M+SxHzPQ8Hzdoc9YOm5ADHUN3Q3X0Vd9up0znfvH4JrVKOKsMW668/kxgS03TqLAspJN
         mtF4eQRSK+Jdro2lTS3nAGayvLhYY1p95JOnyVbieol1UNbubnc3/xmtV8LohYvLQQ9M
         moXaXZlFVgKicX/C9Un4No0YFhc8HU7X8VOAITTS3d7i4qvBVoivxfuTaG67km9n9vUv
         gUkw==
X-Gm-Message-State: AOAM532gTIJFHB3AKmL/oO1Nl6lUoeivFDpTXUS2sEdJAsD3ENWPKsHQ
        ldudVE94aDu0HD/fB/Jqfvc=
X-Google-Smtp-Source: ABdhPJyCT14T3CFJZl7PaEVzmV6oqL2DfPcgHTr4L/6p8QBJGQqkRljsg/X4Wp1T0yRaMbLKe1EwKQ==
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr5130796ljj.70.1589037358456;
        Sat, 09 May 2020 08:15:58 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id o3sm4289980lfl.78.2020.05.09.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 08:15:57 -0700 (PDT)
Date:   Sat, 9 May 2020 18:15:19 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org, brendanhiggins@google.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: [PATCH] lib: linear_ranges: Add missing MODULE_LICENSE()
Message-ID: <20200509151519.GA7100@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When linear_ranges is compiled as module we get warning
about missing MODULE_LICENSE(). Fix it by adding
MODULE_LICENSE("GPL") as is suggested by SPDX and EXPORTs.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

I saw Mark applied the linear-ranges patch. So I sent this fix as
incremental patch - but I still use the same Linus tree as a base of
this fix - the linear-ranges file should be unchanged in regulator tree.
If this does not apply I can clone regulator tree and create this fix on
it.

I don't know if this is the correct way to fix this as the linear-ranges
should be merged to power-supply tree.

I guess we can either:
- Use this patch to fix regulator tree and create fixed tag for
  power-supply(?)
- Add this fix in the original series and resend whole series(?)
- re-create the series and drop the already applied patches. Add this
  fix as a fixup patch in new series and apply it to power-supply tree
  after the linear-ranges from regulator is merged to power-supply.

 Please adviece me if this patch is not the way to go.

Oh, and I am really sorry for the trouble. I saw I had regulators=y
in all of my compilations due to some pincontrol dependencies. So
linear-ranges was not built as module in any of my test compilations :(

Thanks for testing Mark!

 lib/linear_ranges.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
index d1336c75ccd7..9495ef3572b7 100644
--- a/lib/linear_ranges.c
+++ b/lib/linear_ranges.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/linear_range.h>
+#include <linux/module.h>
 
 /**
  * linear_range_values_in_range - return the amount of values in a range
@@ -239,3 +240,6 @@ int linear_range_get_selector_high(const struct linear_range *r,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
+
+MODULE_DESCRIPTION("linear-ranges helper");
+MODULE_LICENSE("GPL");
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
