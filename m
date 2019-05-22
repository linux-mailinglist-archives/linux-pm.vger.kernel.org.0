Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D226A03
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfEVSqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 14:46:14 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:34526 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfEVSqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 14:46:14 -0400
Received: by mail-pl1-f172.google.com with SMTP id w7so1494692plz.1;
        Wed, 22 May 2019 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O1znsyun5k31ul6fBEA+RjUaCYqXoow7Mzb/sgD9eYc=;
        b=Liwk7BDgA5Iglig6m0mb2LfwL1u9OLghbwyUFckRqJTDaFmasEbzSl1/ciR+AbzTm0
         ekVpm8d21vO8e9PNvVZ6KCUQ+qMtgbY0SttsF0sYxTTxJ5QK6IRMu+WoNrpbNArSwDbV
         Yp8fpLVOnc9+krxB4I8QejUSkpVJJxnZamugXSuoAUG8s0QtQUJScuHjijL4QgZBj5Pk
         M8En9fwXCb02IwCj6yBdPmRJrnaa6qkNBhNOY75uG+TGUQ76zHcMd4A5BzOP5UCIW58s
         otrXv11sAvf7Iqh+EZ/CwbywmCJSv3mU4aIUzS9ktCffEo9PTRCpdcMQkFQRDFu+OWos
         I0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O1znsyun5k31ul6fBEA+RjUaCYqXoow7Mzb/sgD9eYc=;
        b=bG6qxARqByqo6sDw3ZISrA40OgjdrtltEdlJhLYuqtXFRKSkAgKSHvqoxnJI8nKmpw
         ZvUW2E4Tc0P65v9YfHVN2q1Db57A7MYM7hTnG/98yYgWaHHWQYo1TRUwXm3M7bnrJeEv
         3c9GbdMtkfLq3Is0l1/aApj2jIjIpDBtVWKk1iYF+W+o0e1jg0NPl2svJs//2c43bYcC
         Z0POdWJF+jjjuUFNvqHqm3z2WbXDBnlQinKw+g0ulhnxk1jYdTeOyQLoSbPlb6n54tO9
         plcB97dcFAPDmLF/ib2EOqwv1n5Q4gLi4f3W/f0FS8NIsk4qLln+Q9cCxIbD00fKJ5gO
         PERA==
X-Gm-Message-State: APjAAAWL+XTReea8qWOLWKIzjoM7aBcT+d4CpeEJ8Acx/S5xvsDh0FI9
        70uSN845Y7V6VjTuAYiipTIfxqjX
X-Google-Smtp-Source: APXvYqw6heevUJ2swRbGZS0xxVKiZnMhXMs1Af4Hhp37/UeOa9UZrmjlJpFoBifUUSwMZqySNo9opA==
X-Received: by 2002:a17:902:b581:: with SMTP id a1mr90420442pls.206.1558550773318;
        Wed, 22 May 2019 11:46:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 25sm2439585pfp.76.2019.05.22.11.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:46:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS
        CPUFREQ DRIVER), "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS CPUFREQ DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 0/2] cpufreq: brcmstb-avs-cpufreq: Couple fixes
Date:   Wed, 22 May 2019 11:45:45 -0700
Message-Id: <20190522184547.31791-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael, Viresh,

These patch series contains two minor fixes for the brcmstb-avs-cpufreq
driver.

Florian Fainelli (2):
  cpufreq: brcmstb-avs-cpufreq: Fix initial command check
  cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency

 drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

