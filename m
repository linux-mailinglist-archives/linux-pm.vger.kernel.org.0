Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624CB2F5429
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbhAMUdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 15:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbhAMUdb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 15:33:31 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26809C061575;
        Wed, 13 Jan 2021 12:32:51 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id n11so4057463lji.5;
        Wed, 13 Jan 2021 12:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqjsfwfE/gvfFJAIpBWNUl53/ddqk06jCLH+ewEiwcs=;
        b=gXx3rZ4rZ9M8XkujqpimI5YAbVr3nV7IggEqrzbAChPFU3TYq+z4iQvQqM0Sy/khkB
         mskOtzoPm/1262+nSLNjKbHnOuKNpGO3g67PkNu1z9HwNVbwsI1GD7TuFuXnET5cR1rW
         PmM6RRsGdfLlPuoBI7vBHtel9HgWHkq/5D8CXnha59x6IbepDql/0YL6SU9Y+/4Z5ZlZ
         /W5aUuyxG3xb/j96ptdNqjzHqgJGA7CxI0jt2mg2Dq5ycJQp2SrNetVbUPf7Au9WcoVi
         Y9Y3o4AiexXnKvXacKePazr1wfsEZ88ogmIPDYSLdDJNM5lVvCWWYwhotU7q3AmOL8q2
         Qimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqjsfwfE/gvfFJAIpBWNUl53/ddqk06jCLH+ewEiwcs=;
        b=PZjNa0wedXsq1wBQphJNeNt+mLHu5sZAkbwoSPCqX7XWwzSyi0xqfUaUNUDJpEi8vN
         jYRwpo+fDhkt0QAyO2YulcHIAfgM9yWZfNQA1wd0xXt5s2k2Vt1QBPxZjSd3b8gy2jLn
         dIPmsVyUwSREBkgfBs6/BEnAD74Wbx+27O6eK7DtGL0mbMj4w3mzqs7XWV0A9XuFHKlo
         z8DhdymnIgEp5gxGOTEUT7bQt8aJG1rwl9da7dMND/vl9M/LRpVcOfTs28hnXeochLrx
         e0ifh7LYIC7I1c898nCOpMOdI/CvmOk2vPu2rPcidhe/u0ch1132UJo96ujJe45pYUcZ
         xOiw==
X-Gm-Message-State: AOAM531ESnBQFLz/6tBN7RoA2h9y3HonCYd5RirPAarUq1XeGW1pKVHt
        C/cyHlZ1ST5/yY0aWiwbinw=
X-Google-Smtp-Source: ABdhPJxVhQM8Vpc83GcI6cMEor4XaFDEvOAI4PCe10tE8mbegBY5PAG/I6cSINKQULYhJ+fQTZtZIg==
X-Received: by 2002:a2e:5753:: with SMTP id r19mr1578532ljd.240.1610569969676;
        Wed, 13 Jan 2021 12:32:49 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id w202sm311194lff.182.2021.01.13.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:32:48 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/2] power: supply: Constify static struct attribute_group
Date:   Wed, 13 Jan 2021 21:32:41 +0100
Message-Id: <20210113203243.20146-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify two static struct attribute_group. The only place they are
used is to put their address in an array of pointers to const struct
attribute_group. With these patches applied, all static attribute_group
structs in drivers/power are const.

Rikard Falkeborn (2):
  power: supply: ltc4162-l: Constify static struct attribute_group
  power: supply: core: Constify static struct attribute_group

 drivers/power/supply/ltc4162-l-charger.c  | 2 +-
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.30.0

