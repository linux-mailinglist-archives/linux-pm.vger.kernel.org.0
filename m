Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F808B1461
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfILS0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 14:26:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37355 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILS0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 14:26:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so6146393pgg.4;
        Thu, 12 Sep 2019 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HxPTM8WSNi70eKHqEf64bKvnoEPXsCHjn1C3hKc2uLw=;
        b=gs63Eq7izGghyEJAd6zWVzgvRopaQU+FsjuSr1wef5IBOgsYROCYKcRaNxEjYPCJYj
         vyBD9qyvNG2MAl1qi5u3HuPNhoJvqTWLaLxLVtAAAYefB23RG8YoG+0GXJ5UvYHvfz/M
         p0fjgREeiUqnINo5Lv487HOSCJP0fiwfFcMiAMxRrSp0jsNO6DGC2t2xgIBtljEkk+kw
         Rjz/pwieK5vE/ZnN4AELnYCt15NrdleuH8XhWg+MxHWMieKX/eyeyLaHr4C87oO3hquV
         Ht4jR3LbKu0326UmTkXGWmAIrRn51LiGEVMeOZYePlXp4NWXaqPCJkBrYimEqKj1A6+j
         fwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HxPTM8WSNi70eKHqEf64bKvnoEPXsCHjn1C3hKc2uLw=;
        b=V7KN9oVs1sekrr4e2kKN1s7vvbWUeRWK6yX4NvvsALPwMQKSbuvGKVqTtZ0KIv1Kag
         wMLC4Z1sA05JgyK2H6hAhysihXx+azUqtCiG53fPRVtVQnk3xq93Q7zTxaZkGa2oWnhR
         IkWcUzS7/zauJhuXKOc9plo74n6I6TmDA+nivYK9sdUjDa8ikLiFQCQa+/S+4lqFOTTX
         mNsDLQgeZly1n2XELui5Nbhc8VDHZFdHh4w+fWHd4pfOZ2iUQWXpZcy/7p9mER6d7f3w
         yBPj5jZQvE3ZKqyUqNBa/R48SOdvnQkq6S0cLysomPqifMP6SL3UY4LfO43W3NeRxU49
         4XlA==
X-Gm-Message-State: APjAAAXbQpMKg5UjE6wfBUT2+JZqJb8zpFjs9lJbjJlmNZAiK4AH3Xqe
        wGFeUcZ2z0Q5D6nxgUgXRkU=
X-Google-Smtp-Source: APXvYqwWjKI9A2HCgA7Wc9rY6FmY+zPVFcKqsXhvF02coC9orcmI3lK1EqYd3UVpp1KleQ1WXYYJSg==
X-Received: by 2002:a62:ce8a:: with SMTP id y132mr11856400pfg.9.1568312763607;
        Thu, 12 Sep 2019 11:26:03 -0700 (PDT)
Received: from localhost.localdomain (61-231-52-128.dynamic-ip.hinet.net. [61.231.52.128])
        by smtp.gmail.com with ESMTPSA id r1sm20747382pgv.70.2019.09.12.11.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 11:26:02 -0700 (PDT)
From:   lecopzer@gmail.com
X-Google-Original-From: lecopzer.chen@mediatek.com
To:     lecopzer@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yj.chiang@mediatek.com, lecopzer.chen@mediatek.com
Subject: [PATCH v2 0/2] test_power: Add CHARGE_COUNTER and CURRENT properties   
Date:   Fri, 13 Sep 2019 02:25:58 +0800
Message-Id: <20190912182600.24211-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds two common properties to test_power driver.
Most power supply drivers has these two properties, so add them to
test framework.


Changes in v2:
	- Seperate CHARGE_COUNTER and CURRENT into 2 patches.
	- Correct CHARGE_COUNTER whicch can be negative.


lecopzer (2):
  test_power: Add CHARGE_COUNTER properties
  test_power: Add CURRENT properties

 drivers/power/supply/test_power.c | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

-- 
2.17.1

