Return-Path: <linux-pm+bounces-4630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431786F6ED
	for <lists+linux-pm@lfdr.de>; Sun,  3 Mar 2024 20:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66B0B20CBD
	for <lists+linux-pm@lfdr.de>; Sun,  3 Mar 2024 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96479DAD;
	Sun,  3 Mar 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+MADzLc"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242E79DA5
	for <linux-pm@vger.kernel.org>; Sun,  3 Mar 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709495597; cv=none; b=YgqgQ2J8Ixf15yPlc/2HMRwXeJyRFQ+xatQepa9dA0+iDqRC5/OlvQRTMktTjRviV0rwLlQ2DEpokZ4nFILozsN/ZIaLkri5w3wC1TJ0KbKYVLnzoptGYIphw3M+zlYBb6kTSWybvIvk69Yme4b8obwuU0DaKXkzY7UPkkGxGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709495597; c=relaxed/simple;
	bh=N8AdG+bpHRuthiZLw9I1zjuqHwMT7szV3BMkquNxpxE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WQc/eD2hFKWla/OoB2allA43JYOlVpLcPUGWT5MD4SbrxcbIhw2QNUy0nkkGZfgzxDfLbsbD8/tRtwp10iTL5jXL1p2uOBKAc5F7ypCSnzTMVhjHwPB/ew5C6r3U105N+4AL37oJJm9c7O2s0jymGkzaudJRQLykoqUCgcMCKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+MADzLc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709495594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N8AdG+bpHRuthiZLw9I1zjuqHwMT7szV3BMkquNxpxE=;
	b=V+MADzLcl8KSbKHvPChtC0mktEunmg1KRlXfyYi5bXXJMlIjebkurgjrJbyh1ZlYVDX5PC
	cb4IrjD4cLMTNuD0VrDdpPmJBcAk8IFLiHoIt5YUCuZ4sh1zj6Sj+J2jShipiMx/Yb7BCf
	Cu/2J8cu2pkYALsk8mSOAxPHx53CF+4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62--1QFypUkOwCRgc7VZXiqMg-1; Sun, 03 Mar 2024 14:53:13 -0500
X-MC-Unique: -1QFypUkOwCRgc7VZXiqMg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4552007ee7so8192966b.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2024 11:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709495592; x=1710100392;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N8AdG+bpHRuthiZLw9I1zjuqHwMT7szV3BMkquNxpxE=;
        b=UP7P6x2MvDkDcjvN3v8SXqc6fqJVe0WfiyPXd2B23OdZirGxD5iWLSgvdnvM/lmwgp
         CQ1NthRipqh2P/u9T9bhMzyFDl2RGe7XJHtSZW8bwJiFJVpilVwmf52DHLBufxj2JfsI
         xJwPtc02vF+JUq64ti4GRZABjyADLElkysQkK113LcM0r1hVwIT6xJSB3q7qUw4geDpM
         jrjSmi/c7iwWhm8V6uuyHInko0rgwgtUR5TOzI6ax+438bBjG4mS2mI/rsz66C6tstZN
         fQGPho2986EBsKcYognQ+uRoMZKIHvWhex/1CE7SWQxP3Y1uhTQzLPUISVtKtvOtnDoS
         eQKw==
X-Forwarded-Encrypted: i=1; AJvYcCUbWAy5nXhuQmmuwiYW5Lalg8t6rF99tLzFIfZ633Sq1mgIyTYD/sKKBydSG4TkSthyVfJ8Id8htOXyeO/ymfCHzJzPV3Z7Sqc=
X-Gm-Message-State: AOJu0YzN9DOpSyiFOc+DH9CAxWe4AMHmdhlELg5QfDKrELCYgoDzielH
	UZrfJFyZ6AElaB8Uo8WE5HMGbizCpHuuI36cRPjjoyMDe/OlwWVCXf8fGRQSQsBRWLpT4dDVJab
	AwFhPF9vQkqxGmDGxFZqVH6oV31B3P8/OdEcLJHPT/0UeOhcTdxQDG3xE
X-Received: by 2002:a17:906:55a:b0:a44:cf37:1908 with SMTP id k26-20020a170906055a00b00a44cf371908mr3025834eja.1.1709495592008;
        Sun, 03 Mar 2024 11:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRoNqehCT/8xh1OvRTbgJ/QangHT/d9acrbziW6l1F9rth43/MHUyDxdKEQKud6wA2jW+Dzw==
X-Received: by 2002:a17:906:55a:b0:a44:cf37:1908 with SMTP id k26-20020a170906055a00b00a44cf371908mr3025822eja.1.1709495591638;
        Sun, 03 Mar 2024 11:53:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gz11-20020a170906f2cb00b00a44cdb21d53sm1980134ejb.36.2024.03.03.11.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 11:53:11 -0800 (PST)
Message-ID: <010ea3a0-929e-4912-ad22-9f0cf5b1a3e2@redhat.com>
Date: Sun, 3 Mar 2024 20:53:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sh@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: pm_runtime_early_init() defined but not used, except on SuperH which
 has its own definition ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

I noticed that drivers/base/power/power.h defines pm_runtime_early_init()
but nothing under drivers/base uses this.

A grep over the entire tree shows that arch/sh/drivers/platform_early.c
does use pm_runtime_early_init() but rather then including
drivers/base/power/power.h it has its own definition / private copy
of both device_pm_init_common() and pm_runtime_early_init() from
drivers/base/power/power.h ???

Also the private copy of pm_runtime_early_init() in
arch/sh/drivers/platform_early.c differs from the unused one
in drivers/base/power/power.h, but only when CONFIG_PM is not set.

When CONFIG_PM is not set then the pm_runtime_early_init() in
arch/sh/drivers/platform_early.c is a no-op, where as the one in
drivers/base/power/power.h still calls device_pm_init_common()
in this case ...

I also wonder if given that pm_runtime_early_init() is not
used with the exception of arch/sh/drivers/platform_early.c
if the dev->power.early_init flag check in
device_pm_init_common() is really necessary ?

On non SuperH the only (1) caller of device_pm_init_common()
is device_pm_init(), so it seems to me that the code to
avoid doing device_pm_init_common() twice is unnecessary.

Actually it seems to me that the entire contents of
device_pm_init_common() can be moved inside device_pm_init()
and the dev->power.early_init can be completely dropped (2).

Regards,

Hans


1) Well pm_runtime_early_init() calls it too, but that itself
is unused and can be removed, removing it is even ok-ish
for SuperH since that has its own copy anyways.

2) With the exception that all of this is still necessary
for SuperH I guess.



