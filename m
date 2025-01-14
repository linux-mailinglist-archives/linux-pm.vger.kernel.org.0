Return-Path: <linux-pm+bounces-20399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A0A1025A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 09:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DCF1887F66
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB3284A64;
	Tue, 14 Jan 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaqgT+oY"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382E284A40
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844602; cv=none; b=rBFJKd1OZkb7vkjNGT0NuTI4zllGxtv80ZImoJOmrM2lZ/+A5AWs8A1i7Sm25vXTQtpOUjEKQmM24HFR1bnaCCn4MZSCnS9n2W5Xeo0hYwlQG21BxIiIYk74ADq8G6YBEjIFs4w/bDUOvsu1u1PWqNGwQEwBl5o1HrFhWXQwLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844602; c=relaxed/simple;
	bh=yjI73KXE1o0v24JdQTFtJedB3AghlGDfi+/rsDjpB3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGaTO3v139Ry8yfjoHiO0yGMZHNzK7jlEvNoTzsCsgl+/PKZAwaMwRH2z8si526DZhh04aZUyc5eM4cCgESkCIFbr0t83I/RRu8Qo2OZYlhAxRpoCMM3qTZY1tKP2J34qJUQYJ/if9tI5fs8g4PsHlnVFlF+EfbJqcRSHYBaR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaqgT+oY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736844600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPh+lL8fM1azGe99o+jyyb0ZHEVF7xd0MdY/zPEIluA=;
	b=LaqgT+oYd+QgksEA0MozlPU+Z+s4Q5jFCQOYk4PvSV3GQm6aDOcKBqJID+NkWul/D55LY8
	Dck1yZHUYNpx/SCl8g+Km+UsO/9+KLwtmcSmztcLKLmWXPmuUFpRtPOcDRO76pHEZ18cFB
	hRAo+Yz3UOmFrtobkSDi+Dp6DJJkFOA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-fWJGdEfHPmS3-AajRrb8GQ-1; Tue, 14 Jan 2025 03:49:58 -0500
X-MC-Unique: fWJGdEfHPmS3-AajRrb8GQ-1
X-Mimecast-MFC-AGG-ID: fWJGdEfHPmS3-AajRrb8GQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436328fcfeeso41803785e9.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 00:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736844597; x=1737449397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPh+lL8fM1azGe99o+jyyb0ZHEVF7xd0MdY/zPEIluA=;
        b=f6Rxe+uwFbH4XfRi67/VXZ1tHODPTWD2OwLTcofkYb31xBxkRzKy+PKRTTYXqB1m1U
         JHtKBEq/4E68eDIIlIdpuw0LFrHUV1P4aI0RBybrsStpbr9iWpazU12It5X6+sCe3kcc
         VUThw5pqKDJxr6caQFkiyyAfai9biPYtH7qSF7fRBON0skl6LhBl1Tx7/uOrCWoEVwt8
         hVXEnLrxHldzmKeYgW46GvA57Mu99VXCBRkstWxxenSZIKzZGn/nOz24PXSdN82aD+DS
         2sXONN1JpAvz5JdY2UgjkkuUVVydYadfgCBOKSQ5nEJWGGCrkTmToz6SxR19s+BS8TTJ
         xXpw==
X-Forwarded-Encrypted: i=1; AJvYcCWCXVQ/WTQs7g+btgxbhmHzliFZd2eQkC2z9M9sK7j+EQ6gEuTycrWW57JSWSgt3bGOMqijJ7a7aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbug2s+9lIzEzOy9LyVX67Lxl4CStRM012o3BPOOXCDJSbPCVn
	WVcUD73Un6t8x89omzpp4QLOVCExtFOU2xmpRjqDfJ/ZPn2Q9gUNPeIAO3woeuJqnneei7s/fE2
	ynkmQJ2qMnT0HX/+kLpNpw2HN4ZCv9Trf810kyv7MQaEqJGh3a7pYVrQt
X-Gm-Gg: ASbGncvxOfhrHqw2UMqUipyDYq2QUIUpjafEH//fXx4xCq09ERBmbGo462/SY9GTl+R
	RoWDcSaU/i+NL59mWo30LTMov4kY/DCuWVimysgAa7o3k6NtMea719YFSE1ij3t3j8uM+boYQ9T
	aPOUMidXJAnSEVfi8iHnWbfrbPi1qDNq4Db/ON38A1T9wiLtjimUilFde3E4Uf27ac6KjZLPuLh
	FiqoepquktJlh582Gk70mcB8rCgkCG8ti1tq86XZ5iy0Mh4+lj5wLWWd/17CW/qBPg4bNZqL/K+
	rlTlxQh7GZM=
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr223306475e9.7.1736844597265;
        Tue, 14 Jan 2025 00:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOIBNjAnXgPwJtVjORPvgQ1GVBYC46pvFjgixl6aysLuqBaKkmhOPJs5mJt9C7n+7EkBny7A==
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr223306125e9.7.1736844596920;
        Tue, 14 Jan 2025 00:49:56 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62116sm166347825e9.35.2025.01.14.00.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 00:49:56 -0800 (PST)
Message-ID: <44a21765-1283-4e79-b24a-fb672399250d@redhat.com>
Date: Tue, 14 Jan 2025 09:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 M Chetan Kumar <m.chetan.kumar@intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 12:33 AM, Maciej S. Szmigiero wrote:
 @@ -530,3 +531,56 @@ void ipc_pcie_kfree_skb(struct iosm_pcie
*ipc_pcie, struct sk_buff *skb)
>  	IPC_CB(skb)->mapping = 0;
>  	dev_kfree_skb(skb);
>  }
> +
> +static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
> +{
> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +		if (pci_registered) {

Out of sheer ignorance on my side, why 'mode == PM_RESTORE_PREPARE' is
required above? Isn't the driver already unregistered by the previous
PM_HIBERNATION_PREPARE call?

Thanks,

Paolo


