Return-Path: <linux-pm+bounces-15301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D89942A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 10:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FD5B21312
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9165D1DCB3F;
	Tue,  8 Oct 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jiWqMnzR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604713AA4E
	for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375634; cv=none; b=ajY2Axvp722IPJyAO77Vvhy1GqG4q4JkqIgLpl4ZZpHNh/tq+Hdco9mew4TdeIzsWiR9eEADbPYSLeyxSZak/RqfRJTig/RNy38qqyXdIAm0hNOUj13KsUZRFdCCwfX0v2as5MwznmTRCXjk6e5bw80WgC6W8aGCriwDqLv+aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375634; c=relaxed/simple;
	bh=SA7p1pK7GJRdZ2aSXfBMJYpiT/f4erZ1sHELDMvQa1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpFhGwNEi8cufmlZIBmzIYXrzCpWAOYCSUx5Cu1QJopCE/Bkvk/SIHWVj+7kuQknIt1Cdn7sa0yYq+scN86o4F4PH+QV0ywH19vjAXnvdPOXAv8N93V5JdXcvBfJc44K/1IZ73l6GiL4LsnJwDAWhRBkXYGjf4F2M6lqjgPB0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jiWqMnzR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so55239465e9.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2024 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728375630; x=1728980430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLA7sL4jTUFGJMFkMOPtXgp1AzpZdyeuaRidXBBLnMU=;
        b=jiWqMnzRn8Y9zK5G5EK7k9+mVH35CHwV9h5jIfITQDrJ1ZNsG2yWlJPv0dYWBjvvaW
         3SizMgrQrC6bnv15r48HS4Nd7nOdLhB9oWK22uhcUSAW/i56EBgtltpUUXtKObNzkZLL
         UgfU6Ao3RqFQIyKY52X0W3kaL5lcc8GUkdR9bFtPewSotm2PwSbhJ+8CIV+HFP6qJdAW
         Z9mdOT+HWgzFszhE5J3Tgl9FAUSA6Tk+t42dMM/2IqZ7l1aIAgVWkUkYEvpP2ewMowVT
         f2njWlb2IG4YiGREMrkLh+4VNtmvD20ZZEM/5/FZTnS2XULMEdbbkvfpLORCvPauOrCF
         BANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375630; x=1728980430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLA7sL4jTUFGJMFkMOPtXgp1AzpZdyeuaRidXBBLnMU=;
        b=gUGDQpuhwpu4zn6gOFL0HhtXMmjU7b86FAetZjFEbGdflbTxEI3UXm0kkj1LrJaVVx
         0cgnSTX0xy0Aw9yJdR5d0ZGmhtBAzlnly4XEZz4FPaZZdakTplha23lhr2OVbqD2DVHZ
         GEBHLxstENop3ES+2k44nkwcIxAIxJIv6LG+swS2WrLlZsXx+YhRwvW/83RLSd/d82+l
         IwvK4PbYdEyReZwSEtnI6hR7S1q0Aw5m/qSKMkagHFAzi6WAeZ2360x6hNLAJque5Lpw
         mvgRSATCITSE25P8wNUW26YKhLmnYD1/v0UeSyIOAjJWtuHF+H6tfYjaGktCW5gp3rWv
         wQ5w==
X-Gm-Message-State: AOJu0Yyq7xmWFLUoDU/2UkxiMW71H58tzolbstv46KJ23+FpM5Rr3IVp
	Ih9itkcAXWtsIeigEworOJtXCVUeHqzuvft+GWzWXImQpoJvyCMOk+MyYILIDmm/HysOmIVGzgR
	z
X-Google-Smtp-Source: AGHT+IGy6e2hyfBM6ucgCV6S78O4kJP6vjQ+Tn8p8Qf2UI4J3EG8HRiCChmfiVkttgsGMH7vG0IS2Q==
X-Received: by 2002:a05:600c:35c9:b0:42c:cd88:d0f4 with SMTP id 5b1f17b1804b1-42f85ae8efbmr117465365e9.22.1728375630285;
        Tue, 08 Oct 2024 01:20:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:738a:20da:f541:94ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697024fsm7467370f8f.95.2024.10.08.01.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:20:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] power: sequencing: make the QCom PMU pwrseq driver depend on CONFIG_OF
Date: Tue,  8 Oct 2024 10:20:28 +0200
Message-ID: <172837562698.35030.232807683263443584.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004130449.51725-1-brgl@bgdev.pl>
References: <20241004130449.51725-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 04 Oct 2024 15:04:49 +0200, Bartosz Golaszewski wrote:
> This driver uses various OF-specific functions and depends on phandle
> parsing. There's no reason to make it available to non-OF systems so add
> a relevant dependency switch to its Kconfig entry.
> 
> 

Applied, thanks!

[1/1] power: sequencing: make the QCom PMU pwrseq driver depend on CONFIG_OF
      commit: a85bbe01a320eb3f1398da3430384596b1c51663

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

