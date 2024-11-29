Return-Path: <linux-pm+bounces-18242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FA9DE90F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C54B2232F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BEF13C3D5;
	Fri, 29 Nov 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajyuvY0U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF38615A
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892792; cv=none; b=mzduy0zsY8wfxH1hst9PqmKqGBK599SE/deDoSL45cvxHLrugUgZwU3QmyY5arQ6PX6UU5yKgXfVshcg3owgNxROjFJ/YeCeIdXfd1F7WUUCQhtnH634r3eCGCbvpNBLSa5kFj/PAnTm5WI8kFtp1DIrhz327IWKCD2sA4vT1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892792; c=relaxed/simple;
	bh=XeH9Dl+YiczJX25jJqLBZYxPVx8bYkmdZiQIlzdgKrM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AujaG1KOtRkaQYoo2/FPY0+MozPhh4xhNZUAIVeAdIdOzU2vnAcrOJEr1fdHo/8fNQqsGrDCy3cn/JA8datuS3+/SvVmwR6sxWcQbPhXynDfHPCFW9kxzVDRpbjOYk+i1Xdn3tRRK7NfSJfVUsn7saB9I3qhIsTMDZnmmvbTOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajyuvY0U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43497839b80so12691285e9.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732892788; x=1733497588; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SW7ouWuacudV5o43kEnwoBxTWELD8f4S71gR6NG7OtE=;
        b=ajyuvY0UrVk0gld+7pOOT0Yn6Rep+pKBjexlJq6eA+7wXqSIEMiOxNal2E8lWUK3pe
         f755Qz46F01RcqwmJQSIcBjTR7YEdoqLEW2T48IaGXDci/YR4G27VfCZjqsjn0weZXId
         O9hHbAxGn3qAEFWKE+iG3Hqa6v3LT0R11i5YVJjLIrV3JgjTX5fxkaiWVn/GSwoOKX4q
         EYS0465UZNJ3PNNJR0qe/GrP+0WksajZeRsh8ZfRsLLcgWfeOa2Ogf8tuwEyJgwdHGiX
         +DmVrC1hwyMP/HNcuWXNO+s7jjirGMcA2kYFJAL1ecxXUj5jNJ5FSFawKQXs1XYp+Jf/
         v2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892788; x=1733497588;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SW7ouWuacudV5o43kEnwoBxTWELD8f4S71gR6NG7OtE=;
        b=HkEk0h1aCB82frv57/824Yo6fFdhZ8iAxT6p8r+R7f0F+zcYgqZ0ZsPL6SyyHlHN18
         5kJ7WAzqWqbns8kWgHGKwOAFgkWVAImu6wXgSQcCOcTcY1aL3cZkiHhPo8vd81LPhXGg
         kXmSirKL4Fl50ZZND0M50UZq+8A+UhXCfIko2Gi9aFPQcAldCbAgqu1MvqJ44zta7/b4
         /qN+olHiN75rQik65Up3T6UyPlZcvYuSJvnxY19cn3FW9x4+N0chZjrW+Zotu5RLPuIV
         x+Q6j+MktXA6osozT7QvC9ofz1koILW6tVLb94imgJJTQUZl52NlkNaNKO8cS9gWgEVJ
         h79Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMGULRpAaxX0PJggU06BKA3YpOpLqDyn76bqxvdqr/3VistQJL5qe8bzQNq7kGwC+mzos0rWzTuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9hMx/oNHc+xNGGCiaMNLSXv3aGUN6mZ/8W6Qo79IYUtOYiJq
	uhZ/CiJi7l4Mkhi0G4bJIIyUUxpnueSpxLTgZv4f6c+D1g94PVy5jSjcuLzr0N4=
X-Gm-Gg: ASbGncvTy6LH4kO3lTb0kKTe7g+ly8VfLp/O9VT8fSQlu7pawDAW5iSbkpq/Nog5fDE
	c0CZWWnVbnxBVK0MPl+arxZ74Z856jvnehlaI1jKEisY5sQyO9/vvUw5lE2QgttR+g0QAILui1I
	6ivxZ0GnA1U/SMco4imsDOOHMO/67IbqLgqIsJnqN4XKV9gMe4y0OrmJybKs/RPVRm18B5UlsHH
	Ls2AHoEnyMwQFkyhu/jK+4+IlfEi/xv9u2s0Lh2KWi7RZR2kenR4U8Q1EfALFzf5MCjFEg=
