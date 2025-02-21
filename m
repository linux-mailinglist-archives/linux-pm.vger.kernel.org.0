Return-Path: <linux-pm+bounces-22655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7FA3F7BA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15E21891A1A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C32101AE;
	Fri, 21 Feb 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePu0mX4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5F20E70E
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149523; cv=none; b=k6vhTMOyEHfO9Ce6mDCpWwNHgJRZUtGSn5yqpvU7J21iWCso8J3HZ/1W1teqHshSQX19OGZkLXUhwO9MPbuZxjV0ILhZL8aJg+P+bSADbwS0M1N43S68tLNGobTY6nKnIQ6W4uvFIKis/DA0vre+iDw+sdf3RLchugCuwA0VQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149523; c=relaxed/simple;
	bh=Q83QYgMg9BNvYcSvd+0OOQUvMk1vcqMy7DCAkX3vSsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLSUi6H/aruqkf+c84UaPbq/m3bEjQqv5VYoO+AG5E2e73eEmXmTArGTCwc8aeHspvha6KbmFpZb8wuOc9VBJp5B6C+XR570Eb4FDghVGOQrDmeGe/VwC0+GU1KbuN+WylFHIe6jRL48amowfXPqyXi5q+YQuFIn3TEdWtfps6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePu0mX4u; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30918c29da2so22667271fa.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740149520; x=1740754320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HErEzyWkwZ0RWbaKsVAHI18mvYGkCDcx4TEVCFIo6Ww=;
        b=ePu0mX4uLCR9UaSHS0mKe82zg3BoMIoOtlqJ0Yo7TDSPa2+uI5PTb8qUsr1GatkaDi
         5O/HQtVHKKTrpfNOew6ZpIezyOZumtkpSVeXJ3V0b47bRQrWZVrUZqTSBbIGwQRdBjzM
         fmOLSt3KXeEkk4+05Pkn+AP4feDw2KNNOjcW9aEX8rOxJbZF3sfVhep7pY8RB84aCkPA
         mIx9xU0Q9373EpvJalD5PMQ6X6QdQTaH6A96vJsiHZKKunHjop9ULflDMjG1LgOSvRdW
         40PutE98+etUI4QLKj/1zR/IH21MDfgpQip4A1Km2jxemkX36pWU0+CaJHXnyUAt3K8O
         VvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149520; x=1740754320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HErEzyWkwZ0RWbaKsVAHI18mvYGkCDcx4TEVCFIo6Ww=;
        b=qhnyHbUpFHF/XyKlZFZ/8tEHy1M9BnveqvowY/A7u4LRIiZt6Qfp1HZY0wHq5isfCj
         ww8OK8ezgsOrkIgqRKewi7JF627QhNRriBaB62k22xo3wVAb6mqVv6+vPSkHxy/5tvct
         7IZyx7B3boS35oxAanC/BvgdjHWdOUPkgutgGXQOM+KK2uNjbQlMtVd8kc5DrsYzRrtl
         fK5c7ItlzH+LiYipkWQKXrLevnGbH9fee9dlTBFy3Gv9+B1q8Gon/EvfyRiHsGJObQda
         Nng0RKKwoPVzCY4N3oYIHg+lHQtlhx8ZTKZzyTqcBDgivNA+awIBdmkBeWB9ov7gN4mF
         Xtgg==
X-Forwarded-Encrypted: i=1; AJvYcCWCWcDXfvieWpfS3O429YmHhspbPMeJ5/PbUQ5Ws3K7bCsOkjJB2c2AoA4dnZGpQSvnel9d8SzasQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3rMON/vr0xY924cTDelY5xVXdOQLFih2kYg4LrW+MbJD5zdw
	77WypTWTyOaVS9pAI0rgcT3C7M7v+vcG0XhceS2J1fovihGA8H6ZlbonNft2ilQ=
X-Gm-Gg: ASbGncsMkIOU/6As2vAZycMhBLsTbtoHOtwA4Caj4HyC0frx74x0PUU3mUgjk1pqS15
	EpIbpKtoA2LAGEtA8QiC5cETwve+FMSBuXerBtGojZiPHkEpGrFD5WXEj4u/sM9mPMecrFc9Cyc
	Qi0pVWIR9E5y0rq1Oc7eIoB2ypjnEOYFrkghBl6B6E56xUMWORC8UQYdQOkAkcEPfAD/lC19+pL
	malA42Wc0L3l9kIjoe5+ywXvp/VL6jonGxmrssS4Qs6U7oxJ9aLd0a8giZwQ8H3JPw4HumJye/G
	DUGdUw5zW/pWjOK5feqh+BST2ffjnxGhujyvHCqOtFaXdhW4/HdPa+8zVQ1HLHDD1B6IRfE51A4
	heMyQ/A==
X-Google-Smtp-Source: AGHT+IFNLcfJ7gKB3ypJv7fmqVunoNkPKowHqZRPbtqkqs0FOKNliqghvaJdULQs4XtpGOsuoHAisA==
X-Received: by 2002:a05:6512:3e1b:b0:545:1d13:c063 with SMTP id 2adb3069b0e04-54838ef088fmr1338727e87.14.1740149520104;
        Fri, 21 Feb 2025 06:52:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545317a7525sm2043942e87.13.2025.02.21.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:51:58 -0800 (PST)
Date: Fri, 21 Feb 2025 16:51:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: amitk@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	robh@kernel.org, thara.gopinath@gmail.com
Subject: Re: [PATCH v4 4/5] thermal: qcom: tsens: Add support for IPQ5018
 tsens
Message-ID: <5quz7ulnxvhsafmjxw2ktwfrkqjcnzeao2msfwdhltoz6im3c2@dh2dbczl2qkn>
References: <hmhagxzvumlmzvnbw533ebzilbvknexarsnxjfwi4djq3eabkc@efferfxbxkt3>
 <DS7PR19MB88835F4120912ED00626709B9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB88835F4120912ED00626709B9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Feb 21, 2025 at 06:41:44PM +0400, George Moussalem wrote:
> I've just checked the downstream dts and driver, it contains 5 sensors,
> but only 4 are used. So I propose we leave the number of sensors to 5 and
> adjust the commit message. Thoughts?

SGTM

-- 
With best wishes
Dmitry

