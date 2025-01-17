Return-Path: <linux-pm+bounces-20593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43429A14881
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 04:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E221889363
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 03:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272941F5610;
	Fri, 17 Jan 2025 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBq8n7Zt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A225A643
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084947; cv=none; b=j82MEWSTaHYMagLolMex1evu7d8GILltzjswyzjMS4hOPOPnkQxPy+peDmNmzM6UlNOb0kkXCAHZXvUToXZakKIHDe3IcpdPpVNly1KO77s+uyHXaIT9uQvxty2BrkRn1hRwHjuVM9SA+6XPp6wWI1hHgduKfnKqfbxLj7iPwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084947; c=relaxed/simple;
	bh=NbSxWnZyu8RyFNkzI/hOemUAH4hDNgeb1XTakz637p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtF7L7b64ZvhvHUEI+0ldkfh50Hwv2NFwbxo71LavplvHArKrQLWLnatW/PwZu/Ibaz8ROMPfQBzc+w9hY56czIGWKQWSNcX7QQT4juoEfzkRoDm0mUMxZ5L3/XdVCUxFE9lTUZvnbLOKVpgemliWE1G/2kwHohoCOob0EN8a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBq8n7Zt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166f1e589cso40309275ad.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 19:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737084944; x=1737689744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCiz+sabDeeau8SEKk5GsN1jfadMcq+hi9aKPPfDvcI=;
        b=XBq8n7Zt7yKfKtP/dp6cKhwKuy8BWdbwJr65EwzKYQGMafQ9Or39yvqXCVCXiwuM3P
         amS6ntHmw/zDSzQtFJ5meV14hex2jHIFIuTaiO1hIwWRtn1QXAOOpQ3Cx6WoaBonKEF+
         sw5aNNaEUs96kvNEt5TW/SvptLGhHQYbyEbiv5Zf6xQvRW23TdGT7gAWqBuNq7ALDddu
         UcVkNfB+UY2DpmR6VHbE7cdLcuwqjWjtoIMU+tfyMz6O3qFOfOG8/EnGgJIDoiDFBoQI
         s5gLleMwErnFVskfOBj9yB4wXrUQki6mpS300J4i0MTffKp+45+C/xtfXV3dmG/LwgtE
         lrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737084944; x=1737689744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCiz+sabDeeau8SEKk5GsN1jfadMcq+hi9aKPPfDvcI=;
        b=ZRkheWmIBOWxVHQ9OHpYZoG1YvvSW9yqPoe6CGiAvISgzursDyJTu4KTrPlipdOYGL
         LS8v105PivPGguUik98/gY/wQ0kdfF0Ad1vDNQNPj+wPw/8Kae7C9N4q1xzpBsgM70JG
         AvwjwBePOQOiP72vgGlJ2Gcotgev5NOV9xAbJEy6BRYMHwB4HuT5tLh3/o1WaAqAqE3x
         JuAhef+qe4Yz9dxaTNXidZT6hCO/vZE0L3tbGSDtxhriGUuIzaHEmgnIfFT8DKxSw9IG
         EAbqwGlbWkP6ukAwUzoikU+Z/+Te4D+GXJfOVTtxUqsAtbzltUThtnxcvzKH2ldsrl/b
         simw==
X-Forwarded-Encrypted: i=1; AJvYcCXfozu5VHJNR589CDdkyLJQL/Mg/zaHnhQWkfltHtlf++0MduMNrG/ysW0jxPmkRt/JllZUgGHnkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT13W82iUSLJo6QJM+P9ivuHmQ8wRFNGHPy8bpFw6X1pSaM1Q1
	Eoe5nVL+o6oAz14JE5mDIdU4h0r6LrOjTivikxZJ/rc/jX0OUiCvedfdh01a7+8=
X-Gm-Gg: ASbGncspO2WPBLZ+RV0VJ5dwoaFpHk2BTilaLYgVG2econ9C49Xh3zFoA6/0nIZ7YkA
	WGvjZWxcq5qsbSYUM/JWKrFBCnRI+yNSqXqAt2qJC4E9/1a6n9GtF9+TEaNVV9j4T1uef3q6u+F
	4vTPCuNwJq3mP1k2dJxepskyM0EcDpVatHEuGSQ8VgsOPWZbk0WJ5EGlQZw8ZqFi5d9PXOHgmsR
	HZWZQVepY0N973tHPDIKfoO1z1LT64kDxKGGnGqrEbNCxIYb9+JmcjQtFw=
X-Google-Smtp-Source: AGHT+IF5Ygdj23ZD7GuKZPa9QsTHhprHgm42ulCzwj5UoaKE1u+8zqF+SlF34qHYFtOsB+w9cQjK2Q==
X-Received: by 2002:a17:902:ea05:b0:216:3d72:1712 with SMTP id d9443c01a7336-21c3579359cmr18630745ad.48.1737084943861;
        Thu, 16 Jan 2025 19:35:43 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea1fe9sm7100525ad.2.2025.01.16.19.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 19:35:43 -0800 (PST)
Date: Fri, 17 Jan 2025 09:05:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v10 1/2] pmdomain: airoha: Add Airoha CPU PM Domain
 support
Message-ID: <20250117033538.pnh52c7qd2bb7h2z@vireshk-i7>
References: <20250109131313.32317-1-ansuelsmth@gmail.com>
 <20250116070214.vdnbyyqnciifngha@vireshk-i7>
 <CAPDyKFr_z3WUyO2bTV7fPt8=ECdoHCERd=f5UN8MmNpyN=Rm_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr_z3WUyO2bTV7fPt8=ECdoHCERd=f5UN8MmNpyN=Rm_A@mail.gmail.com>

On 16-01-25, 16:58, Ulf Hansson wrote:
> On Thu, 16 Jan 2025 at 08:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Ulf,
> >
> > On 09-01-25, 14:12, Christian Marangi wrote:
> > > Add Airoha CPU PM Domain support to control frequency and power of CPU
> > > present on Airoha EN7581 SoC.
> > >
> > > Frequency and power can be controlled with the use of the SMC command by
> > > passing the performance state. The driver also expose a read-only clock
> > > that expose the current CPU frequency with SMC command.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > Changes v10:
> > > - Depends on HAVE_ARM_SMCCC
> > > Changes v9:
> > > - Fix compile error targetting wrong branch (remove_new change)
> > > Changes v8:
> > > - Add this patch
> > > - Use SMC invoke instead of 1.2
> >
> > Any inputs on this ?
> 
> Apologize for the delay! This looks good to me! So, applied for next
> to my pmdomain tree, thanks!
> 
> I assume Viresh will take the cpufreq patch via his tree? Please let
> me know if you prefer another route.

Applied 2/2. Thanks.

-- 
viresh

