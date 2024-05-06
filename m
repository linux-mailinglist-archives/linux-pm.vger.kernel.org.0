Return-Path: <linux-pm+bounces-7531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924F8BCCCB
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 13:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149CEB21F1A
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC736142E9D;
	Mon,  6 May 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWL82/Xa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D611142E69
	for <linux-pm@vger.kernel.org>; Mon,  6 May 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994772; cv=none; b=s6n/sopiBksKKpyofH40EUJu5BDyk+v2kjhgdqwwqPr3su8aKgFDUa21zSdP7yorVp76ea/oXtyTxNuPLNPVj+9IdQNVDCAAgUSadXnjdjZbsLzZYVhEr3JMsAIEVb0RmPvHoHziKRg6CemvDP3bxriJ34i4BESHm+1gs+Zaydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994772; c=relaxed/simple;
	bh=nyIvye1mAmsLXOpkXDLUu8L+een5qozkaTlT/QXRRxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbT7YirDfJ7sSWIQbPbcjj49quJ9MiR+OMpBQKHhl4yePFF1oJD1esxI0CyvwMMNACJ6AGrkwWxa5mbrTgFuhFaiX7ufppfdYbrDtMDXdElagt8XKOKiT1xBiDRbgRkXMViADVP2fEvutJGbFY9r91wLub9BAIQXLqiakoaCxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWL82/Xa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ba1ba5592so12095595e9.1
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2024 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714994768; x=1715599568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyIvye1mAmsLXOpkXDLUu8L+een5qozkaTlT/QXRRxY=;
        b=pWL82/XalcjwtDKG5w5yIONzOa2tZ6JvaCJlVjkmX2hb1euz0pqLRNlW+QvpKJiyZA
         j+RhE7I1XdMNgPI0zcHmVPAlQSbc99Zg3W6PlMG8CihAcLeDDkm85eC5rMJ56nSp9ptO
         s5lpG96TzqdOG7xx2tEdoVTOrof1JwqsjdCKL1hPATeDxdR5EKf2PvhMCY91TT+iPXEZ
         VTg7S6j7S4zAmFLtQONRMs7v80TO9Pkp0vjbuYGKOD91NRSOYID8mF6WYzVICtFXy8yR
         meF22vygBk6hPaZdcwN1naC/es1M8gjkv/jym7DOcaDWJ8RVCsqhhAwTPTMIDIK21/Yh
         SSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714994768; x=1715599568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyIvye1mAmsLXOpkXDLUu8L+een5qozkaTlT/QXRRxY=;
        b=avfaCck+df9/bz5VtQVhm6w3HI0HtpkfzFLCrMbAzgUb8LYqp7CutnMz5oFWWjfSzM
         EQ654jM4H6SwkQYbKTduXCjBrN55Rm7yJZXXFU1Bx9XhRJIF7vCRpPCvmGV7HX8hg+tA
         gYehHZfJBD+qKj+rN8FshiH9232hx+8jmOaJOW4wubiCESq+UojxaMBfcbweJQj4p4/A
         z2M6hgRLCC7GtwmDSi8ExJvQn7QZg3QBuymBWUOXGb1azf/0Sq4dBFyjScFPLRFt6+Do
         0w1NiafNprIIVoPv3UKlOC4oOQdkVRIosSQs8VPo8lYJhFDBtBTN8bjHqmcj4NpgoAz9
         tLyw==
X-Forwarded-Encrypted: i=1; AJvYcCWIwsp2vUL1+bHrpWUHWZibLuclK6Cvp6V3HwZXAjEf6/AD8lqdfpko5K8BtLoARrThfkgvXnv5SnwlAT6FAT+upppUX7sMkvo=
X-Gm-Message-State: AOJu0YzVwLkeZ3E81614ktkWhWRRZa/Ba4yVUCRBPTyfUSNk4+FuqbFn
	Mk3CowBVYxAuoPd20l2J3HigS78rxCTjGhLTcs07gyHp97/IdJMFoSSsazMHBAs=
X-Google-Smtp-Source: AGHT+IGCR414tDgIBuGRHSWPl4962sZegL04EWcxSJEuof3KPdT1YiHxQPEtdYB4aEFgGMKCWpBjrg==
X-Received: by 2002:a05:600c:3150:b0:419:f241:633b with SMTP id h16-20020a05600c315000b00419f241633bmr9840596wmo.8.1714994768460;
        Mon, 06 May 2024 04:26:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n15-20020a7bc5cf000000b00418176845ddsm8033022wmk.0.2024.05.06.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 04:26:07 -0700 (PDT)
Date: Mon, 6 May 2024 14:26:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thermal/cpufreq: increment i in
 cpufreq_get_requested_power()
Message-ID: <be825436-c310-4565-b902-13b1be930647@moroto.mountain>
References: <a7c1fe73-b40e-437c-8ccb-7b3baad04df7@moroto.mountain>
 <67159a18-3923-4345-bff8-ade49cc769ba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67159a18-3923-4345-bff8-ade49cc769ba@arm.com>

On Mon, May 06, 2024 at 10:41:52AM +0100, Lukasz Luba wrote:
> Would you agree that I will keep you as 'Reported-by' and send a
> separate patch to change that !SMP code completely in that
> get_load() function and get rid of the 'cpu_idx' argument?

Yes, please.

regards,
dan carpenter


