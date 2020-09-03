Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1927425C2C7
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgICOfN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgICO0y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 10:26:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D6C06125F
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:21:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id t23so3689858ljc.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYAJCWwmY8cmxpPn4BwEU5jj0ebyOjiSup5bfL+YfQo=;
        b=OX99CF6KkJNmfc3cah9J0jDtURY5SCXnwcy/sD3QgshXNBW9j1zVf/rkRRGYeSbr7t
         JeMRA7cw7JvE/MXBwWS+jgVDTy081C0Gt+hp0ZZhOKOioMXr5D10EwLgyTZpbqGod0pn
         ZkgiDeO+5GKLc0FW3rJjEHeMIul0K6wwhUKfJSHWjBs5hmXzpaHrr20LzrIuLZZzWQrp
         wv/m0e+TMpXoX3za5IYdS6SchZujltYgvCKWzK7bUUqPIc814EyGkfizhaeSABlG/yAV
         TvAKgNhs08iJNjhZRDsKtGEVTURIeeTYBarbcRzhZOkJ76SLyGpX9uoNoGI9p/1PM2XH
         W0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYAJCWwmY8cmxpPn4BwEU5jj0ebyOjiSup5bfL+YfQo=;
        b=N/ADl9+MMCEo9jw2OyYJ7+f1eJn2KLZ8pu/Xc5t+YVTcRE3PxqMRSaxQqoCVktp6nc
         8cw5aAFZj0YKQDUPGox1vcBxCO/8rY1dO1HEhKwueS6k20knGzaJXvpVwhYjh+oPlPOY
         EhKmaRooGCM2L+A3qGQAv6TpGs/9UeyW9fxbTDWGCXK+ucgm62KpAYUH3MHgjSOL6/IU
         ihNCIK1u+A8jMonc9NKh/WlSRTwpw8n1KXxXPD/dWD+8xogzQUt5zQ+Pr92WsFy55y00
         Y+3HkFQYb3ZxuvRbVmis2DDuHdMGkhk6EpEBOZuq7qUL/iiK8i+EXH2E8+otwNu3hspT
         0QhA==
X-Gm-Message-State: AOAM5309CTIr8fHhEYcHTJaczUHVljcgRDfA7IB1YyMeKEea06GFOS9K
        CE1rfi86eG7ySrd5nigimn0pCQ==
X-Google-Smtp-Source: ABdhPJyP5OhNVD/jJ9z1pfq9aQtBj7avCZg/irip+mSpxwrEoQM9Kpl/YIx14MDRVDCA2CSAugQ41w==
X-Received: by 2002:a2e:7e0b:: with SMTP id z11mr1290883ljc.133.1599139276410;
        Thu, 03 Sep 2020 06:21:16 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id e23sm584220lfj.80.2020.09.03.06.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:21:15 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/0] qcom: pm8150: add support for thermal monitoring
Date:   Thu,  3 Sep 2020 16:21:00 +0300
Message-Id: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch serie adds support for thermal monitoring block on Qualcomm's
PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
to support thermal zones provided by this thermal monitoring block.
Unlike the rest of PMIC thermal senses, these thermal zones describe
particular thermistors, which differ between from board to board.

Changes since v1:
 - Introduce fixp_linear_interpolate() by Craig Tatlor
 - Lots of syntax/whitespace changes
 - Cleaned up register definitions per Jonathan's suggestion
 - Implemented most of the suggestions from Bjorn's and Jonathan's
   review


