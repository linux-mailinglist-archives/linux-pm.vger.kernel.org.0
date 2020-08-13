Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAF24337F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 07:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgHMFLA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 01:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHMFK7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 01:10:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6526C061757
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 22:10:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d4so2200236pjx.5
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPZ6SG/zYPhOh4F1hrC3AfjzUbgPD+IZVvEp6h306j8=;
        b=fEl/Jq/IgbTmIkW1eFw7j5PmpSOA8UBiPp5t3w904WZTHkDJEq/ZZ70kMgDTGl8a0r
         SwlJ3GCcXfKEBKDCanVitTiE3DrwVmGy6PQpol/PJAUKrkGRDX6+8JyqzOZmQJJwH9gG
         YCcys+vF7D+sRiPBBbE619Go7a0cY/tLQYkf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPZ6SG/zYPhOh4F1hrC3AfjzUbgPD+IZVvEp6h306j8=;
        b=Dr1xsy3Pp3Ezf5ixSlxpAp3D+uWRrCJR+mcpVBxb2HcJo6IOrX4/W0vMdWgwcKPHqy
         cmcmwqqJatv3nKu5Uzl+Swq+8mtqelNluM0tM/bG8K12yd7M1PxCO4KaLCmsvSSY6oRn
         9X3Z1HMZPHP5D8IdiecIUxEankk8K2C4rh+aBmcw/S2koFiPFyJnmhTIBoPLVi2EvK/+
         UWhBnUxXlIYVlksyPcbyxJ+mJ2D3O09RSRJwkyUF1nSzhdoTotw+bPeZOsg+hc8Y+l3b
         MXLzkcEhgWpFFx086X/JYIXQ/9VhdjZfHcTA2g+YC0JlOiy39L6co5HoJyIvlzX8PcSC
         e2VQ==
X-Gm-Message-State: AOAM530yQ0+65W/0JoILjcCp825nJyaRVd3c/8qKMeTDuMQ2AdGL/oML
        AbZGoK+1z36D/VZ/6x24facOUg==
X-Google-Smtp-Source: ABdhPJyJ84Z1Cr6z9ApwODz+2nouy9c+f2cgePFP3YjXMx7fv4qXRXtOiQNR2ld5kJT4Ti8CYyBWZA==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr2445834plr.72.1597295459232;
        Wed, 12 Aug 2020 22:10:59 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id fh14sm3720153pjb.38.2020.08.12.22.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 22:10:58 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v3 0/2] power: supply: sbs-battery: fix presence check
Date:   Thu, 13 Aug 2020 13:10:06 +0800
Message-Id: <20200813051008.3461515-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <0200811065307.2094930-1-ikjn@chromium.org>
References: <0200811065307.2094930-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When gpio detection is not supplied, presence state transitions depend
on every smbus transfer result from get_property(). This patch tries to
check battery presence again with well supported command before
state transition.

Changes:
v3: check return value of get_presence_and_health()
v2: combine get_presence_and_health functions to reuse

Ikjoon Jang (2):
  power: supply: sbs-battery: combine get_presence_and_health
  power: supply: sbs-battery: don't assume i2c errors as battery
    disconnect

 drivers/power/supply/sbs-battery.c | 98 ++++++++++++++++--------------
 1 file changed, 53 insertions(+), 45 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog

