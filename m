Return-Path: <linux-pm+bounces-24127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DFA63756
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF703188E149
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300E1DF963;
	Sun, 16 Mar 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7bRTc3r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BDC2E0;
	Sun, 16 Mar 2025 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742155918; cv=none; b=cSMH1K6f56e0O3h5p6hDAmi6TpAS/4JKGMu3Quo/UgM6UqGArFE+zr8eYH0aj8VmEAPLkUgx+UzS83fe8RQBWAfTXYUgmekOnP3KVwL1LD2qYQJpOdBRs29Ks+Kb26Zm2Xgj1BZJZXWDfEtcvdSX/k+myYQpcPsV7fku0QpIy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742155918; c=relaxed/simple;
	bh=kZXHMRu4zP5iEpivVL8TaHoUqAIAUcgeEn6p+2qCtfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BSGQpr9xP2YgLS5d8W8+qA3ujeNCY6zEJTxooBeuwUvZ3OJpqgFw0nz6DDlrUOsVHTPeEFHrfhIogBluWDfObSwKPtGz9n9KAPwhBaWuXZH2ziAGku/YFTrD/uLzIvhb7ccDXm57xxbhQHFB7HOyNTlUB09mJeYyDFbIowqKDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7bRTc3r; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso6591840a12.2;
        Sun, 16 Mar 2025 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742155915; x=1742760715; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UaSCRpDARPh5PgWTn0PdJWV14xdzaOHwnIlV2JMuNQ=;
        b=i7bRTc3rbQ3SOeJEcGdmib0hgn8Q3398ZLYHDeNGAxrsJpMadCXrFsnjTluCSsL+hN
         qFyaV1O5xAXLKjt9oQCj9v40dfB3VkSb+3+4hxEIiMvJmhcmQ+JwDs0r96ACcL1anXnV
         ufdyC7RpHvzxXGM6rzpaWf+myMP+74io+dX/J/eQ7QVmJxr9qioE9dcQIgbwWtXlWSfA
         LnbEkKRxpRl/27XXVxCgSmduMtZI+RHF8fHg1a7ctyLURVtedg2NxffskNZ9NKBRzz3N
         l9ByAGWB4z28I50MCXXX5EAQgQDhkshQdYuRATo+yB1vSvXKB0vd9v3YmGhOeCsWSmPB
         ZVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742155915; x=1742760715;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UaSCRpDARPh5PgWTn0PdJWV14xdzaOHwnIlV2JMuNQ=;
        b=iaNxxWS5wp0NeTHCVlsjFRv3iaywgbytltvuUbMLX8fd5WHW/Hr5wfJnuKDED+0TS0
         JAmhx6CWsl9gMXPPjGtQX/z/8WhDy4KAc3i7lnwhX5PIbTQ0Eq6aOivivaDZb2uLhLQr
         JXUY3ckl3QKRrtfQmzJ8lI4ze123L5gH0XmqiCc+GJbgnUkoJNrN0Vkxdi3BEI8ssR/j
         zuxlVlq7nWeAzvuucu0IAwBSzZxz/ohyK+vwvKO8FSbJfIkWuIC8RmAAJ7+uX/VggqNM
         K8bSEhyGy0lxkd38HF6pZpo73+KDscoHyl4b9EOd+ScHdk84XWtQyYN361SGhe6goA2D
         WUhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV36QJdM/ASCCniMfukXSnkycc295A7ICZPDRolcLR+fdbH8iu07V4R59/N4M/R8XdACIidg6pP4M/SMJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXIBRCbXLbDJDrLDtWclDQV3m19//hVbI51Tkj4GFIfGBn8Rv
	xrGVPgXlxrFAyGrHlCvGluqsfjESZNHNH78TmnA1XwqnhMlaEbVG
X-Gm-Gg: ASbGncuFvGfDFeDza73CMhq1qDKbR3wSiCj7nvFPzjDpoNQsCgt3LeNeD7hUKah5ass
	VqytJNUZ8NnYclOELJ2JhYGQxuObgwIMRpiEDRworFna1Rb541c+YsdqmZLLwd0eoytf91AeDf2
	vn052IrUX2VG/vno0E/0ZQGqytp3lS040tQUiS46IEickavxtfLwe2kNdNJvFY/meiBm6KYFQmb
	K4fi8IxCmZJMvw3GckPDSIAO8Or1L6h3G7KRfFpBZBLxEXyZv95B8q0Q0xXlrG8V0tQP/xVdhGA
	gsOOXTYi7tRkLKgCNYqKR3pjLUyvhOzNeWQss99qsKnW0RiyUbhau3nLtRiZR+LCCpEvIOO5wdW
	z4vXe9FRjc1wtyRE/4A==
X-Google-Smtp-Source: AGHT+IH40WcmvqXmMZYwJvZmaB8T0MSIe9rbH2slg2ugRfarihrNwMaiLUL8d+0aJ94vprgCoVcTDg==
X-Received: by 2002:a05:6402:1e90:b0:5e6:44d9:57f7 with SMTP id 4fb4d7f45d1cf-5e8a09f77abmr9471727a12.26.1742155914667;
        Sun, 16 Mar 2025 13:11:54 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169b105fsm5059233a12.40.2025.03.16.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 13:11:53 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 21:11:49 +0100
Subject: [PATCH] power: supply: max77693: Fix wrong conversion of charge
 input threshold value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-max77693-charger-input-threshold-fix-v1-1-2b037d0ac722@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIQw12cC/x2NQQqDMBBFryKz7oAmJDG9SulC6mgGbJRJLIJ49
 w4u33/w3wmFhKnAszlB6MeF16zQPRr4pCHPhDwqg2mNa23n8TscIfhoUbXMJMh52yvWJFTSuow
 48YExmsn50FvXe9CrTUjnO/N6X9cf/KrpBHYAAAA=
X-Change-ID: 20250316-max77693-charger-input-threshold-fix-992f56783586
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742155912; l=2068;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=kZXHMRu4zP5iEpivVL8TaHoUqAIAUcgeEn6p+2qCtfk=;
 b=K7HITCJsMpUQKw2T6WNpUERr3ecEeWy/Cz+5Dfw1paNgp+vW/2aARY+wFGjGBFoZhPUkdu2XR
 /wAik14/lbEBt+ydtqp/994qVar+8eLPkNWn97r3xwI+S7WiLoemj+7
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The charge input threshold voltage register on the MAX77693 PMIC accepts
four values: 0x0 for 4.3v, 0x1 for 4.7v, 0x2 for 4.8v and 0x3 for 4.9v.
Due to an oversight, the driver calculated the values for 4.7v and above
starting from 0x0, rather than from 0x1 ([(4700000 - 4700000) / 100000]
gives 0).

Add 1 to the calculation to ensure that 4.7v is converted to a register
value of 0x1 and that the other two voltages are converted correctly as
well.

Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
The charge input threshold voltage register on the MAX77693 PMIC accepts
four values: 0x0 for 4.3v, 0x1 for 4.7v, 0x2 for 4.8v and 0x3 for 4.9v.
Due to an oversight, the driver calculated the values for 4.7v and above
starting from 0x0, rather than from 0x1 ([(4700000 - 4700000) / 100000]
gives 0).

Add 1 to the calculation to ensure that 4.7v is converted to a register
value of 0x1 and that the other two voltages are converted correctly as
well.

Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
---
 drivers/power/supply/max77693_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index cdea35c0d1de1111311d198d042bfa5b10da52b7..027d6a539b65a2fe423f90bab27d705a8145f7e7 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -608,7 +608,7 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 	case 4700000:
 	case 4800000:
 	case 4900000:
-		data = (uvolt - 4700000) / 100000;
+		data = ((uvolt - 4700000) / 100000) + 1;
 		break;
 	default:
 		dev_err(chg->dev, "Wrong value for charge input voltage regulation threshold\n");

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250316-max77693-charger-input-threshold-fix-992f56783586

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


