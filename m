Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F28178F9B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgCDLfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 06:35:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39221 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDLfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 06:35:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so1908007edb.6;
        Wed, 04 Mar 2020 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DPVszP3963wNdExcgJRPDsGAe8NIh4E9G99F11CZ+qc=;
        b=XdUQLmI/IVWiEXuPBYH7fvfVsR01GI/hoVyjziqRLy5X3xiB77BReI0dcgMcRrUu5D
         dOVMapahG8pFdUqHjOYIYWHLGaR60G1q/+fDuNWoHAafyJ8J5+Mbvh6EZcNWIvSlFrIq
         KOJwQd+cNNk8u48jEySS4ZYTJz7NkcBEPhjjpkB0uK0yt1Un2FVzC0KR4RZCfEJ70Ll2
         iyMov+IBO0AMKwuw/CVkwO7xE836se0c7Mn98M+SJ9Gq5bOZHvNhKXN/OUADOtVExvNX
         pMlgPNsRtA03fwhCK9s42j3CfcfIg+QZS0TJJ19KILHjmKrHsTjVWxLSy1acw4rHkrgT
         8Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DPVszP3963wNdExcgJRPDsGAe8NIh4E9G99F11CZ+qc=;
        b=YMM8blcEs685TRS4mV1tG8CnXrl/szBJvXuyyKY6PJ/q53O5gsYUWwctEUq+mct5Cj
         bBLV1B2ey4ObHW7jIHWnTWE4uMVMxRRWA8e/4DSCUeNMZpY8nd+hQq6cTS7echCta3b6
         MKx5pDu7tDP1I5B0yhfk6cqeoeXoDMCldqyTeXn5un79/6dw+tIhavNVMoabP2bOQtjb
         KiIm6HWgTABEtgT9TSkYb26w/uiWXBJFZgfzn0zh29AogSrhnJFJy1rDuHv+So23m242
         g3arxH2HnqDWT/WcXyQcWUZSV+rnFl3QmwxJOUZz053TBLnLA5vS01LCoXNo/4JXFvO5
         YuQg==
X-Gm-Message-State: ANhLgQ2CECE1fj1vCpohDPZXR0EzTsJXK6+B15JD6zHc5lggB3fZZqbU
        zl14gK05jc03b/dV1XVRplQ=
X-Google-Smtp-Source: ADFU+vvrwiVGnfIJe5IcbqtO7UovqUrHErJ78bJvdOvfQb4axpxC72rr8v7LZuQXP9axGJeBad+iuA==
X-Received: by 2002:a17:906:1be2:: with SMTP id t2mr2128366ejg.357.1583321703821;
        Wed, 04 Mar 2020 03:35:03 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d16:4100:3093:39f0:d3ca:23c6])
        by smtp.gmail.com with ESMTPSA id n4sm273434edv.26.2020.03.04.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:35:03 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update ALLWINNER CPUFREQ DRIVER entry
Date:   Wed,  4 Mar 2020 12:34:52 +0100
Message-Id: <20200304113452.10201-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit b30d8cf5e171 ("dt-bindings: opp: Convert Allwinner H6 OPP to a
schema") converted in Documentation/devicetree/bindings/opp/ the file
sun50i-nvmem-cpufreq.txt to allwinner,sun50i-h6-operating-points.yaml.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches \
  F: Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt

Adjust the file pattern and while at it, add the two maintainers mentioned
in the yaml file to the ALLWINNER CPUFREQ DRIVER entry.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Maxime, Chen-Yu, Yangtao, please ack.
Rob, please pick this patch.

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a143a13e..8e5ed8737966 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -691,9 +691,11 @@ F:	drivers/staging/media/allegro-dvt/
 
 ALLWINNER CPUFREQ DRIVER
 M:	Yangtao Li <tiny.windzz@gmail.com>
+M:	Chen-Yu Tsai <wens@csie.org>
+M:	Maxime Ripard <mripard@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
+F:	Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
 F:	drivers/cpufreq/sun50i-cpufreq-nvmem.c
 
 ALLWINNER CRYPTO DRIVERS
-- 
2.17.1

