Return-Path: <linux-pm+bounces-24886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BFEA7E589
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 18:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E481898415
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38186207DE6;
	Mon,  7 Apr 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcuoTgV4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90A204C11;
	Mon,  7 Apr 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041202; cv=none; b=dog1YwzrB/kHryQ7aaMtzHRKlvQfaylR/qMaazq7dLFu8lFGXYIlo/4Ye82xPpfKShZ+i9Dto2D6/gYNOlrr652MUtxYpoc0Va4/LExkO+oDZikf3h90/hjMTNNtDamcrwS82Z5i4Ts+sAK0Jvds+8hjv3M2Pt+wSLbB2mqpKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041202; c=relaxed/simple;
	bh=NIrIJzzmdQL32hJN2sevH3JixRQ0+8i8QHBKjFJpt5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f843lp7QXjGM0KgVv3QzOOs0qDCAqrSGCXBVnyMjrivSk+tnBYGFHjBeJU3FeXxI4rx0Vya/gcj5B0QkfPd7v3zZkpiBQfNedtzMa8rTAaOs82DejBBF/aEV8f9QqQEcEp59+7TMrA+b9+b6pKEjoS63hZHwFvf5YwVuulbKOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcuoTgV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B207C4CEE7;
	Mon,  7 Apr 2025 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744041201;
	bh=NIrIJzzmdQL32hJN2sevH3JixRQ0+8i8QHBKjFJpt5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcuoTgV47FXyu6zNK+dq2segR1GdghpPTPda+6XN00y2K+8rJo7H0kIZtgREE8ret
	 xiPrhuZeMJZiNO0f5SgpSU4bn+WB1SwVk9QMgsIRaJZrsRCCJJ5MQq22uaklCAWr3p
	 RCSa96y7/Tjg8eBgeGwWMTKuxoTPQfNUKrnK2m8a7G+FbugClJgP/pzrNVPMRreg5f
	 LGbpzKYe46OlGiCOLqdsWXslA7ZF8zXhprO5LZjFqafFLSBA1Nej6sP1BBnwgyG/Fv
	 xMB7FCT0vP8cSGaTEo3sT2/hSQVdC8tx7eAdlyNlmCuVUTpMigDARSS/KeuyfJ6Zgr
	 CmfeyiEeMcyjQ==
From: Conor Dooley <conor@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	drew@pdp7.com,
	guoren@kernel.org,
	wefu@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jszhang@kernel.org,
	ulf.hansson@linaro.org,
	m.szyprowski@samsung.com,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain support
Date: Mon,  7 Apr 2025 16:53:03 +0100
Message-ID: <20250407-diabolic-draw-200389f7d6f0@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250311171900.1549916-1-m.wilczynski@samsung.com>
References:  <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com> <20250311171900.1549916-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=657; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=n+5hM5kQu6ehBQ3n8017RawWqIN18GKPHpFuSaJtspw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOmfv9w78Ij31uJti0qcPn9UvyjW1zH94RHDDZG1DJ+6X /yfkxfp3lHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJzCpk+M1mvj/LPvDz037h SRO3vs1+a+fS33fCuZm172lyo7OdYxsjQ8sti/PNp0IbLrEFvmBy6Db5KMIf8iaLq0X9ocBlnz5 1VgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 11 Mar 2025 18:18:55 +0100, Michal Wilczynski wrote:
> This patch series introduces and documents power management (PM) support and
> the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
> board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
> upstream, these patches can merge independently.
> 
> Bigger series cover letter:
> https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
> 
> [...]

Applied to riscv-config-for-next, thanks!

[5/5] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
      https://git.kernel.org/conor/c/54fe9380a50b

Thanks,
Conor.

