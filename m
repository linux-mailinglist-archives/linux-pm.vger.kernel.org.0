Return-Path: <linux-pm+bounces-29330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594AAAE43D5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681BC3B88FC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7304C7F;
	Mon, 23 Jun 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hu07njvI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51C25392D
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685329; cv=none; b=cO1R4150uGEsy/AFljAk/m5pBqiD9uMq0q2NrNpgEvglXLzUHj63PCiUYEFwL6Dym9ci+eWq0M7WKlsSJVGuGScvhaS39OCUaY+TilBHfLXYZ6YK1cty8yrYA3+MbHBoBkEl3yGNUrb25xFVbY40rldoXzXxQufc23FabFAdW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685329; c=relaxed/simple;
	bh=CZPIIuiXWaxWEqo7ZUeSDp4YmiojBsPZAXQKWl3KkCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnFxlTeISbgoNQctAFfJqVq0gm+jUUyqxA+jhH0KhB9LumsOsmZU0NJF6hUbUjths+vh8JqLuhILm/WRs4gb2EcbH4CSmquU3iheT/5PS3tkfjsrUAfqdYkhgRx8KtMr4D+KVTwtCI1Gv4tyFVJApU0QkEWDBFp20TFIKWrc1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hu07njvI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so849059666b.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750685326; x=1751290126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghSyw5V7chVdFkoqV6rqSAFiOuBWmfoz7AKlaYMAXyA=;
        b=Hu07njvIsiIncNGhbFEbNmDyJLkvmE7XfyCoxVCc6RzWT4Dn2mJuXl39MxqbvZmZ/e
         QX6XZkzNYOmEOvOVxc++miKA4n+oTx3Jguit8EjVkeLNXdJhkfc9tkjKBWP46C79lGT9
         8Cd/P+mQusfM0Yi+Sr/Uu57sjMd/Ldp8055TVb0zMvZVD/aLOm0LMU8DBDi8MP//qUGO
         rg2NOzZ4kdRqNgQtNyKlequA0++nMXdT+hO/CGrINjl/ishwCHdz6M6sMCVTZoN6kO1P
         fSgWU2Zv8RONEfufXgLwofTN6vb2ep/2ee07RyJwFpbne21Rkhu+9IM2+mgW8GAHeohp
         wbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750685326; x=1751290126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghSyw5V7chVdFkoqV6rqSAFiOuBWmfoz7AKlaYMAXyA=;
        b=GxoUDlZC98+2uf37NTcsUXkYmuUvpm/aMIAAe2rbXtCRMm9Z0GPD0oWhvb6j5k3nka
         EDRdxIJ9cLAKaRGVNSg7Vv/ZJX5i6Ls5h2vix86ulTuk/2XeaSKmXO0lj9/+TIM21Uul
         BeWzKQTDO1j/GQ3+5kDAb26FX1xRDp9zeInlsDpIxRTnO4TzgbQKguykydkzrFNoGlCX
         lJo4qBW50tIhiQTPUjNx7YFQKlVIDCBtM/+fxSamdg1rsOVg7yE/x+IK+KPvdCJ/teXt
         9+DSsu3aEsS3eh6MsT6Mp7Ub0gojnuI9dck/ZdHQT+ZLCEL+zBTersmWqt9SP5qh/Yu5
         RfIw==
X-Forwarded-Encrypted: i=1; AJvYcCUC1GpuL5KjWpidObv3yV3n6wSMVG0B/qk0tx5PjBu1dm3VcpXIHELv8Da7lI+4sHC1ayBAV81iaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfkF8lJNlQ+meEqhydehRp0gPXrmXO793OFu3nYNSjDO1J4VU
	2hcYm0Ut8twJWIa90lQ5vJ/NwtYZZ8z5+vzbRjrLiNvoun12Bm9funmNNZMD5VKYBLk=
X-Gm-Gg: ASbGncu/kGNX32/tbW9nU1xShQaO8eFob0H23to5eoRBCw5cKcp3V4dRnCrV+9s7X6P
	NshYkbArKIkIZheazAalgjPEue9Xqv/0+G18JtOClxdOIcRb7amDIJUfF1yb1RR/Aj+Et5CQ5Yy
	ltrrB718oqJg6ybS7xm6iQ11111cgmKdpJ1TfKVSUWsbZeM2ksfqoY/JaYiJRZvNH+eaKnu8Yqm
	DSm9FVpe1qYTeuelpBvwtosgQUg/2bFi/5Lti2sYBPRgxr+piFyc+fc81mtMyll0WPwOo42M+Sp
	+nz82i6codHOk4MIo3dR5xXiQ4uSnbdUGpYwwdsZWOPYmp+59WotNhw+1aJz/1ESTQ8lD0y4EqQ
	LFl0zz8uyRAiMxiZljvT4MnvfZYy4
X-Google-Smtp-Source: AGHT+IGhyEaOkW0GKZdN7FokWfTGZ3JvH/k1Md47OeKEd3y6barUdSa5bFRlE9UhLlT9Zpp1dlJzmA==
X-Received: by 2002:a17:907:1ca1:b0:ae0:11da:c923 with SMTP id a640c23a62f3a-ae057fa141fmr1230309266b.58.1750685325960;
        Mon, 23 Jun 2025 06:28:45 -0700 (PDT)
Received: from ?IPV6:2001:a61:1376:6301:41a9:a5d4:30e1:2ed8? ([2001:a61:1376:6301:41a9:a5d4:30e1:2ed8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541bc9absm715524966b.145.2025.06.23.06.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 06:28:45 -0700 (PDT)
Message-ID: <4433c6e5-44d4-49e7-a034-aefb9a0ff538@suse.com>
Date: Mon, 23 Jun 2025 15:28:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Update last busy timestamp in Runtime PM
 autosuspend callbacks
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 08:12, Sakari Ailus wrote:
> Folks,

Hi,
  
> This set extends the inclusion of the pm_runtime_mark_last_busy() call to
> the _autosuspend() variants of the Runtime PM functions dealing with
> suspending devices, i.e. pm_runtime_put_autosuspend(),
> pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> pm_request_autosuspend(). This will introduce, for a brief amount of time,
> unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
> an issue. Also, all users of these functions, including those that did not
> call pm_runtime_mark_last_busy(), will now include that call. Presumably
> in the vast majority of the cases a missing call would have been a bug.

Now that I think about this, I am not sure of the logic behind this.
It seems to me that you are making marking a device busy and dropping
the reference synonymous.

Is the time you use to derive the likelihood determined by the start
of IO or the end of IO?

	Regards
		Oliver


