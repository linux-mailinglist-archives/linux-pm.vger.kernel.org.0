Return-Path: <linux-pm+bounces-13969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F1974205
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EC28659C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3631A4B81;
	Tue, 10 Sep 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hR2Ju+2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53811A3BB8;
	Tue, 10 Sep 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992636; cv=none; b=bmRxkSTcGPuy6jijGNXdJjzwwS4DaHSwedMCT8W+VYFeIHc/u7gu6n/J0DThbpOv2cDwTZyViY12BjjMevRSIEFHSkOK+m18DZ9u60Z9+jBQWcE4U7PrCTyAzHVIh/xTLdqJMpo5bOFZcQR+Xrqy6K8dI3xPRzKaB5Br5J+MRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992636; c=relaxed/simple;
	bh=KpbqArYY4tsxF7f4+5ZopT6L3iZhLbvCXwOIm7Kkr54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skGDIuQCdFnAfdYpz8Xx289Q5eZbobcoBcaQpctKomgaJBkZ8VNEtmdDuIX8H9acOne7blQgEpjOW0O5PObx8dwsTWbpe00cQfWuMfxPRIE7eIHv9lt0r0ZpWPU4DEqQgrZbQyejeMEV1m8sRu0AqQNhJi2TSR45bBpXsL8bJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hR2Ju+2A; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tJdvoX4bYWfo5nT4U9dcgC8mgoUNfWu0sO6XHPGd1zo=; b=hR2Ju+2AeJ9MOJGCVR47pRYwie
	ffm9GBt5O1fFqMqIwTtTp9ek0tkDzXKASo62F5d9IDqt3D/a1Sz09cgtHSRM7WNWq55sPb7Zg7Tq9
	Xz8+xzv3aICvO1noaO9sq+P464H6zDpYoJqxlqiRp/LATrndaRZMD7mSF2kVNq5yX+2vGdzX4tgkJ
	kznImmhVFwaQFgfoVVFbS8NK58cNh31dkCxiMVQvnQf60TnbWibn4DlA9jn1T6X7pgy3fVMwmdMR2
	p8AbOCj1qFpj2X+oKixYUXv7R5vNfrxOwqC84ppnUNKPeP+ZgDbflxzNIYRcCZ25iwM5Alb9CR3MK
	G6m9+G/g==;
Received: from i53875a02.versanet.de ([83.135.90.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1so5Wn-0007L4-6C; Tue, 10 Sep 2024 20:23:49 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject:
 Re: [PATCH v1 3/6] pmdomain: rockchip: reduce indention in rockchip_pd_power
Date: Tue, 10 Sep 2024 20:26:17 +0200
Message-ID: <1787473.G7SD5HZVK5@diego>
In-Reply-To: <20240910180530.47194-4-sebastian.reichel@collabora.com>
References:
 <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <20240910180530.47194-4-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. September 2024, 19:57:12 CEST schrieb Sebastian Reichel:
> Rework the logic, so that the function exits early when the
> power domain state is already correct to reduce code indention.

				indentation
both here and in the subject

change itself
Reviewed-by: Heiko Stuebner <heiko@sntech.de>



