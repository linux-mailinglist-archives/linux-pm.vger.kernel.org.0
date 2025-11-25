Return-Path: <linux-pm+bounces-38621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A8C85E81
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382554E9EE6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7A248F51;
	Tue, 25 Nov 2025 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdWboLe6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173423ABA9
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087285; cv=none; b=LmjNgYI4ctBlLk461EL1q1oarka+x/Ht9zyddLkXHrIQ46vWq1rMH/R/ZCZi5HsIvNDr9t65zQnBuh9U4wmsxT5U04CMkFMFngBATjMmLt4kjOcqq1Qz/a0YsWq1O/q/+1Uae64H5Jy+7bb0ukIB80tBMLPjAl+70U9ErVUYX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087285; c=relaxed/simple;
	bh=7WpdqrsxKc58eqdMOT/GfNUzGo38GTGSCp96a60kVdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNcx9kmIMmiG5duIetJ/L5mQsaGhgxFT5bzJR09q8EcpKNyyuuAIotpGv6ltZDCSwECA//q5MEKCY6Uwsy0lFTiefhyWT+eTg2ZxuGEyjZzpdOB24GYgeUcjBFAAI+0asuRGhNk+AzSl5uMU6YiR/ZVUx+Y54A32NIJ0QxlgQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdWboLe6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29845b06dd2so70753125ad.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764087283; x=1764692083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BS22/Jgjgk8LyIJMs2VxEyscWALwx2agFhzMZn6bbEo=;
        b=WdWboLe6k5MY1+5QgdeV8N6a4a/lw+oAOkLuYWAipkAE4GBPSyYIg9/EULlV/mjob/
         w9rSyJztFdKqDUtEUW+aFDjYAEIKQUUnFlghn10Ww07UI4cst6z4vz0IwXm3/bJqhkk0
         L+KXU63ZNt8UtUMLDQ57O6IoRkF7MiXB6gZFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087283; x=1764692083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS22/Jgjgk8LyIJMs2VxEyscWALwx2agFhzMZn6bbEo=;
        b=ky3EOt1VsfGcY8LE9gWs8s4A1I+C7yWzq4hPIhrFva72jgN/zugrEgw0M7G+owfwMW
         hy0bS4OOUWavUNp0ntp6IN26ZdXjvp0vtqg9aid/NIfQyGy/ZfGeznYQhfrGLTuNLzA/
         pTK5te4614L1H7All4P9JEPrhopJqqpkjxbVnICI15yYbJ/1SYRzzLZpFCVqub6q5BkU
         3+b2dQ5bRjXKkkowuGXUAc965L/oFTzRj+o7wq5FnLjskJzgacE6AzDhYd2/cYO0XJUv
         XGWzfY0QT6foMyiKq7w9h0FbwFm/Daahv028iCmVuhmJkz0ZfFvKj74uHigDcMI083i1
         CQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlsLvw4acrSyhezNWvW6tWYdS3IFW/OBK5Y0gwcYx8K3uZfxzl54Wfw4AMfiOGcrYWpsgu8nGNxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkHF058FPbFq0GOTnTvvt5hsE9jHcNM+/W/YWm4tyYvQTaF/A
	4arrxn3s7McZyIP5jwGkZWITJkC7zdsi1u/FjqvyECeNdCq8wbWat0vNNKca7gVsFw==
X-Gm-Gg: ASbGncuzDOkLXVsR0LtE4PKurA3KyFFEOKIC/xfCQOWKoN5jCQmrl2EDgvr9mKqNh2h
	SePjKRUqWFYQ6OP9Nx8qynQK+SVBtAMKdaQEM19tk1/MH9QoNzdBPyeh3apB2Gt6+GWpB8ojdQt
	4Eetxo0dMrb45DRBjHS63bid53UhK/3BRmsKvbFLtxesEaU3z3SCHJJRw0W23a1l5VyfxV3LFLr
	z893r28HT4Z+e870ei2p3MXZXkfX29RJrs9/Iyq+3hbhR+4vJqXmOZKlGzzTxiBHZtWcTP294nL
	5JqIv+OOqZZepj/owy9+rvobNFWzqCv0eYOQYNz6FXkF01dii6QM20cZX7n+J2paD2+BT3xa8m0
	diFkaDsXqYJdilVT0Yai16GgnGr49XLZzVga4nCf9mesu98VXdP7+bTl7wxSMWiX7SL3mAmh48G
	RSbuS7h2KG4lHd/pI5WyEyepKIbVOTe9DbX5Ur5NsOLzd1WQ==
X-Google-Smtp-Source: AGHT+IHXwLO4qNaJvPVHWCGuBXPcsFgzsSjBBHzxsy8o1WTDGbCMGBLQXUoIz6DkSJEImlVVulsTxQ==
X-Received: by 2002:a05:7022:e19:b0:119:e569:f262 with SMTP id a92af1059eb24-11c9d7185c7mr11638583c88.11.1764087282717;
        Tue, 25 Nov 2025 08:14:42 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:62e0:9ddd:dee9:122b])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11c93e3e784sm61789747c88.5.2025.11.25.08.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:14:42 -0800 (PST)
Date: Tue, 25 Nov 2025 08:14:39 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aSXV7y49lgA1cWmE@google.com>
References: <20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>

Hi Bjorn,

On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> Today, it's possible for a PCI device to be created and
> runtime-suspended before it is fully initialized. When that happens, the
> device will remain in D0, but the suspend process may save an
> intermediate version of that device's state -- for example, without
> appropriate BAR configuration. When the device later resumes, we'll
> restore invalid PCI state and the device may not function.
> 
> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> until we've fully initialized the device.
[...] 
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> ---
> 
> Changes in v4:
>  * Move pm_runtime_set_active() too
> 
> Changes in v3:
>  * Add Link to initial discussion
>  * Add Rafael's Reviewed-by
>  * Add lengthier footnotes about forbid vs allow vs sysfs
> 
> Changes in v2:
>  * Update CC list
>  * Rework problem description
>  * Update solution: defer pm_runtime_enable(), instead of trying to
>    get()/put()
> 
>  drivers/pci/bus.c | 4 ++++
>  drivers/pci/pci.c | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)

I'm wondering what the status of this patch is, as the next merge window
is approaching. It fixes a critical bug for me, and it has had plenty of
review.

Thanks,
Brian

