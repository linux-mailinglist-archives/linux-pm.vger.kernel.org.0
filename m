Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED724E333
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 00:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHUWUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgHUWUF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 18:20:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E171C0613ED;
        Fri, 21 Aug 2020 15:20:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so4279854ejc.9;
        Fri, 21 Aug 2020 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7vQF+OxfgOKk0npVS0VvNYm6+7r6keuyTTIR2ujT+U=;
        b=KCKHNZrwbEg94W23Rxj8Q1KBSJ8mNYqRfdIwfa2pVOfhPhfVlU/rlxlzSixkZxy+7W
         6Z6nr9ReeguiAiv/b4UwP+9ysmd0auq70UoVifpEpYRqmr4gpdvZd7Znwi6tIMm/ceGZ
         zeTK5ybOXuyQASvf3ZczSEWEk0f2ZiRLVJisD5zRYQfQBtgMQj/VbdkXflZTuoa82M3G
         U1C2ecD6mBIQ24cB+/BnvW6SmpUtdPaTH09hlVvJB09QmHPmey2wae4qWe/quo5inCLr
         /LpmZsHKjrBVw7qE2BergJgROMi3epNGOsNbUbsIxDjDnXzsHhy5GZnTrOkfK6Sm/7Of
         +nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7vQF+OxfgOKk0npVS0VvNYm6+7r6keuyTTIR2ujT+U=;
        b=TeJNEFBlUWQzCj8KjJhCU2UXsS/NMGQFgIRN6EmqhrAu5hh+w8agbfTiWStdU+qOvJ
         E/YFn3g5rJnQI0TslmfhQSS+o7EG1H8AADrDD0J+0OpE99LhJacWB+Hf5It+VzH7mgPC
         hsGM4CzOFh76So1mrrb9BaxMBZ+hkFF6vvLWIq565ftVvuKxjdaE8O+doUAOAElnoE/K
         tzIy7HXPMrr7LLAVqy5Io6Dv/RTLJF0VOqUDm6AcYz/KM4cX0cUd/09C49adCcLiup2H
         ywE6TVvUDWMLMhZvCKkjNuKhitQCwHP92opBmYBWvW+iysw2Qy756LAFbGxzXnskoDkQ
         LbbA==
X-Gm-Message-State: AOAM532CaPjSl9MS/C8+o+nR0eozeaHH0ixBREthDfRqi5KNjXJX8Z0a
        B907GpQ/0RlSaGHfUuWIqmQ=
X-Google-Smtp-Source: ABdhPJwE3p74e1G3s8fppsaS1ne3bDVk4xRiz7QIHEk0U4INmIbyzz7mWUEm2Cwbe6F+UPhpN+nffA==
X-Received: by 2002:a17:906:af51:: with SMTP id ly17mr4897233ejb.81.1598048402972;
        Fri, 21 Aug 2020 15:20:02 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id p23sm1780147edm.31.2020.08.21.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:20:02 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for ATC260x PMIC
Date:   Sat, 22 Aug 2020 01:19:52 +0300
Message-Id: <dcadc77041fafe425c0bad219d55437671cd205a.1598043782.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add MAINTAINERS entry for ATC260x PMIC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[cristian: change binding doc file path, add file patterns for onkey and
           poweroff drivers, fix ordering, add myself as co-maintainer]
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e28d8ad47d03..b57ac4e9aa11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2899,6 +2899,18 @@ W:	http://www.openaoe.org/
 F:	Documentation/admin-guide/aoe/
 F:	drivers/block/aoe/
 
+ATC260X PMIC MFD DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+M:	Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+L:	linux-actions@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
+F:	drivers/input/misc/atc260x-onkey.c
+F:	drivers/mfd/atc260*
+F:	drivers/power/reset/atc260x-poweroff.c
+F:	drivers/regulator/atc260x-regulator.c
+F:	include/linux/mfd/atc260x/*
+
 ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
-- 
2.28.0

