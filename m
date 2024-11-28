Return-Path: <linux-pm+bounces-18201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B922B9DB55F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 11:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EC4B2153C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D519ABC3;
	Thu, 28 Nov 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkDWXMtE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F929192B94
	for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788488; cv=none; b=ioc4/rvaoDENFIIyHfQUsYZk/vr36k8kyVx/mXG2c9mA6y1IjmYPYPl/K25tPtLYlUMzX0x4KyIhhsV/sX7EZTFzKLel3psEFP7dya1FiZNEe9DGGW+eC5npx0qVHUdC9PVvDowd1CHcGy09IiPYNSvz4zM47O1mIq81gnF1Pec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788488; c=relaxed/simple;
	bh=8skcluPb5KySGbl1QWIwfG/p2EUmL9ffmC8AK029src=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lddYWgkdim0i3K7/PULCrxiATKZwPkJxF0EGkWoirokq0WaFc5B/EFY0os26pi4gXEqcc88u/sp/IbLXARugv+tQyDk4lJ8Y/E6a/DcR55Cd7uNPk9tct952ZfBo7pDHnov/FJx3ZrvTZ51LC98XkjhR4Ymbd0/zkbKIRs6CcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkDWXMtE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3825a721ae5so396837f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732788484; x=1733393284; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ng5DukXBHLhyQt4qj69S1LcwJvUdoL890VdhX9vWftk=;
        b=NkDWXMtEiEgkdf2nyciQK+m929XqkDiGznG4NGaDR0d0lXIYdFrSAu5MRnKpJE13tC
         mgeRc2IQtYfZoTg69wx/rXysL0mgd7IRNYJXKOPq0/4Tp0AZrIXrshg+Wjaa2l8vxtpQ
         U5AAYFgCiHdBk2XyPJN+M7hyg3unBiHbmymq0cYoUn/IxmxUty7s5qvuSrTuKjh7EyNl
         +phzP61SUbrXVMrwycmaMsdPoPxGsRg6c2gC8ljJHkx0p6izNXByFy+NMcwn/TNN/qAU
         gVQe0xEuVhRF4ad6by/kCbHNp3bJHu/0wF++bAl6wEuVyOCsUB0bhc1qxmD55+/VtyKm
         EE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788484; x=1733393284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng5DukXBHLhyQt4qj69S1LcwJvUdoL890VdhX9vWftk=;
        b=rfG97HQqQcq49T16OrYer44jqGGWUOtDZC3YPXThMO+0EUNApk1D6lKyhSXDQvyBq4
         rJJcXt4DU7uUYMKHkpwvanxUHGmoKzFDHFOqxAF3E61WMETOhVLzLgBcPrTNjTCDOBaf
         /iEatnVRJbEgrpQu26VLF1XHAlexuSX7OQemTpaIOZ3B+PIW77cnCxFTJjRGJlSAdNdp
         q9UnIiBH5eEMbkxNJNkDGFWy1RqT9wzRmt6HJhVhhrtb7a1yi1AzrmjXI6KMgVbhHZOR
         w5NgQlH16WoYBCCu+Vf4P/jDIr8+ebM6eG18X4rRR9JcV9CHoD/x7TiV94HfppSP3a7z
         vpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2sOVsc/HBzUukGloCZMR5ToVoc9Hwf4aTfvh8BoCd1bYBLC9+HgB5rVjd3EJ5gkyVrh+uEJTXaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsBcGj57Z2ilE9/KH+iiQmyc+tHfN9DF6ZNhqgcNvIrWz0jIS
	elJGh4zcYDNnHvRjtS6e0l5Jfl8gjRstOUGp2a9ibVlyRammgymu2zAj2Mutt8o=
X-Gm-Gg: ASbGncs4A8RCTOM9AqGnm9McfnfvC75CYGICRr5+qaAh2EaaItSJScXVLNyiyilVf1R
	pEmcr/dYE2bFS+sgLpnPaug0T2Ffs2DVMQwlO3rJg5Mi6BWcJnfkYKRLHHKBQpmDqXbI0x3QZG7
	qppUomATWXHQq/zMw4HYQ4AQYAfidANjP+12P0AoSOkJGApiKxWYn4SBFtYDfPR+nR4afiMrn3s
	W4rKlsi8qAwlQXicmmojmgHQTclUw9kDvMuSqR4IucTRWa3h2g5K70gn2s/R+s6/NBy8rc=
X-Google-Smtp-Source: AGHT+IFKf4bquwdhlK5RF968lsp14oLZ3x72nv57uo5+eQdppr+kvS8nrDbYelTP65RSzlcf0ARkng==
X-Received: by 2002:a05:6000:156b:b0:382:4a94:af0a with SMTP id ffacd0b85a97d-385cbd80afamr1624339f8f.20.1732788484536;
        Thu, 28 Nov 2024 02:08:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a56fsm1230335f8f.62.2024.11.28.02.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:08:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] OPP: fix buffer overflow in indexed freq and bandwidth
 reads
Date: Thu, 28 Nov 2024 11:07:53 +0100
Message-Id: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlASGcC/x2NSwqEMBAFryK9ngYTv3iVYRax7WgjJCGRQRDvb
 uOy4NWrCwpn4QJTdUHmvxSJQcF8KqDNhZVRFmWwtW2NsSMeMQlhTAm9nOiK+gdKWPhE2ph29G3
 vuaOGhtmB3qTMunwT3999P6bbqBZyAAAA
X-Change-ID: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8skcluPb5KySGbl1QWIwfG/p2EUmL9ffmC8AK029src=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSEECgem8wGWvZixDER6uQxG0aoieHbOCD2lak4Ku
 4W8PvaSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0hBAgAKCRB33NvayMhJ0d7IEA
 CM5+s+4EId7Zw8Ltfzi3AtYBAj0B0f5Sulbl77DwW+tCeIAKgBJb085B1kLM9wmGHqMq7t8w1h2zLi
 /TxHWmZ092rTpCpgMuXwxuFExhpSP8zhOQWGHS2SYtBevFxMvapQfGCDxyCarVjmK7hxs8+QXJQvJ1
 xen+UBbzNMkP1KNFeS0FBZ8XDB8xZMULtwmOf5kuFBNbavVc6+64NbCJWPXI/vsJi9RghDoocb7JgW
 vCXiEBjM1Y0adPsLsr8oPJwNr8zp3cq8VX1CETunnxbGN5twd3gBs2GB9pXUYSuttiEemnZUsH8PrJ
 FsGKrWzAshiiSNTElkaf2vkG8v6CWiMhBR4aozEtO1m5LuSRz9p76FPaTQNcr69AtJHztuCngvJLHK
 tAMNa2s1g2NXYxWP7kb41qNZHpsyFrCHoE/n235CFNIr4wxrlxHqcRM3Qy3bDB1SlNexOWbTe9MOAf
 Qoa03iozVAym5uweW4SYrVix06ZOoCxBqYdggEZCBQi/yDpMQE2DRBBncY2v3Xuirr/fqGlVzBGq5Z
 T2GedGzAx++0oh9xsh+/FlP4ziAWvaU42I1JOUTWycr5OHH734W/e4MTqdxorltrImo++/aqb+s5xk
 k8w8qIHvv7FfrWeJ7BpRee3HMPBc6H9kk8R5GILhd9t4yRXtu89dEVMFNzJQ==
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
Neil Armstrong (2):
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized

 drivers/opp/core.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)
---
base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
change-id: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


