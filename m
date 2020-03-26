Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B064193D5B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 11:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCZK4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 06:56:37 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:40924 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCZK4h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 06:56:37 -0400
Received: by mail-lf1-f42.google.com with SMTP id j17so4397497lfe.7
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47qXZzwAbKRjmlZIR98ky/JOV75sfZwm8sWlwjShF8c=;
        b=EGCqvfJE6vR1DAd9s5QD9Lz37cQED2VqxH8++YisKkjfp+p7F8m2Y71LDftQBpb/2n
         i5VgyFZ9WS8uu99Tqbsk26tLxx8VfPW2OQl5zqQ8Y7AtEKez9H72KpmrpqdZ9HDTCCX4
         /7w+vI3ihA0ONx8vYXi6P9G41+zT2cquEvOCqPZhp1QKQcGeoXiYyDVE/vplychWsqje
         P79LblH0YEbwBPDoDKyXQd6hF8RY5vEk5YhEJ1efuYiLPVx4yd+X/chm+hWLcGnZ0BWN
         iVID2OyJ58JpmCSQjz4O+fKvPfnXg4za+xEf7Upx9Cx5aS+GNZRwLpNMFjJP14qQc5yU
         HIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47qXZzwAbKRjmlZIR98ky/JOV75sfZwm8sWlwjShF8c=;
        b=gXIMjC1NE4n4f/tWq0UFLFT9I5RrNomsLl+vOhUc821hh70444Or1bbNVZbkaRqxEC
         cGf8KAf88AvJBGxlUdBbY3GuuXjG7uAQWGho5aovn10FwvdhjHNGFqq1AHL1hCe4dUGO
         0JjCBOrUQUMdpHogZ48E3ZBvJvvAdQppiKRq15YAAyjHQetre9JY678fzsH9OhAeHKZM
         Y/YTgyCGSYFn0k3p0aMbOBvtgsFlKmZ9KbceXYnPtLis9RL6D3EmLNJYimv5UqRV8wTm
         ODn+SzMXgW+T2FImgNKIBMaIqlhGj2/96wd98QSZkUihb0ZzRWBaznKgHchBAh3VD4/J
         /rbg==
X-Gm-Message-State: ANhLgQ3KlR1Ss9LvuENRqgChGjNzz/bzNw0Wdxy5g2ufFQCQvFjq8ATr
        +GU4bNKj0XDc/VMTLoXDvy+S+g==
X-Google-Smtp-Source: ADFU+vvS1OdyK1KZuc0v+FzxWV0LS3mwrT/slQOOveM59Ax919FAfDjO8Iw+zFw0NGknj1fhGBUQFg==
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr5441924lfa.0.1585220194880;
        Thu, 26 Mar 2020 03:56:34 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z17sm1214653ljm.19.2020.03.26.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:56:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/2] dt-bindings: A few updates to PSCI and power-domain bindings
Date:   Thu, 26 Mar 2020 11:56:24 +0100
Message-Id: <20200326105626.6369-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Recent updates to the PSCI and the power-domain DT bindings, deserves some
additional improvements on top. This series takes care of this.

Ulf Hansson (2):
  dt-bindings: arm: Add some constraints for PSCI nodes
  dt-bindings: power: Fix example for power-domain

 .../devicetree/bindings/arm/psci.yaml         |  5 ++++
 .../bindings/power/power-domain.yaml          | 28 +++++++++----------
 2 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.20.1

