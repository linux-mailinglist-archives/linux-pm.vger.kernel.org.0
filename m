Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45711374A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 22:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfLDV4X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 16:56:23 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:57022 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDV4X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 16:56:23 -0500
Received: by mail-pl1-f201.google.com with SMTP id k22so372367pls.23
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=pLFKaWBxg3G91fQPN27XvAEs6sumdPZLqfrYTLin87M=;
        b=HQpsnJV1F1F54ZMj+I2hsZyKO+lpwzLTbCEQDfkrgLSTYB3gmAS+k+2sz1Y1Pc+Aza
         mlwhuCYAhP5z1K1dNLu9bjyHasUdLlKeFLo69o/PGvkRdY33Ww+Mv/lPyrRw1rQyHQ2L
         cCtoZRdp7zGcz8EotAMMvpgUw+p8UAYvYdGGHz3Zof9aGYeJG7EUsJtkiu8x5a6FACrz
         9STLb4KN0CEEiOQ9dkex5iMD+tHgM3Uy2hyYFleQPWmx7vE4OwhswmQUX4qtDkT2yeuR
         IFj4GRdRaZWEoeo0gLagaBVz7GCdkwncP2uCRkJE69t6dR7PSQhHjbDgo3R7CTkjyN+W
         DYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=pLFKaWBxg3G91fQPN27XvAEs6sumdPZLqfrYTLin87M=;
        b=MNuWko0ROWpu72TIvipWlTy671I9XMt/G92AZ3UXqgcSgEK+sz08QrsYwDSb6ppuAH
         oWt7olLdhFELZ/fFqGcU4zenZE98VJQArFfe+IoqrmBXRzblGFam74CzrQGhzFdGo44i
         lf+6UdthQ+SCJfVMcWZONOsFelOKI80waDcS1x6caZqEFzxL8TVakyyw3SncTNXdU6V1
         XdSEgY4mQc8NdCsda8Vte9QxOXA1CVrPxR6ws+SjUPZpBskZ+Ugr0RSPJ7RpQgkp6epu
         qtmMs04L9OSDzGiuNfeGCzC1dhlZweKc44+Mt1yr9w7CaoCmzxc1Y31ip4MvzCKgO/Ze
         bmag==
X-Gm-Message-State: APjAAAXriMAfKSwubpmp00culcy/0onoj8GH5syMQMFDOt4yoJqT7qxE
        hA/Z/EGZNfDGQhFS8k4/HKsCQls=
X-Google-Smtp-Source: APXvYqxVhdDK3bnCACGmbkS3gGGhN+JPPXEpzuCvBE5GWgaY0BrOdygx6lhAUTBfUSazl9ozGRJyc2A=
X-Received: by 2002:a63:5d06:: with SMTP id r6mr5679994pgb.249.1575496582323;
 Wed, 04 Dec 2019 13:56:22 -0800 (PST)
Date:   Wed,  4 Dec 2019 13:56:16 -0800
In-Reply-To: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
Message-Id: <20191204215618.125826-1-wvw@google.com>
Mime-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 0/2] thermal: introduce by-name softlink
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The paths thermal_zone%d and cooling_device%d are not intuitive and the
numbers are subject to change due to device tree change. This usually
leads to tree traversal in userspace code.
The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
cooling_device respectively.

Changes since v1 [1]:
 * Split cooling device registration into a seperate patch

[1]: v1: https://lore.kernel.org/patchwork/patch/1139450/

Wei Wang (2):
  thermal: fix and clean up tz and cdev registration
  thermal: create softlink by name for thermal_zone and cooling_device

 drivers/thermal/thermal_core.c | 37 +++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog

