Return-Path: <linux-pm+bounces-27131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0AAB6911
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 12:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB881B64AAB
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E72741B0;
	Wed, 14 May 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ee+kKI1V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2002741A2
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219412; cv=none; b=bLnFbdLfDSp19dxLPq6VR+jMF0V7e7lR5uQmwjpCY9v6uWi73nhBiIjGvAbobRVbIHGIryQjP3ArbCVvAF3chQ8ny1umAnslxfhbHV3EAZ+D/M8zhtHzcYRlTfMx0f06qXLyXSPhOxw5OXjCj+lh+lFdEGerznwyFIQkYHtaMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219412; c=relaxed/simple;
	bh=icczPrIZYGv2B6Fk9mhsXabLOVp132e36d3tOVpTinM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN2VKXPvBiX7GOR9tfJRnH4s5ZmWEcweFAAd/X7w6jdJ4/j+1L5QlZHuSDIXfic2rhsZmrjbe4zUIJegUx4ASF9eyqcjWxzo7WPAzufO0QluVfMKCKBz/hbajwAGCZy60t1qJuqAu83qtJP0XuC5Xv2fX+qaGo7XnBD05l1Ai80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ee+kKI1V; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso15988045e9.0
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747219408; x=1747824208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0KB+309i4RxjvcykFikT0JnK/+6UeZWOdqeF0dxsBa8=;
        b=Ee+kKI1V8Ie7cwPlwgEgEXL8958RQNtMbuyDHfqDse4KK6A5TNQEdv9YRspPThzwbo
         2wyt+ExFSSHFlp26WXuB0daF/T5Td9Yat50Ut799M3HY0h4FblDxfDW/RAzbqZgF+59o
         uvWhYocUNrif9iGnUKlcYPHqkYfXLqmNQ8axGx+nRYUABgP4j2kLdD1bdbVdJELzM1cq
         lMKvbcPvLWzFGMyrf5pEV+HmpIoXhwJktNBSHmzyBxUoUX79D7vFJjc47VN2tfy6D6sM
         GTT/lJoUlvMbNPwMB2+F3jy4eXkNWxJisFLhyXOBYd37pEXHqwbYjsjUSUWyQM8DO45B
         zH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747219408; x=1747824208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KB+309i4RxjvcykFikT0JnK/+6UeZWOdqeF0dxsBa8=;
        b=OjHhBvL0j5OZlCqYkOI9nLde96/HkpS4R3VrMS0aEh8Lddy10T4HfP2G/Gv6+c7/hY
         BZ7y8ygijT7wNEbNPFl4SPKXGypS6Tfi0VV5nz1Eh4zqKheaXmDjsLsolTO/mYxjgi+Q
         k+IpCUBZMB7R9ynT9zNHRM5vvfO4qPKigNPaMYwMiVC6n12+oIsdN8m754j4/zQuo3JG
         734o17Eep3HHEH9wdKrWIn08Cjghjil8VabXUeuE6THzu4tH+21US+6XmxhfW0hATo/E
         u0X+6qF7r5TEdMdT0eNc/m2G+5BDCcGVB1Bisqbum6R5TYW289DpCJfvLlnHYVk9cx40
         EFfw==
X-Forwarded-Encrypted: i=1; AJvYcCU3vQ9iGevsW+3VnTw21UF6Z+pH530Uh6HHSt+VxXhmA/VS0TCUhi+6Vve6nYDdEbKANQLk5xq8eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjbUocH8H6XLWbMR9E/CHNsV5xmssKIY+JuLd7I/3vL4AGhp2
	ulC+KxO1Z137DSWFE6PGMOx+rgQNlx4BIdMKacpVNZlMBrpHkq1RxPDYVwDrdQc=
X-Gm-Gg: ASbGncutF0wW+gIJJ+7XdxWGKoT19j/c1o/C3K+gAMYNjuwsOnvM+k/GLQzZG9iIaKh
	apkbMyRZ7ofKJEY3Md1tH9/QyLAc5J/tdFIGKH/C6Oyew3IYs8nPCKAhM3Zu+43SZgDHegNo3Lx
	gbq3ft1NryXfxKBhFPaMK0zLvfcfhRSk4xQnYIHaxkWnqcwqNXYTvPMMMy/6biy8CPCOXpdVsJG
	aTh627hwdvtwgyUgfcCfVDQk8gir88vGWVc+5/inCFY0l7n4k+UrKiPTFhIvp5dsnoCWw+D5YKC
	nB26VmvgS9HcHFr1xeg6WmNZbomM0aluv8QAlVYEEiiPMYQHDQkKdEc6qm2aZ6EyS4ezxzhe2c9
	xAnssiOYvIuDSMw7xHKPrTlOH
X-Google-Smtp-Source: AGHT+IGDzh2lHF9+tgixSkp4osRxuBf88vHe1okOKr+0ee4IX09GyQKbdwfBSUBsbvD4311dkhuxWg==
X-Received: by 2002:a05:600c:1553:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-442f2168bd3mr17922085e9.22.1747219408117;
        Wed, 14 May 2025 03:43:28 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f397b6fbsm24822375e9.39.2025.05.14.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:43:27 -0700 (PDT)
Date: Wed, 14 May 2025 12:43:25 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
	thara.gopinath@gmail.com, dmitry.baryshkov@linaro.org,
	robh@kernel.org, krzk+dt@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v9 0/6] Add support for IPQ5018 tsens
Message-ID: <aCRzzXkd_qWuN3Fo@mai.linaro.org>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
 <DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Feb 28, 2025 at 09:11:33AM +0400, George Moussalem wrote:
> IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
> and 1 interrupt. There is no RPM present in the soc to do tsens early
> enable. Adding support for the same here.
> 
> Last patch series sent by Qualcomm dates back to Sep 22, 2023.
> Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
> and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
> confirmed this SoC is still active, I'm continuing the efforts to send
> patches upstream for Linux kernel support.
> https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

Applied, patches 2,3,4,5

Thanks!

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

