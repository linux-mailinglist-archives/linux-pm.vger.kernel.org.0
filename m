Return-Path: <linux-pm+bounces-21554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9554A2C93C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1931662AE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D21624DA;
	Fri,  7 Feb 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfROce6b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6842E40B;
	Fri,  7 Feb 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946885; cv=none; b=rNrHqQkHYT78dlJmAeGhMlj1w20hBhTlA1g4stSBatPmRxiL69YCtWCwZkbgz7+Qobc80h47N9PBxaVMz/7zJgRLu6n5itNC3yRZYvacpAJ2wQ3AfP7wLdErTmIx5wFDLQKN5zI+sWCsODaLiFZdZS8YwaB8aIUnSxgHMPpl3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946885; c=relaxed/simple;
	bh=/zF2LhwagKWXf+jGYAxOXKMLCv7q9b93kla4OYElc8I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWdr2dh3NQ8zyYaBsoU6Z2Nrg8PFKMlUUOY2FcbZxc6+J4bGdloJMYX4EEl81emTCcKkM8uGn69MxafvkTbJCp25hfh2tfV4bjo9xUOZ3vWuy7JGWD2rPAqrjVpON8ZOWYzcQDtwlCSCuhfeLl6Wsb/mI1UQuTkPHqgYzwVvlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfROce6b; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so171398085a.0;
        Fri, 07 Feb 2025 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738946881; x=1739551681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLvPkZKAPsSMnxafsZaEnvYemBph/BJy+bYFdl2FKPc=;
        b=dfROce6b+NBrMPPQRjmXcUN2Tv04JApjB/CBl/q5ZrI1rP+rzwCDzWXBJsZBmsrrBo
         cx/+JiXgIs1Q9mp1oUrkopYyIjFFj6GNtrZ+hj45UyHxLcaGspzyvgbV+dVzI+eAp9r1
         4T4j1zNiUU129gEEk8MnOlC5Bzrje4HgVYks5hs/JVOiZ8r1Q7LANkT0ncONruu2bkwe
         MkrP2eXVg5S0PfjdNZkqVq7OtUlTpp2x7Go0KaIIiPXce1iLNHAcwp9nhU+kWVCJCdne
         n6wvhw3uWVyRlipPLlyDN6VGvmfVfKFuf47HupI1T9fgpiEHx3YoqxXkYbOG/TB3dLsJ
         eP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738946881; x=1739551681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLvPkZKAPsSMnxafsZaEnvYemBph/BJy+bYFdl2FKPc=;
        b=ljG4cPFiRoduWiwxYckxDzgmZtip2+tijXG56brG03zDjYbFAbM6IazxcKZCqTFt7P
         CeH0P32BRJ/yXSdKh+rYBIUe+tH8LIdsXzLPS4g4599XoFHtcg6D36t03rgiErRtVPor
         IUSmq5PcVlmOMDJNT5ZC/6MeeMAq+lf0TOiaDRkqPlUEvzsiuJpGmfmNq+ljEbXpis8L
         k/pf14Q4RXY5QNQox42XD6NnoJIWen3/juOm7ZFCnC3t0dPxCphRAIj/63JzB//p65vl
         2Jk2CJO6WrPyzZmmb+IqAED59DBTMQaPZmrJYZL+wNC0PT+mMIupVHmzKBfP4RWT4L0P
         650Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVpOZPJg+pGCahh5dVkzDgBJoCQDyW9qttts6/N8ZTuB38P099lOpMXLtmzOs+dFI/4zt1z/L7xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywvDWGTBqywcQZsJ+GHLf0ZLMbiF8gvFW27kLaOn1ZRBDWGqGf
	blGsT3uP3eQ4aHRD3IRwFsyxDKIgwWLz0AO7d1zzJTFa+rkqThkeMJW6rL3l
X-Gm-Gg: ASbGnctEXoHG9Pe0d4Bt3X3cFy0DzhknedmmieTUsjwMADe7KmWoH4nFn8OkM1o4sKJ
	tX4ZXbfYrrfqL1rQWT5YE6Z+sS0L+jHYS78POSpPj3+3dNLNQ/wCE1W3FR1vxzhFPxfknlOd4pZ
	56hXrpx/EfmKTpKY1Y/iM/9VXjPFPp/FKmcCKNLNeLy3w7lKCTbiggntYHDmMiMwCN+QjVunqDS
	HYtLSD89CbmF1Xv2RuS4i3yF7ZlPiSNBlxYkuBoBc+msrCKVll0O+8lIwJHicf5MX9f6NQYYTlQ
	h8xq9QUmxKzBS/VuI8/EdMJ4OTYU6Q5JdOceiKsFOOApILiRk25d0eMaxMg=
X-Google-Smtp-Source: AGHT+IEr3FTDT7SjKLFcV/86PKpmd1Ulc9pLBA2vnFIK1IvijuUo0pqO49m1oZQlx0sqziOn6memSg==
X-Received: by 2002:a05:620a:4448:b0:7b6:c92e:2e6f with SMTP id af79cd13be357-7c047c1b895mr615602285a.22.1738946881480;
        Fri, 07 Feb 2025 08:48:01 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ed0304sm208492185a.115.2025.02.07.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:48:00 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] thermal/drivers/rockchip: add missing rk3328 mapping entry
Date: Fri,  7 Feb 2025 11:47:40 -0500
Message-ID: <20250207164740.14475-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mapping table for the rk3328 is missing the entry for -25°C which is
found in the TRM[1] §9.5.2 "Temperature-to-code mapping".

NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
      4096-<code in table>. Whereas the table in the TRM gives the code
      "3774" for -25°C, the kernel uses 4096-3774=322.

Link: https://opensource.rock-chips.com/images/9/97/Rockchip_RK3328TRM_V1.1-Part1-20170321.pdf
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 drivers/thermal/rockchip_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f551df48eef9..a8ad85feb68f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -386,6 +386,7 @@ static const struct tsadc_table rk3328_code_table[] = {
 	{296, -40000},
 	{304, -35000},
 	{313, -30000},
+	{322, -25000},
 	{331, -20000},
 	{340, -15000},
 	{349, -10000},
-- 
2.44.0.501.g19981daefd7c


