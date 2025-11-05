Return-Path: <linux-pm+bounces-37447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A4C3558B
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 12:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05773B06D9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232930F929;
	Wed,  5 Nov 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k278Zokh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17FF30F545
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341715; cv=none; b=lJMRslgkhs2gmZv+3B1eiLl1TIW8wrCGSxD2SZNAd2q3eXmwxp1WgmMBq3T1/1mrSjO4S6iOdX1z1MFSFXZBn0OCUAzozskdKV+toE/ceQuSo18POvZiy3E9f5QqGBpxLsY90VP4e8S2o5NsK+ha+BiuqPYsg7o9Hrb5kFpzGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341715; c=relaxed/simple;
	bh=BFh9UCgyUwVsBujdH7J4wHkf6lQu8PKTJJsPUVxGQHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGSrPKXgAXe05iTxuZ7l14LTOdcQ2/t+daY1TRtEl7dq26qDywK68OOM000XPoVQL/QrTELCtIo6blwQWxt+SHt7UgU7WWlLX5PqKWzu3mZj+WDl/igrVrlRsMgCef1pdciQlr4PsxXqLWMzNnaRt87I4lPLcY8YCA1kvdNXl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k278Zokh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c2f6a580so1437284f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 03:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341712; x=1762946512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1euWTEJaHKdLb/LdGqQPWx0LpFCSrEIebRupku/uzo=;
        b=k278ZokhFRG8x2Yfc9a+f3qRXKSxKe2N2vCj3XDtw+piX/ykpK/BP+DGni/rX1/3Oq
         3Nz2F733yooupiRFKjbE7DIlk27TccKLImgYqXTFNvrioNEw4KQvTYY6WeBT5OEPuFRN
         XszjZMljn2L8LB1Oc4rdPX/SxnKRpppk1YmFwIEiLRPkvQis6xbGFbTB3yh3FGnavA/+
         fz6FFRX4/Js7Wz/tGk+TjZr3WQh0ppTKlcI/FmHJkVMzK+v6Wk6o3tjDGx0vLO+akzmy
         k30dZrTBdbD7Oo8oFfwtmeJIPQznqw+HVu1Lm9qojYwO1c8fWdI3kN+//adGTjNCAVMq
         tpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341712; x=1762946512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1euWTEJaHKdLb/LdGqQPWx0LpFCSrEIebRupku/uzo=;
        b=wjz7ZDNMUZY7paksizXkLEirorfOFpThzEcbAvl+L604Fh9vj6OkIvmTH+qrNHeXNb
         723QOuCCQi7fJBmCMJRBiRKVKK+LCAD47ATJmaK6FQopf9VNatA+44Ehh0IdwAwtIc/W
         /R/M9G4ugdwLzj/hwBjNcrQ0Dt7ioRseJGm2X8bVYSd/TPop85GKAj9KUm32oXzh6v8E
         qtqkfgT0Ldow458EWVuydPhaNE4GThgKxMJtym3IZhQ3H+n5YdduhHzgYhMyaLN+KUsb
         mHm7EAs0pGIqCncC6/rvojZSx/aJwlfgwJ/XLm+0vFvofsrpJzUnxduER/3wDCS9kVZe
         PGgg==
X-Forwarded-Encrypted: i=1; AJvYcCUjqYtFftYNO83T4Yz6DeT+NAx/spyKgwwWqJMmn9iXCuNzLEq4Ia4CzJVhNkPZff5RznmLS/MzOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rMtmNb73NJJlGZCzIZJnSlhkPCG54lzYlKggtfk1TZdeolEO
	G1XVOp6DTefnJCXUa1AfWfQ0XI/xG+WCwlX4rLoZll5bYj5exM3vM4PW
X-Gm-Gg: ASbGncuKYccRMPOr5k6UQhkl2O6XWZfwLSY3d0mldVEKHumksAEAumm0NZ32atZ84ww
	jxMUlIa7L5RoQV0rEZqA9Rvu8yPzXT2XM9us5rv0N6uKxk2XDqwD8biacvPlN85HzwqRn2icKzv
	qTpPqdYMHIWSJW7ciXZ5AgS8s9Uh/Sdx9ub9ghZo97LL5SpyTvFSrPAC9fqLd6mHjRfxTQsJeqv
	HaXEerLBJ5ZmT5ihU6VdAEa/+EvCuC7hJ20tP335i+zFS3R8DBqa1uovULReukQDjTGsc9I+lxp
	fju2SQBEoPfB4og55BQy2lbiQnjlM7jNork0CcWemW4zefjJguIrwxZqKUBBJh+Kgggek8ihtEI
	+SOj7vur+Ju7wwZY0hsYKv5JiudjXfsoJ1g88XNxgGbyC5tjUHJJYG40Mt+cVmaHeKDiykTEMI8
	Sxdr3K9mVJugf44o39HceIs50T1rloBg==
X-Google-Smtp-Source: AGHT+IFaBERjDOWilhiZ8nC8UXn/SnYdgLV2o1hiIVjnv+aP0HIBPMqxjWbtS5BYh1ZNdfc2gkZbxA==
X-Received: by 2002:a05:6000:1845:b0:429:ba95:3a89 with SMTP id ffacd0b85a97d-429e33078c3mr2614657f8f.36.1762341711769;
        Wed, 05 Nov 2025 03:21:51 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm9829851f8f.45.2025.11.05.03.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:21:51 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 0/1] cpufreq: qcom: handle ipq806x with no SMEM
Date: Wed,  5 Nov 2025 12:21:33 +0100
Message-ID: <20251105112136.371376-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series handle a small device family of ipq806x
devices (Google OnHub) that doesn't have SMEM init.

We improve the SMEM driver and apply a workaround in
the cpufreq driver.

(I didn't add the review tag as the patch changed
 with the new implementation)

Changes v4:
- Add extra info of socinfo not usable
- Add Review tag
- Fix compilation warning for -Wpointer-to-int-cast
Changes v3:
- Drop first 2 patch as they got merged
- Use of_match_node
Changes v2:
- Rename error macro to INIT_ERR_PTR
- Return -ENODEV from smem probe
- Restructure if condition in cpufreq driver

Christian Marangi (1):
  cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.51.0


