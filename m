Return-Path: <linux-pm+bounces-25196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78446A850AF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9009A43E3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD6F4ED;
	Fri, 11 Apr 2025 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxO5WP+2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F713B7AE;
	Fri, 11 Apr 2025 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332026; cv=none; b=Ja11SnFBP9KmHwoW/DaoiXmMfqjhhq0jDdNgJ8QycAe5HuOXU1c6TxYq+UaYXSF2dk7GC5dzr3dvN9aBO4gRD+t9ML7zmwAytItOUJJC0efJWBpEAfVKhD1NE7HKLUt/qUYP68qMv9OXiIgESNXmp8sKfwBgWJSDMEDySCa4a38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332026; c=relaxed/simple;
	bh=OVnmHC1nA8BJoaP2LILMHzkcbR2WcOje5+IPNQb/UsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ps/ItS+QFMksSGALrWbaGMybFEqso/Wh0QAqCdc7gNAzhAW9J0Gg+PbyqCzax+pjJsPnRzpeoro4xJ4aFSXz0LUY/Jf56YzaI+su1rlV54IAqitRK3qqOb8onQJXmzBucCqgU1bMC9+RcBg4waFk6Ft/a6Ly2HE4L6owCD6G+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxO5WP+2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso13393791fa.3;
        Thu, 10 Apr 2025 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744332023; x=1744936823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkLjkAkBybKViu/IzAoHDfQk1VY1JyR4qcLvgOYgY4E=;
        b=AxO5WP+2XtXAQHEr9xxWozj1tLTyv/Ml86S/AVd1hT26E2wUE1BPE/2+DfEyAs1LYK
         McI5vaRTSRO7UhLjA+u1OWgR3+Z+NfptxCBilpsrCmrpIYOFVxD+BTQZShf4TLL+Iytn
         OMDzwsmqgjVdOl9rpLv9gauYv3XghlEoK9MlLfY9h6xo8159RkwcJhcvGTm1uaMQmEai
         mY0v9sd24hX2EKL+/bGdRHFZ3VUHunMpPkczg4ZNGivieWmdj+gn1IDiIEIjeGTI10vR
         zpJSlOXmnd22j7t6nPBjB/FM4cAhyzmpbjS0qojmqDLySNFLUHclHHwq/7jWTSz1qLGh
         KLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744332023; x=1744936823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkLjkAkBybKViu/IzAoHDfQk1VY1JyR4qcLvgOYgY4E=;
        b=F/Aqaj5+Jb1n4AKaIdB4djZ6K7wYb7tMNBtAn5OeDkNDpUXQ0DaUnQWZIDT0sgdDSy
         Smx2jqVv7cX1reN7UyyngbFj4l1vbopKtQwaQvZk41kZIwQEbBReBWxbgqOnhgVp1A3m
         lQheeeNoBcsypE6cCjJ3p1D8Azj7Q4I+1Zb5PT0mF+2zoBrOc14ayKRzgxEpWvc/+h2L
         CNDTBnWpJxDXW5KFCtEdjUEXOJnXj/wUQ/zNIpfMWD/PbMs4zoXspx8MOJUP1sn1Ea1y
         S+y4BynWDWjzU6cS+wh8w7udhfABVG+8nNwXYq+SWSgze7/Hx9zsVj7eAA7fqt1SEjkZ
         EP3A==
X-Forwarded-Encrypted: i=1; AJvYcCU8iQUAnUW2yb/o+yUF9m+MamCaYDYXTmO7m/IJhi6DbUPp3l7yA7pHZF/Ua8akaI4fg3jKy7AuSFk2YsuI@vger.kernel.org, AJvYcCUhWJDGV13dtR7sHkDijDFwEKtbqos2tsBkz9JwN0kKez/KBYN4jd7npLJ6MNMAZiEBZh42XwzTSp8P@vger.kernel.org, AJvYcCX83l2hh+QbM52t0k6uEPMkNoHwts4sSnq7ffhSHXgM5cIorxkXJVUIM3c8Anba8j9VQ5q+0CnP9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2mT9xzy4Nmk3PXrklrZ3Jh2jaseFzQ7gXZPNO+WPF1o7RRWo
	4KOTeykV63nrB/Zynea1s5KvFDGtJzvkMQ7XeL0RpEDttramo8th
X-Gm-Gg: ASbGncsUU2gmjJlfBN6XYabmvgt4FBM7fyP+FeuYAU5JpKkUlOEfNjJp0JazJKIXRqq
	fedaEbciwixHux1IcUBKx1WgT+KgL72Pf5djhHQL+eq/oc2KtCLCE7DvO5bTRBmjnceKjrOKgFB
	XDx3NjmQSU0FmQSR7vBJE7+II2rkPwftDwtJdeY7skOo4gT9paOSgEG0leHzsDuRNQG20AXwzXO
	4l5VsSc4Q8emJFtggW9tDPaQuemvAdIZMrmixynG67jvbyxoawPYGYEMSZmvf4wkVSsKRvgO0Wi
	mCUIkQdCEOH5pKy6dl/AnpzSQZ7Mn6z3KDJu1qObBmne9PhHRA==
X-Google-Smtp-Source: AGHT+IH0C04pdT7V39Cl5bBkK9z9UT0OrMbiEPLzhJb+HovoC/tpoPabyXxob1snSgH5ltQh5BDI9Q==
X-Received: by 2002:a05:651c:2203:b0:30c:3f82:6844 with SMTP id 38308e7fff4ca-31049aadec7mr1968671fa.34.1744332023158;
        Thu, 10 Apr 2025 17:40:23 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea5c6sm6344251fa.62.2025.04.10.17.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:40:22 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 4/6] arm64: dts: allwinner: A523: Add SID controller node
Date: Fri, 11 Apr 2025 08:38:24 +0800
Message-ID: <20250411003827.782544-5-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411003827.782544-1-iuncuim@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The SID controller should be compatible with A64 and others SoC with 0x200
offset.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index ee485899b..d626612bb 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -171,6 +171,13 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		sid: efuse@3006000 {
+			compatible = "allwinner,sun50i-a523-sid", "allwinner,sun50i-a64-sid";
+			reg = <0x03006000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun55i-a523-mmc",
 				     "allwinner,sun20i-d1-mmc";
-- 
2.49.0


