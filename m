Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D47121BDEC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGJTqH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGJTqG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:46:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB027C08C5DC;
        Fri, 10 Jul 2020 12:46:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so7288836ejn.10;
        Fri, 10 Jul 2020 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKe9fcnHaLqYW+TZA6wyu181qJwcaEwZM0FzB6O+GhE=;
        b=pYICjG7JvGOVBOlg0uttBzals1oO3VBvvIUa+CX81xcMwmHVB+h5vkKTM+k4u/kZDZ
         cZCYGu9fXjdAMaT5iAgW2XQtr9zeQOhZEWIeaHcMUNb7YE5iaVqD1J7I8qTq+yTscdzX
         CACrZuWBHqmCdX7OniaHB/WxQ3N6swU+XiYkCHhgiruSz1aKxrMeuHTaVJ0IxmZZqTTB
         anu+5+VlToRu9ltD8b0POmEnzo/+RbkSRjEOZKJ3MvcPZ1eUqzkqSf68FJy/HdCygxTY
         /w5KtRo8kvxohWbTMCakSkYDM9e97/zmME7XRRXSS1OWJBJPwNpSVqIzhdt0cn7iCUoX
         AJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKe9fcnHaLqYW+TZA6wyu181qJwcaEwZM0FzB6O+GhE=;
        b=VdDabsHDjTXrUOOyt51aH9Igc51rDEuQ7UWsU2lry1n/b0VH6OtzKxNAv3qqzPBPJm
         EyKm9tp791czywOPz54PTyfJz6NwB1pv8NfkiwdygfuTjzvcvE8IqYSz4B6rCweautiJ
         C828jL2xZMaAYM0wO15zoP8KGzzxyPee3B2s+jsaaRT3nn0mHLXSyueMDjugPxl9uPZC
         WZztE7LsSINsX9OkmCP7UleN+qnm/A/tWQDotyHrZ1jxf8yz8DjSOxgt/ftrCRs2Yl3z
         DSZaPbUnePg2wa7xbTpizOog+mAuujMha+t7VrGRIaVGqBS4RbzdnrIoVzbKHl8tCKN/
         uuBQ==
X-Gm-Message-State: AOAM532xCUSImMMNGsqjAEqiwpIX1wWJMowq6XocmdoP3UEL7TUn1MPp
        O6QLwv0+Jt+WWBOGLdVooHM7Sgxuw3M=
X-Google-Smtp-Source: ABdhPJy6ba0T34AvK2myKn7iidpLBeh0YnFLWZ69NBa87t2C923SaQUojouWXFrP1r4GsepbVv97xA==
X-Received: by 2002:a17:906:700f:: with SMTP id n15mr52833073ejj.390.1594410364509;
        Fri, 10 Jul 2020 12:46:04 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id kt4sm4155768ejb.48.2020.07.10.12.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:46:03 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add support for ipq8064 tsens
Date:   Fri, 10 Jul 2020 21:45:51 +0200
Message-Id: <20200710194558.26487-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ipq8064 SoCs tsens driver is based on 8960 tsens driver. This patchset expand
the 8960 unused driver with interrupt support and set_trip point.
Ipq8064 needs to registed with a syscon phandle as the tsens regs on
this platform are shared with the gcc controller.

v2:
* Fix dt-bindings problems

Ansuel Smith (6):
  drivers: thermal: tsens: load regmap from phandle for 8960
  drivers: thermal: tsens: add ipq8064 support
  dt-bindings: thermal: tsens: document ipq8064 bindings
  drivers: thermal: tsens: add interrupt support for 9860 driver
  drivers: thermal: tsens: add support for custom set_trip function
  drivers: thermal: tsens: add set_trip support for 8960

 .../bindings/thermal/qcom-tsens.yaml          |  53 +++-
 drivers/thermal/qcom/tsens-8960.c             | 283 +++++++++++++++++-
 drivers/thermal/qcom/tsens.c                  |   7 +
 drivers/thermal/qcom/tsens.h                  |   3 +
 4 files changed, 323 insertions(+), 23 deletions(-)

-- 
2.27.0

