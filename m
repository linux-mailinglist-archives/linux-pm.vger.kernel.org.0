Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B542DDF6B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 09:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgLRIMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 03:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732896AbgLRIMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 03:12:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6D2C06138C
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2020 00:11:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q75so1587795wme.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2020 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J4+WRUOVvjgeuDQuczNvQoHzRDmKAjYM9upWC4MOLY0=;
        b=fZ+ogRG5SnnrxPFEAf76aM5POZ6jWaIQcQz0kKvu2hg4JCrWqT0Yxk3f3JuzTYBkYD
         jJ2wVKATeDh4qcpfJrFgnyZan1KLLKtMHgagm1rP4tur1VBblGti6A7ajC/TMYP0lOeR
         robbtuZXqwGqpEGokyVtOg0aX2OAIzfnsKAiLskzNiY8Rvt5HNzc85qq3AN+/6GJOmkw
         pqOePWBQUEPk+hGsZA74cDiTH/4WC9Q+UYs5/y4ydE+ODCv3et3/fo65apG1Gq6gj6h5
         crUn4eRVBH6nK/lYL20Pdi+/PdgPW+WKJVRqOVmbwkjWUmSlp9wFoyEPIsxJfrZ/m2/X
         Vqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J4+WRUOVvjgeuDQuczNvQoHzRDmKAjYM9upWC4MOLY0=;
        b=et0UG44Jrl0D28C4U0zFaOo6d8O6UtNkOMuyc5B2ji9OPTbD3tqnH0gUSDq157TJZl
         hH6TWWb9yYBkkcsPeRQGV6Yqahht71AEyA2QeT9PpoSglLoYHiJogEvCTO82aIQK3EPi
         bf70gmVrEnXBWb2MhSV1qSkpjCJa7E1tWq1moWX10xplSKh7vemfyf5FmrqCrpMr422q
         w+wBBiNykYKpxiJ2L0BuixEJpl3mG29h2Q3T35gZkEBPBr6u+8HFlmya/ORagBCI172J
         CDfm5tcBcezCWVd2a2VjrWJijSlXsa20M/27s8OZL4R5KuvjYtJy+Og7rvjj2zvpUSg+
         SYBw==
X-Gm-Message-State: AOAM5330gFQEqb88nDDIcoeculMZ4cTY0D1CDq3fUSBWmoo/QivGjNeB
        KWu7+qxRq84IvTq/Brk27k8FgwJqL0UbwA==
X-Google-Smtp-Source: ABdhPJxxIvPozHNLtLiLzic9XlUEp5gsTY143T7fnSR74l/1SlnjDojLV3AXs5bkd58D710E7PsaUQ==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr3025085wmc.187.1608279112621;
        Fri, 18 Dec 2020 00:11:52 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ccb6:ce78:2bcd:4ead? ([2a01:e34:ed2f:f020:ccb6:ce78:2bcd:4ead])
        by smtp.googlemail.com with ESMTPSA id u9sm5796202wmb.32.2020.12.18.00.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 00:11:51 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.11 #2
Message-ID: <bdda0e0b-56b7-025b-ad86-f790517c65b8@linaro.org>
Date:   Fri, 18 Dec 2020 09:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

please consider this trivial change which fall into the cracks. It adds
a couple of ids in a array.

The following changes since commit 4401117bf7fc11dc738c0963fa0c94814abc8dcd:

  thermal/drivers/devfreq_cooling: Fix the build when !ENERGY_MODEL
(2020-12-15 17:03:56 +0100)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.11-2-rc1

for you to fetch changes up to 67698880ac9d56367ebf22f8336ccab6234f9feb:

  thermal: int340x: Support Alder Lake (2020-12-17 15:29:30 +0100)

----------------------------------------------------------------
- Add Alder Lake support ACPI ids (Srinivas Pandruvada)

----------------------------------------------------------------
Srinivas Pandruvada (1):
      thermal: int340x: Support Alder Lake

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 2 files changed, 2 insertions(+)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
