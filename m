Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6770A2C4264
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgKYOs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 09:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKYOs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 09:48:58 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E2C0613D4;
        Wed, 25 Nov 2020 06:48:58 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so2612192pgi.11;
        Wed, 25 Nov 2020 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Peq0jO3BCmWDdna3/CVkwJcf6SyZq4/YYykGC72XjLE=;
        b=Dtb61BkesKg7tTzhrP3m+tDr6y8W3wRnJBdvtxweItL9j/7gPcFKUcmZQ2OBUGovzs
         KX/IBkmIr4tLzI/2HvW6EJsvPUaDcDjIXRNPBwp2y5OlZyWrXs7wXR/xEpjNCv+f73GJ
         Wzm+8gOISOTg+VAUGGjumcFsblh0LPwRxPiHBmwtfV+QjaSMzJv/qVw14bFVkBzOe6VV
         QEJBlbTIT9Vmy2/6qT2Zjjk8pTZ7ktLLLD7KYXJMhz+VsVg7N8JuFEOiJoGUYDk4vXoB
         WK2DQPE0NGIMMjicutW+jG6ixianPVOf1K66s0C/oH4pA+8xpe3Wz6FaX2ks0nmpfEDi
         uBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Peq0jO3BCmWDdna3/CVkwJcf6SyZq4/YYykGC72XjLE=;
        b=N5jNdyzCJNgYHoxEPvxHLe+m/SL7TsglGtj4rNdS9dQYRgNSLPH6Dr7tuidsZoolER
         dtZ+tjp+qTTY4jpj/8bH5l1j8fdb/2I7yCiN9CnWmjVQ8KUme907Tj7vDRusJIepWX/O
         m2jtUmymh3a0z1kLlcV4zgqge4TljlF4Fy/lWbK1+c8lzcpJGBEbROeqT5rSK8SUB8tB
         +C7EsOPiTL5NcmrJzGPHb9/VF/6TVBHPXHDB2FfhDxKuE3EeD3pP29wRRN8ISKmYuXp6
         sNZJkPOzOaxHbkLslsZ7liijYXuLRfhOfiK+SGYc/rbZTjKjDnNBb90u526IoD/KpZEt
         91kw==
X-Gm-Message-State: AOAM530tebWhlZGqF0xY6CtRlcmqwb1di9fQTL3JwDpdH/TGjTV+N/1t
        kU3MTe5zZ52MOIaIAOxRzAU=
X-Google-Smtp-Source: ABdhPJwdFGXPgmP55et0ykEyYLizZsAY98yHBI+wk9OTNsWHja3dYJ03Kt/N2XeX0vlv8zrKbrQWYA==
X-Received: by 2002:a17:90a:8412:: with SMTP id j18mr4833520pjn.124.1606315738059;
        Wed, 25 Nov 2020 06:48:58 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id f5sm2259570pgg.74.2020.11.25.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:48:57 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org
Subject: [RFC PATCH 0/4] Add processor to the ignore PSD override list
Date:   Wed, 25 Nov 2020 23:48:43 +0900
Message-Id: <20201125144847.3920-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

While looking into Giovanni's patches to enable frequency invariance
on AMD systems[0], I noticed an issue with initialising frequency
domain information on a recent AMD APU.

Patch 1 refactors the test to ignore firmware provided frequency
domain into a separate function.

Patch 2 adds said APU (Family: 0x17, Model: 0x60, Stepping: 0x01) to
the list of CPUs for which the PSD override is ignored. I am not quite
happy with having to special case a particular CPU but also couldn't
find any documentation to help identify the CPUs that don't need the
override.

Patch 3 and 4 are somewhat independent and a first step towards
improving the situation with regards to the use of raw identifiers for
AMD processors throughout the kernel.

All feedback welcome.

Thanks,
Punit

[0] https://lore.kernel.org/linux-acpi/20201112182614.10700-1-ggherdovich@suse.cz/

Punit Agrawal (4):
  cpufreq: acpi-cpufreq: Re-factor overriding ACPI PSD
  cpufreq: acpi-cpufreq: Add processor to the ignore PSD override list
  x86/cpu: amd: Define processor families
  cpufreq: acpi-cpufreq: Use identifiers for AMD processor family

 arch/x86/include/asm/amd-family.h    | 18 ++++++++++++++++++
 arch/x86/include/asm/cpu_device_id.h |  2 ++
 drivers/cpufreq/acpi-cpufreq.c       | 24 +++++++++++++++++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/amd-family.h

-- 
2.29.2

