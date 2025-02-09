Return-Path: <linux-pm+bounces-21609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE045A2E11B
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAE93A596C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF49241C94;
	Sun,  9 Feb 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBUn2WTW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12D1EDA1B;
	Sun,  9 Feb 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138835; cv=none; b=EcyXJwzJd+KwntD5VAU25nXTG7O294MnP6bvpwhlH023bROxx8Madw4k7zXOWBmDBtgMmFac0V8KDvaze83Sp9V7+EnaLMCQjkkj1A8rRksL+3Fsu+xmzNspq8G4Qzl70q29hy+4F6li2qKvT6wftdTFwEKrBR/XD76f17sGPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138835; c=relaxed/simple;
	bh=t+MEcyEDzmxjBv9SK0gxt9t3iAQ72gz4bhKsUugOYTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne0iCz2kORvxrNlw01KX4xxnBHlZ1enofFnXOojuKMFkdzqKChf5tHt1IDEix6WoEzv1tGVxMly14IktF8mp4P97Rd1hKIqya9h1Q+bPbzUy5n9Hvkm1oZOULK8sFNG3PyxscYl8IP/N6vXfL5jeHLaHcigZrBYL8uwfDZSpVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBUn2WTW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd14c99d3so1416766f8f.3;
        Sun, 09 Feb 2025 14:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739138832; x=1739743632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKk1eBFoHmDcld3Lfx7t6YPL0jmbrCaQqUFUOUwjSIk=;
        b=cBUn2WTWAQOf9C6R2mRLEGUa9mk+yc0yBCYye8tOHmTySXAdWXpddAbH8lPqCOXPos
         SBJbualdF1A+2IJoH5sF3lMyKTnhgFNo2eYYk5OQqSXdEhVBsRNR91+WIEyessJAZbei
         zBg9y6jKHFUUXOhR/NrHqQQFyeyJQ2rIs50k29Ip1tcISjE3xfswb22p5+aO9rA6Y+/S
         NXSTIAsLejfM2B7RO/mviEwSvUmRmLsbYlOceDSWMiCmVdsS+9nJasw1lKR9Y/83xK06
         CZfnG6uvMJHrZUCf5iVTWnflDduwEpQQl51RlhLViScTRYROIVczzPHXzgidSpyJDpw6
         9tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739138832; x=1739743632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKk1eBFoHmDcld3Lfx7t6YPL0jmbrCaQqUFUOUwjSIk=;
        b=ZbbHXlm65+ty32XsuDf8tciaK5LCTJwLOFynv6rkfolX9NAGGOiY+GpirYUVEcUAin
         4BECVxSu+OpOJZQK5WbdDggMnX82ptJGlRHSDBDKJLKAU8HICcauBorUgaMxlu3ta8HC
         lcnc4qBpSLdoR3B+HVnYEO4POnZgBGPrQE1x+q7N6mXw0ELNLz/u/cm3HkkIaDR7VDF1
         ZGLaozpiadTF0CKJoO5pCianhstZXX7djeJxwxS95Pg8Rid+6jJQQWQfJuNq4HohOR4L
         obTrYhsJDmZBV4Cax+0FWrpAUdYwezCeWj5CrbvSdfuIlftcJ2iPCM8lMfNItNOL4++D
         KuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhDvnDAG28wZsBDPRdrW4+g20dLjNquG3aKl0VRrniLX/E4JhkoG2xCEIhmrdeKDCyFY9vxfEQ+KAc@vger.kernel.org, AJvYcCXyr5LPslmIdLAEc7WK7cWfz1lhQwRzhBL8vSwWi/iLG0c1ZKoVsUkyteY++ZMYprgjgZNZDvYEw3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5GvPPgvpzs7ZQUvBRIHcg/huG7yuKZuAe/wiMATyolx4Yv6YX
	x216S/pj9+a0lsCpuiGLqdvLhZ2B+zFx5okLanTSQIRvTjgbI8dt
X-Gm-Gg: ASbGncsLbF0zIryQPDj/lEVOPSvo/ZitE8VTf0iNJZKJXuEwIqJw6/HhqpHy5HkLKFl
	v8WtoHJBvL4Sm3E2qadf91HJ/4GZkMzdzgpuuxmUkm7AtsSBhet5/bZqS1mtR79+6/0gNnlW8bG
	aO7+y0p+/ibduuuUHdBYyXTzZ6B24Qq3uyEA1Lx7xsFWWF+jFunUfDS7K/GWVQbRj69xBE2IWlt
	MigeQ2ruahPjZk2fsDe8JSLqln8hqy35XxZfpjd3HNkMApF6o404xeus68UZjuv8UwxfuQE6Fv7
	1OANB2xzSEAkprVtsKYn1MpxDLc4
X-Google-Smtp-Source: AGHT+IF2Bns6I6YCSe2LhsETO1BYlvvXG98BlhUd8nZAEcFJtGt/bc67HK+7TnAd5oXHt9YnANZ3Nw==
X-Received: by 2002:adf:f70b:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38dc9135d53mr7026781f8f.36.1739138832176;
        Sun, 09 Feb 2025 14:07:12 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm10386544f8f.53.2025.02.09.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:07:11 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Reichel <sre@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 08/10] riscv/arm64: dts: cv18xx: Add sysctl and reset nodes
Date: Sun,  9 Feb 2025 23:06:33 +0100
Message-ID: <20250209220646.1090868-9-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reset controller node and required sysctl nodes.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
index 53834b0658b2..d793b6db4ed1 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
@@ -309,5 +309,21 @@ dmac: dma-controller@4330000 {
 			snps,data-width = <4>;
 			status = "disabled";
 		};
+
+		rtcsys_ctrl: syscon@5025000 {
+			compatible = "sophgo,cv1800-rtcsys-ctrl", "syscon";
+			reg = <0x05025000 0x1000>;
+		};
+
+		rtcsys_core: syscon@5026000 {
+			compatible = "sophgo,cv1800-rtcsys-core", "syscon";
+			reg = <0x05026000 0x1000>;
+		};
+
+		soc-reset {
+			compatible = "sophgo,cv1800-reset";
+			sophgo,rtcsys-ctrl = <&rtcsys_ctrl>;
+			sophgo,rtcsys-core = <&rtcsys_core>;
+		};
 	};
 };
-- 
2.48.1


