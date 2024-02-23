Return-Path: <linux-pm+bounces-4325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CFB8614EC
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F78B1F218A7
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D3224E8;
	Fri, 23 Feb 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC/9kXj8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B44A3D;
	Fri, 23 Feb 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700197; cv=none; b=lbD6+hp7g81hSfSDVQf4y2755tNLycRwn3N6oAvGtoxMxfkbto10M7a2Wf5MFQFkCgDdF3CWrvULiUE7IG3h+DRS+rJ2Hd44+/pV/L2XUdC/ejpK2UOzPDogcdC805ZRvxSwv5VGh2cb6HFiSiPQ0gzXh9bnoKTf/q6aRql0snY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700197; c=relaxed/simple;
	bh=qRqiZWK+ROUXc7RKxQAD7c06nWL8iNefLn1MrEIIsio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avlF2wlICr349Tn5wxGzkpZhA9Oyj8Y5lZaLYWjJwcy7fDTKMNLvFHoz7OFNYpRyiwOc50abAtWPzpDbDg8TAqpf8sAyqrVlFkwq2WTyUdRsA9GKjJef3RNm9685s2G8ip/MMISNemVifsZmSp3fJcvMD3kNr2hs71q1xs+INwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC/9kXj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B9AC433C7;
	Fri, 23 Feb 2024 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708700197;
	bh=qRqiZWK+ROUXc7RKxQAD7c06nWL8iNefLn1MrEIIsio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UC/9kXj8rodo+yIh1/wpec/Gw94Ss+9rlff9WL77kqnQusyOqQrezzvoxB7d2R229
	 KfL/w24V6ugi5mzDqnqaflgbsqwzX5spbpJ4pjlaIOi/k66yjqkrvmrAvRpIpYfd31
	 o9g1SwzoFAxPZs2reosHn+A8GH2soGadZRZLFUI+to2i19/MK3YdeL2atOa9JY1iaI
	 B6hU9eEy4gfLvivEqfL3ZYTRGN8UN/TSjxNDUUaHJ9NRqO4JLdcizGbSkPcJHIfuXq
	 ywrD+/oi+ohIuL6jCmVbeB7lVLzDMAS391jS0hdzkekltsFrVVuyGcooSt/R0XXFUd
	 952xBOq5Cls2g==
Date: Fri, 23 Feb 2024 14:56:30 +0000
From: Lee Jones <lee@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Input and Thermal due for
 the v6.9 merge window
Message-ID: <20240223145630.GC1666215@google.com>
References: <20240131102656.3379-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131102656.3379-1-biju.das.jz@bp.renesas.com>

Sorry for the delay, I was on vacation.

Enjoy!

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-thermal-v6.9

for you to fetch changes up to f1eb64bf6d4bef5295ab7633874960fbcfadca46:

  dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema (2024-02-08 13:06:03 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Input and Thermal due for the v6.9 merge window

----------------------------------------------------------------
Biju Das (6):
      dt-bindings: mfd: da9062: Update watchdog description
      dt-bindings: mfd: dlg,da9063: Update watchdog child node
      dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
      dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
      dt-bindings: mfd: dlg,da9063: Sort child devices
      dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema

 .../devicetree/bindings/input/da9062-onkey.txt     |  47 ----
 .../bindings/input/dlg,da9062-onkey.yaml           |  38 ++++
 Documentation/devicetree/bindings/mfd/da9062.txt   | 124 -----------
 .../devicetree/bindings/mfd/dlg,da9063.yaml        | 248 ++++++++++++++++++---
 .../devicetree/bindings/thermal/da9062-thermal.txt |  36 ---
 .../bindings/thermal/dlg,da9062-thermal.yaml       |  35 +++
 MAINTAINERS                                        |   6 +-
 7 files changed, 290 insertions(+), 244 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml

-- 
Lee Jones [李琼斯]