X-Google-Smtp-Source: AGHT+IHLjwIcv19sps5Qxo/HDt9wbsQEsQJL0RzO1vyhx08KeD8FgDJzvUXEhCehlv6YYvGHYH4BPA==
X-Received: by 2002:a05:600c:3b25:b0:434:a830:936a with SMTP id 5b1f17b1804b1-434a9de78ddmr100216745e9.21.1732892788021;
        Fri, 29 Nov 2024 07:06:28 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2df65sm4759637f8f.6.2024.11.29.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:06:27 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] OPP: fix buffer overflow in indexed freq and
 bandwidth reads
Date: Fri, 29 Nov 2024 16:06:23 +0100
Message-Id: <20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/YSWcC/5WNQQqDMBBFryKz7pQk2ipdeY/iIo6jDi1JSEQs4
 t2beoMu3+f/93dIHIUTPIodIq+SxLsM5lIAzdZNjDJkBqNMpbVpcPFBCH0IOMqGNuX9guIG3pB
 mpheO1X3kG5VU9xayJkTOzfPi2WWeJS0+fs7HVf/SP+SrRoXUN/1QkSprxe1bnI3+6uME3XEcX
 9S965XRAAAA
X-Change-ID: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XeH9Dl+YiczJX25jJqLBZYxPVx8bYkmdZiQIlzdgKrM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSdhxeGDlCndTNOaNWOE08mkDd/7N8IVvqio4QQk+
 IANIaXGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0nYcQAKCRB33NvayMhJ0cUiD/
 wPlothfof4th5zH/BlmmViFxxS+fwNqOBHk6+gW0mWTQLjEjdq0paGDVxBoGq7/b510EICwkrML4i7
 hquC4fwp+Ya5VUG5jDCU1h5Hb6LO6oigOYbPIea2s/xGnNAoBnD/yotf3PkKNH+pCFa89lJQQXQAUC
 t9908ELwSCpJ5+1J+Ifr8Sv7hmQmTni02VJEVOVm6hXYsbb870F7e2XuSMCnzTrwb/N+cRHSSnXRdV
 Ic/dXb3HaMJ1pySrKXjkLMSUopAyvW6EvVFttxr8K6zEp4wCBVaWDJKGyOGfAQpMuCx9OdqgiXBv7w
 i/cfvNK8S3P2JfjhvwBBeLM+C2FcyaSqJXlbRgnfxTLfnRcMyXipKwN08jZ+ZSaxE9ZQQdAao3usR0
 drjBOUx+zW643HCIVE4EOpr24q0PykZDwy2RFN/uMsYvoGEUCCrSFH8BUEb220r30bapmdfLg19QzZ
 l2UMMfvWFwc5Zz30az/6NQ+C4+VzB7dkmadD2epFQQsXnEWAoxVTA1y/1Q/aCKbV3ue5TRVyCmdhcf
 R5vlmrXL8DXZzvceGNjqYprRaDzy0UkhjmLapurw5rNvcBCO6AsPJH6Q3r7jLUZXHxtmVaq9okc3nK
 BHuC3BnUieUwy+8g1uaXqKhKF+RXyISySXmCmL2qAGsW7qyoXzQ/evZPKH+A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

While fixing a crash when calling dev_pm_opp_find_bw_ceil()
because the bandwdith table wasn't initialized, it happens
the index is not checked aswell for indexed freq finds.

In order to properly fix that, pass the index to the assert
function and add a specialized assert function for freq
and bandwidth.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- keep existing check for non indexed find functions
- use assert_clk_index only for indexed find functions
- fixup commit messages
- Link to v1: https://lore.kernel.org/r/20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org

---
Neil Armstrong (2):
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized

 drivers/opp/core.c | 54 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 17 deletions(-)
---
base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
change-id: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


