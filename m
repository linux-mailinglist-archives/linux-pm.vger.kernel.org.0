Return-Path: <linux-pm+bounces-27195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44718AB8621
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 14:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98483A19B6
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5129ACE9;
	Thu, 15 May 2025 12:13:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79C2989BD;
	Thu, 15 May 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311216; cv=none; b=mclvDfPrj1SYfYVNa+h8b/fUDTRFHXsaI0pjjpRbmCZy37A+4ZvhWysTboUm6OjAU4QvuX/31LgtTbih7CacNtzwx/KTye+anX6ZEXguMxIq9n3bJPpqdpAxR7lta74dRr42h3JUREGiyDYTSOzCCVk/8FA6lqVXwzZsTUlpSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311216; c=relaxed/simple;
	bh=t+hvnA43q5tF5CaV8Z7tTuxshUQT1jqzHOzuSu9AQ/I=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=uSS5Xdc0wFYiDhfDVopgdB5+h/5/BArDt+CCH9TT0VgV5YMfDk0aG8jjAGHQwDkXB8tioLwMgkZEj2L+/aoJlwbpGAZN/gnYZfd6IDwKG0F4M9sVQD3iDha0uEBIcd1EVuH33ZYTvEuh4eStU6bonnSThouTCLUh68Cjo7wqaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZypyV2XZMz8R040;
	Thu, 15 May 2025 20:13:22 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZypyK6CTmz4x5rv;
	Thu, 15 May 2025 20:13:13 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 54FCD9L3092672;
	Thu, 15 May 2025 20:13:09 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 15 May 2025 20:13:12 +0800 (CST)
Date: Thu, 15 May 2025 20:13:12 +0800 (CST)
X-Zmail-TransId: 2afb6825da58ffffffff861-9cf81
X-Mailer: Zmail v1.0
Message-ID: <20250515201312562vXizlDSg23_PhQ1nALjYV@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.enpei@zte.com.cn>
To: <vireshk@kernel.org>
Cc: <nm@ti.com>, <sboyd@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBPUFA6IHN3aXRjaCB0byB1c2Uga21lbWR1cF9hcnJheSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 54FCD9L3092672
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6825DA62.000/4ZypyV2XZMz8R040

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Use kmemdup_array() to avoid multiplication and possible overflows.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
---
 drivers/opp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 72fbb6cadc23..d85e3371493f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2087,8 +2087,8 @@ static int _opp_set_supported_hw(struct opp_table *opp_table,
        if (opp_table->supported_hw)
                return 0;

-       opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
-                                       GFP_KERNEL);
+       opp_table->supported_hw = kmemdup_array(versions, count, sizeof(*versions),
+                                               GFP_KERNEL);
        if (!opp_table->supported_hw)
                return -ENOMEM;

-- 
2.25.1

