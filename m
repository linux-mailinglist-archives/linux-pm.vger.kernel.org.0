Return-Path: <linux-pm+bounces-39999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E631BCE5650
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B763F3034345
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7286242D7F;
	Sun, 28 Dec 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkv0zfwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740F2264AA
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766949305; cv=none; b=WEBRLtDzexXtGJkfTL4hnM/5ZncpoDKC1Uwsj369TBoPf3PpSaKwFyZf2ce52Xoh+F2rboIV4cim3uojBXvHlUBH5gap6n/yiiMwW1yKcPRqugYFlL9GTo2aj8eIYHai3q/pEdfD8qpvP/7ThmNp6fmwobKhpoWgUp48NTwBKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766949305; c=relaxed/simple;
	bh=uBIi0hmaDwZ1Eh1xO1xknbZ/SbqWc2xbKea2FOtMemU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVtMqekBJyMyd3AnfNomN+dZM7HeSz4dCXZmPqe358Nvpcpy8Ae84xhPFqSGN+hbt2Vp84vSgHT0cficy7fKbj+LKXFRHpPj+GW1fSw7LItQlbloNMVaY5Z8sKWQzd6i2rdH8N4PoapxpD1ctNbCI7cALvRqJszLDYq6OG0s/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wkv0zfwa; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso8313967a12.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 11:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766949303; x=1767554103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHbPrPVl0kUpoIjJEVG9hcK9D5Qj6LFWzjIyV2/9lYE=;
        b=Wkv0zfwahg6iE8yaOoPZppXIoVCtn/OmHGcb8TYFNyi9FTe3HHV6zc1QpfpWBnc2uy
         OpmoQfQD/q3zzOpttAXEhZsRyE7mUaOhAGzs5F5GIRu4/J17mOu5MmDmo7trm3nGmsjt
         tx+UiezpGmDDUCTJ3lPCPMeS9Au8QO4FzYKYTM4inRC+ncQVNwLREE4Y0FiEaW5tEXHt
         MH49SSw5u/jigB1NWSdhr7d+WthpCyzKlU0WPKGmNz1qZVuDhYpFUZ5vT2m7wYLt7EbY
         IHZf1Ku2MHjCSN1l1LVoHtYpb60izAXWh7kSTro629Kw38yFa5FB7uAeJO58dZPo3b60
         2RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766949303; x=1767554103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHbPrPVl0kUpoIjJEVG9hcK9D5Qj6LFWzjIyV2/9lYE=;
        b=FVFsWIhl6bJ3FvXkSKMwS+/4WdQ+HiQq3VtRs9gTKQ8N9NORSxpOPLK9gySLiqT2/4
         TYXWvZB9m9GkkktkFGgP9uechXsnHBsu7EUDkDg/6RNCfmFJ/M8J1GfXWCPG06w6yYkU
         RTbn8hOzKr0ksx4piHmSF3JuIeysrm1SRNsVoX8VSszyevMMdPXCyiPo85yURbUu6xZI
         xsnFLes6H9cNJCiW7zzpIp7xaV86vx8LehhrcyJIQDd973uVeJ5kDnTJCXCwWa+qFIyo
         F1SQYn4GDx3rW2Ea3MrGxEhOnhfKadZDWcdDsyXFn1xnXdKCCkP110WHhGFoMSLZWTeP
         faKQ==
X-Gm-Message-State: AOJu0YwtBOkT36ZeUM5Np5StHdOptq5o/f+2ROmcm/zj6XDIMoPpqO0B
	gIBr8Wiq0pvZyxfiabHpBeNOoOAn+v5rrtxGofdZgYR25G79z8jF9wNQ
X-Gm-Gg: AY/fxX6BjEWtsRir+jVCapkc5EKEwq2MTkqkXWEzqjOJoLly9i/aK2shKUnuEwKw7vw
	Oxvis11H3lhJ2Vts2wKCusd7npjrnU18X+jM7S6qsa+MFJTi55ZD54mTjrySGUxI3jNoEcLJ1Qs
	SFK0mw8xbwo7LMM1NAdxytiWg3VhiGSjXxrP7ZjYt/hHzH0XXITnEJPS321iCnWuzkpY0uImgDD
	Gf5Alg1jt2mJwzyNVHDdA5BfVeAm6RGErkFQE1Z7Cxyd5VHu8KI+fDCa3BpWuS69puiIhyaYSeb
	Hw1Yyt7czWzDOH5/FQJev2kqHzs0ECoa2FrROaW49/964GZJ6Teh7nela2gzjqnqOC6z27PYjGw
	nUCxvcKt7w6ZF0va5SNEut9A0NJvvqrSvNTdzQAadJAXvajUvj4KpAx/lnuGWq81FJ2fwuQb4m+
	Z92vSX5jhmBd0tnMMiGDKcQcqDlMlUFFEg+Hg=
X-Google-Smtp-Source: AGHT+IFpQrSbu8E2FonDBThs/wNXWFzgSUzisxOMkr5qF2hrmWL68A7m9Gi2EfPmMwfr9qHJvfAiuQ==
X-Received: by 2002:a05:7022:ea24:b0:11f:2c69:31 with SMTP id a92af1059eb24-1217230ed72mr27203908c88.46.1766949303308;
        Sun, 28 Dec 2025 11:15:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm105992702c88.1.2025.12.28.11.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 11:15:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Dec 2025 11:15:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 09/23] watchdog: rzv2h_wdt: Discard pm_runtime_put()
 return value
Message-ID: <6b496da6-c6b7-431d-ae6c-34f5f682f944@roeck-us.net>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <1867890.VLH7GnMWUR@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1867890.VLH7GnMWUR@rafael.j.wysocki>

On Mon, Dec 22, 2025 at 09:09:22PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Failing device probe due to pm_runtime_put() returning an error is not
> particularly useful.
> 
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel is
> configured with CONFIG_PM unset.
> 
> Accordingly, update rzt2h_wdt_wdtdcr_init() to simply discard the return
> value of pm_runtime_put() and return success to the caller after
> invoking that function.
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

