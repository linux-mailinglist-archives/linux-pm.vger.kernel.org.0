Return-Path: <linux-pm+bounces-35813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 676AFBC523B
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D84E53FF
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049726D4C3;
	Wed,  8 Oct 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qt5WkABl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FB275AE1
	for <linux-pm@vger.kernel.org>; Wed,  8 Oct 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929046; cv=none; b=VXweaJRkgFo9qhP4bmNrDmXs+MPaZcCq5G2As73JCwNecbD78XWWWpq0wJ5tzg+idhisaDfPNQUYhOGEK15yNzkvngaE96iBsVOWClmQ/e+S3LwX/TICDcM7VSXi4pUPp8F7wkAPfqEl/A6eJUrXVPr+aX75fub6oq5Jw5qura4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929046; c=relaxed/simple;
	bh=bzwdPAuM8Rz/Bvizjj7IemyxtXu6fMaEk02nQJZstYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALviU0kh55bBbVK6E74YjOvkY56wG1gn7xBM6Y7at/jCh5xdNVpQ91hOMHxF/whHWFrLyo02jyjBTvbIoHNxAuGrBh2xlSEDUSlCUaOiBnTLSW+Zxz69RcksvTp/mvEJxu88mtHtWkQPDzHnha2m8sEJo24dUF8nyY5OQMxYomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qt5WkABl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781206cce18so1065570b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2025 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759929044; x=1760533844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzwdPAuM8Rz/Bvizjj7IemyxtXu6fMaEk02nQJZstYQ=;
        b=Qt5WkABlK1xlksYE+WbyFB2oYorVn+YS8BaJnRYC2xhRMrPhTtJBIxv6A1YKEZ5e43
         EJ2hfvLucsUoEa6/+fBM6PR4dmQH1e/7/zj1+oYgYvK3FYoC9fOfxrSRNmCM8f0h3gBf
         rRFD9yNwMyovBRUcXhO+WEDMYomhJ/+suNbjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929044; x=1760533844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzwdPAuM8Rz/Bvizjj7IemyxtXu6fMaEk02nQJZstYQ=;
        b=dzM+E+jB2d5aEzFvX9GWKhOWJklYG4oxuB8QSqnj5ZK6pf9o6pnmezYAeOWCp6sK5P
         3+UbLdlea3PVq6QguObTWZ+ULJUCii82lBfet0MOaMWY0ZQo3MVx286ImXHk0+E6QVgg
         1HHFDWGOsgvnhJDiZVbLaRfsDCZ45fdvXz+0DIBAvCVO9ixXYl4Iq8W1J0LX704XD/XU
         NjLwUMZfFeF2I3InFd40AvCdsr+w+UfWDhSADRqXtFtCP2MY8hWe89q74In35WSRsEPo
         lfzWRknHsY7RG55SDZXTPMYVMH4qoVHYGRmCZwZEEPLOY05T0nHGPT5MnUbyuoxZQRen
         VNTw==
X-Forwarded-Encrypted: i=1; AJvYcCUJz+GdV6+nGu7Hrum5wDTnWwV2B/UD1YFXpINxERx9S00RuTnsvdsYd5GUXIH9yZ7LIVyp00C2Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk7ef9sYuf40sd0hmLk5p+0UK+9vDMqO0QojH/ToIkQzkiLY9
	kO8vRqkUwXQyaKeAyj+X1ZKxmSiWC/WuF9Bf1rqdkBSZ9oeeHwgjFddLvBqkqRRTfw==
X-Gm-Gg: ASbGncsqAEmg9OP6fQ2/P5j48WfzBDYJePOx9qCeKdpN7cpXOnqQegekhJbe1CjWulp
	PgltZ/ybfCeuhrIfgYqNKrR9/f6LCDuEcc+oVi6O5bhZ8ho7TXdck5LAqsg7vaEXIt0WNqafdfV
	2k6+/TSHzKatCCbL4Wt//JHuFIJOgXTXa8ZN6hWJlqhLrtYCYHXTX+fi+otdHunDvbXEWSzk6vD
	rhTpnysJu17hcn1pF4DSbc1UTkbPzI+wYDxAz0zCPiWdSSr4S2vyakwlZIiCAIevhORkD2RFgtX
	oWvRIB8zp6TEVFAmTh9B1/7ksvGsaKLTvsatguuugkOJS2NZA724UthRFbF1KoKe9EPo8WIQczj
	ieW1peEDIA4T1YaSTXa3zIwGoPW1lIeCRY061fEHSXReEjA0xmQ==
X-Google-Smtp-Source: AGHT+IETXMqAb55o9uu6gXXXJpn8n0BcOETXjMMNThpqVg0lzq6C+Cs9NvKO6yDPfW+DQ/3AHfGB2g==
X-Received: by 2002:aa7:8291:0:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7922fab2513mr7191654b3a.1.1759929044216;
        Wed, 08 Oct 2025 06:10:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:465a:c20b:6935:23d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dae7sm18883416b3a.9.2025.10.08.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:10:43 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:10:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Pavel Machek <pavel@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
Message-ID: <rbap3e2chlgx7zn2uw5fntjfjoqlfdebsautmiaq4oz7y2ecnx@ejmbrvrtbpju>
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
 <20251008101408.dj46r66gcfo26sgl@lcpd911>
 <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
 <20251008130234.mw6k4k7fupxma2t5@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008130234.mw6k4k7fupxma2t5@lcpd911>

On (25/10/08 18:32), Dhruva Gole wrote:
> What I meant really was to consider another path instead of a mod param,
> something like a /sys/kernel/

Modules' params are exposed to sysfs and are writeable.

