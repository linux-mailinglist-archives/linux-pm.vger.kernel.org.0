Return-Path: <linux-pm+bounces-27817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F889AC8133
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 18:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C761BC0F84
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A43E22D78F;
	Thu, 29 May 2025 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWAWlH1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF678F34;
	Thu, 29 May 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537533; cv=none; b=u/Fjk0Ga+IQzsw57fzNeQAFAGRCI3slvB9zdjciYbYXdgLMbPclrEhbRRiy8h0Y60S6XyVnAT82wxiX1l95u5cQwKGpupi2v2yu64O8uvxkL7YMxYZNtzZYrKn+s4nai4s/caDVqzFB5TxzG8q96a23JEU11TxfsKyuGAszbvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537533; c=relaxed/simple;
	bh=VHtqptbeURxA2oe07XMZKXucJY1J02Li9OYw/uFS5Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+2usYPUROPUICTcuR8+BPBdJxp3XSIGlV+YuzZDr9h2ajO+SbI6GFoeshI+su/jdYRo+zVPKXN9qcNLFt9LJih6ZOgPxzNrZk5mAdRx7o64fYSewXinBmXjfLVXCWHpUXH4RGtXZ4McthxBNW8RpSstAM+mpK877CWTH9FdZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWAWlH1o; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4c4e6a0ccso718545f8f.3;
        Thu, 29 May 2025 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748537530; x=1749142330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VHtqptbeURxA2oe07XMZKXucJY1J02Li9OYw/uFS5Pk=;
        b=aWAWlH1oynmMdp9f+W0A5qDEHYcJAV2kZ+8nDZlQQi0E7BRk0f4pHATQfyHSIxQDT7
         iY2EZh2hz+S+bR8T5mCLNtT0qQxcXoNTGD8q/eoctHuulyIpYadJNos/FoqYwEDlSsLr
         cT/A9fyFEBeA3FWOJFwFhqmG66IN7nZaVWqZqdUv2ON9eWQYQg1J+NEbg4/bXuy0KIVV
         iXsDdbvqaxC5uT/fM5+fYSEDzy/RoiMaAZXOFY9VwUkrI0RLkB8web/iq2j0VqjNZPPR
         HygR2q/zdGJN+xlGri3DOcbGpUIGMvYOGPY0qFUmwk+31fv3Uk2iztK7hevIlGQWoLNW
         bxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537530; x=1749142330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHtqptbeURxA2oe07XMZKXucJY1J02Li9OYw/uFS5Pk=;
        b=tstR5IV/5S7bW5ABQzsaS1iKwxGH0aHUIHA1kjahWZpzyscX4bS3VbrMwFTm8cRmHE
         1Viwp1+bMspXW81X82eeLIR2mckt9rEABhrFi8UoI+i+XpfrNFPMsG8nHsD0PU+foSAb
         TgRGyf+LiMHA5YJf1wUQ0Ae/VWD8a5sHuHwP960FpjbBKSFdF7wLbgtVlc6HfXmKY+Yr
         B7emsRvC3PyVw7iYgERAEF31eSG7JtlPavLluOms1wPe3AWCXXubxBfvZx5xwTbmPaou
         gMAkD4oX0ZLPUGtYdsjrsn2akqjHSO/XvB51r6VtdnBZon47YqbWUz2UgfIphLwYV7Sq
         KxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdo9IapOPqPFqF3yYVuDAt00fVAAxwbdTI8tYKPy32xLmm5wHEb9C1D2Yc42I6Zr59It1Z5GN6v453cY8=@vger.kernel.org, AJvYcCUivLvnuZZCrs/mUEHaFutIKkW8nCqyj7L6JaTTAg7y8cdeayL5vPIE01izi8szyMo2GgOBOMms0rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMRRVP2+dJCnUnAUnKq14KTMU6M88h94H4FPhoSt+6FFo3/T/
	uWB6/18FE/HbPdX7Gw5Vh3MCA//bs3cx9mjKgcURuMOH1FkcfElVUy8OIWSilIXmdSpI+pFgaBE
	NSJwu/sofIltLjFHPB2Eet+EEK9iWMCg=
X-Gm-Gg: ASbGnctR8y9RCTrwLS/HuxopN8uK3H+EEWFZcI1DdYnR8MxhnM8DZQowpRPVobx+VN8
	BGqy4PKBXZM5jRIK6/sNi3BcqjYeBaV+Zf4OtPfwb8xuhqYpnGVP2p6m+hY4K2pEU0LL/Mwqh9P
	hWNEhfbr+lf80x4zn5X9Yvb84VHSnmBuA=
X-Google-Smtp-Source: AGHT+IHiOYVli2u3+XWq32ywtCO1v9x9p1LGinmmvM/+QYOusYp9n19EYKiYmFiV4BKOQkxdgTXw3k4JAwyiiPbm2rY=
X-Received: by 2002:a05:6000:1a8f:b0:3a4:eec5:441c with SMTP id
 ffacd0b85a97d-3a4eec544femr3512442f8f.47.1748537529863; Thu, 29 May 2025
 09:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529085143.709-1-gautham.shenoy@amd.com> <CAJZ5v0h27Re4UwoyCrauNfQupojpfwKSOzSppC9mwR-ATWD3Vg@mail.gmail.com>
 <CAArYzrKT2zMBL54i6AKj1kEASLA3D8W4-d191cuqADaC6NGbjw@mail.gmail.com> <d3926d39-5981-4528-a505-ca478eb3de36@amd.com>
In-Reply-To: <d3926d39-5981-4528-a505-ca478eb3de36@amd.com>
From: Manu Bretelle <chantr4@gmail.com>
Date: Thu, 29 May 2025 09:51:57 -0700
X-Gm-Features: AX0GCFuu2xjBtxrStVFovQqCLRu32jM_H1ILfNSRjmy3kLlULEi5MPPmNiQOLiU
Message-ID: <CAArYzr+-Owj2TPax-kFK6wi1bij+58OOLJR5T2uLY6gRHJn8Cg@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Here is the policy for stable:
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>
> It doesn't explicitly contain a stable tag, but because it has a fixes
> tag it's very likely that it gets backported by AUTOSEL later.
>
>
Thanks Mario!

