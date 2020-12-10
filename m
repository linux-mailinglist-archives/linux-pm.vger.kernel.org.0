Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E792D6B3F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 00:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgLJW6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 17:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388817AbgLJW5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 17:57:35 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608CC0613D3;
        Thu, 10 Dec 2020 14:56:55 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id f9so5582815pfc.11;
        Thu, 10 Dec 2020 14:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVjxVtqxXgYN9c2nHomeMFAAgnOeXuzABonf9BV14U4=;
        b=b90aCyK61/PhANWhccytnEiZPgLJrXVSS+yOEGGXTBUCtYbkJCYkXR9nogJn9FnUkd
         0soQ+hgDOs3C612CbD0SSN5bE6yztYah41jTPp8UircUNHegNkyxfmJAS8QK27NxgANw
         BthxfuEnhu1e5vMHr1PgOd3cA2i5nGw7GRwwXZ7v1WLlIGewPsMFktyMn26qgJnc4cQx
         jKGgJSi1g6wkd+3KtyYCWGuElgw9CuSa55WIhMoFq0moDWtxq/wtYpnW/rheR/OqpxLw
         YQ9cltTQrdvS2vvclz+f8jnDN4imBKSplrJvzGaLR8IM2uv63Kp9mXq+c4yOFMH6/3Ss
         EZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVjxVtqxXgYN9c2nHomeMFAAgnOeXuzABonf9BV14U4=;
        b=sd+oKS4IFMXZkurvmHV1KECTlQEsKYdQxrHyt7QY9M3h4sn2XCwN/XiyJBz7fHplHQ
         bi7EQZ7QSyq3rsyDNtBSipcioo0TAcn8uDwFnwtcjWk1QaO/LvqRo78cRmj9Zl2fVyYn
         93zaltLc4iSejLJ70Rk4yJzD6GTqMVwQxZAUF+/y6t6IgJIpEimb1WziMY0EHI/DgoLH
         G3vwZSCz9GUZvoIz1SLdY987nYLXTGAPlummSUoqk7BFYxfO3cDZLKDJQqugzpIReN7D
         PCNricSBiWnD/32tD1e15c5kjx8pBSvukGVs4y8j9R9WpkDqlG6MzTxz/lc+3XjqnH9e
         X0vw==
X-Gm-Message-State: AOAM530Eu6WP9RRaYwdMLuUm33YLAV0Pa/bbS4yycTfLB1WcxsTdrayw
        Z+wBCD38lP1s/klCXnXuFds7udJbpPXcJKno
X-Google-Smtp-Source: ABdhPJyWRuFdUjfzV/+3SCLci1wxl4ir7wcOCxaVg+zFHV0Di0MAWqIYw3A4X8eW2b/u2+e7NxTtVA==
X-Received: by 2002:a62:8205:0:b029:19e:717c:d647 with SMTP id w5-20020a6282050000b029019e717cd647mr8859674pfd.50.1607641015100;
        Thu, 10 Dec 2020 14:56:55 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id w63sm7429996pfc.20.2020.12.10.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 14:56:54 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de
Subject: [PATCH 0/2] Add processor to the ignore PSD override list
Date:   Fri, 11 Dec 2020 07:56:38 +0900
Message-Id: <20201210225640.317719-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Here's an update of the previously posted patches at [0].

Patch 1 refactors the test to ignore firmware provided frequency
domain into a separate function.

Patch 2 adds the APU (Family: 0x17, Model: 0x60, Stepping: 0x01) to
the list of CPUs for which the PSD override is ignored. In the absence
of clarity regarding the affected CPUs, the patch adds the CPU by
model numbers.

Thanks,
Punit

Changes since RFC:
* Dropped patches 3 and 4 to add macros for AMD processor families due
  to lack of interest
* Patch 1
  - renamed override_acpi_psd() to amd_override_acpi_psd()
  - Changed return value of the function to bool

Punit Agrawal (2):
  cpufreq: acpi-cpufreq: Re-factor overriding ACPI PSD
  cpufreq: acpi-cpufreq: Add processor to the ignore PSD override list

 drivers/cpufreq/acpi-cpufreq.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.29.2

