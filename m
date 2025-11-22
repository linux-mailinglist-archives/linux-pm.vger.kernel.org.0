Return-Path: <linux-pm+bounces-38399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF8C7D4CE
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 18:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D04E401C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA90279DAD;
	Sat, 22 Nov 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5AfyTpI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17826A08F
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763832524; cv=none; b=OBWv5KagOodEISmlx3Zr+Tm3ZOTrA0hqk3pZzSnXi/n61QIHZUOua/ZOZbSnte8AheO0t+IZ+yGmveM7m6ENYh7pjTUbFYV2ql7aea52g5q4A63Re61zWSBceMzkM0eLHc5cu05sbkLFlzV3CmvdYRg+BNZoSHwqa5cFzesfjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763832524; c=relaxed/simple;
	bh=5MlvMXZYTtR3C+2ukJ2tJbzkGsByRH9qIzQcgZ1uih4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIOgCOZZYZEgpZBWIbvs2pXvCcfheqVaDBu8VjPJ9hu+YXWHTstEiSgObjncNQFLPRhqIW7Z6POpxG5VIMGeH4T1E+VjwASLTLwA9nYBqxXNRPFI73RpOEBkr/DhD9izTJ+e9CM6yoG/lM0p0A/2eRoAL1V0jOqOh0C9YMG5FYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5AfyTpI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ba92341f83so4241111b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763832521; x=1764437321; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5MlvMXZYTtR3C+2ukJ2tJbzkGsByRH9qIzQcgZ1uih4=;
        b=J5AfyTpIqgeULMSs7LwLYb5BdhMx26AhFuqy7086YFy7JJdnMoVBVo1YhJys8YF4kA
         WMOGLJ/rDg4ApWJPCNe++jE/8Hnaa0edMyvX++niezWL253ofUzE15a5W4RTzpRZStrh
         0KHZ3oBDHnwm/NAtDoB7nmfDaEQFvaJV0w4xDIISWgSm1kgLs4QeQJLJ2QyDuKIn1FLd
         wtLn1gFB2PBW3OI47nC2i7rtQRix0S85i8+UUtzooMWqVulLh8fDb7BZ/YOSu95TSk0b
         ZjC3CjrqGGJzPvw1srhDqh6PXeyvYxS0+bdDcrTfbt/N8rOjz49D1ArAYuipNKISkLCC
         TEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763832521; x=1764437321;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MlvMXZYTtR3C+2ukJ2tJbzkGsByRH9qIzQcgZ1uih4=;
        b=uHBm25r+zRt+6wTQ5j7+behS1upBV8K273MmHfBKxpL+cvdUWmiapauWt2U5Y7ryPB
         kwYAIT6V25h1SCeRsYJUYZbsh0XXxaXc1J3gEH9CkJlOxXpI+Zke4AgK0kMWnzpXgeEc
         nUTTo5vBLrxWRCzmTgOhFg34TVxk1tmAaAkKA5lhiURIPKH5KaVRLOoilmM2jjoYqrLN
         7QNDwqPsi/SU08gszPnXmFxuvbmE3Ifx9AdUOTBs7FA/HFMlLeyxmPHglYl0px6lNtSq
         PHLkum6KnzWPIHXlCoNryWZg95D756aXklxHxaFtADm/n8AXyiOJUoTBTKrm0ifIg1WU
         /DgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqp8j2rcYeD290Y81BtkC/el/Jp4erk0jHrkwwh4LThU5h52kVIE34aHKn3rZckaRzvLR9Hfrgzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXybui79v/fofJ+cw7rjPeQ27jUGTkEdd2gsgytw1oNbDY8wd
	0YD1vfkZcC0MhtIMdGf30EjsxMAbAvdDheKD6bGDOevxzhrVHqOI8qzI
X-Gm-Gg: ASbGnctwiIKCtYVMKqYCaa4fphr6kRAtr1vOLXx2MPHwQK1wBbNVBDnpaRYtPK5H0Yt
	piyYdz6rTy0WynL6uVQHH5RdQQJT7T0CFwZgIkzJacHgwxCQNi9v71ocy+juxNW4Rc1aw48/DG2
	eE+vlP6iI0JsgU7dk2zDJgOM9gpp4Vcosbo6ivYs0SXe4Dhg2SoBqR1yiT0KIdo+fgAGjV/ol1y
	qNszdFED+mJ/9nvUI9xFX2RYwtkNKPVznmLYc72gTzJcqNj9v5OddV5mhDuXXB6tbkoahzAG5vp
	2VO76pf5opOYxcP6TGXXK8LmmXqrwHDCdBdnEaz08yFPiy50p98dXWvke21dogeOjbOltUE4UYO
	Hm1G6qPaE0m53HCBTUaGOVfrVVmYH45RzxYhVsk0vEc1kidU+O1pV4khdZ98f01Vk1xSwPEFRga
	Xii3dmmXikpCkEFPq5avatEpQmXQs30lwbcU1hHgIdUb9rZFtiICB8Y4AeXQ==
X-Google-Smtp-Source: AGHT+IHProxUTYxUr7Eg0WsWEkqduy6WY8mRtpWbTz5oJpvvl87zL4seGtqYrXC96lkU4A+SdYOPVQ==
X-Received: by 2002:a05:6a20:1586:b0:35f:2293:877f with SMTP id adf61e73a8af0-3614edd980emr7983683637.33.1763832520673;
        Sat, 22 Nov 2025 09:28:40 -0800 (PST)
Received: from ?IPv6:2401:4900:8fcd:4575:1ad3:3d1a:3314:cdd0? ([2401:4900:8fcd:4575:1ad3:3d1a:3314:cdd0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0243b19sm9534469b3a.37.2025.11.22.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 09:28:40 -0800 (PST)
Message-ID: <96d8ddb6c04651224fc66bca825ba99292fc8f87.camel@gmail.com>
Subject: Re: [PATCH RESEND v4] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dwaipayan Ray	
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches	 <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy
 Whitcroft	 <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, Geert Uytterhoeven	
 <geert@linux-m68k.org>
Date: Sat, 22 Nov 2025 22:58:32 +0530
In-Reply-To: <f8b93a66-c755-497d-a425-c7b4baff5165@kernel.org>
References: 
	<20251117-aheev-checkpatch-uninitialized-free-v4-1-fbee16ffeab9@gmail.com>
	 <f8b93a66-c755-497d-a425-c7b4baff5165@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-22 at 14:01 +0100, Krzysztof Kozlowski wrote:
[...]
> I saw the other discussion and Linus re-iterated old approach/syntax
> preference, thus I think this should also include it, since it is de
> facto a coding style:
>=20
> "Pointers with __free attribute should be declared in the place of use
> and initialized (see include/linux/cleanup.h)......"
>=20
> Best regards,
> Krzysztof

Yes. I am planning to do it in v5 along with coding style doc update

