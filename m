Return-Path: <linux-pm+bounces-36596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3CBF80D3
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BE554EDFB9
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62734A3C7;
	Tue, 21 Oct 2025 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjDF/Mqa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AB34A3BE
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071264; cv=none; b=FUFc4qER8/OOWIOYctenQG2VjfhpcWuTZHni5hU702KKuOcb/BS+I/C0gCa0wEmEX7fcUCHUU7tgjz70SYZgWIERk5S0U2o17MSGWLFD9k5nIeHlMI/nC4P2Js2/7j2LUV01j42cUZYylmxGnewZrEM4K2DEc8RgNsRmVCgoGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071264; c=relaxed/simple;
	bh=3RjBXAGDusLGx9xDc6Pf9biTKmKASJPpEkqNe3B3qqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/0oKAxkVwODun8J4D8/kiPLSejmv5yQrp/ED7Tt+DQIOxAWnNyGH1QiOTJKEd+59u4P6XrqHfEtaewvslKQatOiLJvGdemrfFKInTSxZRork3nGIIpfyKlqDH56KQ5EbRVQ6xvjD+egm6OmIsVLIWiOIfSbu/LIH3coCWwuKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jjDF/Mqa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so155988a91.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761071262; x=1761676062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HqYzl/UW33J1zC9mz6UdaYFjF9I5n2x84L74tPVphTs=;
        b=jjDF/MqaU5GTQPcB2gFr/gXDPEVkGu8EP0Eq1OctL+/pieLOP1te1UXphA5cmVB9mF
         vwrr/AF5EyNRaia6YwloBstsG8dJRObDmbe/mnFaswYrXHsr4UtsBgjuRwZL1LPDz3Yf
         0BrHoPw+GYuzg/Qycfpq8hWzxheHPthQPTAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071262; x=1761676062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqYzl/UW33J1zC9mz6UdaYFjF9I5n2x84L74tPVphTs=;
        b=DhBNzJfikZikD/x3tc3Wy4PrgvpqAnrgM9yZYvHnd+5dHsKdRMqDaAtaL6k56p+QbM
         bsIAM8V8eD7ah0GxZ/59O4CauYmpr0X2sylrIC+qB9H+AlFCoeTDq0oyG51CESNNc4TJ
         X97Z+OiHkTCLQezYLGE0KrhryF2YrI2Xe3A/LFrCGQUBE0bxzrM8AGP1yG09xO7j018F
         ZR6ruILZuarninXrcEjavUOCvR6N3Kh7BTNWCdI8KlfHUIhO70EoQPiVuPzVvogsgTHR
         iTP6w0Z+Mng8hZTrjb7TRh5UKuCOGURv9BKfZKZa/dnUTKs4TqsLdizkQTt1gyEEGlH7
         HULg==
X-Forwarded-Encrypted: i=1; AJvYcCVA6p8wpQzNcwRPrerHnWamf/NDvBm5LTQWkIp5AFa6ZY3FJgZFqZXKjB26QlCI351bxbO2xzcJ3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLnvmoNx9lWWbvzy0N/wkiYM31RmMvh93O8bJHdgEceqDilrH
	MQO7nFu4+HhGzmqJmq1uM15qGBIam3RjW2BOUd5QQGhz0Se1E9Y/STJyFECpTS+SyQ==
X-Gm-Gg: ASbGncs/qYGWxlSecSYCypBtuJeD0X2QutKTv9YVUj4g82n4Cw2tW8T/Uv/zA/21qr/
	tEYdjnPY/+5/zc7XS9cBxiqkk6BEUU8C1qqKk/3P/DqDODSweDUdAKLabF1/ZK/GxylXHRdTPg4
	yYA31B9P21k/Nsk34tyy+6enZGXYfZ1amVot/2nfJHPQD0PjXiuiLS9TlfzYXOWysafztxSxX7P
	FMpoY3+fk4Pomr4Du4O7J5bj6xrAYW7FU6YajgQanr3Ag/5I1Cp/60puNOY2CklpJFyxEMyzh+N
	IRv7oVF1bLBXH2oCLWkAJrWKaHfs8hehDKuuKV+5zZtAGxTmhAFlhHfm46E0VHd+GpN1GP/3zHF
	0aPrPZY597PJNFwFuPcU+c5qNQdki1VN9o77yHpg8wMXPQBUBVU7wYfx4mezxA7PgLN6uhr4sTw
	FdtjAxmO2geNezoAKv1LWuXNtGug1kYwTqNkeLrg==
X-Google-Smtp-Source: AGHT+IF8cBN5zDoXETXF5lzZV8J3PI7WMOXfoZlFBQttwsFJrfAQjOmOSkixYd7wOfT54VYENlNFKQ==
X-Received: by 2002:a17:90b:1c06:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-33e21ef1205mr1063117a91.7.1761071261628;
        Tue, 21 Oct 2025 11:27:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:e63a:4ad2:c410:7d7e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33dff3adf7bsm1416782a91.4.2025.10.21.11.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 11:27:40 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:27:39 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPfQmy0-7Cd0I9Jp@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
 <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com>
 <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
 <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
 <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com>

On Tue, Oct 21, 2025 at 04:18:54PM +0300, Ilpo Järvinen wrote:
> On Tue, 21 Oct 2025, Rafael J. Wysocki wrote:
> > So the purpose of this "forbid" call in pci_pm_init() is to "block"
> > runtime PM for PCI devices by default, but allow user space to
> > "unblock" it later.
> > 
> > Would adding a comment to that effect next to that call be useful?
> 
> It would be useful to improve the wording in PM documentation which is too 
> ambiguous. I suggest changing this:
> 
> "void pm_runtime_forbid(struct device *dev);
> 
> unset the power.runtime_auto flag for the device and increase its
> usage counter (used by the /sys/devices/.../power/control interface to 
> effectively prevent the device from being power managed at run time).
> 
> to:
> 
> "... (used to prevent the device from being power managed at run time 
> until pm_runtime_allow() or /sys/devices/.../power/control interface 
> allows it)."

Looks like a good change to me, even if just scratching the surface. If
this goes in a patch, you can add my:

Reviewed-by: Brian Norris <briannorris@chromium.org>

A separate problem that sorta stopped me from trying to rewrite some of
the Documentation/ is that we have both
Documentation/power/runtime_pm.rst and kerneldoc in
include/linux/pm_runtime.h + drivers/base/power/runtime.c. It doesn't
feel great having separate variations of the same API docs.

But hey, I shouldn't let "perfect" be the enemy of progress.

Brian

