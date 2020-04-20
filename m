Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC871B0041
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 05:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDTDm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 23:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTDm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 23:42:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789BEC061A0C;
        Sun, 19 Apr 2020 20:42:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so3455902plt.2;
        Sun, 19 Apr 2020 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tgKd8H7qQqlWB9qi0j7uqHyOzYDxeDmlGhaubN4rAYI=;
        b=FJ7c7XTTzkVKtyZ0n+7hn9Pj8AJaj+rAv2kD3dblTIAJ4Q3KiueZDs88OQswmmYxXr
         r2DgID5Sfkz8+pKR/FlnWG6FqFM326B/rZ0mA3XhLjjmtaGEy61LazwFRHppfamSHcXU
         or1Hl6w+hY3DQZkWF6KvwEBnFo8q8kKkprcQCxJHIrVkj092c5Ds0b2amP8yjpdX6Z77
         hXYoK+wkPKXpLhorAPxeTaR//9RX0G3YOyGUFNKfAPmysYtvvY7UmNIQ6zpHvCJ0H8pX
         GDsEBDMS8rD6iVNAXs+hJhekCqkpc8BrDAVCrttPxk4u3T3dauN1XN7r0o8uPu/WQnwD
         XFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tgKd8H7qQqlWB9qi0j7uqHyOzYDxeDmlGhaubN4rAYI=;
        b=dDpkC1uFWdyoVNAHEwcBOxCKYkSTVGFZLUBa6IlIpVblfARC6enfVRrAvtziDjRsFL
         FQVcqaoCCi+QSTRUBlxrWl7dB0w6U3AyKey4WkzctKggR2ARRxiwHi17eiOobiCSFrLJ
         C3BNGhuwuIRISjuRoINu7+VDsBBAYfMuZzxVQfwIaK9RAcDvBAmbTk2DdfTkI3N+DDJR
         A5t0FVwhtt5MCou5WAUp6fMZr3ASCeZdKodJdvUgHePqoJdsTrR0VzZHrP2wFPOlwNzz
         YQFIE7AJavMEJEOumnsjgvZABnpOaF5JnW1NHX9hrKjL1PUBxsKp2LkiFQUNkW4Q4hJ1
         VLuQ==
X-Gm-Message-State: AGi0PuaPtQHZ/Fmc+7YTXO0zw4jHjYRRImAXp27aabP5PCynBxr0YqFx
        F6JwTLcLM/M6llDhPDxYC2LpFJzAMMM=
X-Google-Smtp-Source: APiQypJUN+QYvXWPpusKzyC0XLgrAoC2lI3YYlocPYh8OxA5j0g/N6elSFsiOi5CjjtCrCrFihVCrA==
X-Received: by 2002:a17:90b:19cc:: with SMTP id nm12mr5262270pjb.34.1587354144903;
        Sun, 19 Apr 2020 20:42:24 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id d21sm12467660pjs.3.2020.04.19.20.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 20:42:24 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        yuanjiang.yu@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add some new properties for the SC27XX fuel gauge
Date:   Mon, 20 Apr 2020 11:42:03 +0800
Message-Id: <cover.1587353854.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patch set adds some new properties for the SC27XX fuel gauge,
as well as changing the 'POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN' as
writeable. Thanks.

Yuanjiang Yu (4):
  power: supply: sc27xx: Set 'no_thermal' flag for SC27xx fuel gauge
  power: supply: sc27xx: Allow to change the battery full capacity
  power: supply: sc27xx: Add CURRENT_NOW/VOLTAGE_NOW properties support
  power: supply: sc27xx: Add boot voltage support

 drivers/power/supply/sc27xx_fuel_gauge.c | 77 +++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 3 deletions(-)

-- 
2.17.1

