Return-Path: <linux-pm+bounces-13394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F025A969832
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC268286566
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFD19CC28;
	Tue,  3 Sep 2024 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mq0mmww3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA719CC37
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354187; cv=none; b=dMXR+kGVE/xUeIbostAKWkkp3J7MkA4CQl6Y+eiJbg/oa3eMylPeLFGh1ysCtZIbnllfDq4AuNR9966rA3RYhy1wghpGy+CG37dLfX3GfHaRh1Q4VthddHbi5sgYw/ajU2fLe5Zoa3s6RJ5Q+sIytESL/BHOo4nRJAlwpizPfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354187; c=relaxed/simple;
	bh=k3H1YkyDwhln4REHugZO7lAU3gxw7rVDI3sze9tZ+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzGzWxwB4v/H26FTPEcuwUJC8M68MYMab4h88KXGUhkiMGSzWkiNY9D9X3If7pn6szgR4iq5wq31z6ec5IH1cXBTLLhmbYHyBXcHQJSRAXF+aNE4s1f4T48uip0j3IlJsSL6bz5X7bpIDaTSHYCxIOuix6xePqM0SH1z23Rn39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mq0mmww3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so2404163a91.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725354185; x=1725958985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXMjQRozUzAfZtDGQl5kmRCarCMdJrz35wUmsxbqBGY=;
        b=Mq0mmww3DqSrb+Kk/GVbECopf14ddHCReuK1xiF+X2L6/h5vyfAPltGuo7Bz8D1L0U
         8BlgeURenGgjkxm/swXDL94IiZONr89htHfT+t7855R4sy+OwbN4gy4ZBthLjHM/Mp20
         8VGR1DzV6UTQ6NPv1ShBK/4ng9DMm0pvdY4a6qakGXpzk6TcdwQ0kRl1Ac6aIoZVwJ8k
         eohrBgsgEj18h1upBKM4HR9dIZHlpEuv972jLQitAePIx9/P1b4YAySjO4O3PZH2ftBO
         WW1NMdYUMAKmTu5WGtm5i6zZKE+Wok/sokViGrY2HlWljokS+lsRn9saEz+d//sTLyFJ
         cszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354185; x=1725958985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXMjQRozUzAfZtDGQl5kmRCarCMdJrz35wUmsxbqBGY=;
        b=gCbGBx52IIixcBgpVrSZQclUPjBPzkmGi7VMdGSePk8I3InEY5MRXV6NvaHU45DvLV
         D45Xhbi+tLfkEEE+B6/SU2yTseblmhaQ4oc3I+gGN0ob2i1yAxBBK9tE0wrqj4I2IKb5
         bXvrrmHTY/Jh1mNrS3+PNE/fnG5f6ND3VCCFT+bMX4kM4T/TXPh6gQmwr4Kw3qDSbnFh
         3KsC7/FQIVRegtBXkP5vjenMRAtvoXKBnUL5Qv4eb2klvQjBNOOyojmW1bdHEpMrARUk
         ETHWmYsHE7yXTiIv8xogV1dBNbMmuiB94Bdb6t9H9TkmPP1HqyqF3AyVRkmMT6H7pBhG
         qx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+EkYNuhsoQoh09NSACFfHfWCXkAaKYlyV7lBzjzqSBYxheDHM0T+/ix4oepYyD0Y0M9TpzEKaUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SWLp+8fHPs9bwSkGTzAjpmuiBbN1FZrqN4FzaP1IfBk9uJ6X
	o5Gi4T1zlX00SjcuKWht4pQPKWnX//f4rntkEDH0RKt3xsfvFIo0FgbhR3kP2sE=
X-Google-Smtp-Source: AGHT+IGbzt8vUGrEk6tocF11V7cRb1xoAuI7nhEIChNefDbTXr8mJQYLikgxuEKN2ui2+XiiLzZpXw==
X-Received: by 2002:a17:90a:2c9:b0:2c9:7219:1db0 with SMTP id 98e67ed59e1d1-2d85616ed48mr19057360a91.3.1725354185405;
        Tue, 03 Sep 2024 02:03:05 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da5932d1ecsm1320793a91.43.2024.09.03.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:03:04 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:33:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: rafael@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix the cacography in powernv-cpufreq.c
Message-ID: <20240903090302.j7znk6icmztf3dnf@vireshk-i7>
References: <20240902082816.2599-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902082816.2599-1-liujing@cmss.chinamobile.com>

On 02-09-24, 16:28, Liu Jing wrote:
> The word 'swtich' is wrong, so fix it.
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

