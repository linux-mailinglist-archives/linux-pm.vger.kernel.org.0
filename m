Return-Path: <linux-pm+bounces-15357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9A99562F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 20:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CD31C25661
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8D21262F;
	Tue,  8 Oct 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="a4DHs6Ha"
X-Original-To: linux-pm@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347A139587;
	Tue,  8 Oct 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410948; cv=none; b=vEJHmmiEj12GJcralIrogtNgc0fpH0EJMzAv/YfRUA8u760lJ3LkZnzHuAuw5e0gLyUSRkaxZTs2pH4ZwmDCXLHhBD10Xk5AZ0JVwl0YxImkt7l1V1ykvJCrlx9lfkBY683mOl2RqVR4p6MXBwWrFUvkm4js/4LshqsxQfosl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410948; c=relaxed/simple;
	bh=SRNkTxxM1vPLx+kwHD1EDvBg+ML8QGlG2cblvhEIQq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpcOCrtQPekvGniMICH8RQVBODEZDPwJfNZbXxVHYlSJ/DG2jKECl6lQjdEQhPDrIYgzk7/ew6AGY9vuuwWKuzrBek0Hwsnx+eiYzUV0SWVv3U2xPVEkESQZ1+LzGCNeg64XWn3pdFaplpC9ZWjxuz6oZMafxT+dTJtRohjkmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=a4DHs6Ha; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNPD15zS6z6ClY9T;
	Tue,  8 Oct 2024 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728410940; x=1731002941; bh=2lkWYtnPI63MLIiTQSgMVVz/
	sT/tHkUhdRp9WuQ8oFo=; b=a4DHs6Hajgb0x18wO1l3wug+QvsJz8yJJu8jz4lM
	tfMzv7Pm9wuqW/dfCm03oHGTMzvavdfpmYUDmF4kG3o0wzZRX8cFlxg+PUGwem9J
	JYcRe4HlaeGBGCFzPqGlTrsCVB8ZNW9HXqy2ZSEIoazCs0Y8YezIQsz9OSQcL7+u
	lZiv9bDxLIUQEd0OWioDxNFTvKAl4yeuHqLQMIAjvX2+fqjmEdAWF9Vc3SB22dQH
	fwZFUJIiDXRBXxbn7h9EuJn9oD0yB1dLLRRE7H+lmRY1EpjAsqDy6u9u3lmt+PVg
	Oawmj7o/gGmNsosPrvDO1dCmh8zqyrh9VA/I51OI9cKwkQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cSgM-UPnMHOQ; Tue,  8 Oct 2024 18:09:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNPCr2v1Xz6ClY9M;
	Tue,  8 Oct 2024 18:08:55 +0000 (UTC)
Message-ID: <683f30d7-ba8c-4072-b4a9-70383052bb49@acm.org>
Date: Tue, 8 Oct 2024 11:08:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] scsi: ufs: core: Add
 UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE
To: Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
 linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
 <1728368130-37213-2-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1728368130-37213-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 11:15 PM, Shawn Lin wrote:
> +	/*
> +	 * Do dme_reset and dme_enable if a UFS host controller need
> +	 * this procedure to actually finish HCE.
> +	 */

need -> needs

> +
> +	/*
> +	 * This quirks needs to be enabled if host controller need to
> +	 * do dme_reset and dme_enable after hce.
> +	 */

quirks -> quirk

Thanks,

Bart.


