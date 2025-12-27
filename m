Return-Path: <linux-pm+bounces-39966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C413CDFF42
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E1A33016CCD
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128A32470E;
	Sat, 27 Dec 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="T+o7cNI3";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="rUHiDWwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA93242C2;
	Sat, 27 Dec 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766853280; cv=pass; b=M8fi0rrTMHyLGS0TQbIcOJjh5Vlm+EiJ9Tsh7jj062S1HZRDpRvz6ROCCDk6/6gbHBzGGlrklXqNy2NzGm1TdZcm2FXUhGuydOkuK2/MkTY1B5/u3JhDGu4AIESFATvaTPaIuiTbVPc34r3E51fJgX5b8yeNUtnli6t8ia8EtZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766853280; c=relaxed/simple;
	bh=QAuf+cMdNxs5eGncOwpfPVnx7bwtpA/mXbQcHusVmDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EQ69+Mm1sMxCSkZ92bBPeyyH0HwRNDMXykB1ceAV8vFUwM+GVZZyU9+2FH2YZtXPsaqYKXoVI4baHiD1zrBzgALBex3ZlEOORjkPw4M1DbaH2cNoqrB2dFokdfC6jXmTuN4jnAVAVD9H9DxYFka32hjpnSHNJcS15Nu5mqu8a+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=T+o7cNI3; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=rUHiDWwh; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1766852904; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XvdxblLCrdDbLt1mtdBZhtZlmTuE5nTxppeNyM/oq/GQW0k44V9zEHrARUKYZtyY3H
    wPJ4MLES+X24+Rq67HcWL0ty/mJ5j1oODzVFoGCez2r+LcYvRzE8auhVQLnLjFNBp0rL
    JBnEhnSRavaFagTjG/QCKo9p1Nm/mv4hOabG3gSCnyZh8KwDfoIoUlaH1znx1odngGg8
    jMJYJXf19Etq1qcYEYXe1Q09oouoTdusUvtQ0ebwBRNfPhvv9uDXQ0JOK38rkoQj15Au
    tIgP6LjWySySXRcPrMKWQAWyRcg3/HqAGsbPvYOnVRb+F083f49eO4wDMthEp+zdvy28
    LYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852904;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=VyBAzRalal+p5EliBFxBewJN0DK+Unjwn6xANRTpk6A=;
    b=QXPDqgmxv5Thquo5mJi0Zns3kIPz9/t7T5DN2kyyfQxW2X/weWWEo8BS2FXLgiuP5Y
    quVPyqnGma2EA15NWS/Bx4ol7UEi9l7ffOhVLCcm6cirG1y8SXD6SuzfDKqVvUbH1FGF
    A2oywo0Yi0wVOY6j/1Wi1FhM8wta79swyfX6Q/IIvdBIevNiVJ4tPT59shfdq2qZsZ4w
    aYMH3fVKtDSWuvt70E0Ux+cwvBb3YqBTNJ7t3mZn7LLr/PHmuD7WDAQXUQT5l2uFhWfr
    e1swh5bjPUTJXhU1EYLlE8HXMA1fZ3xfDzOm2wSrtoMbXf1DkxPguRTNvPUioBQvTym0
    wbzA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852904;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=VyBAzRalal+p5EliBFxBewJN0DK+Unjwn6xANRTpk6A=;
    b=T+o7cNI3rAMorQJSGUOR/vT+3hzCGh+tO+7Y+gvAY6iHbtrK3+8IutkH9ip7d1nyxQ
    AgxjzEYsfXlbgW5TIcC7vVRn896qto+Sf0+rCpUmDz7RU8jSMHTuYoads1skFCNZo5LQ
    U9ioAttHgmYdg/5bOkac3rFL62v4x92omCOr5CqkqYMNBlRrIoKT0RL/p3fqXGW3VKBu
    gCb0KcP2N9qXT/9wSWEVvbixwvXUBKERhttB2FUVeo5AdjZbdDDMLDOE8URc6tL3dFOT
    6AdOtmY6nEEqMCvwUxfX7FO2DfJ9YRUOyZ6SPn7C/xDOf2m/C181gnDmnfEywdtXQU+y
    PttA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766852904;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=VyBAzRalal+p5EliBFxBewJN0DK+Unjwn6xANRTpk6A=;
    b=rUHiDWwh+kTD3oR4xdGnTAjOPZ5cDrwBm0tTpCVaOy8xmHy5ZEilzTlUfu4k2gsHpT
    PQGIAvY/kAPFz4xr8ADA==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQvpoIkZXd2bnfIrOV7Mbk="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec1BRGSNtuH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 27 Dec 2025 17:28:23 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Subject: [PATCH 0/3] power: supply: add battery driver for netronix ec
Date: Sat, 27 Dec 2025 17:28:12 +0100
Message-Id: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwJUGkC/x3MQQ5AMBBA0avIrE3SVhCuIhYtg4lEZYqQxt01l
 m/xf4RAwhSgzSIIXRzYbwk6z2BY7DYT8pgMRplSG1Pj6p1He4pFZ4+D5MGCKuUGXTajriB1u9D
 E9//s+vf9AFGv+c1jAAAA
X-Change-ID: 20251227-kobo-aura-battery-3e60bc159d16
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
Josua Mayer (3):
      power: supply: add battery driver for netronix ec
      dt-bindings: mfd: netronix,ntxec: add reference to power-supply
      ARM: dts: imx: imx50-kobo-aura: add description for battery

 .../devicetree/bindings/mfd/netronix,ntxec.yaml    |   9 +-
 arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts      |   9 ++
 drivers/mfd/ntxec.c                                |   1 +
 drivers/power/supply/Kconfig                       |   9 ++
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ntxec-battery.c               | 101 +++++++++++++++++++++
 6 files changed, 127 insertions(+), 3 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251227-kobo-aura-battery-3e60bc159d16

Best regards,
-- 
Josua Mayer <josua.mayer@jm0.eu>


