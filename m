Return-Path: <linux-pm+bounces-40141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D592CEF3C7
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 20:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC1A3011EE6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA7221555;
	Fri,  2 Jan 2026 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psiAu23t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DF35957
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767382287; cv=none; b=uWs3MCdmKTG0Na7B4ToouzK7pTSVnbfMRf1LiPsBR0NCGPlrjUpXGZR9YfZ6624KPiZoGsrqDjImhPf1Qp+3TVI2D/ZeNjzgRyFthv3jt8ifYUmMn8tLbPIzX26vmLrnc7r8mZk0nKDn8vKjsp4agGE3GtlGuk0AexerJhdsDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767382287; c=relaxed/simple;
	bh=rKr4ax33AzkFv1WKIWv+9pxOC/JSanUEqJ1fShzOIzM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RbUlSe89rVADZ12oxhCPr5WsW40Maffy8LhAKqiBthjPsBfFPKxPg00wfHakUj/PP7c2F/RqEYz8oGn94RsEs5Ef9XOBae7kjkAL6a1CyKqD3WdtdgqUk67R6/xD8cSORZ7Hsu6Xnp9qyh2TRLxjKWJGtmQS0KxGxVkagpetvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psiAu23t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C14C116C6
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767382286;
	bh=rKr4ax33AzkFv1WKIWv+9pxOC/JSanUEqJ1fShzOIzM=;
	h=From:Date:Subject:To:Cc:From;
	b=psiAu23tqD5JabwgEV6O/N1S1RBKunz3Bb6si+VaN5VPYhMCN4YA6T5Hk4GL/prgt
	 bHsbEQRfzMm36Q2/qBjJ8XKxLSP0l+er2vLRG0cNq37wUCcs4KONgvA9JvQR19vLY/
	 vaT68eYUM587C54akjHVH8aAgFjR0Ek7Jz4BrL7UCCMM6SW36/DXosMoZurd56eSXS
	 s4XrkPC4eQluDRavvueMCC4lgvksX3xjTDVgtLLdtD7gWah/M9YoPS7smn0LMBsxRM
	 jDepqIb0aiOtLVAPS5IxkCrklwJX/XQBP1HsKrsLQAskyrCyG7VB310HI6fzcijWz1
	 IMM3+z0qdyzKg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-65d0953cd49so8163069eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 11:31:26 -0800 (PST)
X-Gm-Message-State: AOJu0Yxy/p7gvYTsrocc0q2rbpmXzlnUhkfjxs6rOuGYqxD32eqxIHNR
	d/pbP5mFLEKM2jY1CwwNmVP00aOV+DCUYl6zsZKQWav22eyZvNKZdbvDKxU7HItlcllCHg4QylH
	quVgms7y7g51j2u2riH4ZX275ebKAeJk=
X-Google-Smtp-Source: AGHT+IHpezbOEUXsaAo0TNr/eE0d2/r1t4fDIWKwc5n3s7H5lYC1hgiHH42Cu1vl1quEuHJeRtc/LjeEJNHRGopMOT0=
X-Received: by 2002:a05:6820:1519:b0:65d:c79:8b87 with SMTP id
 006d021491bc7-65ea034552dmr17748700eaf.5.1767382285655; Fri, 02 Jan 2026
 11:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Jan 2026 20:31:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjWY+0MY4sJ1=jHcDzAkCEPtDROrZMdqtx2Qws54svQQ@mail.gmail.com>
X-Gm-Features: AQt7F2ota7hqMqjFA_pF4Iq3Q-2Zz5EK849NKBlAuOMKKjFx4qDKIUhH2Ul6nJg
Message-ID: <CAJZ5v0gjWY+0MY4sJ1=jHcDzAkCEPtDROrZMdqtx2Qws54svQQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.19-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.19-rc4

with top-most commit 684d3b2670a26313bbb99de6d66f384ac0e31c9b

 PM: sleep: Fix suspend_test() at the TEST_CORE level

on top of commit 9448598b22c50c8a5bb77a9103e2d49f134c9578

 Linux 6.19-rc2

to receive a power management fix for 6.19-rc4.

This fixes a recent regression that affects system suspend testing at
the "core" level.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: sleep: Fix suspend_test() at the TEST_CORE level

---------------

 kernel/power/suspend.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

