Return-Path: <linux-pm+bounces-19243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B99F2213
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 04:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76871885810
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA48C07;
	Sun, 15 Dec 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjm3QGAn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3C33FD;
	Sun, 15 Dec 2024 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233223; cv=none; b=XNuUk/COzqshRxaTjDIr2ZE0vVuErrkOBLSENYb+YMUNfYj34VBZNX230bk+MNyQJFMTd5yyqy37skPzD9ngxRY2uhJMJDHwA9I3XtZ+Fo6f3tTR8wIzlOIgK7G1LnCRzGLQ485aXd3BTWNFZiQACP8SpPR5jpj0YYFRUmaYky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233223; c=relaxed/simple;
	bh=830HsbL0q2xNoiQ5LgkvYv9oN8LAN7Z2evbpnxvOz/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGjXJSXZc0SOrhmAD3KAl4KinTLmQ+sXHLCbBFLA2hGrlQQ/kKMngtBmyvj3ziqmGH1H8+69aTxwdNUAyQlUZE1w/+iwrq96QfE+p0ZSt/zuqr2Jbq2a/aXnjpbu4VDgapAbkqSoSkjBcd7vm0WHO/UzbDPrlNaZ25gYVD10aZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjm3QGAn; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a8f1c97ef1so8859025ab.2;
        Sat, 14 Dec 2024 19:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233221; x=1734838021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ii1hnMOWs8P6i05hyvRw7w3VSS/NET2YVPksEA1Jyw4=;
        b=Pjm3QGAnReNl4iccPEB09QmB9UKQT0SgS04x8j/wDp+KNoFVT6BdnIsQOJURrKJoLi
         Bav/m042mrhx4ANr4O6D92htuL+hQT2o6QAfO24GzCU2OdtDFeiycOaUBhO8lNqaJreZ
         0EaRMQP9YnBvwUyedamydCtyin3X6QWh8x7sYqX5pU7afSSK+d8s9IST9Xep/jUpcozx
         an2ItzuDjJzbPIzRFXWfbs6gIIIpJ6EXYoafcct3usUkNaRxNP/mvLpNAFn7YDmT3Q2b
         0Vp3UzSU8LEAOhFnWKi5u2TvYFq1/FTcWTf3HodrWkuHBFt4tk8b41nL+KfBFuFIKP7O
         3tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233221; x=1734838021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii1hnMOWs8P6i05hyvRw7w3VSS/NET2YVPksEA1Jyw4=;
        b=HA9qNhcZ0bTI/wZASgXx6AM9OTb0g7cr0E+e9dm7V56VuBe+YPzCUbhMbhn10KQe/B
         sheiZpw17p8lpgFJjuYjHMCpWC7wY+MCEgfzQ75Yd21TH0dvnTOPHGNBn/DWuf07mQlW
         DiAvWUzhE4o4GLQeAfN+6oqHOtvtfSWYZ1MU89ocmI5Y6EFDjTeNpz2QomT2j0hE+oCz
         WdPra6NfMOFAFcLujyKWtJiTQ2O9w4WMFWfP01fkusfhB7agmwj5xm+tQcUjvqVktSVm
         d/N/ynARoejETGIRoDdV8XC7OaogkMov1NESiQgWY1SafP6tybh65Tn0xsFfykwhGJoU
         oFOw==
X-Forwarded-Encrypted: i=1; AJvYcCUO2lF0Co/L0Oe1VrDm+AAE/3FuHEUUpbQxoEalDryI4miBG52TeLZ6xPlgaN4xznbsSfcxmVaiczCB@vger.kernel.org, AJvYcCX0Dqe8QiN8aGWGq8F4f58rNT7iaJ+q3l6MSixtIDGPUMgNyFdPfT4bTMCb/PS9AGDJw1DTCcYXSz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47leZ/Wg3+9spIDCs/RBC9XW8mzXgtaa2QZae8DgVm907ybia
	77SIVWhiX5XUocTtGhep7FR6Y+viRNCelzCKpxpVWNnwnor3gX8hc7gBWw==
X-Gm-Gg: ASbGnctng8cK7O1I7ZcAGSJdJJDUoPsJSGdEjHg+THyNv5vJaOUG6nNFMNXa/vq2PTC
	I9KDJGxwlRxSeDdYaBRBs72APw+n32d+G76hgwyhiGf8hJwQttepk1A5RLRo6bZwJI3FogW0ucq
	WktshRpWHyCCZuWsz/RFOx3L3UuQYiQolI/GjUIUEGIR8mMB10KTPV00RhDxvHVkIcP74OA/6mG
	zhjN7CxwfDvl3wvDsJnWeTQAFkQ9B4n+506uMm8RGfZwKfDeFcsaSrCemL/I3wAmhlOexRBfNkj
	5FH3uFrl70maMsLfndXvBHtsp6I=
X-Google-Smtp-Source: AGHT+IGpwOE2wJxAOjLF0bAQQL6FoFKJ9XLm19p53xYBVuz+j8h2VFlGeMGJVVbDBavTQ6Ov2c1eDA==
X-Received: by 2002:a05:6e02:164f:b0:3a7:8208:b847 with SMTP id e9e14a558f8ab-3aff8c91872mr79670485ab.22.1734233220827;
        Sat, 14 Dec 2024 19:27:00 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2482298c6sm7755575ab.31.2024.12.14.19.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 19:26:59 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v3 0/3] arm64: dts: rockchip: Add Firefly ITX-3588J Board
Date: Sat, 14 Dec 2024 21:24:52 -0600
Message-ID: <20241215032507.4739-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the 3rd draft of the device tree proposal for the Firefly ITX-3588J
board. The same functionality issues as before are still outstanding;
however I have cleaned up the style and structure as per the comments by
Heiko Stübner on version 2. Of particular note is the splitting of the
device tree source into two files because this platform actually consists
of two boards: the ITX-3588J baseboard and a single Core-3588J compute
module stuck in a slot on it.

 - Shimrra Shai.

Shimrra Shai (3):
  arm64: dts: rockchip: add DTs for Firefly ITX-3588J and its Core-3588J
    SoM
  dt-bindings: pinctrl: add header for PCA9555 GPIO extender bindings on
    some Rockchip-based devices
  dt-bindings: arm: rockchip: Add Firefly ITX-3588J board

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3588-firefly-core-3588j.dtsi   | 453 +++++++++++
 .../dts/rockchip/rk3588-firefly-itx-3588j.dts | 712 ++++++++++++++++++
 .../dt-bindings/pinctrl/rockchip-pca9555.h    |  31 +
 5 files changed, 1204 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-itx-3588j.dts
 create mode 100644 include/dt-bindings/pinctrl/rockchip-pca9555.h

-- 
2.45.2


