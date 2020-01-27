Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2414ACD3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 00:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgA0XzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 18:55:16 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48769 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgA0XzP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 18:55:15 -0500
Received: by mail-pf1-f202.google.com with SMTP id u13so7464086pfl.15
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2020 15:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQAaJOF70jpkpbgo3OKWXwDeISOpcrqAl/nKJxxpz8I=;
        b=rNFOFNSB6Pg92/nVyITfWgqaiTYud0bMb33xDqixTNQOq/2QFKGJTspVwiGjqiEHol
         pXrIgNPQkcZ7yhcGyUNMxOYTDeyNi4nk5v0DLZVGW7f35WCj4CpYY0BV+QiCJ7/LjfTK
         wR/VvA3wAETdLgOYcFLndJ4cWSttfI7XnOE6Hude8Dtm6Flirqve4TknqZl+mMgPzuwT
         1yJCA6VDlssrOkxal2JQTghrhpXiTXUoqltV/Sw/XeKRv4pVSnzUSrAisz2jLrfFewwj
         xidGeyZfGUpJnurRqT5xDSrGmpDJ9rs3o1HBrNb/E3XWPuPQV72R9bC+ltwtlkjGQabS
         Ms5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQAaJOF70jpkpbgo3OKWXwDeISOpcrqAl/nKJxxpz8I=;
        b=Dz/6h6zioquJ6FH/5zAUGvZRld9p4pJ7NvmD7pJknjO3QedthBvpT+EzycWPcIQOTa
         df2KDamBRT4KslnukUP06XTg7s5fp4YJ+2eijtFIJAEOU6RZl21Y7n5Hdsga2iTuU8Qb
         Q7UErmD6jDaTLI5sfbvoZvLqBi+OvpfeUotrnDDIUqTyoCK2OxwkEar/ZxxG1vqlgzY8
         2cNKNUfFl5na0OcFoHaOPIUW5KaIEBFS9k9tmQnVSFpAswEMXu0jKb/2amIJAN3IECY7
         PDdMV0DETYr1PdcHmm7INNmIze/nMDRPIdDTfUL5zx8fwROGHOofsR7rcWER1spXdjrn
         5+ug==
X-Gm-Message-State: APjAAAUHwqb8we8tB4799kixu1O17y6MiKF4lws3dRerHKq5XKmsuYqQ
        Xi4x5btqu+i3eJ6Z7A6MpgFdn04x7BnAOKGJ2W94Jg==
X-Google-Smtp-Source: APXvYqyPdtbN9DZT8FHWQNBJKmpfTGEpiSZRuvKVXpp6IV7WTXe3QBgDE+xT1lY2W+Mc5+T5G2jPTWwGlbE8hQlH33U92g==
X-Received: by 2002:a63:fa50:: with SMTP id g16mr21686970pgk.202.1580169314974;
 Mon, 27 Jan 2020 15:55:14 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:53:56 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 5/5] power: avs: qcom-cpr: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently CONFIG_QCOM_CPR=y implicitly depends on CONFIG_HAS_IOMEM=y;
consequently, on architectures without IOMEM we get the following build
error:

/usr/bin/ld: drivers/power/avs/qcom-cpr.o: in function `cpr_probe':
drivers/power/avs/qcom-cpr.c:1690: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/power/avs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index b8fe166cd0d9f..cdb4237bfd02e 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -14,7 +14,7 @@ menuconfig POWER_AVS
 
 config QCOM_CPR
 	tristate "QCOM Core Power Reduction (CPR) support"
-	depends on POWER_AVS
+	depends on POWER_AVS && HAS_IOMEM
 	select PM_OPP
 	select REGMAP
 	help
-- 
2.25.0.341.g760bfbb309-goog

