Return-Path: <linux-pm+bounces-28245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD9AD13DD
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AB03A46E2
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F681AAE28;
	Sun,  8 Jun 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA5Z/oZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B38633F;
	Sun,  8 Jun 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749408658; cv=none; b=dp8gqus3GalyL2KFfxrUtknrjHZBjD0GpidCxjusQ97Dz8JYBK8F4K21CBoPTDFMuLgNikPBx2QeF8HMZNZNIiKrnvobdVyYmg2/CDnT5rnl5xbwgDd9kSbeVecEK+Py42WqxcqOfe7fhT7DByVRixVcuCez/eFR0PjmU2v9wCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749408658; c=relaxed/simple;
	bh=i7jidX805ido27bLSUjvsY/4xQhzmHpuM2DFF8z+37g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oP3csaxAe7RSotEBQX8C76NYiIYjWc0Q+LqbggUplC/c5rheT9PW38kXp1ufV9ZAGrxcs4ksie3WC6LkfYV2n5FCwAKh+ztgFyP0Gy3eVMwmg7171bIbDprZ1iZZsjE5bwMZvhkOpqgu+F2q5Xt23dbfJByPITkabXlZrosKiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA5Z/oZT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74800b81f1bso2740281b3a.1;
        Sun, 08 Jun 2025 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749408656; x=1750013456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FkQOjW0dEQldWqVQqpMRcOS3E+ncteqKD5m7Do0e/E=;
        b=GA5Z/oZTY1kKrbhB4bRfY/SHHmJe4h43+wV0mdEqfV+h82tOwiSyuYaH/XRiG5N4GE
         ZParffbXqFHFOh6YUdQmPILrE9mSfrAZa4/gd9awDvdGRfG8udwUNSc4dAMObgeBO1ou
         hNkhcx/uLYfPDEWeov2EHn+NYE0W8yDiNmvtcnZxBaAZ9bDhFx+NZDf5f2pzOtZdo48b
         UnG3jneKI87MMJ4BGcC6G3QIQB5j2fBJRfyFjoyWyxW4cr3+Tyb8+XNTJqHpvyalmU7w
         fyTJ0rlaAGfDD8YsuxJb4fn0BgpQcRAU5QrtDok6/hYncfiXH/gViEJfb4lPlMTQZv1n
         Ljuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749408656; x=1750013456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FkQOjW0dEQldWqVQqpMRcOS3E+ncteqKD5m7Do0e/E=;
        b=gemYf0ALUwBW43n8h/vqwAIK7ZFHiAUJf8dspggySCP3ZX18PgLYzvt769iyZIt0yb
         NZyiJPunlpIPFlqicDr0vcRCCCuQ/sJCqXRytX3wkeOqC8511hzvkZYF6vMDguWzjXeo
         eUNwbVtOUeae65fT9etf25dgTObLVUxMHQ3TzZNDz7M+DyHe+9GrstzF9YwL2FyrjiKY
         T7zHxkylLNIqnXfi8nCEJRdcPGV7l3/Zj8/nJUXmks19mxYNPNxl2/j+hc77s5IwnhWW
         v5lem//6XDDwTc9klz9tz9XxBFF92xPYjKogA++LxOZv7wJ8sjpQrX8xWgYII2xbchEs
         Ti7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMzHtIoGFSoPidp7iZw1UaqaKQQkW8QaFu0LbmOduQ9CJAwP1Czy4/f/9JTyIp5K9wv0LObc2z@vger.kernel.org, AJvYcCUqK7h1VnX/xRfdg8xT7PqEbBzNOVXaYnHJSkktxDsgpA23h9sMM1GCvTypM1GPYVwD1Jb45JX4JCA=@vger.kernel.org, AJvYcCV33jG9NBEpYL0+1O3QPjUgJnTtQcSuODkxPGfHhOnSdplYnvPPbSBlF57QGCbq7Cg3LjlmiIT1DZMoTXgo@vger.kernel.org, AJvYcCVN6/TrvNGIz+XUhffzHQxyQq7vr4S2Jmzai4/tnOwXK0HpYMABLeTh7ZbhW6JGH+IMVUPHSFVOD649@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1D+W0nDP4niWScHQWkN26rhkQTYpQ3gIM2aUDvu2/xN+ECdgI
	FxD9afG3Sa20d3mzs8osFN/NXIwSWMg4Wvh5zE/Zd/jX21br4nJex1sC
X-Gm-Gg: ASbGncv+iBSQ98995ti2wJtLrVVSyxd6qwxWgouiTW1+D8lvDdSk4HTmh/Wo4KDB/xd
	7FxqzXTuNZ5hg0+d/m+s5P/akVh3xqveXE/FlvA4oq4h1u75b3kj1lF5h5Ur8cxaklqMRaWTgDt
	cHTgl/+V1MMw/QhUo7k8XnaFe/HHxZJHRNqHsvW6HYBNJNIEqWLTiIyzdPCTy4k1Oec6Wj35zcK
	AFE/e7T8OC1AfCVUSutOGnhHhqmx3SPdCB7+DqVWiITHHbA5CDKodpL3Rg2ugS66W6lUIJ3gjgA
	XkN9hbI1f+2gNWgYKzpSdSzBIQCaAEJQ8P8zSiBDh9vSUAXfSZHyHqLl8JNBfqU=
X-Google-Smtp-Source: AGHT+IFmkmDN5HJMtOVAkQ+D2VV/D9Hx1lj1672INza519ZQEJaZQhN5dtNTS2zy37PO0ZFmNvX1dw==
X-Received: by 2002:a05:6a00:22c7:b0:748:3485:b99d with SMTP id d2e1a72fcca58-7483485d9d4mr10823644b3a.18.1749408655711;
        Sun, 08 Jun 2025 11:50:55 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:21ba:8ec7:ee03:e8ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af3824fsm4493278b3a.19.2025.06.08.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 11:50:55 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Mark Brown <broonie@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Sven Rademakers <sven.rademakers@gmail.com>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH] arm64: dts: rockchip: Remove workaround that prevented Turing RK1 GPU power regulator control
Date: Sun,  8 Jun 2025 11:48:55 -0700
Message-ID: <20250608184855.130206-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3588 GPU power domain cannot be activated unless the external
power regulator is already on. When GPU support was added to this DT,
we had no way to represent this requirement, so `regulator-always-on`
was added to the `vdd_gpu_s0` regulator in order to ensure stability.
A later patch series (see "Fixes:" commit) resolved this shortcoming,
but that commit left the workaround -- and rendered the comment above
it no longer correct.

Remove the workaround to allow the GPU power regulator to power off, now
that the DT includes the necessary information to power it back on
correctly.

Fixes: f94500eb7328b ("arm64: dts: rockchip: Add GPU power domain regulator dependency for RK3588")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Cc: <stable@vger.kernel.org>
---

Hi friends,

This is a patch from about two weeks ago that I failed to address to all
relevant recipients, so I'm resending it with the recipients of the "Fixes:"
commit included, as I should have done originally.

The original thread had no discussion.

Well wishes,
Sam

---
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 60ad272982ad..6daea8961fdd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -398,17 +398,6 @@ rk806_dvs3_null: dvs3-null-pins {
 
 		regulators {
 			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
-				/*
-				 * RK3588's GPU power domain cannot be enabled
-				 * without this regulator active, but it
-				 * doesn't have to be on when the GPU PD is
-				 * disabled.  Because the PD binding does not
-				 * currently allow us to express this
-				 * relationship, we have no choice but to do
-				 * this instead:
-				 */
-				regulator-always-on;
-
 				regulator-boot-on;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
-- 
2.48.1


