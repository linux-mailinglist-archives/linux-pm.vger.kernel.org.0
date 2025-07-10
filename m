Return-Path: <linux-pm+bounces-30624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558FB0098A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6652E1C85BCF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126CD2F004D;
	Thu, 10 Jul 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="IesIWnOL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82FA2797A0;
	Thu, 10 Jul 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167206; cv=none; b=ghzAzAjiwTHNGxn5ARBLvOnlbZ6V+wZOSZQsQGFQrNyTVNs1k9lQM0tRac8fgK7pYmDABomJgDI2J1Rf5DX01zMhhKMQwbVeQd+6gHOyIIT6D73ONl3d5UEHWcKMq5S2M99Kkn6iYPYZie+nC0qZgi4Yn4sZfCVHP/vTi6gjtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167206; c=relaxed/simple;
	bh=Lnosr5H20Dn2haqHWGLlslKpaDH12nnxW/2AdVE7jYQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubDU+ZB1Ejkm5IZfZGhW+c5T9WbK5Qf//rkAGs3Izrxg0KVwRAhO1rV19fbIHkASwZHH6TMZ1LRPRJeRHeFVxgpjF+XOu/U3VXC1s/QKOOrheu8VdXE+kwwmwXoygf2ztTG5wkec58x6agdDLWpGqT41uaGXN1/7uAsSLs+lxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=IesIWnOL; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9DAE43D8E983;
	Thu, 10 Jul 2025 13:06:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VUC382jpjNLG; Thu, 10 Jul 2025 13:06:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F1F8B3D8E98F;
	Thu, 10 Jul 2025 13:06:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F1F8B3D8E98F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1752167202; bh=ksNBoRCkC4yIXct57/Q4A0AkLpVHCvL1iwd3fBezJl0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=IesIWnOLIazWA7URFNaO/qbzZ3EbzgTrvJquBaGpLxLjTeHHByUEsEzK7IQXsxXCD
	 AHLehurxrNQnjuzeHKH1HlNVKzb72JqPN7ZEiJPkrpJCtyx1B7UrvNv6G0mzNbBi7z
	 jIsvlsNhlh7LRcqncuyl/LY4wBXkw+/6BJ40V83bfVqfO2t1rmgOROGEpkiXXGz9ls
	 9EbRXcAR7rD+GgbdE2m6fccKtlUJsfdbXFl9KrurGCS9zemf7THxWInR+qhGVDiGQE
	 x/ocJRBsraPwNekIXtIWEcGgwj6QkeMTxoeE1U97tFlDD0ncAHURTSQf0x1ymughkH
	 oqHDV822Sd3Yg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iTjmdMLDKw13; Thu, 10 Jul 2025 13:06:41 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 953353D8E983;
	Thu, 10 Jul 2025 13:06:41 -0400 (EDT)
Date: Thu, 10 Jul 2025 13:06:40 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Message-ID: <aG_zIFD6IFFhQmSw@fedora>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
 <20250707-pf1550-v8-6-6b6eb67c03a0@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-pf1550-v8-6-6b6eb67c03a0@savoirfairelinux.com>

On Mon, Jul 07, 2025 at 05:37:25PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> 
> Add MAINTAINERS entry for pf1550 PMIC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v6:
>  - Add imx mailing list
> ---
>  MAINTAINERS | 11 +++++++++++

I forgot to add Frank's `Reviewed-by` tag in this and in the charger patch. Will
ensure that all tags are added in the next patchset.

Thanks,
Sam

