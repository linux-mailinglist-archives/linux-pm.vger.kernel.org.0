Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EAF33EC20
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 10:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCQJDL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhCQJCy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 05:02:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8422C06174A
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 02:02:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so821330wmi.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ApKtBPoSIWQUrCpVqiKRCFyvDrL2J8ftPogTa611uXo=;
        b=Pofurp6lLuNNVnbzZViJEc4FphgHvqaEx+4UUzNw9uzdRPg4FL79SjMJDjlhNXhtNF
         MZeWgvBeeSfIU7CEQqBfacL+MldhAZoA1uObz4sIoOHVEp8q0/TeuqLhZAqp3H+JL76Q
         uYFUr7N5UMQC0sSopMaAT5IUD7Tojz6eR+duvDcFLUX2C+ozPmBiiNAW82mn1KQR1/gP
         rulgwUfXpM4BIVafGDAMbqNFSs95abHf4eBa85Nhx1KdioBuP3IC+Vmy6zSw9zOTOv+V
         kwIroFvMRdKbvskJhDsHKUzXVrxvKbhKKqoGKQ3gTrCBP228p/bAmVC39vF4lfthHVVz
         7iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ApKtBPoSIWQUrCpVqiKRCFyvDrL2J8ftPogTa611uXo=;
        b=l/D9fgLYJfafkSfcdjmEIezvzgxTAKh41YugA0NVl93nkousAO3HuDx2ATWhGeuAyU
         P3QGcXZOH1nGwBxQti3+284N1S1IcCBBrKsGB1kvK10H9XmpDChnjT0TpFmzyFJKSAtO
         WGL/qyHJqprINrt1NKQ3d6zrZeabn8iAywM4jNTr+NnB4HNek7KIgCojwPG1dAwgTNkC
         bDlUlcMcE1zB8o8RIDPJ0UMsWfPDCdljFCCHeqhkEDhkvUTKR4+yZJe8rPXtbMrI9TD0
         4jY+Cecj9rkk7v795O6On0IC28DOUIZFkQr6bkr8Mdmx2P6GhPAy2V5ZpGqKSczvxZ90
         04Ww==
X-Gm-Message-State: AOAM533e8wvyywtz6mUAWPu6CokALWuIpotconJsbeNQFuGPEdv50Mdc
        ho2m8DUTb7YFdLWiu0Te3o1FrA==
X-Google-Smtp-Source: ABdhPJztarvfabT2tgmwWehxbS8/7jiw8NqwxYGzn/kk4ZlADIA4gwU2EPIGOp2vpsgDeYHqlzOegQ==
X-Received: by 2002:a05:600c:4146:: with SMTP id h6mr2733051wmm.32.1615971772433;
        Wed, 17 Mar 2021 02:02:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4? ([2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4])
        by smtp.googlemail.com with ESMTPSA id u2sm2317811wmm.5.2021.03.17.02.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 02:02:52 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v5.12
Message-ID: <64ffeeef-45de-6e0d-0ce9-767024d8dd22@linaro.org>
Date:   Wed, 17 Mar 2021 10:02:51 +0100
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

please consider pulling this single fix for the thermal framework.

Thanks

  -- Daniel


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.12-rc4

for you to fetch changes up to 2046a24ae121cd107929655a6aaf3b8c5beea01f:

  thermal/core: Add NULL pointer check before using cooling device stats
(2021-03-17 09:55:58 +0100)

----------------------------------------------------------------
- Fix NULL pointer access when the cooling device transition stats
  table failed to allocate due to a big number of states (Manaf
  Meethalavalappu Pallikunhi).

----------------------------------------------------------------
Manaf Meethalavalappu Pallikunhi (1):
      thermal/core: Add NULL pointer check before using cooling device stats

 drivers/thermal/thermal_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
