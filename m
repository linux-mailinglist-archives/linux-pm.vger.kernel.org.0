Return-Path: <linux-pm+bounces-29818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00462AED54D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BAE3B79E3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CB220F2A;
	Mon, 30 Jun 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0Ps+zKju"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB621FF4B
	for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267493; cv=none; b=RR+gtLvItVgQ8o1mCo1qiwlFE8qg2E0JdcQjf2GF46+N+dMo41H4dQ8rOOGIaaHp2wjcXgyK1X8VSQIp4U2OgyloJ6d8EULFYHo595gGI8ACxZZ6SDu9JfcCvyHE4ZorrG8Ia67KztP0j6joRs+yldtP/Fykcx/4sRCq/w9fgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267493; c=relaxed/simple;
	bh=C4Is2PRDyW5OGXhFVFFPlnsp8t5bvWnOqRzuog7GfQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxK/RKuHbxjLGqgVq2YpMC0nhYIQHe+lNwANl4o+JNcg+KDpXfqGI08Y0MS95rJawtFtDLcOwbxEVHtvNcSzLmPIfF14KI6eUEs2hP6N/pJ9kT6xsQ/Lp9bIvL1OkRlx//GztKwKujnYtvTqwqFBU1TN6Dbk+bkQJJlOG2hZlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0Ps+zKju; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4539cd7990cso3993705e9.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751267490; x=1751872290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAU+1CHc/4Ul9Vcx4dBNSBGytQwqpjVcfS5iUgGEe+o=;
        b=0Ps+zKjuO0HazfDCqTTEoTzMTk11geVPVQwj5bSKtu91kmZqTyt0Z9t9plJ+lGDYhg
         8RkbcXRO6L0FW8StFJJ2qsLsCJsNeQsUx6HVIaM8u31fxN0F7eLSN2Gfus8XHstdPScI
         jOax3s7Uz1g+uo8PuSHzn4M7oOtDAalV1X4S6CNhQkI9yjhS+cQpo9iKwoiBgZFdfJM9
         hp7TYPZVsh7thvtxbTNyj9X4QWdGaqObkybZlsuArt7Z4atMu2+9MIytIKV/Zc7VHXGG
         bAeP/7nqKIGIbpPKlJRKTcFY1shFTQWaoJ4jG2uWur3NoQGp7ykG+1+bEGfa9yuVbEnE
         H7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751267490; x=1751872290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAU+1CHc/4Ul9Vcx4dBNSBGytQwqpjVcfS5iUgGEe+o=;
        b=eKtKA3VGxB6AfS8OKZozfPirSd3yojN7lID/bxIFOnWZwQBilBEAdB917JmO7tT7Lp
         AbfeHRYb/1EkF5Aglq7aaBZJ9UBXE1zyi8KLMJRvwzD2C5rlXf2Kjpog2PFGfeEj/rCp
         FjnUzNBBsgABNNdDXJBvZcZBFKPUojXHMArTAlWVSdgenkJz6LrnlaQE3zbzTSDiuc2X
         76Kyy47/01lHrDY5WrpwhXjQgAWoCR5JFr1MiUIFAQnfmboTmbs5iUrHkEbSKK9xx1Xe
         mpoLdP1mxcvcIcW/Nc1YN1BV7eqximPAGgxRvitFMa7mdwO5+f8IMhOGbIUKboIZ/ZDg
         mqDg==
X-Forwarded-Encrypted: i=1; AJvYcCUD7Q14UB9v+KP9RnDMpLKR8YKa2uhTPHtqmqoXk8CoEXp2IToj4eFjvF367lt+dS7BTN+p1iezBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hcKLSuzSXhfpMqgs4pvqe8b86aLs6Dm2kqJpY7V9s/K4Z609
	wyLHYioAqAtXdn5IfLvCL2XrwwxJ5ooCzF3GWLwQoFiF9lmX5cHTtt8z6+56oYFcekM=
X-Gm-Gg: ASbGncsAXYkeGYb+cz6Y3YFpkF66my9KyvKNKNeCXA7EmPbhDJs1BboPvvraVuzgD72
	4dVnQBSFiDIik43JEp7LfZl1djkqVmEMdN6gOuZCrtcZkVJk+LVfjoJzLVIPtpkZev/JeIC9ScG
	4PIPJKh1YwbIgmqa2BAdLDRbgnWMYziF+lfW6uUKjI8N7hNdg2qZq96MXeWOWU933aKOKsQjAsJ
	EevHXcYHnXROKAPI73Q2EtFChuiMiEGxXRZLCrOl+YkOvuDD38cukUMoQaw80hSU6NmY7pWkovC
	A9eQKObt80D8KXL1wg78lJ9Dy7KAy0rEZPDWBOlak+NWNBugMxPng9z3PrJojp06gcQ5uWBI7Q=
	=
X-Google-Smtp-Source: AGHT+IF/Hi1wIyroMRKaNdh6oJcOjs8dpo4x25ryjFzMBcwdM76uEkmSwa+7+twwlJwv++sUrr296g==
X-Received: by 2002:a05:600c:5306:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4538f308f2amr111748215e9.13.1751267487709;
        Mon, 30 Jun 2025 00:11:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:19e3:6e9c:f7cd:ff6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm155857865e9.20.2025.06.30.00.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:11:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: Fix bluetooth-wifi copypasta for WCN6855
Date: Mon, 30 Jun 2025 09:11:26 +0200
Message-ID: <175126743945.9502.10865323973277778420.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250625-topic-wcn6855_pwrseq-v1-1-cfb96d599ff8@oss.qualcomm.com>
References: <20250625-topic-wcn6855_pwrseq-v1-1-cfb96d599ff8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 25 Jun 2025 17:55:43 +0200, Konrad Dybcio wrote:
> Prevent a name conflict (which is surprisingly not caught by the
> framework).
> 
> 

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: Fix bluetooth-wifi copypasta for WCN6855
      https://git.kernel.org/brgl/linux/c/07d59dec6795428983a840de85aa02febaf7e01b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

