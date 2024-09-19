Return-Path: <linux-pm+bounces-14496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39EA97CE59
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D081C22A9A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0413B797;
	Thu, 19 Sep 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Did/+k3+"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39B13C682
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775941; cv=none; b=Q8Z1A+Dui5Kw4qe9BNrVd4o+0JvwLLoi5i9AjViGHDdZHzjrwjyKOkFF8bMEFn7fuDnPZWhNb8pPJ74Fkk8inGKplxGHN5OVHhJZmnuI4OruqemVVWHp2dFnYd9FQBRpDj0bGoTyjqlSJODm/wJLF2O1uvc5qSFzveZ3vkMCDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775941; c=relaxed/simple;
	bh=LS7GkpmgUUdA1yoEbHbxbJFO3tiZMC+glZfVX6Vn7FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJfMswB70HVAo8cA9Z3B69zdPGM0LKS2UVGh6B/YGwpwz6ggOlVqi5GyseGz8Bejzkvz6lwleyHq+Jf6mRHRvOkqL4kBZeEMCefek/x8UTV7+j1/BVqF1VOmrjoZWDivr4xThIf4fIPNu1TuQJ9aMpdm9l9r372CwapYR9UF0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Did/+k3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726775939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uw3K7ykFF44drs9NAs+jCzR3haQI1c688j5wvgISOu4=;
	b=Did/+k3+dPRkrvCuFqhJxz3Djd4YNq8ncObitElQUrbuXIGEEF7wXSpeVI8rRHObEhbCSC
	r9E9U19NDgUli2SufOwSlIZesht/rGRqv7SBNvdi8vUl0HzeGm+LR/VI3kXhbTq3jAVwYl
	wk4n/o5dHNcUfI9K/4Nw+jcYadN5CC0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-U4lI4GPAN6SxIG4nHJTujA-1; Thu, 19 Sep 2024 15:58:53 -0400
X-MC-Unique: U4lI4GPAN6SxIG4nHJTujA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-718ea25967eso1709995b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 12:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775932; x=1727380732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw3K7ykFF44drs9NAs+jCzR3haQI1c688j5wvgISOu4=;
        b=uqrE8vKAXy1oE8NXlELj2K/xYsqOjeli0KWp9FfTC//MG8ABTjckDjMWtyhtGEuIOE
         wHsquvnp3JwKJsmKLMdxNsjVN026T66JRV9A4QJX/rwF27UVqmyU9oZhHkcWTWfkLxQU
         SH3ViEwAbvZH6XjYqc0dsNiWrPtsRAIgK4JdP+rUclB1HWEh+80RCnoW6h735IAsbIKa
         3Y/8j6hGOsty2JsOMJuA2lfv0lgWe/oJ0B4dBhXRIV+AbBC6ImCRMKEfvLCuCxJlcvOA
         NvPRq2/s0hF2Pk9iGDqQSAtPBB3/O5D7RxKgj6afL2OJ4EwVnmJ04RwA+L3YfLqkCBJW
         4mzg==
X-Gm-Message-State: AOJu0Ywpmfx9tir2L5ovaiSaakP+p+f1FENTyAGhyR/PoLKPRCLaxfK8
	2oRZ7QRdMVElvgT9QwY91JfgCQ0fJ1iFgaYVe+K86AXQ45kn2cFEP1HYjzokgTH9jRstdJAc8oL
	xmw5/wMjHN0AkLQ0UC9ciwYDDvQsn8gJS+X5pfFu1oqu+v8WOnY3Jw2/r
X-Received: by 2002:a05:6a21:3984:b0:1cf:5643:459a with SMTP id adf61e73a8af0-1d30cb6ad31mr234151637.43.1726775932254;
        Thu, 19 Sep 2024 12:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQb6DGtXAS0Y/S6hSYcohhBKcUqxpou8n8QoeC+t6JtE14DWnS9KfuoX0HP7jy3GAxCNx1eQ==
X-Received: by 2002:a05:6a21:3984:b0:1cf:5643:459a with SMTP id adf61e73a8af0-1d30cb6ad31mr234135637.43.1726775931965;
        Thu, 19 Sep 2024 12:58:51 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ab85sm8950434b3a.173.2024.09.19.12.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 12:58:51 -0700 (PDT)
Date: Thu, 19 Sep 2024 15:58:42 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] pm: cpupower: Clean up bindings gitignore
Message-ID: <ZuyCcs67swgQpryP@rhfedora>
References: <20240919180102.20675-1-jwyatt@redhat.com>
 <272b9839-f2a0-4090-be41-cf0ff8721808@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272b9839-f2a0-4090-be41-cf0ff8721808@linuxfoundation.org>

On Thu, Sep 19, 2024 at 12:39:01PM -0600, Shuah Khan wrote:
> On 9/19/24 12:01, John B. Wyatt IV wrote:
> > * Add SPDX identifier to the gitignore
> > * Remove the comment and .i file since it was removed in another patch
> > and therefore no longer needed.
> 
> Don't use the * in the changelogs. There is no need to write this like a
> itemized list. Simply write it as a paragraph.

Sorry about that; v2 sent.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


