Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597583ADF4E
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFTQO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 12:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhFTQO6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 12:14:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8615C061756;
        Sun, 20 Jun 2021 09:12:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c11so21572726ljd.6;
        Sun, 20 Jun 2021 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpsZQbazHsnOFFEnzuaE4vlt3ok7dPDDOWme3hF0/CM=;
        b=qi2lSOnwZCvWfrUq5lo+09c+SzOpRYIxPEAVA0Nhaq5Egm39/arbA6MvYsVUj9goXD
         OLm3eDPiy7IBiXuJxy1DixjnCCkWR9bUz01BozbMuAkqarNmAGIQEOkC5wxkOwjr2HG3
         dohiP77s+yWlrLhza2REtQf3JRdt6CwC/qO1m4mm9WrBvqhAN7MVWJ5FXb61z0WOyXTf
         wiDU6O0myyZvriM50gCkxGsk+fY1dLd5E9sqzYXvO8OeVPl3YJuvzR7eMGkCLb5I7r0i
         GB0QmE83B+K1WMoX6X1KL+XOZ3o0bb9uv0w5+jXVRgtoqgp24uMuH68e5Tm6KOXUGzYQ
         cR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpsZQbazHsnOFFEnzuaE4vlt3ok7dPDDOWme3hF0/CM=;
        b=ljCQYWLR61Hft8h9hjQtuw1xKTUuaILQp4p44XDoUAS0sUlt/QcaSqwYow6yjzgGRq
         8+ILklmM+OSXRE3B4sY/CbwNYmgsI71CG9SLj1Xpmn/L+QP43cqTY8lGbpsgC0QhKOqw
         YgO3TGFUkekTOaligRhUQ9yy23aFZxGypToXt+6VVKDQIb4C5kXkiyRswlr9Ni55tQF2
         voFPP48Gq1ckZU63oFIwiVTBOv/g7IRQuw42BgO9VAFH5kaaKqZNhUdHNfB4wMfnR1AK
         oPQSZUFs27frdxcygTGjWz/qbYJn7JlONJC8Tk/Sh+A24S4GnEXZQ93Yrb879WzvuI21
         oadA==
X-Gm-Message-State: AOAM530MzCkq71HLEPzVsG95T4vUedru2S9zsDZTjTRYSgksTMn4QpXZ
        VBKjzGZPZ0nPHfWaIV1WYdM=
X-Google-Smtp-Source: ABdhPJxfi52lQCzdjBncO4OLwVhPUM4D/b/iQSOQVD0fmPx8OE2An095F00ZU/rxluUmQKicBmRLbg==
X-Received: by 2002:a2e:98b:: with SMTP id 133mr17879640ljj.88.1624205562863;
        Sun, 20 Jun 2021 09:12:42 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id a21sm1849419ljj.21.2021.06.20.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 09:12:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 0/2] Support temperature trips by HWMON core and LM90 driver
Date:   Sun, 20 Jun 2021 19:12:21 +0300
Message-Id: <20210620161223.16844-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

It's typical for embedded devices to use LM90-compatible sensor for
monitoring of CPU core and skin temperatures. The sensor is often
used by thermal zone that performs passive cooling and emergency
shutdown on overheat, hence it's more optimal to use interrupt for
a faster notification about temperature changes. Thermal framework
provides set_trips() callback for programming of temperature trips,
let's support it by HWMON.

Dmitry Osipenko (2):
  hwmon: Support set_trips() of thermal device ops
  hwmon: (lm90) Implement set_trips() callback

 drivers/hwmon/hwmon.c | 12 ++++++++++++
 drivers/hwmon/lm90.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/hwmon.h |  9 +++++++++
 3 files changed, 51 insertions(+)

-- 
2.30.2

