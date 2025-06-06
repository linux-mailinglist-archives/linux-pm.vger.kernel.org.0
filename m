Return-Path: <linux-pm+bounces-28191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB712ACFF6D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 11:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE63B1C22
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2728688A;
	Fri,  6 Jun 2025 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alJUkdZE"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1722550CC
	for <linux-pm@vger.kernel.org>; Fri,  6 Jun 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202710; cv=none; b=QhyL5QwloumR3+6DEUoFlvk8B5MdWAN/VM8XGLYPS6DOQIypuAFJQxx95t8eEByQIBqrMY/Q6pnakVxsA7H49ZQxFmLoDgWT/VGCrqDn767ub06umCk7dZd18GtPczcJMX86D74sqSN5DCde8cmmKy4bvzxhKQK4/I1cL3jpACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202710; c=relaxed/simple;
	bh=jZh8jvo3lyT78zBIAuub14qMFwnpBif3VNd4GueNpac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/S/tnkPRf9Pqwjys26iTd+b/7anxXKK/ZZQcRTR5PsLg855VkgVmWBIo68Ja3J2dmZ8uXY3vfex/sXA3wUul9bXV4xQA8tcWziemqyKzT2yyHoDkDMwsEhxppPrdfBLK2Q2HesbelGeb3ox9CqEusUXK2PfQRC1euFS0I95lew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alJUkdZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749202707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26Ry3YWNg+Xx3lprVa5lk9OAapvgIQNkgZHWX4BPEr0=;
	b=alJUkdZEXXNer9Npn/vtBQg5TUtcT3EGNeFZ5DnjBMAtFeDsecnotY7fAjpU3FdaDE2sf6
	EGw0uUE+a4D47w3P8teknWgAHTkxxNfswXv3oXSjpAZcMOdrd8NfTohmU16neaNuXax/gK
	xV4/xxdRkIIBP43bLklakXaidO3EU14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-4dRMsLOIPQqHKzPxMNYfnA-1; Fri, 06 Jun 2025 05:38:24 -0400
X-MC-Unique: 4dRMsLOIPQqHKzPxMNYfnA-1
X-Mimecast-MFC-AGG-ID: 4dRMsLOIPQqHKzPxMNYfnA_1749202703
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4ee113461so764206f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Jun 2025 02:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202703; x=1749807503;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26Ry3YWNg+Xx3lprVa5lk9OAapvgIQNkgZHWX4BPEr0=;
        b=XG+X/1bwxx/Kw6hTD2bce7ui2A/cA+CbyAKSTEimqYe2KoztPCG87IaTnd1QtVzD+F
         7imtDWVgzCOM09Neo5lMaSNml/qsNcPPXNV5sg5bIcndFJ+Ap0H4lABFqYHmraqL6USH
         Yx8vMcsFWs8L2TqLw/c/cwG/oBNyTqC9dEq+qgznz8i2Pi75qQnOYIHulU8M7MMbQzcp
         cVoRxshTv7tGsUYrFN9LferrGhFbIoAGorLXJ2g5U0sayCJfR/PM2mK3+r3QjPMa3Qhd
         Sr8MTSfmZgLnzpLzNy7v7pB+SgLlvp7tRm3/ZkwMOBiLazVm1df+nWY+lztZtsAAf+09
         VMIg==
X-Forwarded-Encrypted: i=1; AJvYcCUI5sKmHIp5TDyHO/qk63+mnH5Fsy8Akp6RaiHgAG0UfBIfgP/vHcaoiOWeUhWbASfWeffXC5dbvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF31lhFHaUg1rSz3pRJgu1vdDd89YxxUx0HafwtKpLXUV1x3tf
	zrC7PDVQCRE5FM/a5tUqFpAhSiwl1cp9ACtU7O3UWW/qHGmU4FahymMEEufKVUXkV1PtcOhnlvc
	yApgHzx3YN+68MJTvYAUlv/B2RXKMMaTrmYXKcTe+sMXS+eagaT94/fJjCK0G
X-Gm-Gg: ASbGncsr0sMI9tUBSYduX1T+35Q+ohSKRcOuZPsB72ME8AKgEIkMWhmHDaC5GjuP2Px
	s4KiV85rW2cPzj/mk14LXLw0efQw53yfxcZH0pkyjbaps3M/7cbfrBLRMafXX1SL8TA9eUZ/kaC
	Y1ItR+lOG4ttnMgBdFpm4KkeRp5/g9vHL/NSQcVK0NgXfy0mOOCdAzyc6FgIcxkV3PWIS1/1rcp
	4KRkOUFsup6W3RmbTdfFOMef5Yex21M/OpYkQuVVWMS1fGC6cJBmhqNJA6qJLcsqQTrDuuFyugO
	bP5QGtXDnenHS3p+EjUoAQQnW+OxYgAPhJTE2HfESocFyurnSP1StrhAFayBkahQ6eMaeATLOIa
	XudVq
X-Received: by 2002:a05:6000:240b:b0:3a4:f8fa:9c94 with SMTP id ffacd0b85a97d-3a531caa070mr2442147f8f.13.1749202703117;
        Fri, 06 Jun 2025 02:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2hgVVQ9Gk7GHogece0bM9/ZswNLeykZTGpNB8vcSGMUSbHrTwRCq1omPf2ID9eCFShi5YvA==
X-Received: by 2002:a05:6000:240b:b0:3a4:f8fa:9c94 with SMTP id ffacd0b85a97d-3a531caa070mr2442120f8f.13.1749202702694;
        Fri, 06 Jun 2025 02:38:22 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e056122sm15416265e9.6.2025.06.06.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:38:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: remove code clutter
In-Reply-To: <20250606090802.597504-1-lukas.bulwahn@redhat.com>
References: <20250606090802.597504-1-lukas.bulwahn@redhat.com>
Date: Fri, 06 Jun 2025 11:38:19 +0200
Message-ID: <8734cddxbo.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lbulwahn@redhat.com> writes:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> There is no need to introduce the boolean power_on to select the constant
> value for state. Simply pass the value for state as argument. Just remove
> this code clutter.
>
> No functional change.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


