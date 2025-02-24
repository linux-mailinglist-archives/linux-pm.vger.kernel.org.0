Return-Path: <linux-pm+bounces-22808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87255A421CB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BEB3B3E16
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5223CEF8;
	Mon, 24 Feb 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2CNkdl/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEF59B71
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404574; cv=none; b=uDsRkmrvyYw6W6SMo3HDWwjGKXGHIcTUGz7Ham0SHsqsIwBTxHED4a2W8KKkqr7iV7P4xPwSWALm5xHEVLnU9s3x6YPpHIqWZDnXktLYAHl/FwwKxnQToy6PzyplLQPtwsJVJy+kTWb+A8f4//wfg46QyXEarXFu7rgI7pnxfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404574; c=relaxed/simple;
	bh=5mhBn5JOZq/Sr6VtMa/3D4upNLR32dDMAVUAlYfycnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FymLG+fNeq0EU0iZwb9FUBQEhNbosKpulXE4/DBGRaAsxpfviPavcVKJleBR5aJEsrVweNeW/t8imJP+UbFSPEP8gxwFi8eDA3p61k6+zfQ1BqTJUAFSES1nQg3W/Fmq99eqJfSQ9plbjWumhCecSg9YTqj+4NOD1uIKXC/53hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2CNkdl/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fcfso39067081fa.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 05:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740404570; x=1741009370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7IyqSXfcAB07mb16t4JzcS21JNbeSpMHrVwyOTk5Cs=;
        b=V2CNkdl/JDPnhDZQ8jGtzdi8enIFoqaC5Jrlcj3awSqFVzAYaMROtONmV5o+sH+GHw
         mSIjYw01nDxCeRy/LHf0CJBZBkpMPqqL27DqAmwlxCkkU4NATIc62F+UMnAH3giisNPo
         1yhs/r/V5qg8hTvFovRBmDNdYqpy496IMP+9wRI2uhXwnVb6UqSetqBQXv77fBvD0VCI
         g7YPDKggblcOXM+B1Oau0+SqIcuscffqHk5GtCN9SK8+/gW+vWWQngRPXRDGG/fG6aUb
         l0lN7iuo9AQNqcvwSPzMy0QgP0e1elnS8PJvn4x5NANSNuhnLA0eSP79ixtksgNw30S9
         vGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404570; x=1741009370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7IyqSXfcAB07mb16t4JzcS21JNbeSpMHrVwyOTk5Cs=;
        b=X6exzRlbnGW3nxFKVbktcidfZo9wj0kx6sc0LIKBSW+9Uyi7zRoHvA6dZXXcK2T9WR
         v79ADkAfW4PtyhDbM84sv3xdQXaTQxChJknlWzaXD1VOAfu5hIQkNFV3IVc8pIxgSLGS
         4wFo+54aITY+SxJD8wFUVP9k1eKB5EJX6aT3uoW7vPU/Ijxzswxxh4gWM2cQ8jPsQ3gX
         G1a3kvEm35K3bVAKpMM4iDaVNXbnYUExSCkWBELpvFMXW5SLtnW98yM6KlOKH1zVgGBO
         S1DfgFPu6St4un4w2lncqq6/KtIu8kWshtItBwDn2ZtdYZARhvG/Nq+t1Wcy18pAvhsZ
         ylWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdhAWYf5Qe2ewRPe5RVChR8CwEHDioSKlk+wuNqHCrMNK9t+ug2hdSGDgqySE0uTFj8Ztpj2CUgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSlcdgDp3z3G7Tvo0ofNa1ooxf3tupHZ0+qNWWdNa4UW6A53C
	jVZYEXlRgD/z9B2UOpwE9+mDxQqV3ufoLkdHTxfjBk5UEGJmTL7KtXsgFJVsCjs=
X-Gm-Gg: ASbGnctCBEwQlvqDAUmfq51qhTtaTPzcNiYtv/lqZbBdMQLuQvImwSYM1QMMhLgMh84
	oheebEBS8rYyAP6uDgWTTVk2KSVn4jFU47mA4s72bARVGmdcPtaqOZD9aRSRQhA+3XzhHFvVH7A
	iYH/b1bO0TC1T7VtYji1QE/NV0SGV2G7U8dJtVB5n1fQ2hdOJattB+NCyRBnhQeKEroYD0SGNuB
	S+KUEg1Y7W5BpL+KQIvZIslDlbfhHjtqZnne49ZmRC8Z6dVKvdzzyWV1HmXGKLz9VV8f66PfElg
	g7gmTUoPx9D111KTFGvrEvMe+VQXkUp+Owx7Y1/bhFEJ7ugDIUfpNDcHkS/+J3XTQjlxuyH/NGa
	u3r7wHw==
X-Google-Smtp-Source: AGHT+IE48juDZvdR8qHX9mBe7zZT7U1to+JJITpRs1tHbAe0HEtUtfoc3mNnWKiU+vjpJzPigmS6FQ==
X-Received: by 2002:a2e:9f4f:0:b0:302:1c90:58de with SMTP id 38308e7fff4ca-30a59993eb2mr42883071fa.33.1740404570264;
        Mon, 24 Feb 2025 05:42:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091029b75esm36566981fa.103.2025.02.24.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:42:49 -0800 (PST)
Date: Mon, 24 Feb 2025 15:42:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: George Moussalem <george.moussalem@outlook.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	amitk@kernel.org, thara.gopinath@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	quic_srichara@quicinc.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Message-ID: <zygiknq3pldkcdonekzamn2uprnjyc5dip57i75p7uahftekxr@2lqgo3wa6zhf>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
 <DS7PR19MB8883591F0D2E21E62025D2D69DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
 <2fcb52a3-7ef2-465f-b460-2f7b565a188e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fcb52a3-7ef2-465f-b460-2f7b565a188e@kernel.org>

On Mon, Feb 24, 2025 at 10:19:35AM +0100, Krzysztof Kozlowski wrote:
> On 24/02/2025 07:12, George Moussalem wrote:
> > From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > 
> > Document the QFPROM block found on IPQ5018
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> 
> You can send the patches to yourself and see whether they are properly
> threaded.

I don't think outlook world understands the concept of threading.

-- 
With best wishes
Dmitry

