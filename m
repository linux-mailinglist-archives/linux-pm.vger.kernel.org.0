Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023C719F78D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgDFOGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 10:06:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46999 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFOGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 10:06:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so17543610wru.13;
        Mon, 06 Apr 2020 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9YIfum1MZHtzrWybdf4+BjEwvq9ttgdQIUJwha251ck=;
        b=AKiE2B2wKkN0i8fqOu6kSZb1R26OlKakhbhyl/mSUI6IPhDrkBezuzx7f3l0RHQT1b
         FKsOmRhNeaOBQBEq6cuYoFAURLpQmUvLxcJEhltKMWONlFXm6Iu5+uKKEeoSDFdUtO9V
         LCtoPMrzc1h1T0dqk3DwYo7+BNJxas61ThXjoVHyzXpT+u1VQN/SmsQGOo2DbB3noQqW
         rpSkvfkJ9n6ogPLR8iT72YRiV+F4stv2lveU5QzlmCrSYOs9gye6PyHcer8ohQSqOpah
         SmFV+J7QfghW4DfQUJp/59+6LKiL+djoLPsyGaRx97pCQ4Z2gO8nr3eFGegUbSuKbRIJ
         xpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9YIfum1MZHtzrWybdf4+BjEwvq9ttgdQIUJwha251ck=;
        b=jLkTrJ24hMOpdBKEGQSG1aKxPS+FlPCsKUBZuDcbPiZaIFykON6NHxi3A3UCAJFR7B
         oF2ar34wnrAMZcMh6jqPlB8toqoSNNYsyEKWwQafHFRXGgfxHH7vpG3HKxHE14wubn9/
         68bHmCTo6QpZpJFWDWgpqXTf1HHPzf9o6Z8SQTHywHqug+kvcqVvSW3jPvz0YM3OWJjt
         GJNMq2NqrAxTfqmj+b/3XsbmEjgQDFKFl1mgAMxi8G4ywpDlRBNn08dPqOM5Z/wX1elK
         xQr0PozbpJXQ4zB4/XQ852BWmRz5JtM0ES/N+OVMVvgn0nKbsUTxssQbu0Eu70Bs/bl/
         WgAg==
X-Gm-Message-State: AGi0PuZVfk9B07hqrzl/IkEee3VOrEkpbI7DGUo7QhxlQ0aGWhmmhQ3G
        /PVRC7u9UMMurpQOZeju096n7wHXXYuiuMgn
X-Google-Smtp-Source: APiQypKXXUD8gU2Xbc38Puyr9SJT49feILadnMO9LVLyu76UJ26XuJW5a1OBg8hJXELfnHF/SebM6A==
X-Received: by 2002:a5d:5649:: with SMTP id j9mr2993138wrw.117.1586181980667;
        Mon, 06 Apr 2020 07:06:20 -0700 (PDT)
Received: from localhost.localdomain (2a01cb08076a1700beaec5fffee4f72a.ipv6.abo.wanadoo.fr. [2a01:cb08:76a:1700:beae:c5ff:fee4:f72a])
        by smtp.googlemail.com with ESMTPSA id b82sm12040659wmh.1.2020.04.06.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:06:19 -0700 (PDT)
From:   rafirafi <rafirafi.at@gmail.com>
Cc:     rafirafi.at@gmail.com, Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: axp288_fuel_gauge: Add the Meegopad T02 to the blacklist.
Date:   Mon,  6 Apr 2020 16:05:38 +0200
Message-Id: <20200406140538.11894-1-rafirafi.at@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael Gandolfi <rafirafi.at@gmail.com>

    The Meegopad T02 is a PC in stick format and doesn't have a battery,
    it is reported with a random and constant battery charge but as
    discharging to userspace.

    Add it to the blacklist to avoid the bogus battery status reporting.

Signed-off-by: Rafael Gandolfi <rafirafi.at@gmail.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index e1bc4e6e6f30..0bc548865a61 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -717,6 +717,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
 		},
 	},
+	{
+		/* Meegopad T02 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MEEGOPAD T02"),
+		},
+	},
 	{
 		/* Meegopad T08 */
 		.matches = {
-- 
2.17.1

